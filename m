From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:56 +0100
Subject: [PATCH 082/222] net:fec: ensure that we dma unmap the transmit
 descriptors
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeS4-0007If-2r@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On transmit timeout or close, dirty transmit descriptors were not being
correctly cleaned: the only time that DMA mappings are cleaned is when
scanning the TX ring after a transmit interrupt.  Fix this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7f7d9dcb485e..94861870e741 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -327,6 +327,17 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 	return 0;
 }
 
+static void
+fec_enet_tx_unmap(struct bufdesc *bdp, struct fec_enet_private *fep)
+{
+	dma_addr_t addr = bdp->cbd_bufaddr;
+	unsigned length = bdp->cbd_datlen;
+
+	bdp->cbd_bufaddr = 0;
+
+	dma_unmap_single(&fep->pdev->dev, addr, length, DMA_TO_DEVICE);
+}
+
 static netdev_tx_t
 fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
@@ -489,11 +500,12 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Initialize the BD for every fragment in the page. */
 		bdp->cbd_sc = 0;
+		if (bdp->cbd_bufaddr)
+			fec_enet_tx_unmap(bdp, fep);
 		if (fep->tx_skbuff[i]) {
 			dev_kfree_skb_any(fep->tx_skbuff[i]);
 			fep->tx_skbuff[i] = NULL;
 		}
-		bdp->cbd_bufaddr = 0;
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
@@ -792,11 +804,10 @@ fec_enet_tx(struct net_device *ndev)
 		else
 			index = bdp - fep->tx_bd_base;
 
+		fec_enet_tx_unmap(bdp, fep);
+
 		skb = fep->tx_skbuff[index];
 		fep->tx_skbuff[index] = NULL;
-		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr, skb->len,
-				DMA_TO_DEVICE);
-		bdp->cbd_bufaddr = 0;
 
 		/* Check for errors. */
 		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
@@ -1723,6 +1734,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	bdp = fep->tx_bd_base;
 	for (i = 0; i < fep->tx_ring_size; i++) {
+		if (bdp->cbd_bufaddr)
+			fec_enet_tx_unmap(bdp, fep);
 		kfree(fep->tx_bounce[i]);
 		fep->tx_bounce[i] = NULL;
 		skb = fep->tx_skbuff[i];
-- 
1.8.3.1
