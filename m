From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: convert to generic clockevent support
References: <git-1267729916-b61fd4926d11e56bef313c0c427a7933a43621c9@rmk-PC>
Message-ID: <git-1267729916-d89d90e05d3d7392921e61fd9a65a20f3dc6a180@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-integrator/core.c |  107 ++++++++++++++++++++++++++------------
 2 files changed, 74 insertions(+), 34 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d656dec..95ea101 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -224,6 +224,7 @@ config ARCH_INTEGRATOR
 	select COMMON_CLKDEV
 	select ICST525
 	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
 	help
 	  Support for ARM's Integrator platform.
 
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 87c6f98..b1ccbe3 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -20,6 +20,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/io.h>
 
 #include <asm/clkdev.h>
@@ -275,61 +276,99 @@ static void integrator_clocksource_init(u32 khz)
 	clocksource_register(cs);
 }
 
+static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
+
 /*
  * IRQ handler for the timer
  */
-static irqreturn_t
-integrator_timer_interrupt(int irq, void *dev_id)
+static irqreturn_t integrator_timer_interrupt(int irq, void *dev_id)
 {
-	/*
-	 * clear the interrupt
-	 */
-	writel(1, TIMER1_VA_BASE + TIMER_INTCLR);
+	struct clock_event_device *evt = dev_id;
+
+	/* clear the interrupt */
+	writel(1, clkevt_base + TIMER_INTCLR);
 
-	timer_tick();
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
 
+static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
+
+	BUG_ON(mode == CLOCK_EVT_MODE_ONESHOT);
+
+	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		writel(timer_reload, clkevt_base + TIMER_LOAD);
+		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+	}
+
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+}
+
+static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
+{
+	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
+
+	writel(ctrl & ~TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+	writel(next, clkevt_base + TIMER_LOAD);
+	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+
+	return 0;
+}
+
+static struct clock_event_device integrator_clockevent = {
+	.name		= "timer1",
+	.shift		= 34,
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.set_mode	= clkevt_set_mode,
+	.set_next_event	= clkevt_set_next_event,
+	.rating		= 300,
+	.cpumask	= cpu_all_mask,
+};
+
 static struct irqaction integrator_timer_irq = {
-	.name		= "Integrator Timer Tick",
+	.name		= "timer",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= integrator_timer_interrupt,
+	.dev_id		= &integrator_clockevent,
 };
 
-/*
- * Set up timer interrupt, and return the current time in seconds.
- */
-void __init integrator_time_init(unsigned long reload, unsigned int ctrl)
+static void integrator_clockevent_init(u32 khz, unsigned int ctrl)
 {
-	unsigned int timer_ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
+	struct clock_event_device *evt = &integrator_clockevent;
 
-	integrator_clocksource_init(reload * HZ / 1000);
+	if (khz * 1000 > 0x100000 * HZ) {
+		khz /= 256;
+		ctrl |= TIMER_CTRL_DIV256;
+	} else if (khz * 1000 > 0x10000 * HZ) {
+		khz /= 16;
+		ctrl |= TIMER_CTRL_DIV16;
+	}
 
-	timer_reload = reload;
-	timer_ctrl |= ctrl;
+	timer_reload = khz * 1000 / HZ;
+	writel(ctrl, clkevt_base + TIMER_CTRL);
 
-	if (timer_reload > 0x100000) {
-		timer_reload >>= 8;
-		timer_ctrl |= TIMER_CTRL_DIV256;
-	} else if (timer_reload > 0x010000) {
-		timer_reload >>= 4;
-		timer_ctrl |= TIMER_CTRL_DIV16;
-	}
+	evt->irq = IRQ_TIMERINT1;
+	evt->mult = div_sc(khz, NSEC_PER_MSEC, evt->shift);
+	evt->max_delta_ns = clockevent_delta2ns(0xffff, evt);
+	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
 
-	/*
-	 * Initialise to a known state (all timers off)
-	 */
+	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
+	clockevents_register_device(evt);
+}
+
+/*
+ * Set up timer(s).
+ */
+void __init integrator_time_init(unsigned long reload, unsigned int ctrl)
+{
 	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	writel(timer_reload, TIMER1_VA_BASE + TIMER_LOAD);
-	writel(timer_reload, TIMER1_VA_BASE + TIMER_VALUE);
-	writel(timer_ctrl, TIMER1_VA_BASE + TIMER_CTRL);
-
-	/*
-	 * Make irqs happen for the system timer
-	 */
-	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
+	integrator_clocksource_init(reload * HZ / 1000);
+	integrator_clockevent_init(reload * HZ / 1000, ctrl);
 }
