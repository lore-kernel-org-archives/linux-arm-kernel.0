From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Jan 2015 18:30:37 +0100
Subject: [PATCH 1/2] phy: exynos-video-mipi: Fix regression by adding support
 for PMU regmap
Message-ID: <1421429438-32090-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the Exynos Power Management Unit (PMU) driver was converted
to the platform device driver in commit 14fc8b93d47323561edf5d482
("ARM: EXYNOS: Add platform driver support for Exynos PMU") and
then PMU device nodes added to Exynos4 DTs in commit
7b9613aca42a5522d269 ("ARM: dts: add PMU syscon node for exynos4")
the mipi video phy driver started failing probing, due to overlapping
memory mapped register region resources.

Now all the Exynos peripheral devices which have registers in the PMU
region are supposed to use the regmap provided by the syscon driver.
So support for regmap is added in this patch, this unfortunately
creates yet another indirection into that supposedly trivial driver.

The additional mutex is required because single register is used by
PHY pairs (they share bit in a register). An improvement here could
be to allow a PHY instance be created with a driver custom mutex,
which would then be common for each PHY pair. This would eliminate
one of 3 mutexes which need to be taken in the phy_power_on/
phy_power_off code path. However, I tried to keep this bug fix patch
possibly simple.

This change is needed to make MIPI DSI displays and MIPI CSI-2
camera sensors working again on Exynos4 boards.

Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../devicetree/bindings/phy/samsung-phy.txt        |    2 +-
 drivers/phy/phy-exynos-mipi-video.c                |   89 +++++++++++++-------
 include/linux/mfd/syscon/exynos4-pmu.h             |   21 +++++
 3 files changed, 79 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/mfd/syscon/exynos4-pmu.h

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index d5bad92..91e38cf 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -3,8 +3,8 @@ Samsung S5P/EXYNOS SoC series MIPI CSIS/DSIM DPHY

 Required properties:
 - compatible : should be "samsung,s5pv210-mipi-video-phy";
-- reg : offset and length of the MIPI DPHY register set;
 - #phy-cells : from the generic phy bindings, must be 1;
+- syscon - phandle to the PMU system controller;

 For "samsung,s5pv210-mipi-video-phy" compatible PHYs the second cell in
 the PHY specifier identifies the PHY and its meaning is as follows:
diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
index 943e0f8..f017b2f 100644
--- a/drivers/phy/phy-exynos-mipi-video.c
+++ b/drivers/phy/phy-exynos-mipi-video.c
@@ -12,19 +12,18 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon/exynos4-pmu.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>

-/* MIPI_PHYn_CONTROL register offset: n = 0..1 */
+/* MIPI_PHYn_CONTROL reg. offset (for base address from ioremap): n = 0..1 */
 #define EXYNOS_MIPI_PHY_CONTROL(n)	((n) * 4)
-#define EXYNOS_MIPI_PHY_ENABLE		(1 << 0)
-#define EXYNOS_MIPI_PHY_SRESETN		(1 << 1)
-#define EXYNOS_MIPI_PHY_MRESETN		(1 << 2)
-#define EXYNOS_MIPI_PHY_RESET_MASK	(3 << 1)

 enum exynos_mipi_phy_id {
 	EXYNOS_MIPI_PHY_ID_CSIS0,
@@ -38,43 +37,62 @@ enum exynos_mipi_phy_id {
 	((id) == EXYNOS_MIPI_PHY_ID_DSIM0 || (id) == EXYNOS_MIPI_PHY_ID_DSIM1)

 struct exynos_mipi_video_phy {
-	spinlock_t slock;
 	struct video_phy_desc {
 		struct phy *phy;
 		unsigned int index;
 	} phys[EXYNOS_MIPI_PHYS_NUM];
+	spinlock_t slock;
 	void __iomem *regs;
+	struct mutex mutex;
+	struct regmap *regmap;
 };

 static int __set_phy_state(struct exynos_mipi_video_phy *state,
 			enum exynos_mipi_phy_id id, unsigned int on)
 {
+	const unsigned int offset = EXYNOS4_MIPI_PHY_CONTROL(id / 2);
 	void __iomem *addr;
-	u32 reg, reset;
-
-	addr = state->regs + EXYNOS_MIPI_PHY_CONTROL(id / 2);
+	u32 val, reset;

 	if (is_mipi_dsim_phy_id(id))
-		reset = EXYNOS_MIPI_PHY_MRESETN;
-	else
-		reset = EXYNOS_MIPI_PHY_SRESETN;
-
-	spin_lock(&state->slock);
-	reg = readl(addr);
-	if (on)
-		reg |= reset;
+		reset = EXYNOS4_MIPI_PHY_MRESETN;
 	else
-		reg &= ~reset;
-	writel(reg, addr);
-
-	/* Clear ENABLE bit only if MRESETN, SRESETN bits are not set. */
-	if (on)
-		reg |= EXYNOS_MIPI_PHY_ENABLE;
-	else if (!(reg & EXYNOS_MIPI_PHY_RESET_MASK))
-		reg &= ~EXYNOS_MIPI_PHY_ENABLE;
+		reset = EXYNOS4_MIPI_PHY_SRESETN;
+
+	if (state->regmap) {
+		mutex_lock(&state->mutex);
+		regmap_read(state->regmap, offset, &val);
+		if (on)
+			val |= reset;
+		else
+			val &= ~reset;
+		regmap_write(state->regmap, offset, val);
+		if (on)
+			val |= EXYNOS4_MIPI_PHY_ENABLE;
+		else if (!(val & EXYNOS4_MIPI_PHY_RESET_MASK))
+			val &= ~EXYNOS4_MIPI_PHY_ENABLE;
+		regmap_write(state->regmap, offset, val);
+		mutex_unlock(&state->mutex);
+	} else {
+		addr = state->regs + EXYNOS_MIPI_PHY_CONTROL(id / 2);
+
+		spin_lock(&state->slock);
+		val = readl(addr);
+		if (on)
+			val |= reset;
+		else
+			val &= ~reset;
+		writel(val, addr);
+		/* Clear ENABLE bit only if MRESETN, SRESETN bits are not set */
+		if (on)
+			val |= EXYNOS4_MIPI_PHY_ENABLE;
+		else if (!(val & EXYNOS4_MIPI_PHY_RESET_MASK))
+			val &= ~EXYNOS4_MIPI_PHY_ENABLE;
+
+		writel(val, addr);
+		spin_unlock(&state->slock);
+	}

-	writel(reg, addr);
-	spin_unlock(&state->slock);
 	return 0;
 }

@@ -118,7 +136,6 @@ static int exynos_mipi_video_phy_probe(struct platform_device *pdev)
 {
 	struct exynos_mipi_video_phy *state;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct phy_provider *phy_provider;
 	unsigned int i;

@@ -126,14 +143,22 @@ static int exynos_mipi_video_phy_probe(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	state->regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (IS_ERR(state->regmap)) {
+		struct resource *res;

-	state->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(state->regs))
-		return PTR_ERR(state->regs);
+		dev_info(dev, "regmap lookup failed: %ld\n",
+			 PTR_ERR(state->regmap));
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		state->regs = devm_ioremap_resource(dev, res);
+		if (IS_ERR(state->regs))
+			return PTR_ERR(state->regs);
+	}

 	dev_set_drvdata(dev, state);
 	spin_lock_init(&state->slock);
+	mutex_init(&state->mutex);

 	for (i = 0; i < EXYNOS_MIPI_PHYS_NUM; i++) {
 		struct phy *phy = devm_phy_create(dev, NULL,
diff --git a/include/linux/mfd/syscon/exynos4-pmu.h b/include/linux/mfd/syscon/exynos4-pmu.h
new file mode 100644
index 0000000..278b1b1
--- /dev/null
+++ b/include/linux/mfd/syscon/exynos4-pmu.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2015 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_
+#define _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_
+
+/* Exynos4 PMU register definitions */
+
+/* MIPI_PHYn_CONTROL register offset: n = 0..1 */
+#define EXYNOS4_MIPI_PHY_CONTROL(n)	(0x710 + (n) * 4)
+#define EXYNOS4_MIPI_PHY_ENABLE		(1 << 0)
+#define EXYNOS4_MIPI_PHY_SRESETN	(1 << 1)
+#define EXYNOS4_MIPI_PHY_MRESETN	(1 << 2)
+#define EXYNOS4_MIPI_PHY_RESET_MASK	(3 << 1)
+
+#endif /* _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_ */
--
1.7.9.5
