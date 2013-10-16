From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:46 +0530
Subject: [PATCH 28/28] net: use DMA_COMPLETE for dma completion status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-29-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: "David S. Miller" <davem@davemloft.net>
---
David pls ack this as it has dependency on my tree

 net/ipv4/tcp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6e5617b..d2652fb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1429,7 +1429,7 @@ static void tcp_service_net_dma(struct sock *sk, bool wait)
 	do {
 		if (dma_async_is_tx_complete(tp->ucopy.dma_chan,
 					      last_issued, &done,
-					      &used) == DMA_SUCCESS) {
+					      &used) == DMA_COMPLETE) {
 			/* Safe to free early-copied skbs now */
 			__skb_queue_purge(&sk->sk_async_wait_queue);
 			break;
@@ -1437,7 +1437,7 @@ static void tcp_service_net_dma(struct sock *sk, bool wait)
 			struct sk_buff *skb;
 			while ((skb = skb_peek(&sk->sk_async_wait_queue)) &&
 			       (dma_async_is_complete(skb->dma_cookie, done,
-						      used) == DMA_SUCCESS)) {
+						      used) == DMA_COMPLETE)) {
 				__skb_dequeue(&sk->sk_async_wait_queue);
 				kfree_skb(skb);
 			}
-- 
1.7.0.4
