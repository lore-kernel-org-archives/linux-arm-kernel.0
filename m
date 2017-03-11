From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 11 Mar 2017 17:42:29 +0000
Subject: [PATCH 1/2] clocksource: orion: read clock rate once
Message-ID: <E1cml2D-0007CJ-Iv@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than reading the clock rate three times, read it once - we are
about to add a fourth usage.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/clocksource/time-orion.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index a28f496e97cf..c4818a5dc8e5 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -106,6 +106,7 @@ static struct irqaction orion_clkevt_irq = {
 
 static int __init orion_timer_init(struct device_node *np)
 {
+	unsigned long rate;
 	struct clk *clk;
 	int irq, ret;
 
@@ -135,6 +136,8 @@ static int __init orion_timer_init(struct device_node *np)
 		return -EINVAL;
 	}
 
+	rate = clk_get_rate(clk);
+
 	/* setup timer0 as free-running clocksource */
 	writel(~0, timer_base + TIMER0_VAL);
 	writel(~0, timer_base + TIMER0_RELOAD);
@@ -142,15 +145,15 @@ static int __init orion_timer_init(struct device_node *np)
 		TIMER0_RELOAD_EN | TIMER0_EN,
 		TIMER0_RELOAD_EN | TIMER0_EN);
 
-	ret = clocksource_mmio_init(timer_base + TIMER0_VAL, "orion_clocksource",
-				    clk_get_rate(clk), 300, 32,
+	ret = clocksource_mmio_init(timer_base + TIMER0_VAL,
+				    "orion_clocksource", rate, 300, 32,
 				    clocksource_mmio_readl_down);
 	if (ret) {
 		pr_err("Failed to initialize mmio timer");
 		return ret;
 	}
 
-	sched_clock_register(orion_read_sched_clock, 32, clk_get_rate(clk));
+	sched_clock_register(orion_read_sched_clock, 32, rate);
 
 	/* setup timer1 as clockevent timer */
 	ret = setup_irq(irq, &orion_clkevt_irq);
@@ -162,7 +165,7 @@ static int __init orion_timer_init(struct device_node *np)
 	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
 	orion_clkevt.cpumask = cpumask_of(0);
 	orion_clkevt.irq = irq;
-	clockevents_config_and_register(&orion_clkevt, clk_get_rate(clk),
+	clockevents_config_and_register(&orion_clkevt, rate,
 					ORION_ONESHOT_MIN, ORION_ONESHOT_MAX);
 
 	return 0;
-- 
2.7.4
