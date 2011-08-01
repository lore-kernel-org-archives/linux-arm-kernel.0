From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  1 Aug 2011 18:04:18 +0100
Subject: [RFC PATCH v10 2/4] ARM: gic: Add PPI registration interface
In-Reply-To: <1312218260-14866-1-git-send-email-marc.zyngier@arm.com>
References: <1312218260-14866-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312218260-14866-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to request (and free) a PPI.
It thus makes it useable for more than just the local
timers.

Update TWD and MSM timers to use that functionnality.

Based on an earlier patch by Russell King.

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/common/gic.c               |   94 ++++++++++++++++++++++++++++------
 arch/arm/include/asm/hardware/gic.h |    5 ++-
 arch/arm/include/asm/localtimer.h   |    7 ++-
 arch/arm/include/asm/smp_twd.h      |    1 +
 arch/arm/kernel/smp.c               |    4 +-
 arch/arm/kernel/smp_twd.c           |   17 ++++++-
 arch/arm/mach-msm/timer.c           |   56 +++++++++++----------
 7 files changed, 135 insertions(+), 49 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 8adc002..9022836 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -35,7 +35,6 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
-#include <asm/localtimer.h>
 
 static DEFINE_SPINLOCK(irq_controller_lock);
 
@@ -259,14 +258,25 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	irq_set_chained_handler(irq, gic_handle_cascade_irq);
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
-#define gic_ppi_handler		percpu_timer_handler
-#else
+struct gic_action {
+	irq_handler_t handler;
+	void *data;
+};
+
+static DEFINE_PER_CPU(struct gic_action *, gic_ppi_action);
+static unsigned int gic_nr_ppis, gic_ppi_base;
+
 static irqreturn_t gic_ppi_handler(int irq, void *dev_id)
 {
+	unsigned int ppi = irq - gic_ppi_base;
+	struct gic_action *act;
+
+	act = &__get_cpu_var(gic_ppi_action)[ppi];
+	if (likely(act->handler))
+		return act->handler(irq, act->data);
+
 	return IRQ_NONE;
 }
-#endif
 
 #define PPI_IRQACT(nr)						\
 	{							\
@@ -291,6 +301,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	unsigned int gic_irqs, irq_limit, i;
 	void __iomem *base = gic->dist_base;
 	u32 cpumask = 1 << smp_processor_id();
+	u32 dist_ctr, nrcpus;
 	u32 nrppis = 0, ppi_base = 0;
 
 	cpumask |= cpumask << 8;
@@ -302,11 +313,14 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	 * Find out how many interrupts are supported.
 	 * The GIC only supports up to 1020 interrupt sources.
 	 */
-	gic_irqs = readl_relaxed(base + GIC_DIST_CTR) & 0x1f;
-	gic_irqs = (gic_irqs + 1) * 32;
+	dist_ctr = readl_relaxed(base + GIC_DIST_CTR);
+	gic_irqs = ((dist_ctr & 0x1f) + 1) * 32;
 	if (gic_irqs > 1020)
 		gic_irqs = 1020;
 
+	/* Find out how many CPUs are supported (8 max). */
+	nrcpus = ((dist_ctr >> 5) & 7) + 1;
+
 	/*
 	 * Nobody would be insane enough to use PPIs on a secondary
 	 * GIC, right?
@@ -324,6 +338,19 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 			nrppis = 0;
 			ppi_base = 0;
 		}
+
+		for (i = 0; i < nrcpus; i++) {
+			struct gic_action **ppiacts;
+
+			ppiacts = &per_cpu(gic_ppi_action, i);
+			*ppiacts = kzalloc(sizeof(*gic_ppi_action) * nrppis,
+					   GFP_KERNEL);
+			if (!*ppiacts)
+				pr_err("GIC: Can't allocate PPI CPU%d memory", i);
+		}
+
+		gic_nr_ppis = nrppis;
+		gic_ppi_base = ppi_base;
 	}
 
 	pr_info("Configuring GIC with %d sources (%d PPIs)\n",
@@ -387,6 +414,49 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	writel_relaxed(1, base + GIC_DIST_CTRL);
 }
 
+int gic_request_ppi(unsigned int irq, irq_handler_t handler, void *data)
+{
+	struct gic_action *act;
+	unsigned long flags;
+	unsigned int ppi = irq - gic_ppi_base;
+	int ret = -EBUSY;
+
+	if (ppi >= gic_nr_ppis)
+		return -EINVAL;
+
+	local_irq_save(flags);
+	act = &__get_cpu_var(gic_ppi_action)[ppi];
+	if (!act->handler) {
+		act->handler = handler;
+		act->data = data;
+
+		gic_unmask_irq(irq_get_irq_data(irq));
+		ret = 0;
+	}
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+void gic_free_ppi(unsigned int irq, void *data)
+{
+	struct gic_action *act;
+	unsigned long flags;
+	unsigned int ppi = irq - gic_ppi_base;
+
+	if (ppi >= gic_nr_ppis)
+		return;
+
+	local_irq_save(flags);
+	act = &__get_cpu_var(gic_ppi_action)[ppi];
+	if (act->data == data) {
+		gic_mask_irq(irq_get_irq_data(irq));
+		act->handler = NULL;
+		act->data = NULL;
+	}
+	local_irq_restore(flags);
+}
+
 static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 {
 	void __iomem *dist_base = gic->dist_base;
@@ -436,16 +506,6 @@ void __cpuinit gic_secondary_init(unsigned int gic_nr)
 	gic_cpu_init(&gic_data[gic_nr]);
 }
 
-void __cpuinit gic_enable_ppi(unsigned int irq)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	irq_set_status_flags(irq, IRQ_NOPROBE);
-	gic_unmask_irq(irq_get_irq_data(irq));
-	local_irq_restore(flags);
-}
-
 #ifdef CONFIG_SMP
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 435d3f8..b37780f 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -33,6 +33,8 @@
 #define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
+#include <linux/interrupt.h>
+
 extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
@@ -40,7 +42,8 @@ void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
-void gic_enable_ppi(unsigned int);
+int gic_request_ppi(unsigned int irq, irq_handler_t handler, void *data);
+void gic_free_ppi(unsigned int irq, void *data);
 
 struct gic_chip_data {
 	unsigned int irq_offset;
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index e3663f7..9b0dfbb 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -24,7 +24,6 @@ void percpu_timer_setup(void);
  */
 irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 
-
 #ifdef CONFIG_LOCAL_TIMERS
 
 #ifdef CONFIG_HAVE_ARM_TWD
@@ -32,6 +31,7 @@ irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 #include "smp_twd.h"
 
 #define local_timer_ack()	twd_timer_ack()
+#define local_timer_stop(c)	twd_timer_stop((c))
 
 #else
 
@@ -41,6 +41,11 @@ irqreturn_t percpu_timer_handler(int irq, void *dev_id);
  */
 int local_timer_ack(void);
 
+/*
+ * Stop the local timer
+ */
+void local_timer_stop(struct clock_event_device *);
+
 #endif
 
 /*
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index fed9981..6923037 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -24,5 +24,6 @@ extern void __iomem *twd_base;
 
 int twd_timer_ack(void);
 void twd_timer_setup(struct clock_event_device *);
+void twd_timer_stop(struct clock_event_device *);
 
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b21436c..980b800 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -456,7 +456,7 @@ static void ipi_timer(void)
 #ifdef CONFIG_LOCAL_TIMERS
 irqreturn_t percpu_timer_handler(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
+	struct clock_event_device *evt = dev_id;
 
 	if (local_timer_ack()) {
 		evt->event_handler(evt);
@@ -517,7 +517,7 @@ static void percpu_timer_stop(void)
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
 
-	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	local_timer_stop(evt);
 }
 #endif
 
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 2c277d4..b2c4543 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 
 #include <asm/smp_twd.h>
+#include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
 
 /* set up by the platform code */
@@ -80,6 +81,12 @@ int twd_timer_ack(void)
 	return 0;
 }
 
+void twd_timer_stop(struct clock_event_device *clk)
+{
+	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+	gic_free_ppi(clk->irq, clk);
+}
+
 static void __cpuinit twd_calibrate_rate(void)
 {
 	unsigned long count;
@@ -124,6 +131,8 @@ static void __cpuinit twd_calibrate_rate(void)
  */
 void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
+	int err;
+
 	twd_calibrate_rate();
 
 	clk->name = "local_timer";
@@ -137,8 +146,12 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
-	/* Make sure our local interrupt controller has this enabled */
-	gic_enable_ppi(clk->irq);
+	err = gic_request_ppi(clk->irq, percpu_timer_handler, clk);
+	if (err) {
+		pr_err("%s: can't register interrupt %d on cpu %d (%d)\n",
+		       clk->name, clk->irq, smp_processor_id(), err);
+		return;
+	}
 
 	clockevents_register_device(clk);
 }
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 63621f1..1bcdf66 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -71,7 +71,7 @@ enum timer_location {
 struct msm_clock {
 	struct clock_event_device   clockevent;
 	struct clocksource          clocksource;
-	struct irqaction            irq;
+	unsigned int		    irq;
 	void __iomem                *regbase;
 	uint32_t                    freq;
 	uint32_t                    shift;
@@ -87,13 +87,10 @@ enum {
 
 
 static struct msm_clock msm_clocks[];
-static struct clock_event_device *local_clock_event;
 
 static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
-	if (smp_processor_id() != 0)
-		evt = local_clock_event;
 	if (evt->event_handler == NULL)
 		return IRQ_HANDLED;
 	evt->event_handler(evt);
@@ -171,13 +168,7 @@ static struct msm_clock msm_clocks[] = {
 			.mask           = CLOCKSOURCE_MASK(32),
 			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 		},
-		.irq = {
-			.name    = "gp_timer",
-			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
-			.handler = msm_timer_interrupt,
-			.dev_id  = &msm_clocks[0].clockevent,
-			.irq     = INT_GP_TIMER_EXP
-		},
+		.irq = INT_GP_TIMER_EXP,
 		.freq = GPT_HZ,
 	},
 	[MSM_CLOCK_DGT] = {
@@ -196,13 +187,7 @@ static struct msm_clock msm_clocks[] = {
 			.mask           = CLOCKSOURCE_MASK((32 - MSM_DGT_SHIFT)),
 			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 		},
-		.irq = {
-			.name    = "dg_timer",
-			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
-			.handler = msm_timer_interrupt,
-			.dev_id  = &msm_clocks[1].clockevent,
-			.irq     = INT_DEBUG_TIMER_EXP
-		},
+		.irq = INT_DEBUG_TIMER_EXP,
 		.freq = DGT_HZ >> MSM_DGT_SHIFT,
 		.shift = MSM_DGT_SHIFT,
 	}
@@ -261,10 +246,17 @@ static void __init msm_timer_init(void)
 			printk(KERN_ERR "msm_timer_init: clocksource_register "
 			       "failed for %s\n", cs->name);
 
-		res = setup_irq(clock->irq.irq, &clock->irq);
+		ce->irq = clock->irq;
+		if (cpu_is_msm8x60() || cpu_is_msm8960())
+			res = gic_request_ppi(ce->irq, msm_timer_interrupt, ce);
+		else
+			res = request_irq(ce->irq, msm_timer_interrupt,
+					  IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
+					  ce->name, ce);
+
 		if (res)
-			printk(KERN_ERR "msm_timer_init: setup_irq "
-			       "failed for %s\n", cs->name);
+			pr_err("msm_timer_init: request_irq failed for %s\n",
+			       ce->name);
 
 		clockevents_register_device(ce);
 	}
@@ -273,7 +265,9 @@ static void __init msm_timer_init(void)
 #ifdef CONFIG_SMP
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
+	static bool local_timer_inited;
 	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
+	int res;
 
 	/* Use existing clock_event for cpu 0 */
 	if (!smp_processor_id())
@@ -281,12 +275,13 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 
 	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
 
-	if (!local_clock_event) {
+	if (!local_timer_inited) {
 		writel(0, clock->regbase  + TIMER_ENABLE);
 		writel(0, clock->regbase + TIMER_CLEAR);
 		writel(~0, clock->regbase + TIMER_MATCH_VAL);
+		local_timer_inited = true;
 	}
-	evt->irq = clock->irq.irq;
+	evt->irq = clock->irq;
 	evt->name = "local_timer";
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
 	evt->rating = clock->clockevent.rating;
@@ -298,14 +293,23 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 		clockevent_delta2ns(0xf0000000 >> clock->shift, evt);
 	evt->min_delta_ns = clockevent_delta2ns(4, evt);
 
-	local_clock_event = evt;
-
-	gic_enable_ppi(clock->irq.irq);
+	res = gic_request_ppi(evt->irq, msm_timer_interrupt, evt);
+	if (res) {
+		pr_err("local_timer_setup: request_irq failed for %s\n",
+			       clock->clockevent.name);
+		return res;
+	}
 
 	clockevents_register_device(evt);
 	return 0;
 }
 
+void local_timer_stop(struct clock_event_device *evt)
+{
+	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	gic_free_ppi(evt->irq, evt);
+}
+
 inline int local_timer_ack(void)
 {
 	return 1;
-- 
1.7.0.4
