From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:35 +0100
Subject: [PATCH 078/222] net:fec: clean up transmit descriptor setup
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRj-0007IP-LG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid writing any state until we're certain we can proceed with the
transmission: this avoids writing mapping error address values to the
descriptors, or setting the skbuff pointer until we have successfully
mapped the skb.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d9109acc934d..45cb558bb227 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -337,6 +337,8 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	void *bufaddr;
 	unsigned short	status;
 	unsigned int index;
+	unsigned length;
+	dma_addr_t addr;
 
 	/* Fill in a Tx ring entry */
 	bdp = fep->cur_tx;
@@ -362,7 +364,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* Set buffer length and buffer pointer */
 	bufaddr = skb->data;
-	bdp->cbd_datlen = skb->len;
+	length = skb->len;
 
 	/*
 	 * On some FEC implementations data must be aligned on
@@ -376,7 +378,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		index = bdp - fep->tx_bd_base;
 
 	if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
-		memcpy(fep->tx_bounce[index], skb->data, skb->len);
+		memcpy(fep->tx_bounce[index], skb->data, length);
 		bufaddr = fep->tx_bounce[index];
 	}
 
@@ -386,25 +388,23 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	 * swap every frame going to and coming from the controller.
 	 */
 	if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
-		swap_buffer(bufaddr, skb->len);
+		swap_buffer(bufaddr, length);
 
-	/* Save skb pointer */
-	fep->tx_skbuff[index] = skb;
-
-	/* Push the data cache so the CPM does not get stale memory
-	 * data.
-	 */
-	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
-			skb->len, DMA_TO_DEVICE);
-	if (dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr)) {
-		bdp->cbd_bufaddr = 0;
-		fep->tx_skbuff[index] = NULL;
+	/* Push the data cache so the CPM does not get stale memory data. */
+	addr = dma_map_single(&fep->pdev->dev, bufaddr, length, DMA_TO_DEVICE);
+	if (dma_mapping_error(&fep->pdev->dev, addr)) {
 		dev_kfree_skb_any(skb);
 		if (net_ratelimit())
 			netdev_err(ndev, "Tx DMA memory map failed\n");
 		return NETDEV_TX_OK;
 	}
 
+	/* Save skb pointer */
+	fep->tx_skbuff[index] = skb;
+
+	bdp->cbd_datlen = length;
+	bdp->cbd_bufaddr = addr;
+
 	if (fep->bufdesc_ex) {
 
 		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
@@ -489,7 +489,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Initialize the BD for every fragment in the page. */
 		bdp->cbd_sc = 0;
-		if (bdp->cbd_bufaddr && fep->tx_skbuff[i]) {
+		if (fep->tx_skbuff[i]) {
 			dev_kfree_skb_any(fep->tx_skbuff[i]);
 			fep->tx_skbuff[i] = NULL;
 		}
@@ -793,6 +793,7 @@ fec_enet_tx(struct net_device *ndev)
 			index = bdp - fep->tx_bd_base;
 
 		skb = fep->tx_skbuff[index];
+		fep->tx_skbuff[index] = NULL;
 		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr, skb->len,
 				DMA_TO_DEVICE);
 		bdp->cbd_bufaddr = 0;
@@ -842,7 +843,6 @@ fec_enet_tx(struct net_device *ndev)
 
 		/* Free the sk buffer associated with this last transmit */
 		dev_kfree_skb_any(skb);
-		fep->tx_skbuff[index] = NULL;
 
 		fep->dirty_tx = bdp;
 
-- 
1.8.3.1
