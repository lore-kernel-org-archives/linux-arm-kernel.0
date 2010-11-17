From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Nov 2010 19:03:42 +0800
Subject: [PATCH 8/9] ARM: pxa: add 32KHz timer as clock source
In-Reply-To: <1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-6-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA silicons are using 3MHz timer as default clock source. But it'll be stopped
counting in low power mode. Although 32KHz timer is slow, it can continue
counting in low power mode. While low power mode is implemented as idle,
stopped timer can't be accepted.

Add 32KHz timer as an alternative clock source. User can switch clock source
on demand.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mach-pxa/include/mach/regs-ost.h |    2 +
 arch/arm/mach-pxa/time.c                  |  217 +++++++++++++++++++++++------
 2 files changed, 174 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ost.h b/arch/arm/mach-pxa/include/mach/regs-ost.h
index a3e5f86..ac01d5c 100644
--- a/arch/arm/mach-pxa/include/mach/regs-ost.h
+++ b/arch/arm/mach-pxa/include/mach/regs-ost.h
@@ -19,6 +19,7 @@
 #define OWER		__REG(0x40A00018)  /* OS Timer Watchdog Enable Register */
 #define OIER		__REG(0x40A0001C)  /* OS Timer Interrupt Enable Register */
 
+#define OSSR_M4		(1 << 4)	/* Match status channel 4 */
 #define OSSR_M3		(1 << 3)	/* Match status channel 3 */
 #define OSSR_M2		(1 << 2)	/* Match status channel 2 */
 #define OSSR_M1		(1 << 1)	/* Match status channel 1 */
@@ -26,6 +27,7 @@
 
 #define OWER_WME	(1 << 0)	/* Watchdog Match Enable */
 
+#define OIER_E4		(1 << 4)	/* Interrupt enable channel 4 */
 #define OIER_E3		(1 << 3)	/* Interrupt enable channel 3 */
 #define OIER_E2		(1 << 2)	/* Interrupt enable channel 2 */
 #define OIER_E1		(1 << 1)	/* Interrupt enable channel 1 */
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index dd96128..4edd597 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -7,6 +7,10 @@
  * Derived from Nicolas Pitre's PXA timer handler Copyright (c) 2001
  * by MontaVista Software, Inc.  (Nico, your code rocks!)
  *
+ * Support 32KHz timer as alternative timer.
+ * Copyright (c) 2010 by Marvell International Inc.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -18,12 +22,21 @@
 #include <linux/clockchips.h>
 #include <linux/sched.h>
 #include <linux/cnt32_to_63.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
 
 #include <asm/div64.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <mach/regs-ost.h>
 
+#define OSCR2NS_SCALE_FACTOR	10
+#define MIN_OSCR_DELTA		16
+#define PXA_CLOCK_32K		32768
+
+static struct clock_event_device ckevt_pxa;
+static atomic_t active_oscr0, active_32k;
+
 /*
  * This is PXA's sched_clock implementation. This has a resolution
  * of at least 308 ns and a maximum value of 208 days.
@@ -33,8 +46,6 @@
  * calls to sched_clock() which should always be the case in practice.
  */
 
-#define OSCR2NS_SCALE_FACTOR 10
-
 static unsigned long oscr2ns_scale;
 
 static void __init set_oscr2ns_scale(unsigned long oscr_rate)
@@ -53,15 +64,28 @@ static void __init set_oscr2ns_scale(unsigned long oscr_rate)
 
 unsigned long long sched_clock(void)
 {
-	unsigned long long v = cnt32_to_63(OSCR);
-	return (v * oscr2ns_scale) >> OSCR2NS_SCALE_FACTOR;
+	unsigned long long v;
+
+	if (atomic_read(&active_32k) && !atomic_read(&active_oscr0)) {
+		/*
+		 * 32KHz timer is current clock source
+		 * 32768 / x = (10 ^ 9) / nsec
+		 * nsec = (10^9) / 32768 = (10^9) >> 15 = (5^9) >> 6
+		 */
+		v = (unsigned long long)OSCR4 * (5 ^ 9) >> 6;
+	} else {
+		v = cnt32_to_63(OSCR);
+		v = (v * oscr2ns_scale) >> OSCR2NS_SCALE_FACTOR;
+	}
+	return v;
 }
 
+static inline int cpu_has_32khz_timer(void)
+{
+	return !cpu_is_pxa25x();
+}
 
-#define MIN_OSCR_DELTA 16
-
-static irqreturn_t
-pxa_ost0_interrupt(int irq, void *dev_id)
+static irqreturn_t pxa_ost0_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *c = dev_id;
 
@@ -73,33 +97,80 @@ pxa_ost0_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int
-pxa_osmr0_set_next_event(unsigned long delta, struct clock_event_device *dev)
+static struct irqaction pxa_ost0_irq = {
+	.name		= "ost0",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= pxa_ost0_interrupt,
+	.dev_id		= &ckevt_pxa,
+};
+
+static irqreturn_t pxa_32k_interrupt(int irq, void *dev_id)
 {
-	unsigned long next, oscr;
+	struct clock_event_device *c = dev_id;
 
-	OIER |= OIER_E0;
-	next = OSCR + delta;
-	OSMR0 = next;
-	oscr = OSCR;
+	OIER &= ~OIER_E4;
+	OSSR = OSSR_M4;
+	c->event_handler(c);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction pxa_ost4_irq = {
+	.name		= "ost4",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= pxa_32k_interrupt,
+	.dev_id		= &ckevt_pxa,
+};
 
-	return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
+static int pxa_set_next_event(unsigned long delta,
+			      struct clock_event_device *dev)
+{
+	unsigned long next, oscr, oscr4;
+
+	if (atomic_read(&active_oscr0) && atomic_read(&active_32k)) {
+		OIER |= OIER_E0;
+		next = OSCR + (MIN_OSCR_DELTA << 1);
+		OSMR0 = next;
+		oscr = OSCR;
+		return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
+	} else if (atomic_read(&active_32k)) {
+		OIER |= OIER_E4;
+		next = OSCR4 + delta;
+		OSMR4 = next;
+		oscr4 = OSCR4;
+		return (signed)(next - oscr4) <= MIN_OSCR_DELTA ? -ETIME : 0;
+	} else {
+		OIER |= OIER_E0;
+		next = OSCR + delta;
+		OSMR0 = next;
+		oscr = OSCR;
+		return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
+	}
 }
 
-static void
-pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
+static void pxa_set_mode(enum clock_event_mode mode,
+			 struct clock_event_device *dev)
 {
 	switch (mode) {
 	case CLOCK_EVT_MODE_ONESHOT:
-		OIER &= ~OIER_E0;
-		OSSR = OSSR_M0;
+		if (likely(atomic_read(&active_oscr0))) {
+			OIER &= ~OIER_E0;
+			OSSR = OSSR_M0;
+		} else {
+			OIER &= ~OIER_E4;
+			OSSR = OSSR_M4;
+		}
 		break;
 
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		/* initializing, released, or preparing for suspend */
-		OIER &= ~OIER_E0;
-		OSSR = OSSR_M0;
+		if (likely(atomic_read(&active_oscr0))) {
+			OIER &= ~OIER_E0;
+			OSSR = OSSR_M0;
+		} else {
+			OIER &= ~OIER_E4;
+			OSSR = OSSR_M4;
+		}
 		break;
 
 	case CLOCK_EVT_MODE_RESUME:
@@ -108,12 +179,12 @@ pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	}
 }
 
-static struct clock_event_device ckevt_pxa_osmr0 = {
-	.name		= "osmr0",
+static struct clock_event_device ckevt_pxa = {
+	.name		= "osmr",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 200,
-	.set_next_event	= pxa_osmr0_set_next_event,
-	.set_mode	= pxa_osmr0_set_mode,
+	.set_next_event	= pxa_set_next_event,
+	.set_mode	= pxa_set_mode,
 };
 
 static cycle_t pxa_read_oscr(struct clocksource *cs)
@@ -121,42 +192,98 @@ static cycle_t pxa_read_oscr(struct clocksource *cs)
 	return OSCR;
 }
 
+static int pxa_ost0_enable(struct clocksource *cs)
+{
+	atomic_set(&active_oscr0, 1);
+	clockevents_calc_mult_shift(&ckevt_pxa, get_clock_tick_rate(), 4);
+	return 0;
+}
+
+static void pxa_ost0_disable(struct clocksource *cs)
+{
+	atomic_dec(&active_oscr0);
+}
+
 static struct clocksource cksrc_pxa_oscr0 = {
-	.name           = "oscr0",
-	.rating         = 200,
-	.read           = pxa_read_oscr,
-	.mask           = CLOCKSOURCE_MASK(32),
+	.name		= "accurate",
+	.rating		= 200,
+	.read		= pxa_read_oscr,
+	.enable		= pxa_ost0_enable,
+	.disable	= pxa_ost0_disable,
+	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static struct irqaction pxa_ost0_irq = {
-	.name		= "ost0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= pxa_ost0_interrupt,
-	.dev_id		= &ckevt_pxa_osmr0,
+static cycle_t pxa_32k_read(struct clocksource *cs)
+{
+	return OSCR4;
+}
+
+static int pxa_32k_enable(struct clocksource *cs)
+{
+	atomic_set(&active_32k, 1);
+	clockevents_calc_mult_shift(&ckevt_pxa, PXA_CLOCK_32K, 4);
+	return 0;
+}
+
+static void pxa_32k_disable(struct clocksource *cs)
+{
+	atomic_dec(&active_32k);
+}
+
+static struct clocksource cksrc_pxa_32k = {
+	.name		= "32k",
+	.rating		= 150,
+	.read		= pxa_32k_read,
+	.enable		= pxa_32k_enable,
+	.disable	= pxa_32k_disable,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+/*
+ * The rating of OSCR0 _must_ be large than the rating of OSCR4.
+ * So default timer is OSCR0.
+ *
+ * While PXA SoC enters into low power mode, OSCR0 will stop. So using OSCR4
+ * as timer is alternative choice.
+ *
+ * While PXA SoC needs accurate timer, OSCR0 is the best choice.
+ */
 static void __init pxa_timer_init(void)
 {
 	unsigned long clock_tick_rate = get_clock_tick_rate();
 
 	OIER = 0;
-	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
+	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3 | OSSR_M4;
 
 	set_oscr2ns_scale(clock_tick_rate);
 
-	clocksource_calc_mult_shift(&cksrc_pxa_oscr0, clock_tick_rate, 4);
-	clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
-	ckevt_pxa_osmr0.max_delta_ns =
-		clockevent_delta2ns(0x7fffffff, &ckevt_pxa_osmr0);
-	ckevt_pxa_osmr0.min_delta_ns =
-		clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_pxa_osmr0) + 1;
-	ckevt_pxa_osmr0.cpumask = cpumask_of(0);
+	atomic_set(&active_oscr0, 0);
+	atomic_set(&active_32k, 0);
 
-	setup_irq(IRQ_OST0, &pxa_ost0_irq);
+	if (cpu_has_32khz_timer()) {
+		OMCR4 = 0xc1;		/* match OSCR4 & periodic timer */
+		OSMR4 = 0;
+		OSCR4 = 1;
+
+		clocksource_calc_mult_shift(&cksrc_pxa_32k, PXA_CLOCK_32K, 4);
+		setup_irq(IRQ_OST_4_11, &pxa_ost4_irq);
+		clocksource_register(&cksrc_pxa_32k);
+	}
 
+	clocksource_calc_mult_shift(&cksrc_pxa_oscr0, clock_tick_rate, 4);
+	setup_irq(IRQ_OST0, &pxa_ost0_irq);
 	clocksource_register(&cksrc_pxa_oscr0);
-	clockevents_register_device(&ckevt_pxa_osmr0);
+
+	clockevents_calc_mult_shift(&ckevt_pxa, clock_tick_rate, 4);
+	ckevt_pxa.max_delta_ns =
+		clockevent_delta2ns(0x7fffffff, &ckevt_pxa);
+	ckevt_pxa.min_delta_ns =
+		clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_pxa) + 1;
+	ckevt_pxa.cpumask = cpumask_of(0);
+
+	clockevents_register_device(&ckevt_pxa);
 }
 
 #ifdef CONFIG_PM
-- 
1.5.6.5
