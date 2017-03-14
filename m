From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 18:46:49 +0200
Subject: [PATCH v4 1/5] phy: exynos4: Remove duplicated defines of PHY
 register defines
In-Reply-To: <20170314164653.15771-1-krzk@kernel.org>
References: <20170314164653.15771-1-krzk@kernel.org>
Message-ID: <20170314164653.15771-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phy drivers access PMU region through regmap provided by exynos-pmu
driver.   However there is no need to duplicate defines for PMU
registers.  Instead just use whatever is defined in exynos-regs-pmu.h.

Additionally MIPI PHY registers for Exynos5433 start from the same
address as Exynos4 and Exynos5250 so re-use existing defines.

This reduces number of defines and allows removal of one header file.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/phy/phy-exynos-mipi-video.c         | 12 ++++++------
 include/linux/mfd/syscon/exynos4-pmu.h      | 21 ---------------------
 include/linux/mfd/syscon/exynos5-pmu.h      |  3 ---
 include/linux/soc/samsung/exynos-regs-pmu.h |  9 ++++++++-
 4 files changed, 14 insertions(+), 31 deletions(-)
 delete mode 100644 include/linux/mfd/syscon/exynos4-pmu.h

diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
index 6bee04cc4d53..d7fe1f8c3ac8 100644
--- a/drivers/phy/phy-exynos-mipi-video.c
+++ b/drivers/phy/phy-exynos-mipi-video.c
@@ -12,7 +12,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon/exynos4-pmu.h>
 #include <linux/mfd/syscon/exynos5-pmu.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -21,6 +20,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/spinlock.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/mfd/syscon.h>
 
 enum exynos_mipi_phy_id {
@@ -173,7 +173,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 			/* EXYNOS_MIPI_PHY_ID_CSIS0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM0,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5433_MIPI_PHY0_CONTROL,
+			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(0),
 			.resetn_reg = EXYNOS5433_SYSREG_CAM0_MIPI_DPHY_CON,
@@ -182,7 +182,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 			/* EXYNOS_MIPI_PHY_ID_DSIM0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS0,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5433_MIPI_PHY0_CONTROL,
+			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(0),
 			.resetn_reg = EXYNOS5433_SYSREG_DISP_MIPI_PHY,
@@ -191,7 +191,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 			/* EXYNOS_MIPI_PHY_ID_CSIS1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5433_MIPI_PHY1_CONTROL,
+			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(1),
 			.resetn_reg = EXYNOS5433_SYSREG_CAM0_MIPI_DPHY_CON,
@@ -200,7 +200,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 			/* EXYNOS_MIPI_PHY_ID_DSIM1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5433_MIPI_PHY1_CONTROL,
+			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(1),
 			.resetn_reg = EXYNOS5433_SYSREG_DISP_MIPI_PHY,
@@ -209,7 +209,7 @@ static const struct mipi_phy_device_desc exynos5433_mipi_phy = {
 			/* EXYNOS_MIPI_PHY_ID_CSIS2 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5433_MIPI_PHY2_CONTROL,
+			.enable_reg = EXYNOS4_MIPI_PHY_CONTROL(2),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = BIT(0),
 			.resetn_reg = EXYNOS5433_SYSREG_CAM1_MIPI_DPHY_CON,
diff --git a/include/linux/mfd/syscon/exynos4-pmu.h b/include/linux/mfd/syscon/exynos4-pmu.h
deleted file mode 100644
index 278b1b1549e9..000000000000
--- a/include/linux/mfd/syscon/exynos4-pmu.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) 2015 Samsung Electronics Co., Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_
-#define _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_
-
-/* Exynos4 PMU register definitions */
-
-/* MIPI_PHYn_CONTROL register offset: n = 0..1 */
-#define EXYNOS4_MIPI_PHY_CONTROL(n)	(0x710 + (n) * 4)
-#define EXYNOS4_MIPI_PHY_ENABLE		(1 << 0)
-#define EXYNOS4_MIPI_PHY_SRESETN	(1 << 1)
-#define EXYNOS4_MIPI_PHY_MRESETN	(1 << 2)
-#define EXYNOS4_MIPI_PHY_RESET_MASK	(3 << 1)
-
-#endif /* _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_ */
diff --git a/include/linux/mfd/syscon/exynos5-pmu.h b/include/linux/mfd/syscon/exynos5-pmu.h
index c28ff21ca4d2..77c93551ee58 100644
--- a/include/linux/mfd/syscon/exynos5-pmu.h
+++ b/include/linux/mfd/syscon/exynos5-pmu.h
@@ -38,9 +38,6 @@
 
 /* Exynos5433 specific register definitions */
 #define EXYNOS5433_USBHOST30_PHY_CONTROL	(0x728)
-#define EXYNOS5433_MIPI_PHY0_CONTROL		(0x710)
-#define EXYNOS5433_MIPI_PHY1_CONTROL		(0x714)
-#define EXYNOS5433_MIPI_PHY2_CONTROL		(0x718)
 
 #define EXYNOS5_PHY_ENABLE			BIT(0)
 #define EXYNOS5_MIPI_PHY_S_RESETN		BIT(1)
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 49df0a01a2cc..e57d75889a09 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * EXYNOS - Power management unit definition
@@ -50,6 +50,13 @@
 #define S5P_WAKEUP_MASK				0x0608
 #define S5P_WAKEUP_MASK2				0x0614
 
+/* MIPI_PHYn_CONTROL, valid for Exynos3250, Exynos4, Exynos5250 and Exynos5433 */
+#define EXYNOS4_MIPI_PHY_CONTROL(n)		(0x0710 + (n) * 4)
+#define EXYNOS4_MIPI_PHY_ENABLE			(1 << 0)
+#define EXYNOS4_MIPI_PHY_SRESETN		(1 << 1)
+#define EXYNOS4_MIPI_PHY_MRESETN		(1 << 2)
+#define EXYNOS4_MIPI_PHY_RESET_MASK		(3 << 1)
+
 #define S5P_INFORM0				0x0800
 #define S5P_INFORM1				0x0804
 #define S5P_INFORM5				0x0814
-- 
2.9.3
