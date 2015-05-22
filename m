From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:48 +0800
Subject: [PATCH v2 01/12] ARM: imx: use relaxed IO accessor in timer driver
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the __raw_readl/__raw_writel with readl_relaxed/writel_relaxed
which is endian-safe, as a step of moving the driver code into folder
drivers/clocksource.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index ab5ee1c445f3..376d5d8ccfb8 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -91,19 +91,19 @@ static inline void gpt_irq_disable(void)
 	unsigned int tmp;
 
 	if (timer_is_v2())
-		__raw_writel(0, timer_base + V2_IR);
+		writel_relaxed(0, timer_base + V2_IR);
 	else {
-		tmp = __raw_readl(timer_base + MXC_TCTL);
-		__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, timer_base + MXC_TCTL);
+		tmp = readl_relaxed(timer_base + MXC_TCTL);
+		writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, timer_base + MXC_TCTL);
 	}
 }
 
 static inline void gpt_irq_enable(void)
 {
 	if (timer_is_v2())
-		__raw_writel(1<<0, timer_base + V2_IR);
+		writel_relaxed(1<<0, timer_base + V2_IR);
 	else {
-		__raw_writel(__raw_readl(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
+		writel_relaxed(readl_relaxed(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
 			timer_base + MXC_TCTL);
 	}
 }
@@ -112,26 +112,26 @@ static void gpt_irq_acknowledge(void)
 {
 	if (timer_is_v1()) {
 		if (cpu_is_mx1())
-			__raw_writel(0, timer_base + MX1_2_TSTAT);
+			writel_relaxed(0, timer_base + MX1_2_TSTAT);
 		else
-			__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
+			writel_relaxed(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
 				timer_base + MX1_2_TSTAT);
 	} else if (timer_is_v2())
-		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
+		writel_relaxed(V2_TSTAT_OF1, timer_base + V2_TSTAT);
 }
 
 static void __iomem *sched_clock_reg;
 
 static u64 notrace mxc_read_sched_clock(void)
 {
-	return sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
+	return sched_clock_reg ? readl_relaxed(sched_clock_reg) : 0;
 }
 
 static struct delay_timer imx_delay_timer;
 
 static unsigned long imx_read_current_timer(void)
 {
-	return __raw_readl(sched_clock_reg);
+	return readl_relaxed(sched_clock_reg);
 }
 
 static int __init mxc_clocksource_init(struct clk *timer_clk)
@@ -157,11 +157,11 @@ static int mx1_2_set_next_event(unsigned long evt,
 {
 	unsigned long tcmp;
 
-	tcmp = __raw_readl(timer_base + MX1_2_TCN) + evt;
+	tcmp = readl_relaxed(timer_base + MX1_2_TCN) + evt;
 
-	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
+	writel_relaxed(tcmp, timer_base + MX1_2_TCMP);
 
-	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
+	return (int)(tcmp - readl_relaxed(timer_base + MX1_2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
@@ -170,12 +170,12 @@ static int v2_set_next_event(unsigned long evt,
 {
 	unsigned long tcmp;
 
-	tcmp = __raw_readl(timer_base + V2_TCN) + evt;
+	tcmp = readl_relaxed(timer_base + V2_TCN) + evt;
 
-	__raw_writel(tcmp, timer_base + V2_TCMP);
+	writel_relaxed(tcmp, timer_base + V2_TCMP);
 
 	return evt < 0x7fffffff &&
-		(int)(tcmp - __raw_readl(timer_base + V2_TCN)) < 0 ?
+		(int)(tcmp - readl_relaxed(timer_base + V2_TCN)) < 0 ?
 				-ETIME : 0;
 }
 
@@ -206,10 +206,10 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	if (mode != clockevent_mode) {
 		/* Set event time into far-far future */
 		if (timer_is_v2())
-			__raw_writel(__raw_readl(timer_base + V2_TCN) - 3,
+			writel_relaxed(readl_relaxed(timer_base + V2_TCN) - 3,
 					timer_base + V2_TCMP);
 		else
-			__raw_writel(__raw_readl(timer_base + MX1_2_TCN) - 3,
+			writel_relaxed(readl_relaxed(timer_base + MX1_2_TCN) - 3,
 					timer_base + MX1_2_TCMP);
 
 		/* Clear pending interrupt */
@@ -259,9 +259,9 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	uint32_t tstat;
 
 	if (timer_is_v2())
-		tstat = __raw_readl(timer_base + V2_TSTAT);
+		tstat = readl_relaxed(timer_base + V2_TSTAT);
 	else
-		tstat = __raw_readl(timer_base + MX1_2_TSTAT);
+		tstat = readl_relaxed(timer_base + MX1_2_TSTAT);
 
 	gpt_irq_acknowledge();
 
@@ -316,8 +316,8 @@ static void __init _mxc_timer_init(int irq,
 	 * Initialise to a known state (all timers off, and timing reset)
 	 */
 
-	__raw_writel(0, timer_base + MXC_TCTL);
-	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
+	writel_relaxed(0, timer_base + MXC_TCTL);
+	writel_relaxed(0, timer_base + MXC_TPRER); /* see datasheet note */
 
 	if (timer_is_v2()) {
 		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
@@ -325,7 +325,7 @@ static void __init _mxc_timer_init(int irq,
 			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
 			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
 				/* 24 / 8 = 3 MHz */
-				__raw_writel(7 << V2_TPRER_PRE24M,
+				writel_relaxed(7 << V2_TPRER_PRE24M,
 					timer_base + MXC_TPRER);
 				tctl_val |= V2_TCTL_24MEN;
 			}
@@ -336,7 +336,7 @@ static void __init _mxc_timer_init(int irq,
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 	}
 
-	__raw_writel(tctl_val, timer_base + MXC_TCTL);
+	writel_relaxed(tctl_val, timer_base + MXC_TCTL);
 
 	/* init and register the timer to the framework */
 	mxc_clocksource_init(clk_per);
-- 
1.9.1
