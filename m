From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:39 +0100
Subject: [RFC PATCH 11/16] ARM: local timers: move exynos4 to
	LOCAL_TIMER_DEVICES/EXYNOS_MCT/ARM_SMP_TWD
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the exynos4 platforms to use the new arm_smp_twd or exynos4_mct
drivers, depending on the configuration. arch/arm/mach-exynos4/mct.c
takes a major hit in the process.

Add the platform devices and register them as early platform devices.

Tested on a SMDK-v310 with TWD only.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/Kconfig      |    2 +
 arch/arm/mach-exynos4/Makefile     |    1 -
 arch/arm/mach-exynos4/localtimer.c |   27 -----
 arch/arm/mach-exynos4/mct.c        |  197 ++---------------------------------
 arch/arm/mach-exynos4/time.c       |   33 +++++-
 arch/arm/plat-s5p/s5p-time.c       |    1 -
 6 files changed, 41 insertions(+), 220 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/localtimer.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 1435fc3..0db7aa3 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -12,6 +12,8 @@ if ARCH_EXYNOS4
 config CPU_EXYNOS4210
 	bool
 	select S3C_PL330_DMA
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD if !EXYNOS4_MCT
 	help
 	  Enable EXYNOS4210 CPU support
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 1366995..b223972 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -23,7 +23,6 @@ ifeq ($(CONFIG_EXYNOS4_MCT),y)
 obj-y				+= mct.o
 else
 obj-y				+= time.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 endif
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-exynos4/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
deleted file mode 100644
index 315de6f..0000000
--- a/arch/arm/mach-exynos4/localtimer.c
+++ /dev/null
@@ -1,27 +0,0 @@
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
-#include <asm/hardware/gic.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index 14ac10b..5aea222 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
@@ -18,7 +17,6 @@
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/percpu.h>
 
 #include <mach/map.h>
 #include <mach/regs-mct.h>
@@ -27,13 +25,6 @@
 static unsigned long clk_cnt_per_tick;
 static unsigned long clk_rate;
 
-struct mct_clock_event_device {
-	struct clock_event_device *evt;
-	void __iomem *base;
-};
-
-struct mct_clock_event_device mct_tick[2];
-
 static void exynos4_mct_write(unsigned int value, void *addr)
 {
 	void __iomem *stat_addr;
@@ -67,30 +58,6 @@ static void exynos4_mct_write(unsigned int value, void *addr)
 		stat_addr = EXYNOS4_MCT_G_CNT_WSTAT;
 		mask = 1 << 1;		/* G_CNT_U write status */
 		break;
-	case (u32)(EXYNOS4_MCT_L0_BASE + MCT_L_TCON_OFFSET):
-		stat_addr = EXYNOS4_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
-		mask = 1 << 3;		/* L0_TCON write status */
-		break;
-	case (u32)(EXYNOS4_MCT_L1_BASE + MCT_L_TCON_OFFSET):
-		stat_addr = EXYNOS4_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
-		mask = 1 << 3;		/* L1_TCON write status */
-		break;
-	case (u32)(EXYNOS4_MCT_L0_BASE + MCT_L_TCNTB_OFFSET):
-		stat_addr = EXYNOS4_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
-		mask = 1 << 0;		/* L0_TCNTB write status */
-		break;
-	case (u32)(EXYNOS4_MCT_L1_BASE + MCT_L_TCNTB_OFFSET):
-		stat_addr = EXYNOS4_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
-		mask = 1 << 0;		/* L1_TCNTB write status */
-		break;
-	case (u32)(EXYNOS4_MCT_L0_BASE + MCT_L_ICNTB_OFFSET):
-		stat_addr = EXYNOS4_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
-		mask = 1 << 1;		/* L0_ICNTB write status */
-		break;
-	case (u32)(EXYNOS4_MCT_L1_BASE + MCT_L_ICNTB_OFFSET):
-		stat_addr = EXYNOS4_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
-		mask = 1 << 1;		/* L1_ICNTB write status */
-		break;
 	default:
 		return;
 	}
@@ -249,158 +216,6 @@ static void exynos4_clockevent_init(void)
 	setup_irq(IRQ_MCT_G0, &mct_comp_event_irq);
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
-/* Clock event handling */
-static void exynos4_mct_tick_stop(struct mct_clock_event_device *mevt)
-{
-	unsigned long tmp;
-	unsigned long mask = MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START;
-	void __iomem *addr = mevt->base + MCT_L_TCON_OFFSET;
-
-	tmp = __raw_readl(addr);
-	if (tmp & mask) {
-		tmp &= ~mask;
-		exynos4_mct_write(tmp, addr);
-	}
-}
-
-static void exynos4_mct_tick_start(unsigned long cycles,
-				   struct mct_clock_event_device *mevt)
-{
-	unsigned long tmp;
-
-	exynos4_mct_tick_stop(mevt);
-
-	tmp = (1 << 31) | cycles;	/* MCT_L_UPDATE_ICNTB */
-
-	/* update interrupt count buffer */
-	exynos4_mct_write(tmp, mevt->base + MCT_L_ICNTB_OFFSET);
-
-	/* enable MCT tick interrupt */
-	exynos4_mct_write(0x1, mevt->base + MCT_L_INT_ENB_OFFSET);
-
-	tmp = __raw_readl(mevt->base + MCT_L_TCON_OFFSET);
-	tmp |= MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START |
-	       MCT_L_TCON_INTERVAL_MODE;
-	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
-}
-
-static int exynos4_tick_set_next_event(unsigned long cycles,
-				       struct clock_event_device *evt)
-{
-	struct mct_clock_event_device *mevt = &mct_tick[smp_processor_id()];
-
-	exynos4_mct_tick_start(cycles, mevt);
-
-	return 0;
-}
-
-static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
-					 struct clock_event_device *evt)
-{
-	struct mct_clock_event_device *mevt = &mct_tick[smp_processor_id()];
-
-	exynos4_mct_tick_stop(mevt);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		exynos4_mct_tick_start(clk_cnt_per_tick, mevt);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
-}
-
-static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
-{
-	struct mct_clock_event_device *mevt = dev_id;
-	struct clock_event_device *evt = mevt->evt;
-
-	/*
-	 * This is for supporting oneshot mode.
-	 * Mct would generate interrupt periodically
-	 * without explicit stopping.
-	 */
-	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
-		exynos4_mct_tick_stop(mevt);
-
-	/* Clear the MCT tick interrupt */
-	exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction mct_tick0_event_irq = {
-	.name		= "mct_tick0_irq",
-	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
-	.handler	= exynos4_mct_tick_isr,
-};
-
-static struct irqaction mct_tick1_event_irq = {
-	.name		= "mct_tick1_irq",
-	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
-	.handler	= exynos4_mct_tick_isr,
-};
-
-static void exynos4_mct_tick_init(struct clock_event_device *evt)
-{
-	unsigned int cpu = smp_processor_id();
-
-	mct_tick[cpu].evt = evt;
-
-	if (cpu == 0) {
-		mct_tick[cpu].base = EXYNOS4_MCT_L0_BASE;
-		evt->name = "mct_tick0";
-	} else {
-		mct_tick[cpu].base = EXYNOS4_MCT_L1_BASE;
-		evt->name = "mct_tick1";
-	}
-
-	evt->cpumask = cpumask_of(cpu);
-	evt->set_next_event = exynos4_tick_set_next_event;
-	evt->set_mode = exynos4_tick_set_mode;
-	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 450;
-
-	clockevents_calc_mult_shift(evt, clk_rate / 2, 5);
-	evt->max_delta_ns =
-		clockevent_delta2ns(0x7fffffff, evt);
-	evt->min_delta_ns =
-		clockevent_delta2ns(0xf, evt);
-
-	clockevents_register_device(evt);
-
-	exynos4_mct_write(0x1, mct_tick[cpu].base + MCT_L_TCNTB_OFFSET);
-
-	if (cpu == 0) {
-		mct_tick0_event_irq.dev_id = &mct_tick[cpu];
-		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
-	} else {
-		mct_tick1_event_irq.dev_id = &mct_tick[cpu];
-		irq_set_affinity(IRQ_MCT1, cpumask_of(1));
-		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
-	}
-}
-
-/* Setup the local clock events for a CPU */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	exynos4_mct_tick_init(evt);
-}
-
-int local_timer_ack(void)
-{
-	return 0;
-}
-
-#endif /* CONFIG_LOCAL_TIMERS */
-
 static void __init exynos4_timer_resources(void)
 {
 	struct clk *mct_clk;
@@ -409,11 +224,23 @@ static void __init exynos4_timer_resources(void)
 	clk_rate = clk_get_rate(mct_clk);
 }
 
+static struct platform_device exynos4_mct_device = {
+	.name		= "exynos4_mct",
+	.id		= -1,
+};
+
+static struct platform_device *exynos4_early_devices[] = {
+	&exynos4_mct_device,
+};
+
 static void __init exynos4_timer_init(void)
 {
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
+
+	early_platform_add_devices(exynos4_early_devices,
+				   ARRAY_SIZE(exynos4_early_devices));
 }
 
 struct sys_timer exynos4_timer = {
diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index ebb8f38..be674d5 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -19,8 +19,6 @@
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
 
-#include <asm/smp_twd.h>
-
 #include <mach/map.h>
 #include <plat/regs-timer.h>
 #include <asm/mach/time.h>
@@ -285,15 +283,38 @@ static void __init exynos4_timer_resources(void)
 	clk_enable(tin4);
 }
 
+static struct resource exynos4_twd_resources[] = {
+	{
+		.start	= EXYNOS4_PA_COREPERI + 0x600,
+		.end	= EXYNOS4_PA_COREPERI + 0x600 + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device exynos4_twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= exynos4_twd_resources,
+	.num_resources	= ARRAY_SIZE(exynos4_twd_resources),
+};
+
+static struct platform_device *exynos4_early_devices[] = {
+	&exynos4_twd_device,
+};
+
 static void __init exynos4_timer_init(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = S5P_VA_TWD;
-#endif
-
 	exynos4_timer_resources();
 	exynos4_clockevent_init();
 	exynos4_clocksource_init();
+
+	early_platform_add_devices(exynos4_early_devices,
+				   ARRAY_SIZE(exynos4_early_devices));
 }
 
 struct sys_timer exynos4_timer = {
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index 899a8cc..f2a0915 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -18,7 +18,6 @@
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
 
-#include <asm/smp_twd.h>
 #include <asm/mach/time.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-- 
1.7.0.4
