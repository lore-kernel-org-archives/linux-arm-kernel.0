From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:43 +0530
Subject: [PATCH 29/41] clocksource: atlas7: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <797a54c3155022b91781dfc218422de6ef0bd573.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate atlas7 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-atlas7.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-atlas7.c b/drivers/clocksource/timer-atlas7.c
index 60f9de3438b0..27fa13680be1 100644
--- a/drivers/clocksource/timer-atlas7.c
+++ b/drivers/clocksource/timer-atlas7.c
@@ -76,7 +76,7 @@ static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
 	/* clear timer interrupt */
 	writel_relaxed(BIT(cpu), sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
 
-	if (ce->mode == CLOCK_EVT_MODE_ONESHOT)
+	if (clockevent_state_oneshot(ce))
 		sirfsoc_timer_count_disable(cpu);
 
 	ce->event_handler(ce);
@@ -117,18 +117,11 @@ static int sirfsoc_timer_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *ce)
+/* Oneshot is enabled in set_next_event */
+static int sirfsoc_timer_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* enable in set_next_event */
-		break;
-	default:
-		break;
-	}
-
 	sirfsoc_timer_count_disable(smp_processor_id());
+	return 0;
 }
 
 static void sirfsoc_clocksource_suspend(struct clocksource *cs)
@@ -193,7 +186,9 @@ static int sirfsoc_local_timer_setup(struct clock_event_device *ce)
 	ce->name = "local_timer";
 	ce->features = CLOCK_EVT_FEAT_ONESHOT;
 	ce->rating = 200;
-	ce->set_mode = sirfsoc_timer_set_mode;
+	ce->set_state_shutdown = sirfsoc_timer_shutdown;
+	ce->set_state_oneshot = sirfsoc_timer_shutdown;
+	ce->tick_resume = sirfsoc_timer_shutdown;
 	ce->set_next_event = sirfsoc_timer_set_next_event;
 	clockevents_calc_mult_shift(ce, atlas7_timer_rate, 60);
 	ce->max_delta_ns = clockevent_delta2ns(-2, ce);
-- 
2.4.0
