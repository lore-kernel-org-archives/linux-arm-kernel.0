From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:14 +0000
Subject: [PATCH v3 03/14] picoxcell: add support for the system timers
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-4-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The picoXcell devices have 4 timers capable of generating interrupts
when they reach a predefined value and restarting and a freerunning RTC.
Use one of the interrupt capable timers as the clockevent_device and the
RTC for the clocksource and sched_clock().

v2:
	- use clocksource_register_hz() and
	  clockevents_calc_mult_shift() rather than specifying .mult and
	  .shift.

v3:
	- Incorporate feedback from RMK.
	- Don't emulate oneshot mode in the timers, let the generic
	  clockevents layer do it.
	- Provide a better sched_clock() based on plat-nomadik's.
	- Convert to __raw_ io accessors.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile         |    3 +-
 arch/arm/mach-picoxcell/picoxcell_core.h |    2 +
 arch/arm/mach-picoxcell/time.c           |  255 ++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/time.c

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 6afe388..493ec0e 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1 +1,2 @@
-obj-y				:= picoxcell_core.o io.o axi2cfg.o
+obj-y				:= picoxcell_core.o io.o axi2cfg.o \
+				   time.o
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.h b/arch/arm/mach-picoxcell/picoxcell_core.h
index 5b27e52..941d1a6 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.h
+++ b/arch/arm/mach-picoxcell/picoxcell_core.h
@@ -13,9 +13,11 @@
 #define __ASM_ARCH_PICOXCELL_CORE_H__
 
 struct picoxcell_soc;
+struct sys_timer;
 
 extern void __init picoxcell_core_init(void);
 extern void __init picoxcell_init_irq(void);
 extern void __init picoxcell_map_io(void);
+extern struct sys_timer picoxcell_sys_timer;
 
 #endif /* __ASM_ARCH_PICOXCELL_CORE_H__ */
diff --git a/arch/arm/mach-picoxcell/time.c b/arch/arm/mach-picoxcell/time.c
new file mode 100644
index 0000000..9864200
--- /dev/null
+++ b/arch/arm/mach-picoxcell/time.c
@@ -0,0 +1,255 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/cnt32_to_63.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/mach/time.h>
+
+#include <mach/hardware.h>
+
+#include "picoxcell_core.h"
+#include "soc.h"
+
+enum timer_id {
+	TIMER_ID_CLOCKEVENT,
+	TIMER_ID_CLOCKSOURCE,
+	NR_TIMERS,
+};
+
+struct timer_instance {
+	void __iomem	    *base;
+	struct irqaction    irqaction;
+};
+
+static u32 sched_mult, sched_shift;
+static struct timer_list cnt32_to_63_keepwarm_timer;
+
+/*
+ * We expect to have 2 timers - a freerunning one for the clock source and a
+ * periodic/oneshot one for the clock_event_device.
+ */
+static struct timer_instance timers[NR_TIMERS];
+
+static void timer_set_mode(enum clock_event_mode mode,
+			   struct clock_event_device *clk)
+{
+	struct timer_instance *timer = &timers[TIMER_ID_CLOCKEVENT];
+	unsigned long load_count = DIV_ROUND_UP(CLOCK_TICK_RATE, HZ);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/*
+		 * By default, use the kernel tick rate. The reload value can
+		 * be changed with the timer_set_next_event() function.
+		 */
+		__raw_writel(load_count,
+			     timer->base + TIMER_LOAD_COUNT_REG_OFFSET);
+		__raw_writel(TIMER_ENABLE | TIMER_MODE,
+			     timer->base + TIMER_CONTROL_REG_OFFSET);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		__raw_writel(0, timer->base + TIMER_CONTROL_REG_OFFSET);
+		break;
+	}
+}
+
+static int timer_set_next_event(unsigned long evt,
+				struct clock_event_device *clk)
+{
+	struct timer_instance *timer = &timers[TIMER_ID_CLOCKEVENT];
+
+	/* Disable the timer, write the new event then enable it. */
+	__raw_writel(0, timer->base + TIMER_CONTROL_REG_OFFSET);
+	__raw_writel(evt, timer->base + TIMER_LOAD_COUNT_REG_OFFSET);
+	__raw_writel(TIMER_ENABLE | TIMER_MODE,
+		     timer->base + TIMER_CONTROL_REG_OFFSET);
+
+	return 0;
+}
+
+static struct clock_event_device clockevent_picoxcell = {
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event		= timer_set_next_event,
+	.set_mode		= timer_set_mode,
+};
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id)
+{
+	struct timer_instance *timer = &timers[TIMER_ID_CLOCKEVENT];
+
+	/* Clear the interrupt. */
+	__raw_readl(timer->base + TIMER_EOI_REG_OFFSET);
+
+	clockevent_picoxcell.event_handler(&clockevent_picoxcell);
+
+	return IRQ_HANDLED;
+}
+
+#define PICOXCELL_MIN_RANGE	4
+
+static void picoxcell_clockevent_init(struct picoxcell_soc *soc)
+{
+	struct timer_instance *inst = &timers[TIMER_ID_CLOCKEVENT];
+	const struct picoxcell_timer *timer = NULL;
+	int i;
+
+	for (i = 0; i < soc->nr_timers; ++i)
+		if (soc->timers[i].type == TIMER_TYPE_TIMER) {
+			timer = &soc->timers[i];
+			break;
+		}
+
+	BUG_ON(!timer);
+
+	/* Configure the interrupt for this timer. */
+	inst->irqaction.name	= timer->name;
+	inst->irqaction.handler	= timer_interrupt;
+	inst->irqaction.flags	= IRQF_DISABLED | IRQF_TIMER | IRQF_PROBE;
+	inst->base		= ioremap(timer->base, TIMER_SPACING);
+
+	clockevent_picoxcell.name = timer->name;
+	clockevents_calc_mult_shift(&clockevent_picoxcell, CLOCK_TICK_RATE,
+				    PICOXCELL_MIN_RANGE);
+	clockevent_picoxcell.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_picoxcell);
+	clockevent_picoxcell.min_delta_ns = 50000;
+	clockevent_picoxcell.cpumask = cpumask_of(0);
+
+	/* Start with the timer disabled and the interrupt enabled. */
+	__raw_writel(0, inst->base + TIMER_CONTROL_REG_OFFSET);
+	setup_irq(timer->irq, &inst->irqaction);
+
+	clockevents_register_device(&clockevent_picoxcell);
+}
+
+static cycle_t picoxcell_rtc_get_cycles(struct clocksource *cs)
+{
+	struct timer_instance *inst = &timers[TIMER_ID_CLOCKSOURCE];
+
+	return __raw_readl(inst->base + RTCLK_CCV_REG_OFFSET);
+}
+
+/*
+ * Kernel assumes that sched_clock can be called early but may not have
+ * things ready yet.
+ */
+static cycle_t read_dummy(struct clocksource *cs)
+{
+	return 0;
+}
+
+static struct clocksource clocksource_picoxcell = {
+	.name	    = "rtc",
+	.rating     = 300,
+	.read	    = read_dummy,
+	.mask	    = CLOCKSOURCE_MASK(32),
+	.flags	    = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void __init picoxcell_clocksource_init(struct picoxcell_soc *soc)
+{
+	const struct picoxcell_timer *timer = NULL;
+	int i;
+
+	for (i = 0; i < soc->nr_timers; ++i)
+		if (soc->timers[i].type == TIMER_TYPE_RTC) {
+			timer = &soc->timers[i];
+			break;
+		}
+
+	BUG_ON(!timer);
+
+	timers[TIMER_ID_CLOCKSOURCE].base = ioremap(timer->base, SZ_4K);
+
+	/* The RTC is always running. We don't need to do any initialization. */
+	clocksource_picoxcell.read = picoxcell_rtc_get_cycles;
+	clocksource_register_hz(&clocksource_picoxcell, CLOCK_TICK_RATE);
+}
+
+/*
+ * Overwrite weak default sched_clock with something more precise.
+ *
+ * We use the same idea as plat-nomadik to keep sched_clock() from wrapping
+ * too often as the RTC is clocked at 200MHz. A wrap once a year is
+ * acceptable.
+ */
+#define SCHED_CLOCK_MIN_WRAP	(3600 * 24 * 365)
+unsigned long long notrace sched_clock(void)
+{
+	u64 cycles = cnt32_to_63(__raw_readl(IO_ADDRESS(PICOXCELL_RTCLK_BASE) +
+					     RTCLK_CCV_REG_OFFSET));
+	return (cycles * sched_mult) >> sched_shift;
+}
+
+/* Just kick sched_clock at least once every half period. */
+static void cnt32_to_63_keepwarm(unsigned long data)
+{
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	(void)sched_clock();
+}
+
+static void __init picoxcell_sched_clock_init(unsigned long rate)
+{
+	u32 v;
+	unsigned long delta;
+	u64 days;
+
+	/* Find the appropriate mult and shift factors. */
+	clocks_calc_mult_shift(&sched_mult, &sched_shift, rate,
+			       NSEC_PER_SEC, SCHED_CLOCK_MIN_WRAP);
+	/*
+	 * The multiply needs to be an even number to get rid of bit 63 for
+	 * cnt_32_to_63().
+	 */
+	if (sched_mult & 1)
+		sched_mult++;
+
+	/* Take the max counter value and scale it. */
+	days = (~0LLU * sched_mult) >> sched_shift;
+	do_div(days, NSEC_PER_SEC);
+	do_div(days, 3600 * 24);
+
+	pr_info("sched_clock: using %d bits @ %lu Hz wrap in %lu days\n",
+		(64 - sched_shift), rate, (unsigned long)days);
+
+	/*
+	 * Program a timer to kick us at half 32 bit wraparound.
+	 * Formula: seconds per wrap = (2^32) / f.
+	 */
+	v = (0xFFFFFFFFUL / rate) / 2;
+	pr_debug("sched_clock: prescaled timer rate: %lu Hz, initialize keepwarm timer every %u seconds\n",
+		 rate, v);
+
+	/* Convert seconds into jiffies. */
+	delta = msecs_to_jiffies(v * 1000);
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, delta);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + delta));
+}
+
+static void __init picoxcell_timer_init(void)
+{
+	struct picoxcell_soc *soc = picoxcell_get_soc();
+
+	picoxcell_clocksource_init(soc);
+	picoxcell_clockevent_init(soc);
+	picoxcell_sched_clock_init(CLOCK_TICK_RATE);
+}
+
+struct sys_timer picoxcell_sys_timer = {
+	.init	= picoxcell_timer_init,
+};
-- 
1.7.2.3
