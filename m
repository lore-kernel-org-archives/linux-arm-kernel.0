From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:58 -0700
Subject: [PATCH net-next 34/40] net: fec: update dirty_tx even if no skb
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-35-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If dirty_tx isn't updated, then dma_unmap_single
will be called twice.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 512b1ad..8dea600 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1236,10 +1236,8 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_private *fep,
 			dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
 					bdp->cbd_datlen, DMA_TO_DEVICE);
 		bdp->cbd_bufaddr = 0;
-		if (!skb) {
-			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
-			continue;
-		}
+		if (!skb)
+			goto skb_done;
 
 		/* Check for errors. */
 		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
@@ -1278,7 +1276,7 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_private *fep,
 
 		/* Free the sk buffer associated with this last transmit */
 		dev_kfree_skb_any(skb);
-
+skb_done:
 		/* Make sure the update to bdp and tx_skbuff are performed
 		 * before dirty_tx
 		 */
-- 
2.5.0
