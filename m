From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  8 Jun 2015 19:10:44 +0530
Subject: [PATCH 3/6] clocksource: bcm2835: Migrate to new 'set-state' interface
In-Reply-To: <cover.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <b0bf70d911dffe170b0d2b2b3e680bb445c15fc4.1433768426.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate bcm2835 driver to the new 'set-state' interface provided by
the clockevents core, the earlier 'set-mode' interface is marked
obsolete now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/bcm2835_timer.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 26ed331b1aad..b59b8e1ba503 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -54,19 +54,9 @@ static u64 notrace bcm2835_sched_read(void)
 	return readl_relaxed(system_clock);
 }
 
-static void bcm2835_time_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt_dev)
+static int bcm2835_time_noop(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	default:
-		WARN(1, "%s: unhandled event mode %d\n", __func__, mode);
-		break;
-	}
+	return 0;
 }
 
 static int bcm2835_time_set_next_event(unsigned long event,
@@ -129,7 +119,8 @@ static void __init bcm2835_timer_init(struct device_node *node)
 	timer->evt.name = node->name;
 	timer->evt.rating = 300;
 	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
-	timer->evt.set_mode = bcm2835_time_set_mode;
+	timer->evt.set_state_shutdown = bcm2835_time_noop;
+	timer->evt.set_state_oneshot = bcm2835_time_noop;
 	timer->evt.set_next_event = bcm2835_time_set_next_event;
 	timer->evt.cpumask = cpumask_of(0);
 	timer->act.name = node->name;
-- 
2.4.0
