From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Nov 2010 10:06:04 +0000
Subject: [RFC PATCH 03/13] picoxcell: add support for the system timers
In-Reply-To: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1290506774-17895-4-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The picoXcell devices have 4 timers capable of generating interrupts
when they reach a predefined value and restarting and a freerunning RTC.
Use one of the interrupt capable timers as the clockevent_device and the
RTC for the clocksource and sched_clock().

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile         |    3 +-
 arch/arm/mach-picoxcell/picoxcell_core.h |    2 +
 arch/arm/mach-picoxcell/time.c           |  206 ++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 7246a6a..726c61f 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1 +1,2 @@
-obj-y				:= picoxcell_core.o axi2cfg.o
+obj-y				:= picoxcell_core.o axi2cfg.o \
+				   time.o
\ No newline at end of file
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
index 0000000..67062cb
--- /dev/null
+++ b/arch/arm/mach-picoxcell/time.c
@@ -0,0 +1,206 @@
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
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
+		writel(load_count, timer->base + TIMER_LOAD_COUNT_REG_OFFSET);
+		writel(TIMER_ENABLE | TIMER_MODE,
+		       timer->base + TIMER_CONTROL_REG_OFFSET);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		writel(TIMER_MODE, timer->base + TIMER_CONTROL_REG_OFFSET);
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		writel(0, timer->base + TIMER_CONTROL_REG_OFFSET);
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
+	writel(0, timer->base + TIMER_CONTROL_REG_OFFSET);
+	writel(evt, timer->base + TIMER_LOAD_COUNT_REG_OFFSET);
+	writel(TIMER_ENABLE | TIMER_MODE,
+	       timer->base + TIMER_CONTROL_REG_OFFSET);
+
+	return 0;
+}
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id);
+
+static struct clock_event_device clockevent_picoxcell = {
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.shift			= 20,
+	.set_next_event		= timer_set_next_event,
+	.set_mode		= timer_set_mode,
+};
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id)
+{
+	struct timer_instance *timer = &timers[TIMER_ID_CLOCKEVENT];
+
+	/* If we are in oneshot mode, we need to stop receiving interrupts. */
+	if (CLOCK_EVT_MODE_ONESHOT == clockevent_picoxcell.mode) {
+		unsigned long val = readl(timer->base +
+					  TIMER_CONTROL_REG_OFFSET);
+		val |= TIMER_INTERRUPT_MASK;
+		writel(val, timer->base + TIMER_CONTROL_REG_OFFSET);
+	}
+
+	/* Clear the interrupt. */
+	readl(timer->base + TIMER_EOI_REG_OFFSET);
+
+	clockevent_picoxcell.event_handler(&clockevent_picoxcell);
+
+	return IRQ_HANDLED;
+}
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
+	clockevent_picoxcell.name   = timer->name;
+	clockevent_picoxcell.mult   = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
+					     clockevent_picoxcell.shift);
+	clockevent_picoxcell.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_picoxcell);
+	clockevent_picoxcell.min_delta_ns = 50000;
+	clockevent_picoxcell.cpumask = cpumask_of(0);
+
+	/* Start with the timer disabled and the interrupt enabled. */
+	writel(0, inst->base + TIMER_CONTROL_REG_OFFSET);
+	setup_irq(timer->irq, &inst->irqaction);
+
+	clockevents_register_device(&clockevent_picoxcell);
+}
+
+static cycle_t picoxcell_rtc_get_cycles(struct clocksource *cs)
+{
+	struct timer_instance *inst = &timers[TIMER_ID_CLOCKSOURCE];
+
+	return readl(inst->base + RTCLK_CCV_REG_OFFSET);
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
+	.shift	    = 2,
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
+	clocksource_picoxcell.mult = clocksource_hz2mult(CLOCK_TICK_RATE,
+						clocksource_picoxcell.shift);
+	clocksource_picoxcell.read = picoxcell_rtc_get_cycles;
+	clocksource_register(&clocksource_picoxcell);
+}
+
+/*
+ * Overwrite weak default sched_clock with something more precise
+ */
+unsigned long long notrace sched_clock(void)
+{
+	const cycle_t cyc = clocksource_picoxcell.read(&clocksource_picoxcell);
+
+	return clocksource_cyc2ns(cyc, clocksource_picoxcell.mult,
+				  clocksource_picoxcell.shift);
+}
+
+static void __init picoxcell_timer_init(void)
+{
+	struct picoxcell_soc *soc = picoxcell_get_soc();
+
+	picoxcell_clocksource_init(soc);
+	picoxcell_clockevent_init(soc);
+}
+
+struct sys_timer picoxcell_sys_timer = {
+	.init	= picoxcell_timer_init,
+};
-- 
1.7.2.3
