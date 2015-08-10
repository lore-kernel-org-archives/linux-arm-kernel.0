From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:52:05 +0200
Subject: [PATCH 48/74] clockevents/drivers/vt8500: Migrate to new 'set-state'
 interface
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-48-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate vt8500 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/vt8500_timer.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index 1098ed3..a92e94b 100644
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
1.9.1
