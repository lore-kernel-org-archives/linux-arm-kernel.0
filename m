From: jc.lee@samsung.com (Jaecheol Lee)
Date: Fri,  8 Jul 2011 18:43:55 +0900
Subject: [PATCH] ARM: EXYNOS4: Add support AFTR mode on EXYNOS4210
Message-ID: <1310118235-17543-1-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support AFTR(ARM OFF TOP RUNNING) mode in
cpuidle driver. L2 cache keeps their data in this mode.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/mach-exynos4/Makefile  |    2 +-
 arch/arm/mach-exynos4/cpuidle.c |  139 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-exynos4/idle.S    |  112 +++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/idle.S

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 60fe5ec..7de3865 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o idle.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/arch/arm/mach-exynos4/cpuidle.c b/arch/arm/mach-exynos4/cpuidle.c
index bf7e96f..0987e81 100644
--- a/arch/arm/mach-exynos4/cpuidle.c
+++ b/arch/arm/mach-exynos4/cpuidle.c
@@ -14,10 +14,22 @@
 #include <linux/io.h>
 
 #include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/cacheflush.h>
+
+#include <mach/regs-pmu.h>
+#include <mach/pmu.h>
+
+#define REG_DIRECTGO_ADDR	(S5P_VA_SYSRAM + 0x24)
+#define REG_DIRECTGO_FLAG	(S5P_VA_SYSRAM + 0x20)
 
 static int exynos4_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_state *state);
 
+static int exynos4_enter_lowpower(struct cpuidle_device *dev,
+				  struct cpuidle_state *state);
+
 static struct cpuidle_state exynos4_cpuidle_set[] = {
 	[0] = {
 		.enter			= exynos4_enter_idle,
@@ -27,6 +39,14 @@ static struct cpuidle_state exynos4_cpuidle_set[] = {
 		.name			= "IDLE",
 		.desc			= "ARM clock gating(WFI)",
 	},
+	[1] = {
+		.enter			= exynos4_enter_lowpower,
+		.exit_latency		= 300,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "LOW_POWER",
+		.desc			= "ARM power down",
+	},
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
@@ -36,6 +56,85 @@ static struct cpuidle_driver exynos4_idle_driver = {
 	.owner		= THIS_MODULE,
 };
 
+void exynos4_cpu_lp(unsigned long arg)
+{
+	unsigned int sp;
+
+	/* get current stack address */
+	asm("mov %0, sp" : "=r" (sp) : : "cc");
+
+	/*
+	 * Refer to v7 cpu_suspend function.
+	 * From saveblk to stack_addr + (4 * 3) + (4 * 9)
+	 * 4byte * (v:p offset, virt sp, phy resume fn)
+	 * cpu_suspend_size = 4 * 9 (from proc-v7.S)
+	 * Min L2 cache clean size = 36 + 12 + 36 = 84
+	 */
+	outer_clean_range(virt_to_phys((void *)sp), 84);
+
+	/* To clean sleep_save_sp area */
+	outer_clean_range(virt_to_phys(cpu_resume), 64);
+
+	cpu_do_idle();
+}
+
+/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
+static void exynos4_set_wakeupmask(void)
+{
+	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
+}
+
+extern void exynos4_idle_resume(void);
+
+static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
+				    struct cpuidle_state *state)
+{
+	struct timeval before, after;
+	int idle_time;
+	unsigned long tmp;
+
+	local_irq_disable();
+	do_gettimeofday(&before);
+
+	exynos4_set_wakeupmask();
+
+	__raw_writel(virt_to_phys(exynos4_idle_resume), REG_DIRECTGO_ADDR);
+	__raw_writel(0xfcba0d10, REG_DIRECTGO_FLAG);
+
+	/* Set value of power down register for aftr mode */
+	exynos4_sys_powerdown_conf(SYS_AFTR);
+
+	/* Setting Central Sequence Register for power down mode */
+	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
+	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
+	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+
+	cpu_suspend(0, exynos4_cpu_lp);
+
+	/*
+	 * If PMU failed while entering sleep mode, WFI will be
+	 * ignored by PMU and then exiting cpu_do_idle().
+	 * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
+	 * in this situation.
+	 */
+	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
+	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
+		tmp |= S5P_CENTRAL_LOWPWR_CFG;
+		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+	}
+
+	/* Clear wakeup state register */
+	__raw_writel(0x0, S5P_WAKEUP_STAT);
+
+	do_gettimeofday(&after);
+
+	local_irq_enable();
+	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
+		    (after.tv_usec - before.tv_usec);
+
+	return idle_time;
+}
+
 static int exynos4_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_state *state)
 {
@@ -55,6 +154,29 @@ static int exynos4_enter_idle(struct cpuidle_device *dev,
 	return idle_time;
 }
 
+static int exynos4_enter_lowpower(struct cpuidle_device *dev,
+				  struct cpuidle_state *state)
+{
+	struct cpuidle_state *new_state = state;
+
+	/* This mode only can be entered when Core1 is offline */
+	if (cpu_online(1)) {
+		BUG_ON(!dev->safe_state);
+		new_state = dev->safe_state;
+	}
+	dev->last_state = new_state;
+
+	if (new_state == &dev->states[0])
+		return exynos4_enter_idle(dev, new_state);
+	else
+		return exynos4_enter_core0_aftr(dev, new_state);
+
+	return exynos4_enter_idle(dev, new_state);
+}
+
+/* Keep following save sequence prefetch, power, tag, data, aux */
+extern unsigned long l2cc_save[5];
+
 static int __init exynos4_init_cpuidle(void)
 {
 	int i, max_cpuidle_state, cpu_id;
@@ -66,8 +188,11 @@ static int __init exynos4_init_cpuidle(void)
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
 		device->cpu = cpu_id;
 
-		device->state_count = (sizeof(exynos4_cpuidle_set) /
+		if (cpu_id == 0)
+			device->state_count = (sizeof(exynos4_cpuidle_set) /
 					       sizeof(struct cpuidle_state));
+		else
+			device->state_count = 1;	/* Support IDLE only */
 
 		max_cpuidle_state = device->state_count;
 
@@ -76,11 +201,23 @@ static int __init exynos4_init_cpuidle(void)
 					sizeof(struct cpuidle_state));
 		}
 
+		device->safe_state = &device->states[0];
+
 		if (cpuidle_register_device(device)) {
 			printk(KERN_ERR "CPUidle register device failed\n,");
 			return -EIO;
 		}
 	}
+
+	l2cc_save[0] = __raw_readl(S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
+	l2cc_save[1] = __raw_readl(S5P_VA_L2CC + L2X0_POWER_CTRL);
+	l2cc_save[2] = __raw_readl(S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
+	l2cc_save[3] = __raw_readl(S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+	l2cc_save[4] = __raw_readl(S5P_VA_L2CC + L2X0_AUX_CTRL);
+
+	clean_dcache_area(&l2cc_save[0], 5 * sizeof(unsigned long));
+	outer_clean_range(virt_to_phys(&l2cc_save[0]),
+			  virt_to_phys(&l2cc_save[4] + sizeof(unsigned long)));
 	return 0;
 }
 device_initcall(exynos4_init_cpuidle);
diff --git a/arch/arm/mach-exynos4/idle.S b/arch/arm/mach-exynos4/idle.S
new file mode 100644
index 0000000..21e934c
--- /dev/null
+++ b/arch/arm/mach-exynos4/idle.S
@@ -0,0 +1,112 @@
+/* linux/arch/arm/mach-exynos4/idle.S
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4210 AFTR/LPA idle support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+#include <asm/memory.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include <mach/map.h>
+
+	.text
+
+	/*
+	 * sleep magic, to allow the bootloader to check for an valid
+	 * image to resume to. Must be the first word before the
+	 * s3c_cpu_resume entry.
+	 */
+
+	.word	0x2bedf00d
+
+	/*
+	 * exynos4_idle_resume
+	 *
+	 * resume code entry for IROM to call
+	 *
+	 * we must put this code here in the data segment as we have no
+	 * other way of restoring the stack pointer after sleep, and we
+	 * must not write to the code segment (code is read-only)
+	 */
+	.data
+	.align
+ENTRY(exynos4_idle_resume)
+	ldr	r0, scu_pa_addr		@ load physica address of SCU
+	ldr	r1, [r0]
+	orr	r1, r1, #1
+	orr	r1, r1, #(1 << 5)
+	str	r1, [r0]		@ enable SCU
+
+	ldr	r0, l2cc_pa_addr	@ load physical address of L2CC
+
+	ldr	r1, l2cc_tag_latency_ctrl	@ tag latency register offset
+	add	r1, r0, r1
+	ldr	r2, l2cc_tag_data	@ load saved tag latency register
+	str	r2, [r1]		@ store saved value to register
+
+	ldr	r1, l2cc_data_latency_ctrl	@ data latency register offset
+	add	r1, r0, r1
+	ldr	r2, l2cc_data_data	@ load saved data latency register
+	str	r2, [r1]		@ store saved value to register
+
+	ldr	r1, l2cc_prefetch_ctrl	@ prefetch control register offset
+	add	r1, r0, r1
+	ldr	r2, l2cc_prefetch_data	@ load saved prefetch control register
+	str	r2, [r1]		@ store saved value to register
+
+	ldr	r1, l2cc_pwr_ctrl	@ power control register offset
+	add	r1, r0, r1
+	ldr	r2, l2cc_pwr_data	@ load saved power control register
+	str	r2, [r1]		@ store saved value to register
+
+	ldr	r1, l2cc_aux_ctrl	@ aux control register offset
+	add	r1, r0, r1
+	ldr	r2, l2cc_aux_data	@ load saved aux control register
+	str	r2, [r1]		@ store saved value to register
+
+	ldr	r1, l2cc_ctrl		@ control register offset
+	add	r1, r0, r1
+	mov	r2, #1			@ enable L2CC
+	str	r2, [r1]
+
+	b	cpu_resume
+ENDPROC(exynos4_idle_resume)
+
+	.global	l2cc_save
+
+scu_pa_addr:
+	.word	EXYNOS4_PA_COREPERI
+l2cc_pa_addr:
+	.word	EXYNOS4_PA_L2CC
+l2cc_prefetch_ctrl:
+	.word	L2X0_PREFETCH_CTRL
+l2cc_pwr_ctrl:
+	.word	L2X0_POWER_CTRL
+l2cc_tag_latency_ctrl:
+	.word	L2X0_TAG_LATENCY_CTRL
+l2cc_data_latency_ctrl:
+	.word	L2X0_DATA_LATENCY_CTRL
+l2cc_aux_ctrl:
+	.word	L2X0_AUX_CTRL
+l2cc_ctrl:
+	.word	L2X0_CTRL
+l2cc_save:
+l2cc_prefetch_data:
+	.long	0
+l2cc_pwr_data:
+	.long	0
+l2cc_tag_data:
+	.long	0
+l2cc_data_data:
+	.long	0
+l2cc_aux_data:
+	.long	0
-- 
1.7.1
