From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  6 Jan 2014 00:04:40 +0100
Subject: [PATCH 2/2] ehci-platform: Add support for clks and phy passed
 through devicetree
In-Reply-To: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
References: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1388963080-12544-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ehci-platform is only used in combination with devicetree when used
with some via socs. By extending it to (optionally) get clks and a phy from
devicetree, and enabling / disabling those on power_on / off, it can be used
more generically. Specifically after this commit it can be used for the
ehci controller on Allwinner sunxi SoCs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/usb/platform-ehci.txt      |  25 +++++
 .../devicetree/bindings/usb/vt8500-ehci.txt        |  12 --
 drivers/usb/host/ehci-platform.c                   | 125 +++++++++++++++++----
 3 files changed, 131 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/platform-ehci.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/vt8500-ehci.txt

diff --git a/Documentation/devicetree/bindings/usb/platform-ehci.txt b/Documentation/devicetree/bindings/usb/platform-ehci.txt
new file mode 100644
index 0000000..aba6da1
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/platform-ehci.txt
@@ -0,0 +1,25 @@
+Generic Platform EHCI controller
+
+Required properties:
+ - compatible: Should be "platform-ehci"
+   (legacy: via,vt8500-ehci" or "wm,prizm-ehci")
+ - reg: Address range of the ehci registers.
+ - interrupts: Should contain the ehci interrupt.
+
+Optional properties:
+ - clocks: array of clocks
+ - clock-names: clock names "ahb" and/or "ehci"
+ - phys: phy
+ - phy-names: "usb_phy"
+
+Example:
+
+usb: ehci at D8007100 {
+	compatible = "platform-ehci";
+	reg = <0xD8007100 0x200>;
+	interrupts = <1>;
+	clocks = <&ahb_gates 2>, <&usb_clk 6>;
+	clock-names = "ahb", "ehci";
+	phys = <&usbphy 1>;
+	phy-names = "usb_phy";
+};
diff --git a/Documentation/devicetree/bindings/usb/vt8500-ehci.txt b/Documentation/devicetree/bindings/usb/vt8500-ehci.txt
deleted file mode 100644
index 5fb8fd6..0000000
--- a/Documentation/devicetree/bindings/usb/vt8500-ehci.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-VIA VT8500 and Wondermedia WM8xxx SoC USB controllers.
-
-Required properties:
- - compatible: Should be "via,vt8500-ehci" or "wm,prizm-ehci".
- - reg: Address range of the ehci registers. size should be 0x200
- - interrupts: Should contain the ehci interrupt.
-
-usb: ehci at D8007100 {
-	compatible = "wm,prizm-ehci", "usb-ehci";
-	reg = <0xD8007100 0x200>;
-	interrupts = <1>;
-};
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 7f30b71..01d9a97 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -18,6 +18,7 @@
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -25,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -34,6 +36,12 @@
 
 #define DRIVER_DESC "EHCI generic platform driver"
 
+struct ehci_platform_priv {
+	struct clk *ahb_clk;
+	struct clk *ehci_clk;
+	struct phy *phy;
+};
+
 static const char hcd_name[] = "ehci-platform";
 
 static int ehci_platform_reset(struct usb_hcd *hcd)
@@ -64,13 +72,79 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	return 0;
 }
 
+static int ehci_platform_power_on(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ehci_platform_priv *priv =
+		(struct ehci_platform_priv *)hcd_to_ehci(hcd)->priv;
+	int ret;
+
+	if (!IS_ERR(priv->ehci_clk)) {
+		ret = clk_prepare_enable(priv->ehci_clk);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(priv->ahb_clk)) {
+		ret = clk_prepare_enable(priv->ahb_clk);
+		if (ret)
+			goto err_disable_ehci_clk;
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
+err_disable_ehci_clk:
+	if (!IS_ERR(priv->ehci_clk))
+		clk_disable_unprepare(priv->ehci_clk);
+
+	return ret;
+}
+
+static void ehci_platform_power_off(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ehci_platform_priv *priv =
+		(struct ehci_platform_priv *)hcd_to_ehci(hcd)->priv;
+
+	if (!IS_ERR(priv->phy)) {
+		phy_power_off(priv->phy);
+		phy_exit(priv->phy);
+	}
+
+	if (!IS_ERR(priv->ahb_clk))
+		clk_disable_unprepare(priv->ahb_clk);
+
+	if (!IS_ERR(priv->ehci_clk))
+		clk_disable_unprepare(priv->ehci_clk);
+}
+
 static struct hc_driver __read_mostly ehci_platform_hc_driver;
 
 static const struct ehci_driver_overrides platform_overrides __initconst = {
-	.reset =	ehci_platform_reset,
+	.reset =		ehci_platform_reset,
+	.extra_priv_size =	sizeof(struct ehci_platform_priv),
 };
 
-static struct usb_ehci_pdata ehci_platform_defaults;
+static struct usb_ehci_pdata ehci_platform_defaults = {
+	.power_on =		ehci_platform_power_on,
+	.power_suspend =	ehci_platform_power_off,
+	.power_off =		ehci_platform_power_off,
+};
 
 static int ehci_platform_probe(struct platform_device *dev)
 {
@@ -85,7 +159,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 	/*
 	 * use reasonable defaults so platforms don't have to provide these.
-	 * with DT probing on ARM, none of these are set.
+	 * with DT probing on ARM.
 	 */
 	if (!dev_get_platdata(&dev->dev))
 		dev->dev.platform_data = &ehci_platform_defaults;
@@ -107,17 +181,30 @@ static int ehci_platform_probe(struct platform_device *dev)
 		return -ENXIO;
 	}
 
+	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
+			     dev_name(&dev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	if (pdata == &ehci_platform_defaults) {
+		struct ehci_platform_priv *priv = (struct ehci_platform_priv *)
+						  hcd_to_ehci(hcd)->priv;
+
+		priv->phy = devm_phy_get(&dev->dev, "usb_phy");
+		if (IS_ERR(priv->phy) && PTR_ERR(priv->phy) == -EPROBE_DEFER) {
+			err = -EPROBE_DEFER;
+			goto err_put_hcd;
+		}
+
+		priv->ehci_clk = devm_clk_get(&dev->dev, "ehci");
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
-	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
-			     dev_name(&dev->dev));
-	if (!hcd) {
-		err = -ENOMEM;
-		goto err_power;
+			goto err_put_hcd;
 	}
 
 	hcd->rsrc_start = res_mem->start;
@@ -126,21 +213,19 @@ static int ehci_platform_probe(struct platform_device *dev)
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
@@ -203,11 +288,13 @@ static int ehci_platform_resume(struct device *dev)
 #define ehci_platform_resume	NULL
 #endif /* CONFIG_PM */
 
-static const struct of_device_id vt8500_ehci_ids[] = {
+static const struct of_device_id ehci_platform_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
 	{ .compatible = "wm,prizm-ehci", },
+	{ .compatible = "platform-ehci", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, ehci_platform_ids);
 
 static const struct platform_device_id ehci_platform_table[] = {
 	{ "ehci-platform", 0 },
@@ -229,7 +316,7 @@ static struct platform_driver ehci_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "ehci-platform",
 		.pm	= &ehci_platform_pm_ops,
-		.of_match_table = vt8500_ehci_ids,
+		.of_match_table = ehci_platform_ids,
 	}
 };
 
-- 
1.8.4.2
