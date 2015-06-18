From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:41 +0530
Subject: [PATCH 27/41] clocksource: efm32: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <9f1d1bd65917023c427a1dd4951a434ea8aef54b.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate efm32 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

There is nothing to be done for resume state and so isn't implemented.

Cc: Uwe Kleine-K?nig <kernel@pengutronix.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/time-efm32.c | 66 +++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index 5b6e3d5644c9..b06e4c2be406 100644
--- a/drivers/clocksource/time-efm32.c
+++ b/drivers/clocksource/time-efm32.c
@@ -48,40 +48,42 @@ struct efm32_clock_event_ddata {
 	unsigned periodic_top;
 };
 
-static void efm32_clock_event_set_mode(enum clock_event_mode mode,
-				       struct clock_event_device *evtdev)
+static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
 {
 	struct efm32_clock_event_ddata *ddata =
 		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-		writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
-		writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-			       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-			       TIMERn_CTRL_MODE_DOWN,
-			       ddata->base + TIMERn_CTRL);
-		writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-		writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-			       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-			       TIMERn_CTRL_OSMEN |
-			       TIMERn_CTRL_MODE_DOWN,
-			       ddata->base + TIMERn_CTRL);
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-		break;
-
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	return 0;
+}
+
+static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_OSMEN |
+		       TIMERn_CTRL_MODE_DOWN,
+		       ddata->base + TIMERn_CTRL);
+	return 0;
+}
+
+static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+		       TIMERn_CTRL_MODE_DOWN,
+		       ddata->base + TIMERn_CTRL);
+	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
+	return 0;
 }
 
 static int efm32_clock_event_set_next_event(unsigned long evt,
@@ -112,7 +114,9 @@ static struct efm32_clock_event_ddata clock_event_ddata = {
 	.evtdev = {
 		.name = "efm32 clockevent",
 		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_mode = efm32_clock_event_set_mode,
+		.set_state_shutdown = efm32_clock_event_shutdown,
+		.set_state_periodic = efm32_clock_event_set_periodic,
+		.set_state_oneshot = efm32_clock_event_set_oneshot,
 		.set_next_event = efm32_clock_event_set_next_event,
 		.rating = 200,
 	},
-- 
2.4.0
