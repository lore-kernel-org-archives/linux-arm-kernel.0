From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 12 Oct 2012 15:45:34 +0530
Subject: [PATCH] usb: phy: samsung: Introducing usb phy driver for hsotg
In-Reply-To: <1349256393-11741-1-git-send-email-p.paneri@samsung.com>
References: <1349256393-11741-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1350036934-6051-1-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_set_drvdata() required for driver's remove function, so adding
it back.

>From v6:
Added TODO for phy bindings with controller
Dropped platform_set_drvdata() from driver probe

This driver uses usb_phy interface to interact with s3c-hsotg. Supports
phy_init and phy_shutdown functions to enable/disable phy. Tested with
smdk6410 and smdkv310. More SoCs can be brought under later.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/usb/samsung-usbphy.txt     |   11 +
 drivers/usb/phy/Kconfig                            |    8 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/samsung-usbphy.c                   |  357 ++++++++++++++++++++
 include/linux/platform_data/samsung-usbphy.h       |   27 ++
 5 files changed, 404 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung-usbphy.txt
 create mode 100644 drivers/usb/phy/samsung-usbphy.c
 create mode 100644 include/linux/platform_data/samsung-usbphy.h

diff --git a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
new file mode 100644
index 0000000..7b26e2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
@@ -0,0 +1,11 @@
+* Samsung's usb phy transceiver
+
+The Samsung's phy transceiver is used for controlling usb otg phy for
+s3c-hsotg usb device controller.
+TODO: Adding the PHY binding with controller(s) according to the under
+developement generic PHY driver.
+
+Required properties:
+- compatible : should be "samsung,exynos4210-usbphy"
+- reg : base physical address of the phy registers and length of memory mapped
+	region.
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 63c339b..313685f 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -32,3 +32,11 @@ config MV_U3D_PHY
 	help
 	  Enable this to support Marvell USB 3.0 phy controller for Marvell
 	  SoC.
+
+config SAMSUNG_USBPHY
+	bool "Samsung USB PHY controller Driver"
+	depends on USB_S3C_HSOTG
+	select USB_OTG_UTILS
+	help
+	  Enable this to support Samsung USB phy controller for samsung
+	  SoCs.
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index b069f29..55dcfc1 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_OMAP_USB2)			+= omap-usb2.o
 obj-$(CONFIG_USB_ISP1301)		+= isp1301.o
 obj-$(CONFIG_MV_U3D_PHY)		+= mv_u3d_phy.o
 obj-$(CONFIG_USB_EHCI_TEGRA)	+= tegra_usb_phy.o
+obj-$(CONFIG_SAMSUNG_USBPHY)		+= samsung-usbphy.o
diff --git a/drivers/usb/phy/samsung-usbphy.c b/drivers/usb/phy/samsung-usbphy.c
new file mode 100644
index 0000000..14c182f
--- /dev/null
+++ b/drivers/usb/phy/samsung-usbphy.c
@@ -0,0 +1,357 @@
+/* linux/drivers/usb/phy/samsung-usbphy.c
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * Author: Praveen Paneri <p.paneri@samsung.com>
+ *
+ * Samsung USB2.0 High-speed OTG transceiver, talks to S3C HS OTG controller
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/usb/otg.h>
+#include <linux/platform_data/samsung-usbphy.h>
+
+/* Register definitions */
+
+#define S3C_PHYPWR				(0x00)
+
+#define S3C_PHYPWR_NORMAL_MASK			(0x19 << 0)
+#define S3C_PHYPWR_OTG_DISABLE			(1 << 4)
+#define S3C_PHYPWR_ANALOG_POWERDOWN		(1 << 3)
+#define S3C_PHYPWR_FORCE_SUSPEND		(1 << 1)
+/* For Exynos4 */
+#define EXYNOS4_PHYPWR_NORMAL_MASK		(0x39 << 0)
+#define EXYNOS4_PHYPWR_SLEEP			(1 << 5)
+
+#define S3C_PHYCLK				(0x04)
+
+#define S3C_PHYCLK_MODE_SERIAL			(1 << 6)
+#define S3C_PHYCLK_EXT_OSC			(1 << 5)
+#define S3C_PHYCLK_COMMON_ON_N			(1 << 4)
+#define S3C_PHYCLK_ID_PULL			(1 << 2)
+#define S3C_PHYCLK_CLKSEL_MASK			(0x3 << 0)
+#define S3C_PHYCLK_CLKSEL_SHIFT			(0)
+#define S3C_PHYCLK_CLKSEL_48M			(0x0 << 0)
+#define S3C_PHYCLK_CLKSEL_12M			(0x2 << 0)
+#define S3C_PHYCLK_CLKSEL_24M			(0x3 << 0)
+
+#define S3C_RSTCON				(0x08)
+
+#define S3C_RSTCON_PHYCLK			(1 << 2)
+#define S3C_RSTCON_HCLK				(1 << 1)
+#define S3C_RSTCON_PHY				(1 << 0)
+
+#ifndef MHZ
+#define MHZ (1000*1000)
+#endif
+
+enum samsung_cpu_type {
+	TYPE_S3C64XX,
+	TYPE_EXYNOS4210,
+};
+
+/*
+ * struct samsung_usbphy - transceiver driver state
+ * @phy: transceiver structure
+ * @plat: platform data
+ * @dev: The parent device supplied to the probe function
+ * @clk: usb phy clock
+ * @regs: usb phy register memory base
+ * @ref_clk_freq: reference clock frequency selection
+ * @cpu_type: machine identifier
+ */
+struct samsung_usbphy {
+	struct usb_phy	phy;
+	struct samsung_usbphy_data *plat;
+	struct device	*dev;
+	struct clk	*clk;
+	void __iomem	*regs;
+	int		ref_clk_freq;
+	int		cpu_type;
+};
+
+#define phy_to_sphy(x)		container_of((x), struct samsung_usbphy, phy)
+
+/*
+ * Returns reference clock frequency selection value
+ */
+static int samsung_usbphy_get_refclk_freq(struct samsung_usbphy *sphy)
+{
+	struct clk *ref_clk;
+	int refclk_freq = 0;
+
+	ref_clk = clk_get(sphy->dev, "xusbxti");
+	if (IS_ERR(ref_clk)) {
+		dev_err(sphy->dev, "Failed to get reference clock\n");
+		return PTR_ERR(ref_clk);
+	}
+
+	switch (clk_get_rate(ref_clk)) {
+	case 12 * MHZ:
+		refclk_freq |= S3C_PHYCLK_CLKSEL_12M;
+		break;
+	case 24 * MHZ:
+		refclk_freq |= S3C_PHYCLK_CLKSEL_24M;
+		break;
+	default:
+	case 48 * MHZ:
+		/* default reference clock */
+		refclk_freq |= S3C_PHYCLK_CLKSEL_48M;
+		break;
+	}
+	clk_put(ref_clk);
+
+	return refclk_freq;
+}
+
+static void samsung_usbphy_enable(struct samsung_usbphy *sphy)
+{
+	void __iomem *regs = sphy->regs;
+	u32 phypwr;
+	u32 phyclk;
+	u32 rstcon;
+
+	/* set clock frequency for PLL */
+	phyclk = sphy->ref_clk_freq;
+	phypwr = readl(regs + S3C_PHYPWR);
+	rstcon = readl(regs + S3C_RSTCON);
+
+	switch (sphy->cpu_type) {
+	case TYPE_S3C64XX:
+		phyclk &= ~(S3C_PHYCLK_COMMON_ON_N);
+		phypwr &= ~S3C_PHYPWR_NORMAL_MASK;
+		rstcon |= S3C_RSTCON_PHY;
+		break;
+	case TYPE_EXYNOS4210:
+		phypwr &= ~EXYNOS4_PHYPWR_NORMAL_MASK;
+		rstcon |= S3C_RSTCON_PHY;
+	default:
+		break;
+	}
+
+	writel(phyclk, regs + S3C_PHYCLK);
+	/* set to normal of PHY0 */
+	writel(phypwr, regs + S3C_PHYPWR);
+	/* reset all ports of PHY and Link */
+	writel(rstcon, regs + S3C_RSTCON);
+	udelay(10);
+	rstcon &= ~S3C_RSTCON_PHY;
+	writel(rstcon, regs + S3C_RSTCON);
+}
+
+static void samsung_usbphy_disable(struct samsung_usbphy *sphy)
+{
+	void __iomem *regs = sphy->regs;
+	u32 phypwr;
+
+	phypwr = readl(regs + S3C_PHYPWR);
+
+	switch (sphy->cpu_type) {
+	case TYPE_S3C64XX:
+		phypwr |= S3C_PHYPWR_NORMAL_MASK;
+		break;
+	case TYPE_EXYNOS4210:
+		phypwr |= EXYNOS4_PHYPWR_NORMAL_MASK;
+	default:
+		break;
+	}
+
+	/* unset to normal of PHY0 */
+	writel(phypwr, regs + S3C_PHYPWR);
+}
+
+/*
+ * The function passed to the usb driver for phy initialization
+ */
+static int samsung_usbphy_init(struct usb_phy *phy)
+{
+	struct samsung_usbphy *sphy;
+	int ret = 0;
+
+	sphy = phy_to_sphy(phy);
+
+	/* Enable the phy clock */
+	ret = clk_prepare_enable(sphy->clk);
+	if (ret) {
+		dev_err(sphy->dev, "%s: clk_prepare_enable failed\n", __func__);
+		return ret;
+	}
+
+	/* Disable phy isolation */
+	if (sphy->plat && sphy->plat->pmu_isolation)
+		sphy->plat->pmu_isolation(false);
+
+	/* Initialize usb phy registers */
+	samsung_usbphy_enable(sphy);
+
+	/* Disable the phy clock */
+	clk_disable_unprepare(sphy->clk);
+	return ret;
+}
+
+/*
+ * The function passed to the usb driver for phy shutdown
+ */
+static void samsung_usbphy_shutdown(struct usb_phy *phy)
+{
+	struct samsung_usbphy *sphy;
+
+	sphy = phy_to_sphy(phy);
+
+	if (clk_prepare_enable(sphy->clk)) {
+		dev_err(sphy->dev, "%s: clk_prepare_enable failed\n", __func__);
+		return;
+	}
+
+	/* De-initialize usb phy registers */
+	samsung_usbphy_disable(sphy);
+
+	/* Enable phy isolation */
+	if (sphy->plat && sphy->plat->pmu_isolation)
+		sphy->plat->pmu_isolation(true);
+
+	clk_disable_unprepare(sphy->clk);
+}
+
+static const struct of_device_id samsung_usbphy_dt_match[];
+
+static inline int samsung_usbphy_get_driver_data(struct platform_device *pdev)
+{
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
+		int data;
+		const struct of_device_id *match;
+		match = of_match_node(samsung_usbphy_dt_match,
+							pdev->dev.of_node);
+		data = (int) match->data;
+		return data;
+	}
+
+	return platform_get_device_id(pdev)->driver_data;
+}
+
+static int __devinit samsung_usbphy_probe(struct platform_device *pdev)
+{
+	struct samsung_usbphy *sphy;
+	struct samsung_usbphy_data *pdata;
+	struct device *dev = &pdev->dev;
+	struct resource *phy_mem;
+	void __iomem	*phy_base;
+	struct clk *clk;
+	int	ret = 0;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: no platform data defined\n", __func__);
+		return -EINVAL;
+	}
+
+	phy_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!phy_mem) {
+		dev_err(dev, "%s: missing mem resource\n", __func__);
+		return -ENODEV;
+	}
+
+	phy_base = devm_request_and_ioremap(dev, phy_mem);
+	if (!phy_base) {
+		dev_err(dev, "%s: register mapping failed\n", __func__);
+		return -ENXIO;
+	}
+
+	sphy = devm_kzalloc(dev, sizeof(*sphy), GFP_KERNEL);
+	if (!sphy)
+		return -ENOMEM;
+
+	clk = devm_clk_get(dev, "otg");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "Failed to get otg clock\n");
+		return PTR_ERR(clk);
+	}
+
+	sphy->dev		= &pdev->dev;
+	sphy->plat		= pdata;
+	sphy->regs		= phy_base;
+	sphy->clk		= clk;
+	sphy->phy.dev		= sphy->dev;
+	sphy->phy.label		= "samsung-usbphy";
+	sphy->phy.init		= samsung_usbphy_init;
+	sphy->phy.shutdown	= samsung_usbphy_shutdown;
+	sphy->cpu_type		= samsung_usbphy_get_driver_data(pdev);
+	sphy->ref_clk_freq	= samsung_usbphy_get_refclk_freq(sphy);
+
+	platform_set_drvdata(pdev, sphy);
+
+	ret = usb_add_phy(&sphy->phy, USB_PHY_TYPE_USB2);
+	return ret;
+}
+
+static int __exit samsung_usbphy_remove(struct platform_device *pdev)
+{
+	struct samsung_usbphy *sphy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&sphy->phy);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id samsung_usbphy_dt_match[] = {
+	{
+		.compatible = "samsung,s3c64xx-usbphy",
+		.data = (void *)TYPE_S3C64XX,
+	}, {
+		.compatible = "samsung,exynos4210-usbphy",
+		.data = (void *)TYPE_EXYNOS4210,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, samsung_usbphy_dt_match);
+#else
+#define samsung_usbphy_dt_match NULL
+#endif
+
+static struct platform_device_id samsung_usbphy_driver_ids[] = {
+	{
+		.name		= "s3c64xx-usbphy",
+		.driver_data	= TYPE_S3C64XX,
+	}, {
+		.name		= "exynos4210-usbphy",
+		.driver_data	= TYPE_EXYNOS4210,
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(platform, samsung_usbphy_driver_ids);
+
+static struct platform_driver samsung_usbphy_driver = {
+	.probe		= samsung_usbphy_probe,
+	.remove		= __devexit_p(samsung_usbphy_remove),
+	.id_table	= samsung_usbphy_driver_ids,
+	.driver		= {
+		.name	= "samsung-usbphy",
+		.owner	= THIS_MODULE,
+		.of_match_table = samsung_usbphy_dt_match,
+	},
+};
+
+module_platform_driver(samsung_usbphy_driver);
+
+MODULE_DESCRIPTION("Samsung USB phy controller");
+MODULE_AUTHOR("Praveen Paneri <p.paneri@samsung.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:samsung-usbphy");
diff --git a/include/linux/platform_data/samsung-usbphy.h b/include/linux/platform_data/samsung-usbphy.h
new file mode 100644
index 0000000..1bd24cb
--- /dev/null
+++ b/include/linux/platform_data/samsung-usbphy.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2012 Samsung Electronics Co.Ltd
+ *		http://www.samsung.com/
+ * Author: Praveen Paneri <p.paneri@samsung.com>
+ *
+ * Defines platform data for samsung usb phy driver.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __SAMSUNG_USBPHY_PLATFORM_H
+#define __SAMSUNG_USBPHY_PLATFORM_H
+
+/**
+ * samsung_usbphy_data - Platform data for USB PHY driver.
+ * @pmu_isolation: Function to control usb phy isolation in PMU.
+ */
+struct samsung_usbphy_data {
+	void (*pmu_isolation)(int on);
+};
+
+extern void samsung_usbphy_set_pdata(struct samsung_usbphy_data *pd);
+
+#endif /* __SAMSUNG_USBPHY_PLATFORM_H */
-- 
1.7.1
