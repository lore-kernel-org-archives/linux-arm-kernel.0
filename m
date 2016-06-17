From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 17 Jun 2016 10:44:19 +0200
Subject: [PATCH V3] clocksource/drivers/time-efm32: Convert init function to
 return error
In-Reply-To: <20160617065250.GU26048@pengutronix.de>
References: <20160617065250.GU26048@pengutronix.de>
Message-ID: <1466153059-16820-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error and let the caller unaware of
the state of the system.

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/time-efm32.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index b06e4c2..6e2f79f 100644
--- a/drivers/clocksource/time-efm32.c
+++ b/drivers/clocksource/time-efm32.c
@@ -233,10 +233,15 @@ static int __init efm32_clockevent_init(struct device_node *np)
 					DIV_ROUND_CLOSEST(rate, 1024),
 					0xf, 0xffff);
 
-	setup_irq(irq, &efm32_clock_event_irq);
+	ret = setup_irq(irq, &efm32_clock_event_irq);
+	if (ret) {
+		pr_err("Failed setup irq");
+		goto err_setup_irq;
+	}
 
 	return 0;
 
+err_setup_irq:
 err_get_irq:
 
 	iounmap(base);
@@ -255,16 +260,16 @@ err_clk_get:
  * This function asserts that we have exactly one clocksource and one
  * clock_event_device in the end.
  */
-static void __init efm32_timer_init(struct device_node *np)
+static int __init efm32_timer_init(struct device_node *np)
 {
 	static int has_clocksource, has_clockevent;
-	int ret;
+	int ret = 0;
 
 	if (!has_clocksource) {
 		ret = efm32_clocksource_init(np);
 		if (!ret) {
 			has_clocksource = 1;
-			return;
+			return 0;
 		}
 	}
 
@@ -272,9 +277,11 @@ static void __init efm32_timer_init(struct device_node *np)
 		ret = efm32_clockevent_init(np);
 		if (!ret) {
 			has_clockevent = 1;
-			return;
+			return 0;
 		}
 	}
+
+	return ret;
 }
-CLOCKSOURCE_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
-CLOCKSOURCE_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(efm32compat, "efm32,timer", efm32_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(efm32, "energymicro,efm32-timer", efm32_timer_init);
-- 
1.9.1
