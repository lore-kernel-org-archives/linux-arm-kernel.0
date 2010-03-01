From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Tue, 2 Mar 2010 00:23:07 +0100
Subject: [PATCH] plat-nomadik: use one-shot clock events
Message-ID: <20100301232307.GA10703@morgana.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

This is a complete rewrite of the MTU driver, using one-shot
for events and a free-running timer for stamping. It allows
CONFIG_NO_HZ and CONFIG_HIGH_RES_TIMERS to work on Nomadik and Ux500.

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---

this patch has been rebased onto cec6f922fb34e8495fd29011f45f10d12fc88cb5
i.e. next-20100301. It applies and works equally well on current master
(i.e. 4805a1b0e6d74feb6428c05116a2886a076ee341)

 arch/arm/plat-nomadik/timer.c |  128 +++++++++++++++++++---------------------
 1 files changed, 61 insertions(+), 67 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 62f18ad..db67402 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -2,7 +2,7 @@
  *  linux/arch/arm/mach-nomadik/timer.c
  *
  * Copyright (C) 2008 STMicroelectronics
- * Copyright (C) 2009 Alessandro Rubini, somewhat based on at91sam926x
+ * Copyright (C) 2010 Alessandro Rubini
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2, as
@@ -18,130 +18,124 @@
 
 #include <plat/mtu.h>
 
-static u32	nmdk_count;		/* accumulated count */
-static u32	nmdk_cycle;		/* write-once */
+void __iomem *mtu_base; /* ssigned by machine code */
 
-/* setup by the platform code */
-void __iomem *mtu_base;
-
-/*
- * clocksource: the MTU device is a decrementing counters, so we negate
- * the value being read.
- */
+/* clocksource: MTU decrements, so we negate the value being read. */
 static cycle_t nmdk_read_timer(struct clocksource *cs)
 {
-	u32 count = readl(mtu_base + MTU_VAL(0));
-	return nmdk_count + nmdk_cycle - count;
-
+	return -readl(mtu_base + MTU_VAL(0));
 }
 
 static struct clocksource nmdk_clksrc = {
 	.name		= "mtu_0",
-	.rating		= 120,
+	.rating		= 200,
 	.read		= nmdk_read_timer,
+	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-/*
- * Clockevent device: currently only periodic mode is supported
- */
+/* Clockevent device: use one-shot mode */
 static void nmdk_clkevt_mode(enum clock_event_mode mode,
 			     struct clock_event_device *dev)
 {
-	unsigned long flags;
+	u32 cr;
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		/* enable interrupts -- and count current value? */
-		raw_local_irq_save(flags);
-		writel(readl(mtu_base + MTU_IMSC) | 1, mtu_base + MTU_IMSC);
-		raw_local_irq_restore(flags);
+		pr_err("%s: periodic mode not supported\n", __func__);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
-		BUG(); /* Not supported, yet */
-		/* FALLTHROUGH */
+		/* Load highest value, enable device, enable interrupts */
+		cr = readl(mtu_base + MTU_CR(1));
+		writel(0, mtu_base + MTU_LR(1));
+		writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(1));
+		writel(0x2, mtu_base + MTU_IMSC);
+		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
 		/* disable irq */
-		raw_local_irq_save(flags);
-		writel(readl(mtu_base + MTU_IMSC) & ~1, mtu_base + MTU_IMSC);
-		raw_local_irq_restore(flags);
+		writel(0, mtu_base + MTU_IMSC);
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		break;
 	}
 }
 
+static int nmdk_clkevt_next(unsigned long evt, struct clock_event_device *ev)
+{
+	/* writing the value has immediate effect */
+	writel(evt, mtu_base + MTU_LR(1));
+	return 0;
+}
+
 static struct clock_event_device nmdk_clkevt = {
-	.name		= "mtu_0",
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.name		= "mtu_1",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
-	.rating		= 100,
+	.rating		= 200,
 	.set_mode	= nmdk_clkevt_mode,
+	.set_next_event	= nmdk_clkevt_next,
 };
 
 /*
- * IRQ Handler for the timer 0 of the MTU block. The irq is not shared
- * as we are the only users of mtu0 by now.
+ * IRQ Handler for timer 1 of the MTU block.
  */
 static irqreturn_t nmdk_timer_interrupt(int irq, void *dev_id)
 {
-	/* ack: "interrupt clear register" */
-	writel(1 << 0, mtu_base + MTU_ICR);
-
-	/* we can't count lost ticks, unfortunately */
-	nmdk_count += nmdk_cycle;
-	nmdk_clkevt.event_handler(&nmdk_clkevt);
+	struct clock_event_device *evdev = dev_id;
 
+	writel(1 << 1, mtu_base + MTU_ICR); /* Interrupt clear reg */
+	evdev->event_handler(evdev);
 	return IRQ_HANDLED;
 }
 
-/*
- * Set up timer interrupt, and return the current time in seconds.
- */
 static struct irqaction nmdk_timer_irq = {
 	.name		= "Nomadik Timer Tick",
 	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= nmdk_timer_interrupt,
+	.dev_id		= &nmdk_clkevt,
 };
 
-static void nmdk_timer_reset(void)
-{
-	u32 cr;
-
-	writel(0, mtu_base + MTU_CR(0)); /* off */
-
-	/* configure load and background-load, and fire it up */
-	writel(nmdk_cycle, mtu_base + MTU_LR(0));
-	writel(nmdk_cycle, mtu_base + MTU_BGLR(0));
-	cr = MTU_CRn_PERIODIC | MTU_CRn_PRESCALE_1 | MTU_CRn_32BITS;
-	writel(cr, mtu_base + MTU_CR(0));
-	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
-}
-
 void __init nmdk_timer_init(void)
 {
 	unsigned long rate;
-	int bits;
-
-	rate = CLOCK_TICK_RATE; /* 2.4MHz */
-	nmdk_cycle = (rate + HZ/2) / HZ;
+	u32 cr = MTU_CRn_32BITS;;
+
+	/*
+	 * Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
+	 * use a divide-by-16 counter if it's more than 16MHz
+	 */
+	rate = CLOCK_TICK_RATE;
+	if (rate > 16 << 20) {
+		rate /= 16;
+		cr |= MTU_CRn_PRESCALE_16;
+	} else {
+		cr |= MTU_CRn_PRESCALE_1;
+	}
 
-	/* Init the timer and register clocksource */
-	nmdk_timer_reset();
+	/* Timer 0 is the free running clocksource */
+	writel(cr, mtu_base + MTU_CR(0));
+	writel(0, mtu_base + MTU_LR(0));
+	writel(0, mtu_base + MTU_BGLR(0));
+	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
 
 	nmdk_clksrc.mult = clocksource_hz2mult(rate, nmdk_clksrc.shift);
-	bits =  8*sizeof(nmdk_count);
-	nmdk_clksrc.mask = CLOCKSOURCE_MASK(bits);
 
 	if (clocksource_register(&nmdk_clksrc))
-		printk(KERN_ERR "timer: failed to initialize clock "
-			"source %s\n", nmdk_clksrc.name);
+		pr_err("timer: failed to initialize clock source %s\n",
+		       nmdk_clksrc.name);
+
+	/* Timer 1 is used for events, fix according to rate */
+	writel(cr | MTU_CRn_ONESHOT, mtu_base + MTU_CR(1)); /* off, currently */
+	nmdk_clkevt.mult = div_sc(rate, NSEC_PER_SEC, nmdk_clkevt.shift);
+	nmdk_clkevt.max_delta_ns =
+		clockevent_delta2ns(0xffffffff, &nmdk_clkevt);
+	nmdk_clkevt.min_delta_ns =
+		clockevent_delta2ns(0x00000002, &nmdk_clkevt);
+	nmdk_clkevt.cpumask	= cpumask_of(0);
 
 	/* Register irq and clockevents */
 	setup_irq(IRQ_MTU0, &nmdk_timer_irq);
-	nmdk_clkevt.mult = div_sc(rate, NSEC_PER_SEC, nmdk_clkevt.shift);
-	nmdk_clkevt.cpumask = cpumask_of(0);
 	clockevents_register_device(&nmdk_clkevt);
 }
-- 
1.5.6.5
