From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  8 Jan 2014 17:30:08 +0100
Subject: [PATCH v2 2/2] ehci-platform: Add support for clks and phy passed
 through devicetree
In-Reply-To: <1389198608-24339-1-git-send-email-hdegoede@redhat.com>
References: <1389198608-24339-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1389198608-24339-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ehci-platform is only used in combination with devicetree when used
with some via socs. By extending it to (optionally) get clks and a phy from
devicetree, and enabling / disabling those on power_on / off, it can be used
more generically. Specifically after this commit it can be used for the
ehci controller on Allwinner sunxi SoCs.

Somehow we've ended up with 2 device-bindings documents for ehci-platform.c,
this patch renames and updates one to platform-ehci.txt to reflect that this
is a generic platform driver, and removes the other.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/usb/platform-ehci.txt      |  25 ++++
 .../devicetree/bindings/usb/via,vt8500-ehci.txt    |  15 ---
 .../devicetree/bindings/usb/vt8500-ehci.txt        |  12 --
 drivers/usb/host/ehci-platform.c                   | 126 +++++++++++++++++----
 4 files changed, 131 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/platform-ehci.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/vt8500-ehci.txt

diff --git a/Documentation/devicetree/bindings/usb/platform-ehci.txt b/Documentation/devicetree/bindings/usb/platform-ehci.txt
new file mode 100644
index 0000000..56c478d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/platform-ehci.txt
@@ -0,0 +1,25 @@
+Generic Platform EHCI controller
+
+Required properties:
+- compatible : "via,vt8500-ehci" or "wm,prizm-ehci"
+- reg : ehci controller register range (address and length)
+- interrupts : ehci controller interrupt
+
+Optional properties:
+- clocks : a list of phandle + clock specifier pairs, one for each entry
+   in clock-names.
+- clock-names : "clk0", "clk1", ...
+- phys : phy
+- phy-names : "phy0"
+
+Example:
+
+	ehci at d8007900 {
+		compatible = "via,vt8500-ehci";
+		reg = <0xd8007900 0x200>;
+		interrupts = <43>;
+		clocks = <&usb_clk 6>, <&ahb_gates 2>;
+		clock-names = "clk0", "clk1";
+		phys = <&usbphy 1>;
+		phy-names = "phy0";
+	};
diff --git a/Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt b/Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
deleted file mode 100644
index 17b3ad1..0000000
--- a/Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-VIA/Wondermedia VT8500 EHCI Controller
------------------------------------------------------
-
-Required properties:
-- compatible : "via,vt8500-ehci"
-- reg : Should contain 1 register ranges(address and length)
-- interrupts : ehci controller interrupt
-
-Example:
-
-	ehci at d8007900 {
-		compatible = "via,vt8500-ehci";
-		reg = <0xd8007900 0x200>;
-		interrupts = <43>;
-	};
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
index 7f30b71..ce76659 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -3,6 +3,7 @@
  *
  * Copyright 2007 Steven Brown <sbrown@cortland.com>
  * Copyright 2010-2012 Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
  *
  * Derived from the ohci-ssb driver
  * Copyright 2007 Michael Buesch <m@bues.ch>
@@ -18,6 +19,7 @@
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -25,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -34,6 +37,12 @@
 
 #define DRIVER_DESC "EHCI generic platform driver"
 
+#define EHCI_MAX_CLKS 3
+struct ehci_platform_priv {
+	struct clk *clks[EHCI_MAX_CLKS];
+	struct phy *phy;
+};
+
 static const char hcd_name[] = "ehci-platform";
 
 static int ehci_platform_reset(struct usb_hcd *hcd)
@@ -64,28 +73,84 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	return 0;
 }
 
+static int ehci_platform_power_on(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ehci_platform_priv *priv =
+		(struct ehci_platform_priv *)hcd_to_ehci(hcd)->priv;
+	int clk, ret;
+
+	for (clk = 0; priv->clks[clk] && clk < EHCI_MAX_CLKS; clk++) {
+		ret = clk_prepare_enable(priv->clks[clk]);
+		if (ret)
+			goto err_disable_clks;
+	}
+
+	if (priv->phy) {
+		ret = phy_init(priv->phy);
+		if (ret)
+			goto err_disable_clks;
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
+err_disable_clks:
+	while (--clk >= 0)
+		clk_disable_unprepare(priv->clks[clk]);
+
+	return ret;
+}
+
+static void ehci_platform_power_off(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ehci_platform_priv *priv =
+		(struct ehci_platform_priv *)hcd_to_ehci(hcd)->priv;
+	int clk;
+
+	if (priv->phy) {
+		phy_power_off(priv->phy);
+		phy_exit(priv->phy);
+	}
+
+	for (clk = EHCI_MAX_CLKS - 1; clk >= 0; clk--)
+		if (priv->clks[clk])
+			clk_disable_unprepare(priv->clks[clk]);
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
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata;
-	int irq;
-	int err;
+	int clk, irq, err;
+	char name[8];
 
 	if (usb_disabled())
 		return -ENODEV;
 
 	/*
-	 * use reasonable defaults so platforms don't have to provide these.
-	 * with DT probing on ARM, none of these are set.
+	 * Use reasonable defaults so platforms don't have to provide these
+	 * with DT probing on ARM.
 	 */
 	if (!dev_get_platdata(&dev->dev))
 		dev->dev.platform_data = &ehci_platform_defaults;
@@ -107,17 +172,40 @@ static int ehci_platform_probe(struct platform_device *dev)
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
+		priv->phy = devm_phy_get(&dev->dev, "phy0");
+		if (IS_ERR(priv->phy)) {
+			err = PTR_ERR(priv->phy);
+			if (err == -EPROBE_DEFER)
+				goto err_put_hcd;
+			priv->phy = NULL;
+		}
+
+		for (clk = 0; clk < EHCI_MAX_CLKS; clk++) {
+			snprintf(name, sizeof(name), "clk%d", clk);
+			priv->clks[clk] = devm_clk_get(&dev->dev, name);
+			if (IS_ERR(priv->clks[clk])) {
+				err = PTR_ERR(priv->clks[clk]);
+				if (err == -EPROBE_DEFER)
+					goto err_put_hcd;
+				priv->clks[clk] = NULL;
+			}
+		}
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
@@ -126,21 +214,19 @@ static int ehci_platform_probe(struct platform_device *dev)
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
-- 
1.8.4.2
