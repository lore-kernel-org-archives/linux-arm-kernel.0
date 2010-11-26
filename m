From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Nov 2010 14:49:05 +0800
Subject: [PATCH 06/15] ARM: mxs: Add timer support
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1290754154-9428-7-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale MXS-based SoCs implement timer support in block TIMROT.
There are two versions of TIMROT. The v1 on MX23 only gets 16 bits
counter and has no match function. The v2 on MX28 extends the
counter to 32 bits and add the match function.

As the result, we need two instances of timers with v1 for better
implementation, one for next_event and another for get_cycles.
Otherwise, get_cycles may get imprecise result after long time
cumulating. With v2, one instance can serve two purposes well.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/timer.c |  285 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 285 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/timer.c

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
new file mode 100644
index 0000000..c52b465
--- /dev/null
+++ b/arch/arm/mach-mxs/timer.c
@@ -0,0 +1,285 @@
+/*
+ *  Copyright (C) 2000-2001 Deep Blue Solutions
+ *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ *  Copyright (C) 2006-2007 Pavel Pisa (ppisa at pikron.com)
+ *  Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
+ *  Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+
+#include <mach/hardware.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+
+/*
+ * There are 2 versions of the timrot on Freescale MXS-based SoCs.
+ * The v1 on MX23 only gets 16 bits counter and has no match function.
+ * The v2 on MX28 extends the counter to 32 bits and add the match function.
+ *
+ * As the result, we need two instances of timers with v1 for better
+ * implementation, one for next_event and another for get_cycles. Otherwise,
+ * get_cycles may get imprecise result after long time cumulating.
+ * With v2, one instance can serve two purposes well.
+ */
+#define timrot_is_v1()	(cpu_is_mx23())
+
+#define HW_TIMROT_ROTCTRL			0x00
+#define HW_TIMROT_TIMCTRLn(n)			(0x20 + (n) * 0x40)
+#define HW_TIMROT_RUNNING_COUNTn(n)		(0x30 + (n) * 0x40)
+#define HW_TIMROT_MATCH_COUNTn(n)		(0x50 + (n) * 0x40)
+#define BM_TIMROT_TIMCTRLn_RELOAD		(1 << 6)
+#define BM_TIMROT_TIMCTRLn_UPDATE		(1 << 7)
+#define BM_TIMROT_TIMCTRLn_MATCH_MODE		(1 << 11)
+#define BM_TIMROT_TIMCTRLn_IRQ_EN		(1 << 14)
+#define BM_TIMROT_TIMCTRLn_IRQ			(1 << 15)
+#define BP_TIMROT_TIMCTRLn_SELECT		0
+#define BV_TIMROT_TIMCTRLn_SELECT__32KHZ_XTAL	(timrot_is_v1() ? 0x8 : 0xb)
+
+static struct clock_event_device clockevent_mxs;
+static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
+
+static void __iomem *timer_base;
+
+static inline void timrot_irq_disable(void)
+{
+	__raw_writel(BM_TIMROT_TIMCTRLn_IRQ_EN,
+			timer_base + HW_TIMROT_TIMCTRLn(0) + MXS_CLR_ADDR);
+}
+
+static inline void timrot_irq_enable(void)
+{
+	__raw_writel(BM_TIMROT_TIMCTRLn_IRQ_EN,
+			timer_base + HW_TIMROT_TIMCTRLn(0) + MXS_SET_ADDR);
+}
+
+static void timrot_irq_acknowledge(void)
+{
+	__raw_writel(BM_TIMROT_TIMCTRLn_IRQ,
+			timer_base + HW_TIMROT_TIMCTRLn(0) + MXS_CLR_ADDR);
+}
+
+static cycle_t timrot_get_cycles(struct clocksource *cs)
+{
+	if (timrot_is_v1())
+		return ~((__raw_readl(timer_base + HW_TIMROT_RUNNING_COUNTn(1))
+				& 0xffff0000) >> 16);
+	else
+		return ~__raw_readl(timer_base + HW_TIMROT_RUNNING_COUNTn(0));
+}
+
+static int timrot_set_next_event(unsigned long evt,
+					struct clock_event_device *dev)
+{
+	unsigned long match;
+	int ret;
+
+	/* timrot decrements the count */
+	if (timrot_is_v1()) {
+		__raw_writel(evt, timer_base + HW_TIMROT_RUNNING_COUNTn(0));
+		ret = 0;
+	} else {
+		match = __raw_readl(timer_base + HW_TIMROT_MATCH_COUNTn(0))
+				- evt;
+		__raw_writel(match, timer_base + HW_TIMROT_MATCH_COUNTn(0));
+		ret = (int)(match - __raw_readl(timer_base +
+				HW_TIMROT_RUNNING_COUNTn(0))) > 0 ? -ETIME : 0;
+	}
+
+	return ret;
+}
+
+static irqreturn_t mxs_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_mxs;
+
+	timrot_irq_acknowledge();
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction mxs_timer_irq = {
+	.name		= "MXS Timer Tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= mxs_timer_interrupt,
+};
+
+#ifdef DEBUG
+static const char *clock_event_mode_label[] = {
+	[CLOCK_EVT_MODE_PERIODIC] = "CLOCK_EVT_MODE_PERIODIC",
+	[CLOCK_EVT_MODE_ONESHOT]  = "CLOCK_EVT_MODE_ONESHOT",
+	[CLOCK_EVT_MODE_SHUTDOWN] = "CLOCK_EVT_MODE_SHUTDOWN",
+	[CLOCK_EVT_MODE_UNUSED]   = "CLOCK_EVT_MODE_UNUSED"
+};
+#endif /* DEBUG */
+
+static void mxs_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	unsigned long flags;
+
+	/*
+	 * The timer interrupt generation is disabled at least
+	 * for enough time to call mxs_set_next_event()
+	 */
+	local_irq_save(flags);
+
+	/* Disable interrupt in timer module */
+	timrot_irq_disable();
+
+	if (mode != clockevent_mode) {
+		/* Set event time into far-far future */
+		__raw_writel(__raw_readl(timer_base +
+				HW_TIMROT_RUNNING_COUNTn(0)) + 3,
+				timer_base + HW_TIMROT_MATCH_COUNTn(0));
+
+		/* Clear pending interrupt */
+		timrot_irq_acknowledge();
+	}
+
+#ifdef DEBUG
+	printk(KERN_INFO "mxs_set_mode: changing mode from %s to %s\n",
+		clock_event_mode_label[clockevent_mode],
+		clock_event_mode_label[mode]);
+#endif /* DEBUG */
+
+	/* Remember timer mode */
+	clockevent_mode = mode;
+	local_irq_restore(flags);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		printk(KERN_ERR "mxs_set_mode: Periodic mode is not "
+				"supported for MXS-based\n");
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+	/*
+	 * Do not put overhead of interrupt enable/disable into
+	 * mxs_set_next_event(), the core has about 4 minutes
+	 * to call mxs_set_next_event() or shutdown clock after
+	 * mode switching
+	 */
+		local_irq_save(flags);
+		timrot_irq_enable();
+		local_irq_restore(flags);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		/* Left event sources disabled, no more interrupts appear */
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_mxs = {
+	.name		= "mxs_timrot",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.shift		= 32,
+	.set_mode	= mxs_set_mode,
+	.set_next_event	= timrot_set_next_event,
+	.rating		= 200,
+};
+
+static int __init mxs_clockevent_init(struct clk *timer_clk)
+{
+	unsigned int c = clk_get_rate(timer_clk);
+
+	clockevent_mxs.mult = div_sc(c, NSEC_PER_SEC, clockevent_mxs.shift);
+	clockevent_mxs.cpumask = cpumask_of(0);
+	if (timrot_is_v1()) {
+		clockevent_mxs.max_delta_ns =
+			clockevent_delta2ns(0xfffe, &clockevent_mxs);
+		clockevent_mxs.min_delta_ns =
+			clockevent_delta2ns(0xf, &clockevent_mxs);
+	} else {
+		clockevent_mxs.max_delta_ns =
+			clockevent_delta2ns(0xfffffffe, &clockevent_mxs);
+		clockevent_mxs.min_delta_ns =
+			clockevent_delta2ns(0xff, &clockevent_mxs);
+	}
+
+	clockevents_register_device(&clockevent_mxs);
+
+	return 0;
+}
+
+static struct clocksource clocksource_mxs = {
+	.name 		= "mxs_timer",
+	.rating		= 200,
+	.read		= timrot_get_cycles,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift 		= 10,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int __init mxs_clocksource_init(struct clk *timer_clk)
+{
+	unsigned int c = clk_get_rate(timer_clk);
+
+	if (timrot_is_v1())
+		clocksource_mxs.mask = CLOCKSOURCE_MASK(16);
+	clocksource_mxs.mult = clocksource_hz2mult(c, clocksource_mxs.shift);
+	clocksource_register(&clocksource_mxs);
+
+	return 0;
+}
+
+void __init mxs_timer_init(struct clk *timer_clk,
+				void __iomem *base, int irq)
+{
+	clk_enable(timer_clk);
+
+	timer_base = base;
+
+	/*
+	 * Initialize timers to a known state
+	 */
+	mxs_reset_block(base + HW_TIMROT_ROTCTRL);
+
+	if (timrot_is_v1()) {
+		/* timer0 is for next_event */
+		__raw_writel(
+			BV_TIMROT_TIMCTRLn_SELECT__32KHZ_XTAL |
+			BM_TIMROT_TIMCTRLn_UPDATE |
+			BM_TIMROT_TIMCTRLn_IRQ_EN,
+			base + HW_TIMROT_TIMCTRLn(0));
+		/* timer1 is for get_cycles */
+		__raw_writel(
+			BV_TIMROT_TIMCTRLn_SELECT__32KHZ_XTAL |
+			BM_TIMROT_TIMCTRLn_RELOAD,
+			base + HW_TIMROT_TIMCTRLn(1));
+		__raw_writel(0xffff, timer_base  + HW_TIMROT_RUNNING_COUNTn(1));
+
+	} else {
+		__raw_writel(
+			BV_TIMROT_TIMCTRLn_SELECT__32KHZ_XTAL |
+			BM_TIMROT_TIMCTRLn_IRQ_EN |
+			BM_TIMROT_TIMCTRLn_MATCH_MODE,
+			timer_base + HW_TIMROT_TIMCTRLn(0));
+	}
+
+	/* init and register the timer to the framework */
+	mxs_clocksource_init(timer_clk);
+	mxs_clockevent_init(timer_clk);
+
+	/* Make irqs happen */
+	setup_irq(irq, &mxs_timer_irq);
+}
-- 
1.7.1
