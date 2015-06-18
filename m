From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:51 +0530
Subject: [PATCH 37/41] clocksource: sun5i: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <c116a968a5e7ae7d86ef1f7a1811942a1096b679.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate sun5i driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 45 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 0ffb4ea7c925..bca9573e036a 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -103,27 +103,31 @@ static void sun5i_clkevt_time_start(struct sun5i_timer_clkevt *ce, u8 timer, boo
 	       ce->timer.base + TIMER_CTL_REG(timer));
 }
 
-static void sun5i_clkevt_mode(enum clock_event_mode mode,
-			      struct clock_event_device *clkevt)
+static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
 {
 	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		sun5i_clkevt_time_stop(ce, 0);
-		sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
-		sun5i_clkevt_time_start(ce, 0, true);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		sun5i_clkevt_time_stop(ce, 0);
-		sun5i_clkevt_time_start(ce, 0, false);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		sun5i_clkevt_time_stop(ce, 0);
-		break;
-	}
+	sun5i_clkevt_time_stop(ce, 0);
+	return 0;
+}
+
+static int sun5i_clkevt_set_oneshot(struct clock_event_device *clkevt)
+{
+	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
+
+	sun5i_clkevt_time_stop(ce, 0);
+	sun5i_clkevt_time_start(ce, 0, false);
+	return 0;
+}
+
+static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
+{
+	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
+
+	sun5i_clkevt_time_stop(ce, 0);
+	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
+	sun5i_clkevt_time_start(ce, 0, true);
+	return 0;
 }
 
 static int sun5i_clkevt_next_event(unsigned long evt,
@@ -286,7 +290,10 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 	ce->clkevt.name = node->name;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.set_next_event = sun5i_clkevt_next_event;
-	ce->clkevt.set_mode = sun5i_clkevt_mode;
+	ce->clkevt.set_state_shutdown = sun5i_clkevt_shutdown;
+	ce->clkevt.set_state_periodic = sun5i_clkevt_set_periodic;
+	ce->clkevt.set_state_oneshot = sun5i_clkevt_set_oneshot;
+	ce->clkevt.tick_resume = sun5i_clkevt_shutdown;
 	ce->clkevt.rating = 340;
 	ce->clkevt.irq = irq;
 	ce->clkevt.cpumask = cpu_possible_mask;
-- 
2.4.0
