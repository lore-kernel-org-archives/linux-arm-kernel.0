From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 20:50:17 +0000
Subject: [PATCH V4 08/11] mv643xx.c: Add basic device tree support.
In-Reply-To: <cover.1359232975.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359232975.git.jason@lakedaemon.net>
Message-ID: <ae234445a8e7da81922be524f6eadce51b7f29db.1359232975.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ian Molton <ian.molton@codethink.co.uk>

    This patch adds basic device tree support to the mv643xx ethernet driver.

    It should be enough for most current users of the device, and should allow
    a painless migration.

    Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Documentation/devicetree/bindings/net/mv643xx.txt | 75 ++++++++++++++++++
 drivers/net/ethernet/marvell/mv643xx_eth.c        | 93 +++++++++++++++++++++--
 2 files changed, 161 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mv643xx.txt

diff --git a/Documentation/devicetree/bindings/net/mv643xx.txt b/Documentation/devicetree/bindings/net/mv643xx.txt
new file mode 100644
index 0000000..2727f798
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mv643xx.txt
@@ -0,0 +1,75 @@
+mv643xx related nodes.
+
+marvell,mdio-mv643xx:
+
+Required properties:
+
+ - interrupts : <a> where a is the SMI interrupt number.
+ - reg : the base address and size of the controllers register space.
+
+Optional properties:
+ - shared_smi : on some chips, the second PHY is "shared", meaning it is
+	really accessed via the first SMI controller. It is passed in this
+	way due to the present structure of the driver, which requires the
+	base address for the MAC to be passed in via the SMI controllers
+	platform data.
+ - tx_csum_limit : on some devices, this option is required for proper
+	operation wrt. jumbo frames.
+
+
+Example:
+
+smi0: mdio at 72000 {
+	compatible = "marvell,mdio-mv643xx";
+	reg = <0x72000 0x4000>;
+	interrupts = <46>;
+	tx_csum_limit = <1600>;
+	status = "disabled";
+};
+
+smi1: mdio at 76000 {
+	compatible = "marvell,mdio-mv643xx";
+	reg = <0x76000 0x4000>;
+	interrupts = <47>;
+	shared_smi = <&smi0>;
+	tx_csum_limit = <1600>;
+	status = "disabled";
+};
+
+
+
+marvell,mv643xx-eth:
+
+Required properties:
+ - interrupts : the port interrupt number.
+ - mdio : phandle of the smi device as drescribed above
+
+Optional properties:
+ - port_number : the port number on this bus.
+ - phy_addr : the PHY address.
+ - reg : should match the mdio reg this device is attached to.
+	this is a required hack for now due to the way the
+	driver is constructed. This allows the device clock to be
+	kept running so that the MAC is not lost after boot.
+
+
+Example:
+
+egiga0 {
+	compatible = "marvell,mv643xx-eth";
+	reg = <0x72000 0x4000>;
+	mdio = <&smi0>;
+	port_number = <0>;
+	phy_addr = <0x80>;
+	interrupts = <11>;
+};
+
+egiga1 {
+	compatible = "marvell,mv643xx-eth";
+	reg = <0x76000 0x4000>;
+	mdio = <&smi1>;
+	port_number = <0>;
+	phy_addr = <0x81>;
+	interrupts = <15>;
+};
+
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 84c1326..7048d7c 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -48,6 +48,9 @@
 #include <linux/ethtool.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -2586,7 +2589,7 @@ static void infer_hw_params(struct mv643xx_eth_shared_private *msp)
 static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 {
 	static int mv643xx_eth_version_printed;
-	struct mv643xx_eth_shared_platform_data *pd = pdev->dev.platform_data;
+	struct mv643xx_eth_shared_platform_data *pd;
 	struct mv643xx_eth_shared_private *msp;
 	const struct mbus_dram_target_info *dram;
 	struct resource *res;
@@ -2610,6 +2613,26 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	if (msp->base == NULL)
 		goto out_free;
 
+	if (pdev->dev.of_node) {
+		struct device_node *np = NULL;
+
+		/* when all users of this driver use FDT, we can remove this */
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
+			goto out_free;
+		}
+
+		of_property_read_u32(pdev->dev.of_node,
+			"tx_csum_limit", &pd->tx_csum_limit);
+
+		np = of_parse_phandle(pdev->dev.of_node, "shared_smi", 0);
+		if (np)
+			pd->shared_smi = of_find_device_by_node(np);
+
+	} else {
+		pd = pdev->dev.platform_data;
+	}
 	/*
 	 * Set up and register SMI bus.
 	 */
@@ -2642,7 +2665,6 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res != NULL) {
 		int err;
-
 		err = request_irq(res->start, mv643xx_eth_err_irq,
 				  IRQF_SHARED, "mv643xx_eth", msp);
 		if (!err) {
@@ -2660,6 +2682,10 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 
 	msp->tx_csum_limit = (pd != NULL && pd->tx_csum_limit) ?
 					pd->tx_csum_limit : 9 * 1024;
+
+	if (pdev->dev.of_node)
+		kfree(pd);  /* If we created a fake pd, free it now */
+
 	infer_hw_params(msp);
 
 	platform_set_drvdata(pdev, msp);
@@ -2693,12 +2719,21 @@ static int mv643xx_eth_shared_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id mv_mdio_dt_ids[] __devinitdata = {
+	{ .compatible = "marvell,mdio-mv643xx", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mv_mdio_dt_ids);
+#endif
+
 static struct platform_driver mv643xx_eth_shared_driver = {
 	.probe		= mv643xx_eth_shared_probe,
 	.remove		= mv643xx_eth_shared_remove,
 	.driver = {
 		.name	= MV643XX_ETH_SHARED_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mv_mdio_dt_ids),
 	},
 };
 
@@ -2858,7 +2893,36 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	struct resource *res;
 	int err;
 
-	pd = pdev->dev.platform_data;
+	if (pdev->dev.of_node) {
+		struct device_node *np = NULL;
+
+		/* when all users of this driver use FDT, we can remove this */
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
+			return -ENOMEM;
+		}
+
+		of_property_read_u32(pdev->dev.of_node,
+			"port_number", &pd->port_number);
+
+		if (!of_property_read_u32(pdev->dev.of_node,
+				"phy_addr", &pd->phy_addr))
+			pd->phy_addr = MV643XX_ETH_PHY_ADDR(pd->phy_addr);
+		else
+			pd->phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT;
+
+		np = of_parse_phandle(pdev->dev.of_node, "mdio", 0);
+		if (np) {
+			pd->shared = of_find_device_by_node(np);
+		} else {
+			kfree(pd);
+			return -ENODEV;
+		}
+	} else {
+		pd = pdev->dev.platform_data;
+	}
+
 	if (pd == NULL) {
 		dev_err(&pdev->dev, "no mv643xx_eth_platform_data\n");
 		return -ENODEV;
@@ -2866,12 +2930,15 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 
 	if (pd->shared == NULL) {
 		dev_err(&pdev->dev, "no mv643xx_eth_platform_data->shared\n");
-		return -ENODEV;
+		err = -ENODEV;
+		goto out_free_pd;
 	}
 
 	dev = alloc_etherdev_mq(sizeof(struct mv643xx_eth_private), 8);
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		err = -ENOMEM;
+		goto out_free_pd;
+	}
 
 	mp = netdev_priv(dev);
 	platform_set_drvdata(pdev, mp);
@@ -2908,6 +2975,8 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 
 	init_pscr(mp, pd->speed, pd->duplex);
 
+	if (pdev->dev.of_node)
+		kfree(pd); /* If we created a fake pd, free it now */
 
 	mib_counters_clear(mp);
 
@@ -2927,7 +2996,6 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	mp->rx_oom.data = (unsigned long)mp;
 	mp->rx_oom.function = oom_timer_wrapper;
 
-
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	BUG_ON(!res);
 	dev->irq = res->start;
@@ -2976,6 +3044,8 @@ out:
 	}
 #endif
 	free_netdev(dev);
+out_free_pd:
+	kfree(pd);
 
 	return err;
 }
@@ -3015,6 +3085,14 @@ static void mv643xx_eth_shutdown(struct platform_device *pdev)
 		port_reset(mp);
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id mv_eth_dt_ids[] __devinitdata = {
+	{ .compatible = "marvell,mv643xx-eth", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mv_eth_dt_ids);
+#endif
+
 static struct platform_driver mv643xx_eth_driver = {
 	.probe		= mv643xx_eth_probe,
 	.remove		= mv643xx_eth_remove,
@@ -3022,6 +3100,7 @@ static struct platform_driver mv643xx_eth_driver = {
 	.driver = {
 		.name	= MV643XX_ETH_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mv_eth_dt_ids),
 	},
 };
 
-- 
1.8.1.1
