From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  1 Jun 2016 10:34:50 +0200
Subject: [PATCH 7/9] clocksource/drivers/cadence_ttc: Convert init function to
 return error
In-Reply-To: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
References: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1464770093-12667-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

 - panic, thus leading to a kernel crash while another timer may work and
   make the system boot up correctly

 or

 - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/cadence_ttc_timer.c | 82 +++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 9be6018..aa36cbf 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -322,22 +322,22 @@ static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
+static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 					 u32 timer_width)
 {
 	struct ttc_timer_clocksource *ttccs;
 	int err;
 
 	ttccs = kzalloc(sizeof(*ttccs), GFP_KERNEL);
-	if (WARN_ON(!ttccs))
-		return;
+	if (!ttccs)
+		return -ENOMEM;
 
 	ttccs->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttccs->ttc.clk);
-	if (WARN_ON(err)) {
+	if (err) {
 		kfree(ttccs);
-		return;
+		return err;
 	}
 
 	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
@@ -345,9 +345,13 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 	ttccs->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clocksource_cb;
 	ttccs->ttc.clk_rate_change_nb.next = NULL;
-	if (clk_notifier_register(ttccs->ttc.clk,
-				&ttccs->ttc.clk_rate_change_nb))
+
+	err = clk_notifier_register(ttccs->ttc.clk,
+				    &ttccs->ttc.clk_rate_change_nb);
+	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
+		return err;
+	}
 
 	ttccs->ttc.base_addr = base;
 	ttccs->cs.name = "ttc_clocksource";
@@ -368,14 +372,16 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
 
 	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
-	if (WARN_ON(err)) {
+	if (err) {
 		kfree(ttccs);
-		return;
+		return err;
 	}
 
 	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
 	sched_clock_register(ttc_sched_clock_read, timer_width,
 			     ttccs->ttc.freq / PRESCALE);
+
+	return 0;
 }
 
 static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
@@ -401,30 +407,35 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
 	}
 }
 
-static void __init ttc_setup_clockevent(struct clk *clk,
-						void __iomem *base, u32 irq)
+static int __init ttc_setup_clockevent(struct clk *clk,
+				       void __iomem *base, u32 irq)
 {
 	struct ttc_timer_clockevent *ttcce;
 	int err;
 
 	ttcce = kzalloc(sizeof(*ttcce), GFP_KERNEL);
-	if (WARN_ON(!ttcce))
-		return;
+	if (!ttcce)
+		return -ENOMEM;
 
 	ttcce->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (WARN_ON(err)) {
+	if (err) {
 		kfree(ttcce);
-		return;
+		return err;
 	}
 
 	ttcce->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clockevent_cb;
 	ttcce->ttc.clk_rate_change_nb.next = NULL;
-	if (clk_notifier_register(ttcce->ttc.clk,
-				&ttcce->ttc.clk_rate_change_nb))
+
+	err = clk_notifier_register(ttcce->ttc.clk,
+				    &ttcce->ttc.clk_rate_change_nb);
+	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
+		return err;
+	}
+
 	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
 
 	ttcce->ttc.base_addr = base;
@@ -451,13 +462,15 @@ static void __init ttc_setup_clockevent(struct clk *clk,
 
 	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (WARN_ON(err)) {
+	if (err) {
 		kfree(ttcce);
-		return;
+		return err;
 	}
 
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
+
+	return 0;
 }
 
 /**
@@ -466,20 +479,14 @@ static void __init ttc_setup_clockevent(struct clk *clk,
  * Initializes the timer hardware and register the clock source and clock event
  * timers with Linux kernal timer framework
  */
-static void __init ttc_timer_init(struct device_node *timer)
+static int __init ttc_timer_init(struct device_node *timer)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
 	struct clk *clk_cs, *clk_ce;
-	static int initialized;
-	int clksel;
+	int clksel, ret;
 	u32 timer_width = 16;
 
-	if (initialized)
-		return;
-
-	initialized = 1;
-
 	/*
 	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
 	 * and use it. Note that the event timer uses the interrupt and it's the
@@ -488,13 +495,13 @@ static void __init ttc_timer_init(struct device_node *timer)
 	timer_baseaddr = of_iomap(timer, 0);
 	if (!timer_baseaddr) {
 		pr_err("ERROR: invalid timer base address\n");
-		BUG();
+		return -ENXIO;
 	}
 
 	irq = irq_of_parse_and_map(timer, 1);
 	if (irq <= 0) {
 		pr_err("ERROR: invalid interrupt number\n");
-		BUG();
+		return -EINVAL;
 	}
 
 	of_property_read_u32(timer, "timer-width", &timer_width);
@@ -504,7 +511,7 @@ static void __init ttc_timer_init(struct device_node *timer)
 	clk_cs = of_clk_get(timer, clksel);
 	if (IS_ERR(clk_cs)) {
 		pr_err("ERROR: timer input clock not found\n");
-		BUG();
+		return PTR_ERR(clk_cs);
 	}
 
 	clksel = readl_relaxed(timer_baseaddr + 4 + TTC_CLK_CNTRL_OFFSET);
@@ -512,13 +519,20 @@ static void __init ttc_timer_init(struct device_node *timer)
 	clk_ce = of_clk_get(timer, clksel);
 	if (IS_ERR(clk_ce)) {
 		pr_err("ERROR: timer input clock not found\n");
-		BUG();
+		return PTR_ERR(clk_cs);
 	}
 
-	ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
-	ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
+	ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
+	if (ret)
+		return ret;
+
+	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
+	if (ret)
+		return ret;
 
 	pr_info("%s #0@%p, irq=%d\n", timer->name, timer_baseaddr, irq);
+
+	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(ttc, "cdns,ttc", ttc_timer_init);
-- 
1.9.1
