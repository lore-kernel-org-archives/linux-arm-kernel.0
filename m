From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Fri, 19 Aug 2011 18:40:00 +0530
Subject: [RFC PATCH 4/4] ARM: EXYNOS4: Modify cpuidle code to adapt to
	save/restore common code
In-Reply-To: <1313759340-31319-1-git-send-email-amit.kachhap@linaro.org>
References: <1313759340-31319-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1313759400-31347-4-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2 retention cpuidle state is modified to use the interfaces
exposed by the lorenzo's cpuidle consolidation code. As can be seen lot of
code is reduced in the machine directory.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-exynos4/Makefile           |    2 +-
 arch/arm/mach-exynos4/cpuidle.c          |   85 +++++++++-------
 arch/arm/mach-exynos4/idle.S             |  165 ------------------------------
 arch/arm/mach-exynos4/include/mach/pmu.h |    4 -
 5 files changed, 52 insertions(+), 205 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/idle.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a4435d6..4f97bb5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -786,6 +786,7 @@ config ARCH_EXYNOS4
 	select CLKDEV_LOOKUP
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
+	select ARCH_USES_CPU_PM
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 12568b0..2e3a407 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o idle.o
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/arch/arm/mach-exynos4/cpuidle.c b/arch/arm/mach-exynos4/cpuidle.c
index 1164945..a15f038 100644
--- a/arch/arm/mach-exynos4/cpuidle.c
+++ b/arch/arm/mach-exynos4/cpuidle.c
@@ -13,16 +13,23 @@
 #include <linux/cpuidle.h>
 #include <linux/io.h>
 #include <linux/suspend.h>
-
+#include <linux/slab.h>
+#include <linux/err.h>
 #include <asm/proc-fns.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/cacheflush.h>
-
+#include <asm/unified.h>
+#include <asm/sr_platform_api.h>
 #include <mach/regs-pmu.h>
 #include <mach/pmu.h>
 
-#define REG_DIRECTGO_ADDR	(S5P_VA_SYSRAM + 0x24)
-#define REG_DIRECTGO_FLAG	(S5P_VA_SYSRAM + 0x20)
+#include <plat/exynos4.h>
+
+#define REG_DIRECTGO_ADDR	(exynos4_subrev() == 0 ?\
+				(S5P_VA_SYSRAM + 0x24) : S5P_INFORM7)
+#define REG_DIRECTGO_FLAG	(exynos4_subrev() == 0 ?\
+				(S5P_VA_SYSRAM + 0x20) : S5P_INFORM6)
+
 
 static int exynos4_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_state *state);
@@ -56,29 +63,30 @@ static struct cpuidle_driver exynos4_idle_driver = {
 	.owner		= THIS_MODULE,
 };
 
-void exynos4_cpu_lp(void *stack_addr)
+/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
+static void exynos4_set_wakeupmask(void)
 {
-	/*
-	 * Refer to v7 cpu_suspend function.
-	 * From saveblk to stack_addr + (4 * 3) + (4 * 9)
-	 * 4byte * (v:p offset, virt sp, phy resume fn)
-	 * cpu_suspend_size = 4 * 9 (from proc-v7.S)
-	 * Min L2 cache clean size = 36 + 12 + 36 = 84
-	 */
-
-	outer_clean_range(virt_to_phys(stack_addr), 84);
-
-	/* To clean sleep_save_sp area */
+	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
+}
 
-	outer_clean_range(virt_to_phys(cpu_resume), 64);
+unsigned int g_pwr_ctrl, g_diag_reg;
 
-	cpu_do_idle();
+static void save_cpu_arch_register(void)
+{
+	/*read power control register*/
+	asm("mrc p15, 0, %0, c15, c0, 0" : "=r"(g_pwr_ctrl) : : "cc");
+	/*read diagnostic register*/
+	asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc");
+	return;
 }
 
-/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos4_set_wakeupmask(void)
+static void restore_cpu_arch_register(void)
 {
-	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
+	/*write power control register*/
+	asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
+	/*write diagnostic register*/
+	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
+	return;
 }
 
 static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
@@ -93,18 +101,24 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 
 	exynos4_set_wakeupmask();
 
-	__raw_writel(virt_to_phys(exynos4_idle_resume), REG_DIRECTGO_ADDR);
+	__raw_writel(BSYM(virt_to_phys(arch_reset_handler())),
+						 REG_DIRECTGO_ADDR);
 	__raw_writel(0xfcba0d10, REG_DIRECTGO_FLAG);
 
 	/* Set value of power down register for aftr mode */
 	exynos4_sys_powerdown_conf(SYS_AFTR);
 
+	save_cpu_arch_register();
+
 	/* Setting Central Sequence Register for power down mode */
 	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
 	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 
-	exynos4_enter_lp(0, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	/*cstate=SHUTDOWN, cluster=RETENTION, save=ALL*/
+	cpu_enter_idle(3, 2, SR_SAVE_ALL);
+
+	restore_cpu_arch_register();
 
 	/*
 	 * If PMU failed while entering sleep mode, WFI will be
@@ -117,7 +131,6 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 		tmp |= S5P_CENTRAL_LOWPWR_CFG;
 		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 	}
-	cpu_init();
 	/* Clear wakeup state register */
 	__raw_writel(0x0, S5P_WAKEUP_STAT);
 
@@ -139,7 +152,8 @@ static int exynos4_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	do_gettimeofday(&before);
 
-	cpu_do_idle();
+	/*cstate=STANDBY, cluster=RUN, save=no flags*/
+	cpu_enter_idle(1, 0, 0);
 
 	do_gettimeofday(&after);
 	local_irq_enable();
@@ -169,6 +183,17 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 	return exynos4_enter_idle(dev, new_state);
 }
 
+void *platform_context_pointer(unsigned int size)
+{
+	void *memory;
+	memory = kmalloc(size, GFP_KERNEL);
+	if (memory == NULL) {
+		printk(KERN_ERR "Memory size = %u not available", size);
+		return ERR_PTR(-ENOMEM);
+	}
+	return virt_to_phys(memory);
+}
+
 static int __init exynos4_init_cpuidle(void)
 {
 	int i, max_cpuidle_state, cpu_id;
@@ -200,16 +225,6 @@ static int __init exynos4_init_cpuidle(void)
 			return -EIO;
 		}
 	}
-
-	l2cc_save[0] = __raw_readl(S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
-	l2cc_save[1] = __raw_readl(S5P_VA_L2CC + L2X0_POWER_CTRL);
-	l2cc_save[2] = __raw_readl(S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
-	l2cc_save[3] = __raw_readl(S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-	l2cc_save[4] = __raw_readl(S5P_VA_L2CC + L2X0_AUX_CTRL);
-
-	clean_dcache_area(&l2cc_save[0], 5 * sizeof(unsigned long));
-	outer_clean_range(virt_to_phys(&l2cc_save[0]),
-			  virt_to_phys(&l2cc_save[4] + sizeof(unsigned long)));
 	return 0;
 }
 device_initcall(exynos4_init_cpuidle);
diff --git a/arch/arm/mach-exynos4/idle.S b/arch/arm/mach-exynos4/idle.S
deleted file mode 100644
index 5a3cd41..0000000
--- a/arch/arm/mach-exynos4/idle.S
+++ /dev/null
@@ -1,165 +0,0 @@
-/* linux/arch/arm/mach-exynos4/idle.S
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4210 AFTR/LPA idle support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/linkage.h>
-
-#include <asm/assembler.h>
-#include <asm/memory.h>
-#include <asm/hardware/cache-l2x0.h>
-
-#include <mach/map.h>
-
-	.text
-
-	/*
-	 * exynos4_enter_lp
-	 *
-	 * entry:
-	 *	r1 = v:p offset
-	 */
-
-ENTRY(exynos4_enter_lp)
-	stmfd	sp!, { r3 - r12, lr }
-
-	adr	r0, sleep_save_misc
-
-	mrc	p15, 0, r2, c15, c0, 0	@ read power control register
-	str	r2, [r0], #4
-
-	mrc	p15, 0, r2, c15, c0, 1	@ read diagnostic register
-	str	r2, [r0], #4
-
-	ldr	r3, =resume_with_mmu
-	bl	cpu_suspend
-
-	mov	r0, sp
-	bl	exynos4_cpu_lp
-
-	/* Restore original sp */
-	mov	r0, sp
-	add	r0, r0, #4
-	ldr	sp, [r0]
-
-	mov	r0, #0
-	b	early_wakeup
-
-resume_with_mmu:
-
-	adr	r0, sleep_save_misc
-
-	ldr	r1, [r0], #4
-	mcr	p15, 0, r1, c15, c0, 0	@ write power control register
-
-	ldr	r1, [r0], #4
-	mcr	p15, 0, r1, c15, c0, 1	@ write diagnostic register
-
-	mov	r0, #1
-early_wakeup:
-
-	ldmfd	sp!, { r3 - r12, pc }
-
-	.ltorg
-
-	/*
-	 * sleep magic, to allow the bootloader to check for an valid
-	 * image to resume to. Must be the first word before the
-	 * s3c_cpu_resume entry.
-	 */
-
-	.word	0x2bedf00d
-
-sleep_save_misc:
-	.long	0
-	.long	0
-
-	/*
-	 * exynos4_idle_resume
-	 *
-	 * resume code entry for IROM to call
-	 *
-	 * we must put this code here in the data segment as we have no
-	 * other way of restoring the stack pointer after sleep, and we
-	 * must not write to the code segment (code is read-only)
-	 */
-	.data
-	.align
-ENTRY(exynos4_idle_resume)
-	ldr	r0, scu_pa_addr		@ load physica address of SCU
-	ldr	r1, [r0]
-	orr	r1, r1, #1
-	orr	r1, r1, #(1 << 5)
-	str	r1, [r0]		@ enable SCU
-
-	ldr	r0, l2cc_pa_addr	@ load physical address of L2CC
-
-	ldr	r1, l2cc_tag_latency_ctrl	@ tag latency register offset
-	add	r1, r0, r1
-	ldr	r2, l2cc_tag_data	@ load saved tag latency register
-	str	r2, [r1]		@ store saved value to register
-
-	ldr	r1, l2cc_data_latency_ctrl	@ data latency register offset
-	add	r1, r0, r1
-	ldr	r2, l2cc_data_data	@ load saved data latency register
-	str	r2, [r1]		@ store saved value to register
-
-	ldr	r1, l2cc_prefetch_ctrl	@ prefetch control register offset
-	add	r1, r0, r1
-	ldr	r2, l2cc_prefetch_data	@ load saved prefetch control register
-	str	r2, [r1]		@ store saved value to register
-
-	ldr	r1, l2cc_pwr_ctrl	@ power control register offset
-	add	r1, r0, r1
-	ldr	r2, l2cc_pwr_data	@ load saved power control register
-	str	r2, [r1]		@ store saved value to register
-
-	ldr	r1, l2cc_aux_ctrl	@ aux control register offset
-	add	r1, r0, r1
-	ldr	r2, l2cc_aux_data	@ load saved aux control register
-	str	r2, [r1]		@ store saved value to register
-
-	ldr	r1, l2cc_ctrl		@ control register offset
-	add	r1, r0, r1
-	mov	r2, #1			@ enable L2CC
-	str	r2, [r1]
-
-	b	cpu_resume
-ENDPROC(exynos4_idle_resume)
-
-	.global	l2cc_save
-
-scu_pa_addr:
-	.word	EXYNOS4_PA_COREPERI
-l2cc_pa_addr:
-	.word	EXYNOS4_PA_L2CC
-l2cc_prefetch_ctrl:
-	.word	L2X0_PREFETCH_CTRL
-l2cc_pwr_ctrl:
-	.word	L2X0_POWER_CTRL
-l2cc_tag_latency_ctrl:
-	.word	L2X0_TAG_LATENCY_CTRL
-l2cc_data_latency_ctrl:
-	.word	L2X0_DATA_LATENCY_CTRL
-l2cc_aux_ctrl:
-	.word	L2X0_AUX_CTRL
-l2cc_ctrl:
-	.word	L2X0_CTRL
-l2cc_save:
-l2cc_prefetch_data:
-	.long	0
-l2cc_pwr_data:
-	.long	0
-l2cc_tag_data:
-	.long	0
-l2cc_data_data:
-	.long	0
-l2cc_aux_data:
-	.long	0
diff --git a/arch/arm/mach-exynos4/include/mach/pmu.h b/arch/arm/mach-exynos4/include/mach/pmu.h
index 960456f..d23194d 100644
--- a/arch/arm/mach-exynos4/include/mach/pmu.h
+++ b/arch/arm/mach-exynos4/include/mach/pmu.h
@@ -21,8 +21,4 @@ enum sys_powerdown {
 };
 
 extern void exynos4_sys_powerdown_conf(enum sys_powerdown mode);
-extern void exynos4_idle_resume(void);
-extern void exynos4_enter_lp(unsigned long arg, long offset);
-/* Keep following save sequence prefetch, power, tag, data, aux */
-extern unsigned long l2cc_save[5];
 #endif /* __ASM_ARCH_PMU_H */
-- 
1.7.1
