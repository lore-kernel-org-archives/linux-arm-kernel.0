From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Feb 2013 21:42:08 -0600
Subject: [PATCH 4/4] ARM: highbank: adapt to use ARM PSCI calls
In-Reply-To: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
Message-ID: <1361936528-25998-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adapts highbank to use the ARM PSCI calls for cpu power control.
Secondary core boot, cpu hotplug, suspend/resume, reset and poweroff are
all converted to use PSCI calls. Doing this removes direct access to the
SCU and factors out the A9 vs. A15 differences.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/Kconfig    |    2 +-
 arch/arm/mach-highbank/Makefile   |    2 +-
 arch/arm/mach-highbank/core.h     |    3 --
 arch/arm/mach-highbank/highbank.c |   49 +++++----------------------
 arch/arm/mach-highbank/hotplug.c  |   12 +------
 arch/arm/mach-highbank/platsmp.c  |   42 ++++-------------------
 arch/arm/mach-highbank/pm.c       |   25 +++++---------
 arch/arm/mach-highbank/sysregs.h  |   67 ++++++-------------------------------
 arch/arm/mach-highbank/system.c   |   32 ------------------
 drivers/mailbox/pl320-ipc.c       |    2 +-
 10 files changed, 39 insertions(+), 197 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/system.c

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 44b12f9..9dc0c9e 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -5,13 +5,13 @@ config ARCH_HIGHBANK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_PSCI
 	select ARM_TIMER_SP804
 	select CACHE_L2X0
 	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select HAVE_ARM_SCU
 	select HAVE_SMP
 	select MAILBOX
 	select PL320_MBOX
diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
index 8a1ef57..c1dde52 100644
--- a/arch/arm/mach-highbank/Makefile
+++ b/arch/arm/mach-highbank/Makefile
@@ -1,4 +1,4 @@
-obj-y					:= highbank.o system.o smc.o
+obj-y					:= highbank.o smc.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
index 3f65206..b8bcde7 100644
--- a/arch/arm/mach-highbank/core.h
+++ b/arch/arm/mach-highbank/core.h
@@ -1,9 +1,6 @@
 #ifndef __HIGHBANK_CORE_H
 #define __HIGHBANK_CORE_H
 
-extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
-extern void highbank_restart(char, const char *);
-extern void __iomem *scu_base_addr;
 
 #ifdef CONFIG_PM_SLEEP
 extern void highbank_pm_init(void);
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 3a5e62c..e8c9382 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -26,9 +26,6 @@
 #include <linux/clk-provider.h>
 
 #include <asm/arch_timer.h>
-#include <asm/cacheflush.h>
-#include <asm/cputype.h>
-#include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
@@ -40,50 +37,15 @@
 #include "sysregs.h"
 
 void __iomem *sregs_base;
-void __iomem *scu_base_addr;
-
-static void __init highbank_scu_map_io(void)
-{
-	unsigned long base;
-
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
-
-	scu_base_addr = ioremap(base, SZ_4K);
-}
-
-#define HB_JUMP_TABLE_PHYS(cpu)		(0x40 + (0x10 * (cpu)))
-#define HB_JUMP_TABLE_VIRT(cpu)		phys_to_virt(HB_JUMP_TABLE_PHYS(cpu))
-
-void highbank_set_cpu_jump(int cpu, void *jump_addr)
-{
-	cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 0);
-	writel(virt_to_phys(jump_addr), HB_JUMP_TABLE_VIRT(cpu));
-	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
-	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
-			  HB_JUMP_TABLE_PHYS(cpu) + 15);
-}
-
-#ifdef CONFIG_CACHE_L2X0
-static void highbank_l2x0_disable(void)
-{
-	/* Disable PL310 L2 Cache controller */
-	highbank_smc1(0x102, 0x0);
-}
-#endif
 
 static void __init highbank_init_irq(void)
 {
 	irqchip_init();
 
-	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
-		highbank_scu_map_io();
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Enable PL310 L2 Cache controller */
 	highbank_smc1(0x102, 0x1);
 	l2x0_of_init(0, ~0UL);
-	outer_cache.disable = highbank_l2x0_disable;
 #endif
 }
 
@@ -123,10 +85,15 @@ static void __init highbank_timer_init(void)
 
 static void highbank_power_off(void)
 {
-	highbank_set_pwr_shutdown();
+	highbank_cpu_off(HB_PWR_SHUTDOWN, 1);
+}
 
-	while (1)
-		cpu_do_idle();
+static void highbank_restart(char mode, const char *cmd)
+{
+	if (mode == 'h')
+		highbank_cpu_off(HB_PWR_HARD_RESET, 1);
+	else
+		highbank_cpu_off(HB_PWR_SOFT_RESET, 1);
 }
 
 static int highbank_platform_notifier(struct notifier_block *nb,
diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
index f30c528..dc65b0f 100644
--- a/arch/arm/mach-highbank/hotplug.c
+++ b/arch/arm/mach-highbank/hotplug.c
@@ -15,25 +15,15 @@
  */
 #include <linux/kernel.h>
 
-#include <asm/cacheflush.h>
-
-#include "core.h"
 #include "sysregs.h"
 
-extern void secondary_startup(void);
-
 /*
  * platform-specific code to shutdown a CPU
  *
  */
 void __ref highbank_cpu_die(unsigned int cpu)
 {
-	flush_cache_all();
-
-	highbank_set_cpu_jump(cpu, phys_to_virt(0));
-	highbank_set_core_pwr();
-
-	cpu_do_idle();
+	highbank_cpu_off(0, 0);
 
 	/* We should never return from idle */
 	panic("highbank: cpu %d unexpectedly exit from shutdown\n", cpu);
diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
index 8797a70..33ae6ca 100644
--- a/arch/arm/mach-highbank/platsmp.c
+++ b/arch/arm/mach-highbank/platsmp.c
@@ -16,10 +16,10 @@
  */
 #include <linux/init.h>
 #include <linux/smp.h>
-#include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
-
-#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
+#include <asm/psci.h>
+#include <asm/page.h>
 
 #include "core.h"
 
@@ -32,41 +32,13 @@ static void __cpuinit highbank_secondary_init(unsigned int cpu)
 
 static int __cpuinit highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	highbank_set_cpu_jump(cpu, secondary_startup);
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
-	return 0;
-}
-
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-static void __init highbank_smp_init_cpus(void)
-{
-	unsigned int i, ncores = 4;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "highbank: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-}
-
-static void __init highbank_smp_prepare_cpus(unsigned int max_cpus)
-{
-	if (scu_base_addr)
-		scu_enable(scu_base_addr);
+	if (psci_ops.cpu_on)
+		return psci_ops.cpu_on(cpu_logical_map(cpu),
+				       __pa(secondary_startup));
+	return -ENODEV;
 }
 
 struct smp_operations highbank_smp_ops __initdata = {
-	.smp_init_cpus		= highbank_smp_init_cpus,
-	.smp_prepare_cpus	= highbank_smp_prepare_cpus,
 	.smp_secondary_init	= highbank_secondary_init,
 	.smp_boot_secondary	= highbank_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 04eddb4..d1f511b 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -16,27 +16,21 @@
 
 #include <linux/cpu_pm.h>
 #include <linux/init.h>
-#include <linux/io.h>
 #include <linux/suspend.h>
 
-#include <asm/cacheflush.h>
-#include <asm/proc-fns.h>
 #include <asm/suspend.h>
 
-#include "core.h"
 #include "sysregs.h"
 
 static int highbank_suspend_finish(unsigned long val)
 {
-	outer_flush_all();
-	outer_disable();
+	const struct psci_power_state ps = {
+		.id = HB_PWR_SUSPEND,
+		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+		.affinity_level = 1,
+	};
 
-	highbank_set_pwr_suspend();
-
-	cpu_do_idle();
-
-	highbank_clear_pwr_request();
-	return 0;
+	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
 }
 
 static int highbank_pm_enter(suspend_state_t state)
@@ -44,15 +38,11 @@ static int highbank_pm_enter(suspend_state_t state)
 	cpu_pm_enter();
 	cpu_cluster_pm_enter();
 
-	highbank_set_cpu_jump(0, cpu_resume);
 	cpu_suspend(0, highbank_suspend_finish);
 
 	cpu_cluster_pm_exit();
 	cpu_pm_exit();
 
-	highbank_smc1(0x102, 0x1);
-	if (scu_base_addr)
-		scu_enable(scu_base_addr);
 	return 0;
 }
 
@@ -63,5 +53,8 @@ static const struct platform_suspend_ops highbank_pm_ops = {
 
 void __init highbank_pm_init(void)
 {
+	if (!psci_ops.cpu_suspend)
+		return;
+
 	suspend_set_ops(&highbank_pm_ops);
 }
diff --git a/arch/arm/mach-highbank/sysregs.h b/arch/arm/mach-highbank/sysregs.h
index 5995df7..38818f3 100644
--- a/arch/arm/mach-highbank/sysregs.h
+++ b/arch/arm/mach-highbank/sysregs.h
@@ -16,71 +16,26 @@
 #ifndef _MACH_HIGHBANK__SYSREGS_H_
 #define _MACH_HIGHBANK__SYSREGS_H_
 
-#include <linux/io.h>
-#include <linux/smp.h>
-#include <asm/smp_plat.h>
-#include <asm/smp_scu.h>
-#include "core.h"
-
-extern void __iomem *sregs_base;
-
-#define HB_SREG_A9_PWR_REQ		0xf00
-#define HB_SREG_A9_BOOT_STAT		0xf04
-#define HB_SREG_A9_BOOT_DATA		0xf08
+#include <linux/err.h>
+#include <asm/psci.h>
 
 #define HB_PWR_SUSPEND			0
 #define HB_PWR_SOFT_RESET		1
 #define HB_PWR_HARD_RESET		2
 #define HB_PWR_SHUTDOWN			3
 
-#define SREG_CPU_PWR_CTRL(c)		(0x200 + ((c) * 4))
-
-static inline void highbank_set_core_pwr(void)
-{
-	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
-	if (scu_base_addr)
-		scu_power_mode(scu_base_addr, SCU_PM_POWEROFF);
-	else
-		writel_relaxed(1, sregs_base + SREG_CPU_PWR_CTRL(cpu));
-}
-
-static inline void highbank_clear_core_pwr(void)
+static inline int highbank_cpu_off(int id, int affinity_level)
 {
-	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
-	if (scu_base_addr)
-		scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
-	else
-		writel_relaxed(0, sregs_base + SREG_CPU_PWR_CTRL(cpu));
-}
+	struct psci_power_state ps = {
+		.id = id,
+		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+		.affinity_level = affinity_level,
+	};
 
-static inline void highbank_set_pwr_suspend(void)
-{
-	writel(HB_PWR_SUSPEND, sregs_base + HB_SREG_A9_PWR_REQ);
-	highbank_set_core_pwr();
-}
+	if (psci_ops.cpu_off)
+		return psci_ops.cpu_off(ps);
 
-static inline void highbank_set_pwr_shutdown(void)
-{
-	writel(HB_PWR_SHUTDOWN, sregs_base + HB_SREG_A9_PWR_REQ);
-	highbank_set_core_pwr();
-}
-
-static inline void highbank_set_pwr_soft_reset(void)
-{
-	writel(HB_PWR_SOFT_RESET, sregs_base + HB_SREG_A9_PWR_REQ);
-	highbank_set_core_pwr();
-}
-
-static inline void highbank_set_pwr_hard_reset(void)
-{
-	writel(HB_PWR_HARD_RESET, sregs_base + HB_SREG_A9_PWR_REQ);
-	highbank_set_core_pwr();
-}
-
-static inline void highbank_clear_pwr_request(void)
-{
-	writel(~0UL, sregs_base + HB_SREG_A9_PWR_REQ);
-	highbank_clear_core_pwr();
+	return -ENODEV;
 }
 
 #endif
diff --git a/arch/arm/mach-highbank/system.c b/arch/arm/mach-highbank/system.c
deleted file mode 100644
index 37d8384..0000000
--- a/arch/arm/mach-highbank/system.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright 2011 Calxeda, Inc.
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
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#include <linux/io.h>
-#include <asm/proc-fns.h>
-
-#include "core.h"
-#include "sysregs.h"
-
-void highbank_restart(char mode, const char *cmd)
-{
-	if (mode == 'h')
-		highbank_set_pwr_hard_reset();
-	else
-		highbank_set_pwr_soft_reset();
-
-	while (1)
-		cpu_do_idle();
-}
-
diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index c45b3ae..4127e2e 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -196,4 +196,4 @@ static int __init ipc_init(void)
 {
 	return amba_driver_register(&pl320_driver);
 }
-module_init(ipc_init);
+arch_initcall(ipc_init);
-- 
1.7.10.4
