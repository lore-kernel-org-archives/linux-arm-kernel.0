From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:46 +0530
Subject: [PATCH 32/41] clocksource: digicolor: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <6809c28328450f138517daa6c22f97f283f3fd01.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate digicolor driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-digicolor.c | 41 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index 7f8388cfa810..e73947f0f86d 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -87,27 +87,27 @@ static inline void dc_timer_set_count(struct clock_event_device *ce,
 	writel(count, dt->base + COUNT(dt->timer_id));
 }
 
-static void digicolor_clkevt_mode(enum clock_event_mode mode,
-				  struct clock_event_device *ce)
+static int digicolor_clkevt_shutdown(struct clock_event_device *ce)
+{
+	dc_timer_disable(ce);
+	return 0;
+}
+
+static int digicolor_clkevt_set_oneshot(struct clock_event_device *ce)
+{
+	dc_timer_disable(ce);
+	dc_timer_enable(ce, CONTROL_MODE_ONESHOT);
+	return 0;
+}
+
+static int digicolor_clkevt_set_periodic(struct clock_event_device *ce)
 {
 	struct digicolor_timer *dt = dc_timer(ce);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		dc_timer_disable(ce);
-		dc_timer_set_count(ce, dt->ticks_per_jiffy);
-		dc_timer_enable(ce, CONTROL_MODE_PERIODIC);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		dc_timer_disable(ce);
-		dc_timer_enable(ce, CONTROL_MODE_ONESHOT);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		dc_timer_disable(ce);
-		break;
-	}
+	dc_timer_disable(ce);
+	dc_timer_set_count(ce, dt->ticks_per_jiffy);
+	dc_timer_enable(ce, CONTROL_MODE_PERIODIC);
+	return 0;
 }
 
 static int digicolor_clkevt_next_event(unsigned long evt,
@@ -125,7 +125,10 @@ static struct digicolor_timer dc_timer_dev = {
 		.name = "digicolor_tick",
 		.rating = 340,
 		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-		.set_mode = digicolor_clkevt_mode,
+		.set_state_shutdown = digicolor_clkevt_shutdown,
+		.set_state_periodic = digicolor_clkevt_set_periodic,
+		.set_state_oneshot = digicolor_clkevt_set_oneshot,
+		.tick_resume = digicolor_clkevt_shutdown,
 		.set_next_event = digicolor_clkevt_next_event,
 	},
 	.timer_id = TIMER_C,
-- 
2.4.0
