From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:40 -0700
Subject: [PATCH net-next 16/40] net: fec: eliminate calls to
 fec_enet_get_prevdesc
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-17-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This shrinks the code a little.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 34 ++++++++-----------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9285425..1a838cc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -758,6 +758,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 	struct bufdesc *bdp;
 	unsigned int i;
 	unsigned int q;
+	unsigned status;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		/* Initialize the receive buffer descriptors. */
@@ -765,19 +766,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 		bdp = rxq->bd.base;
 
 		for (i = 0; i < rxq->bd.ring_size; i++) {
-
 			/* Initialize the BD for every fragment in the page. */
-			if (bdp->cbd_bufaddr)
-				bdp->cbd_sc = BD_ENET_RX_EMPTY;
-			else
-				bdp->cbd_sc = 0;
+			status = bdp->cbd_bufaddr ? BD_ENET_RX_EMPTY : 0;
+			if (bdp == rxq->bd.last)
+				status |= BD_SC_WRAP;
+			bdp->cbd_sc = status;
 			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 		}
-
-		/* Set the last buffer to wrap */
-		bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-		bdp->cbd_sc |= BD_SC_WRAP;
-
 		rxq->bd.cur = rxq->bd.base;
 	}
 
@@ -789,18 +784,15 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
 			/* Initialize the BD for every fragment in the page. */
-			bdp->cbd_sc = 0;
 			if (txq->tx_skbuff[i]) {
 				dev_kfree_skb_any(txq->tx_skbuff[i]);
 				txq->tx_skbuff[i] = NULL;
 			}
 			bdp->cbd_bufaddr = 0;
+			bdp->cbd_sc = (bdp == txq->bd.last) ? BD_SC_WRAP : 0;
 			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		}
-
-		/* Set the last buffer to wrap */
 		bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-		bdp->cbd_sc |= BD_SC_WRAP;
 		txq->dirty_tx = bdp;
 	}
 }
@@ -2712,19 +2704,16 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 		}
 
 		rxq->rx_skbuff[i] = skb;
-		bdp->cbd_sc = BD_ENET_RX_EMPTY;
 
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
 			ebdp->cbd_esc = BD_ENET_RX_INT;
 		}
+		bdp->cbd_sc = BD_ENET_RX_EMPTY |
+				((bdp == rxq->bd.last) ? BD_SC_WRAP : 0);
 
 		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 	}
-
-	/* Set the last buffer to wrap. */
-	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-	bdp->cbd_sc |= BD_SC_WRAP;
 	return 0;
 
  err_alloc:
@@ -2747,21 +2736,16 @@ fec_enet_alloc_txq_buffers(struct net_device *ndev, unsigned int queue)
 		if (!txq->tx_bounce[i])
 			goto err_alloc;
 
-		bdp->cbd_sc = 0;
 		bdp->cbd_bufaddr = 0;
 
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
 			ebdp->cbd_esc = BD_ENET_TX_INT;
 		}
+		bdp->cbd_sc = (bdp == txq->bd.last) ? BD_SC_WRAP : 0;
 
 		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 	}
-
-	/* Set the last buffer to wrap. */
-	bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-	bdp->cbd_sc |= BD_SC_WRAP;
-
 	return 0;
 
  err_alloc:
-- 
2.5.0
