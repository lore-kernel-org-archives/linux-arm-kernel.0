From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:23 +0530
Subject: [PATCH 09/41] clocksource: meson6: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <31c070cb211232dbe5f03f7afa62ac27d65481ba.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate meson6 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Carlo Caione <carlo@caione.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/meson6_timer.c | 50 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 5c15cba41dca..1fa22c4d2d49 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -67,25 +67,25 @@ static void meson6_clkevt_time_start(unsigned char timer, bool periodic)
 	writel(val | TIMER_ENABLE_BIT(timer), timer_base + TIMER_ISA_MUX);
 }
 
-static void meson6_clkevt_mode(enum clock_event_mode mode,
-			       struct clock_event_device *clk)
+static int meson6_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		meson6_clkevt_time_stop(CED_ID);
-		meson6_clkevt_time_setup(CED_ID, USEC_PER_SEC/HZ - 1);
-		meson6_clkevt_time_start(CED_ID, true);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		meson6_clkevt_time_stop(CED_ID);
-		meson6_clkevt_time_start(CED_ID, false);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		meson6_clkevt_time_stop(CED_ID);
-		break;
-	}
+	meson6_clkevt_time_stop(CED_ID);
+	return 0;
+}
+
+static int meson6_set_oneshot(struct clock_event_device *evt)
+{
+	meson6_clkevt_time_stop(CED_ID);
+	meson6_clkevt_time_start(CED_ID, false);
+	return 0;
+}
+
+static int meson6_set_periodic(struct clock_event_device *evt)
+{
+	meson6_clkevt_time_stop(CED_ID);
+	meson6_clkevt_time_setup(CED_ID, USEC_PER_SEC / HZ - 1);
+	meson6_clkevt_time_start(CED_ID, true);
+	return 0;
 }
 
 static int meson6_clkevt_next_event(unsigned long evt,
@@ -99,11 +99,15 @@ static int meson6_clkevt_next_event(unsigned long evt,
 }
 
 static struct clock_event_device meson6_clockevent = {
-	.name		= "meson6_tick",
-	.rating		= 400,
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= meson6_clkevt_mode,
-	.set_next_event	= meson6_clkevt_next_event,
+	.name			= "meson6_tick",
+	.rating			= 400,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= meson6_shutdown,
+	.set_state_periodic	= meson6_set_periodic,
+	.set_state_oneshot	= meson6_set_oneshot,
+	.tick_resume		= meson6_shutdown,
+	.set_next_event		= meson6_clkevt_next_event,
 };
 
 static irqreturn_t meson6_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
