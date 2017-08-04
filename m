From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  4 Aug 2017 22:32:32 +0200
Subject: [PATCH] Revert "reset: Add a Gemini reset controller"
Message-ID: <20170804203232.25230-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 2acb037fc42b8ce5ae59a7d5db3c9b35672e3dd7.

We ended up merging the reset controller into the clock
controller so we can now get rid of this stand-alone
implementation.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/reset/Kconfig        |   7 ---
 drivers/reset/Makefile       |   1 -
 drivers/reset/reset-gemini.c | 110 -------------------------------------------
 3 files changed, 118 deletions(-)
 delete mode 100644 drivers/reset/reset-gemini.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c4c4a4cbcf49..52d5251660b9 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -34,13 +34,6 @@ config RESET_BERLIN
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
-config RESET_GEMINI
-	bool "Gemini Reset Driver" if COMPILE_TEST
-	default ARCH_GEMINI
-	select MFD_SYSCON
-	help
-	  This enables the reset controller driver for Cortina Systems Gemini.
-
 config RESET_HSDK_V1
 	bool "HSDK v1 Reset Driver"
 	default n
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 9373040efc63..b62783f50fe5 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
-obj-$(CONFIG_RESET_GEMINI) += reset-gemini.o
 obj-$(CONFIG_RESET_HSDK_V1) += reset-hsdk-v1.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
diff --git a/drivers/reset/reset-gemini.c b/drivers/reset/reset-gemini.c
deleted file mode 100644
index a2478997c75b..000000000000
--- a/drivers/reset/reset-gemini.c
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * Cortina Gemini Reset controller driver
- * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/reset-controller.h>
-#include <dt-bindings/reset/cortina,gemini-reset.h>
-
-/**
- * struct gemini_reset - gemini reset controller
- * @map: regmap to access the containing system controller
- * @rcdev: reset controller device
- */
-struct gemini_reset {
-	struct regmap *map;
-	struct reset_controller_dev rcdev;
-};
-
-#define GEMINI_GLOBAL_SOFT_RESET 0x0c
-
-#define to_gemini_reset(p) \
-	container_of((p), struct gemini_reset, rcdev)
-
-/*
- * This is a self-deasserting reset controller.
- */
-static int gemini_reset(struct reset_controller_dev *rcdev,
-			unsigned long id)
-{
-	struct gemini_reset *gr = to_gemini_reset(rcdev);
-
-	/* Manual says to always set BIT 30 (CPU1) to 1 */
-	return regmap_write(gr->map,
-			    GEMINI_GLOBAL_SOFT_RESET,
-			    BIT(GEMINI_RESET_CPU1) | BIT(id));
-}
-
-static int gemini_reset_status(struct reset_controller_dev *rcdev,
-			     unsigned long id)
-{
-	struct gemini_reset *gr = to_gemini_reset(rcdev);
-	u32 val;
-	int ret;
-
-	ret = regmap_read(gr->map, GEMINI_GLOBAL_SOFT_RESET, &val);
-	if (ret)
-		return ret;
-
-	return !!(val & BIT(id));
-}
-
-static const struct reset_control_ops gemini_reset_ops = {
-	.reset = gemini_reset,
-	.status = gemini_reset_status,
-};
-
-static int gemini_reset_probe(struct platform_device *pdev)
-{
-	struct gemini_reset *gr;
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	int ret;
-
-	gr = devm_kzalloc(dev, sizeof(*gr), GFP_KERNEL);
-	if (!gr)
-		return -ENOMEM;
-
-	gr->map = syscon_node_to_regmap(np);
-	if (IS_ERR(gr->map)) {
-		ret = PTR_ERR(gr->map);
-		dev_err(dev, "unable to get regmap (%d)", ret);
-		return ret;
-	}
-	gr->rcdev.owner = THIS_MODULE;
-	gr->rcdev.nr_resets = 32;
-	gr->rcdev.ops = &gemini_reset_ops;
-	gr->rcdev.of_node = pdev->dev.of_node;
-
-	ret = devm_reset_controller_register(&pdev->dev, &gr->rcdev);
-	if (ret)
-		return ret;
-
-	dev_info(dev, "registered Gemini reset controller\n");
-	return 0;
-}
-
-static const struct of_device_id gemini_reset_dt_ids[] = {
-	{ .compatible = "cortina,gemini-syscon", },
-	{ /* sentinel */ },
-};
-
-static struct platform_driver gemini_reset_driver = {
-	.probe	= gemini_reset_probe,
-	.driver = {
-		.name		= "gemini-reset",
-		.of_match_table	= gemini_reset_dt_ids,
-		.suppress_bind_attrs = true,
-	},
-};
-builtin_platform_driver(gemini_reset_driver);
-- 
2.9.4
