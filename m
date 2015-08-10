From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:51:57 +0200
Subject: [PATCH 40/74] clockevents/drivers/digicolor: Migrate to new
 'set-state' interface
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-40-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate digicolor driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Tested-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/clocksource/timer-digicolor.c | 41 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index 7f8388c..e73947f0f 100644
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
1.9.1
