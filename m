From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Realview/Versatile: separate out common SP804 timer
	code
References: <git-1267729916-5eb24b69c868ed8197842aa7c1576cdd05d9d41e@rmk-PC>
Message-ID: <git-1267729916-b3b2e99b741f69ced39e5e0f96dbe3564d8b3a21@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                                |    5 +
 arch/arm/mach-realview/core.c                   |  139 +------------------
 arch/arm/mach-versatile/core.c                  |  135 +------------------
 arch/arm/plat-versatile/Makefile                |    1 +
 arch/arm/plat-versatile/include/plat/timer-sp.h |    2 +
 arch/arm/plat-versatile/timer-sp.c              |  168 +++++++++++++++++++++++
 6 files changed, 182 insertions(+), 268 deletions(-)
 create mode 100644 arch/arm/plat-versatile/include/plat/timer-sp.h
 create mode 100644 arch/arm/plat-versatile/timer-sp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d296ae9..01bc0dd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -239,6 +239,7 @@ config ARCH_REALVIEW
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
+	select ARM_TIMER_SP804
 	help
 	  This enables support for ARM Ltd RealView boards.
 
@@ -253,6 +254,7 @@ config ARCH_VERSATILE
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
+	select ARM_TIMER_SP804
 	help
 	  This enables support for ARM Ltd Versatile board.
 
@@ -858,6 +860,9 @@ config PLAT_PXA
 config PLAT_VERSATILE
 	bool
 
+config ARM_TIMER_SP804
+	bool
+
 source arch/arm/mm/Kconfig
 
 config IWMMXT
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 17eb7eb..80b8142 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -25,8 +25,6 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/ata_platform.h>
@@ -51,6 +49,7 @@
 #include <mach/clkdev.h>
 #include <mach/platform.h>
 #include <mach/irqs.h>
+#include <plat/timer-sp.h>
 
 #include "core.h"
 
@@ -646,133 +645,6 @@ void __iomem *timer2_va_base;
 void __iomem *timer3_va_base;
 
 /*
- * How long is the timer interval?
- */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >= 0x100000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 8)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV256)
-#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
-#elif TIMER_INTERVAL >= 0x10000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 4)		/* Divide by 16 */
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV16)
-#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
-#else
-#define TIMER_RELOAD	(TIMER_INTERVAL)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV1)
-#define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
-#endif
-
-static void timer_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *clk)
-{
-	unsigned long ctrl;
-
-	switch(mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, timer0_va_base + TIMER_LOAD);
-
-		ctrl = TIMER_CTRL_PERIODIC;
-		ctrl |= TIMER_CTRL_32BIT | TIMER_CTRL_IE | TIMER_CTRL_ENABLE;
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl = TIMER_CTRL_ONESHOT;
-		ctrl |= TIMER_CTRL_32BIT | TIMER_CTRL_IE;
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		ctrl = 0;
-	}
-
-	writel(ctrl, timer0_va_base + TIMER_CTRL);
-}
-
-static int timer_set_next_event(unsigned long evt,
-				struct clock_event_device *unused)
-{
-	unsigned long ctrl = readl(timer0_va_base + TIMER_CTRL);
-
-	writel(evt, timer0_va_base + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, timer0_va_base + TIMER_CTRL);
-
-	return 0;
-}
-
-static struct clock_event_device timer0_clockevent =	 {
-	.name		= "timer0",
-	.shift		= 32,
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= timer_set_mode,
-	.set_next_event	= timer_set_next_event,
-	.rating		= 300,
-	.cpumask	= cpu_all_mask,
-};
-
-static void __init realview_clockevents_init(unsigned int timer_irq)
-{
-	timer0_clockevent.irq = timer_irq;
-	timer0_clockevent.mult =
-		div_sc(1000000, NSEC_PER_SEC, timer0_clockevent.shift);
-	timer0_clockevent.max_delta_ns =
-		clockevent_delta2ns(0xffffffff, &timer0_clockevent);
-	timer0_clockevent.min_delta_ns =
-		clockevent_delta2ns(0xf, &timer0_clockevent);
-
-	clockevents_register_device(&timer0_clockevent);
-}
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t realview_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &timer0_clockevent;
-
-	/* clear the interrupt */
-	writel(1, timer0_va_base + TIMER_INTCLR);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction realview_timer_irq = {
-	.name		= "RealView Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= realview_timer_interrupt,
-};
-
-static cycle_t realview_get_cycles(struct clocksource *cs)
-{
-	return ~readl(timer3_va_base + TIMER_VALUE);
-}
-
-static struct clocksource clocksource_realview = {
-	.name	= "timer3",
-	.rating	= 200,
-	.read	= realview_get_cycles,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.shift	= 20,
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static void __init realview_clocksource_init(void)
-{
-	/* setup timer 0 as free-running clocksource */
-	writel(0, timer3_va_base + TIMER_CTRL);
-	writel(0xffffffff, timer3_va_base + TIMER_LOAD);
-	writel(0xffffffff, timer3_va_base + TIMER_VALUE);
-	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		timer3_va_base + TIMER_CTRL);
-
-	clocksource_realview.mult =
-		clocksource_khz2mult(1000, clocksource_realview.shift);
-	clocksource_register(&clocksource_realview);
-}
-
-/*
  * Set up the clock source and clock events devices
  */
 void __init realview_timer_init(unsigned int timer_irq)
@@ -799,13 +671,8 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer2_va_base + TIMER_CTRL);
 	writel(0, timer3_va_base + TIMER_CTRL);
 
-	/* 
-	 * Make irqs happen for the system timer
-	 */
-	setup_irq(timer_irq, &realview_timer_irq);
-
-	realview_clocksource_init();
-	realview_clockevents_init(timer_irq);
+	sp804_clocksource_init(timer3_va_base);
+	sp804_clockevents_init(timer0_va_base, timer_irq);
 }
 
 /*
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e9d255f..b68ddd3 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -28,8 +28,6 @@
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
 #include <linux/cnt32_to_63.h>
 #include <linux/io.h>
 
@@ -50,6 +48,7 @@
 #include <mach/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
+#include <plat/timer-sp.h>
 
 #include "core.h"
 
@@ -877,120 +876,6 @@ void __init versatile_init(void)
 #define TIMER1_VA_BASE		(__io_address(VERSATILE_TIMER0_1_BASE) + 0x20)
 #define TIMER2_VA_BASE		 __io_address(VERSATILE_TIMER2_3_BASE)
 #define TIMER3_VA_BASE		(__io_address(VERSATILE_TIMER2_3_BASE) + 0x20)
-#define VA_IC_BASE		 __io_address(VERSATILE_VIC_BASE) 
-
-/*
- * How long is the timer interval?
- */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >= 0x100000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 8)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV256)
-#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
-#elif TIMER_INTERVAL >= 0x10000
-#define TIMER_RELOAD	(TIMER_INTERVAL >> 4)		/* Divide by 16 */
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV16)
-#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
-#else
-#define TIMER_RELOAD	(TIMER_INTERVAL)
-#define TIMER_DIVISOR	(TIMER_CTRL_DIV1)
-#define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
-#endif
-
-static void timer_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *clk)
-{
-	unsigned long ctrl;
-
-	switch(mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, TIMER0_VA_BASE + TIMER_LOAD);
-
-		ctrl = TIMER_CTRL_PERIODIC;
-		ctrl |= TIMER_CTRL_32BIT | TIMER_CTRL_IE | TIMER_CTRL_ENABLE;
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl = TIMER_CTRL_ONESHOT;
-		ctrl |= TIMER_CTRL_32BIT | TIMER_CTRL_IE;
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		ctrl = 0;
-	}
-
-	writel(ctrl, TIMER0_VA_BASE + TIMER_CTRL);
-}
-
-static int timer_set_next_event(unsigned long evt,
-				struct clock_event_device *unused)
-{
-	unsigned long ctrl = readl(TIMER0_VA_BASE + TIMER_CTRL);
-
-	writel(evt, TIMER0_VA_BASE + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, TIMER0_VA_BASE + TIMER_CTRL);
-
-	return 0;
-}
-
-static struct clock_event_device timer0_clockevent =	 {
-	.name		= "timer0",
-	.shift		= 32,
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= timer_set_mode,
-	.set_next_event	= timer_set_next_event,
-};
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t versatile_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &timer0_clockevent;
-
-	writel(1, TIMER0_VA_BASE + TIMER_INTCLR);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction versatile_timer_irq = {
-	.name		= "Versatile Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= versatile_timer_interrupt,
-};
-
-static cycle_t versatile_get_cycles(struct clocksource *cs)
-{
-	return ~readl(TIMER3_VA_BASE + TIMER_VALUE);
-}
-
-static struct clocksource clocksource_versatile = {
-	.name 		= "timer3",
- 	.rating		= 200,
- 	.read		= versatile_get_cycles,
-	.mask		= CLOCKSOURCE_MASK(32),
- 	.shift 		= 20,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static int __init versatile_clocksource_init(void)
-{
-	/* setup timer3 as free-running clocksource */
-	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
-	writel(0xffffffff, TIMER3_VA_BASE + TIMER_LOAD);
-	writel(0xffffffff, TIMER3_VA_BASE + TIMER_VALUE);
-	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-	       TIMER3_VA_BASE + TIMER_CTRL);
-
- 	clocksource_versatile.mult =
- 		clocksource_khz2mult(1000, clocksource_versatile.shift);
- 	clocksource_register(&clocksource_versatile);
-
- 	return 0;
-}
 
 /*
  * Set up timer interrupt, and return the current time in seconds.
@@ -1019,22 +904,8 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	/* 
-	 * Make irqs happen for the system timer
-	 */
-	setup_irq(IRQ_TIMERINT0_1, &versatile_timer_irq);
-
-	versatile_clocksource_init();
-
-	timer0_clockevent.mult =
-		div_sc(1000000, NSEC_PER_SEC, timer0_clockevent.shift);
-	timer0_clockevent.max_delta_ns =
-		clockevent_delta2ns(0xffffffff, &timer0_clockevent);
-	timer0_clockevent.min_delta_ns =
-		clockevent_delta2ns(0xf, &timer0_clockevent);
-
-	timer0_clockevent.cpumask = cpumask_of(0);
-	clockevents_register_device(&timer0_clockevent);
+	sp804_clocksource_init(TIMER3_VA_BASE);
+	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
 }
 
 struct sys_timer versatile_timer = {
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 2228fd1..334d2f1 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1 +1,2 @@
 obj-y	:= clock.o
+obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
diff --git a/arch/arm/plat-versatile/include/plat/timer-sp.h b/arch/arm/plat-versatile/include/plat/timer-sp.h
new file mode 100644
index 0000000..21e75e3
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/timer-sp.h
@@ -0,0 +1,2 @@
+void sp804_clocksource_init(void __iomem *);
+void sp804_clockevents_init(void __iomem *, unsigned int);
diff --git a/arch/arm/plat-versatile/timer-sp.c b/arch/arm/plat-versatile/timer-sp.c
new file mode 100644
index 0000000..98722f4
--- /dev/null
+++ b/arch/arm/plat-versatile/timer-sp.c
@@ -0,0 +1,168 @@
+/*
+ *  linux/arch/arm/plat-versatile/timer-sp.c
+ *
+ *  Copyright (C) 1999 - 2003 ARM Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <asm/hardware/arm_timer.h>
+
+#include <mach/platform.h>
+
+#include <plat/timer-sp.h>
+
+/*
+ * How long is the timer interval?
+ */
+#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
+#if TIMER_INTERVAL >= 0x100000
+#define TIMER_RELOAD	(TIMER_INTERVAL >> 8)
+#define TIMER_DIVISOR	(TIMER_CTRL_DIV256)
+#elif TIMER_INTERVAL >= 0x10000
+#define TIMER_RELOAD	(TIMER_INTERVAL >> 4)		/* Divide by 16 */
+#define TIMER_DIVISOR	(TIMER_CTRL_DIV16)
+#else
+#define TIMER_RELOAD	(TIMER_INTERVAL)
+#define TIMER_DIVISOR	(TIMER_CTRL_DIV1)
+#endif
+
+
+static void __iomem *clksrc_base;
+
+static cycle_t sp804_read(struct clocksource *cs)
+{
+	return ~readl(clksrc_base + TIMER_VALUE);
+}
+
+static struct clocksource clocksource_sp804 = {
+	.name		= "timer3",
+	.rating		= 200,
+	.read		= sp804_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 20,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init sp804_clocksource_init(void __iomem *base)
+{
+	struct clocksource *cs = &clocksource_sp804;
+
+	clksrc_base = base;
+
+	/* setup timer 0 as free-running clocksource */
+	writel(0, clksrc_base + TIMER_CTRL);
+	writel(0xffffffff, clksrc_base + TIMER_LOAD);
+	writel(0xffffffff, clksrc_base + TIMER_VALUE);
+	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
+		clksrc_base + TIMER_CTRL);
+
+	cs->mult = clocksource_khz2mult(1000, cs->shift);
+	clocksource_register(cs);
+}
+
+
+static void __iomem *clkevt_base;
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/* clear the interrupt */
+	writel(1, clkevt_base + TIMER_INTCLR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void sp804_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt)
+{
+	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE;
+
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
+		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* period set, and timer enabled in 'next_event' hook */
+		ctrl |= TIMER_CTRL_ONESHOT;
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		break;
+	}
+
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+}
+
+static int sp804_set_next_event(unsigned long next,
+	struct clock_event_device *evt)
+{
+	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
+
+	writel(next, clkevt_base + TIMER_LOAD);
+	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+
+	return 0;
+}
+
+static struct clock_event_device sp804_clockevent = {
+	.name		= "timer0",
+	.shift		= 32,
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= sp804_set_mode,
+	.set_next_event	= sp804_set_next_event,
+	.rating		= 300,
+	.cpumask	= cpu_all_mask,
+};
+
+static struct irqaction sp804_timer_irq = {
+	.name		= "timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= sp804_timer_interrupt,
+	.dev_id		= &sp804_clockevent,
+};
+
+void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq)
+{
+	struct clock_event_device *evt = &sp804_clockevent;
+
+	clkevt_base = base;
+
+	evt->irq = timer_irq;
+	evt->mult = div_sc(1000000, NSEC_PER_SEC, evt->shift);
+	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
+	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
+
+	setup_irq(timer_irq, &sp804_timer_irq);
+	clockevents_register_device(evt);
+}
