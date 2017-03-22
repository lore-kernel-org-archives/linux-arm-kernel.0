From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 22 Mar 2017 17:00:53 +0000
Subject: [PATCH V2 2/5] soc/tegra: Move Tegra flowctrl driver
In-Reply-To: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
References: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1490202056-13040-3-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flowctrl driver is required for both ARM and ARM64 Tegra devices
and in order to enable support for it for ARM64, move the Tegra flowctrl
driver into drivers/soc/tegra.

By moving the flowctrl driver, tegra_flowctrl_init() is now called by
via an early initcall and to prevent this function from attempting to
mapping IO space for a non-Tegra device, a test for 'soc_is_tegra()'
is also added.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/Makefile          |   1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c |   3 +-
 arch/arm/mach-tegra/flowctrl.c        | 179 --------------------------------
 arch/arm/mach-tegra/flowctrl.h        |  66 ------------
 arch/arm/mach-tegra/platsmp.c         |   2 +-
 arch/arm/mach-tegra/pm.c              |   2 +-
 arch/arm/mach-tegra/reset-handler.S   |   2 +-
 arch/arm/mach-tegra/sleep-tegra20.S   |   3 +-
 arch/arm/mach-tegra/sleep-tegra30.S   |   2 +-
 arch/arm/mach-tegra/tegra.c           |   2 -
 drivers/soc/tegra/Kconfig             |   7 ++
 drivers/soc/tegra/Makefile            |   1 +
 drivers/soc/tegra/flowctrl.c          | 187 ++++++++++++++++++++++++++++++++++
 include/soc/tegra/flowctrl.h          |  82 +++++++++++++++
 14 files changed, 285 insertions(+), 254 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/flowctrl.c
 delete mode 100644 arch/arm/mach-tegra/flowctrl.h
 create mode 100644 drivers/soc/tegra/flowctrl.c
 create mode 100644 include/soc/tegra/flowctrl.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index fffad2426ee4..3b33f0bb78ae 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -2,7 +2,6 @@ asflags-y				+= -march=armv7-a
 
 obj-y                                   += io.o
 obj-y                                   += irq.o
-obj-y					+= flowctrl.o
 obj-y					+= pm.o
 obj-y					+= reset.o
 obj-y					+= reset-handler.o
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index afcee04f2616..76e4c83cd5c8 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -26,12 +26,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#include <soc/tegra/flowctrl.h>
+
 #include <asm/cpuidle.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
 #include "cpuidle.h"
-#include "flowctrl.h"
 #include "iomap.h"
 #include "irq.h"
 #include "pm.h"
diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
deleted file mode 100644
index 07c688de248e..000000000000
--- a/arch/arm/mach-tegra/flowctrl.c
+++ /dev/null
@@ -1,179 +0,0 @@
-/*
- * arch/arm/mach-tegra/flowctrl.c
- *
- * functions and macros to control the flowcontroller
- *
- * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/cpumask.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <soc/tegra/fuse.h>
-
-#include "flowctrl.h"
-
-static u8 flowctrl_offset_halt_cpu[] = {
-	FLOW_CTRL_HALT_CPU0_EVENTS,
-	FLOW_CTRL_HALT_CPU1_EVENTS,
-	FLOW_CTRL_HALT_CPU1_EVENTS + 8,
-	FLOW_CTRL_HALT_CPU1_EVENTS + 16,
-};
-
-static u8 flowctrl_offset_cpu_csr[] = {
-	FLOW_CTRL_CPU0_CSR,
-	FLOW_CTRL_CPU1_CSR,
-	FLOW_CTRL_CPU1_CSR + 8,
-	FLOW_CTRL_CPU1_CSR + 16,
-};
-
-static void __iomem *tegra_flowctrl_base;
-
-static void flowctrl_update(u8 offset, u32 value)
-{
-	if (WARN_ONCE(!tegra_flowctrl_base,
-		      "Tegra flowctrl not initialised!\n"))
-		return;
-
-	writel(value, tegra_flowctrl_base + offset);
-
-	/* ensure the update has reached the flow controller */
-	wmb();
-	readl_relaxed(tegra_flowctrl_base + offset);
-}
-
-u32 flowctrl_read_cpu_csr(unsigned int cpuid)
-{
-	u8 offset = flowctrl_offset_cpu_csr[cpuid];
-
-	if (WARN_ONCE(!tegra_flowctrl_base,
-		      "Tegra flowctrl not initialised!\n"))
-		return 0;
-
-	return readl(tegra_flowctrl_base + offset);
-}
-
-void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value)
-{
-	return flowctrl_update(flowctrl_offset_cpu_csr[cpuid], value);
-}
-
-void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value)
-{
-	return flowctrl_update(flowctrl_offset_halt_cpu[cpuid], value);
-}
-
-void flowctrl_cpu_suspend_enter(unsigned int cpuid)
-{
-	unsigned int reg;
-	int i;
-
-	reg = flowctrl_read_cpu_csr(cpuid);
-	switch (tegra_get_chip_id()) {
-	case TEGRA20:
-		/* clear wfe bitmap */
-		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
-		/* clear wfi bitmap */
-		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP;
-		/* pwr gating on wfe */
-		reg |= TEGRA20_FLOW_CTRL_CSR_WFE_CPU0 << cpuid;
-		break;
-	case TEGRA30:
-	case TEGRA114:
-	case TEGRA124:
-		/* clear wfe bitmap */
-		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
-		/* clear wfi bitmap */
-		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
-		/* pwr gating on wfi */
-		reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;
-		break;
-	}
-	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr flag */
-	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event flag */
-	reg |= FLOW_CTRL_CSR_ENABLE;			/* pwr gating */
-	flowctrl_write_cpu_csr(cpuid, reg);
-
-	for (i = 0; i < num_possible_cpus(); i++) {
-		if (i == cpuid)
-			continue;
-		reg = flowctrl_read_cpu_csr(i);
-		reg |= FLOW_CTRL_CSR_EVENT_FLAG;
-		reg |= FLOW_CTRL_CSR_INTR_FLAG;
-		flowctrl_write_cpu_csr(i, reg);
-	}
-}
-
-void flowctrl_cpu_suspend_exit(unsigned int cpuid)
-{
-	unsigned int reg;
-
-	/* Disable powergating via flow controller for CPU0 */
-	reg = flowctrl_read_cpu_csr(cpuid);
-	switch (tegra_get_chip_id()) {
-	case TEGRA20:
-		/* clear wfe bitmap */
-		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
-		/* clear wfi bitmap */
-		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP;
-		break;
-	case TEGRA30:
-	case TEGRA114:
-	case TEGRA124:
-		/* clear wfe bitmap */
-		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
-		/* clear wfi bitmap */
-		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
-		break;
-	}
-	reg &= ~FLOW_CTRL_CSR_ENABLE;			/* clear enable */
-	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr */
-	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event */
-	flowctrl_write_cpu_csr(cpuid, reg);
-}
-
-static const struct of_device_id matches[] __initconst = {
-	{ .compatible = "nvidia,tegra124-flowctrl" },
-	{ .compatible = "nvidia,tegra114-flowctrl" },
-	{ .compatible = "nvidia,tegra30-flowctrl" },
-	{ .compatible = "nvidia,tegra20-flowctrl" },
-	{ }
-};
-
-void __init tegra_flowctrl_init(void)
-{
-	/* hardcoded fallback if device tree node is missing */
-	unsigned long base = 0x60007000;
-	unsigned long size = SZ_4K;
-	struct device_node *np;
-
-	np = of_find_matching_node(NULL, matches);
-	if (np) {
-		struct resource res;
-
-		if (of_address_to_resource(np, 0, &res) == 0) {
-			size = resource_size(&res);
-			base = res.start;
-		}
-
-		of_node_put(np);
-	}
-
-	tegra_flowctrl_base = ioremap_nocache(base, size);
-}
diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
deleted file mode 100644
index 73a9c5016c1a..000000000000
--- a/arch/arm/mach-tegra/flowctrl.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * arch/arm/mach-tegra/flowctrl.h
- *
- * functions and macros to control the flowcontroller
- *
- * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __MACH_TEGRA_FLOWCTRL_H
-#define __MACH_TEGRA_FLOWCTRL_H
-
-#define FLOW_CTRL_HALT_CPU0_EVENTS	0x0
-#define FLOW_CTRL_WAITEVENT		(2 << 29)
-#define FLOW_CTRL_WAIT_FOR_INTERRUPT	(4 << 29)
-#define FLOW_CTRL_JTAG_RESUME		(1 << 28)
-#define FLOW_CTRL_SCLK_RESUME		(1 << 27)
-#define FLOW_CTRL_HALT_CPU_IRQ		(1 << 10)
-#define	FLOW_CTRL_HALT_CPU_FIQ		(1 << 8)
-#define FLOW_CTRL_HALT_LIC_IRQ		(1 << 11)
-#define FLOW_CTRL_HALT_LIC_FIQ		(1 << 10)
-#define FLOW_CTRL_HALT_GIC_IRQ		(1 << 9)
-#define FLOW_CTRL_HALT_GIC_FIQ		(1 << 8)
-#define FLOW_CTRL_CPU0_CSR		0x8
-#define	FLOW_CTRL_CSR_INTR_FLAG		(1 << 15)
-#define FLOW_CTRL_CSR_EVENT_FLAG	(1 << 14)
-#define FLOW_CTRL_CSR_ENABLE_EXT_CRAIL	(1 << 13)
-#define FLOW_CTRL_CSR_ENABLE_EXT_NCPU	(1 << 12)
-#define FLOW_CTRL_CSR_ENABLE_EXT_MASK ( \
-		FLOW_CTRL_CSR_ENABLE_EXT_NCPU | \
-		FLOW_CTRL_CSR_ENABLE_EXT_CRAIL)
-#define FLOW_CTRL_CSR_ENABLE		(1 << 0)
-#define FLOW_CTRL_HALT_CPU1_EVENTS	0x14
-#define FLOW_CTRL_CPU1_CSR		0x18
-
-#define TEGRA20_FLOW_CTRL_CSR_WFE_CPU0		(1 << 4)
-#define TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP	(3 << 4)
-#define TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP	0
-
-#define TEGRA30_FLOW_CTRL_CSR_WFI_CPU0		(1 << 8)
-#define TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP	(0xF << 4)
-#define TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP	(0xF << 8)
-
-#ifndef __ASSEMBLY__
-u32 flowctrl_read_cpu_csr(unsigned int cpuid);
-void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value);
-void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value);
-
-void flowctrl_cpu_suspend_enter(unsigned int cpuid);
-void flowctrl_cpu_suspend_exit(unsigned int cpuid);
-
-void tegra_flowctrl_init(void);
-#endif
-
-#endif
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 75620ae73913..b5a2afe99101 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -21,6 +21,7 @@
 #include <linux/jiffies.h>
 #include <linux/smp.h>
 
+#include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
@@ -30,7 +31,6 @@
 #include <asm/smp_scu.h>
 
 #include "common.h"
-#include "flowctrl.h"
 #include "iomap.h"
 #include "reset.h"
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index b0f48a3946fa..1ad5719779b0 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
 
+#include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pm.h>
 #include <soc/tegra/pmc.h>
@@ -38,7 +39,6 @@
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 
-#include "flowctrl.h"
 #include "iomap.h"
 #include "pm.h"
 #include "reset.h"
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index e3070fdab80b..805f306fa6f7 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -17,12 +17,12 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 
+#include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
-#include "flowctrl.h"
 #include "iomap.h"
 #include "reset.h"
 #include "sleep.h"
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index f5d19667484e..5c8e638ee51a 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -20,6 +20,8 @@
 
 #include <linux/linkage.h>
 
+#include <soc/tegra/flowctrl.h>
+
 #include <asm/assembler.h>
 #include <asm/proc-fns.h>
 #include <asm/cp15.h>
@@ -27,7 +29,6 @@
 
 #include "irammap.h"
 #include "sleep.h"
-#include "flowctrl.h"
 
 #define EMC_CFG				0xc
 #define EMC_ADR_CFG			0x10
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 16e5ff03383c..dd4a67dabd91 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -16,13 +16,13 @@
 
 #include <linux/linkage.h>
 
+#include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
 
-#include "flowctrl.h"
 #include "irammap.h"
 #include "sleep.h"
 
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index e01cbca196b5..649e9e8c7bcc 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -48,7 +48,6 @@
 #include "board.h"
 #include "common.h"
 #include "cpuidle.h"
-#include "flowctrl.h"
 #include "iomap.h"
 #include "irq.h"
 #include "pm.h"
@@ -75,7 +74,6 @@ static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
 	tegra_cpu_reset_handler_init();
-	tegra_flowctrl_init();
 }
 
 static void __init tegra_dt_init_irq(void)
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 208d6edb3fdb..c7e8ddfb574e 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -12,6 +12,7 @@ config ARCH_TEGRA_2x_SOC
 	select PINCTRL_TEGRA20
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
@@ -24,6 +25,7 @@ config ARCH_TEGRA_3x_SOC
 	select ARM_ERRATA_764369 if SMP
 	select PINCTRL_TEGRA30
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
@@ -35,6 +37,7 @@ config ARCH_TEGRA_114_SOC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA114
+	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
@@ -45,6 +48,7 @@ config ARCH_TEGRA_124_SOC
 	bool "Enable support for Tegra124 family"
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
@@ -101,6 +105,9 @@ config ARCH_TEGRA_186_SOC
 endif
 endif
 
+config SOC_TEGRA_FLOWCTRL
+	bool
+
 config SOC_TEGRA_PMC
 	bool
 
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index b4425e4319ff..4f81dd55e5d1 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -1,5 +1,6 @@
 obj-y += fuse/
 
 obj-y += common.o
+obj-$(CONFIG_SOC_TEGRA_FLOWCTRL) += flowctrl.o
 obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
 obj-$(CONFIG_SOC_TEGRA_PMC_TEGRA186) += pmc-tegra186.o
diff --git a/drivers/soc/tegra/flowctrl.c b/drivers/soc/tegra/flowctrl.c
new file mode 100644
index 000000000000..3a5a1cb9ae90
--- /dev/null
+++ b/drivers/soc/tegra/flowctrl.c
@@ -0,0 +1,187 @@
+/*
+ * drivers/soc/tegra/flowctrl.c
+ *
+ * Functions and macros to control the flowcontroller
+ *
+ * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <soc/tegra/common.h>
+#include <soc/tegra/flowctrl.h>
+#include <soc/tegra/fuse.h>
+
+static u8 flowctrl_offset_halt_cpu[] = {
+	FLOW_CTRL_HALT_CPU0_EVENTS,
+	FLOW_CTRL_HALT_CPU1_EVENTS,
+	FLOW_CTRL_HALT_CPU1_EVENTS + 8,
+	FLOW_CTRL_HALT_CPU1_EVENTS + 16,
+};
+
+static u8 flowctrl_offset_cpu_csr[] = {
+	FLOW_CTRL_CPU0_CSR,
+	FLOW_CTRL_CPU1_CSR,
+	FLOW_CTRL_CPU1_CSR + 8,
+	FLOW_CTRL_CPU1_CSR + 16,
+};
+
+static void __iomem *tegra_flowctrl_base;
+
+static void flowctrl_update(u8 offset, u32 value)
+{
+	if (WARN_ONCE(!tegra_flowctrl_base,
+		      "Tegra flowctrl not initialised!\n"))
+		return;
+
+	writel(value, tegra_flowctrl_base + offset);
+
+	/* ensure the update has reached the flow controller */
+	wmb();
+	readl_relaxed(tegra_flowctrl_base + offset);
+}
+
+u32 flowctrl_read_cpu_csr(unsigned int cpuid)
+{
+	u8 offset = flowctrl_offset_cpu_csr[cpuid];
+
+	if (WARN_ONCE(!tegra_flowctrl_base,
+		      "Tegra flowctrl not initialised!\n"))
+		return 0;
+
+	return readl(tegra_flowctrl_base + offset);
+}
+
+void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value)
+{
+	return flowctrl_update(flowctrl_offset_cpu_csr[cpuid], value);
+}
+
+void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value)
+{
+	return flowctrl_update(flowctrl_offset_halt_cpu[cpuid], value);
+}
+
+void flowctrl_cpu_suspend_enter(unsigned int cpuid)
+{
+	unsigned int reg;
+	int i;
+
+	reg = flowctrl_read_cpu_csr(cpuid);
+	switch (tegra_get_chip_id()) {
+	case TEGRA20:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP;
+		/* pwr gating on wfe */
+		reg |= TEGRA20_FLOW_CTRL_CSR_WFE_CPU0 << cpuid;
+		break;
+	case TEGRA30:
+	case TEGRA114:
+	case TEGRA124:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
+		/* pwr gating on wfi */
+		reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;
+		break;
+	}
+	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr flag */
+	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event flag */
+	reg |= FLOW_CTRL_CSR_ENABLE;			/* pwr gating */
+	flowctrl_write_cpu_csr(cpuid, reg);
+
+	for (i = 0; i < num_possible_cpus(); i++) {
+		if (i == cpuid)
+			continue;
+		reg = flowctrl_read_cpu_csr(i);
+		reg |= FLOW_CTRL_CSR_EVENT_FLAG;
+		reg |= FLOW_CTRL_CSR_INTR_FLAG;
+		flowctrl_write_cpu_csr(i, reg);
+	}
+}
+
+void flowctrl_cpu_suspend_exit(unsigned int cpuid)
+{
+	unsigned int reg;
+
+	/* Disable powergating via flow controller for CPU0 */
+	reg = flowctrl_read_cpu_csr(cpuid);
+	switch (tegra_get_chip_id()) {
+	case TEGRA20:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP;
+		break;
+	case TEGRA30:
+	case TEGRA114:
+	case TEGRA124:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
+		break;
+	}
+	reg &= ~FLOW_CTRL_CSR_ENABLE;			/* clear enable */
+	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr */
+	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event */
+	flowctrl_write_cpu_csr(cpuid, reg);
+}
+
+static const struct of_device_id matches[] __initconst = {
+	{ .compatible = "nvidia,tegra124-flowctrl" },
+	{ .compatible = "nvidia,tegra114-flowctrl" },
+	{ .compatible = "nvidia,tegra30-flowctrl" },
+	{ .compatible = "nvidia,tegra20-flowctrl" },
+	{ }
+};
+
+static int __init tegra_flowctrl_init(void)
+{
+	/* hardcoded fallback if device tree node is missing */
+	unsigned long base = 0x60007000;
+	unsigned long size = SZ_4K;
+	struct device_node *np;
+
+	if (!soc_is_tegra())
+		return 0;
+
+	np = of_find_matching_node(NULL, matches);
+	if (np) {
+		struct resource res;
+
+		if (of_address_to_resource(np, 0, &res) == 0) {
+			size = resource_size(&res);
+			base = res.start;
+		}
+
+		of_node_put(np);
+	}
+
+	tegra_flowctrl_base = ioremap_nocache(base, size);
+	if (!tegra_flowctrl_base)
+		return -ENXIO;
+
+	return 0;
+}
+early_initcall(tegra_flowctrl_init);
diff --git a/include/soc/tegra/flowctrl.h b/include/soc/tegra/flowctrl.h
new file mode 100644
index 000000000000..8f86aea4024b
--- /dev/null
+++ b/include/soc/tegra/flowctrl.h
@@ -0,0 +1,82 @@
+/*
+ * Functions and macros to control the flowcontroller
+ *
+ * Copyright (c) 2010-2012, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __SOC_TEGRA_FLOWCTRL_H__
+#define __SOC_TEGRA_FLOWCTRL_H__
+
+#define FLOW_CTRL_HALT_CPU0_EVENTS	0x0
+#define FLOW_CTRL_WAITEVENT		(2 << 29)
+#define FLOW_CTRL_WAIT_FOR_INTERRUPT	(4 << 29)
+#define FLOW_CTRL_JTAG_RESUME		(1 << 28)
+#define FLOW_CTRL_SCLK_RESUME		(1 << 27)
+#define FLOW_CTRL_HALT_CPU_IRQ		(1 << 10)
+#define	FLOW_CTRL_HALT_CPU_FIQ		(1 << 8)
+#define FLOW_CTRL_HALT_LIC_IRQ		(1 << 11)
+#define FLOW_CTRL_HALT_LIC_FIQ		(1 << 10)
+#define FLOW_CTRL_HALT_GIC_IRQ		(1 << 9)
+#define FLOW_CTRL_HALT_GIC_FIQ		(1 << 8)
+#define FLOW_CTRL_CPU0_CSR		0x8
+#define	FLOW_CTRL_CSR_INTR_FLAG		(1 << 15)
+#define FLOW_CTRL_CSR_EVENT_FLAG	(1 << 14)
+#define FLOW_CTRL_CSR_ENABLE_EXT_CRAIL	(1 << 13)
+#define FLOW_CTRL_CSR_ENABLE_EXT_NCPU	(1 << 12)
+#define FLOW_CTRL_CSR_ENABLE_EXT_MASK ( \
+		FLOW_CTRL_CSR_ENABLE_EXT_NCPU | \
+		FLOW_CTRL_CSR_ENABLE_EXT_CRAIL)
+#define FLOW_CTRL_CSR_ENABLE		(1 << 0)
+#define FLOW_CTRL_HALT_CPU1_EVENTS	0x14
+#define FLOW_CTRL_CPU1_CSR		0x18
+
+#define TEGRA20_FLOW_CTRL_CSR_WFE_CPU0		(1 << 4)
+#define TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP	(3 << 4)
+#define TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP	0
+
+#define TEGRA30_FLOW_CTRL_CSR_WFI_CPU0		(1 << 8)
+#define TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP	(0xF << 4)
+#define TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP	(0xF << 8)
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_SOC_TEGRA_FLOWCTRL
+u32 flowctrl_read_cpu_csr(unsigned int cpuid);
+void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value);
+void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value);
+
+void flowctrl_cpu_suspend_enter(unsigned int cpuid);
+void flowctrl_cpu_suspend_exit(unsigned int cpuid);
+#else
+static inline u32 flowctrl_read_cpu_csr(unsigned int cpuid)
+{
+	return 0;
+}
+
+static inline void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value)
+{
+}
+
+static inline void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value) {}
+
+static inline void flowctrl_cpu_suspend_enter(unsigned int cpuid)
+{
+}
+
+static inline void flowctrl_cpu_suspend_exit(unsigned int cpuid)
+{
+}
+#endif /* CONFIG_SOC_TEGRA_FLOWCTRL */
+#endif /* __ASSEMBLY */
+#endif /* __SOC_TEGRA_FLOWCTRL_H__ */
-- 
2.7.4
