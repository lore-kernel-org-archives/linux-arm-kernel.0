From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:32 +0530
Subject: [PATCH 18/41] clocksource: rockchip: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <94ca38bcf546de1481b2764f6286b8c370e17f74.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate rockchip driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything for oneshot or resume modes, and so the
callbacks aren't provided.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/rockchip_timer.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index a35993bafb20..bb2c2b050964 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -82,23 +82,18 @@ static inline int rk_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static inline void rk_timer_set_mode(enum clock_event_mode mode,
-				     struct clock_event_device *ce)
+static int rk_timer_shutdown(struct clock_event_device *ce)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		rk_timer_disable(ce);
-		rk_timer_update_counter(rk_timer(ce)->freq / HZ - 1, ce);
-		rk_timer_enable(ce, TIMER_MODE_FREE_RUNNING);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		rk_timer_disable(ce);
-		break;
-	}
+	rk_timer_disable(ce);
+	return 0;
+}
+
+static int rk_timer_set_periodic(struct clock_event_device *ce)
+{
+	rk_timer_disable(ce);
+	rk_timer_update_counter(rk_timer(ce)->freq / HZ - 1, ce);
+	rk_timer_enable(ce, TIMER_MODE_FREE_RUNNING);
+	return 0;
 }
 
 static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
@@ -107,7 +102,7 @@ static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 
 	rk_timer_interrupt_clear(ce);
 
-	if (ce->mode == CLOCK_EVT_MODE_ONESHOT)
+	if (clockevent_state_oneshot(ce))
 		rk_timer_disable(ce);
 
 	ce->event_handler(ce);
@@ -161,7 +156,8 @@ static void __init rk_timer_init(struct device_node *np)
 	ce->name = TIMER_NAME;
 	ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->set_next_event = rk_timer_set_next_event;
-	ce->set_mode = rk_timer_set_mode;
+	ce->set_state_shutdown = rk_timer_shutdown;
+	ce->set_state_periodic = rk_timer_set_periodic;
 	ce->irq = irq;
 	ce->cpumask = cpumask_of(0);
 	ce->rating = 250;
-- 
2.4.0
