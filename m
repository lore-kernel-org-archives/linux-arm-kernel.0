From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:41 +0100
Subject: [RFC PATCH 13/16] ARM: local timers: remove smp_twd from arch/arm
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no in-tree user of arch/arm/kernel/smp_twd.c, as they've
been all converted to driver/clocksource/arm_smp_twd.c.

Shed a tear, and get rid of it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                  |    8 --
 arch/arm/include/asm/localtimer.h |   10 ---
 arch/arm/include/asm/smp_twd.h    |   28 -------
 arch/arm/kernel/Makefile          |    1 -
 arch/arm/kernel/smp_twd.c         |  163 -------------------------------------
 5 files changed, 0 insertions(+), 210 deletions(-)
 delete mode 100644 arch/arm/include/asm/smp_twd.h
 delete mode 100644 arch/arm/kernel/smp_twd.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dafb20a..f3c1124 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1370,13 +1370,6 @@ config HAVE_ARM_SCU
 	help
 	  This option enables support for the ARM system coherency unit
 
-config HAVE_ARM_TWD
-	bool
-	depends on SMP
-	select TICK_ONESHOT
-	help
-	  This options enables support for the ARM timer and watchdog unit
-
 choice
 	prompt "Memory split"
 	default VMSPLIT_3G
@@ -1417,7 +1410,6 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && !LOCAL_TIMER_DEVICES
 	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 5c8acb4..74af2cd 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -26,22 +26,12 @@ irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 
 #ifdef CONFIG_LOCAL_TIMERS
 
-#ifdef CONFIG_HAVE_ARM_TWD
-
-#include "smp_twd.h"
-
-#define local_timer_ack()	twd_timer_ack()
-
-#else
-
 /*
  * Platform provides this to acknowledge a local timer IRQ.
  * Returns true if the local timer IRQ is to be processed.
  */
 int local_timer_ack(void);
 
-#endif
-
 /*
  * Setup a local timer interrupt for a CPU.
  */
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
deleted file mode 100644
index fed9981..0000000
--- a/arch/arm/include/asm/smp_twd.h
+++ /dev/null
@@ -1,28 +0,0 @@
-#ifndef __ASMARM_SMP_TWD_H
-#define __ASMARM_SMP_TWD_H
-
-#define TWD_TIMER_LOAD			0x00
-#define TWD_TIMER_COUNTER		0x04
-#define TWD_TIMER_CONTROL		0x08
-#define TWD_TIMER_INTSTAT		0x0C
-
-#define TWD_WDOG_LOAD			0x20
-#define TWD_WDOG_COUNTER		0x24
-#define TWD_WDOG_CONTROL		0x28
-#define TWD_WDOG_INTSTAT		0x2C
-#define TWD_WDOG_RESETSTAT		0x30
-#define TWD_WDOG_DISABLE		0x34
-
-#define TWD_TIMER_CONTROL_ENABLE	(1 << 0)
-#define TWD_TIMER_CONTROL_ONESHOT	(0 << 1)
-#define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
-#define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
-
-struct clock_event_device;
-
-extern void __iomem *twd_base;
-
-int twd_timer_ack(void);
-void twd_timer_setup(struct clock_event_device *);
-
-#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a5b31af..c6c6d8b 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_PM_SLEEP)		+= sleep.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
-obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
deleted file mode 100644
index aa99656..0000000
--- a/arch/arm/kernel/smp_twd.c
+++ /dev/null
@@ -1,163 +0,0 @@
-/*
- *  linux/arch/arm/kernel/smp_twd.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/smp.h>
-#include <linux/jiffies.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
-
-/* set up by the platform code */
-void __iomem *twd_base;
-
-static unsigned long twd_timer_rate;
-static DEFINE_PER_CPU(bool, irq_reqd);
-
-static void twd_set_mode(enum clock_event_mode mode,
-			struct clock_event_device *clk)
-{
-	unsigned long ctrl;
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* timer load already set up */
-		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
-			| TWD_TIMER_CONTROL_PERIODIC;
-		__raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-		disable_irq(clk->irq);
-		/* fall through */
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		ctrl = 0;
-	}
-
-	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
-}
-
-static int twd_set_next_event(unsigned long evt,
-			struct clock_event_device *unused)
-{
-	unsigned long ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
-
-	ctrl |= TWD_TIMER_CONTROL_ENABLE;
-
-	__raw_writel(evt, twd_base + TWD_TIMER_COUNTER);
-	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
-
-	return 0;
-}
-
-/*
- * local_timer_ack: checks for a local timer interrupt.
- *
- * If a local timer interrupt has occurred, acknowledge and return 1.
- * Otherwise, return 0.
- */
-int twd_timer_ack(void)
-{
-	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
-		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
-		return 1;
-	}
-
-	return 0;
-}
-
-static void __cpuinit twd_calibrate_rate(void)
-{
-	unsigned long count;
-	u64 waitjiffies;
-
-	/*
-	 * If this is the first time round, we need to work out how fast
-	 * the timer ticks
-	 */
-	if (twd_timer_rate == 0) {
-		printk(KERN_INFO "Calibrating local timer... ");
-
-		/* Wait for a tick to start */
-		waitjiffies = get_jiffies_64() + 1;
-
-		while (get_jiffies_64() < waitjiffies)
-			udelay(10);
-
-		/* OK, now the tick has started, let's get the timer going */
-		waitjiffies += 5;
-
-				 /* enable, no interrupt or reload */
-		__raw_writel(0x1, twd_base + TWD_TIMER_CONTROL);
-
-				 /* maximum value */
-		__raw_writel(0xFFFFFFFFU, twd_base + TWD_TIMER_COUNTER);
-
-		while (get_jiffies_64() < waitjiffies)
-			udelay(10);
-
-		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
-
-		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
-
-		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
-			(twd_timer_rate / 1000000) % 100);
-	}
-}
-
-/*
- * Setup the local clock events for a CPU.
- */
-void __cpuinit twd_timer_setup(struct clock_event_device *clk)
-{
-	int err;
-	bool *reqd;
-
-	twd_calibrate_rate();
-
-	clk->name = "local_timer";
-	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-			CLOCK_EVT_FEAT_C3STOP;
-	clk->rating = 350;
-	clk->set_mode = twd_set_mode;
-	clk->set_next_event = twd_set_next_event;
-	clk->shift = 20;
-	clk->mult = div_sc(twd_timer_rate, NSEC_PER_SEC, clk->shift);
-	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
-	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
-
-	reqd = &__get_cpu_var(irq_reqd);
-	if (!*reqd) {
-		err = request_irq(clk->irq, percpu_timer_handler,
-				  IRQF_PERCPU | IRQF_NOBALANCING | IRQF_TIMER,
-				  clk->name, clk);
-		if (err) {
-			pr_err("%s: can't register interrupt %d on cpu %d (%d)\n",
-			       clk->name, clk->irq, smp_processor_id(), err);
-			return;
-		}
-
-		*reqd = true;
-	} else
-		enable_irq(clk->irq);
-
-	clockevents_register_device(clk);
-}
-- 
1.7.0.4
