From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 14 Mar 2015 11:57:16 +0800
Subject: [PATCH v5 1/2] phy: Add driver to support individual USB PHYs on sun9i
In-Reply-To: <1426305437-15208-1-git-send-email-wens@csie.org>
References: <1426305437-15208-1-git-send-email-wens@csie.org>
Message-ID: <1426305437-15208-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike previous Allwinner SoCs, there is no central PHY control block
on the A80. Also, OTG support is completely split off into a different
controller.

This adds a new driver to support the regular USB PHYs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/phy/sun9i-usb-phy.txt      |  38 ++++
 drivers/phy/Kconfig                                |  11 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-sun9i-usb.c                        | 202 +++++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt
 create mode 100644 drivers/phy/phy-sun9i-usb.c

diff --git a/Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt
new file mode 100644
index 000000000000..1cca85c709d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt
@@ -0,0 +1,38 @@
+Allwinner sun9i USB PHY
+-----------------------
+
+Required properties:
+- compatible : should be one of
+  * allwinner,sun9i-a80-usb-phy
+- reg : a list of offset + length pairs
+- #phy-cells : from the generic phy bindings, must be 0
+- phy_type : "hsic" for HSIC usage;
+	     other values or absence of this property indicates normal USB
+- clocks : phandle + clock specifier for the phy clocks
+- clock-names : depending on the "phy_type" property,
+  * "phy" for normal USB
+  * "hsic_480M", "hsic_12M" for HSIC
+- resets : a list of phandle + reset specifier pairs
+- reset-names : depending on the "phy_type" property,
+  * "phy" for normal USB
+  * "hsic" for HSIC
+
+Optional Properties:
+- phy-supply : from the generic phy bindings, a phandle to a regulator that
+	       provides power to VBUS.
+
+It is recommended to list all clocks and resets available.
+The driver will only use those matching the phy_type.
+
+Example:
+	usbphy1: phy at 00a01800 {
+		compatible = "allwinner,sun9i-a80-usb-phy";
+		reg = <0x00a01800 0x4>;
+		clocks = <&usb_phy_clk 2>, <&usb_phy_clk 10>,
+		       <&usb_phy_clk 3>;
+		clock-names = "hsic_480M", "hsic_12M", "phy";
+		resets = <&usb_phy_clk 18>, <&usb_phy_clk 19>;
+		reset-names = "hsic", "phy";
+		status = "disabled";
+		#phy-cells = <0>;
+	};
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2962de205ba7..5b08eccc5cc5 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -174,6 +174,17 @@ config PHY_SUN4I_USB
 	  This driver controls the entire USB PHY block, both the USB OTG
 	  parts, as well as the 2 regular USB 2 host PHYs.
 
+config PHY_SUN9I_USB
+	tristate "Allwinner sun9i SoC USB PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	select GENERIC_PHY
+	help
+	  Enable this to support the transceiver that is part of Allwinner
+	  sun9i SoCs.
+
+	  This driver controls each individual USB 2 host PHY.
+
 config PHY_SAMSUNG_USB2
 	tristate "Samsung USB 2.0 PHY driver"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f080e1bb2a74..ab8f9af540a2 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
 obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
+obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
 obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
 phy-exynos-usb2-y			+= phy-samsung-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
diff --git a/drivers/phy/phy-sun9i-usb.c b/drivers/phy/phy-sun9i-usb.c
new file mode 100644
index 000000000000..0095914a662c
--- /dev/null
+++ b/drivers/phy/phy-sun9i-usb.c
@@ -0,0 +1,202 @@
+/*
+ * Allwinner sun9i USB phy driver
+ *
+ * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
+ *
+ * Based on phy-sun4i-usb.c from
+ * Hans de Goede <hdegoede@redhat.com>
+ *
+ * and code from
+ * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#define SUNXI_AHB_INCR16_BURST_EN	BIT(11)
+#define SUNXI_AHB_INCR8_BURST_EN	BIT(10)
+#define SUNXI_AHB_INCR4_BURST_EN	BIT(9)
+#define SUNXI_AHB_INCRX_ALIGN_EN	BIT(8)
+#define SUNXI_ULPI_BYPASS_EN		BIT(0)
+
+/* usb1 HSIC specific bits */
+#define SUNXI_EHCI_HS_FORCE		BIT(20)
+#define SUNXI_HSIC_CONNECT_DET		BIT(17)
+#define SUNXI_HSIC_CONNECT_INT		BIT(16)
+#define SUNXI_HSIC			BIT(1)
+
+struct sun9i_usb_phy {
+	struct phy *phy;
+	void __iomem *pmu;
+	struct reset_control *reset;
+	struct clk *clk;
+	struct clk *hsic_clk;
+	enum usb_phy_interface type;
+};
+
+static void sun9i_usb_phy_passby(struct sun9i_usb_phy *phy, int enable)
+{
+	u32 bits, reg_value;
+
+	bits = SUNXI_AHB_INCR16_BURST_EN | SUNXI_AHB_INCR8_BURST_EN |
+		SUNXI_AHB_INCR4_BURST_EN | SUNXI_AHB_INCRX_ALIGN_EN |
+		SUNXI_ULPI_BYPASS_EN;
+
+	if (phy->type == USBPHY_INTERFACE_MODE_HSIC)
+		bits |= SUNXI_HSIC | SUNXI_EHCI_HS_FORCE |
+			SUNXI_HSIC_CONNECT_DET | SUNXI_HSIC_CONNECT_INT;
+
+	reg_value = readl(phy->pmu);
+
+	if (enable)
+		reg_value |= bits;
+	else
+		reg_value &= ~bits;
+
+	writel(reg_value, phy->pmu);
+}
+
+static int sun9i_usb_phy_init(struct phy *_phy)
+{
+	struct sun9i_usb_phy *phy = phy_get_drvdata(_phy);
+	int ret;
+
+	ret = clk_prepare_enable(phy->clk);
+	if (ret)
+		goto err_clk;
+
+	ret = clk_prepare_enable(phy->hsic_clk);
+	if (ret)
+		goto err_hsic_clk;
+
+	ret = reset_control_deassert(phy->reset);
+	if (ret)
+		goto err_reset;
+
+	sun9i_usb_phy_passby(phy, 1);
+	return 0;
+
+err_reset:
+	clk_disable_unprepare(phy->hsic_clk);
+
+err_hsic_clk:
+	clk_disable_unprepare(phy->clk);
+
+err_clk:
+	return ret;
+}
+
+static int sun9i_usb_phy_exit(struct phy *_phy)
+{
+	struct sun9i_usb_phy *phy = phy_get_drvdata(_phy);
+
+	sun9i_usb_phy_passby(phy, 0);
+	reset_control_assert(phy->reset);
+	clk_disable_unprepare(phy->hsic_clk);
+	clk_disable_unprepare(phy->clk);
+
+	return 0;
+}
+
+static struct phy_ops sun9i_usb_phy_ops = {
+	.init		= sun9i_usb_phy_init,
+	.exit		= sun9i_usb_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int sun9i_usb_phy_probe(struct platform_device *pdev)
+{
+	struct sun9i_usb_phy *phy;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->type = of_usb_get_phy_mode(np);
+	if (phy->type == USBPHY_INTERFACE_MODE_HSIC) {
+		phy->clk = devm_clk_get(dev, "hsic_480M");
+		if (IS_ERR(phy->clk)) {
+			dev_err(dev, "failed to get hsic_480M clock\n");
+			return PTR_ERR(phy->clk);
+		}
+
+		phy->hsic_clk = devm_clk_get(dev, "hsic_12M");
+		if (IS_ERR(phy->clk)) {
+			dev_err(dev, "failed to get hsic_12M clock\n");
+			return PTR_ERR(phy->clk);
+		}
+
+		phy->reset = devm_reset_control_get(dev, "hsic");
+		if (IS_ERR(phy->reset)) {
+			dev_err(dev, "failed to get reset control\n");
+			return PTR_ERR(phy->reset);
+		}
+	} else {
+		phy->clk = devm_clk_get(dev, "phy");
+		if (IS_ERR(phy->clk)) {
+			dev_err(dev, "failed to get phy clock\n");
+			return PTR_ERR(phy->clk);
+		}
+
+		phy->reset = devm_reset_control_get(dev, "phy");
+		if (IS_ERR(phy->reset)) {
+			dev_err(dev, "failed to get reset control\n");
+			return PTR_ERR(phy->reset);
+		}
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->pmu = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->pmu))
+		return PTR_ERR(phy->pmu);
+
+	phy->phy = devm_phy_create(dev, NULL, &sun9i_usb_phy_ops);
+	if (IS_ERR(phy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy->phy);
+	}
+
+	phy_set_drvdata(phy->phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id sun9i_usb_phy_of_match[] = {
+	{ .compatible = "allwinner,sun9i-a80-usb-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun9i_usb_phy_of_match);
+
+static struct platform_driver sun9i_usb_phy_driver = {
+	.probe	= sun9i_usb_phy_probe,
+	.driver = {
+		.of_match_table	= sun9i_usb_phy_of_match,
+		.name  = "sun9i-usb-phy",
+	}
+};
+module_platform_driver(sun9i_usb_phy_driver);
+
+MODULE_DESCRIPTION("Allwinner sun9i USB phy driver");
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_LICENSE("GPL");
-- 
2.1.4
