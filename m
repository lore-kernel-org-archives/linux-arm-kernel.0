From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 25 Jan 2012 14:43:28 -0700
Subject: [PATCH 2/3] ARM: tegra: Add a simple PMC driver
In-Reply-To: <1327527809-10179-1-git-send-email-swarren@nvidia.com>
References: <1327527809-10179-1-git-send-email-swarren@nvidia.com>
Message-ID: <1327527809-10179-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This PMC driver is enough to parse the nvidia,invert-interrupt property
from device tree, and configure the PMC's to honor that.

In the future, this file could expand to centralize all other PMC accesses
within the mach-tegra code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Makefile |    1 +
 arch/arm/mach-tegra/common.c |    3 ++
 arch/arm/mach-tegra/pmc.c    |   76 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h    |   23 +++++++++++++
 4 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/pmc.c
 create mode 100644 arch/arm/mach-tegra/pmc.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 49ff80c..749bb7e 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -6,6 +6,7 @@ obj-y                                   += irq.o
 obj-y                                   += clock.o
 obj-y                                   += timer.o
 obj-y					+= fuse.o
+obj-y					+= pmc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= powergate.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 1b1dee0..1cdcda1 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -32,6 +32,7 @@
 #include "board.h"
 #include "clock.h"
 #include "fuse.h"
+#include "pmc.h"
 
 /*
  * Storage for debug-macro.S's state.
@@ -117,6 +118,7 @@ void __init tegra20_init_early(void)
 	tegra2_init_clocks();
 	tegra_clk_init_from_table(tegra20_clk_init_table);
 	tegra_init_cache(0x331, 0x441);
+	tegra_pmc_init();
 }
 #endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
@@ -124,5 +126,6 @@ void __init tegra30_init_early(void)
 {
 	tegra30_init_clocks();
 	tegra_init_cache(0x441, 0x551);
+	tegra_pmc_init();
 }
 #endif
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
new file mode 100644
index 0000000..7af6a54
--- /dev/null
+++ b/arch/arm/mach-tegra/pmc.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include <mach/iomap.h>
+
+#define PMC_CTRL		0x0
+#define PMC_CTRL_INTR_LOW	(1 << 17)
+
+static inline u32 tegra_pmc_readl(u32 reg)
+{
+	return readl(IO_ADDRESS(TEGRA_PMC_BASE + reg));
+}
+
+static inline void tegra_pmc_writel(u32 val, u32 reg)
+{
+	writel(val, IO_ADDRESS(TEGRA_PMC_BASE + reg));
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id matches[] __initconst = {
+	{ .compatible = "nvidia,tegra20-pmc" },
+	{ }
+};
+#endif
+
+void __init tegra_pmc_init(void)
+{
+	/*
+	 * For now, Harmony is the only board that uses the PMC, and it wants
+	 * the signal inverted. Seaboard would too if it used the PMC.
+	 * Hopefully by the time other boards want to use the PMC, everything
+	 * will be device-tree, or they also want it inverted.
+	 */
+	bool invert_interrupt = true;
+	u32 val;
+
+#ifdef CONFIG_OF
+	if (of_have_populated_dt()) {
+		struct device_node *np;
+
+		invert_interrupt = false;
+
+		np = of_find_matching_node(NULL, matches);
+		if (np) {
+			if (of_find_property(np, "nvidia,invert-interrupt",
+						NULL))
+				invert_interrupt = true;
+		}
+	}
+#endif
+
+	val = tegra_pmc_readl(PMC_CTRL);
+	if (invert_interrupt)
+		val |= PMC_CTRL_INTR_LOW;
+	else
+		val &= ~PMC_CTRL_INTR_LOW;
+	tegra_pmc_writel(val, PMC_CTRL);
+}
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
new file mode 100644
index 0000000..8995ee4
--- /dev/null
+++ b/arch/arm/mach-tegra/pmc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef __MACH_TEGRA_PMC_H
+#define __MACH_TEGRA_PMC_H
+
+void tegra_pmc_init(void);
+
+#endif
-- 
1.7.0.4
