From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  1 Feb 2013 08:52:10 +0100
Subject: [PATCH 7/9] como fec wip
In-Reply-To: <1359705132-9434-1-git-send-email-s.hauer@pengutronix.de>
References: <1359705132-9434-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1359705132-9434-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/net/fsl-fec.txt |   20 ++++++
 drivers/net/ethernet/freescale/fec.c              |   77 ++++++++++++---------
 drivers/net/ethernet/freescale/fec.h              |    1 +
 3 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index d536392..ec7060b 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -15,6 +15,9 @@ Optional properties:
   only if property "phy-reset-gpios" is available.  Missing the property
   will have the duration be 1 millisecond.  Numbers greater than 1000 are
   invalid and 1 millisecond will be used instead.
+- phy : a phandle for the PHY device used for the fec. Used to specify an
+  external phy or to specify a particular address if the mdio bus has multiple
+  phys on it.
 
 Example:
 
@@ -26,3 +29,20 @@ ethernet at 83fec000 {
 	phy-reset-gpios = <&gpio2 14 0>; /* GPIO2_14 */
 	local-mac-address = [00 04 9F 01 1B B9];
 };
+
+Example with specific phy address:
+
+ethernet at 83fec000 {
+	compatible = "fsl,imx51-fec", "fsl,imx27-fec";
+	reg = <0x83fec000 0x4000>;
+	interrupts = <87>;
+	phy-mode = "mii";
+	phy-reset-gpios = <&gpio2 14 0>; /* GPIO2_14 */
+	local-mac-address = [00 04 9F 01 1B B9];
+	phy = &phy3;
+
+	phy3: ethernet-phy at 3 {
+		reg = <3>;
+		device_type = "ethernet-phy";
+	};
+};
diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index 0704bca..54a8506 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -48,6 +48,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_net.h>
+#include <linux/of_mdio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 
@@ -950,31 +951,38 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 
 	fep->phy_dev = NULL;
 
-	/* check for attached phy */
-	for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
-		if ((fep->mii_bus->phy_mask & (1 << phy_id)))
-			continue;
-		if (fep->mii_bus->phy_map[phy_id] == NULL)
-			continue;
-		if (fep->mii_bus->phy_map[phy_id]->phy_id == 0)
-			continue;
-		if (dev_id--)
-			continue;
-		strncpy(mdio_bus_id, fep->mii_bus->id, MII_BUS_ID_SIZE);
-		break;
-	}
+	if (fep->phy_node) {
+		phy_dev = of_phy_connect(ndev, fep->phy_node, &fec_enet_adjust_link, 0,
+			      fep->phy_interface);
+	} else {
+		/* check for attached phy */
+		for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
+			if ((fep->mii_bus->phy_mask & (1 << phy_id)))
+				continue;
+			if (fep->mii_bus->phy_map[phy_id] == NULL)
+				continue;
+			if (fep->mii_bus->phy_map[phy_id]->phy_id == 0)
+				continue;
+			if (dev_id--)
+				continue;
+			strncpy(mdio_bus_id, fep->mii_bus->id, MII_BUS_ID_SIZE);
+			break;
+		}
 
-	if (phy_id >= PHY_MAX_ADDR) {
-		printk(KERN_INFO
-			"%s: no PHY, assuming direct connection to switch\n",
-			ndev->name);
-		strncpy(mdio_bus_id, "fixed-0", MII_BUS_ID_SIZE);
-		phy_id = 0;
+		if (phy_id >= PHY_MAX_ADDR) {
+			printk(KERN_INFO
+				"%s: no PHY, assuming direct connection to switch\n",
+				ndev->name);
+			strncpy(mdio_bus_id, "fixed-0", MII_BUS_ID_SIZE);
+			phy_id = 0;
+		}
+
+		snprintf(phy_name, sizeof(phy_name), PHY_ID_FMT, mdio_bus_id, phy_id);
+
+		phy_dev = phy_connect(ndev, phy_name, &fec_enet_adjust_link, 0,
+				      fep->phy_interface);
 	}
 
-	snprintf(phy_name, sizeof(phy_name), PHY_ID_FMT, mdio_bus_id, phy_id);
-	phy_dev = phy_connect(ndev, phy_name, &fec_enet_adjust_link, 0,
-			      fep->phy_interface);
 	if (IS_ERR(phy_dev)) {
 		printk(KERN_ERR "%s: could not attach to PHY\n", ndev->name);
 		return PTR_ERR(phy_dev);
@@ -1076,7 +1084,12 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	for (i = 0; i < PHY_MAX_ADDR; i++)
 		fep->mii_bus->irq[i] = PHY_POLL;
 
-	if (mdiobus_register(fep->mii_bus))
+	if (fep->phy_node)
+		err = of_mdiobus_register(fep->mii_bus, pdev->dev.of_node);
+	else
+		err = mdiobus_register(fep->mii_bus);
+
+	if (err)
 		goto err_out_free_mdio_irq;
 
 	mii_cnt++;
@@ -1484,12 +1497,16 @@ static int fec_enet_init(struct net_device *ndev)
 }
 
 #ifdef CONFIG_OF
-static int fec_get_phy_mode_dt(struct platform_device *pdev)
+static int fec_probe_dt(struct fec_enet_private *fep)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = fep->pdev->dev.of_node;
+
+	if (!np)
+		return -ENODEV;
 
-	if (np)
-		return of_get_phy_mode(np);
+	fep->phy_interface = of_get_phy_mode(np);
+
+	fep->phy_node = of_parse_phandle(np, "phy", 0);
 
 	return -ENODEV;
 }
@@ -1519,7 +1536,7 @@ static void fec_reset_phy(struct platform_device *pdev)
 	gpio_set_value(phy_reset, 1);
 }
 #else /* CONFIG_OF */
-static inline int fec_get_phy_mode_dt(struct platform_device *pdev)
+static inline int fec_probe_dt(struct fec_enet_private *fep)
 {
 	return -ENODEV;
 }
@@ -1581,15 +1598,13 @@ fec_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ndev);
 
-	ret = fec_get_phy_mode_dt(pdev);
+	ret = fec_probe_dt(fep);
 	if (ret < 0) {
 		pdata = pdev->dev.platform_data;
 		if (pdata)
 			fep->phy_interface = pdata->phy;
 		else
 			fep->phy_interface = PHY_INTERFACE_MODE_MII;
-	} else {
-		fep->phy_interface = ret;
 	}
 
 	for (i = 0; i < FEC_IRQ_NUM; i++) {
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index c5a3bc1..0120ea6 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -236,6 +236,7 @@ struct fec_enet_private {
 	/* Phylib and MDIO interface */
 	struct	mii_bus *mii_bus;
 	struct	phy_device *phy_dev;
+	struct	device_node *phy_node;
 	int	mii_timeout;
 	uint	phy_speed;
 	phy_interface_t	phy_interface;
-- 
1.7.10.4
