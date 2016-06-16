From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 16 Jun 2016 18:53:24 +0530
Subject: [PATCH V2 1/4] clk: max77686: Combine Maxim max77686 and max77802
 driver
In-Reply-To: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1466083407-28793-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock IP used on the Maxim PMICs max77686 and max77802 are
same. The configuration of clock register is also same except
the number of clocks.

Part of common code utilisation, there is 3 files for these chips
clock driver, one for common and two files for driver registration.

Combine both drivers into single file and move common code into
same common file reduces the 2 files and make max77686 and max77802
clock driver in single fine. This driver does not depends on the
parent driver structure. The regmap handle is acquired through
regmap APIs for the register access.

This combination of driver helps on adding clock driver for different
Maxim PMICs which has similar clock IP like MAX77620 and MAX20024.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@dowhile0.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
Changes from V1:
- Collected RB and TB from Javier.
- Change the max_gen to max77686.
- Rename structure and avoid duplication for reg and mask.
- Taken care of comment from Krzysztof on coding.
---
 drivers/clk/Kconfig        |  15 +--
 drivers/clk/Makefile       |   2 -
 drivers/clk/clk-max-gen.c  | 194 -----------------------------------
 drivers/clk/clk-max-gen.h  |  32 ------
 drivers/clk/clk-max77686.c | 244 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/clk/clk-max77802.c |  96 ------------------
 6 files changed, 234 insertions(+), 349 deletions(-)
 delete mode 100644 drivers/clk/clk-max-gen.c
 delete mode 100644 drivers/clk/clk-max-gen.h
 delete mode 100644 drivers/clk/clk-max77802.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 98efbfc..6afad74 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -31,22 +31,11 @@ config COMMON_CLK_WM831X
 
 source "drivers/clk/versatile/Kconfig"
 
-config COMMON_CLK_MAX_GEN
-        bool
-
 config COMMON_CLK_MAX77686
-	tristate "Clock driver for Maxim 77686 MFD"
-	depends on MFD_MAX77686
-	select COMMON_CLK_MAX_GEN
-	---help---
-	  This driver supports Maxim 77686 crystal oscillator clock. 
-
-config COMMON_CLK_MAX77802
-	tristate "Clock driver for Maxim 77802 PMIC"
+	tristate "Clock driver for Maxim 77686/77802 MFD"
 	depends on MFD_MAX77686
-	select COMMON_CLK_MAX_GEN
 	---help---
-	  This driver supports Maxim 77802 crystal oscillator clock.
+	  This driver supports Maxim 77686/77802 crystal oscillator clock.
 
 config COMMON_CLK_RK808
 	tristate "Clock driver for RK808"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index dcc5e69..0a3a91b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -26,9 +26,7 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_MACH_LOONGSON32)		+= clk-ls1x.o
-obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
-obj-$(CONFIG_COMMON_CLK_MAX77802)	+= clk-max77802.o
 obj-$(CONFIG_ARCH_MB86S7X)		+= clk-mb86s7x.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
diff --git a/drivers/clk/clk-max-gen.c b/drivers/clk/clk-max-gen.c
deleted file mode 100644
index 35af9cb..0000000
--- a/drivers/clk/clk-max-gen.c
+++ /dev/null
@@ -1,194 +0,0 @@
-/*
- * clk-max-gen.c - Generic clock driver for Maxim PMICs clocks
- *
- * Copyright (C) 2014 Google, Inc
- *
- * Copyright (C) 2012 Samsung Electornics
- * Jonghwa Lee <jonghwa3.lee@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This driver is based on clk-max77686.c
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/regmap.h>
-#include <linux/platform_device.h>
-#include <linux/clk-provider.h>
-#include <linux/mutex.h>
-#include <linux/clkdev.h>
-#include <linux/of.h>
-#include <linux/export.h>
-
-#include "clk-max-gen.h"
-
-struct max_gen_clk {
-	struct regmap *regmap;
-	u32 mask;
-	u32 reg;
-	struct clk_hw hw;
-};
-
-static struct max_gen_clk *to_max_gen_clk(struct clk_hw *hw)
-{
-	return container_of(hw, struct max_gen_clk, hw);
-}
-
-static int max_gen_clk_prepare(struct clk_hw *hw)
-{
-	struct max_gen_clk *max_gen = to_max_gen_clk(hw);
-
-	return regmap_update_bits(max_gen->regmap, max_gen->reg,
-				  max_gen->mask, max_gen->mask);
-}
-
-static void max_gen_clk_unprepare(struct clk_hw *hw)
-{
-	struct max_gen_clk *max_gen = to_max_gen_clk(hw);
-
-	regmap_update_bits(max_gen->regmap, max_gen->reg,
-			   max_gen->mask, ~max_gen->mask);
-}
-
-static int max_gen_clk_is_prepared(struct clk_hw *hw)
-{
-	struct max_gen_clk *max_gen = to_max_gen_clk(hw);
-	int ret;
-	u32 val;
-
-	ret = regmap_read(max_gen->regmap, max_gen->reg, &val);
-
-	if (ret < 0)
-		return -EINVAL;
-
-	return val & max_gen->mask;
-}
-
-static unsigned long max_gen_recalc_rate(struct clk_hw *hw,
-					 unsigned long parent_rate)
-{
-	return 32768;
-}
-
-struct clk_ops max_gen_clk_ops = {
-	.prepare	= max_gen_clk_prepare,
-	.unprepare	= max_gen_clk_unprepare,
-	.is_prepared	= max_gen_clk_is_prepared,
-	.recalc_rate	= max_gen_recalc_rate,
-};
-EXPORT_SYMBOL_GPL(max_gen_clk_ops);
-
-static struct clk *max_gen_clk_register(struct device *dev,
-					struct max_gen_clk *max_gen)
-{
-	struct clk *clk;
-	struct clk_hw *hw = &max_gen->hw;
-	int ret;
-
-	clk = devm_clk_register(dev, hw);
-	if (IS_ERR(clk))
-		return clk;
-
-	ret = clk_register_clkdev(clk, hw->init->name, NULL);
-
-	if (ret)
-		return ERR_PTR(ret);
-
-	return clk;
-}
-
-int max_gen_clk_probe(struct platform_device *pdev, struct regmap *regmap,
-		      u32 reg, struct clk_init_data *clks_init, int num_init)
-{
-	int i, ret;
-	struct max_gen_clk *max_gen_clks;
-	struct clk **clocks;
-	struct device *dev = pdev->dev.parent;
-	const char *clk_name;
-	struct clk_init_data *init;
-
-	clocks = devm_kzalloc(dev, sizeof(struct clk *) * num_init, GFP_KERNEL);
-	if (!clocks)
-		return -ENOMEM;
-
-	max_gen_clks = devm_kzalloc(dev, sizeof(struct max_gen_clk)
-				    * num_init, GFP_KERNEL);
-	if (!max_gen_clks)
-		return -ENOMEM;
-
-	for (i = 0; i < num_init; i++) {
-		max_gen_clks[i].regmap = regmap;
-		max_gen_clks[i].mask = 1 << i;
-		max_gen_clks[i].reg = reg;
-
-		init = devm_kzalloc(dev, sizeof(*init), GFP_KERNEL);
-		if (!init)
-			return -ENOMEM;
-
-		if (dev->of_node &&
-		    !of_property_read_string_index(dev->of_node,
-						   "clock-output-names",
-						   i, &clk_name))
-			init->name = clk_name;
-		else
-			init->name = clks_init[i].name;
-
-		init->ops = clks_init[i].ops;
-		init->flags = clks_init[i].flags;
-
-		max_gen_clks[i].hw.init = init;
-
-		clocks[i] = max_gen_clk_register(dev, &max_gen_clks[i]);
-		if (IS_ERR(clocks[i])) {
-			ret = PTR_ERR(clocks[i]);
-			dev_err(dev, "failed to register %s\n",
-				max_gen_clks[i].hw.init->name);
-			return ret;
-		}
-	}
-
-	platform_set_drvdata(pdev, clocks);
-
-	if (dev->of_node) {
-		struct clk_onecell_data *of_data;
-
-		of_data = devm_kzalloc(dev, sizeof(*of_data), GFP_KERNEL);
-		if (!of_data)
-			return -ENOMEM;
-
-		of_data->clks = clocks;
-		of_data->clk_num = num_init;
-		ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
-					  of_data);
-
-		if (ret) {
-			dev_err(dev, "failed to register OF clock provider\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(max_gen_clk_probe);
-
-int max_gen_clk_remove(struct platform_device *pdev, int num_init)
-{
-	struct device *dev = pdev->dev.parent;
-
-	if (dev->of_node)
-		of_clk_del_provider(dev->of_node);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(max_gen_clk_remove);
diff --git a/drivers/clk/clk-max-gen.h b/drivers/clk/clk-max-gen.h
deleted file mode 100644
index 997e86f..0000000
--- a/drivers/clk/clk-max-gen.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * clk-max-gen.h - Generic clock driver for Maxim PMICs clocks
- *
- * Copyright (C) 2014 Google, Inc
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __CLK_MAX_GEN_H__
-#define __CLK_MAX_GEN_H__
-
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/clkdev.h>
-#include <linux/regmap.h>
-#include <linux/platform_device.h>
-
-int max_gen_clk_probe(struct platform_device *pdev, struct regmap *regmap,
-		      u32 reg, struct clk_init_data *clks_init, int num_init);
-int max_gen_clk_remove(struct platform_device *pdev, int num_init);
-extern struct clk_ops max_gen_clk_ops;
-
-#endif /* __CLK_MAX_GEN_H__ */
diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 9b6f277..9aba3a8 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -1,5 +1,5 @@
 /*
- * clk-max77686.c - Clock driver for Maxim 77686
+ * clk-max77686.c - Clock driver for Maxim 77686/MAX77802
  *
  * Copyright (C) 2012 Samsung Electornics
  * Jonghwa Lee <jonghwa3.lee@samsung.com>
@@ -30,41 +30,261 @@
 #include <linux/clk-provider.h>
 #include <linux/mutex.h>
 #include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
 
 #include <dt-bindings/clock/maxim,max77686.h>
-#include "clk-max-gen.h"
+#include <dt-bindings/clock/maxim,max77802.h>
 
-static struct clk_init_data max77686_clks_init[MAX77686_CLKS_NUM] = {
+#define MAX77802_CLOCK_LOW_JITTER_SHIFT 0x3
+
+enum max77686_chip_name {
+	CHIP_MAX77686,
+	CHIP_MAX77802,
+};
+
+struct max77686_hw_clk_info {
+	const char *name;
+	u32 clk_reg;
+	u32 clk_enable_mask;
+	u32 flags;
+};
+
+struct max77686_clk_init_data {
+	struct regmap *regmap;
+	struct clk_hw hw;
+	struct clk_init_data clk_idata;
+	const struct max77686_hw_clk_info *clk_info;
+};
+
+struct max77686_clk_driver_data {
+	enum max77686_chip_name chip;
+	struct clk **clks;
+	struct max77686_clk_init_data *max_clk_data;
+	struct clk_onecell_data of_data;
+};
+
+static const struct
+max77686_hw_clk_info max77686_hw_clks_info[MAX77686_CLKS_NUM] = {
 	[MAX77686_CLK_AP] = {
 		.name = "32khz_ap",
-		.ops = &max_gen_clk_ops,
+		.clk_reg = MAX77686_REG_32KHZ,
+		.clk_enable_mask = BIT(MAX77686_CLK_AP),
 	},
 	[MAX77686_CLK_CP] = {
 		.name = "32khz_cp",
-		.ops = &max_gen_clk_ops,
+		.clk_reg = MAX77686_REG_32KHZ,
+		.clk_enable_mask = BIT(MAX77686_CLK_CP),
 	},
 	[MAX77686_CLK_PMIC] = {
 		.name = "32khz_pmic",
-		.ops = &max_gen_clk_ops,
+		.clk_reg = MAX77686_REG_32KHZ,
+		.clk_enable_mask = BIT(MAX77686_CLK_PMIC),
+	},
+};
+
+static const struct
+max77686_hw_clk_info max77802_hw_clks_info[MAX77802_CLKS_NUM] = {
+	[MAX77802_CLK_32K_AP] = {
+		.name = "32khz_ap",
+		.clk_reg = MAX77802_REG_32KHZ,
+		.clk_enable_mask = BIT(MAX77802_CLK_32K_AP),
+	},
+	[MAX77802_CLK_32K_CP] = {
+		.name = "32khz_cp",
+		.clk_reg = MAX77802_REG_32KHZ,
+		.clk_enable_mask = BIT(MAX77802_CLK_32K_CP),
 	},
 };
 
+static struct max77686_clk_init_data *to_max77686_clk_init_data(
+				struct clk_hw *hw)
+{
+	return container_of(hw, struct max77686_clk_init_data, hw);
+}
+
+static int max77686_clk_prepare(struct clk_hw *hw)
+{
+	struct max77686_clk_init_data *max77686 = to_max77686_clk_init_data(hw);
+
+	return regmap_update_bits(max77686->regmap, max77686->clk_info->clk_reg,
+				  max77686->clk_info->clk_enable_mask,
+				  max77686->clk_info->clk_enable_mask);
+}
+
+static void max77686_clk_unprepare(struct clk_hw *hw)
+{
+	struct max77686_clk_init_data *max77686 = to_max77686_clk_init_data(hw);
+
+	regmap_update_bits(max77686->regmap, max77686->clk_info->clk_reg,
+			   max77686->clk_info->clk_enable_mask,
+			   ~max77686->clk_info->clk_enable_mask);
+}
+
+static int max77686_clk_is_prepared(struct clk_hw *hw)
+{
+	struct max77686_clk_init_data *max77686 = to_max77686_clk_init_data(hw);
+	int ret;
+	u32 val;
+
+	ret = regmap_read(max77686->regmap, max77686->clk_info->clk_reg, &val);
+
+	if (ret < 0)
+		return -EINVAL;
+
+	return val & max77686->clk_info->clk_enable_mask;
+}
+
+static unsigned long max77686_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return 32768;
+}
+
+static struct clk_ops max77686_clk_ops = {
+	.prepare	= max77686_clk_prepare,
+	.unprepare	= max77686_clk_unprepare,
+	.is_prepared	= max77686_clk_is_prepared,
+	.recalc_rate	= max77686_recalc_rate,
+};
+
 static int max77686_clk_probe(struct platform_device *pdev)
 {
-	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct max77686_clk_driver_data *drv_data;
+	const struct max77686_hw_clk_info *hw_clks;
+	struct regmap *regmap;
+	int i, ret, num_clks;
+
+	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+
+	regmap = dev_get_regmap(parent, NULL);
+	if (!regmap) {
+		dev_err(dev, "Failed to get rtc regmap\n");
+		return -ENODEV;
+	}
+
+	drv_data->chip = id->driver_data;
+
+	switch (drv_data->chip) {
+	case CHIP_MAX77686:
+		num_clks = MAX77686_CLKS_NUM;
+		hw_clks = max77686_hw_clks_info;
+		break;
+
+	case CHIP_MAX77802:
+		num_clks = MAX77802_CLKS_NUM;
+		hw_clks = max77802_hw_clks_info;
+		break;
+
+	default:
+		dev_err(dev, "Unknown Chip ID\n");
+		return -EINVAL;
+	}
+
+	drv_data->max_clk_data = devm_kcalloc(dev, num_clks,
+					      sizeof(*drv_data->max_clk_data),
+					      GFP_KERNEL);
+	if (!drv_data->max_clk_data)
+		return -ENOMEM;
+
+	drv_data->clks = devm_kcalloc(dev, num_clks,
+				      sizeof(*drv_data->clks), GFP_KERNEL);
+	if (!drv_data->clks)
+		return -ENOMEM;
 
-	return max_gen_clk_probe(pdev, iodev->regmap, MAX77686_REG_32KHZ,
-				 max77686_clks_init, MAX77686_CLKS_NUM);
+	for (i = 0; i < num_clks; i++) {
+		struct max77686_clk_init_data *max_clk_data;
+		struct clk *clk;
+		const char *clk_name;
+
+		max_clk_data = &drv_data->max_clk_data[i];
+
+		max_clk_data->regmap = regmap;
+		max_clk_data->clk_info = &hw_clks[i];
+		max_clk_data->clk_idata.flags = hw_clks[i].flags;
+		max_clk_data->clk_idata.ops = &max77686_clk_ops;
+
+		if (parent->of_node &&
+		    !of_property_read_string_index(parent->of_node,
+						   "clock-output-names",
+						   i, &clk_name))
+			max_clk_data->clk_idata.name = clk_name;
+		else
+			max_clk_data->clk_idata.name = hw_clks[i].name;
+
+		max_clk_data->hw.init = &max_clk_data->clk_idata;
+
+		clk = devm_clk_register(dev, &max_clk_data->hw);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err(dev, "Failed to clock register: %d\n", ret);
+			return ret;
+		}
+
+		ret = clk_register_clkdev(clk, max_clk_data->clk_idata.name,
+					  NULL);
+		if (ret < 0) {
+			dev_err(dev, "Failed to clkdev register: %d\n", ret);
+			return ret;
+		}
+		drv_data->clks[i] = clk;
+	}
+
+	platform_set_drvdata(pdev, drv_data);
+
+	if (parent->of_node) {
+		drv_data->of_data.clks = drv_data->clks;
+		drv_data->of_data.clk_num = num_clks;
+		ret = of_clk_add_provider(parent->of_node,
+					  of_clk_src_onecell_get,
+					  &drv_data->of_data);
+
+		if (ret < 0) {
+			dev_err(dev, "Failed to register OF clock provider: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	/* MAX77802: Enable low-jitter mode on the 32khz clocks. */
+	if (drv_data->chip == CHIP_MAX77802) {
+		ret = regmap_update_bits(regmap, MAX77802_REG_32KHZ,
+					 1 << MAX77802_CLOCK_LOW_JITTER_SHIFT,
+					 1 << MAX77802_CLOCK_LOW_JITTER_SHIFT);
+		if (ret < 0) {
+			dev_err(dev, "Failed to config low-jitter: %d\n", ret);
+			goto remove_of_clk_provider;
+		}
+	}
+
+	return 0;
+
+remove_of_clk_provider:
+	if (parent->of_node)
+		of_clk_del_provider(parent->of_node);
+
+	return ret;
 }
 
 static int max77686_clk_remove(struct platform_device *pdev)
 {
-	return max_gen_clk_remove(pdev, MAX77686_CLKS_NUM);
+	struct device *parent = pdev->dev.parent;
+
+	if (parent->of_node)
+		of_clk_del_provider(parent->of_node);
+
+	return 0;
 }
 
 static const struct platform_device_id max77686_clk_id[] = {
-	{ "max77686-clk", 0},
-	{ },
+	{ "max77686-clk", .driver_data = CHIP_MAX77686, },
+	{ "max77802-clk", .driver_data = CHIP_MAX77802, },
+	{},
 };
 MODULE_DEVICE_TABLE(platform, max77686_clk_id);
 
diff --git a/drivers/clk/clk-max77802.c b/drivers/clk/clk-max77802.c
deleted file mode 100644
index 355dd2e..0000000
--- a/drivers/clk/clk-max77802.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * clk-max77802.c - Clock driver for Maxim 77802
- *
- * Copyright (C) 2014 Google, Inc
- *
- * Copyright (C) 2012 Samsung Electornics
- * Jonghwa Lee <jonghwa3.lee@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This driver is based on clk-max77686.c
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/max77686-private.h>
-#include <linux/clk-provider.h>
-#include <linux/mutex.h>
-#include <linux/clkdev.h>
-
-#include <dt-bindings/clock/maxim,max77802.h>
-#include "clk-max-gen.h"
-
-#define MAX77802_CLOCK_OPMODE_MASK	0x1
-#define MAX77802_CLOCK_LOW_JITTER_SHIFT 0x3
-
-static struct clk_init_data max77802_clks_init[MAX77802_CLKS_NUM] = {
-	[MAX77802_CLK_32K_AP] = {
-		.name = "32khz_ap",
-		.ops = &max_gen_clk_ops,
-	},
-	[MAX77802_CLK_32K_CP] = {
-		.name = "32khz_cp",
-		.ops = &max_gen_clk_ops,
-	},
-};
-
-static int max77802_clk_probe(struct platform_device *pdev)
-{
-	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	int ret;
-
-	ret = max_gen_clk_probe(pdev, iodev->regmap, MAX77802_REG_32KHZ,
-				max77802_clks_init, MAX77802_CLKS_NUM);
-
-	if (ret) {
-		dev_err(&pdev->dev, "generic probe failed %d\n", ret);
-		return ret;
-	}
-
-	/* Enable low-jitter mode on the 32khz clocks. */
-	ret = regmap_update_bits(iodev->regmap, MAX77802_REG_32KHZ,
-				 1 << MAX77802_CLOCK_LOW_JITTER_SHIFT,
-				 1 << MAX77802_CLOCK_LOW_JITTER_SHIFT);
-	if (ret < 0)
-		dev_err(&pdev->dev, "failed to enable low-jitter mode\n");
-
-	return ret;
-}
-
-static int max77802_clk_remove(struct platform_device *pdev)
-{
-	return max_gen_clk_remove(pdev, MAX77802_CLKS_NUM);
-}
-
-static const struct platform_device_id max77802_clk_id[] = {
-	{ "max77802-clk", 0},
-	{ },
-};
-MODULE_DEVICE_TABLE(platform, max77802_clk_id);
-
-static struct platform_driver max77802_clk_driver = {
-	.driver = {
-		.name  = "max77802-clk",
-	},
-	.probe = max77802_clk_probe,
-	.remove = max77802_clk_remove,
-	.id_table = max77802_clk_id,
-};
-
-module_platform_driver(max77802_clk_driver);
-
-MODULE_DESCRIPTION("MAXIM 77802 Clock Driver");
-MODULE_AUTHOR("Javier Martinez Canillas <javier@osg.samsung.com");
-MODULE_LICENSE("GPL");
-- 
2.1.4
