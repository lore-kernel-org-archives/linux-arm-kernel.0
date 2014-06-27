From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 18:58:46 +0200
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
Message-ID: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

These drivers are closely coupled and need to be moved as a whole. One
reason for moving them out of arch/arm/mach-tegra is to allow them to be
shared with 64-bit ARM.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                       | 32 --------
 arch/arm/mach-tegra/common.h                       |  4 -
 arch/arm/mach-tegra/io.c                           | 27 +++++-
 arch/arm/mach-tegra/pmc.h                          | 62 --------------
 arch/arm/mach-tegra/tegra.c                        |  9 --
 drivers/soc/Makefile                               |  1 +
 drivers/soc/tegra/Makefile                         | 34 ++++++++
 .../soc/tegra}/cpuidle-tegra114.c                  |  0
 .../soc/tegra}/cpuidle-tegra20.c                   |  6 +-
 .../soc/tegra}/cpuidle-tegra30.c                   |  0
 .../arm/mach-tegra => drivers/soc/tegra}/cpuidle.c |  0
 .../arm/mach-tegra => drivers/soc/tegra}/cpuidle.h |  3 -
 .../mach-tegra => drivers/soc/tegra}/flowctrl.c    |  0
 .../mach-tegra => drivers/soc/tegra}/flowctrl.h    |  2 -
 .../arm/mach-tegra => drivers/soc/tegra}/headsmp.S |  0
 .../arm/mach-tegra => drivers/soc/tegra}/hotplug.c |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/iomap.h |  0
 .../arm/mach-tegra => drivers/soc/tegra}/irammap.h |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/irq.c   |  1 -
 {arch/arm/mach-tegra => drivers/soc/tegra}/irq.h   |  6 --
 .../arm/mach-tegra => drivers/soc/tegra}/platsmp.c |  5 --
 .../mach-tegra => drivers/soc/tegra}/pm-tegra20.c  |  0
 .../mach-tegra => drivers/soc/tegra}/pm-tegra30.c  |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/pm.c    |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/pm.h    |  4 +-
 {arch/arm/mach-tegra => drivers/soc/tegra}/pmc.c   |  0
 drivers/soc/tegra/pmc.h                            | 35 ++++++++
 .../mach-tegra => drivers/soc/tegra}/powergate.c   |  0
 .../soc/tegra}/reset-handler.S                     |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h |  2 -
 .../soc/tegra}/sleep-tegra20.S                     |  0
 .../soc/tegra}/sleep-tegra30.S                     |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.S |  0
 {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.h |  2 -
 include/linux/tegra-soc.h                          | 95 ++++++++++++++++++++++
 36 files changed, 195 insertions(+), 135 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/common.h
 delete mode 100644 arch/arm/mach-tegra/pmc.h
 create mode 100644 drivers/soc/tegra/Makefile
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra114.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra20.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra30.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.h (91%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.h (98%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/headsmp.S (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/hotplug.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/iomap.h (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/irammap.h (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/irq.c (99%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/irq.h (83%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/platsmp.c (98%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm-tegra20.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm-tegra30.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm.h (94%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/pmc.c (100%)
 create mode 100644 drivers/soc/tegra/pmc.h
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/powergate.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset-handler.S (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h (97%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep-tegra20.S (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep-tegra30.S (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.S (100%)
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.h (98%)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index c303b55de22e..bed5b9b0c17a 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,38 +1,6 @@
 asflags-y				+= -march=armv7-a
 
 obj-y                                   += io.o
-obj-y                                   += irq.o
-obj-y					+= pmc.o
-obj-y					+= flowctrl.o
-obj-y					+= powergate.o
-obj-y					+= pm.o
-obj-y					+= reset.o
-obj-y					+= reset-handler.o
-obj-y					+= sleep.o
 obj-y					+= tegra.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
-endif
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
-endif
-obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
-
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
-endif
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= cpuidle-tegra114.o
-endif
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
deleted file mode 100644
index 5900cc44f780..000000000000
--- a/arch/arm/mach-tegra/common.h
+++ /dev/null
@@ -1,4 +0,0 @@
-extern struct smp_operations tegra_smp_ops;
-
-extern int tegra_cpu_kill(unsigned int cpu);
-extern void tegra_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index bb9c9c29d181..2d68275aeadb 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -28,7 +28,32 @@
 #include <asm/mach/map.h>
 
 #include "board.h"
-#include "iomap.h"
+
+/*
+ * On TEGRA, many peripherals are very closely packed in
+ * two 256MB io windows (that actually only use about 64KB
+ * at the start of each).
+ *
+ * We will just map the first MMU section of each window (to minimize
+ * pt entries needed) and provide a macro to transform physical
+ * io addresses to an appropriate void __iomem *.
+ */
+
+#define IO_IRAM_PHYS	0x40000000
+#define IO_IRAM_VIRT	IOMEM(0xFE400000)
+#define IO_IRAM_SIZE	SZ_256K
+
+#define IO_CPU_PHYS	0x50040000
+#define IO_CPU_VIRT	IOMEM(0xFE440000)
+#define IO_CPU_SIZE	SZ_16K
+
+#define IO_PPSB_PHYS	0x60000000
+#define IO_PPSB_VIRT	IOMEM(0xFE200000)
+#define IO_PPSB_SIZE	SECTION_SIZE
+
+#define IO_APB_PHYS	0x70000000
+#define IO_APB_VIRT	IOMEM(0xFE000000)
+#define IO_APB_SIZE	SECTION_SIZE
 
 static struct map_desc tegra_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
deleted file mode 100644
index 139a30867cb2..000000000000
--- a/arch/arm/mach-tegra/pmc.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (C) 2012 NVIDIA CORPORATION. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-#ifndef __MACH_TEGRA_PMC_H
-#define __MACH_TEGRA_PMC_H
-
-#include <linux/io.h>
-#include <linux/reboot.h>
-
-enum tegra_suspend_mode {
-	TEGRA_SUSPEND_NONE = 0,
-	TEGRA_SUSPEND_LP2,	/* CPU voltage off */
-	TEGRA_SUSPEND_LP1,	/* CPU voltage off, DRAM self-refresh */
-	TEGRA_SUSPEND_LP0,      /* CPU + core voltage off, DRAM self-refresh */
-	TEGRA_MAX_SUSPEND_MODE,
-};
-
-#ifdef CONFIG_PM_SLEEP
-enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
-void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
-void tegra_pmc_suspend(void);
-void tegra_pmc_resume(void);
-void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
-void tegra_pmc_suspend_init(void);
-#endif
-
-extern void __iomem *tegra_pmc_base;
-
-static inline u32 tegra_pmc_readl(u32 reg)
-{
-	return readl(tegra_pmc_base + reg);
-}
-
-static inline void tegra_pmc_writel(u32 val, u32 reg)
-{
-	writel(val, tegra_pmc_base + reg);
-}
-
-bool tegra_pmc_cpu_is_powered(int cpuid);
-int tegra_pmc_cpu_power_on(int cpuid);
-int tegra_pmc_cpu_remove_clamping(int cpuid);
-
-void tegra_pmc_restart(enum reboot_mode mode, const char *cmd);
-
-void tegra_pmc_init_irq(void);
-void tegra_pmc_init(void);
-
-#endif
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index ab6544576eac..cea2db665b1f 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -44,15 +44,6 @@
 #include <asm/trusted_foundations.h>
 
 #include "board.h"
-#include "common.h"
-#include "cpuidle.h"
-#include "flowctrl.h"
-#include "iomap.h"
-#include "irq.h"
-#include "pmc.h"
-#include "pm.h"
-#include "reset.h"
-#include "sleep.h"
 
 /*
  * Storage for debug-macro.S's state.
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 0f7c44793b29..3b1b95d932d1 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
new file mode 100644
index 000000000000..6fd8790c314d
--- /dev/null
+++ b/drivers/soc/tegra/Makefile
@@ -0,0 +1,34 @@
+asflags-y += -march=armv7-a
+
+obj-y += flowctrl.o
+obj-y += irq.o
+obj-y += pm.o
+obj-y += pmc.o
+obj-y += powergate.o
+obj-y += reset.o
+obj-y += reset-handler.o
+obj-y += sleep.o
+
+
+obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
+obj-$(CONFIG_SMP) += platsmp.o headsmp.o
+
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC) += pm-tegra20.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC) += sleep-tegra20.o
+
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC) += pm-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC) += sleep-tegra30.o
+
+obj-$(CONFIG_ARCH_TEGRA_114_SOC) += pm-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_114_SOC) += sleep-tegra30.o
+
+obj-$(CONFIG_ARCH_TEGRA_124_SOC) += pm-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_124_SOC) += sleep-tegra30.o
+
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-y += cpuidle.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC) += cpuidle-tegra20.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC) += cpuidle-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_114_SOC) += cpuidle-tegra114.o
+obj-$(CONFIG_ARCH_TEGRA_124_SOC) += cpuidle-tegra114.o
+endif
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/drivers/soc/tegra/cpuidle-tegra114.c
similarity index 100%
rename from arch/arm/mach-tegra/cpuidle-tegra114.c
rename to drivers/soc/tegra/cpuidle-tegra114.c
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/drivers/soc/tegra/cpuidle-tegra20.c
similarity index 100%
rename from arch/arm/mach-tegra/cpuidle-tegra20.c
rename to drivers/soc/tegra/cpuidle-tegra20.c
index b82dcaee2ef4..0710e48f79e0 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/drivers/soc/tegra/cpuidle-tegra20.c
@@ -31,11 +31,11 @@
 #include <asm/suspend.h>
 #include <asm/smp_plat.h>
 
-#include "pm.h"
-#include "sleep.h"
+#include "flowctrl.h"
 #include "iomap.h"
 #include "irq.h"
-#include "flowctrl.h"
+#include "pm.h"
+#include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
 static bool abort_flag;
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/drivers/soc/tegra/cpuidle-tegra30.c
similarity index 100%
rename from arch/arm/mach-tegra/cpuidle-tegra30.c
rename to drivers/soc/tegra/cpuidle-tegra30.c
diff --git a/arch/arm/mach-tegra/cpuidle.c b/drivers/soc/tegra/cpuidle.c
similarity index 100%
rename from arch/arm/mach-tegra/cpuidle.c
rename to drivers/soc/tegra/cpuidle.c
diff --git a/arch/arm/mach-tegra/cpuidle.h b/drivers/soc/tegra/cpuidle.h
similarity index 91%
rename from arch/arm/mach-tegra/cpuidle.h
rename to drivers/soc/tegra/cpuidle.h
index c017dab60ffa..6f5b61d317fd 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/drivers/soc/tegra/cpuidle.h
@@ -22,9 +22,6 @@ int tegra20_cpuidle_init(void);
 void tegra20_cpuidle_pcie_irqs_in_use(void);
 int tegra30_cpuidle_init(void);
 int tegra114_cpuidle_init(void);
-void tegra_cpuidle_init(void);
-#else
-static inline void tegra_cpuidle_init(void) {}
 #endif
 
 #endif
diff --git a/arch/arm/mach-tegra/flowctrl.c b/drivers/soc/tegra/flowctrl.c
similarity index 100%
rename from arch/arm/mach-tegra/flowctrl.c
rename to drivers/soc/tegra/flowctrl.c
diff --git a/arch/arm/mach-tegra/flowctrl.h b/drivers/soc/tegra/flowctrl.h
similarity index 98%
rename from arch/arm/mach-tegra/flowctrl.h
rename to drivers/soc/tegra/flowctrl.h
index 73a9c5016c1a..c89aac60a143 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/drivers/soc/tegra/flowctrl.h
@@ -59,8 +59,6 @@ void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value);
 
 void flowctrl_cpu_suspend_enter(unsigned int cpuid);
 void flowctrl_cpu_suspend_exit(unsigned int cpuid);
-
-void tegra_flowctrl_init(void);
 #endif
 
 #endif
diff --git a/arch/arm/mach-tegra/headsmp.S b/drivers/soc/tegra/headsmp.S
similarity index 100%
rename from arch/arm/mach-tegra/headsmp.S
rename to drivers/soc/tegra/headsmp.S
diff --git a/arch/arm/mach-tegra/hotplug.c b/drivers/soc/tegra/hotplug.c
similarity index 100%
rename from arch/arm/mach-tegra/hotplug.c
rename to drivers/soc/tegra/hotplug.c
diff --git a/arch/arm/mach-tegra/iomap.h b/drivers/soc/tegra/iomap.h
similarity index 100%
rename from arch/arm/mach-tegra/iomap.h
rename to drivers/soc/tegra/iomap.h
diff --git a/arch/arm/mach-tegra/irammap.h b/drivers/soc/tegra/irammap.h
similarity index 100%
rename from arch/arm/mach-tegra/irammap.h
rename to drivers/soc/tegra/irammap.h
diff --git a/arch/arm/mach-tegra/irq.c b/drivers/soc/tegra/irq.c
similarity index 99%
rename from arch/arm/mach-tegra/irq.c
rename to drivers/soc/tegra/irq.c
index 1a74d562dca1..57807a79f5fd 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/drivers/soc/tegra/irq.c
@@ -27,7 +27,6 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/syscore_ops.h>
 
-#include "board.h"
 #include "iomap.h"
 
 #define ICTLR_CPU_IEP_VFIQ	0x08
diff --git a/arch/arm/mach-tegra/irq.h b/drivers/soc/tegra/irq.h
similarity index 83%
rename from arch/arm/mach-tegra/irq.h
rename to drivers/soc/tegra/irq.h
index bc05ce5613fb..5142649bba05 100644
--- a/arch/arm/mach-tegra/irq.h
+++ b/drivers/soc/tegra/irq.h
@@ -19,10 +19,4 @@
 
 bool tegra_pending_sgi(void);
 
-#ifdef CONFIG_PM_SLEEP
-int tegra_legacy_irq_syscore_init(void);
-#else
-static inline int tegra_legacy_irq_syscore_init(void) { return 0; }
-#endif
-
 #endif
diff --git a/arch/arm/mach-tegra/platsmp.c b/drivers/soc/tegra/platsmp.c
similarity index 98%
rename from arch/arm/mach-tegra/platsmp.c
rename to drivers/soc/tegra/platsmp.c
index d9878acae3d2..f3622181d39e 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/drivers/soc/tegra/platsmp.c
@@ -27,10 +27,6 @@
 #include <asm/smp_plat.h>
 
 #include "flowctrl.h"
-#include "reset.h"
-#include "pmc.h"
-
-#include "common.h"
 #include "iomap.h"
 
 static cpumask_t tegra_cpu_init_mask;
@@ -40,7 +36,6 @@ static void tegra_secondary_init(unsigned int cpu)
 	cpumask_set_cpu(cpu, &tegra_cpu_init_mask);
 }
 
-
 static int tegra20_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	cpu = cpu_logical_map(cpu);
diff --git a/arch/arm/mach-tegra/pm-tegra20.c b/drivers/soc/tegra/pm-tegra20.c
similarity index 100%
rename from arch/arm/mach-tegra/pm-tegra20.c
rename to drivers/soc/tegra/pm-tegra20.c
diff --git a/arch/arm/mach-tegra/pm-tegra30.c b/drivers/soc/tegra/pm-tegra30.c
similarity index 100%
rename from arch/arm/mach-tegra/pm-tegra30.c
rename to drivers/soc/tegra/pm-tegra30.c
diff --git a/arch/arm/mach-tegra/pm.c b/drivers/soc/tegra/pm.c
similarity index 100%
rename from arch/arm/mach-tegra/pm.c
rename to drivers/soc/tegra/pm.c
diff --git a/arch/arm/mach-tegra/pm.h b/drivers/soc/tegra/pm.h
similarity index 94%
rename from arch/arm/mach-tegra/pm.h
rename to drivers/soc/tegra/pm.h
index f4a89698e5b0..0d899557ffeb 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/drivers/soc/tegra/pm.h
@@ -21,7 +21,7 @@
 #ifndef _MACH_TEGRA_PM_H_
 #define _MACH_TEGRA_PM_H_
 
-#include "pmc.h"
+#include <linux/tegra-soc.h>
 
 struct tegra_lp1_iram {
 	void	*start_addr;
@@ -44,14 +44,12 @@ extern void (*tegra_tear_down_cpu)(void);
 #ifdef CONFIG_PM_SLEEP
 enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode);
-void tegra_init_suspend(void);
 #else
 static inline enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode)
 {
 	return TEGRA_SUSPEND_NONE;
 }
-static inline void tegra_init_suspend(void) {}
 #endif
 
 #endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/pmc.c b/drivers/soc/tegra/pmc.c
similarity index 100%
rename from arch/arm/mach-tegra/pmc.c
rename to drivers/soc/tegra/pmc.c
diff --git a/drivers/soc/tegra/pmc.h b/drivers/soc/tegra/pmc.h
new file mode 100644
index 000000000000..45643454e5cd
--- /dev/null
+++ b/drivers/soc/tegra/pmc.h
@@ -0,0 +1,35 @@
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
+#include <linux/io.h>
+
+extern void __iomem *tegra_pmc_base;
+
+static inline u32 tegra_pmc_readl(u32 reg)
+{
+	return readl(tegra_pmc_base + reg);
+}
+
+static inline void tegra_pmc_writel(u32 val, u32 reg)
+{
+	writel(val, tegra_pmc_base + reg);
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/powergate.c b/drivers/soc/tegra/powergate.c
similarity index 100%
rename from arch/arm/mach-tegra/powergate.c
rename to drivers/soc/tegra/powergate.c
diff --git a/arch/arm/mach-tegra/reset-handler.S b/drivers/soc/tegra/reset-handler.S
similarity index 100%
rename from arch/arm/mach-tegra/reset-handler.S
rename to drivers/soc/tegra/reset-handler.S
diff --git a/arch/arm/mach-tegra/reset.c b/drivers/soc/tegra/reset.c
similarity index 100%
rename from arch/arm/mach-tegra/reset.c
rename to drivers/soc/tegra/reset.c
diff --git a/arch/arm/mach-tegra/reset.h b/drivers/soc/tegra/reset.h
similarity index 97%
rename from arch/arm/mach-tegra/reset.h
rename to drivers/soc/tegra/reset.h
index 76a93434c6ee..e054cca2abea 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/drivers/soc/tegra/reset.h
@@ -57,7 +57,5 @@ void tegra_secondary_startup(void);
 		(__tegra_cpu_reset_handler_end - \
 		 __tegra_cpu_reset_handler_start)
 
-void __init tegra_cpu_reset_handler_init(void);
-
 #endif
 #endif
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/drivers/soc/tegra/sleep-tegra20.S
similarity index 100%
rename from arch/arm/mach-tegra/sleep-tegra20.S
rename to drivers/soc/tegra/sleep-tegra20.S
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/drivers/soc/tegra/sleep-tegra30.S
similarity index 100%
rename from arch/arm/mach-tegra/sleep-tegra30.S
rename to drivers/soc/tegra/sleep-tegra30.S
diff --git a/arch/arm/mach-tegra/sleep.S b/drivers/soc/tegra/sleep.S
similarity index 100%
rename from arch/arm/mach-tegra/sleep.S
rename to drivers/soc/tegra/sleep.S
diff --git a/arch/arm/mach-tegra/sleep.h b/drivers/soc/tegra/sleep.h
similarity index 98%
rename from arch/arm/mach-tegra/sleep.h
rename to drivers/soc/tegra/sleep.h
index 339fe42cd6fb..41b257f22b80 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/drivers/soc/tegra/sleep.h
@@ -121,7 +121,6 @@
 .endm
 
 #else
-void tegra_pen_lock(void);
 void tegra_pen_unlock(void);
 void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
@@ -130,7 +129,6 @@ void tegra_disable_clean_inv_dcache(u32 flag);
 #ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
-void tegra_hotplug_init(void);
 #else
 static inline void tegra_hotplug_init(void) {}
 #endif
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index fcf65ecbecca..9fb8c7261403 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -17,6 +17,10 @@
 #ifndef __LINUX_TEGRA_SOC_H_
 #define __LINUX_TEGRA_SOC_H_
 
+#ifndef __ASSEMBLY__
+#include <linux/reboot.h>
+#endif
+
 #define TEGRA20		0x20
 #define TEGRA30		0x30
 #define TEGRA114	0x35
@@ -59,6 +63,97 @@ int tegra_fuse_readl(u32 offset, u32 *val);
 extern int tegra_chip_id;
 extern struct tegra_sku_info tegra_sku_info;
 
+/*
+ * flow controller
+ */
+
+void tegra_flowctrl_init(void);
+
+/*
+ * CPU hotplug
+ */
+#ifdef CONFIG_HOTPLUG_CPU
+void tegra_cpu_die(unsigned int cpu);
+int tegra_cpu_kill(unsigned int cpu);
+void tegra_hotplug_init(void);
+#else
+static inline void tegra_hotplug_init(void)
+{
+}
+#endif
+
+/*
+ * CPU idle
+ */
+#ifdef CONFIG_CPU_IDLE
+void tegra_cpuidle_init(void);
+#else
+static inline void tegra_cpuidle_init(void)
+{
+}
+#endif
+
+/*
+ * IRQ
+ */
+#ifdef CONFIG_PM_SLEEP
+int tegra_legacy_irq_syscore_init(void);
+#else
+static inline int tegra_legacy_irq_syscore_init(void)
+{
+	return 0;
+}
+#endif
+
+/*
+ * power management controller (PMC)
+ */
+enum tegra_suspend_mode {
+	TEGRA_SUSPEND_NONE = 0,
+	TEGRA_SUSPEND_LP2,	/* CPU voltage off */
+	TEGRA_SUSPEND_LP1,	/* CPU voltage off, DRAM self-refresh */
+	TEGRA_SUSPEND_LP0,      /* CPU + core voltage off, DRAM self-refresh */
+	TEGRA_MAX_SUSPEND_MODE,
+};
+
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
+void tegra_pmc_suspend(void);
+void tegra_pmc_resume(void);
+void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
+void tegra_pmc_suspend_init(void);
+#endif
+
+void tegra_pmc_restart(enum reboot_mode mode, const char *cmd);
+
+void tegra_pmc_init_irq(void);
+void tegra_pmc_init(void);
+
+bool tegra_pmc_cpu_is_powered(int cpuid);
+int tegra_pmc_cpu_power_on(int cpuid);
+int tegra_pmc_cpu_remove_clamping(int cpuid);
+
+/*
+ * power management
+ */
+#ifdef CONFIG_PM_SLEEP
+void tegra_init_suspend(void);
+#else
+static inline void tegra_init_suspend(void)
+{
+}
+#endif
+
+/* reset */
+void __init tegra_cpu_reset_handler_init(void);
+
+/* sleep */
+void tegra_pen_lock(void);
+
+/* SMP */
+extern struct smp_operations tegra_smp_ops;
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_TEGRA_SOC_H_ */
-- 
2.0.0
