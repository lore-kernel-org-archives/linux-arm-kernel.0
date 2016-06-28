From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:31:14 +0200
Subject: [PATCH 55/92] clocksource/drivers/keystone: Convert init function to
 return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-55-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
---
 drivers/clocksource/timer-keystone.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
index 1cea08c..4199823 100644
--- a/drivers/clocksource/timer-keystone.c
+++ b/drivers/clocksource/timer-keystone.c
@@ -144,7 +144,7 @@ static int keystone_set_periodic(struct clock_event_device *evt)
 	return 0;
 }
 
-static void __init keystone_timer_init(struct device_node *np)
+static int __init keystone_timer_init(struct device_node *np)
 {
 	struct clock_event_device *event_dev = &timer.event_dev;
 	unsigned long rate;
@@ -154,20 +154,20 @@ static void __init keystone_timer_init(struct device_node *np)
 	irq  = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		pr_err("%s: failed to map interrupts\n", __func__);
-		return;
+		return -EINVAL;
 	}
 
 	timer.base = of_iomap(np, 0);
 	if (!timer.base) {
 		pr_err("%s: failed to map registers\n", __func__);
-		return;
+		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to get clock\n", __func__);
 		iounmap(timer.base);
-		return;
+		return PTR_ERR(clk);
 	}
 
 	error = clk_prepare_enable(clk);
@@ -219,11 +219,12 @@ static void __init keystone_timer_init(struct device_node *np)
 	clockevents_config_and_register(event_dev, rate, 1, ULONG_MAX);
 
 	pr_info("keystone timer clock @%lu Hz\n", rate);
-	return;
+	return 0;
 err:
 	clk_put(clk);
 	iounmap(timer.base);
+	return error;
 }
 
-CLOCKSOURCE_OF_DECLARE(keystone_timer, "ti,keystone-timer",
-					keystone_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(keystone_timer, "ti,keystone-timer",
+			   keystone_timer_init);
-- 
1.9.1
