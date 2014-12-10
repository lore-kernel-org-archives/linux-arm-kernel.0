From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 10:35:20 +0100
Subject: [PATCH v8 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <5487EC09.8090907@huawei.com>
References: <1397869980-21187-1-git-send-email-zhangfei.gao@linaro.org>
 <5487C357.9030507@huawei.com> <5487EC09.8090907@huawei.com>
Message-ID: <2331317.LV3gPP3odb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 December 2014 14:45:29 Ding Tianhong wrote:
> 
> Miss this code, I think the best way is skb_orphan(skb), just like the cxgb3 drivers, some hardware
> didn't use the tx inq to free dmad Tx packages.

The problem with skb_orphan is that you are telling the network stack that
the packet is now out of its reach and it will no longer be able to take
queued packets into account. This can work as long as you are guaranteed
to never fill up the tx queue and assume that the network link is always
faster than your CPUs, but then you have to do additional steps, at least:

- turn off flow control (pause frames)
- disable half-duplex, 10mbit and 100mbit connections
- remove the byte queue limit code from the driver
- never call netif_stop_queue or return NETDEV_TX_BUSY from the tx
  function, but instead drop the oldest packets from the tx queue
  to make room, and rely on higher-level protocols (TCP) to throttle
  the output
- for best throughput, don't bother looking at the status of the tx
  queue until it has filled up, then clean up all transmitted packets
  (if any) but at least enough so you can continue sending a bit longer.

The above can work because you know the device is only used in one SoC
that has a relatively slow CPU. I would describe it as "we don't know
how much data we can send, but in doubt we send more and do our best
to make that case as rare as possible". It's also management friendly
because you can reach higher-than-gigabit transmit rates this way
if you ignore the packet loss ;-). The price for this is that you
eventually have to retransmit packets that get dropped.

The alternative to this is to keep all the features of the network
stack in place and to keep retrying the tx cleanup in some way so
you don't have to orphan or drop any skbs. This could be as easy as

- drop the skb_orphan() call
- make hip04_tx_reclaim() return an error if the queue is still full
- do not call napi_complete or turn on the rx irq if hip04_tx_reclaim
  failed

	Arnd
