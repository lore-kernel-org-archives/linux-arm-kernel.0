From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:25:05 -0600
Subject: [PATCH 1/7] ARM: tegra: remove common.c
In-Reply-To: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1379096711-26875-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

common.c was create to contain code shared across the various Tegra board
files. There is now only one board file, tegra.c. So, move the code there.
One exception is the PMC reboot routine, which moves to pmc.c, and now
takes advantage of the 'standard' tegra_pmc_readl/writel functions.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Makefile |   1 -
 arch/arm/mach-tegra/board.h  |   6 ---
 arch/arm/mach-tegra/common.c | 113 -------------------------------------------
 arch/arm/mach-tegra/pmc.c    |   9 ++++
 arch/arm/mach-tegra/pmc.h    |   4 ++
 arch/arm/mach-tegra/tegra.c  |  67 ++++++++++++++++++++++++-
 6 files changed, 78 insertions(+), 122 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/common.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e7e5f45..97eb48e 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,6 +1,5 @@
 asflags-y				+= -march=armv7-a
 
-obj-y                                   += common.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y					+= fuse.o
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index db6810d..7b9a5bd 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -25,14 +25,8 @@
 #include <linux/types.h>
 #include <linux/reboot.h>
 
-void tegra_assert_system_reset(enum reboot_mode mode, const char *cmd);
-
-void __init tegra_init_early(void);
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
-void __init tegra_dt_init_irq(void);
-
-void tegra_init_late(void);
 
 #ifdef CONFIG_DEBUG_FS
 int tegra_clk_debugfs_init(void);
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
deleted file mode 100644
index 58dc91c5..0000000
--- a/arch/arm/mach-tegra/common.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * arch/arm/mach-tegra/common.c
- *
- * Copyright (c) 2013 NVIDIA Corporation. All rights reserved.
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@android.com>
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
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/reboot.h>
-#include <linux/irqchip.h>
-
-#include <asm/hardware/cache-l2x0.h>
-
-#include "board.h"
-#include "common.h"
-#include "cpuidle.h"
-#include "fuse.h"
-#include "iomap.h"
-#include "irq.h"
-#include "pmc.h"
-#include "apbio.h"
-#include "sleep.h"
-#include "pm.h"
-#include "reset.h"
-
-/*
- * Storage for debug-macro.S's state.
- *
- * This must be in .data not .bss so that it gets initialized each time the
- * kernel is loaded. The data is declared here rather than debug-macro.S so
- * that multiple inclusions of debug-macro.S point at the same data.
- */
-u32 tegra_uart_config[4] = {
-	/* Debug UART initialization required */
-	1,
-	/* Debug UART physical address */
-	0,
-	/* Debug UART virtual address */
-	0,
-	/* Scratch space for debug macro */
-	0,
-};
-
-#ifdef CONFIG_OF
-void __init tegra_dt_init_irq(void)
-{
-	tegra_pmc_init_irq();
-	tegra_init_irq();
-	irqchip_init();
-	tegra_legacy_irq_syscore_init();
-}
-#endif
-
-void tegra_assert_system_reset(enum reboot_mode mode, const char *cmd)
-{
-	void __iomem *reset = IO_ADDRESS(TEGRA_PMC_BASE + 0);
-	u32 reg;
-
-	reg = readl_relaxed(reset);
-	reg |= 0x10;
-	writel_relaxed(reg, reset);
-}
-
-static void __init tegra_init_cache(void)
-{
-#ifdef CONFIG_CACHE_L2X0
-	int ret;
-	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
-	u32 aux_ctrl, cache_type;
-
-	cache_type = readl(p + L2X0_CACHE_TYPE);
-	aux_ctrl = (cache_type & 0x700) << (17-8);
-	aux_ctrl |= 0x7C400001;
-
-	ret = l2x0_of_init(aux_ctrl, 0x8200c3fe);
-	if (!ret)
-		l2x0_saved_regs_addr = virt_to_phys(&l2x0_saved_regs);
-#endif
-
-}
-
-void __init tegra_init_early(void)
-{
-	tegra_cpu_reset_handler_init();
-	tegra_apb_io_init();
-	tegra_init_fuse();
-	tegra_init_cache();
-	tegra_powergate_init();
-	tegra_hotplug_init();
-}
-
-void __init tegra_init_late(void)
-{
-	tegra_init_suspend();
-	tegra_cpuidle_init();
-	tegra_powergate_debugfs_init();
-}
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 7916ff9..93a4dbc 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -166,6 +166,15 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 	return tegra_pmc_powergate_remove_clamping(id);
 }
 
+void tegra_pmc_restart(enum reboot_mode mode, const char *cmd)
+{
+	u32 val;
+
+	val = tegra_pmc_readl(0);
+	val |= 0x10;
+	tegra_pmc_writel(val, 0);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static void set_power_timers(u32 us_on, u32 us_off, unsigned long rate)
 {
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 4d5f8f3..59e19c34 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -18,6 +18,8 @@
 #ifndef __MACH_TEGRA_PMC_H
 #define __MACH_TEGRA_PMC_H
 
+#include <linux/reboot.h>
+
 enum tegra_suspend_mode {
 	TEGRA_SUSPEND_NONE = 0,
 	TEGRA_SUSPEND_LP2,	/* CPU voltage off */
@@ -39,6 +41,8 @@ bool tegra_pmc_cpu_is_powered(int cpuid);
 int tegra_pmc_cpu_power_on(int cpuid);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
 
+void tegra_pmc_restart(enum reboot_mode mode, const char *cmd);
+
 void tegra_pmc_init_irq(void);
 void tegra_pmc_init(void);
 
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 4da271d..40b031c 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -35,17 +35,78 @@
 #include <linux/usb/tegra_usb_phy.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/tegra.h>
+#include <linux/irqchip.h>
 
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/setup.h>
 
+#include "apbio.h"
 #include "board.h"
 #include "common.h"
+#include "cpuidle.h"
 #include "fuse.h"
 #include "iomap.h"
+#include "irq.h"
 #include "pmc.h"
+#include "pm.h"
+#include "reset.h"
+#include "sleep.h"
+
+/*
+ * Storage for debug-macro.S's state.
+ *
+ * This must be in .data not .bss so that it gets initialized each time the
+ * kernel is loaded. The data is declared here rather than debug-macro.S so
+ * that multiple inclusions of debug-macro.S point at the same data.
+ */
+u32 tegra_uart_config[4] = {
+	/* Debug UART initialization required */
+	1,
+	/* Debug UART physical address */
+	0,
+	/* Debug UART virtual address */
+	0,
+	/* Scratch space for debug macro */
+	0,
+};
+
+static void __init tegra_init_cache(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	int ret;
+	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
+	u32 aux_ctrl, cache_type;
+
+	cache_type = readl(p + L2X0_CACHE_TYPE);
+	aux_ctrl = (cache_type & 0x700) << (17-8);
+	aux_ctrl |= 0x7C400001;
+
+	ret = l2x0_of_init(aux_ctrl, 0x8200c3fe);
+	if (!ret)
+		l2x0_saved_regs_addr = virt_to_phys(&l2x0_saved_regs);
+#endif
+}
+
+static void __init tegra_init_early(void)
+{
+	tegra_cpu_reset_handler_init();
+	tegra_apb_io_init();
+	tegra_init_fuse();
+	tegra_init_cache();
+	tegra_powergate_init();
+	tegra_hotplug_init();
+}
+
+static void __init tegra_dt_init_irq(void)
+{
+	tegra_pmc_init_irq();
+	tegra_init_irq();
+	irqchip_init();
+	tegra_legacy_irq_syscore_init();
+}
 
 static void __init tegra_dt_init(void)
 {
@@ -107,7 +168,9 @@ static void __init tegra_dt_init_late(void)
 {
 	int i;
 
-	tegra_init_late();
+	tegra_init_suspend();
+	tegra_cpuidle_init();
+	tegra_powergate_debugfs_init();
 
 	for (i = 0; i < ARRAY_SIZE(board_init_funcs); i++) {
 		if (of_machine_is_compatible(board_init_funcs[i].machine)) {
@@ -132,6 +195,6 @@ DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
 	.init_time	= tegra_dt_init_time,
 	.init_machine	= tegra_dt_init,
 	.init_late	= tegra_dt_init_late,
-	.restart	= tegra_assert_system_reset,
+	.restart	= tegra_pmc_restart,
 	.dt_compat	= tegra_dt_board_compat,
 MACHINE_END
-- 
1.8.1.5
