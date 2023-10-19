# Dockerfile
FROM golang:1.16-alpine as builder
WORKDIR /app

COPY go.mod go.mod
COPY go.sum go.sum
ENV GOPROXY=https://goproxy.io
RUN go mod download

COPY main.go .
RUN go build -o kubevela-gitops-demo main.go

FROM alpine:3.10
WORKDIR /app
COPY --from=builder /app/kubevela-gitops-demo /app/kubevela-gitops-demo
ENTRYPOINT ./kubevela-gitops-demo
EXPOSE 8088