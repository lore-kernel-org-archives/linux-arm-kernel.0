From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Nov 2010 22:36:28 +0800
Subject: [PATCH 04/11] ARM: imx: Add timer support for i.MX28
In-Reply-To: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1289831795-4373-5-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC i.MX28 implements the timer in block TIMROT. It adds the
support in the same file with GPT, and uses timer_is_timrot()
to distinguish the IP block.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/plat-mxc/time.c |  120 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index f9a1b05..3e1f09d 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
  *  Copyright (C) 2006-2007 Pavel Pisa (ppisa at pikron.com)
  *  Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
+ *  Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -63,8 +64,22 @@
 #define V2_TCN			0x24
 #define V2_TCMP			0x10
 
-#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
-#define timer_is_v2()	(!timer_is_v1())
+/* TIMROT */
+#define HW_TIMROT_ROTCTRL			0x00
+#define HW_TIMROT_TIMCTRL0			0x20
+#define HW_TIMROT_TIMCTRL0_SET			0x24
+#define HW_TIMROT_TIMCTRL0_CLR			0x28
+#define HW_TIMROT_RUNNING_COUNT0		0x30
+#define HW_TIMROT_MATCH_COUNT0			0x50
+#define BM_TIMROT_TIMCTRL0_IRQ_EN		0x00004000
+#define BM_TIMROT_TIMCTRL0_IRQ			0x00008000
+#define BM_TIMROT_TIMCTRL0_MATCH_MODE		0x00000800
+#define BP_TIMROT_TIMCTRL0_SELECT		0
+#define BV_TIMROT_TIMCTRLn_SELECT__32KHZ_XTAL	0xb
+
+#define timer_is_v1()		(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
+#define timer_is_v2()		(!timer_is_v1())
+#define timer_is_timrot()	(cpu_is_mx28())
 
 static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
@@ -105,6 +120,24 @@ static void gpt_irq_acknowledge(void)
 		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
 }
 
+static inline void timrot_irq_disable(void)
+{
+	__raw_writel(BM_TIMROT_TIMCTRL0_IRQ_EN,
+			timer_base + HW_TIMROT_TIMCTRL0_CLR);
+}
+
+static inline void timrot_irq_enable(void)
+{
+	__raw_writel(BM_TIMROT_TIMCTRL0_IRQ_EN,
+			timer_base + HW_TIMROT_TIMCTRL0_SET);
+}
+
+static void timrot_irq_acknowledge(void)
+{
+	__raw_writel(BM_TIMROT_TIMCTRL0_IRQ,
+			timer_base + HW_TIMROT_TIMCTRL0_CLR);
+}
+
 static cycle_t mx1_2_get_cycles(struct clocksource *cs)
 {
 	return __raw_readl(timer_base + MX1_2_TCN);
@@ -115,6 +148,11 @@ static cycle_t v2_get_cycles(struct clocksource *cs)
 	return __raw_readl(timer_base + V2_TCN);
 }
 
+static cycle_t timrot_get_cycles(struct clocksource *cs)
+{
+	return ~__raw_readl(timer_base + HW_TIMROT_RUNNING_COUNT0);
+}
+
 static struct clocksource clocksource_mxc = {
 	.name 		= "mxc_timer1",
 	.rating		= 200,
@@ -128,8 +166,12 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	if (timer_is_v2())
+	if (timer_is_timrot()) {
+		clocksource_mxc.read = timrot_get_cycles;
+		clocksource_mxc.shift = 10;
+	} else if (timer_is_v2()) {
 		clocksource_mxc.read = v2_get_cycles;
+	}
 
 	clocksource_mxc.mult = clocksource_hz2mult(c,
 					clocksource_mxc.shift);
@@ -166,6 +208,18 @@ static int v2_set_next_event(unsigned long evt,
 				-ETIME : 0;
 }
 
+static int timrot_set_next_event(unsigned long evt,
+					struct clock_event_device *dev)
+{
+	unsigned long match;
+
+	match = __raw_readl(timer_base + HW_TIMROT_MATCH_COUNT0) - evt;
+	__raw_writel(match, timer_base + HW_TIMROT_MATCH_COUNT0);
+
+	return (int)(match - __raw_readl(timer_base +
+			HW_TIMROT_RUNNING_COUNT0)) > 0 ? -ETIME : 0;
+}
+
 #ifdef DEBUG
 static const char *clock_event_mode_label[] = {
 	[CLOCK_EVT_MODE_PERIODIC] = "CLOCK_EVT_MODE_PERIODIC",
@@ -186,12 +240,19 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	 */
 	local_irq_save(flags);
 
-	/* Disable interrupt in GPT module */
-	gpt_irq_disable();
+	/* Disable interrupt in timer module */
+	if (timer_is_timrot())
+		timrot_irq_disable();
+	else
+		gpt_irq_disable();
 
 	if (mode != clockevent_mode) {
 		/* Set event time into far-far future */
-		if (timer_is_v2())
+		if (timer_is_timrot())
+			__raw_writel(__raw_readl(timer_base +
+					HW_TIMROT_RUNNING_COUNT0) + 3,
+					timer_base + HW_TIMROT_MATCH_COUNT0);
+		else if (timer_is_v2())
 			__raw_writel(__raw_readl(timer_base + V2_TCN) - 3,
 					timer_base + V2_TCMP);
 		else
@@ -199,7 +260,10 @@ static void mxc_set_mode(enum clock_event_mode mode,
 					timer_base + MX1_2_TCMP);
 
 		/* Clear pending interrupt */
-		gpt_irq_acknowledge();
+		if (timer_is_timrot())
+			timrot_irq_acknowledge();
+		else
+			gpt_irq_acknowledge();
 	}
 
 #ifdef DEBUG
@@ -225,7 +289,10 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	 * mode switching
 	 */
 		local_irq_save(flags);
-		gpt_irq_enable();
+		if (timer_is_timrot())
+			timrot_irq_enable();
+		else
+			gpt_irq_enable();
 		local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
@@ -249,7 +316,10 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	else
 		tstat = __raw_readl(timer_base + MX1_2_TSTAT);
 
-	gpt_irq_acknowledge();
+	if (timer_is_timrot())
+		timrot_irq_acknowledge();
+	else
+		gpt_irq_acknowledge();
 
 	evt->event_handler(evt);
 
@@ -275,7 +345,9 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	if (timer_is_v2())
+	if (timer_is_timrot())
+		clockevent_mxc.set_next_event = timrot_set_next_event;
+	else if (timer_is_v2())
 		clockevent_mxc.set_next_event = v2_set_next_event;
 
 	clockevent_mxc.mult = div_sc(c, NSEC_PER_SEC,
@@ -303,16 +375,24 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 	/*
 	 * Initialise to a known state (all timers off, and timing reset)
 	 */
-
-	__raw_writel(0, timer_base + MXC_TCTL);
-	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
-
-	if (timer_is_v2())
-		tctl_val = V2_TCTL_CLK_IPG | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-	else
-		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
-
-	__raw_writel(tctl_val, timer_base + MXC_TCTL);
+	if (timer_is_timrot()) {
+		mxc_reset_block(base + HW_TIMROT_ROTCTRL);
+		__raw_writel(
+			BV_TIMROT_TIMCTRLn_SELECT__32KHZ_XTAL |
+			BM_TIMROT_TIMCTRL0_IRQ_EN |
+			BM_TIMROT_TIMCTRL0_MATCH_MODE,
+			timer_base + HW_TIMROT_TIMCTRL0); /* timer0*/
+	} else {
+		__raw_writel(0, timer_base + MXC_TCTL);
+		__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
+		if (timer_is_v2())
+			tctl_val = V2_TCTL_CLK_IPG | V2_TCTL_FRR |
+					V2_TCTL_WAITEN | MXC_TCTL_TEN;
+		else
+			tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 |
+					MXC_TCTL_TEN;
+		__raw_writel(tctl_val, timer_base + MXC_TCTL);
+	}
 
 	/* init and register the timer to the framework */
 	mxc_clocksource_init(timer_clk);
-- 
1.7.1
