From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:37 +0530
Subject: [PATCH 23/41] clocksource: sun4i: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <fe0d96a4671d94c60f7b252d1c038cd62ed71162.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate sun4i driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/sun4i_timer.c | 41 +++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 1928a8912584..6f3719d73390 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -81,25 +81,25 @@ static void sun4i_clkevt_time_start(u8 timer, bool periodic)
 	       timer_base + TIMER_CTL_REG(timer));
 }
 
-static void sun4i_clkevt_mode(enum clock_event_mode mode,
-			      struct clock_event_device *clk)
+static int sun4i_clkevt_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		sun4i_clkevt_time_stop(0);
-		sun4i_clkevt_time_setup(0, ticks_per_jiffy);
-		sun4i_clkevt_time_start(0, true);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		sun4i_clkevt_time_stop(0);
-		sun4i_clkevt_time_start(0, false);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		sun4i_clkevt_time_stop(0);
-		break;
-	}
+	sun4i_clkevt_time_stop(0);
+	return 0;
+}
+
+static int sun4i_clkevt_set_oneshot(struct clock_event_device *evt)
+{
+	sun4i_clkevt_time_stop(0);
+	sun4i_clkevt_time_start(0, false);
+	return 0;
+}
+
+static int sun4i_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	sun4i_clkevt_time_stop(0);
+	sun4i_clkevt_time_setup(0, ticks_per_jiffy);
+	sun4i_clkevt_time_start(0, true);
+	return 0;
 }
 
 static int sun4i_clkevt_next_event(unsigned long evt,
@@ -116,7 +116,10 @@ static struct clock_event_device sun4i_clockevent = {
 	.name = "sun4i_tick",
 	.rating = 350,
 	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode = sun4i_clkevt_mode,
+	.set_state_shutdown = sun4i_clkevt_shutdown,
+	.set_state_periodic = sun4i_clkevt_set_periodic,
+	.set_state_oneshot = sun4i_clkevt_set_oneshot,
+	.tick_resume = sun4i_clkevt_shutdown,
 	.set_next_event = sun4i_clkevt_next_event,
 };
 
-- 
2.4.0
