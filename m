From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:46:48 +0200
Subject: [PATCH 5/7] ARM: plat-nomadik: timer: Add support for periodic timers
Message-ID: <1316699208-21392-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

This adds support for a periodic mode in the MTU (Nomadik)
timer clockevent driver. It also include changes needed for
deeper powerstates where MTU block gets powered off.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/timer.c |   88 ++++++++++++++++++++++++++++-------------
 1 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index bd638c5..a04b521 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -23,7 +23,12 @@
 
 #include <plat/mtu.h>
 
+static bool clkevt_periodic;
+static u32 clk_prescale;
+static u32 nmdk_cycle;		/* write-once */
+
 void __iomem *mtu_base; /* Assigned by machine code */
+
 #ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
 /*
  * Override the global weak sched_clock symbol with this
@@ -49,31 +54,55 @@ static void notrace nomadik_update_sched_clock(void)
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 #endif
+
 /* Clockevent device: use one-shot mode */
+static int nmdk_clkevt_next(unsigned long evt, struct clock_event_device *ev)
+{
+	writel(1 << 1, mtu_base + MTU_IMSC);
+	writel(evt, mtu_base + MTU_LR(1));
+	/* Load highest value, enable device, enable interrupts */
+	writel(MTU_CRn_ONESHOT | clk_prescale |
+	       MTU_CRn_32BITS | MTU_CRn_ENA,
+	       mtu_base + MTU_CR(1));
+
+	return 0;
+}
+
+static void nmdk_clkevt_reset(void)
+{
+	if (clkevt_periodic) {
+
+		/* Timer: configure load and background-load, and fire it up */
+		writel(nmdk_cycle, mtu_base + MTU_LR(1));
+		writel(nmdk_cycle, mtu_base + MTU_BGLR(1));
+
+		writel(MTU_CRn_PERIODIC | clk_prescale |
+		       MTU_CRn_32BITS | MTU_CRn_ENA,
+		       mtu_base + MTU_CR(1));
+		writel(1 << 1, mtu_base + MTU_IMSC);
+	} else {
+		/* Generate an interrupt to start the clockevent again */
+		(void) nmdk_clkevt_next(nmdk_cycle, NULL);
+	}
+}
+
 static void nmdk_clkevt_mode(enum clock_event_mode mode,
 			     struct clock_event_device *dev)
 {
-	u32 cr;
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		pr_err("%s: periodic mode not supported\n", __func__);
+		clkevt_periodic = true;
+		nmdk_clkevt_reset();
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
-		/* Load highest value, enable device, enable interrupts */
-		cr = readl(mtu_base + MTU_CR(1));
-		writel(0, mtu_base + MTU_LR(1));
-		writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(1));
-		writel(1 << 1, mtu_base + MTU_IMSC);
+		clkevt_periodic = false;
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
-		/* disable irq */
 		writel(0, mtu_base + MTU_IMSC);
 		/* disable timer */
-		cr = readl(mtu_base + MTU_CR(1));
-		cr &= ~MTU_CRn_ENA;
-		writel(cr, mtu_base + MTU_CR(1));
+		writel(0, mtu_base + MTU_CR(1));
 		/* load some high default value */
 		writel(0xffffffff, mtu_base + MTU_LR(1));
 		break;
@@ -82,16 +111,9 @@ static void nmdk_clkevt_mode(enum clock_event_mode mode,
 	}
 }
 
-static int nmdk_clkevt_next(unsigned long evt, struct clock_event_device *ev)
-{
-	/* writing the value has immediate effect */
-	writel(evt, mtu_base + MTU_LR(1));
-	return 0;
-}
-
 static struct clock_event_device nmdk_clkevt = {
 	.name		= "mtu_1",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
 	.rating		= 200,
 	.set_mode	= nmdk_clkevt_mode,
 	.set_next_event	= nmdk_clkevt_next,
@@ -116,11 +138,23 @@ static struct irqaction nmdk_timer_irq = {
 	.dev_id		= &nmdk_clkevt,
 };
 
+static void nmdk_clksrc_reset(void)
+{
+	/* Disable */
+	writel(0, mtu_base + MTU_CR(0));
+
+	/* ClockSource: configure load and background-load, and fire it up */
+	writel(nmdk_cycle, mtu_base + MTU_LR(0));
+	writel(nmdk_cycle, mtu_base + MTU_BGLR(0));
+
+	writel(clk_prescale | MTU_CRn_32BITS | MTU_CRn_ENA,
+	       mtu_base + MTU_CR(0));
+}
+
 void __init nmdk_timer_init(void)
 {
 	unsigned long rate;
 	struct clk *clk0;
-	u32 cr = MTU_CRn_32BITS;
 
 	clk0 = clk_get_sys("mtu0", NULL);
 	BUG_ON(IS_ERR(clk0));
@@ -138,16 +172,16 @@ void __init nmdk_timer_init(void)
 	rate = clk_get_rate(clk0);
 	if (rate > 32000000) {
 		rate /= 16;
-		cr |= MTU_CRn_PRESCALE_16;
+		clk_prescale = MTU_CRn_PRESCALE_16;
 	} else {
-		cr |= MTU_CRn_PRESCALE_1;
+		clk_prescale = MTU_CRn_PRESCALE_1;
 	}
 
+	nmdk_cycle = (rate + HZ/2) / HZ;
+
+
 	/* Timer 0 is the free running clocksource */
-	writel(cr, mtu_base + MTU_CR(0));
-	writel(0, mtu_base + MTU_LR(0));
-	writel(0, mtu_base + MTU_BGLR(0));
-	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
+	nmdk_clksrc_reset();
 
 	if (clocksource_mmio_init(mtu_base + MTU_VAL(0), "mtu_0",
 			rate, 200, 32, clocksource_mmio_readl_down))
@@ -160,8 +194,6 @@ void __init nmdk_timer_init(void)
 
 	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
 
-	writel(cr | MTU_CRn_ONESHOT, mtu_base + MTU_CR(1)); /* off, currently */
-
 	nmdk_clkevt.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &nmdk_clkevt);
 	nmdk_clkevt.min_delta_ns =
-- 
1.7.3.2
