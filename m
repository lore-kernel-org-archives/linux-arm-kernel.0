From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:41 -0700
Subject: [PATCH net-next 17/40] net: fec: move restart test for efficiency
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-18-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves 1 comparison.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1a838cc..fcbbf0d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1154,8 +1154,13 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_private *fep,
 		/* Order the load of bd.cur and cbd_sc */
 		rmb();
 		status = READ_ONCE(bdp->cbd_sc);
-		if (status & BD_ENET_TX_READY)
+		if (status & BD_ENET_TX_READY) {
+			if (!readl(txq->bd.reg_desc_active)) {
+				/* ERR006358 has hit, restart tx */
+				writel(0, txq->bd.reg_desc_active);
+			}
 			break;
+		}
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 
@@ -1225,11 +1230,6 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_private *fep,
 				netif_tx_wake_queue(nq);
 		}
 	}
-
-	/* ERR006538: Keep the transmitter going */
-	if (bdp != txq->bd.cur &&
-	    readl(txq->bd.reg_desc_active) == 0)
-		writel(0, txq->bd.reg_desc_active);
 }
 
 static int
-- 
2.5.0
