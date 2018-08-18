FROM ubuntu:16.04
MAINTAINER ulordhub <https://ulordhub.com>

RUN apt-get update
RUN apt install -y curl wget git
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt install -y nodejs
RUN apt install -y python make gcc g++ libzmq3-dev build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
RUN apt install -y software-properties-common && add-apt-repository ppa:bitcoin/bitcoin
RUN apt update && apt install -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev

COPY uchain-explorer /uchain-explorer
COPY data/ulord.conf /root/.ulordcore/ulord.conf
RUN cd /uchain-explorer && npm install && \
    cd /uchain-explorer/node_modules/bitcore-node-ulord && npm update && \
    cd /uchain-explorer/node_modules/bitcore-lib-ulord && npm update
RUN cd /uchain-explorer/node_modules/bitcore-node-ulord/bin && \
    wget https://github.com/UlordChain/UlordChain/releases/download/Version-1-0-0/ulordchain_ubuntu_v_1_0_0.tar.gz && tar xvf ulordchain_ubuntu_v_1_0_0.tar.gz

ADD entrypoint /
CMD ["/entrypoint"]
