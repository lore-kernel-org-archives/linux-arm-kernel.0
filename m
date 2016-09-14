From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:40 +0100
Subject: [PATCH 02/19] phy: stih41x-usb: Remove usb phy driver and dt binding
 documentation.
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This phy is only used on STiH415/6 based silicon, and support for
these SoC's is being removed from the kernel.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <kishon@ti.com>
---
 .../devicetree/bindings/phy/phy-stih41x-usb.txt    |  24 ---
 drivers/phy/Kconfig                                |   8 -
 drivers/phy/Makefile                               |   1 -
 drivers/phy/phy-stih41x-usb.c                      | 188 ---------------------
 4 files changed, 221 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
 delete mode 100644 drivers/phy/phy-stih41x-usb.c

diff --git a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
deleted file mode 100644
index 744b480..0000000
--- a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-STMicroelectronics STiH41x USB PHY binding
-------------------------------------------
-
-This file contains documentation for the usb phy found in STiH415/6 SoCs from
-STMicroelectronics.
-
-Required properties:
-- compatible	: should be "st,stih416-usb-phy" or "st,stih415-usb-phy"
-- st,syscfg	: should be a phandle of the syscfg node
-- clock-names	: must contain "osc_phy"
-- clocks	: must contain an entry for each name in clock-names.
-See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-- #phy-cells	: must be 0 for this phy
-See: Documentation/devicetree/bindings/phy/phy-bindings.txt
-
-Example:
-
-usb2_phy: usb2phy at 0 {
-	compatible	= "st,stih416-usb-phy";
-	#phy-cells	= <0>;
-	st,syscfg	= <&syscfg_rear>;
-	clocks		= <&clk_sysin>;
-	clock-names	= "osc_phy";
-};
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d1f22ac..b4aa039 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -392,14 +392,6 @@ config PHY_STIH407_USB
 	  Enable this support to enable the picoPHY device used by USB2
 	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
 
-config PHY_STIH41X_USB
-	tristate "STMicroelectronics USB2 PHY driver for STiH41x series"
-	depends on ARCH_STI
-	select GENERIC_PHY
-	help
-	  Enable this to support the USB transceiver that is part of
-	  STMicroelectronics STiH41x SoC series.
-
 config PHY_QCOM_UFS
 	tristate "Qualcomm UFS PHY driver"
 	depends on OF && ARCH_QCOM
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index d169d80..5e48741 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
 obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
-obj-$(CONFIG_PHY_STIH41X_USB)		+= phy-stih41x-usb.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
diff --git a/drivers/phy/phy-stih41x-usb.c b/drivers/phy/phy-stih41x-usb.c
deleted file mode 100644
index 0ac7463..0000000
--- a/drivers/phy/phy-stih41x-usb.c
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * Copyright (C) 2014 STMicroelectronics
- *
- * STMicroelectronics PHY driver for STiH41x USB.
- *
- * Author: Maxime Coquelin <maxime.coquelin@st.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2, as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/clk.h>
-#include <linux/phy/phy.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
-
-#define SYSCFG332  0x80
-#define SYSCFG2520 0x820
-
-/**
- * struct stih41x_usb_cfg - SoC specific PHY register mapping
- * @syscfg: Offset in syscfg registers bank
- * @cfg_mask: Bits mask for PHY configuration
- * @cfg: Static configuration value for PHY
- * @oscok: Notify the PHY oscillator clock is ready
- *	   Setting this bit enable the PHY
- */
-struct stih41x_usb_cfg {
-	u32 syscfg;
-	u32 cfg_mask;
-	u32 cfg;
-	u32 oscok;
-};
-
-/**
- * struct stih41x_usb_phy - Private data for the PHY
- * @dev: device for this controller
- * @regmap: Syscfg registers bank in which PHY is configured
- * @cfg: SoC specific PHY register mapping
- * @clk: Oscillator used by the PHY
- */
-struct stih41x_usb_phy {
-	struct device *dev;
-	struct regmap *regmap;
-	const struct stih41x_usb_cfg *cfg;
-	struct clk *clk;
-};
-
-static struct stih41x_usb_cfg stih415_usb_phy_cfg = {
-	.syscfg = SYSCFG332,
-	.cfg_mask = 0x3f,
-	.cfg = 0x38,
-	.oscok = BIT(6),
-};
-
-static struct stih41x_usb_cfg stih416_usb_phy_cfg = {
-	.syscfg = SYSCFG2520,
-	.cfg_mask = 0x33f,
-	.cfg = 0x238,
-	.oscok = BIT(6),
-};
-
-static int stih41x_usb_phy_init(struct phy *phy)
-{
-	struct stih41x_usb_phy *phy_dev = phy_get_drvdata(phy);
-
-	return regmap_update_bits(phy_dev->regmap, phy_dev->cfg->syscfg,
-			   phy_dev->cfg->cfg_mask, phy_dev->cfg->cfg);
-}
-
-static int stih41x_usb_phy_power_on(struct phy *phy)
-{
-	struct stih41x_usb_phy *phy_dev = phy_get_drvdata(phy);
-	int ret;
-
-	ret = clk_prepare_enable(phy_dev->clk);
-	if (ret) {
-		dev_err(phy_dev->dev, "Failed to enable osc_phy clock\n");
-		return ret;
-	}
-
-	ret = regmap_update_bits(phy_dev->regmap, phy_dev->cfg->syscfg,
-				 phy_dev->cfg->oscok, phy_dev->cfg->oscok);
-	if (ret)
-		clk_disable_unprepare(phy_dev->clk);
-
-	return ret;
-}
-
-static int stih41x_usb_phy_power_off(struct phy *phy)
-{
-	struct stih41x_usb_phy *phy_dev = phy_get_drvdata(phy);
-	int ret;
-
-	ret = regmap_update_bits(phy_dev->regmap, phy_dev->cfg->syscfg,
-			phy_dev->cfg->oscok, 0);
-	if (ret) {
-		dev_err(phy_dev->dev, "Failed to clear oscok bit\n");
-		return ret;
-	}
-
-	clk_disable_unprepare(phy_dev->clk);
-
-	return 0;
-}
-
-static const struct phy_ops stih41x_usb_phy_ops = {
-	.init		= stih41x_usb_phy_init,
-	.power_on	= stih41x_usb_phy_power_on,
-	.power_off	= stih41x_usb_phy_power_off,
-	.owner		= THIS_MODULE,
-};
-
-static const struct of_device_id stih41x_usb_phy_of_match[];
-
-static int stih41x_usb_phy_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
-	struct stih41x_usb_phy *phy_dev;
-	struct device *dev = &pdev->dev;
-	struct phy_provider *phy_provider;
-	struct phy *phy;
-
-	phy_dev = devm_kzalloc(dev, sizeof(*phy_dev), GFP_KERNEL);
-	if (!phy_dev)
-		return -ENOMEM;
-
-	match = of_match_device(stih41x_usb_phy_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	phy_dev->cfg = match->data;
-
-	phy_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
-	if (IS_ERR(phy_dev->regmap)) {
-		dev_err(dev, "No syscfg phandle specified\n");
-		return PTR_ERR(phy_dev->regmap);
-	}
-
-	phy_dev->clk = devm_clk_get(dev, "osc_phy");
-	if (IS_ERR(phy_dev->clk)) {
-		dev_err(dev, "osc_phy clk not found\n");
-		return PTR_ERR(phy_dev->clk);
-	}
-
-	phy = devm_phy_create(dev, NULL, &stih41x_usb_phy_ops);
-
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create phy\n");
-		return PTR_ERR(phy);
-	}
-
-	phy_dev->dev = dev;
-
-	phy_set_drvdata(phy, phy_dev);
-
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	return PTR_ERR_OR_ZERO(phy_provider);
-}
-
-static const struct of_device_id stih41x_usb_phy_of_match[] = {
-	{ .compatible = "st,stih415-usb-phy", .data = &stih415_usb_phy_cfg },
-	{ .compatible = "st,stih416-usb-phy", .data = &stih416_usb_phy_cfg },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, stih41x_usb_phy_of_match);
-
-static struct platform_driver stih41x_usb_phy_driver = {
-	.probe	= stih41x_usb_phy_probe,
-	.driver = {
-		.name	= "stih41x-usb-phy",
-		.of_match_table	= stih41x_usb_phy_of_match,
-	}
-};
-module_platform_driver(stih41x_usb_phy_driver);
-
-MODULE_AUTHOR("Maxime Coquelin <maxime.coquelin@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics USB PHY driver for STiH41x series");
-MODULE_LICENSE("GPL v2");
-- 
1.9.1
