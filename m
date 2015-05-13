From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 13 May 2015 14:04:53 -0700
Subject: regression with today's linux-next
In-Reply-To: <20150513182738.GA28201@saruman.tx.rr.com>
References: <20150513182738.GA28201@saruman.tx.rr.com>
Message-ID: <1431551093.27831.5.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-13 at 13:27 -0500, Felipe Balbi wrote:
> Hi Alexander,
> 
> your commit 9451980a6646 (net: Use cached copy of pfmemalloc to avoid
> accessing page) regresses most OMAP-based boards with a NULL pointer
> dereference.
> 
> Below you can find git bisect log and a serial console capture of the
> problem.

Are you using jumbo frames ?

Please try :

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d67e612bf0ef..701318378142 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -414,9 +414,14 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	len += NET_SKB_PAD;
 
 	if ((len > SKB_WITH_OVERHEAD(PAGE_SIZE)) ||
-	    (gfp_mask & (__GFP_WAIT | GFP_DMA)))
-		return __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
-
+	    (gfp_mask & (__GFP_WAIT | GFP_DMA))) {
+		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
+		if (skb) {
+			skb_reserve(skb, NET_SKB_PAD);
+			skb->dev = dev;
+		}
+		return skb;
+	}
 	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	len = SKB_DATA_ALIGN(len);
 
