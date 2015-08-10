From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:51:44 +0200
Subject: [PATCH 27/74] clockevents/drivers/rockchip: Migrate to new
 'set-state' interface
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-27-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate rockchip driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything for oneshot or resume modes, and so the
callbacks aren't provided.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/rockchip_timer.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index a35993b..bb2c2b0 100644
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
1.9.1
