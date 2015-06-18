From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:31 +0530
Subject: [PATCH 17/41] clocksource: qcom: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <f3bbf91cc4244796291bff383ef24a182bb3b690.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate qcom driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Periodic mode isn't supported by the driver and so the callback isn't
provided anymore.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/qcom-timer.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
index cba2d015564c..f8e09f923651 100644
--- a/drivers/clocksource/qcom-timer.c
+++ b/drivers/clocksource/qcom-timer.c
@@ -47,7 +47,7 @@ static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 	/* Stop the timer tick */
-	if (evt->mode == CLOCK_EVT_MODE_ONESHOT) {
+	if (clockevent_state_oneshot(evt)) {
 		u32 ctrl = readl_relaxed(event_base + TIMER_ENABLE);
 		ctrl &= ~TIMER_ENABLE_EN;
 		writel_relaxed(ctrl, event_base + TIMER_ENABLE);
@@ -75,26 +75,14 @@ static int msm_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void msm_timer_set_mode(enum clock_event_mode mode,
-			      struct clock_event_device *evt)
+static int msm_timer_shutdown(struct clock_event_device *evt)
 {
 	u32 ctrl;
 
 	ctrl = readl_relaxed(event_base + TIMER_ENABLE);
 	ctrl &= ~(TIMER_ENABLE_EN | TIMER_ENABLE_CLR_ON_MATCH_EN);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_RESUME:
-	case CLOCK_EVT_MODE_PERIODIC:
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Timer is enabled in set_next_event */
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		break;
-	}
 	writel_relaxed(ctrl, event_base + TIMER_ENABLE);
+	return 0;
 }
 
 static struct clock_event_device __percpu *msm_evt;
@@ -126,7 +114,9 @@ static int msm_local_timer_setup(struct clock_event_device *evt)
 	evt->name = "msm_timer";
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
 	evt->rating = 200;
-	evt->set_mode = msm_timer_set_mode;
+	evt->set_state_shutdown = msm_timer_shutdown;
+	evt->set_state_oneshot = msm_timer_shutdown;
+	evt->tick_resume = msm_timer_shutdown;
 	evt->set_next_event = msm_timer_set_next_event;
 	evt->cpumask = cpumask_of(cpu);
 
@@ -147,7 +137,7 @@ static int msm_local_timer_setup(struct clock_event_device *evt)
 
 static void msm_local_timer_stop(struct clock_event_device *evt)
 {
-	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 }
 
-- 
2.4.0
