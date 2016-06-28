From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:31:05 +0200
Subject: [PATCH 46/92] clocksource/drivers/time-lpc32xx: Convert init function
 to return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-46-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
---
 drivers/clocksource/time-lpc32xx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
index daae61e..cb5b866 100644
--- a/drivers/clocksource/time-lpc32xx.c
+++ b/drivers/clocksource/time-lpc32xx.c
@@ -288,16 +288,16 @@ err_clk_enable:
  * This function asserts that we have exactly one clocksource and one
  * clock_event_device in the end.
  */
-static void __init lpc32xx_timer_init(struct device_node *np)
+static int __init lpc32xx_timer_init(struct device_node *np)
 {
 	static int has_clocksource, has_clockevent;
-	int ret;
+	int ret = 0;
 
 	if (!has_clocksource) {
 		ret = lpc32xx_clocksource_init(np);
 		if (!ret) {
 			has_clocksource = 1;
-			return;
+			return 0;
 		}
 	}
 
@@ -305,8 +305,10 @@ static void __init lpc32xx_timer_init(struct device_node *np)
 		ret = lpc32xx_clockevent_init(np);
 		if (!ret) {
 			has_clockevent = 1;
-			return;
+			return 0;
 		}
 	}
+
+	return ret;
 }
-CLOCKSOURCE_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
-- 
1.9.1
