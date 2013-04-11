From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 11 Apr 2013 14:40:23 +0200
Subject: [PATCH] net: mv643xx_eth: Add GRO support
Message-ID: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds GRO support to mv643xx_eth by making it invoke
napi_gro_receive instead of netif_receive_skb.

Signed-off-by: Soeren Moch <smoch@web.de>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Dale Farnsworth <dale@farnsworth.org>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 305038f..c850d04 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -604,7 +604,7 @@ static int rxq_process(struct rx_queue *rxq, int budget)
 			lro_receive_skb(&rxq->lro_mgr, skb, (void *)cmd_sts);
 			lro_flush_needed = 1;
 		} else
-			netif_receive_skb(skb);
+			napi_gro_receive(&mp->napi, skb);
 
 		continue;
 
-- 
1.7.10.4
