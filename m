From: dinggnu@gmail.com (Cong Ding)
Date: Mon, 14 Jan 2013 22:18:46 +0100
Subject: [PATCH] arm: mach-zynq/timer.c: fix memory leakage
Message-ID: <1358198331-31949-1-git-send-email-dinggnu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the variable ttccs allocated isn't freed when error occurs, so we call kfree
before return.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 arch/arm/mach-zynq/timer.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index f9fbc9c..df04761 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -203,15 +203,15 @@ static void __init zynq_ttc_setup_clocksource(struct device_node *np,
 
 	err = of_property_read_u32(np, "reg", &reg);
 	if (WARN_ON(err))
-		return;
+		goto out;
 
 	clk = of_clk_get_by_name(np, "cpu_1x");
 	if (WARN_ON(IS_ERR(clk)))
-		return;
+		goto out;
 
 	err = clk_prepare_enable(clk);
 	if (WARN_ON(err))
-		return;
+		goto out;
 
 	ttccs->xttc.base_addr = base + reg * 4;
 
@@ -229,7 +229,10 @@ static void __init zynq_ttc_setup_clocksource(struct device_node *np,
 
 	err = clocksource_register_hz(&ttccs->cs, clk_get_rate(clk) / PRESCALE);
 	if (WARN_ON(err))
-		return;
+		goto out;
+	return;
+out:
+	kfree(ttccs);
 }
 
 static void __init zynq_ttc_setup_clockevent(struct device_node *np,
@@ -245,21 +248,21 @@ static void __init zynq_ttc_setup_clockevent(struct device_node *np,
 
 	err = of_property_read_u32(np, "reg", &reg);
 	if (WARN_ON(err))
-		return;
+		goto out;
 
 	ttcce->xttc.base_addr = base + reg * 4;
 
 	ttcce->clk = of_clk_get_by_name(np, "cpu_1x");
 	if (WARN_ON(IS_ERR(ttcce->clk)))
-		return;
+		goto out;
 
 	err = clk_prepare_enable(ttcce->clk);
 	if (WARN_ON(err))
-		return;
+		goto out;
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (WARN_ON(!irq))
-		return;
+		goto out;
 
 	ttcce->ce.name = np->name;
 	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
@@ -277,11 +280,15 @@ static void __init zynq_ttc_setup_clockevent(struct device_node *np,
 	err = request_irq(irq, xttcps_clock_event_interrupt, IRQF_TIMER,
 			  np->name, ttcce);
 	if (WARN_ON(err))
-		return;
+		goto out;
 
 	clockevents_config_and_register(&ttcce->ce,
 					clk_get_rate(ttcce->clk) / PRESCALE,
 					1, 0xfffe);
+	return;
+
+out:
+	kfree(ttcce);
 }
 
 static const __initconst struct of_device_id zynq_ttc_match[] = {
-- 
1.7.9.5
