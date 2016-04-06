From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:25:56 -0700
Subject: [PATCH net-next V3 10/16] net: fec: move restart test for efficiency
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-11-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move restart test to earlier in fec_txq() which saves one comparison.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: change commit message
---
 drivers/net/ethernet/freescale/fec_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 349fda1..a2a9dca 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1157,8 +1157,13 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_priv_tx_q *txq)
 		/* Order the load of bd.cur and cbd_sc */
 		rmb();
 		status = fec16_to_cpu(READ_ONCE(bdp->cbd_sc));
-		if (status & BD_ENET_TX_READY)
+		if (status & BD_ENET_TX_READY) {
+			if (!readl(txq->bd.reg_desc_active)) {
+				/* ERR006358 has hit, restart tx */
+				writel(0, txq->bd.reg_desc_active);
+			}
 			break;
+		}
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 
@@ -1230,11 +1235,6 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_priv_tx_q *txq)
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
