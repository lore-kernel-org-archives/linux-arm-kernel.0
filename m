From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Sep 2010 17:49:10 -0500
Subject: [PATCH 1/3] ARM: move timer-sp.c from versatile to common
Message-ID: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@smooth-stone.com>

The timer-sp h/w used on versatile platforms can also be used for other
platforms, so move it to a common location.

Rename timer names for clocksource and clockevent to generic name.
Which timer instance is which is platform dependent.

Signed-off-by: Rob Herring <rob.herring@smooth-stone.com>
---
 arch/arm/common/Makefile                        |    1 +
 arch/arm/common/timer-sp.c                      |  154 ++++++++++++++++++++++
 arch/arm/include/asm/hardware/timer-sp.h        |    2 +
 arch/arm/mach-integrator/integrator_cp.c        |    2 +-
 arch/arm/mach-realview/core.c                   |    2 +-
 arch/arm/mach-versatile/core.c                  |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c               |    2 +-
 arch/arm/mach-vexpress/v2m.c                    |    2 +-
 arch/arm/plat-versatile/Makefile                |    1 -
 arch/arm/plat-versatile/include/plat/timer-sp.h |    2 -
 arch/arm/plat-versatile/timer-sp.c              |  156 -----------------------
 11 files changed, 162 insertions(+), 164 deletions(-)
 create mode 100644 arch/arm/common/timer-sp.c
 create mode 100644 arch/arm/include/asm/hardware/timer-sp.h
 delete mode 100644 arch/arm/plat-versatile/include/plat/timer-sp.h
 delete mode 100644 arch/arm/plat-versatile/timer-sp.c

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e6e8664..e7521bc 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
+obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
new file mode 100644
index 0000000..b552358
--- /dev/null
+++ b/arch/arm/common/timer-sp.c
@@ -0,0 +1,154 @@
+/*
+ *  linux/arch/arm/common/timer-sp.c
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
+/*
+ * These timers are currently always setup to be clocked at 1MHz.
+ */
+#define TIMER_FREQ_KHZ	(1000)
+#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
+
+static void __iomem *clksrc_base;
+
+static cycle_t sp804_read(struct clocksource *cs)
+{
+	return ~readl(clksrc_base + TIMER_VALUE);
+}
+
+static struct clocksource clocksource_sp804 = {
+	.name		= "timer-sp",
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
+	cs->mult = clocksource_khz2mult(TIMER_FREQ_KHZ, cs->shift);
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
+	.name		= "timer-sp",
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
+	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
+	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
+	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
+
+	setup_irq(timer_irq, &sp804_timer_irq);
+	clockevents_register_device(evt);
+}
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
new file mode 100644
index 0000000..21e75e3
--- /dev/null
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -0,0 +1,2 @@
+void sp804_clocksource_init(void __iomem *);
+void sp804_clockevents_init(void __iomem *, unsigned int);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 05db40e..6c432a0 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -41,7 +41,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 2fa38df..121c6d6 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -50,7 +50,7 @@
 #include <mach/clkdev.h>
 #include <mach/platform.h>
 #include <mach/irqs.h>
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "core.h"
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..6b93bd6 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -49,7 +49,7 @@
 #include <mach/clkdev.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "core.h"
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index efb1270..685e6ee 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -21,7 +21,7 @@
 #include <mach/clkdev.h>
 #include <mach/ct-ca9x4.h>
 
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 817f0ad..5bc853d 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -22,7 +22,7 @@
 #include <mach/clkdev.h>
 #include <mach/motherboard.h>
 
-#include <plat/timer-sp.h>
+#include <asm/hardware/timer-sp.h>
 
 #include "core.h"
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 5cf88e8..aaa571d 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,5 +1,4 @@
 obj-y	:= clock.o
-obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
 obj-$(CONFIG_ARCH_REALVIEW) += sched-clock.o
 obj-$(CONFIG_ARCH_VERSATILE) += sched-clock.o
 ifeq ($(CONFIG_LEDS_CLASS),y)
diff --git a/arch/arm/plat-versatile/include/plat/timer-sp.h b/arch/arm/plat-versatile/include/plat/timer-sp.h
deleted file mode 100644
index 21e75e3..0000000
--- a/arch/arm/plat-versatile/include/plat/timer-sp.h
+++ /dev/null
@@ -1,2 +0,0 @@
-void sp804_clocksource_init(void __iomem *);
-void sp804_clockevents_init(void __iomem *, unsigned int);
diff --git a/arch/arm/plat-versatile/timer-sp.c b/arch/arm/plat-versatile/timer-sp.c
deleted file mode 100644
index fb0d1c2..0000000
--- a/arch/arm/plat-versatile/timer-sp.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- *  linux/arch/arm/plat-versatile/timer-sp.c
- *
- *  Copyright (C) 1999 - 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-
-#include <asm/hardware/arm_timer.h>
-
-#include <plat/timer-sp.h>
-
-/*
- * These timers are currently always setup to be clocked at 1MHz.
- */
-#define TIMER_FREQ_KHZ	(1000)
-#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
-
-static void __iomem *clksrc_base;
-
-static cycle_t sp804_read(struct clocksource *cs)
-{
-	return ~readl(clksrc_base + TIMER_VALUE);
-}
-
-static struct clocksource clocksource_sp804 = {
-	.name		= "timer3",
-	.rating		= 200,
-	.read		= sp804_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 20,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-void __init sp804_clocksource_init(void __iomem *base)
-{
-	struct clocksource *cs = &clocksource_sp804;
-
-	clksrc_base = base;
-
-	/* setup timer 0 as free-running clocksource */
-	writel(0, clksrc_base + TIMER_CTRL);
-	writel(0xffffffff, clksrc_base + TIMER_LOAD);
-	writel(0xffffffff, clksrc_base + TIMER_VALUE);
-	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		clksrc_base + TIMER_CTRL);
-
-	cs->mult = clocksource_khz2mult(TIMER_FREQ_KHZ, cs->shift);
-	clocksource_register(cs);
-}
-
-
-static void __iomem *clkevt_base;
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static void sp804_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt)
-{
-	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE;
-
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
-		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl |= TIMER_CTRL_ONESHOT;
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		break;
-	}
-
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-}
-
-static int sp804_set_next_event(unsigned long next,
-	struct clock_event_device *evt)
-{
-	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
-
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
-
-	return 0;
-}
-
-static struct clock_event_device sp804_clockevent = {
-	.name		= "timer0",
-	.shift		= 32,
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= sp804_set_mode,
-	.set_next_event	= sp804_set_next_event,
-	.rating		= 300,
-	.cpumask	= cpu_all_mask,
-};
-
-static struct irqaction sp804_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= sp804_timer_interrupt,
-	.dev_id		= &sp804_clockevent,
-};
-
-void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq)
-{
-	struct clock_event_device *evt = &sp804_clockevent;
-
-	clkevt_base = base;
-
-	evt->irq = timer_irq;
-	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
-	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
-	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
-
-	setup_irq(timer_irq, &sp804_timer_irq);
-	clockevents_register_device(evt);
-}
-- 
1.7.0.4
