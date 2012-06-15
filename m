From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Fri, 15 Jun 2012 09:44:02 +0200
Subject: [PATCH v3 1/9] clocksource: time-armada-370-xp: Marvell Armada 370/XP
 SoC timer driver
In-Reply-To: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1339746250-26650-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timer 0 is used as free-running clocksource, while timer 1 is used as
clock_event_device.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 drivers/clocksource/Kconfig              |    3 +
 drivers/clocksource/Makefile             |    3 +-
 drivers/clocksource/time-armada-370-xp.c |  242 ++++++++++++++++++++++++++++++
 include/linux/time-armada-370-xp.h       |   18 +++
 4 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clocksource/time-armada-370-xp.c
 create mode 100644 include/linux/time-armada-370-xp.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 99c6b20..b323631 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -16,6 +16,9 @@ config CLKSRC_MMIO
 config DW_APB_TIMER
 	bool
 
+config ARMADA_370_XP_TIMER
+	bool
+
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer"
 	depends on UX500_SOC_DB8500
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 8d81a1d..ef6cf32 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
-obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
\ No newline at end of file
+obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
+obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
new file mode 100644
index 0000000..c6bdba4
--- /dev/null
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -0,0 +1,242 @@
+/*
+ * Marvell Armada 370/XP SoC timer handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Timer 0 is used as free-running clocksource, while timer 1 is
+ * used as clock_event_device.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <asm/sched_clock.h>
+
+/*
+ * Timer block registers.
+ */
+#define TIMER_CTRL_OFF		0x0000
+#define  TIMER0_EN		 0x0001
+#define  TIMER0_RELOAD_EN	 0x0002
+#define  TIMER0_25MHZ            0x0800
+#define  TIMER0_DIV(div)         ((div) << 19)
+#define  TIMER1_EN		 0x0004
+#define  TIMER1_RELOAD_EN	 0x0008
+#define  TIMER1_25MHZ            0x1000
+#define  TIMER1_DIV(div)         ((div) << 22)
+#define TIMER_EVENTS_STATUS	0x0004
+#define  TIMER0_CLR_MASK         (~0x1)
+#define  TIMER1_CLR_MASK         (~0x100)
+#define TIMER0_RELOAD_OFF	0x0010
+#define TIMER0_VAL_OFF		0x0014
+#define TIMER1_RELOAD_OFF	0x0018
+#define TIMER1_VAL_OFF		0x001c
+
+/* Global timers are connected to the coherency fabric clock, and the
+   below divider reduces their incrementing frequency. */
+#define TIMER_DIVIDER_SHIFT     5
+#define TIMER_DIVIDER           (1 << TIMER_DIVIDER_SHIFT)
+
+/*
+ * SoC-specific data.
+ */
+static void __iomem *timer_base;
+static int timer_irq;
+
+/*
+ * Number of timer ticks per jiffy.
+ */
+static u32 ticks_per_jiffy;
+
+static u32 notrace armada_370_xp_read_sched_clock(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+/*
+ * Clockevent handling.
+ */
+static int
+armada_370_xp_clkevt_next_event(unsigned long delta,
+				struct clock_event_device *dev)
+{
+	unsigned long flags;
+	u32 u;
+
+	if (delta == 0)
+		return -ETIME;
+
+	local_irq_save(flags);
+
+	/*
+	 * Clear clockevent timer interrupt.
+	 */
+	writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+
+	/*
+	 * Setup new clockevent timer value.
+	 */
+	writel(delta, timer_base + TIMER1_VAL_OFF);
+
+	/*
+	 * Enable the timer.
+	 */
+	u = readl(timer_base + TIMER_CTRL_OFF);
+	u = ((u & ~TIMER1_RELOAD_EN) | TIMER1_EN |
+	     TIMER1_DIV(TIMER_DIVIDER_SHIFT));
+	writel(u, timer_base + TIMER_CTRL_OFF);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static void
+armada_370_xp_clkevt_mode(enum clock_event_mode mode,
+			  struct clock_event_device *dev)
+{
+	unsigned long flags;
+	u32 u;
+
+	local_irq_save(flags);
+	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+		/*
+		 * Setup timer to fire at 1/HZ intervals.
+		 */
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
+
+		/*
+		 * Enable timer.
+		 */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+
+		writel((u | TIMER1_EN | TIMER1_RELOAD_EN |
+			TIMER1_DIV(TIMER_DIVIDER_SHIFT)),
+		       timer_base + TIMER_CTRL_OFF);
+	} else {
+		/*
+		 * Disable timer.
+		 */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
+
+		/*
+		 * ACK pending timer interrupt.
+		 */
+		writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+
+	}
+	local_irq_restore(flags);
+}
+
+static struct clock_event_device armada_370_xp_clkevt = {
+	.name		= "armada_370_xp_tick",
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	.shift		= 32,
+	.rating		= 300,
+	.set_next_event	= armada_370_xp_clkevt_next_event,
+	.set_mode	= armada_370_xp_clkevt_mode,
+};
+
+static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * ACK timer interrupt and call event handler.
+	 */
+
+	writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+	armada_370_xp_clkevt.event_handler(&armada_370_xp_clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction armada_370_xp_timer_irq = {
+	.name		= "armada_370_xp_tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= armada_370_xp_timer_interrupt
+};
+
+void __init armada_370_xp_timer_init(void)
+{
+	u32 u;
+	struct device_node *np;
+	unsigned int timer_clk;
+	int ret;
+	np = of_find_compatible_node(NULL, NULL, "marvell,timer");
+	timer_base = of_iomap(np, 0);
+	WARN_ON(!timer_base);
+
+	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
+		/* The fixed 25MHz timer is available so let's use it */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u | TIMER0_25MHZ | TIMER1_25MHZ,
+		       timer_base + TIMER_CTRL_OFF);
+		timer_clk = 25000000;
+	} else {
+		u32 clk = 0;
+		ret = of_property_read_u32(np, "clock-frequency", &clk);
+		WARN_ON(!clk || ret < 0);
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u & ~(TIMER0_25MHZ | TIMER1_25MHZ),
+		       timer_base + TIMER_CTRL_OFF);
+		timer_clk = clk / TIMER_DIVIDER;
+	}
+
+	/* We use timer 0 as clocksource, and timer 1 for
+	   clockevents */
+	timer_irq = irq_of_parse_and_map(np, 1);
+
+	ticks_per_jiffy = (timer_clk + HZ / 2) / HZ;
+
+	/*
+	 * Set scale and timer for sched_clock.
+	 */
+	setup_sched_clock(armada_370_xp_read_sched_clock, 32, timer_clk);
+
+	/*
+	 * Setup free-running clocksource timer (interrupts
+	 * disabled).
+	 */
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+
+	u = readl(timer_base + TIMER_CTRL_OFF);
+
+	writel((u | TIMER0_EN | TIMER0_RELOAD_EN |
+		TIMER0_DIV(TIMER_DIVIDER_SHIFT)), timer_base + TIMER_CTRL_OFF);
+
+	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
+			      "armada_370_xp_clocksource",
+			      timer_clk, 300, 32, clocksource_mmio_readl_down);
+
+	/*
+	 * Setup clockevent timer (interrupt-driven).
+	 */
+	setup_irq(timer_irq, &armada_370_xp_timer_irq);
+	armada_370_xp_clkevt.mult = div_sc(timer_clk, NSEC_PER_SEC,
+					   armada_370_xp_clkevt.shift);
+	armada_370_xp_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe,
+							&armada_370_xp_clkevt);
+	armada_370_xp_clkevt.min_delta_ns =
+	    clockevent_delta2ns(1, &armada_370_xp_clkevt);
+	armada_370_xp_clkevt.cpumask = cpumask_of(0);
+	clockevents_register_device(&armada_370_xp_clkevt);
+}
+
diff --git a/include/linux/time-armada-370-xp.h b/include/linux/time-armada-370-xp.h
new file mode 100644
index 0000000..dfdfdc0
--- /dev/null
+++ b/include/linux/time-armada-370-xp.h
@@ -0,0 +1,18 @@
+/*
+ * Marvell Armada 370/XP SoC timer handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ */
+#ifndef __TIME_ARMADA_370_XPPRCMU_H
+#define __TIME_ARMADA_370_XPPRCMU_H
+
+#include <linux/init.h>
+
+void __init armada_370_xp_timer_init(void);
+
+#endif
-- 
1.7.9.5
