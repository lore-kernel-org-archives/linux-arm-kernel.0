From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 8 Oct 2012 18:26:17 +0800
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for secondary CPUs
In-Reply-To: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
Message-ID: <1349691981-31038-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This supports power-gated (LP2) idle on secondary CPUs for Tegra30.
The secondary CPUs can go into LP2 state independently. When CPU goes
into LP2 state, it saves it's state and puts itself to flow controlled
WFI state. After that, it will been power gated.

Based on the work by:
Scott Williams <scwilliams@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile          |    1 +
 arch/arm/mach-tegra/cpuidle-tegra30.c |   79 +++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/pm.c              |   88 +++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pm.h              |   30 +++++++++++
 arch/arm/mach-tegra/reset.h           |    9 +++
 arch/arm/mach-tegra/sleep-tegra30.S   |   26 ++++++++++
 arch/arm/mach-tegra/sleep.S           |   66 ++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.h           |    2 +
 8 files changed, 300 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tegra/pm.c
 create mode 100644 arch/arm/mach-tegra/pm.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 9b80c1e..6f224f7 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -8,6 +8,7 @@ obj-y					+= pmc.o
 obj-y					+= flowctrl.o
 obj-y					+= powergate.o
 obj-y					+= apbio.o
+obj-y					+= pm.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_CPU_IDLE)			+= sleep.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks.o
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 0f85df8..842fef4 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -19,21 +19,94 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/clockchips.h>
 
 #include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+
+#include "pm.h"
+#include "sleep.h"
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra30_idle_lp2(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv,
+			    int index);
+#endif
 
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
 	.en_core_tk_irqen = 1,
-	.state_count = 1,
+	.state_count = 2,
 	.states = {
 		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+#ifdef CONFIG_PM_SLEEP
+		[1] = {
+			.enter			= tegra30_idle_lp2,
+			.exit_latency		= 2000,
+			.target_residency	= 2200,
+			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.name			= "LP2",
+			.desc			= "CPU power-gate",
+		},
+#endif
 	},
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
+#ifdef CONFIG_PM_SLEEP
+static bool tegra30_idle_enter_lp2_cpu_n(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
+{
+#ifdef CONFIG_SMP
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	smp_wmb();
+
+	save_cpu_arch_register();
+
+	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+
+	restore_cpu_arch_register();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+#endif
+
+	return true;
+}
+
+static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv,
+				      int index)
+{
+	bool entered_lp2 = false;
+
+	local_fiq_disable();
+
+	tegra_set_cpu_in_lp2(dev->cpu);
+	cpu_pm_enter();
+
+	if (dev->cpu == 0)
+		cpu_do_idle();
+	else
+		entered_lp2 = tegra30_idle_enter_lp2_cpu_n(dev, drv, index);
+
+	cpu_pm_exit();
+	tegra_clear_cpu_in_lp2(dev->cpu);
+
+	local_fiq_enable();
+
+	smp_rmb();
+
+	return (entered_lp2) ? index : 0;
+}
+#endif
+
 int __init tegra30_cpuidle_init(void)
 {
 	int ret;
@@ -41,6 +114,10 @@ int __init tegra30_cpuidle_init(void)
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &tegra_idle_driver;
 
+#ifndef CONFIG_PM_SLEEP
+	drv->state_count = 1;	/* support clockgating only */
+#endif
+
 	ret = cpuidle_register_driver(&tegra_idle_driver);
 	if (ret) {
 		pr_err("CPUidle driver registration failed\n");
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
new file mode 100644
index 0000000..4655383
--- /dev/null
+++ b/arch/arm/mach-tegra/pm.c
@@ -0,0 +1,88 @@
+/*
+ * CPU complex suspend & resume functions for Tegra SoCs
+ *
+ * Copyright (c) 2009-2012, NVIDIA Corporation. All rights reserved.
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/cpumask.h>
+
+#include <mach/iomap.h>
+
+#include "reset.h"
+
+#ifdef CONFIG_PM_SLEEP
+static unsigned int g_diag_reg;
+static DEFINE_SPINLOCK(tegra_lp2_lock);
+static cpumask_t tegra_in_lp2;
+
+void save_cpu_arch_register(void)
+{
+	/*read diagnostic register*/
+	asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc");
+	return;
+}
+
+void restore_cpu_arch_register(void)
+{
+	/*write diagnostic register*/
+	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
+	return;
+}
+
+void __cpuinit tegra_clear_cpu_in_lp2(int cpu)
+{
+	spin_lock(&tegra_lp2_lock);
+	BUG_ON(!cpumask_test_cpu(cpu, &tegra_in_lp2));
+	cpumask_clear_cpu(cpu, &tegra_in_lp2);
+
+	/*
+	 * Update the IRAM copy used by the reset handler. The IRAM copy
+	 * can't use used directly by cpumask_clear_cpu() because it uses
+	 * LDREX/STREX which requires the addressed location to be inner
+	 * cacheable and sharable which IRAM isn't.
+	 */
+	writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
+	dsb();
+
+	spin_unlock(&tegra_lp2_lock);
+}
+
+bool __cpuinit tegra_set_cpu_in_lp2(int cpu)
+{
+	bool last_cpu = false;
+
+	spin_lock(&tegra_lp2_lock);
+	BUG_ON(cpumask_test_cpu(cpu, &tegra_in_lp2));
+	cpumask_set_cpu(cpu, &tegra_in_lp2);
+
+	/*
+	 * Update the IRAM copy used by the reset handler. The IRAM copy
+	 * can't use used directly by cpumask_set_cpu() because it uses
+	 * LDREX/STREX which requires the addressed location to be inner
+	 * cacheable and sharable which IRAM isn't.
+	 */
+	writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
+	dsb();
+
+	if ((cpu == 0) && cpumask_equal(&tegra_in_lp2, cpu_online_mask))
+		last_cpu = true;
+
+	spin_unlock(&tegra_lp2_lock);
+	return last_cpu;
+}
+#endif
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
new file mode 100644
index 0000000..21858d6
--- /dev/null
+++ b/arch/arm/mach-tegra/pm.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2010 Google, Inc.
+ * Copyright (c) 2010-2012 NVIDIA Corporation. All rights reserved.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
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
+ */
+
+#ifndef _MACH_TEGRA_PM_H_
+#define _MACH_TEGRA_PM_H_
+
+void save_cpu_arch_register(void);
+void restore_cpu_arch_register(void);
+
+void tegra_clear_cpu_in_lp2(int cpu);
+bool tegra_set_cpu_in_lp2(int cpu);
+
+#endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index de88bf8..234cd6b 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -29,6 +29,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <mach/irammap.h>
+
 extern unsigned long __tegra_cpu_reset_handler_data[TEGRA_RESET_DATA_SIZE];
 
 void __tegra_cpu_reset_handler_start(void);
@@ -36,6 +38,13 @@ void __tegra_cpu_reset_handler(void);
 void __tegra_cpu_reset_handler_end(void);
 void tegra_secondary_startup(void);
 
+#ifdef CONFIG_PM_SLEEP
+#define tegra_cpu_lp2_mask \
+	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
+	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_LP2] - \
+	 (u32)__tegra_cpu_reset_handler_start)))
+#endif
+
 #define tegra_cpu_reset_handler_offset \
 		((u32)__tegra_cpu_reset_handler - \
 		 (u32)__tegra_cpu_reset_handler_start)
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 777d9ce..67b1cba 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -17,6 +17,8 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/glue-cache.h>
 
 #include <mach/iomap.h>
 
@@ -82,6 +84,7 @@ delay_1:
 	ldr	r3, [r1]			@ read CSR
 	str	r3, [r1]			@ clear CSR
 	tst	r0, #TEGRA30_POWER_HOTPLUG_SHUTDOWN
+	moveq   r3, #FLOW_CTRL_WAIT_FOR_INTERRUPT	@ For LP2
 	movne	r3, #FLOW_CTRL_WAITEVENT		@ For hotplug
 	str	r3, [r2]
 	ldr	r0, [r2]
@@ -105,3 +108,26 @@ wfe_war:
 
 ENDPROC(tegra30_cpu_shutdown)
 #endif
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * tegra30_sleep_cpu_secondary_finish(unsigned long v2p)
+ *
+ * Enters LP2 on secondary CPU by exiting coherency and powergating the CPU.
+ */
+ENTRY(tegra30_sleep_cpu_secondary_finish)
+	mov	r7, lr
+
+	/* Flush and disable the L1 data cache */
+	bl	tegra_flush_l1_cache
+
+	/* Turn off SMP coherency */
+	exit_smp r4, r5
+
+	/* Powergate this CPU. */
+	mov	r0, #0                          @ power mode flags (!hotplug)
+	bl	tegra30_cpu_shutdown
+	mov	r0, #1                          @ never return here
+	mov	pc, r7
+ENDPROC(tegra30_sleep_cpu_secondary_finish)
+#endif
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index ea81554..7748fdb 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -25,9 +25,75 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
+#include <asm/cp15.h>
 
 #include <mach/iomap.h>
 
 #include "flowctrl.h"
 #include "sleep.h"
 
+#ifdef CONFIG_PM_SLEEP
+/*
+ * tegra_flush_l1_cache
+ *
+ * clean & invalidate the L1 cache
+ *
+ * The flush_cache_all flushes all caches within level of coherence, this
+ * may not be desired if all we need is to flush L1 only. Therefore this
+ * function is implemented to flush the L1 cache only.
+ *
+ * Disable is needed before flush to prevent allocation during flush.
+ * When cache is disabled, we cannot push to stack.
+ *
+ * Corrupted registers: r0-r7, r9-r11
+ */
+
+ENTRY(tegra_flush_l1_cache)
+	stmfd	sp!, {r4-r5, r7, r9-r11, lr}
+	dmb					@ ensure ordering
+
+	/* Disable the data cache */
+	mrc	p15, 0, r2, c1, c0, 0
+	bic	r2, r2, #CR_C
+	dsb
+	mcr	p15, 0, r2, c1, c0, 0
+
+	/* Flush data cache */
+	mov	r10, #0
+#ifdef CONFIG_PREEMPT
+	save_and_disable_irqs_notrace r9	@ make cssr&csidr read atomic
+#endif
+	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
+	isb					@ isb to sych the new cssr&csidr
+	mrc	p15, 1, r1, c0, c0, 0		@ read the new csidr
+#ifdef CONFIG_PREEMPT
+	restore_irqs_notrace r9
+#endif
+	and	r2, r1, #7			@ extract the length of the cache lines
+	add	r2, r2, #4			@ add 4 (line length offset)
+	ldr	r4, =0x3ff
+	ands	r4, r4, r1, lsr #3		@ find maximum number on the way size
+	clz	r5, r4				@ find bit position of way size increment
+	ldr	r7, =0x7fff
+	ands	r7, r7, r1, lsr #13		@ extract max number of the index size
+loop2:
+	mov	r9, r4				@ create working copy of max way size
+loop3:
+	orr	r11, r10, r9, lsl r5		@ factor way and cache number into r11
+	orr	r11, r11, r7, lsl r2		@ factor index number into r11
+	mcr	p15, 0, r11, c7, c14, 2		@ clean & invalidate by set/way
+	subs	r9, r9, #1			@ decrement the way
+	bge	loop3
+	subs	r7, r7, #1			@ decrement the index
+	bge	loop2
+finished:
+	mov	r10, #0				@ swith back to cache level 0
+	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
+	dsb
+	isb
+
+	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}
+	mov	pc, lr
+ENDPROC(tegra_flush_l1_cache)
+
+#endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index c9dec37..220fbd1 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -82,5 +82,7 @@ static inline void tegra20_hotplug_init(void) {}
 static inline void tegra30_hotplug_init(void) {}
 #endif
 
+int tegra30_sleep_cpu_secondary_finish(unsigned long);
+
 #endif
 #endif
-- 
1.7.0.4
