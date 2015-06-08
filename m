From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  8 Jun 2015 19:10:45 +0530
Subject: [PATCH 4/6] clocksource: bcm_kona: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <37f46a2101da7435343810d9fa94cfae716c377a.1433768426.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate bcm_kona driver to the new 'set-state' interface provided by
the clockevents core, the earlier 'set-mode' interface is marked
obsolete now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/bcm_kona_timer.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index f1e33d08dd83..4efca5f7d443 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -127,25 +127,25 @@ static int kona_timer_set_next_event(unsigned long clc,
 	return 0;
 }
 
-static void kona_timer_set_mode(enum clock_event_mode mode,
-			     struct clock_event_device *unused)
+static int cona_timer_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* by default mode is one shot don't do any thing */
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		kona_timer_disable_and_clear(timers.tmr_regs);
-	}
+	kona_timer_disable_and_clear(timers.tmr_regs);
+	return 0;
+}
+
+static int cona_timer_set_oneshot(struct clock_event_device *evt)
+{
+	/* By default mode is one shot, don't do any thing */
+	return 0;
 }
 
 static struct clock_event_device kona_clockevent_timer = {
 	.name = "timer 1",
 	.features = CLOCK_EVT_FEAT_ONESHOT,
 	.set_next_event = kona_timer_set_next_event,
-	.set_mode = kona_timer_set_mode
+	.set_state_shutdown = cona_timer_shutdown,
+	.set_state_oneshot = cona_timer_set_oneshot,
+	.tick_resume = cona_timer_shutdown,
 };
 
 static void __init kona_timer_clockevents_init(void)
-- 
2.4.0
