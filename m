From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:04 +0100
Subject: [PATCH 113/222] net:fec: add better flow control support
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeV6-0007Km-Kj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FEC hardware in iMX6 is capable of separate control of each flow
control path: the receiver can be programmed via the receive control
register to detect flow control frames, and the transmitter can be
programmed via the receive FIFO thresholds to enable generation of
pause frames.

This means we can implement the full range of flow control: both
symmetric and asymmetric flow control.  We support ethtool configuring
all options: forced manual mode, where each path can be controlled
individually, and autonegotiation mode.

In autonegotiation mode, the tx/rx enable bits can be used to influence
the outcome, though they don't precisely define which paths will be
enabled.  One combination we don't support is "symmetric only" since we
can always configure each path independently, a case which Linux seems
to often get wrong.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |   3 +-
 drivers/net/ethernet/freescale/fec_main.c | 196 ++++++++++++++++++++++--------
 2 files changed, 146 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index aca92660d2be..af81d0f62dae 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -316,7 +316,8 @@ struct fec_enet_private {
 	struct	completion mdio_done;
 	int	irq[FEC_IRQ_NUM];
 	int	bufdesc_ex;
-	int	pause_flag;
+	unsigned short pause_flag;
+	unsigned short pause_mode;
 
 	struct	napi_struct napi;
 	int	csum_flags;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c697b6ae9039..fb01d7891b67 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -225,8 +225,9 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 /* Transmitter timeout */
 #define TX_TIMEOUT (2 * HZ)
 
-#define FEC_PAUSE_FLAG_AUTONEG	0x1
-#define FEC_PAUSE_FLAG_ENABLE	0x2
+#define FEC_PAUSE_FLAG_AUTONEG	BIT(0)
+#define FEC_PAUSE_FLAG_RX	BIT(1)
+#define FEC_PAUSE_FLAG_TX	BIT(2)
 
 static int mii_cnt;
 
@@ -655,7 +656,7 @@ fec_restart(struct net_device *ndev)
 	 */
 	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
 		/* Enable flow control and length check */
-		rcntl |= 0x40000000 | 0x00000020;
+		rcntl |= 0x40000000;
 
 		/* RGMII, RMII or MII */
 		if (fep->phy_interface == PHY_INTERFACE_MODE_RGMII)
@@ -701,22 +702,24 @@ fec_restart(struct net_device *ndev)
 	}
 
 #if !defined(CONFIG_M5272)
-	/* enable pause frame*/
-	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
-	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
-	     fep->phy_dev && fep->phy_dev->pause)) {
-		rcntl |= FEC_ENET_FCE;
-
-		/* set FIFO threshold parameter to reduce overrun */
-		writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
-		writel(FEC_ENET_RSFL_V, fep->hwp + FEC_R_FIFO_RSFL);
-		writel(FEC_ENET_RAEM_V, fep->hwp + FEC_R_FIFO_RAEM);
-		writel(FEC_ENET_RAFL_V, fep->hwp + FEC_R_FIFO_RAFL);
-
-		/* OPD */
-		writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
-	} else {
-		rcntl &= ~FEC_ENET_FCE;
+	if (fep->full_duplex == DUPLEX_FULL) {
+		/*
+		 * Configure pause modes according to the current status.
+		 * Must only be enabled for full duplex links.
+		 */
+		if (fep->pause_mode & FEC_PAUSE_FLAG_RX)
+			rcntl |= FEC_ENET_FCE;
+
+		if (fep->pause_mode & FEC_PAUSE_FLAG_TX) {
+			/* set FIFO threshold parameter to reduce overrun */
+			writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
+			writel(FEC_ENET_RSFL_V, fep->hwp + FEC_R_FIFO_RSFL);
+			writel(FEC_ENET_RAEM_V, fep->hwp + FEC_R_FIFO_RAEM);
+			writel(FEC_ENET_RAFL_V, fep->hwp + FEC_R_FIFO_RAFL);
+
+			/* OPD */
+			writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
+		}
 	}
 #endif /* !defined(CONFIG_M5272) */
 
@@ -1261,6 +1264,35 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 			status_change = 1;
 		}
 
+		if (fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) {
+			u32 lcl_adv = phy_dev->advertising;
+			u32 rmt_adv = phy_dev->lp_advertising;
+			unsigned mode = 0;
+
+			if (lcl_adv & rmt_adv & ADVERTISED_Pause) {
+				/*
+				 * Local Device  Link Partner
+				 * Pause AsymDir Pause AsymDir Result
+				 *   1     X       1     X     TX+RX
+				 */
+				mode = FEC_PAUSE_FLAG_TX | FEC_PAUSE_FLAG_RX;
+			} else if (lcl_adv & rmt_adv & ADVERTISED_Asym_Pause) {
+				/*
+				 *   0     1       1     1     RX
+				 *   1     1       0     1     TX
+				 */
+				if (rmt_adv & ADVERTISED_Pause)
+					mode = FEC_PAUSE_FLAG_RX;
+				else
+					mode = FEC_PAUSE_FLAG_TX;
+			}
+
+			if (mode != fep->pause_mode) {
+				fep->pause_mode = mode;
+				status_change = 1;
+			}
+		}
+
 		/* if any of the above changed restart the FEC */
 		if (status_change) {
 			napi_disable(&fep->napi);
@@ -1339,6 +1371,34 @@ static int fec_enet_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	return 0;
 }
 
+static void fec_enet_phy_config(struct net_device *ndev)
+{
+#ifndef CONFIG_M5272
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct phy_device *phy = fep->phy_dev;
+	unsigned pause = 0;
+
+	/*
+	 * Pause advertisment logic is weird.  We don't advertise the raw
+	 * "can tx" and "can rx" modes, but instead it is whether we support
+	 * symmetric flow or asymmetric flow.
+	 *
+	 * Symmetric flow means we can only support both transmit and receive
+	 * flow control frames together.  Asymmetric flow means we can
+	 * independently control each.  Note that there is no bit encoding
+	 * for "I can only receive flow control frames."
+	 */
+	if (fep->pause_flag & FEC_PAUSE_FLAG_RX)
+		pause |= ADVERTISED_Asym_Pause | ADVERTISED_Pause;
+	if (fep->pause_flag & FEC_PAUSE_FLAG_TX)
+		pause |= ADVERTISED_Asym_Pause;
+
+	pause &= phy->supported;
+	pause |= phy->advertising & ~(ADVERTISED_Pause | ADVERTISED_Asym_Pause);
+	phy->advertising = pause;
+#endif
+}
+
 static int fec_enet_mii_probe(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -1385,7 +1445,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 		phy_dev->supported &= PHY_GBIT_FEATURES;
 		phy_dev->supported &= ~SUPPORTED_1000baseT_Half;
 #if !defined(CONFIG_M5272)
-		phy_dev->supported |= SUPPORTED_Pause;
+		phy_dev->supported |= SUPPORTED_Pause | SUPPORTED_Asym_Pause;
 #endif
 	}
 	else
@@ -1397,6 +1457,8 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	fep->link = 0;
 	fep->full_duplex = 0;
 
+	fec_enet_phy_config(ndev);
+
 	netdev_info(ndev, "Freescale FEC PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
 		    fep->phy_dev->drv->name, dev_name(&fep->phy_dev->dev),
 		    fep->phy_dev->irq);
@@ -1578,50 +1640,78 @@ static void fec_enet_get_pauseparam(struct net_device *ndev,
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
 	pause->autoneg = (fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) != 0;
-	pause->tx_pause = (fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) != 0;
-	pause->rx_pause = pause->tx_pause;
+	pause->rx_pause = (fep->pause_flag & FEC_PAUSE_FLAG_RX) != 0;
+	pause->tx_pause = (fep->pause_flag & FEC_PAUSE_FLAG_TX) != 0;
 }
 
 static int fec_enet_set_pauseparam(struct net_device *ndev,
 				   struct ethtool_pauseparam *pause)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	unsigned pause_flag, changed;
+	struct phy_device *phy = fep->phy_dev;
 
-	if (!fep->phy_dev)
+	if (!phy)
 		return -ENODEV;
-
-	if (pause->tx_pause != pause->rx_pause) {
-		netdev_info(ndev,
-			"hardware only support enable/disable both tx and rx");
+	if (!(phy->supported & SUPPORTED_Pause))
+		return -EINVAL;
+	if (!(phy->supported & SUPPORTED_Asym_Pause) &&
+	    pause->rx_pause != pause->tx_pause)
 		return -EINVAL;
-	}
 
-	fep->pause_flag = 0;
+	pause_flag = 0;
+	if (pause->autoneg)
+		pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
+	if (pause->rx_pause)
+		pause_flag |= FEC_PAUSE_FLAG_RX;
+	if (pause->tx_pause)
+		pause_flag |= FEC_PAUSE_FLAG_TX;
 
-	/* tx pause must be same as rx pause */
-	fep->pause_flag |= pause->rx_pause ? FEC_PAUSE_FLAG_ENABLE : 0;
-	fep->pause_flag |= pause->autoneg ? FEC_PAUSE_FLAG_AUTONEG : 0;
+	changed = fep->pause_flag ^ pause_flag;
+	fep->pause_flag = pause_flag;
 
-	if (pause->rx_pause || pause->autoneg) {
-		fep->phy_dev->supported |= ADVERTISED_Pause;
-		fep->phy_dev->advertising |= ADVERTISED_Pause;
-	} else {
-		fep->phy_dev->supported &= ~ADVERTISED_Pause;
-		fep->phy_dev->advertising &= ~ADVERTISED_Pause;
-	}
+	/* configure the phy advertisment according to our new options */
+	fec_enet_phy_config(ndev);
 
-	if (pause->autoneg) {
-		if (netif_running(ndev))
-			fec_stop(ndev);
-		phy_start_aneg(fep->phy_dev);
-	}
-	if (netif_running(ndev)) {
-		napi_disable(&fep->napi);
-		netif_tx_lock_bh(ndev);
-		fec_restart(ndev);
-		netif_wake_queue(ndev);
-		netif_tx_unlock_bh(ndev);
-		napi_enable(&fep->napi);
+	if (changed) {
+		if (pause_flag & FEC_PAUSE_FLAG_AUTONEG) {
+			if (netif_running(ndev))
+				phy_start_aneg(fep->phy_dev);
+		} else {
+			int adv, old_adv;
+
+			/*
+			 * Even if we are not in autonegotiate mode, we
+			 * still update the phy with our capabilities so
+			 * our link parter can make the appropriate
+			 * decision.  PHYLIB provides no way to do this.
+			 */
+			adv = phy_read(phy, MII_ADVERTISE);
+			if (adv >= 0) {
+				old_adv = adv;
+				adv &= ~(ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM);
+				if (phy->advertising & ADVERTISED_Pause)
+					adv |= ADVERTISE_PAUSE_CAP;
+				if (phy->advertising & ADVERTISED_Asym_Pause)
+					adv |= ADVERTISE_PAUSE_ASYM;
+
+				if (old_adv != adv)
+					phy_write(phy, MII_ADVERTISE, adv);
+			}
+
+			/* Forced pause mode */
+			fep->pause_mode = fep->pause_flag;
+
+			if (netif_running(ndev)) {
+				napi_disable(&fep->napi);
+				netif_tx_lock_bh(ndev);
+				fec_stop(ndev);
+				fec_restart(ndev);
+				netif_wake_queue(ndev);
+				netif_tx_unlock_bh(ndev);
+				napi_enable(&fep->napi);
+			}
+		}
 	}
 
 	return 0;
@@ -2253,7 +2343,9 @@ fec_probe(struct platform_device *pdev)
 	/* default enable pause frame auto negotiation */
 	if (pdev->id_entry &&
 	    (pdev->id_entry->driver_data & FEC_QUIRK_HAS_GBIT))
-		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
+		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG |
+				   FEC_PAUSE_FLAG_TX |
+				   FEC_PAUSE_FLAG_RX;
 #endif
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.8.3.1
