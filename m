From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 20 Jun 2011 16:34:17 +0900
Subject: [PATCH 6/7] ARM: EXYNOS4: Remove clock event timers using ARM private
	timers
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1308555258-4322-7-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

External GIC cannot support PPI (Private Peripheral Interrupt) for
ARM private timers. Thus MCT should be selected as clock event timers
by default.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig                    |    3 +-
 arch/arm/mach-exynos4/Makefile                   |    7 +-
 arch/arm/mach-exynos4/cpu.c                      |    2 +-
 arch/arm/mach-exynos4/include/mach/entry-macro.S |    6 -
 arch/arm/mach-exynos4/include/mach/irqs.h        |    2 -
 arch/arm/mach-exynos4/localtimer.c               |   26 --
 arch/arm/mach-exynos4/time.c                     |  303 ----------------------
 7 files changed, 4 insertions(+), 345 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c
 delete mode 100644 arch/arm/mach-exynos4/time.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 1435fc3..0aca083 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -16,7 +16,8 @@ config CPU_EXYNOS4210
 	  Enable EXYNOS4210 CPU support
 
 config EXYNOS4_MCT
-	bool "Kernel timer support by MCT"
+	bool
+	default y
 	help
 	  Use MCT (Multi Core Timer) as kernel timers
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 60fe5ec..c3c70ab 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -20,12 +20,7 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
-ifeq ($(CONFIG_EXYNOS4_MCT),y)
-obj-y				+= mct.o
-else
-obj-y				+= time.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
-endif
+obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 40a866c..d153309 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -172,7 +172,7 @@ void __init exynos4_init_irq(void)
 {
 	int irq;
 
-	gic_init(0, IRQ_LOCALTIMER, S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+	gic_init(0, IRQ_SPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
 	gic_arch_extn.irq_eoi = exynos4_gic_irq_eoi;
 
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index 4fad076..d7a1e28 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -80,10 +80,4 @@
 		/* As above, this assumes that irqstat and base are preserved.. */
 
 		.macro test_for_ltirq, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		mov	\tmp, #0
-		cmp	\irqnr, #29
-		moveq	\tmp, #1
-		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
 		.endm
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index e497ea2..250427f 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -19,8 +19,6 @@
 
 #define IRQ_PPI(x)		S5P_IRQ(x+16)
 
-#define IRQ_LOCALTIMER		IRQ_PPI(13)
-
 /* SPI: Shared Peripheral Interrupt */
 
 #define IRQ_SPI(x)		S5P_IRQ(x+32)
diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
deleted file mode 100644
index 6bf3d0a..0000000
--- a/arch/arm/mach-exynos4/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/* linux/arch/arm/mach-exynos4/localtimer.c
- *
- * Cloned from linux/arch/arm/mach-realview/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/clockchips.h>
-
-#include <asm/irq.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
deleted file mode 100644
index 9a74294..0000000
--- a/arch/arm/mach-exynos4/time.c
+++ /dev/null
@@ -1,303 +0,0 @@
-/* linux/arch/arm/mach-exynos4/time.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 (and compatible) HRT support
- * PWM 2/4 is used for this feature
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/platform_device.h>
-
-#include <asm/smp_twd.h>
-
-#include <mach/map.h>
-#include <plat/regs-timer.h>
-#include <asm/mach/time.h>
-
-static unsigned long clock_count_per_tick;
-
-static struct clk *tin2;
-static struct clk *tin4;
-static struct clk *tdiv2;
-static struct clk *tdiv4;
-static struct clk *timerclk;
-
-static void exynos4_pwm_stop(unsigned int pwm_id)
-{
-	unsigned long tcon;
-
-	tcon = __raw_readl(S3C2410_TCON);
-
-	switch (pwm_id) {
-	case 2:
-		tcon &= ~S3C2410_TCON_T2START;
-		break;
-	case 4:
-		tcon &= ~S3C2410_TCON_T4START;
-		break;
-	default:
-		break;
-	}
-	__raw_writel(tcon, S3C2410_TCON);
-}
-
-static void exynos4_pwm_init(unsigned int pwm_id, unsigned long tcnt)
-{
-	unsigned long tcon;
-
-	tcon = __raw_readl(S3C2410_TCON);
-
-	/* timers reload after counting zero, so reduce the count by 1 */
-	tcnt--;
-
-	/* ensure timer is stopped... */
-	switch (pwm_id) {
-	case 2:
-		tcon &= ~(0xf<<12);
-		tcon |= S3C2410_TCON_T2MANUALUPD;
-
-		__raw_writel(tcnt, S3C2410_TCNTB(2));
-		__raw_writel(tcnt, S3C2410_TCMPB(2));
-		__raw_writel(tcon, S3C2410_TCON);
-
-		break;
-	case 4:
-		tcon &= ~(7<<20);
-		tcon |= S3C2410_TCON_T4MANUALUPD;
-
-		__raw_writel(tcnt, S3C2410_TCNTB(4));
-		__raw_writel(tcnt, S3C2410_TCMPB(4));
-		__raw_writel(tcon, S3C2410_TCON);
-
-		break;
-	default:
-		break;
-	}
-}
-
-static inline void exynos4_pwm_start(unsigned int pwm_id, bool periodic)
-{
-	unsigned long tcon;
-
-	tcon  = __raw_readl(S3C2410_TCON);
-
-	switch (pwm_id) {
-	case 2:
-		tcon |= S3C2410_TCON_T2START;
-		tcon &= ~S3C2410_TCON_T2MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T2RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T2RELOAD;
-		break;
-	case 4:
-		tcon |= S3C2410_TCON_T4START;
-		tcon &= ~S3C2410_TCON_T4MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T4RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T4RELOAD;
-		break;
-	default:
-		break;
-	}
-	__raw_writel(tcon, S3C2410_TCON);
-}
-
-static int exynos4_pwm_set_next_event(unsigned long cycles,
-					struct clock_event_device *evt)
-{
-	exynos4_pwm_init(2, cycles);
-	exynos4_pwm_start(2, 0);
-	return 0;
-}
-
-static void exynos4_pwm_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
-{
-	exynos4_pwm_stop(2);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		exynos4_pwm_init(2, clock_count_per_tick);
-		exynos4_pwm_start(2, 1);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
-}
-
-static struct clock_event_device pwm_event_device = {
-	.name		= "pwm_timer2",
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 200,
-	.shift		= 32,
-	.set_next_event	= exynos4_pwm_set_next_event,
-	.set_mode	= exynos4_pwm_set_mode,
-};
-
-irqreturn_t exynos4_clock_event_isr(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &pwm_event_device;
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction exynos4_clock_event_irq = {
-	.name		= "pwm_timer2_irq",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= exynos4_clock_event_isr,
-};
-
-static void __init exynos4_clockevent_init(void)
-{
-	unsigned long pclk;
-	unsigned long clock_rate;
-	struct clk *tscaler;
-
-	pclk = clk_get_rate(timerclk);
-
-	/* configure clock tick */
-
-	tscaler = clk_get_parent(tdiv2);
-
-	clk_set_rate(tscaler, pclk / 2);
-	clk_set_rate(tdiv2, pclk / 2);
-	clk_set_parent(tin2, tdiv2);
-
-	clock_rate = clk_get_rate(tin2);
-
-	clock_count_per_tick = clock_rate / HZ;
-
-	pwm_event_device.mult =
-		div_sc(clock_rate, NSEC_PER_SEC, pwm_event_device.shift);
-	pwm_event_device.max_delta_ns =
-		clockevent_delta2ns(-1, &pwm_event_device);
-	pwm_event_device.min_delta_ns =
-		clockevent_delta2ns(1, &pwm_event_device);
-
-	pwm_event_device.cpumask = cpumask_of(0);
-	clockevents_register_device(&pwm_event_device);
-
-	setup_irq(IRQ_TIMER2, &exynos4_clock_event_irq);
-}
-
-static cycle_t exynos4_pwm4_read(struct clocksource *cs)
-{
-	return (cycle_t) ~__raw_readl(S3C_TIMERREG(0x40));
-}
-
-#ifdef CONFIG_PM
-static void exynos4_pwm4_resume(struct clocksource *cs)
-{
-	unsigned long pclk;
-
-	pclk = clk_get_rate(timerclk);
-
-	clk_set_rate(tdiv4, pclk / 2);
-	clk_set_parent(tin4, tdiv4);
-
-	exynos4_pwm_init(4, ~0);
-	exynos4_pwm_start(4, 1);
-}
-#endif
-
-struct clocksource pwm_clocksource = {
-	.name		= "pwm_timer4",
-	.rating		= 250,
-	.read		= exynos4_pwm4_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS ,
-#ifdef CONFIG_PM
-	.resume		= exynos4_pwm4_resume,
-#endif
-};
-
-static void __init exynos4_clocksource_init(void)
-{
-	unsigned long pclk;
-	unsigned long clock_rate;
-
-	pclk = clk_get_rate(timerclk);
-
-	clk_set_rate(tdiv4, pclk / 2);
-	clk_set_parent(tin4, tdiv4);
-
-	clock_rate = clk_get_rate(tin4);
-
-	exynos4_pwm_init(4, ~0);
-	exynos4_pwm_start(4, 1);
-
-	if (clocksource_register_hz(&pwm_clocksource, clock_rate))
-		panic("%s: can't register clocksource\n", pwm_clocksource.name);
-}
-
-static void __init exynos4_timer_resources(void)
-{
-	struct platform_device tmpdev;
-
-	tmpdev.dev.bus = &platform_bus_type;
-
-	timerclk = clk_get(NULL, "timers");
-	if (IS_ERR(timerclk))
-		panic("failed to get timers clock for system timer");
-
-	clk_enable(timerclk);
-
-	tmpdev.id = 2;
-	tmpdev.dev.init_name = "s3c24xx-pwm.2";
-	tin2 = clk_get(&tmpdev.dev, "pwm-tin");
-	if (IS_ERR(tin2))
-		panic("failed to get pwm-tin2 clock for system timer");
-
-	tdiv2 = clk_get(&tmpdev.dev, "pwm-tdiv");
-	if (IS_ERR(tdiv2))
-		panic("failed to get pwm-tdiv2 clock for system timer");
-	clk_enable(tin2);
-
-	tmpdev.id = 4;
-	tmpdev.dev.init_name = "s3c24xx-pwm.4";
-	tin4 = clk_get(&tmpdev.dev, "pwm-tin");
-	if (IS_ERR(tin4))
-		panic("failed to get pwm-tin4 clock for system timer");
-
-	tdiv4 = clk_get(&tmpdev.dev, "pwm-tdiv");
-	if (IS_ERR(tdiv4))
-		panic("failed to get pwm-tdiv4 clock for system timer");
-
-	clk_enable(tin4);
-}
-
-static void __init exynos4_timer_init(void)
-{
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = S5P_VA_TWD;
-#endif
-
-	exynos4_timer_resources();
-	exynos4_clockevent_init();
-	exynos4_clocksource_init();
-}
-
-struct sys_timer exynos4_timer = {
-	.init		= exynos4_timer_init,
-};
-- 
1.7.1
