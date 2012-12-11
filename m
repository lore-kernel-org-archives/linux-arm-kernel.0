From: erdnetdev@gmail.com (Eric Dumazet)
Date: Tue, 11 Dec 2012 10:54:56 -0800
Subject: [PATCH v2 1/1] net: ethernet: davinci_cpdma: Add boundary for
 rx and tx descriptors
In-Reply-To: <20121211.133426.484976995112519196.davem@davemloft.net>
References: <1355197433-7492-1-git-send-email-mugunthanvnm@ti.com>
 <20121211.133058.2238010228178961245.davem@davemloft.net>
 <20121211.133426.484976995112519196.davem@davemloft.net>
Message-ID: <1355252096.27891.130.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-11 at 13:34 -0500, David Miller wrote:

> 
> You can't signal "out of descriptors" and stop the queue after the
> fact.  NETDEV_TX_BUSY is for handling exceptional and extraordinary
> conditions, not for the normal queue full handling.

This reminds me an idea I had about MQ/MQPRIO qdisc and BQL interaction

(BQL btw makes less probable a NETDEV_TX_BUSY event or
__QUEUE_STATE_DRV_XOFF state, but more probable a
__QUEUE_STATE_STACK_XOFF)

We dequeue a packet from qdisc, then we realize tx queue is in XOFF
state, and we have to hold the skb into gso_skb for later.

This shows in stats (tc -s qdisc dev eth0) as requeues.

Problem of these requeues is that high priority packets can not be
dequeued as long as this (possibly low prio and big TSO packet) is not
removed from gso_skb.

At 1Gbps speed, a full size TSO packet is 500 us of extra latency.

Suggested fix : add a TCQ_F_MQSLAVE flag to allow dequeue_skb() to test
the netif_xmit_frozen_or_stopped() status _before_ dequeing packet from
qdisc.

(For other qdiscs, we dont really know which tx queue will use the next
packet before dequeueing it)
