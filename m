From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:46 -0700
Subject: [PATCH net-next 22/40] net: fec: call dma_unmap_single on mapped tx
 buffers at restart
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-23-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index bc084ad9..da2e3c530 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -403,6 +403,7 @@ dma_mapping_error:
 		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
 				bdp->cbd_datlen, DMA_TO_DEVICE);
+		bdp->cbd_bufaddr = 0;
 	}
 	return ERR_PTR(-ENOMEM);
 }
@@ -788,11 +789,18 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
 			/* Initialize the BD for every fragment in the page. */
+			if (bdp->cbd_bufaddr) {
+				if (!IS_TSO_HEADER(txq, bdp->cbd_bufaddr))
+					dma_unmap_single(&fep->pdev->dev,
+							 bdp->cbd_bufaddr,
+							 bdp->cbd_datlen,
+							 DMA_TO_DEVICE);
+				bdp->cbd_bufaddr = 0;
+			}
 			if (txq->tx_skbuff[i]) {
 				dev_kfree_skb_any(txq->tx_skbuff[i]);
 				txq->tx_skbuff[i] = NULL;
 			}
-			bdp->cbd_bufaddr = 0;
 			bdp->cbd_sc = (bdp == txq->bd.last) ? BD_SC_WRAP : 0;
 			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		}
@@ -2635,6 +2643,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 						 bdp->cbd_bufaddr,
 						 FEC_ENET_RX_FRSIZE - fep->rx_align,
 						 DMA_FROM_DEVICE);
+				bdp->cbd_bufaddr = 0;
 				dev_kfree_skb(skb);
 			}
 			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
@@ -2645,11 +2654,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		txq = fep->tx_queue[q];
 		bdp = txq->bd.base;
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			if (bdp->cbd_bufaddr) {
+				if (!IS_TSO_HEADER(txq, bdp->cbd_bufaddr))
+					dma_unmap_single(&fep->pdev->dev,
+							 bdp->cbd_bufaddr,
+							 bdp->cbd_datlen,
+							 DMA_TO_DEVICE);
+				bdp->cbd_bufaddr = 0;
+			}
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 			skb = txq->tx_skbuff[i];
 			txq->tx_skbuff[i] = NULL;
 			dev_kfree_skb(skb);
+			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		}
 	}
 }
-- 
2.5.0
