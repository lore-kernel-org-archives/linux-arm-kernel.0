From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:00:54 +0200
Subject: [PATCH 21/93] clocksource/drivers/digicolor: Convert init function to
 return error
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-21-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/clocksource/timer-digicolor.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index 96bb222..b929061 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -148,7 +148,7 @@ static u64 notrace digicolor_timer_sched_read(void)
 	return ~readl(dc_timer_dev.base + COUNT(TIMER_B));
 }
 
-static void __init digicolor_timer_init(struct device_node *node)
+static int __init digicolor_timer_init(struct device_node *node)
 {
 	unsigned long rate;
 	struct clk *clk;
@@ -161,19 +161,19 @@ static void __init digicolor_timer_init(struct device_node *node)
 	dc_timer_dev.base = of_iomap(node, 0);
 	if (!dc_timer_dev.base) {
 		pr_err("Can't map registers");
-		return;
+		return -ENXIO;
 	}
 
 	irq = irq_of_parse_and_map(node, dc_timer_dev.timer_id);
 	if (irq <= 0) {
 		pr_err("Can't parse IRQ");
-		return;
+		return -EINVAL;
 	}
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
 		pr_err("Can't get timer clock");
-		return;
+		return PTR_ERR(clk);
 	}
 	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
@@ -190,13 +190,17 @@ static void __init digicolor_timer_init(struct device_node *node)
 	ret = request_irq(irq, digicolor_timer_interrupt,
 			  IRQF_TIMER | IRQF_IRQPOLL, "digicolor_timerC",
 			  &dc_timer_dev.ce);
-	if (ret)
+	if (ret) {
 		pr_warn("request of timer irq %d failed (%d)\n", irq, ret);
+		return ret;
+	}
 
 	dc_timer_dev.ce.cpumask = cpu_possible_mask;
 	dc_timer_dev.ce.irq = irq;
 
 	clockevents_config_and_register(&dc_timer_dev.ce, rate, 0, 0xffffffff);
+
+	return 0;
 }
-CLOCKSOURCE_OF_DECLARE(conexant_digicolor, "cnxt,cx92755-timer",
+CLOCKSOURCE_OF_DECLARE_RET(conexant_digicolor, "cnxt,cx92755-timer",
 		       digicolor_timer_init);
-- 
1.9.1
