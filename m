From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  8 Aug 2013 08:32:28 -0300
Subject: [PATCH v2 2/6] clocksource: armada-370-xp: Simplify TIMER_CTRL
 register access
In-Reply-To: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1375961552-12967-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit creates two functions to access the TIMER_CTRL register:
one for global one for the per-cpu. This makes the code much more
readable. In addition, since the TIMER_CTRL register is also used for
watchdog, this is preparation work for future thread-safe improvements.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 62 +++++++++++++++-----------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index ed584ec..bbb727c 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -72,6 +72,18 @@ static u32 ticks_per_jiffy;
 
 static struct clock_event_device __percpu *armada_370_xp_evt;
 
+static void timer_ctrl_clrset(u32 clr, u32 set)
+{
+       writel((readl(timer_base + TIMER_CTRL_OFF) & ~clr) | set,
+               timer_base + TIMER_CTRL_OFF);
+}
+
+static void local_timer_ctrl_clrset(u32 clr, u32 set)
+{
+       writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
+               local_base + TIMER_CTRL_OFF);
+}
+
 static u32 notrace armada_370_xp_read_sched_clock(void)
 {
 	return ~readl(timer_base + TIMER0_VAL_OFF);
@@ -84,7 +96,6 @@ static int
 armada_370_xp_clkevt_next_event(unsigned long delta,
 				struct clock_event_device *dev)
 {
-	u32 u;
 	/*
 	 * Clear clockevent timer interrupt.
 	 */
@@ -98,11 +109,8 @@ armada_370_xp_clkevt_next_event(unsigned long delta,
 	/*
 	 * Enable the timer.
 	 */
-	u = readl(local_base + TIMER_CTRL_OFF);
-	u = ((u & ~TIMER0_RELOAD_EN) | TIMER0_EN |
-	     TIMER0_DIV(TIMER_DIVIDER_SHIFT));
-	writel(u, local_base + TIMER_CTRL_OFF);
-
+	local_timer_ctrl_clrset(TIMER0_RELOAD_EN,
+				TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT));
 	return 0;
 }
 
@@ -110,8 +118,6 @@ static void
 armada_370_xp_clkevt_mode(enum clock_event_mode mode,
 			  struct clock_event_device *dev)
 {
-	u32 u;
-
 	if (mode == CLOCK_EVT_MODE_PERIODIC) {
 
 		/*
@@ -123,18 +129,14 @@ armada_370_xp_clkevt_mode(enum clock_event_mode mode,
 		/*
 		 * Enable timer.
 		 */
-
-		u = readl(local_base + TIMER_CTRL_OFF);
-
-		writel((u | TIMER0_EN | TIMER0_RELOAD_EN |
-			TIMER0_DIV(TIMER_DIVIDER_SHIFT)),
-			local_base + TIMER_CTRL_OFF);
+		local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN |
+					   TIMER0_EN |
+					   TIMER0_DIV(TIMER_DIVIDER_SHIFT));
 	} else {
 		/*
 		 * Disable timer.
 		 */
-		u = readl(local_base + TIMER_CTRL_OFF);
-		writel(u & ~TIMER0_EN, local_base + TIMER_CTRL_OFF);
+		local_timer_ctrl_clrset(TIMER0_EN, 0);
 
 		/*
 		 * ACK pending timer interrupt.
@@ -163,14 +165,14 @@ static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
  */
 static int armada_370_xp_timer_setup(struct clock_event_device *evt)
 {
-	u32 u;
+	u32 clr = 0, set = 0;
 	int cpu = smp_processor_id();
 
-	u = readl(local_base + TIMER_CTRL_OFF);
 	if (timer25Mhz)
-		writel(u | TIMER0_25MHZ, local_base + TIMER_CTRL_OFF);
+		set = TIMER0_25MHZ;
 	else
-		writel(u & ~TIMER0_25MHZ, local_base + TIMER_CTRL_OFF);
+		clr = TIMER0_25MHZ;
+	local_timer_ctrl_clrset(clr, set);
 
 	evt->name		= "armada_370_xp_per_cpu_tick",
 	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
@@ -219,7 +221,7 @@ static struct notifier_block armada_370_xp_timer_cpu_nb = {
 
 void __init armada_370_xp_timer_init(void)
 {
-	u32 u;
+	u32 clr = 0, set = 0;
 	struct device_node *np;
 	int res;
 
@@ -230,23 +232,19 @@ void __init armada_370_xp_timer_init(void)
 
 	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
 		/* The fixed 25MHz timer is available so let's use it */
-		u = readl(timer_base + TIMER_CTRL_OFF);
-		writel(u | TIMER0_25MHZ,
-		       timer_base + TIMER_CTRL_OFF);
+		set = TIMER0_25MHZ;
 		timer_clk = 25000000;
 	} else {
 		unsigned long rate = 0;
 		struct clk *clk = of_clk_get(np, 0);
 		WARN_ON(IS_ERR(clk));
 		rate =  clk_get_rate(clk);
-
-		u = readl(timer_base + TIMER_CTRL_OFF);
-		writel(u & ~(TIMER0_25MHZ),
-		       timer_base + TIMER_CTRL_OFF);
-
 		timer_clk = rate / TIMER_DIVIDER;
+
+		clr = TIMER0_25MHZ;
 		timer25Mhz = false;
 	}
+	timer_ctrl_clrset(clr, set);
 
 	/*
 	 * We use timer 0 as clocksource, and private(local) timer 0
@@ -268,10 +266,8 @@ void __init armada_370_xp_timer_init(void)
 	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
 	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
 
-	u = readl(timer_base + TIMER_CTRL_OFF);
-
-	writel((u | TIMER0_EN | TIMER0_RELOAD_EN |
-		TIMER0_DIV(TIMER_DIVIDER_SHIFT)), timer_base + TIMER_CTRL_OFF);
+	timer_ctrl_clrset(0, TIMER0_EN | TIMER0_RELOAD_EN |
+			     TIMER0_DIV(TIMER_DIVIDER_SHIFT));
 
 	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
 			      "armada_370_xp_clocksource",
-- 
1.8.1.5
