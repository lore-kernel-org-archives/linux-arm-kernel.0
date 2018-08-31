From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 31 Aug 2018 16:09:13 +0800
Subject: [PATCH net-next v2 1/3] net: mvneta: Don't check NETIF_F_GRO ourself
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
Message-ID: <20180831160913.325ee36b@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

napi_gro_receive() checks NETIF_F_GRO bit as well, if the bit is not
set, we will go through GRO_NORMAL in napi_skb_finish(), so fall back
to netif_receive_skb_internal(), so we don't need to check NETIF_F_GRO
ourself.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bc80a678abc3..814aee92a1d3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2065,10 +2065,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		/* Linux processing */
 		rxq->skb->protocol = eth_type_trans(rxq->skb, dev);
 
-		if (dev->features & NETIF_F_GRO)
-			napi_gro_receive(napi, rxq->skb);
-		else
-			netif_receive_skb(rxq->skb);
+		napi_gro_receive(napi, rxq->skb);
 
 		/* clean uncomplete skb pointer in queue */
 		rxq->skb = NULL;
-- 
2.18.0
