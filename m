From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 9 Dec 2013 17:17:04 -0500
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
Message-ID: <1386627424-373-3-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Keystone platform USB PHY driver support. Current main purpose
of this driver is to enable the PHY reference clock gate on the
Keystone SoC. Otherwise it is a nop PHY.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 drivers/usb/phy/Kconfig        |   10 +++
 drivers/usb/phy/Makefile       |    1 +
 drivers/usb/phy/phy-keystone.c |  142 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/usb/phy/phy-keystone.c

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 08e2f39..c6792f43 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -40,6 +40,16 @@ config ISP1301_OMAP
 	  This driver can also be built as a module.  If so, the module
 	  will be called isp1301_omap.
 
+config KEYSTONE_USB_PHY
+	tristate "Keystone USB PHY Driver"
+	depends on ARCH_KEYSTONE
+	select USB_PHY
+	select NOP_USB_XCEIV
+	help
+	  Enable this to support Keystone USB phy. This driver provides
+	  interface to interact with USB 2.0 and USB 3.0 PHY that is part
+	  of the Keystone SOC.
+
 config MV_U3D_PHY
 	bool "Marvell USB 3.0 PHY controller Driver"
 	depends on CPU_MMP3
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 022c1da..311b47b 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_USB_RCAR_PHY)		+= phy-rcar-usb.o
 obj-$(CONFIG_USB_RCAR_GEN2_PHY)		+= phy-rcar-gen2-usb.o
 obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
+obj-$(CONFIG_KEYSTONE_USB_PHY)		+= phy-keystone.o
diff --git a/drivers/usb/phy/phy-keystone.c b/drivers/usb/phy/phy-keystone.c
new file mode 100644
index 0000000..e025eb2
--- /dev/null
+++ b/drivers/usb/phy/phy-keystone.c
@@ -0,0 +1,142 @@
+/*
+ * phy-keystone - USB PHY, talking to dwc3 controller in Keystone.
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Author: WingMan Kwok <w-kwok2@ti.com>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include "phy-generic.h"
+
+/* USB PHY control register offsets */
+#define USB_PHY_CTL_UTMI		0x0000
+#define USB_PHY_CTL_PIPE		0x0004
+#define USB_PHY_CTL_PARAM_1		0x0008
+#define USB_PHY_CTL_PARAM_2		0x000c
+#define USB_PHY_CTL_CLOCK		0x0010
+#define USB_PHY_CTL_PLL			0x0014
+
+#define PHY_REF_SSP_EN			BIT(29)
+
+struct keystone_usbphy {
+	struct usb_phy_gen_xceiv	usb_phy_gen;
+	void __iomem			*phy_ctrl;
+};
+
+static inline u32 keystone_usbphy_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static inline void keystone_usbphy_writel(void __iomem *base,
+					  u32 offset, u32 value)
+{
+	writel(value, base + offset);
+}
+
+static int keystone_usbphy_init(struct usb_phy *phy)
+{
+	struct keystone_usbphy *k_phy = dev_get_drvdata(phy->dev);
+	u32 val;
+
+	val  = keystone_usbphy_readl(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK);
+	keystone_usbphy_writel(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK,
+				val | PHY_REF_SSP_EN);
+	udelay(20);
+	return 0;
+}
+
+static void keystone_usbphy_shutdown(struct usb_phy *phy)
+{
+	struct keystone_usbphy *k_phy = dev_get_drvdata(phy->dev);
+	u32 val;
+
+	val  = keystone_usbphy_readl(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK);
+	keystone_usbphy_writel(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK,
+				val &= ~PHY_REF_SSP_EN);
+}
+
+static int keystone_usbphy_probe(struct platform_device *pdev)
+{
+	struct device		*dev = &pdev->dev;
+	struct keystone_usbphy	*k_phy;
+	struct resource		*res;
+	int ret;
+
+	k_phy = devm_kzalloc(dev, sizeof(*k_phy), GFP_KERNEL);
+	if (!k_phy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing usb phy resource\n");
+		return -EINVAL;
+	}
+
+	k_phy->phy_ctrl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(k_phy->phy_ctrl))
+		return PTR_ERR(k_phy->phy_ctrl);
+
+	ret = usb_phy_gen_create_phy(dev, &k_phy->usb_phy_gen,
+			USB_PHY_TYPE_USB2, 0, false);
+	if (ret)
+		return ret;
+
+	ret = usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
+	if (ret)
+		return ret;
+	k_phy->usb_phy_gen.phy.init = keystone_usbphy_init;
+	k_phy->usb_phy_gen.phy.shutdown = keystone_usbphy_shutdown;
+
+	platform_set_drvdata(pdev, k_phy);
+
+	return 0;
+}
+
+static int keystone_usbphy_remove(struct platform_device *pdev)
+{
+	struct keystone_usbphy *k_phy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&k_phy->usb_phy_gen.phy);
+
+	return 0;
+}
+
+static const struct of_device_id keystone_usbphy_ids[] = {
+	{ .compatible = "ti,keystone-usbphy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, keystone_usbphy_ids);
+
+static struct platform_driver keystone_usbphy_driver = {
+	.probe          = keystone_usbphy_probe,
+	.remove         = keystone_usbphy_remove,
+	.driver         = {
+		.name   = "keystone-usbphy",
+		.owner  = THIS_MODULE,
+		.of_match_table = of_match_ptr(keystone_usbphy_ids),
+	},
+};
+
+module_platform_driver(keystone_usbphy_driver);
+
+MODULE_ALIAS("platform: keystone-usbphy");
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("Keystone USB phy driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
