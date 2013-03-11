From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 16:26:55 -0600
Subject: [PATCH REPOST] i2c: tegra: assume CONFIG_OF, remove platform data
Message-ID: <1363040815-31833-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra only supports, and always enables, device tree. Remove all ifdefs
and runtime checks for DT support from the driver. Platform data is
therefore no longer required. Delete the header that defines it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/tegra.c    |    2 --
 drivers/i2c/busses/i2c-tegra.c |   26 +++++++-------------------
 include/linux/i2c-tegra.h      |   25 -------------------------
 3 files changed, 7 insertions(+), 46 deletions(-)
 delete mode 100644 include/linux/i2c-tegra.h

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 27232c9..f68c9f6 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -31,8 +31,6 @@
 #include <linux/pda_power.h>
 #include <linux/platform_data/tegra_usb.h>
 #include <linux/io.h>
-#include <linux/i2c.h>
-#include <linux/i2c-tegra.h>
 #include <linux/usb/tegra_usb_phy.h>
 
 #include <asm/mach-types.h>
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 36704e3..865f885 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -25,7 +25,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/i2c-tegra.h>
 #include <linux/of_i2c.h>
 #include <linux/of_device.h>
 #include <linux/module.h>
@@ -172,7 +171,7 @@ struct tegra_i2c_dev {
 	u8 *msg_buf;
 	size_t msg_buf_remaining;
 	int msg_read;
-	unsigned long bus_clk_rate;
+	u32 bus_clk_rate;
 	bool is_suspended;
 };
 
@@ -685,7 +684,6 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.clk_divisor_std_fast_mode = 0x19,
 };
 
-#if defined(CONFIG_OF)
 /* Match table for of_platform binding */
 static const struct of_device_id tegra_i2c_of_match[] = {
 	{ .compatible = "nvidia,tegra114-i2c", .data = &tegra114_i2c_hw, },
@@ -695,16 +693,13 @@ static const struct of_device_id tegra_i2c_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);
-#endif
 
 static int tegra_i2c_probe(struct platform_device *pdev)
 {
 	struct tegra_i2c_dev *i2c_dev;
-	struct tegra_i2c_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res;
 	struct clk *div_clk;
 	struct clk *fast_clk;
-	const unsigned int *prop;
 	void __iomem *base;
 	int irq;
 	int ret = 0;
@@ -745,23 +740,16 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
 
-	i2c_dev->bus_clk_rate = 100000; /* default clock rate */
-	if (pdata) {
-		i2c_dev->bus_clk_rate = pdata->bus_clk_rate;
-
-	} else if (i2c_dev->dev->of_node) {    /* if there is a device tree node ... */
-		prop = of_get_property(i2c_dev->dev->of_node,
-				"clock-frequency", NULL);
-		if (prop)
-			i2c_dev->bus_clk_rate = be32_to_cpup(prop);
-	}
+	ret = of_property_read_u32(i2c_dev->dev->of_node, "clock-frequency",
+					&i2c_dev->bus_clk_rate);
+	if (ret)
+		i2c_dev->bus_clk_rate = 100000; /* default clock rate */
 
 	i2c_dev->hw = &tegra20_i2c_hw;
 
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
-		match = of_match_device(of_match_ptr(tegra_i2c_of_match),
-						&pdev->dev);
+		match = of_match_device(tegra_i2c_of_match, &pdev->dev);
 		i2c_dev->hw = match->data;
 		i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
 						"nvidia,tegra20-i2c-dvc");
@@ -867,7 +855,7 @@ static struct platform_driver tegra_i2c_driver = {
 	.driver  = {
 		.name  = "tegra-i2c",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(tegra_i2c_of_match),
+		.of_match_table = tegra_i2c_of_match,
 		.pm    = TEGRA_I2C_PM,
 	},
 };
diff --git a/include/linux/i2c-tegra.h b/include/linux/i2c-tegra.h
deleted file mode 100644
index 9c85da4..0000000
--- a/include/linux/i2c-tegra.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * drivers/i2c/busses/i2c-tegra.c
- *
- * Copyright (C) 2010 Google, Inc.
- * Author: Colin Cross <ccross@android.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef _LINUX_I2C_TEGRA_H
-#define _LINUX_I2C_TEGRA_H
-
-struct tegra_i2c_platform_data {
-	unsigned long bus_clk_rate;
-};
-
-#endif /* _LINUX_I2C_TEGRA_H */
-- 
1.7.10.4
