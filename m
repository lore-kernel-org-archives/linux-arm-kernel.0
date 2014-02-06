From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:56 +0100
Subject: [PATCH v2 11/12] ARM: EXYNOS: Stop using legacy Samsung PM code
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-12-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Exynos SoCs does not follow most of the semantics of older SoCs
when configuring the system to enter sleep, there is no reason to rely
on the legacy Samsung PM core anymore.

This patch adds local Exynos suspend ops and removes all the code left
unnecessary. As a side effect, suspend support on Exynos becomes
multiplatform-friendly.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                |  8 ---
 arch/arm/mach-exynos/Makefile               |  2 +-
 arch/arm/mach-exynos/common.h               |  8 +++
 arch/arm/mach-exynos/include/mach/pm-core.h | 75 -------------------------
 arch/arm/mach-exynos/pm.c                   | 79 ++++++++++++++++++++++++---
 arch/arm/mach-exynos/regs-pmu.h             |  2 +
 arch/arm/mach-exynos/sleep.S                | 85 +++++++++++++++++++++++++++++
 arch/arm/plat-samsung/s5p-sleep.S           | 45 ---------------
 8 files changed, 167 insertions(+), 137 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/pm-core.h
 create mode 100644 arch/arm/mach-exynos/sleep.S

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 0964d97..fcd78c2 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -49,8 +49,6 @@ config CPU_EXYNOS4210
 	select ARCH_HAS_BANDGAP
 	select ARM_CPU_SUSPEND if PM_SLEEP
 	select PINCTRL_EXYNOS
-	select S5P_PM if PM_SLEEP
-	select S5P_SLEEP if PM_SLEEP
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4210 CPU support
@@ -61,8 +59,6 @@ config SOC_EXYNOS4212
 	depends on ARCH_EXYNOS4
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
-	select S5P_PM if PM_SLEEP
-	select S5P_SLEEP if PM_SLEEP
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4212 SoC support
@@ -84,8 +80,6 @@ config SOC_EXYNOS5250
 	select ARCH_HAS_BANDGAP
 	select PINCTRL_EXYNOS
 	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	select S5P_PM if PM_SLEEP
-	select S5P_SLEEP if PM_SLEEP
 	select S5P_DEV_MFC
 	select SAMSUNG_DMADEV
 	help
@@ -96,8 +90,6 @@ config SOC_EXYNOS5420
 	default y
 	depends on ARCH_EXYNOS5
 	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	select S5P_PM if PM_SLEEP
-	select S5P_SLEEP if PM_SLEEP
 	help
 	  Enable EXYNOS5420 SoC support
 
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 8930b66..58fe9e6 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -14,7 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
 
-obj-$(CONFIG_S5P_PM)		+= pm.o
+obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 82e08fb..aba6a2a 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -27,12 +27,20 @@ void exynos_init_late(void);
 
 void exynos_firmware_init(void);
 
+#ifdef CONFIG_PINCTRL_EXYNOS
+extern u32 exynos_get_eint_wake_mask(void);
+#else
+static inline u32 exynos_get_eint_wake_mask(void) { return 0xffffffff; }
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 extern void __init exynos_pm_init(void);
 #else
 static inline void exynos_pm_init(void) {}
 #endif
 
+extern void exynos_cpu_resume(void);
+
 extern struct smp_operations exynos_smp_ops;
 
 extern void exynos_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
deleted file mode 100644
index dc0697c..0000000
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/pm-core.h
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Based on arch/arm/mach-s3c2410/include/mach/pm-core.h,
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * EXYNOS4210 - PM core support for arch/arm/plat-s5p/pm.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_PM_CORE_H
-#define __ASM_ARCH_PM_CORE_H __FILE__
-
-#include <linux/of.h>
-#include <mach/map.h>
-
-#define S5P_EINT_WAKEUP_MASK			(S5P_VA_PMU + 0x0604)
-#define S5P_WAKEUP_MASK				(S5P_VA_PMU + 0x0608)
-
-#ifdef CONFIG_PINCTRL_EXYNOS
-extern u32 exynos_get_eint_wake_mask(void);
-#else
-static inline u32 exynos_get_eint_wake_mask(void) { return 0xffffffff; }
-#endif
-
-static inline void s3c_pm_debug_init_uart(void)
-{
-	/* nothing here yet */
-}
-
-static inline void s3c_pm_arch_prepare_irqs(void)
-{
-	__raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
-	__raw_writel(s3c_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
-}
-
-static inline void s3c_pm_arch_stop_clocks(void)
-{
-	/* nothing here yet */
-}
-
-static inline void s3c_pm_arch_show_resume_irqs(void)
-{
-	/* nothing here yet */
-}
-
-static inline void s3c_pm_arch_update_uart(void __iomem *regs,
-					   struct pm_uart_save *save)
-{
-	/* nothing here yet */
-}
-
-static inline void s3c_pm_restored_gpios(void)
-{
-	/* nothing here yet */
-}
-
-static inline void samsung_pm_saved_gpios(void)
-{
-	/* nothing here yet */
-}
-
-/* Compatibility definitions to make plat-samsung/pm.c compile */
-#define IRQ_EINT_BIT(x)		1
-#define s3c_irqwake_intallow	0
-#define s3c_irqwake_eintallow	0
-
-#endif /* __ASM_ARCH_PM_CORE_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 596ed13..ada1c83 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -23,14 +23,14 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
+#include <asm/suspend.h>
 
 #include <plat/cpu.h>
-#include <plat/pm.h>
+#include <plat/pm-common.h>
 #include <plat/pll.h>
 #include <plat/regs-srom.h>
 
 #include <mach/map.h>
-#include <mach/pm-core.h>
 
 #include "common.h"
 #include "regs-pmu.h"
@@ -48,6 +48,7 @@ static struct sleep_save exynos_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
+static u32 exynos_irqwake_intmask = 0xffffffff;
 
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
@@ -72,6 +73,10 @@ static void exynos_pm_prepare(void)
 {
 	unsigned int tmp;
 
+	/* Set wake-up mask registers */
+	__raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
+	__raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
+
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
 	if (soc_is_exynos5250()) {
@@ -89,7 +94,7 @@ static void exynos_pm_prepare(void)
 
 	/* ensure@least INFORM0 has the resume address */
 
-	__raw_writel(virt_to_phys(s3c_cpu_resume), S5P_INFORM0);
+	__raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
 }
 
 static int exynos_pm_suspend(void)
@@ -187,14 +192,71 @@ static struct syscore_ops exynos_pm_syscore_ops = {
 	.resume		= exynos_pm_resume,
 };
 
-void __init exynos_pm_init(void)
+/*
+ * Suspend Ops
+ */
+
+static int exynos_suspend_enter(suspend_state_t state)
 {
-	u32 tmp;
+	int ret;
+
+	s3c_pm_debug_init();
+
+	S3C_PMDBG("%s: suspending the system...\n", __func__);
+
+	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
+			exynos_irqwake_intmask, exynos_get_eint_wake_mask());
 
-	pm_cpu_prep = exynos_pm_prepare;
-	pm_cpu_sleep = exynos_cpu_suspend;
+	if (exynos_irqwake_intmask == -1U
+	    && exynos_get_eint_wake_mask() == -1U) {
+		pr_err("%s: No wake-up sources!\n", __func__);
+		pr_err("%s: Aborting sleep\n", __func__);
+		return -EINVAL;
+	}
+
+	s3c_pm_save_uarts();
+	exynos_pm_prepare();
+	flush_cache_all();
+	s3c_pm_check_store();
+
+	ret = cpu_suspend(0, exynos_cpu_suspend);
+	if (ret)
+		return ret;
+
+	s3c_pm_restore_uarts();
 
-	s3c_pm_init();
+	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
+			__raw_readl(S5P_WAKEUP_STAT));
+
+	s3c_pm_check_restore();
+
+	S3C_PMDBG("%s: resuming the system...\n", __func__);
+
+	return 0;
+}
+
+static int exynos_suspend_prepare(void)
+{
+	s3c_pm_check_prepare();
+
+	return 0;
+}
+
+static void exynos_suspend_finish(void)
+{
+	s3c_pm_check_cleanup();
+}
+
+static const struct platform_suspend_ops exynos_suspend_ops = {
+	.enter		= exynos_suspend_enter,
+	.prepare	= exynos_suspend_prepare,
+	.finish		= exynos_suspend_finish,
+	.valid		= suspend_valid_only_mem,
+};
+
+void __init exynos_pm_init(void)
+{
+	u32 tmp;
 
 	/* All wakeup disable */
 	tmp = __raw_readl(S5P_WAKEUP_MASK);
@@ -202,4 +264,5 @@ void __init exynos_pm_init(void)
 	__raw_writel(tmp, S5P_WAKEUP_MASK);
 
 	register_syscore_ops(&exynos_pm_syscore_ops);
+	suspend_set_ops(&exynos_suspend_ops);
 }
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 7c029ce..2c15a8f 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -31,6 +31,8 @@
 #define EXYNOS5440_SWRESET			S5P_PMUREG(0x00C4)
 
 #define S5P_WAKEUP_STAT				S5P_PMUREG(0x0600)
+#define S5P_EINT_WAKEUP_MASK			S5P_PMUREG(0x0604)
+#define S5P_WAKEUP_MASK				S5P_PMUREG(0x0608)
 
 #define S5P_INFORM0				S5P_PMUREG(0x0800)
 #define S5P_INFORM1				S5P_PMUREG(0x0804)
diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
new file mode 100644
index 0000000..a2613e9
--- /dev/null
+++ b/arch/arm/mach-exynos/sleep.S
@@ -0,0 +1,85 @@
+/*
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Exynos low-level resume code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#define CPU_MASK	0xff0ffff0
+#define CPU_CORTEX_A9	0x410fc090
+
+	/*
+	 * The following code is located into the .data section. This is to
+	 * allow l2x0_regs_phys to be accessed with a relative load while we
+	 * can't rely on any MMU translation. We could have put l2x0_regs_phys
+	 * in the .text section as well, but some setups might insist on it to
+	 * be truly read-only. (Reference from: arch/arm/kernel/sleep.S)
+	 */
+	.data
+	.align
+
+	/*
+	 * sleep magic, to allow the bootloader to check for an valid
+	 * image to resume to. Must be the first word before the
+	 * exynos_cpu_resume entry.
+	 */
+
+	.word	0x2bedf00d
+
+	/*
+	 * exynos_cpu_resume
+	 *
+	 * resume code entry for bootloader to call
+	 */
+
+ENTRY(exynos_cpu_resume)
+#ifdef CONFIG_CACHE_L2X0
+	mrc	p15, 0, r0, c0, c0, 0
+	ldr	r1, =CPU_MASK
+	and	r0, r0, r1
+	ldr	r1, =CPU_CORTEX_A9
+	cmp	r0, r1
+	bne	skip_l2_resume
+	adr	r0, l2x0_regs_phys
+	ldr	r0, [r0]
+	cmp	r0, #0
+	beq	skip_l2_resume
+	ldr	r1, [r0, #L2X0_R_PHY_BASE]
+	ldr	r2, [r1, #L2X0_CTRL]
+	tst	r2, #0x1
+	bne	skip_l2_resume
+	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
+	str	r2, [r1, #L2X0_AUX_CTRL]
+	ldr	r2, [r0, #L2X0_R_TAG_LATENCY]
+	str	r2, [r1, #L2X0_TAG_LATENCY_CTRL]
+	ldr	r2, [r0, #L2X0_R_DATA_LATENCY]
+	str	r2, [r1, #L2X0_DATA_LATENCY_CTRL]
+	ldr	r2, [r0, #L2X0_R_PREFETCH_CTRL]
+	str	r2, [r1, #L2X0_PREFETCH_CTRL]
+	ldr	r2, [r0, #L2X0_R_PWR_CTRL]
+	str	r2, [r1, #L2X0_POWER_CTRL]
+	mov	r2, #1
+	str	r2, [r1, #L2X0_CTRL]
+skip_l2_resume:
+#endif
+	b	cpu_resume
+ENDPROC(exynos_cpu_resume)
+#ifdef CONFIG_CACHE_L2X0
+	.globl l2x0_regs_phys
+l2x0_regs_phys:
+	.long	0
+#endif
diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
index 20764bd..c500165 100644
--- a/arch/arm/plat-samsung/s5p-sleep.S
+++ b/arch/arm/plat-samsung/s5p-sleep.S
@@ -23,18 +23,7 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
-#include <asm/hardware/cache-l2x0.h>
 
-#define CPU_MASK	0xff0ffff0
-#define CPU_CORTEX_A9	0x410fc090
-
-/*
- *	 The following code is located into the .data section. This is to
- *	 allow l2x0_regs_phys to be accessed with a relative load while we
- *	 can't rely on any MMU translation. We could have put l2x0_regs_phys
- *	 in the .text section as well, but some setups might insist on it to
- *	 be truly read-only. (Reference from: arch/arm/kernel/sleep.S)
- */
 	.data
 	.align
 
@@ -53,39 +42,5 @@
 	 */
 
 ENTRY(s3c_cpu_resume)
-#ifdef CONFIG_CACHE_L2X0
-	mrc	p15, 0, r0, c0, c0, 0
-	ldr	r1, =CPU_MASK
-	and	r0, r0, r1
-	ldr	r1, =CPU_CORTEX_A9
-	cmp	r0, r1
-	bne	skip_l2_resume
-	adr	r0, l2x0_regs_phys
-	ldr	r0, [r0]
-	cmp	r0, #0
-	beq	skip_l2_resume
-	ldr	r1, [r0, #L2X0_R_PHY_BASE]
-	ldr	r2, [r1, #L2X0_CTRL]
-	tst	r2, #0x1
-	bne	skip_l2_resume
-	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
-	str	r2, [r1, #L2X0_AUX_CTRL]
-	ldr	r2, [r0, #L2X0_R_TAG_LATENCY]
-	str	r2, [r1, #L2X0_TAG_LATENCY_CTRL]
-	ldr	r2, [r0, #L2X0_R_DATA_LATENCY]
-	str	r2, [r1, #L2X0_DATA_LATENCY_CTRL]
-	ldr	r2, [r0, #L2X0_R_PREFETCH_CTRL]
-	str	r2, [r1, #L2X0_PREFETCH_CTRL]
-	ldr	r2, [r0, #L2X0_R_PWR_CTRL]
-	str	r2, [r1, #L2X0_POWER_CTRL]
-	mov	r2, #1
-	str	r2, [r1, #L2X0_CTRL]
-skip_l2_resume:
-#endif
 	b	cpu_resume
 ENDPROC(s3c_cpu_resume)
-#ifdef CONFIG_CACHE_L2X0
-	.globl l2x0_regs_phys
-l2x0_regs_phys:
-	.long	0
-#endif
-- 
1.8.5.2
