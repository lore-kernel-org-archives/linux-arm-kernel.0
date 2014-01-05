From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  6 Jan 2014 00:04:39 +0100
Subject: [PATCH 1/2] ohci-platform: Add support for devicetree instantiation
Message-ID: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for ohci-platform instantiation from devicetree, including
optionally getting clks and a phy from devicetree, and enabling / disabling
those on power_on / off.

This should allow using ohci-platform from devicetree in various cases.
Specifically after this commit it can be used for the ohci controller found
on Allwinner sunxi SoCs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/usb/platform-ohci.txt      |  25 ++++
 drivers/usb/host/ohci-platform.c                   | 146 ++++++++++++++++++---
 2 files changed, 151 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/platform-ohci.txt

diff --git a/Documentation/devicetree/bindings/usb/platform-ohci.txt b/Documentation/devicetree/bindings/usb/platform-ohci.txt
new file mode 100644
index 0000000..6846f1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/platform-ohci.txt
@@ -0,0 +1,25 @@
+Generic Platform OHCI controller
+
+Required properties:
+ - compatible: Should be "platform-ohci"
+ - reg: Address range of the ohci registers.
+ - interrupts: Should contain the ohci interrupt.
+
+Optional properties:
+ - clocks: array of clocks
+ - clock-names: clock names "ahb" and/or "ohci"
+ - phys: phy
+ - phy-names: "usb_phy"
+
+Example:
+
+	ohci0: ohci at 0x01c14400 {
+		compatible = "platform-ohci";
+		reg = <0x01c14400 0x100>;
+		interrupts = <0 64 4>;
+		clocks = <&ahb_gates 2>, <&usb_clk 6>;
+		clock-names = "ahb", "ohci";
+		phys = <&usbphy 1>;
+		phy-names = "usb_phy";
+		status = "disabled";
+	};
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index f351ff5..b7abb44 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -14,11 +14,14 @@
  * Licensed under the GNU/GPL. See COPYING for details.
  */
 
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/usb.h>
@@ -28,6 +31,12 @@
 
 #define DRIVER_DESC "OHCI generic platform driver"
 
+struct ohci_platform_priv {
+	struct clk *ahb_clk;
+	struct clk *ohci_clk;
+	struct phy *phy;
+};
+
 static const char hcd_name[] = "ohci-platform";
 
 static int ohci_platform_reset(struct usb_hcd *hcd)
@@ -48,11 +57,79 @@ static int ohci_platform_reset(struct usb_hcd *hcd)
 	return ohci_setup(hcd);
 }
 
+static int ohci_platform_power_on(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ohci_platform_priv *priv =
+		(struct ohci_platform_priv *)hcd_to_ohci(hcd)->priv;
+	int ret;
+
+	if (!IS_ERR(priv->ohci_clk)) {
+		ret = clk_prepare_enable(priv->ohci_clk);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(priv->ahb_clk)) {
+		ret = clk_prepare_enable(priv->ahb_clk);
+		if (ret)
+			goto err_disable_ohci_clk;
+	}
+
+	if (!IS_ERR(priv->phy)) {
+		ret = phy_init(priv->phy);
+		if (ret)
+			goto err_disable_ahb_clk;
+
+		ret = phy_power_on(priv->phy);
+		if (ret)
+			goto err_exit_phy;
+	}
+
+	return 0;
+
+err_exit_phy:
+	phy_exit(priv->phy);
+err_disable_ahb_clk:
+	if (!IS_ERR(priv->ahb_clk))
+		clk_disable_unprepare(priv->ahb_clk);
+err_disable_ohci_clk:
+	if (!IS_ERR(priv->ohci_clk))
+		clk_disable_unprepare(priv->ohci_clk);
+
+	return ret;
+}
+
+static void ohci_platform_power_off(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ohci_platform_priv *priv =
+		(struct ohci_platform_priv *)hcd_to_ohci(hcd)->priv;
+
+	if (!IS_ERR(priv->phy)) {
+		phy_power_off(priv->phy);
+		phy_exit(priv->phy);
+	}
+
+	if (!IS_ERR(priv->ahb_clk))
+		clk_disable_unprepare(priv->ahb_clk);
+
+	if (!IS_ERR(priv->ohci_clk))
+		clk_disable_unprepare(priv->ohci_clk);
+}
+
 static struct hc_driver __read_mostly ohci_platform_hc_driver;
 
 static const struct ohci_driver_overrides platform_overrides __initconst = {
-	.product_desc =	"Generic Platform OHCI controller",
-	.reset =	ohci_platform_reset,
+	.product_desc =		"Generic Platform OHCI controller",
+	.reset =		ohci_platform_reset,
+	.extra_priv_size =	sizeof(struct ohci_platform_priv),
+};
+
+static struct usb_ohci_pdata ohci_platform_defaults = {
+	.power_on =		ohci_platform_power_on,
+	.power_suspend =	ohci_platform_power_off,
+	.power_off =		ohci_platform_power_off,
 };
 
 static int ohci_platform_probe(struct platform_device *dev)
@@ -60,12 +137,23 @@ static int ohci_platform_probe(struct platform_device *dev)
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
 	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
-	int irq;
-	int err = -ENOMEM;
+	int irq, err;
 
+	/*
+	 * use reasonable defaults so platforms don't have to provide these.
+	 * with DT probing on ARM.
+	 */
 	if (!pdata) {
-		WARN_ON(1);
-		return -ENODEV;
+		pdata = dev->dev.platform_data = &ohci_platform_defaults;
+		/*
+		 * Right now device-tree probed devices don't get dma_mask set.
+		 * Since shared usb code relies on it, set it here for now.
+		 * Once we have dma capability bindings this can go away.
+		 */
+		err = dma_coerce_mask_and_coherent(&dev->dev,
+						   DMA_BIT_MASK(32));
+		if (err)
+			return err;
 	}
 
 	if (usb_disabled())
@@ -83,17 +171,30 @@ static int ohci_platform_probe(struct platform_device *dev)
 		return -ENXIO;
 	}
 
+	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
+			dev_name(&dev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	if (pdata == &ohci_platform_defaults) {
+		struct ohci_platform_priv *priv = (struct ohci_platform_priv *)
+						  hcd_to_ohci(hcd)->priv;
+
+		priv->phy = devm_phy_get(&dev->dev, "usb_phy");
+		if (IS_ERR(priv->phy) && PTR_ERR(priv->phy) == -EPROBE_DEFER) {
+			err = -EPROBE_DEFER;
+			goto err_put_hcd;
+		}
+
+		priv->ohci_clk = devm_clk_get(&dev->dev, "ohci");
+		priv->ahb_clk = devm_clk_get(&dev->dev, "ahb");
+	}
+
+	platform_set_drvdata(dev, hcd);
 	if (pdata->power_on) {
 		err = pdata->power_on(dev);
 		if (err < 0)
-			return err;
-	}
-
-	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
-			dev_name(&dev->dev));
-	if (!hcd) {
-		err = -ENOMEM;
-		goto err_power;
+			goto err_put_hcd;
 	}
 
 	hcd->rsrc_start = res_mem->start;
@@ -102,21 +203,19 @@ static int ohci_platform_probe(struct platform_device *dev)
 	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
-		goto err_put_hcd;
+		goto err_power;
 	}
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err)
-		goto err_put_hcd;
-
-	platform_set_drvdata(dev, hcd);
+		goto err_power;
 
 	return err;
 
-err_put_hcd:
-	usb_put_hcd(hcd);
 err_power:
 	if (pdata->power_off)
 		pdata->power_off(dev);
+err_put_hcd:
+	usb_put_hcd(hcd);
 
 	return err;
 }
@@ -178,6 +277,12 @@ static int ohci_platform_resume(struct device *dev)
 #define ohci_platform_resume	NULL
 #endif /* CONFIG_PM */
 
+static const struct of_device_id ohci_platform_ids[] = {
+	{ .compatible = "platform-ohci", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ohci_platform_ids);
+
 static const struct platform_device_id ohci_platform_table[] = {
 	{ "ohci-platform", 0 },
 	{ }
@@ -198,6 +303,7 @@ static struct platform_driver ohci_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "ohci-platform",
 		.pm	= &ohci_platform_pm_ops,
+		.of_match_table = ohci_platform_ids,
 	}
 };
 
-- 
1.8.4.2
