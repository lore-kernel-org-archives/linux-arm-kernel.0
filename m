From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:49 +0800
Subject: [PATCH v2 02/12] ARM: imx: move timer resources into a structure
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of passing around as individual argument, let's move timer
resources like irq and clocks together with base address into a data
structure, and pass pointer of the structure as argument to simplify
the function call interface.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 91 +++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 376d5d8ccfb8..7c131e1b2637 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/sched_clock.h>
+#include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -84,6 +85,13 @@
 static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
+struct imx_timer {
+	void __iomem *base;
+	int irq;
+	struct clk *clk_per;
+	struct clk *clk_ipg;
+};
+
 static void __iomem *timer_base;
 
 static inline void gpt_irq_disable(void)
@@ -134,10 +142,10 @@ static unsigned long imx_read_current_timer(void)
 	return readl_relaxed(sched_clock_reg);
 }
 
-static int __init mxc_clocksource_init(struct clk *timer_clk)
+static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 {
-	unsigned int c = clk_get_rate(timer_clk);
-	void __iomem *reg = timer_base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
+	unsigned int c = clk_get_rate(imxtm->clk_per);
+	void __iomem *reg = imxtm->base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
 
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
@@ -284,49 +292,51 @@ static struct clock_event_device clockevent_mxc = {
 	.rating		= 200,
 };
 
-static int __init mxc_clockevent_init(struct clk *timer_clk)
+static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 {
 	if (timer_is_v2())
 		clockevent_mxc.set_next_event = v2_set_next_event;
 
 	clockevent_mxc.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&clockevent_mxc,
-					clk_get_rate(timer_clk),
+					clk_get_rate(imxtm->clk_per),
 					0xff, 0xfffffffe);
 
 	return 0;
 }
 
-static void __init _mxc_timer_init(int irq,
-				   struct clk *clk_per, struct clk *clk_ipg)
+static void __init _mxc_timer_init(struct imx_timer *imxtm)
 {
 	uint32_t tctl_val;
 
-	if (IS_ERR(clk_per)) {
+	/* Temporary */
+	timer_base = imxtm->base;
+
+	if (IS_ERR(imxtm->clk_per)) {
 		pr_err("i.MX timer: unable to get clk\n");
 		return;
 	}
 
-	if (!IS_ERR(clk_ipg))
-		clk_prepare_enable(clk_ipg);
+	if (!IS_ERR(imxtm->clk_ipg))
+		clk_prepare_enable(imxtm->clk_ipg);
 
-	clk_prepare_enable(clk_per);
+	clk_prepare_enable(imxtm->clk_per);
 
 	/*
 	 * Initialise to a known state (all timers off, and timing reset)
 	 */
 
-	writel_relaxed(0, timer_base + MXC_TCTL);
-	writel_relaxed(0, timer_base + MXC_TPRER); /* see datasheet note */
+	writel_relaxed(0, imxtm->base + MXC_TCTL);
+	writel_relaxed(0, imxtm->base + MXC_TPRER); /* see datasheet note */
 
 	if (timer_is_v2()) {
 		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-		if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
+		if (clk_get_rate(imxtm->clk_per) == V2_TIMER_RATE_OSC_DIV8) {
 			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
 			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
 				/* 24 / 8 = 3 MHz */
 				writel_relaxed(7 << V2_TPRER_PRE24M,
-					timer_base + MXC_TPRER);
+					imxtm->base + MXC_TPRER);
 				tctl_val |= V2_TCTL_24MEN;
 			}
 		} else {
@@ -336,47 +346,58 @@ static void __init _mxc_timer_init(int irq,
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 	}
 
-	writel_relaxed(tctl_val, timer_base + MXC_TCTL);
+	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
 
 	/* init and register the timer to the framework */
-	mxc_clocksource_init(clk_per);
-	mxc_clockevent_init(clk_per);
+	mxc_clocksource_init(imxtm);
+	mxc_clockevent_init(imxtm);
 
 	/* Make irqs happen */
-	setup_irq(irq, &mxc_timer_irq);
+	setup_irq(imxtm->irq, &mxc_timer_irq);
 }
 
 void __init mxc_timer_init(unsigned long pbase, int irq)
 {
-	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
-	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
+	struct imx_timer *imxtm;
+
+	imxtm = kzalloc(sizeof(*imxtm), GFP_KERNEL);
+	BUG_ON(!imxtm);
 
-	timer_base = ioremap(pbase, SZ_4K);
-	BUG_ON(!timer_base);
+	imxtm->clk_per = clk_get_sys("imx-gpt.0", "per");
+	imxtm->clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
 
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+	imxtm->base = ioremap(pbase, SZ_4K);
+	BUG_ON(!imxtm->base);
+
+	_mxc_timer_init(imxtm);
 }
 
 static void __init mxc_timer_init_dt(struct device_node *np)
 {
-	struct clk *clk_per, *clk_ipg;
-	int irq;
+	struct imx_timer *imxtm;
+	static int initialized;
 
-	if (timer_base)
+	/* Support one instance only */
+	if (initialized)
 		return;
 
-	timer_base = of_iomap(np, 0);
-	WARN_ON(!timer_base);
-	irq = irq_of_parse_and_map(np, 0);
+	imxtm = kzalloc(sizeof(*imxtm), GFP_KERNEL);
+	BUG_ON(!imxtm);
 
-	clk_ipg = of_clk_get_by_name(np, "ipg");
+	imxtm->base = of_iomap(np, 0);
+	WARN_ON(!imxtm->base);
+	imxtm->irq = irq_of_parse_and_map(np, 0);
+
+	imxtm->clk_ipg = of_clk_get_by_name(np, "ipg");
 
 	/* Try osc_per first, and fall back to per otherwise */
-	clk_per = of_clk_get_by_name(np, "osc_per");
-	if (IS_ERR(clk_per))
-		clk_per = of_clk_get_by_name(np, "per");
+	imxtm->clk_per = of_clk_get_by_name(np, "osc_per");
+	if (IS_ERR(imxtm->clk_per))
+		imxtm->clk_per = of_clk_get_by_name(np, "per");
+
+	_mxc_timer_init(imxtm);
 
-	_mxc_timer_init(irq, clk_per, clk_ipg);
+	initialized = 1;
 }
 CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt", mxc_timer_init_dt);
-- 
1.9.1
