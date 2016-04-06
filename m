From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:26:01 -0700
Subject: [PATCH net-next V3 15/16] net: fec: call dma_unmap_single on mapped
 tx buffers at restart
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-16-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure any pending tx buffers are unmapped when the
fec is restarted.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: no change
---
 drivers/net/ethernet/freescale/fec_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a38acf2..101d820 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -404,6 +404,7 @@ dma_mapping_error:
 		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		dma_unmap_single(&fep->pdev->dev, fec32_to_cpu(bdp->cbd_bufaddr),
 				 fec16_to_cpu(bdp->cbd_datlen), DMA_TO_DEVICE);
+		bdp->cbd_bufaddr = cpu_to_fec32(0);
 	}
 	return ERR_PTR(-ENOMEM);
 }
@@ -761,11 +762,18 @@ static void reset_tx_queue(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 	for (i = 0; i < txq->bd.ring_size; i++) {
 		/* Initialize the BD for every fragment in the page. */
+		if (bdp->cbd_bufaddr) {
+			if (!IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+		}
 		if (txq->tx_skbuff[i]) {
 			dev_kfree_skb_any(txq->tx_skbuff[i]);
 			txq->tx_skbuff[i] = NULL;
 		}
-		bdp->cbd_bufaddr = cpu_to_fec32(0);
 		bdp->cbd_sc = cpu_to_fec16((bdp == txq->bd.last) ?
 					   BD_SC_WRAP : 0);
 		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -2643,6 +2651,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 FEC_ENET_RX_FRSIZE - fep->rx_align,
 						 DMA_FROM_DEVICE);
+				bdp->cbd_bufaddr = cpu_to_fec32(0);
 				dev_kfree_skb(skb);
 			}
 			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
-- 
2.5.0
