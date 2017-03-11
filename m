From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 22:00:21 +0200
Subject: [PATCH v3 5/5] phy: exynos: Use one define for enable bit
In-Reply-To: <20170311200021.5827-1-krzk@kernel.org>
References: <20170311200021.5827-1-krzk@kernel.org>
Message-ID: <20170311200021.5827-6-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need for separate defines for Exynos4 and Exynos5 phy enable
bit and MIPI phy reset bits.  In both cases there are the same so
simplify it.

This reduces number of defines and allows removal of one header file.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/phy/phy-exynos-dp-video.c           |  5 ++--
 drivers/phy/phy-exynos-mipi-video.c         | 39 ++++++++++++++---------------
 drivers/phy/phy-exynos5-usbdrd.c            |  5 ++--
 include/linux/mfd/syscon/exynos5-pmu.h      | 22 ----------------
 include/linux/soc/samsung/exynos-regs-pmu.h |  3 ++-
 5 files changed, 25 insertions(+), 49 deletions(-)
 delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h

diff --git a/drivers/phy/phy-exynos-dp-video.c b/drivers/phy/phy-exynos-dp-video.c
index d72193188980..bb3279dbf88c 100644
--- a/drivers/phy/phy-exynos-dp-video.c
+++ b/drivers/phy/phy-exynos-dp-video.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
-#include <linux/mfd/syscon/exynos5-pmu.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
@@ -37,7 +36,7 @@ static int exynos_dp_video_phy_power_on(struct phy *phy)
 
 	/* Disable power isolation on DP-PHY */
 	return regmap_update_bits(state->regs, state->drvdata->phy_ctrl_offset,
-				  EXYNOS5_PHY_ENABLE, EXYNOS5_PHY_ENABLE);
+				  EXYNOS4_PHY_ENABLE, EXYNOS4_PHY_ENABLE);
 }
 
 static int exynos_dp_video_phy_power_off(struct phy *phy)
@@ -46,7 +45,7 @@ static int exynos_dp_video_phy_power_off(struct phy *phy)
 
 	/* Enable power isolation on DP-PHY */
 	return regmap_update_bits(state->regs, state->drvdata->phy_ctrl_offset,
-				  EXYNOS5_PHY_ENABLE, 0);
+				  EXYNOS4_PHY_ENABLE, 0);
 }
 
 static const struct phy_ops exynos_dp_video_phy_ops = {
diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
index acef1d92691e..c198886f80a3 100644
--- a/drivers/phy/phy-exynos-mipi-video.c
+++ b/drivers/phy/phy-exynos-mipi-video.c
@@ -12,7 +12,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon/exynos5-pmu.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -64,7 +63,7 @@ static const struct mipi_phy_device_desc s5pv210_mipi_phy = {
 		{
 			/* EXYNOS_MIPI_PHY_ID_CSIS0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM0,
-			.enable_val = EXYNOS4_MIPI_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS4_MIPI_PHY_SRESETN,
@@ -73,7 +72,7 @@ static const struct mipi_phy_device_desc s5pv210_mipi_phy = {
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS0,
-			.enable_val = EXYNOS4_MIPI_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS4_MIPI_PHY_MRESETN,
@@ -82,7 +81,7 @@ static const struct mipi_phy_device_desc s5pv210_mipi_phy = {
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_CSIS1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM1,
-			.enable_val = EXYNOS4_MIPI_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS4_MIPI_PHY_SRESETN,
@@ -91,7 +90,7 @@ static const struct mipi_phy_device_desc s5pv210_mipi_phy = {
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS1,
-			.enable_val = EXYNOS4_MIPI_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS4_MIPI_PHY_MRESETN,
@@ -109,46 +108,46 @@ static const struct mipi_phy_device_desc exynos5420_mipi_phy = {
 		{
 			/* EXYNOS_MIPI_PHY_ID_CSIS0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM0,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
-			.resetn_val = EXYNOS5_MIPI_PHY_S_RESETN,
+			.resetn_val = EXYNOS4_MIPI_PHY_SRESETN,
 			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS0,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
-			.resetn_val = EXYNOS5_MIPI_PHY_M_RESETN,
+			.resetn_val = EXYNOS4_MIPI_PHY_MRESETN,
 			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_CSIS1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM1,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
-			.resetn_val = EXYNOS5_MIPI_PHY_S_RESETN,
+			.resetn_val = EXYNOS4_MIPI_PHY_SRESETN,
 			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS1,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
-			.resetn_val = EXYNOS5_MIPI_PHY_M_RESETN,
+			.resetn_val = EXYNOS4_MIPI_PHY_MRESETN,
 			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_CSIS2 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(2),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
-			.resetn_val = EXYNOS5_MIPI_PHY_S_RESETN,
+			.resetn_val = EXYNOS4_MIPI_PHY_SRESETN,
 			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(2),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		},
@@ -172,7 +171,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 		{
 			/* EXYNOS_MIPI_PHY_ID_CSIS0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM0,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(0),
@@ -181,7 +180,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS0,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(0),
@@ -190,7 +189,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_CSIS1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(1),
@@ -199,7 +198,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(1),
@@ -208,7 +207,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_CSIS2 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
-			.enable_val = EXYNOS5_PHY_ENABLE,
+			.enable_val = EXYNOS4_PHY_ENABLE,
 			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(2),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(0),
diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
index 7c896d0cda18..7c41daa2c625 100644
--- a/drivers/phy/phy-exynos5-usbdrd.c
+++ b/drivers/phy/phy-exynos5-usbdrd.c
@@ -22,7 +22,6 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/mfd/syscon.h>
-#include <linux/mfd/syscon/exynos5-pmu.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
@@ -236,10 +235,10 @@ static void exynos5_usbdrd_phy_isol(struct phy_usb_instance *inst,
 	if (!inst->reg_pmu)
 		return;
 
-	val = on ? 0 : EXYNOS5_PHY_ENABLE;
+	val = on ? 0 : EXYNOS4_PHY_ENABLE;
 
 	regmap_update_bits(inst->reg_pmu, inst->pmu_offset,
-			   EXYNOS5_PHY_ENABLE, val);
+			   EXYNOS4_PHY_ENABLE, val);
 }
 
 /*
diff --git a/include/linux/mfd/syscon/exynos5-pmu.h b/include/linux/mfd/syscon/exynos5-pmu.h
deleted file mode 100644
index 0a4ddabc395e..000000000000
--- a/include/linux/mfd/syscon/exynos5-pmu.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Exynos5 SoC series Power Management Unit (PMU) register offsets
- * and bit definitions.
- *
- * Copyright (C) 2014 Samsung Electronics Co., Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_
-#define _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_
-
-#define EXYNOS5_PHY_ENABLE			BIT(0)
-#define EXYNOS5_MIPI_PHY_S_RESETN		BIT(1)
-#define EXYNOS5_MIPI_PHY_M_RESETN		BIT(2)
-
-#define EXYNOS5433_PAD_RETENTION_AUD_OPTION		(0x3028)
-#define EXYNOS5433_PAD_INITIATE_WAKEUP_FROM_LOWPWR	BIT(28)
-
-#endif /* _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_ */
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index c261ed927e1e..bebdde5dccd6 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -52,7 +52,8 @@
 
 /* MIPI_PHYn_CONTROL, valid for Exynos3250, Exynos4, Exynos5250 and Exynos5433 */
 #define EXYNOS4_MIPI_PHY_CONTROL(n)		(0x0710 + (n) * 4)
-#define EXYNOS4_MIPI_PHY_ENABLE			(1 << 0)
+/* Phy enable bit, common for all phy registers, not only MIPI */
+#define EXYNOS4_PHY_ENABLE			(1 << 0)
 #define EXYNOS4_MIPI_PHY_SRESETN		(1 << 1)
 #define EXYNOS4_MIPI_PHY_MRESETN		(1 << 2)
 #define EXYNOS4_MIPI_PHY_RESET_MASK		(3 << 1)
-- 
2.9.3
