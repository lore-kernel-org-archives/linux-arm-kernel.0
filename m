From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 21 May 2015 17:59:20 +0200
Subject: [PATCH v2 1/2] phy: add lpc18xx usb otg phy driver
In-Reply-To: <1432223961-26101-1-git-send-email-manabian@gmail.com>
References: <1432223961-26101-1-git-send-email-manabian@gmail.com>
Message-ID: <1432223961-26101-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PHY driver for the internal USB OTG PHY found on NXP
LPC18xx and LPC43xx devices. This driver takes care of
enabling the PHY in CREG (syscon) and setting the required
clock frequency.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/phy/Kconfig               |  11 +++
 drivers/phy/Makefile              |   1 +
 drivers/phy/phy-lpc18xx-usb-otg.c | 143 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/phy/phy-lpc18xx-usb-otg.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index a53bd5b52df9..e11fb9e3c760 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -52,6 +52,17 @@ config PHY_EXYNOS_MIPI_VIDEO
 	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
 	  and EXYNOS SoCs.
 
+config PHY_LPC18XX_USB_OTG
+	tristate "NXP LPC18xx/43xx SoC USB OTG PHY driver"
+	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support NXP LPC18xx/43xx internal USB OTG PHY.
+
+	  This driver is need for USB0 support on LPC18xx/43xx and takes
+	  care of enabling and clock setup.
+
 config PHY_MVEBU_SATA
 	def_bool y
 	depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f12625178780..b7251f3b9ef7 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
 obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
 obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
 obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
+obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
 obj-$(CONFIG_PHY_MIPHY28LP) 		+= phy-miphy28lp.o
 obj-$(CONFIG_PHY_MIPHY365X)		+= phy-miphy365x.o
diff --git a/drivers/phy/phy-lpc18xx-usb-otg.c b/drivers/phy/phy-lpc18xx-usb-otg.c
new file mode 100644
index 000000000000..da77d54ccbea
--- /dev/null
+++ b/drivers/phy/phy-lpc18xx-usb-otg.c
@@ -0,0 +1,143 @@
+/*
+ * PHY driver for NXP LPC18xx/43xx internal USB OTG PHY
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* USB OTG PHY register offset and bit in CREG */
+#define LPC18XX_CREG_CREG0		0x004
+#define LPC18XX_CREG_CREG0_USB0PHY	BIT(5)
+
+struct lpc18xx_usb_otg_phy {
+	struct phy *phy;
+	struct clk *clk;
+	struct regmap *reg;
+};
+
+static int lpc18xx_usb_otg_phy_init(struct phy *phy)
+{
+	struct lpc18xx_usb_otg_phy *lpc = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare(lpc->clk);
+	if (ret)
+		return ret;
+
+	/* The PHY must be clocked at 480 MHz */
+	return clk_set_rate(lpc->clk, 480000000);
+}
+
+static int lpc18xx_usb_otg_phy_exit(struct phy *phy)
+{
+	struct lpc18xx_usb_otg_phy *lpc = phy_get_drvdata(phy);
+
+	clk_unprepare(lpc->clk);
+
+	return 0;
+}
+
+static int lpc18xx_usb_otg_phy_power_on(struct phy *phy)
+{
+	struct lpc18xx_usb_otg_phy *lpc = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_enable(lpc->clk);
+	if (ret)
+		return ret;
+
+	/* The bit in CREG is cleared to enable the PHY */
+	return regmap_update_bits(lpc->reg, LPC18XX_CREG_CREG0,
+				  LPC18XX_CREG_CREG0_USB0PHY, 0);
+}
+
+static int lpc18xx_usb_otg_phy_power_off(struct phy *phy)
+{
+	struct lpc18xx_usb_otg_phy *lpc = phy_get_drvdata(phy);
+	int ret;
+
+	ret = regmap_update_bits(lpc->reg, LPC18XX_CREG_CREG0,
+				 LPC18XX_CREG_CREG0_USB0PHY,
+				 LPC18XX_CREG_CREG0_USB0PHY);
+	if (ret)
+		return ret;
+
+	clk_disable(lpc->clk);
+
+	return 0;
+}
+
+static const struct phy_ops lpc18xx_usb_otg_phy_ops = {
+	.init		= lpc18xx_usb_otg_phy_init,
+	.exit		= lpc18xx_usb_otg_phy_exit,
+	.power_on	= lpc18xx_usb_otg_phy_power_on,
+	.power_off	= lpc18xx_usb_otg_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int lpc18xx_usb_otg_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct lpc18xx_usb_otg_phy *lpc;
+
+	lpc = devm_kzalloc(&pdev->dev, sizeof(*lpc), GFP_KERNEL);
+	if (!lpc)
+		return -ENOMEM;
+
+	lpc->reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
+	if (IS_ERR(lpc->reg)) {
+		dev_err(&pdev->dev, "failed to get syscon\n");
+		return PTR_ERR(lpc->reg);
+	}
+
+	lpc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(lpc->clk)) {
+		dev_err(&pdev->dev, "failed to get clock\n");
+		return PTR_ERR(lpc->clk);
+	}
+
+	lpc->phy = devm_phy_create(&pdev->dev, NULL, &lpc18xx_usb_otg_phy_ops);
+	if (IS_ERR(lpc->phy)) {
+		dev_err(&pdev->dev, "failed to create PHY\n");
+		return PTR_ERR(lpc->phy);
+	}
+
+	phy_set_drvdata(lpc->phy, lpc);
+
+	phy_provider = devm_of_phy_provider_register(&pdev->dev,
+						     of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id lpc18xx_usb_otg_phy_match[] = {
+	{ .compatible = "nxp,lpc1850-usb-otg-phy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_usb_otg_phy_match);
+
+static struct platform_driver lpc18xx_usb_otg_phy_driver = {
+	.probe		= lpc18xx_usb_otg_phy_probe,
+	.driver		= {
+		.name	= "lpc18xx-usb-otg-phy",
+		.of_match_table = lpc18xx_usb_otg_phy_match,
+	},
+};
+module_platform_driver(lpc18xx_usb_otg_phy_driver);
+
+MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
+MODULE_DESCRIPTION("NXP LPC18xx/43xx USB OTG PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.0
