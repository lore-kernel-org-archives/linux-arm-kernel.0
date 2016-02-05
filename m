From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri,  5 Feb 2016 14:52:50 -0700
Subject: [PATCH net-next V2 8/8] net: fec: improve error handling
In-Reply-To: <1454709170-19527-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454709170-19527-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454709170-19527-9-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unmap initial buffer on error.
Don't free skb until it has been unmapped.
Move cbd_bufaddr assignment closer to the mapping function.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 97ca72a..ef18ca5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -382,7 +382,6 @@ fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 		addr = dma_map_single(&fep->pdev->dev, bufaddr, frag_len,
 				      DMA_TO_DEVICE);
 		if (dma_mapping_error(&fep->pdev->dev, addr)) {
-			dev_kfree_skb_any(skb);
 			if (net_ratelimit())
 				netdev_err(ndev, "Tx DMA memory map failed\n");
 			goto dma_mapping_error;
@@ -467,8 +466,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	if (nr_frags) {
 		last_bdp = fec_enet_txq_submit_frag_skb(txq, skb, ndev);
-		if (IS_ERR(last_bdp))
+		if (IS_ERR(last_bdp)) {
+			dma_unmap_single(&fep->pdev->dev, addr,
+					 buflen, DMA_TO_DEVICE);
+			dev_kfree_skb_any(skb);
 			return NETDEV_TX_OK;
+		}
 	} else {
 		status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
 		if (fep->bufdesc_ex) {
@@ -478,6 +481,8 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 				estatus |= BD_ENET_TX_TS;
 		}
 	}
+	bdp->cbd_bufaddr = cpu_to_fec32(addr);
+	bdp->cbd_datlen = cpu_to_fec16(buflen);
 
 	if (fep->bufdesc_ex) {
 
@@ -501,8 +506,6 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	/* Save skb pointer */
 	txq->tx_skbuff[index] = skb;
 
-	bdp->cbd_datlen = cpu_to_fec16(buflen);
-	bdp->cbd_bufaddr = cpu_to_fec32(addr);
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
-- 
2.5.0
