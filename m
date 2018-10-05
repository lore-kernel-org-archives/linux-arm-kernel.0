From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  5 Oct 2018 16:35:30 +0200
Subject: [PATCH 01/13] clocksource: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20181005143253.GE1881@mai>
References: <20181005143253.GE1881@mai>
Message-ID: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/asm9260_timer.c       | 2 +-
 drivers/clocksource/cadence_ttc_timer.c   | 2 +-
 drivers/clocksource/dw_apb_timer_of.c     | 8 ++++----
 drivers/clocksource/pxa_timer.c           | 6 +++---
 drivers/clocksource/time-orion.c          | 8 ++++----
 drivers/clocksource/timer-integrator-ap.c | 2 +-
 drivers/clocksource/timer-sp804.c         | 2 +-
 drivers/clocksource/zevio-timer.c         | 8 ++++----
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 38cd2fe..fbaee04 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -193,7 +193,7 @@ static int __init asm9260_timer_init(struct device_node *np)
 
 	priv.base = of_io_request_and_map(np, 0, np->name);
 	if (IS_ERR(priv.base)) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return PTR_ERR(priv.base);
 	}
 
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 29d5175..b334029 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -535,7 +535,7 @@ static int __init ttc_timer_init(struct device_node *timer)
 	if (ret)
 		return ret;
 
-	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
+	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
 
 	return 0;
 }
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 69866cd..fabaa29 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -33,7 +33,7 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 	*base = of_iomap(np, 0);
 
 	if (!*base)
-		panic("Unable to map regs for %s", np->name);
+		panic("Unable to map regs for %pOFn", np);
 
 	/*
 	 * Not all implementations use a periphal clock, so don't panic
@@ -42,8 +42,8 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 	pclk = of_clk_get_by_name(np, "pclk");
 	if (!IS_ERR(pclk))
 		if (clk_prepare_enable(pclk))
-			pr_warn("pclk for %s is present, but could not be activated\n",
-				np->name);
+			pr_warn("pclk for %pOFn is present, but could not be activated\n",
+				np);
 
 	timer_clk = of_clk_get_by_name(np, "timer");
 	if (IS_ERR(timer_clk))
@@ -57,7 +57,7 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 try_clock_freq:
 	if (of_property_read_u32(np, "clock-freq", rate) &&
 	    of_property_read_u32(np, "clock-frequency", rate))
-		panic("No clock nor clock-frequency property for %s", np->name);
+		panic("No clock nor clock-frequency property for %pOFn", np);
 }
 
 static void __init add_clockevent(struct device_node *event_timer)
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 08cd6eaf..3958379 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -191,13 +191,13 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	/* timer registers are shared with watchdog timer */
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_crit("%s: unable to get clk\n", np->name);
+		pr_crit("%pOFn: unable to get clk\n", np);
 		return PTR_ERR(clk);
 	}
 
@@ -210,7 +210,7 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	/* we are only interested in OS-timer0 irq */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
-		pr_crit("%s: unable to parse OS-timer0 irq\n", np->name);
+		pr_crit("%pOFn: unable to parse OS-timer0 irq\n", np);
 		return -EINVAL;
 	}
 
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index 1220206..7d487107 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -129,13 +129,13 @@ static int __init orion_timer_init(struct device_node *np)
 	/* timer registers are shared with watchdog timer */
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("%s: unable to get clk\n", np->name);
+		pr_err("%pOFn: unable to get clk\n", np);
 		return PTR_ERR(clk);
 	}
 
@@ -148,7 +148,7 @@ static int __init orion_timer_init(struct device_node *np)
 	/* we are only interested in timer1 irq */
 	irq = irq_of_parse_and_map(np, 1);
 	if (irq <= 0) {
-		pr_err("%s: unable to parse timer1 irq\n", np->name);
+		pr_err("%pOFn: unable to parse timer1 irq\n", np);
 		return -EINVAL;
 	}
 
@@ -174,7 +174,7 @@ static int __init orion_timer_init(struct device_node *np)
 	/* setup timer1 as clockevent timer */
 	ret = setup_irq(irq, &orion_clkevt_irq);
 	if (ret) {
-		pr_err("%s: unable to setup irq\n", np->name);
+		pr_err("%pOFn: unable to setup irq\n", np);
 		return ret;
 	}
 
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 62d2469..76e526f 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -190,7 +190,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_err("No clock for %s\n", node->name);
+		pr_err("No clock for %pOFn\n", node);
 		return PTR_ERR(clk);
 	}
 	clk_prepare_enable(clk);
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e01222e..052b230 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -249,7 +249,7 @@ static int __init sp804_of_init(struct device_node *np)
 	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
-			pr_err("sp804: %s clock not found: %d\n", np->name,
+			pr_err("sp804: %pOFn clock not found: %d\n", np,
 				(int)PTR_ERR(clk2));
 			clk2 = NULL;
 		}
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index f746893..6127e80 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -148,12 +148,12 @@ static int __init zevio_timer_add(struct device_node *node)
 
 	of_address_to_resource(node, 0, &res);
 	scnprintf(timer->clocksource_name, sizeof(timer->clocksource_name),
-			"%llx.%s_clocksource",
-			(unsigned long long)res.start, node->name);
+			"%llx.%pOFn_clocksource",
+			(unsigned long long)res.start, node);
 
 	scnprintf(timer->clockevent_name, sizeof(timer->clockevent_name),
-			"%llx.%s_clockevent",
-			(unsigned long long)res.start, node->name);
+			"%llx.%pOFn_clockevent",
+			(unsigned long long)res.start, node);
 
 	if (timer->interrupt_regs && irqnr) {
 		timer->clkevt.name		= timer->clockevent_name;
-- 
2.7.4
