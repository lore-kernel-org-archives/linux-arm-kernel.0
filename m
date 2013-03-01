From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 1 Mar 2013 15:32:10 +0800
Subject: [PATCH V3 1/4] ARM: tegra: pmc: convert PMC driver to support DT only
Message-ID: <1362123131-3339-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra kernel only support boot from DT now. Clean up the PMC driver
to support DT only, that includes:

* remove the ifdef of CONFIG_OF
* replace the static mapping of PMC addr to map from DT

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* BUG_ON directly if no PMC DT node
* remove redundant () in tegra_pmc_writel
V2:
* removing the change from readl_relaxed back to readl, same with the
  write function
* adding a BUG() when there is no PMC node in DT
* removeing the redundancy of_have_populated_dt() check
---
 arch/arm/mach-tegra/pmc.c | 51 ++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 5d79d34..a916eca 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
+ * Copyright (C) 2012,2013 NVIDIA CORPORATION. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -18,59 +18,52 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/of.h>
-
-#include "iomap.h"
+#include <linux/of_address.h>
 
 #define PMC_CTRL		0x0
 #define PMC_CTRL_INTR_LOW	(1 << 17)
 
+static void __iomem *tegra_pmc_base;
+static bool tegra_pmc_invert_interrupt;
+
 static inline u32 tegra_pmc_readl(u32 reg)
 {
-	return readl(IO_ADDRESS(TEGRA_PMC_BASE + reg));
+	return readl(tegra_pmc_base + reg);
 }
 
 static inline void tegra_pmc_writel(u32 val, u32 reg)
 {
-	writel(val, IO_ADDRESS(TEGRA_PMC_BASE + reg));
+	writel(val, tegra_pmc_base + reg);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id matches[] __initconst = {
 	{ .compatible = "nvidia,tegra114-pmc" },
 	{ .compatible = "nvidia,tegra30-pmc" },
 	{ .compatible = "nvidia,tegra20-pmc" },
 	{ }
 };
-#endif
 
-void __init tegra_pmc_init(void)
+static void tegra_pmc_parse_dt(void)
 {
-	/*
-	 * For now, Harmony is the only board that uses the PMC, and it wants
-	 * the signal inverted. Seaboard would too if it used the PMC.
-	 * Hopefully by the time other boards want to use the PMC, everything
-	 * will be device-tree, or they also want it inverted.
-	 */
-	bool invert_interrupt = true;
-	u32 val;
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, matches);
+	BUG_ON(!np);
 
-#ifdef CONFIG_OF
-	if (of_have_populated_dt()) {
-		struct device_node *np;
+	tegra_pmc_base = of_iomap(np, 0);
 
-		invert_interrupt = false;
+	tegra_pmc_invert_interrupt = of_property_read_bool(np,
+				     "nvidia,invert-interrupt");
+}
+
+void __init tegra_pmc_init(void)
+{
+	u32 val;
 
-		np = of_find_matching_node(NULL, matches);
-		if (np) {
-			if (of_find_property(np, "nvidia,invert-interrupt",
-						NULL))
-				invert_interrupt = true;
-		}
-	}
-#endif
+	tegra_pmc_parse_dt();
 
 	val = tegra_pmc_readl(PMC_CTRL);
-	if (invert_interrupt)
+	if (tegra_pmc_invert_interrupt)
 		val |= PMC_CTRL_INTR_LOW;
 	else
 		val &= ~PMC_CTRL_INTR_LOW;
-- 
1.8.1.1
