From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:39 +0800
Subject: [PATCH 1/9] ARM: imx: move timer resources into a structure
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Instead of passing around as argument, let's move timer resources like
irq and clocks together with base address into a data structure, and
reference the resources from the struct variable directly to simplify
the function call interface.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 119 ++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index ab5ee1c445f3..8ad7cb2a7f08 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -84,27 +84,34 @@
 static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
-static void __iomem *timer_base;
+struct imx_timer {
+	void __iomem *base;
+	int irq;
+	struct clk *clk_per;
+	struct clk *clk_ipg;
+};
+
+static struct imx_timer imxtm;
 
 static inline void gpt_irq_disable(void)
 {
 	unsigned int tmp;
 
 	if (timer_is_v2())
-		__raw_writel(0, timer_base + V2_IR);
+		__raw_writel(0, imxtm.base + V2_IR);
 	else {
-		tmp = __raw_readl(timer_base + MXC_TCTL);
-		__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, timer_base + MXC_TCTL);
+		tmp = __raw_readl(imxtm.base + MXC_TCTL);
+		__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, imxtm.base + MXC_TCTL);
 	}
 }
 
 static inline void gpt_irq_enable(void)
 {
 	if (timer_is_v2())
-		__raw_writel(1<<0, timer_base + V2_IR);
+		__raw_writel(1<<0, imxtm.base + V2_IR);
 	else {
-		__raw_writel(__raw_readl(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
-			timer_base + MXC_TCTL);
+		__raw_writel(__raw_readl(imxtm.base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
+			imxtm.base + MXC_TCTL);
 	}
 }
 
@@ -112,12 +119,12 @@ static void gpt_irq_acknowledge(void)
 {
 	if (timer_is_v1()) {
 		if (cpu_is_mx1())
-			__raw_writel(0, timer_base + MX1_2_TSTAT);
+			__raw_writel(0, imxtm.base + MX1_2_TSTAT);
 		else
 			__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
-				timer_base + MX1_2_TSTAT);
+				imxtm.base + MX1_2_TSTAT);
 	} else if (timer_is_v2())
-		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
+		__raw_writel(V2_TSTAT_OF1, imxtm.base + V2_TSTAT);
 }
 
 static void __iomem *sched_clock_reg;
@@ -134,10 +141,10 @@ static unsigned long imx_read_current_timer(void)
 	return __raw_readl(sched_clock_reg);
 }
 
-static int __init mxc_clocksource_init(struct clk *timer_clk)
+static int __init mxc_clocksource_init(void)
 {
-	unsigned int c = clk_get_rate(timer_clk);
-	void __iomem *reg = timer_base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
+	unsigned int c = clk_get_rate(imxtm.clk_per);
+	void __iomem *reg = imxtm.base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
 
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
@@ -157,11 +164,11 @@ static int mx1_2_set_next_event(unsigned long evt,
 {
 	unsigned long tcmp;
 
-	tcmp = __raw_readl(timer_base + MX1_2_TCN) + evt;
+	tcmp = __raw_readl(imxtm.base + MX1_2_TCN) + evt;
 
-	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
+	__raw_writel(tcmp, imxtm.base + MX1_2_TCMP);
 
-	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
+	return (int)(tcmp - __raw_readl(imxtm.base + MX1_2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
@@ -170,12 +177,12 @@ static int v2_set_next_event(unsigned long evt,
 {
 	unsigned long tcmp;
 
-	tcmp = __raw_readl(timer_base + V2_TCN) + evt;
+	tcmp = __raw_readl(imxtm.base + V2_TCN) + evt;
 
-	__raw_writel(tcmp, timer_base + V2_TCMP);
+	__raw_writel(tcmp, imxtm.base + V2_TCMP);
 
 	return evt < 0x7fffffff &&
-		(int)(tcmp - __raw_readl(timer_base + V2_TCN)) < 0 ?
+		(int)(tcmp - __raw_readl(imxtm.base + V2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
@@ -206,11 +213,11 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	if (mode != clockevent_mode) {
 		/* Set event time into far-far future */
 		if (timer_is_v2())
-			__raw_writel(__raw_readl(timer_base + V2_TCN) - 3,
-					timer_base + V2_TCMP);
+			__raw_writel(__raw_readl(imxtm.base + V2_TCN) - 3,
+					imxtm.base + V2_TCMP);
 		else
-			__raw_writel(__raw_readl(timer_base + MX1_2_TCN) - 3,
-					timer_base + MX1_2_TCMP);
+			__raw_writel(__raw_readl(imxtm.base + MX1_2_TCN) - 3,
+					imxtm.base + MX1_2_TCMP);
 
 		/* Clear pending interrupt */
 		gpt_irq_acknowledge();
@@ -259,9 +266,9 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	uint32_t tstat;
 
 	if (timer_is_v2())
-		tstat = __raw_readl(timer_base + V2_TSTAT);
+		tstat = __raw_readl(imxtm.base + V2_TSTAT);
 	else
-		tstat = __raw_readl(timer_base + MX1_2_TSTAT);
+		tstat = __raw_readl(imxtm.base + MX1_2_TSTAT);
 
 	gpt_irq_acknowledge();
 
@@ -284,49 +291,48 @@ static struct clock_event_device clockevent_mxc = {
 	.rating		= 200,
 };
 
-static int __init mxc_clockevent_init(struct clk *timer_clk)
+static int __init mxc_clockevent_init(void)
 {
 	if (timer_is_v2())
 		clockevent_mxc.set_next_event = v2_set_next_event;
 
 	clockevent_mxc.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&clockevent_mxc,
-					clk_get_rate(timer_clk),
+					clk_get_rate(imxtm.clk_per),
 					0xff, 0xfffffffe);
 
 	return 0;
 }
 
-static void __init _mxc_timer_init(int irq,
-				   struct clk *clk_per, struct clk *clk_ipg)
+static void __init _mxc_timer_init(void)
 {
 	uint32_t tctl_val;
 
-	if (IS_ERR(clk_per)) {
+	if (IS_ERR(imxtm.clk_per)) {
 		pr_err("i.MX timer: unable to get clk\n");
 		return;
 	}
 
-	if (!IS_ERR(clk_ipg))
-		clk_prepare_enable(clk_ipg);
+	if (!IS_ERR(imxtm.clk_ipg))
+		clk_prepare_enable(imxtm.clk_ipg);
 
-	clk_prepare_enable(clk_per);
+	clk_prepare_enable(imxtm.clk_per);
 
 	/*
 	 * Initialise to a known state (all timers off, and timing reset)
 	 */
 
-	__raw_writel(0, timer_base + MXC_TCTL);
-	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
+	__raw_writel(0, imxtm.base + MXC_TCTL);
+	__raw_writel(0, imxtm.base + MXC_TPRER); /* see datasheet note */
 
 	if (timer_is_v2()) {
 		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-		if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
+		if (clk_get_rate(imxtm.clk_per) == V2_TIMER_RATE_OSC_DIV8) {
 			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
 			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
 				/* 24 / 8 = 3 MHz */
 				__raw_writel(7 << V2_TPRER_PRE24M,
-					timer_base + MXC_TPRER);
+					imxtm.base + MXC_TPRER);
 				tctl_val |= V2_TCTL_24MEN;
 			}
 		} else {
@@ -336,47 +342,44 @@ static void __init _mxc_timer_init(int irq,
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 	}
 
-	__raw_writel(tctl_val, timer_base + MXC_TCTL);
+	__raw_writel(tctl_val, imxtm.base + MXC_TCTL);
 
 	/* init and register the timer to the framework */
-	mxc_clocksource_init(clk_per);
-	mxc_clockevent_init(clk_per);
+	mxc_clocksource_init();
+	mxc_clockevent_init();
 
 	/* Make irqs happen */
-	setup_irq(irq, &mxc_timer_irq);
+	setup_irq(imxtm.irq, &mxc_timer_irq);
 }
 
 void __init mxc_timer_init(unsigned long pbase, int irq)
 {
-	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
-	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
+	imxtm.clk_per = clk_get_sys("imx-gpt.0", "per");
+	imxtm.clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
 
-	timer_base = ioremap(pbase, SZ_4K);
-	BUG_ON(!timer_base);
+	imxtm.base = ioremap(pbase, SZ_4K);
+	BUG_ON(!imxtm.base);
 
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+	_mxc_timer_init();
 }
 
 static void __init mxc_timer_init_dt(struct device_node *np)
 {
-	struct clk *clk_per, *clk_ipg;
-	int irq;
-
-	if (timer_base)
+	if (imxtm.base)
 		return;
 
-	timer_base = of_iomap(np, 0);
-	WARN_ON(!timer_base);
-	irq = irq_of_parse_and_map(np, 0);
+	imxtm.base = of_iomap(np, 0);
+	WARN_ON(!imxtm.base);
+	imxtm.irq = irq_of_parse_and_map(np, 0);
 
-	clk_ipg = of_clk_get_by_name(np, "ipg");
+	imxtm.clk_ipg = of_clk_get_by_name(np, "ipg");
 
 	/* Try osc_per first, and fall back to per otherwise */
-	clk_per = of_clk_get_by_name(np, "osc_per");
-	if (IS_ERR(clk_per))
-		clk_per = of_clk_get_by_name(np, "per");
+	imxtm.clk_per = of_clk_get_by_name(np, "osc_per");
+	if (IS_ERR(imxtm.clk_per))
+		imxtm.clk_per = of_clk_get_by_name(np, "per");
 
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+	_mxc_timer_init();
 }
 CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt", mxc_timer_init_dt);
-- 
1.9.1
