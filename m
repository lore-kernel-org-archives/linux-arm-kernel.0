From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jul 2018 20:33:21 +0200
Subject: [PATCH net-next 2/5 v2] net: gemini: Improve connection prints
In-Reply-To: <20180704183324.10605-1-linus.walleij@linaro.org>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
Message-ID: <20180704183324.10605-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch over to using a module parameter and debug prints
that can be controlled by this or ethtool like everyone
else. Depromote all other prints to debug messages.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use a module parameter and the message levels like all
  other drivers and stop trying to be special.
---
 drivers/net/ethernet/cortina/gemini.c | 44 +++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 8fc31723f700..f219208d2351 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -46,6 +46,11 @@
 #define DRV_NAME		"gmac-gemini"
 #define DRV_VERSION		"1.0"
 
+#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
+static int debug = -1;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
+
 #define HSIZE_8			0x00
 #define HSIZE_16		0x01
 #define HSIZE_32		0x02
@@ -300,23 +305,26 @@ static void gmac_speed_set(struct net_device *netdev)
 		status.bits.speed = GMAC_SPEED_1000;
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
 			status.bits.mii_rmii = GMAC_PHY_RGMII_1000;
-		netdev_info(netdev, "connect to RGMII @ 1Gbit\n");
+		netdev_dbg(netdev, "connect %s to RGMII @ 1Gbit\n",
+			   phydev_name(phydev));
 		break;
 	case 100:
 		status.bits.speed = GMAC_SPEED_100;
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
 			status.bits.mii_rmii = GMAC_PHY_RGMII_100_10;
-		netdev_info(netdev, "connect to RGMII @ 100 Mbit\n");
+		netdev_dbg(netdev, "connect %s to RGMII @ 100 Mbit\n",
+			   phydev_name(phydev));
 		break;
 	case 10:
 		status.bits.speed = GMAC_SPEED_10;
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
 			status.bits.mii_rmii = GMAC_PHY_RGMII_100_10;
-		netdev_info(netdev, "connect to RGMII @ 10 Mbit\n");
+		netdev_dbg(netdev, "connect %s to RGMII @ 10 Mbit\n",
+			   phydev_name(phydev));
 		break;
 	default:
-		netdev_warn(netdev, "Not supported PHY speed (%d)\n",
-			    phydev->speed);
+		netdev_warn(netdev, "Unsupported PHY speed (%d) on %s\n",
+			    phydev->speed, phydev_name(phydev));
 	}
 
 	if (phydev->duplex == DUPLEX_FULL) {
@@ -363,11 +371,8 @@ static int gmac_setup_phy(struct net_device *netdev)
 		return -ENODEV;
 	netdev->phydev = phy;
 
-	netdev_info(netdev, "connected to PHY \"%s\"\n",
-		    phydev_name(phy));
-	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
-			   (unsigned long)phy->phy_id,
-			   phy_modes(phy->interface));
+	netdev_dbg(netdev, "connected to PHY \"%s\"\n",
+		   phydev_name(phy));
 
 	phy->supported &= PHY_GBIT_FEATURES;
 	phy->supported |= SUPPORTED_Asym_Pause | SUPPORTED_Pause;
@@ -376,19 +381,19 @@ static int gmac_setup_phy(struct net_device *netdev)
 	/* set PHY interface type */
 	switch (phy->interface) {
 	case PHY_INTERFACE_MODE_MII:
-		netdev_info(netdev, "set GMAC0 to GMII mode, GMAC1 disabled\n");
+		netdev_dbg(netdev,
+			   "MII: set GMAC0 to GMII mode, GMAC1 disabled\n");
 		status.bits.mii_rmii = GMAC_PHY_MII;
-		netdev_info(netdev, "connect to MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
-		netdev_info(netdev, "set GMAC0 to GMII mode, GMAC1 disabled\n");
+		netdev_dbg(netdev,
+			   "GMII: set GMAC0 to GMII mode, GMAC1 disabled\n");
 		status.bits.mii_rmii = GMAC_PHY_GMII;
-		netdev_info(netdev, "connect to GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
-		dev_info(dev, "set GMAC0 and GMAC1 to MII/RGMII mode\n");
+		netdev_dbg(netdev,
+			   "RGMII: set GMAC0 and GMAC1 to MII/RGMII mode\n");
 		status.bits.mii_rmii = GMAC_PHY_RGMII_100_10;
-		netdev_info(netdev, "connect to RGMII\n");
 		break;
 	default:
 		netdev_err(netdev, "Unsupported MII interface\n");
@@ -1307,8 +1312,8 @@ static void gmac_enable_irq(struct net_device *netdev, int enable)
 	unsigned long flags;
 	u32 val, mask;
 
-	netdev_info(netdev, "%s device %d %s\n", __func__,
-		    netdev->dev_id, enable ? "enable" : "disable");
+	netdev_dbg(netdev, "%s device %d %s\n", __func__,
+		   netdev->dev_id, enable ? "enable" : "disable");
 	spin_lock_irqsave(&geth->irq_lock, flags);
 
 	mask = GMAC0_IRQ0_2 << (netdev->dev_id * 2);
@@ -1813,7 +1818,7 @@ static int gmac_open(struct net_device *netdev)
 		     HRTIMER_MODE_REL);
 	port->rx_coalesce_timer.function = &gmac_coalesce_delay_expired;
 
-	netdev_info(netdev, "opened\n");
+	netdev_dbg(netdev, "opened\n");
 
 	return 0;
 
@@ -2385,6 +2390,7 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	port->id = id;
 	port->geth = geth;
 	port->dev = dev;
+	port->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
 	/* DMA memory */
 	dmares = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.17.1
