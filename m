From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 23:26:54 +0200
Subject: [PATCH V2 35/63] clocksource/drivers/time-lpc32xx: Convert init
 function to return error
In-Reply-To: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1466112442-31105-36-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/time-efm32.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index b06e4c2..b71ffc6 100644
--- a/drivers/clocksource/time-efm32.c
+++ b/drivers/clocksource/time-efm32.c
@@ -233,7 +233,11 @@ static int __init efm32_clockevent_init(struct device_node *np)
 					DIV_ROUND_CLOSEST(rate, 1024),
 					0xf, 0xffff);
 
-	setup_irq(irq, &efm32_clock_event_irq);
+	ret = setup_irq(irq, &efm32_clock_event_irq);
+	if (ret) {
+		pr_err("Failed setup irq");
+		goto err_get_irq;
+	}
 
 	return 0;
 
@@ -255,16 +259,16 @@ err_clk_get:
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
 
@@ -272,9 +276,11 @@ static void __init efm32_timer_init(struct device_node *np)
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
