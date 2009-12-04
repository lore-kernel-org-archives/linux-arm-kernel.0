From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Dec 2009 09:34:51 +0100
Subject: [RFC][PATCH 03/10] arm: mxc: changes to common plat-mxc code
	to add support for i.MX5
In-Reply-To: <DE2504B3A515524BBE6934369EFDC0DA08C2A56C@az33exm20.fsl.freescale.net>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
	<DE2504B3A515524BBE6934369EFDC0DA08C2A56C@az33exm20.fsl.freescale.net>
Message-ID: <20091204083451.GG15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 08:12:58PM -0700, Herring Robert-RA7055 wrote:
> Amit,
> 
> I would suggest you refactor the timer code into version 1 and version 2
> either as 2 separate files or with a timer_is_v2() function rather than
> the mess of cpu_is_X macros it currently has. Essentially there are 2
> versions of the timer hardware. Version 1 is found on MX1/MXL and MX21.
> Version 2 is found on MX25, MX27, MX31, MX35, MX37, MX51, and future
> parts. I will send you what we have done in our tree.

Like this:


commit ed6bbc59e3f6b33b48a0d5ac053220cd318ceee7
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue Nov 17 16:31:13 2009 +0100

    mxc timer: Add mx51 support
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 844567e..0c45509 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -57,6 +57,9 @@
 #define MX3_TCN			0x24
 #define MX3_TCMP		0x10
 
+#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx27())
+#define timer_is_v2()	(cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51())
+
 static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
@@ -66,7 +69,7 @@ static inline void gpt_irq_disable(void)
 {
 	unsigned int tmp;
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		__raw_writel(0, timer_base + MX3_IR);
 	else {
 		tmp = __raw_readl(timer_base + MXC_TCTL);
@@ -76,7 +79,7 @@ static inline void gpt_irq_disable(void)
 
 static inline void gpt_irq_enable(void)
 {
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		__raw_writel(1<<0, timer_base + MX3_IR);
 	else {
 		__raw_writel(__raw_readl(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
@@ -90,7 +93,7 @@ static void gpt_irq_acknowledge(void)
 		__raw_writel(0, timer_base + MX1_2_TSTAT);
 	if (cpu_is_mx2())
 		__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP, timer_base + MX1_2_TSTAT);
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		__raw_writel(MX3_TSTAT_OF1, timer_base + MX3_TSTAT);
 }
 
@@ -117,7 +120,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		clocksource_mxc.read = mx3_get_cycles;
 
 	clocksource_mxc.mult = clocksource_hz2mult(c,
@@ -180,7 +183,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 
 	if (mode != clockevent_mode) {
 		/* Set event time into far-far future */
-		if (cpu_is_mx3() || cpu_is_mx25())
+		if (timer_is_v2())
 			__raw_writel(__raw_readl(timer_base + MX3_TCN) - 3,
 					timer_base + MX3_TCMP);
 		else
@@ -233,7 +236,7 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = &clockevent_mxc;
 	uint32_t tstat;
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		tstat = __raw_readl(timer_base + MX3_TSTAT);
 	else
 		tstat = __raw_readl(timer_base + MX1_2_TSTAT);
@@ -264,7 +267,7 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		clockevent_mxc.set_next_event = mx3_set_next_event;
 
 	clockevent_mxc.mult = div_sc(c, NSEC_PER_SEC,
@@ -296,7 +299,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 	__raw_writel(0, timer_base + MXC_TCTL);
 	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		tctl_val = MX3_TCTL_CLK_IPG | MX3_TCTL_FRR | MX3_TCTL_WAITEN | MXC_TCTL_TEN;
 	else
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
