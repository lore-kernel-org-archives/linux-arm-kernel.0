From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:01:33 +0200
Subject: [PATCH 60/93] clocksource/drivers/u300: Convert init function to
 return error
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-60-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-u300.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
index 1744b24..a6a0dec 100644
--- a/drivers/clocksource/timer-u300.c
+++ b/drivers/clocksource/timer-u300.c
@@ -359,27 +359,37 @@ static struct delay_timer u300_delay_timer;
 /*
  * This sets up the system timers, clock source and clock event.
  */
-static void __init u300_timer_init_of(struct device_node *np)
+static int __init u300_timer_init_of(struct device_node *np)
 {
 	unsigned int irq;
 	struct clk *clk;
 	unsigned long rate;
+	int ret;
 
 	u300_timer_base = of_iomap(np, 0);
-	if (!u300_timer_base)
-		panic("could not ioremap system timer\n");
+	if (!u300_timer_base) {
+		pr_err("could not ioremap system timer\n");
+		return -ENXIO;
+	}
 
 	/* Get the IRQ for the GP1 timer */
 	irq = irq_of_parse_and_map(np, 2);
-	if (!irq)
-		panic("no IRQ for system timer\n");
+	if (!irq) {
+		pr_err("no IRQ for system timer\n");
+		return -EINVAL;
+	}
 
 	pr_info("U300 GP1 timer @ base: %p, IRQ: %u\n", u300_timer_base, irq);
 
 	/* Clock the interrupt controller */
 	clk = of_clk_get(np, 0);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
 	rate = clk_get_rate(clk);
 
 	u300_clockevent_data.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
@@ -410,7 +420,9 @@ static void __init u300_timer_init_of(struct device_node *np)
 		u300_timer_base + U300_TIMER_APP_RGPT1);
 
 	/* Set up the IRQ handler */
-	setup_irq(irq, &u300_timer_irq);
+	ret = setup_irq(irq, &u300_timer_irq);
+	if (ret)
+		return ret;
 
 	/* Reset the General Purpose timer 2 */
 	writel(U300_TIMER_APP_RGPT2_TIMER_RESET,
@@ -428,9 +440,12 @@ static void __init u300_timer_init_of(struct device_node *np)
 		u300_timer_base + U300_TIMER_APP_EGPT2);
 
 	/* Use general purpose timer 2 as clock source */
-	if (clocksource_mmio_init(u300_timer_base + U300_TIMER_APP_GPT2CC,
-			"GPT2", rate, 300, 32, clocksource_mmio_readl_up))
+	ret = clocksource_mmio_init(u300_timer_base + U300_TIMER_APP_GPT2CC,
+				    "GPT2", rate, 300, 32, clocksource_mmio_readl_up);
+	if (ret) {
 		pr_err("timer: failed to initialize U300 clock source\n");
+		return ret;
+	}
 
 	/* Configure and register the clockevent */
 	clockevents_config_and_register(&u300_clockevent_data.cevd, rate,
@@ -440,7 +455,8 @@ static void __init u300_timer_init_of(struct device_node *np)
 	 * TODO: init and register the rest of the timers too, they can be
 	 * used by hrtimers!
 	 */
+	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE(u300_timer, "stericsson,u300-apptimer",
+CLOCKSOURCE_OF_DECLARE_RET(u300_timer, "stericsson,u300-apptimer",
 		       u300_timer_init_of);
-- 
1.9.1
