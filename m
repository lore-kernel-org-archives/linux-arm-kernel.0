From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:14 +0100
Subject: [PATCH 115/222] net:fec: allocate descriptor rings at device open,
 and free on device close
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVG-0007Ku-Rg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has had a memory leak for quite some time: when the device is
probed, we allocate a page for the descriptor rings, but we never free
this.

Rather than trying to free it on the various probe failure paths, move
its allocation to device open time - we have to restart the FEC for this
to take effect.  This also means we can free the descriptor rings when
we clean up in the device close function, which gives this a nice
symmetry.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 67 +++++++++++++++----------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 96e74ef0c4d6..9471abb189bc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -607,7 +607,8 @@ fec_restart(struct net_device *ndev)
 	/* Set maximum receive buffer size. */
 	writel(PKT_MAXBLR_SIZE, fep->hwp + FEC_R_BUFF_SIZE);
 
-	fec_enet_bd_init(ndev);
+	if (fep->rx_bd_base)
+		fec_enet_bd_init(ndev);
 	netdev_reset_queue(ndev);
 
 	/* Set receive and transmit descriptor base. */
@@ -1889,6 +1890,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		if (skb)
 			dev_kfree_skb(skb);
 	}
+
+	dma_free_coherent(NULL, PAGE_SIZE, fep->rx_bd_base, fep->rx_bd_dma);
 }
 
 static int fec_enet_alloc_buffers(struct net_device *ndev)
@@ -1897,6 +1900,30 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct sk_buff *skb;
 	union bufdesc_u *bdp;
+	union bufdesc_u *cbd_base;
+	dma_addr_t cbd_dma;
+
+	/* Allocate memory for buffer descriptors. */
+	cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &cbd_dma, GFP_KERNEL);
+	if (!cbd_base)
+		return -ENOMEM;
+
+	memset(cbd_base, 0, PAGE_SIZE);
+
+	/* Set receive and transmit descriptor base. */
+	fep->rx_bd_base = cbd_base;
+	fep->rx_bd_dma = cbd_dma;
+	if (fep->bufdesc_ex) {
+		fep->tx_bd_base = (union bufdesc_u *)
+			(&cbd_base->ebd + fep->rx_ring_size);
+		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc_ex) *
+			fep->rx_ring_size;
+	} else {
+		fep->tx_bd_base = (union bufdesc_u *)
+			(&cbd_base->bd + fep->rx_ring_size);
+		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc) *
+			fep->rx_ring_size;
+	}
 
 	for (i = 0; i < fep->rx_ring_size; i++) {
 		dma_addr_t addr;
@@ -2192,24 +2219,11 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_set_features	= fec_set_features,
 };
 
- /*
-  * XXX:  We need to clean up on failure exits here.
-  *
-  */
-static int fec_enet_init(struct net_device *ndev)
+static void fec_enet_init(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	union bufdesc_u *cbd_base;
-	dma_addr_t cbd_dma;
-
-	/* Allocate memory for buffer descriptors. */
-	cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &cbd_dma, GFP_KERNEL);
-	if (!cbd_base)
-		return -ENOMEM;
-
-	memset(cbd_base, 0, PAGE_SIZE);
 
 	fep->netdev = ndev;
 
@@ -2222,20 +2236,8 @@ static int fec_enet_init(struct net_device *ndev)
 	fep->tx_ring_size = TX_RING_SIZE;
 	fep->rx_ring_size = RX_RING_SIZE;
 
-	/* Set receive and transmit descriptor base. */
-	fep->rx_bd_base = cbd_base;
-	fep->rx_bd_dma = cbd_dma;
-	if (fep->bufdesc_ex) {
-		fep->tx_bd_base = (union bufdesc_u *)
-			(&cbd_base->ebd + fep->rx_ring_size);
-		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc_ex) *
-			fep->rx_ring_size;
-	} else {
-		fep->tx_bd_base = (union bufdesc_u *)
-			(&cbd_base->bd + fep->rx_ring_size);
-		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc) *
-			fep->rx_ring_size;
-	}
+	fep->rx_bd_base = fep->tx_bd_base = NULL;
+	fep->rx_bd_dma = fep->tx_bd_dma = 0;
 
 	/* The FEC Ethernet specific entries in the device structure */
 	ndev->watchdog_timeo = TX_TIMEOUT;
@@ -2272,8 +2274,6 @@ static int fec_enet_init(struct net_device *ndev)
 		fep->tx_min = 1;
 
 	fec_restart(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -2435,9 +2435,7 @@ fec_probe(struct platform_device *pdev)
 	if (fep->bufdesc_ex)
 		fec_ptp_init(pdev);
 
-	ret = fec_enet_init(ndev);
-	if (ret)
-		goto failed_init;
+	fec_enet_init(ndev);
 
 	for (i = 0; i < FEC_IRQ_NUM; i++) {
 		irq = platform_get_irq(pdev, i);
@@ -2474,7 +2472,6 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
-failed_init:
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
 failed_regulator:
-- 
1.8.3.1
