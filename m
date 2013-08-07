From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  7 Aug 2013 20:52:33 -0300
Subject: [PATCH 2/5] clocksource: armada-370-xp: Simplify TIMER_CTRL register
 access
In-Reply-To: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1375919556-24104-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit creates two functions to access the TIMER_CTRL register:
one for global one for the per-cpu. This makes the code much more
readable. In addition, since the TIMER_CTRL register is also used for
watchdog, this is preparation work for future thread-safe improvements.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 70 ++++++++++++++------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 5ee4329..a2351ac 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -71,6 +71,18 @@ static u32 ticks_per_jiffy;
 
 static struct clock_event_device __percpu **percpu_armada_370_xp_evt;
 
+void timer_ctrl_clrset(u32 clr, u32 set)
+{
+       writel((readl(timer_base + TIMER_CTRL_OFF) & ~clr) | set,
+               timer_base + TIMER_CTRL_OFF);
+}
+
+void local_timer_ctrl_clrset(u32 clr, u32 set)
+{
+       writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
+               local_base + TIMER_CTRL_OFF);
+}
+
 static u32 notrace armada_370_xp_read_sched_clock(void)
 {
 	return ~readl(timer_base + TIMER0_VAL_OFF);
@@ -83,7 +95,6 @@ static int
 armada_370_xp_clkevt_next_event(unsigned long delta,
 				struct clock_event_device *dev)
 {
-	u32 u;
 	/*
 	 * Clear clockevent timer interrupt.
 	 */
@@ -97,11 +108,8 @@ armada_370_xp_clkevt_next_event(unsigned long delta,
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
 
@@ -109,8 +117,6 @@ static void
 armada_370_xp_clkevt_mode(enum clock_event_mode mode,
 			  struct clock_event_device *dev)
 {
-	u32 u;
-
 	if (mode == CLOCK_EVT_MODE_PERIODIC) {
 
 		/*
@@ -122,18 +128,14 @@ armada_370_xp_clkevt_mode(enum clock_event_mode mode,
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
@@ -169,18 +171,18 @@ static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
  */
 static int armada_370_xp_timer_setup(struct clock_event_device *evt)
 {
-	u32 u;
+	u32 clr = 0, set = 0;
 	int cpu = smp_processor_id();
 
 	/* Use existing clock_event for cpu 0 */
 	if (!smp_processor_id())
 		return 0;
 
-	u = readl(local_base + TIMER_CTRL_OFF);
 	if (timer25Mhz)
-		writel(u | TIMER0_25MHZ, local_base + TIMER_CTRL_OFF);
+		set = TIMER0_25MHZ;
 	else
-		writel(u & ~TIMER0_25MHZ, local_base + TIMER_CTRL_OFF);
+		clr = TIMER0_25MHZ;
+	local_timer_ctrl_clrset(clr, set);
 
 	evt->name		= armada_370_xp_clkevt.name;
 	evt->irq		= armada_370_xp_clkevt.irq;
@@ -212,7 +214,7 @@ static struct local_timer_ops armada_370_xp_local_timer_ops = {
 
 static void __init armada_370_xp_timer_init(struct device_node *np)
 {
-	u32 u;
+	u32 clr = 0, set = 0;
 	int res;
 
 	timer_base = of_iomap(np, 0);
@@ -220,30 +222,22 @@ static void __init armada_370_xp_timer_init(struct device_node *np)
 	local_base = of_iomap(np, 1);
 
 	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
+
 		/* The fixed 25MHz timer is available so let's use it */
-		u = readl(local_base + TIMER_CTRL_OFF);
-		writel(u | TIMER0_25MHZ,
-		       local_base + TIMER_CTRL_OFF);
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
-		u = readl(local_base + TIMER_CTRL_OFF);
-		writel(u & ~(TIMER0_25MHZ),
-		       local_base + TIMER_CTRL_OFF);
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
+	local_timer_ctrl_clrset(clr, set);
+	timer_ctrl_clrset(clr, set);
 
 	/*
 	 * We use timer 0 as clocksource, and private(local) timer 0
@@ -265,10 +259,8 @@ static void __init armada_370_xp_timer_init(struct device_node *np)
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
