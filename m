From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:54 +0530
Subject: [PATCH 40/41] clocksource: vt8500: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <e44528fefd0db9e8d716f54eb741f463eb706a44.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate vt8500 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/vt8500_timer.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index 1098ed3b9b89..a92e94b40b5b 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -88,29 +88,20 @@ static int vt8500_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void vt8500_timer_set_mode(enum clock_event_mode mode,
-			      struct clock_event_device *evt)
+static int vt8500_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_RESUME:
-	case CLOCK_EVT_MODE_PERIODIC:
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		writel(readl(regbase + TIMER_CTRL_VAL) | 1,
-			regbase + TIMER_CTRL_VAL);
-		writel(0, regbase + TIMER_IER_VAL);
-		break;
-	}
+	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
+	writel(0, regbase + TIMER_IER_VAL);
+	return 0;
 }
 
 static struct clock_event_device clockevent = {
-	.name           = "vt8500_timer",
-	.features       = CLOCK_EVT_FEAT_ONESHOT,
-	.rating         = 200,
-	.set_next_event = vt8500_timer_set_next_event,
-	.set_mode       = vt8500_timer_set_mode,
+	.name			= "vt8500_timer",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.set_next_event		= vt8500_timer_set_next_event,
+	.set_state_shutdown	= vt8500_shutdown,
+	.set_state_oneshot	= vt8500_shutdown,
 };
 
 static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
