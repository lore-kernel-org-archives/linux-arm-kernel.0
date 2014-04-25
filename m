From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:35 +0100
Subject: [PATCH 119/222] net:fec: move bufdesc_ex flag into flags
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVb-0007LA-9R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new flags field to contain the mostly static driver configuration,
the first of which is the bufdesc_ex flag.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +-
 drivers/net/ethernet/freescale/fec_main.c | 48 +++++++++++++++++--------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 11717d2fd520..a5d38e4c770c 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -301,6 +301,8 @@ struct fec_enet_private {
 	unsigned short tx_ring_size;
 	unsigned short rx_ring_size;
 
+	unsigned char flags;
+
 	struct mutex mutex;
 
 	struct	platform_device *pdev;
@@ -318,7 +320,6 @@ struct fec_enet_private {
 	int	speed;
 	struct	completion mdio_done;
 	int	irq[FEC_IRQ_NUM];
-	int	bufdesc_ex;
 	unsigned short pause_flag;
 	unsigned short pause_mode;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index afbcd7f14951..c35a1e00129c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -225,10 +225,14 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 /* Transmitter timeout */
 #define TX_TIMEOUT (2 * HZ)
 
+/* pause mode/flag */
 #define FEC_PAUSE_FLAG_AUTONEG	BIT(0)
 #define FEC_PAUSE_FLAG_RX	BIT(1)
 #define FEC_PAUSE_FLAG_TX	BIT(2)
 
+/* flags */
+#define FEC_FLAG_BUFDESC_EX	BIT(0)
+
 static int mii_cnt;
 
 static union bufdesc_u *
@@ -237,7 +241,7 @@ fec_enet_tx_get(unsigned index, struct fec_enet_private *fep)
 	union bufdesc_u *base = fep->tx_bd_base;
 	union bufdesc_u *bdp;
 
-	if (fep->bufdesc_ex)
+	if (fep->flags & FEC_FLAG_BUFDESC_EX)
 		bdp = (union bufdesc_u *)(&base->ebd + index);
 	else
 		bdp = (union bufdesc_u *)(&base->bd + index);
@@ -253,7 +257,7 @@ fec_enet_rx_get(unsigned index, struct fec_enet_private *fep)
 
 	index &= fep->rx_ring_size - 1;
 
-	if (fep->bufdesc_ex)
+	if (fep->flags & FEC_FLAG_BUFDESC_EX)
 		bdp = (union bufdesc_u *)(&base->ebd + index);
 	else
 		bdp = (union bufdesc_u *)(&base->bd + index);
@@ -417,7 +421,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	fep->tx_page_map[index] = 0;
 
 	cbd_esc = BD_ENET_TX_INT;
-	if (fep->bufdesc_ex) {
+	if (fep->flags & FEC_FLAG_BUFDESC_EX) {
 		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
 			fep->hwts_tx_en)) {
 			cbd_esc |= BD_ENET_TX_TS;
@@ -464,7 +468,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		bdp = fec_enet_tx_get(last, fep);
 		bdp->bd.cbd_datlen = length;
 		bdp->bd.cbd_bufaddr = addr;
-		if (fep->bufdesc_ex) {
+		if (fep->flags & FEC_FLAG_BUFDESC_EX) {
 			bdp->ebd.cbd_esc = cbd_esc;
 			bdp->ebd.cbd_bdu = 0;
 		}
@@ -726,7 +730,7 @@ fec_restart(struct net_device *ndev)
 		writel(1 << 8, fep->hwp + FEC_X_WMRK);
 	}
 
-	if (fep->bufdesc_ex)
+	if (fep->flags & FEC_FLAG_BUFDESC_EX)
 		ecntl |= (1 << 4);
 
 #ifndef CONFIG_M5272
@@ -738,7 +742,7 @@ fec_restart(struct net_device *ndev)
 	writel(ecntl, fep->hwp + FEC_ECNTRL);
 	writel(0, fep->hwp + FEC_R_DES_ACTIVE);
 
-	if (fep->bufdesc_ex)
+	if (fep->flags & FEC_FLAG_BUFDESC_EX)
 		fec_ptp_start_cyclecounter(ndev);
 
 	/* Enable interrupts we wish to service */
@@ -879,7 +883,7 @@ fec_enet_tx(struct net_device *ndev)
 			ndev->stats.collisions++;
 
 		if (skb) {
-			if (fep->bufdesc_ex &&
+			if (fep->flags & FEC_FLAG_BUFDESC_EX &&
 			    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)) {
 				struct skb_shared_hwtstamps shhwtstamps;
 
@@ -998,7 +1002,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		/* If this is a VLAN packet remove the VLAN Tag */
 		vlan_packet_rcvd = false;
 		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
-		    fep->bufdesc_ex && (bdp->ebd.cbd_esc & BD_ENET_RX_VLAN)) {
+		    fep->flags & FEC_FLAG_BUFDESC_EX && (bdp->ebd.cbd_esc & BD_ENET_RX_VLAN)) {
 			/* Push and remove the vlan tag */
 			struct vlan_hdr *vlan_header =
 					(struct vlan_hdr *) (data + ETH_HLEN);
@@ -1033,11 +1037,11 @@ fec_enet_rx(struct net_device *ndev, int budget)
 			skb->protocol = eth_type_trans(skb, ndev);
 
 			/* Get receive timestamp from the skb */
-			if (fep->hwts_rx_en && fep->bufdesc_ex)
+			if (fep->hwts_rx_en && fep->flags & FEC_FLAG_BUFDESC_EX)
 				fec_enet_hwtstamp(fep, bdp->ebd.ts,
 						  skb_hwtstamps(skb));
 
-			if (fep->bufdesc_ex &&
+			if (fep->flags & FEC_FLAG_BUFDESC_EX &&
 			    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
 				if (!(bdp->ebd.cbd_esc & FLAG_RX_CSUM_ERROR)) {
 					/* don't check it */
@@ -1059,7 +1063,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		dma_sync_single_for_device(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
 rx_processing_done:
-		if (fep->bufdesc_ex) {
+		if (fep->flags & FEC_FLAG_BUFDESC_EX) {
 			bdp->ebd.cbd_esc = BD_ENET_RX_INT;
 			bdp->ebd.cbd_prot = 0;
 			bdp->ebd.cbd_bdu = 0;
@@ -1602,7 +1606,7 @@ static int fec_enet_get_ts_info(struct net_device *ndev,
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	if (fep->bufdesc_ex) {
+	if (fep->flags & FEC_FLAG_BUFDESC_EX) {
 
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
 					SOF_TIMESTAMPING_RX_SOFTWARE |
@@ -1851,7 +1855,7 @@ static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 	if (!phydev)
 		return -ENODEV;
 
-	if (fep->bufdesc_ex) {
+	if (fep->flags & FEC_FLAG_BUFDESC_EX) {
 		if (cmd == SIOCSHWTSTAMP)
 			return fec_ptp_set(ndev, rq);
 		if (cmd == SIOCGHWTSTAMP)
@@ -1914,7 +1918,7 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	/* Set receive and transmit descriptor base. */
 	fep->rx_bd_base = cbd_base;
 	fep->rx_bd_dma = cbd_dma;
-	if (fep->bufdesc_ex) {
+	if (fep->flags & FEC_FLAG_BUFDESC_EX) {
 		fep->tx_bd_base = (union bufdesc_u *)
 			(&cbd_base->ebd + fep->rx_ring_size);
 		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc_ex) *
@@ -1950,7 +1954,7 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 		if (i == fep->rx_ring_size - 1)
 			bdp->bd.cbd_sc |= BD_SC_WRAP;
 
-		if (fep->bufdesc_ex)
+		if (fep->flags & FEC_FLAG_BUFDESC_EX)
 			bdp->ebd.cbd_esc = BD_ENET_RX_INT;
 	}
 
@@ -1967,7 +1971,7 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 			bdp->bd.cbd_sc = 0;
 		bdp->bd.cbd_bufaddr = 0;
 
-		if (fep->bufdesc_ex)
+		if (fep->flags & FEC_FLAG_BUFDESC_EX)
 			bdp->ebd.cbd_esc = BD_ENET_TX_INT;
 	}
 
@@ -2367,7 +2371,9 @@ fec_probe(struct platform_device *pdev)
 	fep->pdev = pdev;
 	fep->dev_id = dev_id++;
 
-	fep->bufdesc_ex = 0;
+	fep->flags = 0;
+	if (pdev->id_entry->driver_data & FEC_QUIRK_HAS_BUFDESC_EX)
+		fep->flags |= FEC_FLAG_BUFDESC_EX;
 
 	platform_set_drvdata(pdev, ndev);
 
@@ -2400,11 +2406,9 @@ fec_probe(struct platform_device *pdev)
 		fep->clk_enet_out = NULL;
 
 	fep->clk_ptp = devm_clk_get(&pdev->dev, "ptp");
-	fep->bufdesc_ex =
-		pdev->id_entry->driver_data & FEC_QUIRK_HAS_BUFDESC_EX;
 	if (IS_ERR(fep->clk_ptp)) {
 		fep->clk_ptp = NULL;
-		fep->bufdesc_ex = 0;
+		fep->flags &= ~FEC_FLAG_BUFDESC_EX;
 	}
 
 	ret = clk_prepare_enable(fep->clk_ahb);
@@ -2441,7 +2445,7 @@ fec_probe(struct platform_device *pdev)
 
 	fec_reset_phy(pdev);
 
-	if (fep->bufdesc_ex)
+	if (fep->flags & FEC_FLAG_BUFDESC_EX)
 		fec_ptp_init(pdev);
 
 	fec_enet_init(ndev);
@@ -2471,7 +2475,7 @@ fec_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_register;
 
-	if (fep->bufdesc_ex && fep->ptp_clock)
+	if (fep->flags & FEC_FLAG_BUFDESC_EX && fep->ptp_clock)
 		netdev_info(ndev, "registered PHC device %d\n", fep->dev_id);
 
 	INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
-- 
1.8.3.1
