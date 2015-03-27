From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 27 Mar 2015 07:36:29 +0300
Subject: [PATCH 2/2] phy: driver for Conexant Digicolor internal USB PHY
In-Reply-To: <6284a7672647d46100281959552f9787f98bb552.1427430989.git.baruch@tkos.co.il>
References: <6284a7672647d46100281959552f9787f98bb552.1427430989.git.baruch@tkos.co.il>
Message-ID: <4a9ceb0a240d49dd6a68d50c78f85d310d4b932f.1427430989.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a driver for the USB PHY on the Conexant CX92755 SoC, from the Digicolor
series of SoCs. The PHY is connected to the on-chip chipidea usb2 host.

The hardware is somewhat similar to the phy-mxs-usb.c usb_phy, but it is
different enough to merit its own driver. Also, this driver uses the generic
phy infrastructure.

Cc: Marek Vasut <marex@denx.de>
Cc: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/phy/Kconfig             |   9 ++
 drivers/phy/Makefile            |   1 +
 drivers/phy/phy-digicolor-usb.c | 209 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/phy/phy-digicolor-usb.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2962de205ba7..9589056ef5c7 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -291,4 +291,13 @@ config PHY_QCOM_UFS
 	help
 	  Support for UFS PHY on QCOM chipsets.
 
+config PHY_DIGICOLOR_USB
+	tristate "Conexant Digicolor USB2 PHY Driver"
+	depends on ARCH_DIGICOLOR
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this to support the USB 2.0 PHY that is part of Conexant
+	  Digicolor SoC series.
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f080e1bb2a74..392cb60d0240 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_PHY_STIH41X_USB)		+= phy-stih41x-usb.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
+obj-$(CONFIG_PHY_DIGICOLOR_USB)	+= phy-digicolor-usb.o
diff --git a/drivers/phy/phy-digicolor-usb.c b/drivers/phy/phy-digicolor-usb.c
new file mode 100644
index 000000000000..a1d7503530a0
--- /dev/null
+++ b/drivers/phy/phy-digicolor-usb.c
@@ -0,0 +1,209 @@
+/*
+ * Conexant Digicolor Integrated USB PHY driver
+ *
+ * Copyright (C) 2014, 2015 Paradox Innovation Ltd.
+ *
+ * Author: Baruch Siach <baruch@tkos.co.il>
+ *
+ * Based on phy-mxs-usb.c.
+ *
+ * Copyright 2012-2014 Freescale Semiconductor, Inc.
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ * on behalf of DENX Software Engineering GmbH
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/phy.h>
+
+#define DRIVER_NAME "digicolor_usb_phy"
+
+#define HW_USBPHY_PWD				0x00
+#define HW_USBPHY_TX				0x10
+#define HW_USBPHY_CTRL				0x30
+#define HW_USBPHY_CTRL_SET			0x34
+#define HW_USBPHY_CTRL_CLR			0x38
+
+#define HW_USBPHY_DEBUG				0x50
+
+#define HW_USBPHY_IP				0x90
+#define HW_USBPHY_IP_SET			0x94
+#define HW_USBPHY_IP_CLR			0x98
+
+#define BM_USBPHY_CTRL_SFTRST			BIT(31)
+#define BM_USBPHY_CTRL_CLKGATE			BIT(30)
+#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
+
+#define BM_USBPHY_IP_EN_USB_CLKS		BIT(2)
+#define BM_USBPHY_IP_PLL_LOCKED			BIT(1)
+#define BM_USBPHY_IP_PLL_POWER			BIT(0)
+
+struct dc_usb_phy {
+	struct usb_phy	phy;
+	struct device	*dev;
+	void __iomem	*regs;
+};
+
+static int digicolor_phy_init(struct phy *gphy)
+{
+	struct dc_usb_phy *phy = phy_get_drvdata(gphy);
+
+	/* Disable PLL */
+	writel(BM_USBPHY_IP_EN_USB_CLKS, phy->regs + HW_USBPHY_IP_CLR);
+	udelay(250);
+	writel(BM_USBPHY_IP_PLL_LOCKED, phy->regs + HW_USBPHY_IP_CLR);
+	udelay(250);
+	writel(BM_USBPHY_IP_PLL_POWER, phy->regs + HW_USBPHY_IP_CLR);
+	udelay(250);
+
+	/* Reset PHY */
+	writel(BM_USBPHY_CTRL_SFTRST, phy->regs + HW_USBPHY_CTRL_SET);
+	udelay(1000);
+	writel(BM_USBPHY_CTRL_SFTRST, phy->regs + HW_USBPHY_CTRL_CLR);
+	udelay(1000);
+
+	/* Enable PHY clock */
+	writel(BM_USBPHY_CTRL_CLKGATE, phy->regs + HW_USBPHY_CTRL_CLR);
+	udelay(250);
+
+	/* Enable PLL */
+	writel(BM_USBPHY_IP_PLL_POWER, phy->regs + HW_USBPHY_IP_SET);
+	udelay(250);
+	writel(BM_USBPHY_IP_PLL_LOCKED, phy->regs + HW_USBPHY_IP_SET);
+	udelay(250);
+	writel(BM_USBPHY_IP_EN_USB_CLKS, phy->regs + HW_USBPHY_IP_SET);
+	udelay(250);
+
+	/* Power PHY up */
+	writel(0, phy->regs + HW_USBPHY_PWD);
+	udelay(250);
+
+	/* Set resistors parameters (power up default values) */
+	writel(0x10060607, phy->regs + HW_USBPHY_TX);
+	writel(0x7f180000, phy->regs + HW_USBPHY_DEBUG);
+
+	return 0;
+}
+
+static int digicolor_phy_shutdown(struct phy *gphy)
+{
+	struct dc_usb_phy *phy = phy_get_drvdata(gphy);
+
+	writel(BM_USBPHY_CTRL_CLKGATE, phy->regs + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static struct phy_ops dc_usb_phy_ops = {
+	.owner		= THIS_MODULE,
+	.init		= digicolor_phy_init,
+	.power_off	= digicolor_phy_shutdown,
+};
+
+static int digicolor_phy_on_connect(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	dev_dbg(phy->dev, "%s device has connected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
+
+	if (speed == USB_SPEED_HIGH)
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+		       phy->io_priv + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static int digicolor_phy_on_disconnect(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	dev_dbg(phy->dev, "%s device has disconnected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
+
+	if (speed == USB_SPEED_HIGH)
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+		       phy->io_priv + HW_USBPHY_CTRL_CLR);
+
+	return 0;
+}
+
+static int digicolor_phy_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct dc_usb_phy *phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(phy->regs))
+		return PTR_ERR(phy->regs);
+
+	phy->dev		= &pdev->dev;
+
+	phy->phy.io_priv	= phy->regs;
+	phy->phy.dev		= &pdev->dev;
+	phy->phy.label		= DRIVER_NAME;
+	phy->phy.notify_connect	= digicolor_phy_on_connect;
+	phy->phy.notify_disconnect = digicolor_phy_on_disconnect;
+	phy->phy.type		= USB_PHY_TYPE_USB2;
+
+	platform_set_drvdata(pdev, phy);
+
+	generic_phy = devm_phy_create(phy->dev, NULL, &dc_usb_phy_ops);
+	if (IS_ERR(generic_phy))
+		return PTR_ERR(generic_phy);
+	phy_set_drvdata(generic_phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(phy->dev,
+						     of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	return usb_add_phy_dev(&phy->phy);
+}
+
+static int digicolor_phy_remove(struct platform_device *pdev)
+{
+	struct dc_usb_phy *phy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&phy->phy);
+
+	return 0;
+}
+
+static const struct of_device_id digicolor_phy_dt_ids[] = {
+	{ .compatible = "cnxt,cx92755-usbphy", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, digicolor_phy_dt_ids);
+
+static struct platform_driver digicolor_phy_driver = {
+	.probe = digicolor_phy_probe,
+	.remove = digicolor_phy_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = digicolor_phy_dt_ids,
+	 },
+};
+module_platform_driver(digicolor_phy_driver);
+
+MODULE_ALIAS("platform:digicolor-usb-phy");
+MODULE_DESCRIPTION("Conexant Digicolor Internal USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.1.4
