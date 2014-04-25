From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:09 +0100
Subject: [PATCH 114/222] net:fec: move transmit dma ring address calculation
 to fec_enet_init()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVB-0007Kq-O8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the calculation of the transmit DMA ring address to fec_enet_init()
so the CPU and DMA ring address calculations are localised.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  3 ++-
 drivers/net/ethernet/freescale/fec_main.c | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index af81d0f62dae..29f607a2d9b0 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -287,7 +287,8 @@ struct fec_enet_private {
 	struct	sk_buff *rx_skbuff[RX_RING_SIZE];
 
 	/* CPM dual port RAM relative addresses */
-	dma_addr_t	bd_dma;
+	dma_addr_t	rx_bd_dma;
+	dma_addr_t	tx_bd_dma;
 	/* Address of Rx and Tx buffers */
 	union bufdesc_u	*rx_bd_base;
 	union bufdesc_u	*tx_bd_base;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fb01d7891b67..96e74ef0c4d6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -611,14 +611,8 @@ fec_restart(struct net_device *ndev)
 	netdev_reset_queue(ndev);
 
 	/* Set receive and transmit descriptor base. */
-	writel(fep->bd_dma, fep->hwp + FEC_R_DES_START);
-	if (fep->bufdesc_ex)
-		writel((unsigned long)fep->bd_dma + sizeof(struct bufdesc_ex)
-			* fep->rx_ring_size, fep->hwp + FEC_X_DES_START);
-	else
-		writel((unsigned long)fep->bd_dma + sizeof(struct bufdesc)
-			* fep->rx_ring_size,	fep->hwp + FEC_X_DES_START);
-
+	writel(fep->rx_bd_dma, fep->hwp + FEC_R_DES_START);
+	writel(fep->tx_bd_dma, fep->hwp + FEC_X_DES_START);
 
 	for (i = 0; i <= TX_RING_MOD_MASK; i++) {
 		if (fep->tx_skbuff[i]) {
@@ -2208,10 +2202,10 @@ static int fec_enet_init(struct net_device *ndev)
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
 	union bufdesc_u *cbd_base;
+	dma_addr_t cbd_dma;
 
 	/* Allocate memory for buffer descriptors. */
-	cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &fep->bd_dma,
-				      GFP_KERNEL);
+	cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &cbd_dma, GFP_KERNEL);
 	if (!cbd_base)
 		return -ENOMEM;
 
@@ -2230,12 +2224,18 @@ static int fec_enet_init(struct net_device *ndev)
 
 	/* Set receive and transmit descriptor base. */
 	fep->rx_bd_base = cbd_base;
-	if (fep->bufdesc_ex)
+	fep->rx_bd_dma = cbd_dma;
+	if (fep->bufdesc_ex) {
 		fep->tx_bd_base = (union bufdesc_u *)
 			(&cbd_base->ebd + fep->rx_ring_size);
-	else
+		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc_ex) *
+			fep->rx_ring_size;
+	} else {
 		fep->tx_bd_base = (union bufdesc_u *)
 			(&cbd_base->bd + fep->rx_ring_size);
+		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc) *
+			fep->rx_ring_size;
+	}
 
 	/* The FEC Ethernet specific entries in the device structure */
 	ndev->watchdog_timeo = TX_TIMEOUT;
-- 
1.8.3.1
