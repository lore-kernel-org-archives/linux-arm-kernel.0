From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:33 +0530
Subject: [PATCH 19/41] clocksource: samsung_pwm: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <cd88ba399d67eb6781f409430876fbc9a27d5d54.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate samsung_pwm driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/samsung_pwm_timer.c | 41 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 5645cfc90c41..bc90e13338cc 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -207,25 +207,18 @@ static int samsung_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void samsung_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+static int samsung_shutdown(struct clock_event_device *evt)
 {
 	samsung_time_stop(pwm.event_id);
+	return 0;
+}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick - 1);
-		samsung_time_start(pwm.event_id, true);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+static int samsung_set_periodic(struct clock_event_device *evt)
+{
+	samsung_time_stop(pwm.event_id);
+	samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick - 1);
+	samsung_time_start(pwm.event_id, true);
+	return 0;
 }
 
 static void samsung_clockevent_resume(struct clock_event_device *cev)
@@ -240,12 +233,16 @@ static void samsung_clockevent_resume(struct clock_event_device *cev)
 }
 
 static struct clock_event_device time_event_device = {
-	.name		= "samsung_event_timer",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 200,
-	.set_next_event	= samsung_set_next_event,
-	.set_mode	= samsung_set_mode,
-	.resume		= samsung_clockevent_resume,
+	.name			= "samsung_event_timer",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.set_next_event		= samsung_set_next_event,
+	.set_state_shutdown	= samsung_shutdown,
+	.set_state_periodic	= samsung_set_periodic,
+	.set_state_oneshot	= samsung_shutdown,
+	.tick_resume		= samsung_shutdown,
+	.resume			= samsung_clockevent_resume,
 };
 
 static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
-- 
2.4.0
