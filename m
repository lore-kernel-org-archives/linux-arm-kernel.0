From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:40 +0100
Subject: [PATCH 079/222] net:fec: make rx skb allocation/map more robust
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRo-0007IT-Ob@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate, and then map the receive skb before writing any data to the
ring descriptor or storing the skb.  This means we have ring data in
one of two states: either fully setup, or not setup.  This simplifies
the cleanup, which could end up calling dma_unmap_single() on a DMA
error value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 45cb558bb227..f98ddb0923a3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1712,12 +1712,11 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
 		skb = fep->rx_skbuff[i];
-
-		if (bdp->cbd_bufaddr)
+		if (skb) {
 			dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
-		if (skb)
 			dev_kfree_skb(skb);
+		}
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
@@ -1735,21 +1734,26 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 
 	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
+		dma_addr_t addr;
+
 		skb = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
 		if (!skb) {
 			fec_enet_free_buffers(ndev);
 			return -ENOMEM;
 		}
-		fep->rx_skbuff[i] = skb;
 
-		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, skb->data,
+		addr = dma_map_single(&fep->pdev->dev, skb->data,
 				FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr)) {
+		if (dma_mapping_error(&fep->pdev->dev, addr)) {
+			dev_kfree_skb(skb);
 			fec_enet_free_buffers(ndev);
 			if (net_ratelimit())
 				netdev_err(ndev, "Rx DMA memory map failed\n");
 			return -ENOMEM;
 		}
+
+		fep->rx_skbuff[i] = skb;
+		bdp->cbd_bufaddr = addr;
 		bdp->cbd_sc = BD_ENET_RX_EMPTY;
 
 		if (fep->bufdesc_ex) {
-- 
1.8.3.1
