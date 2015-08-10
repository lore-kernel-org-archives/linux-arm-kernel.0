From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:52:00 +0200
Subject: [PATCH 43/74] clockevents/drivers/prima2: Migrate to new 'set-state'
 interface
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-43-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate prima2 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-prima2.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index ce18d57..78de982 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -104,26 +104,21 @@ static int sirfsoc_timer_set_next_event(unsigned long delta,
 	return next - now > delta ? -ETIME : 0;
 }
 
-static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *ce)
+static int sirfsoc_timer_shutdown(struct clock_event_device *evt)
 {
 	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		WARN_ON(1);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		writel_relaxed(val | BIT(0),
-			sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		writel_relaxed(val & ~BIT(0),
-			sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+
+	writel_relaxed(val & ~BIT(0),
+		       sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+	return 0;
+}
+
+static int sirfsoc_timer_set_oneshot(struct clock_event_device *evt)
+{
+	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+
+	writel_relaxed(val | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+	return 0;
 }
 
 static void sirfsoc_clocksource_suspend(struct clocksource *cs)
@@ -157,7 +152,8 @@ static struct clock_event_device sirfsoc_clockevent = {
 	.name = "sirfsoc_clockevent",
 	.rating = 200,
 	.features = CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode = sirfsoc_timer_set_mode,
+	.set_state_shutdown = sirfsoc_timer_shutdown,
+	.set_state_oneshot = sirfsoc_timer_set_oneshot,
 	.set_next_event = sirfsoc_timer_set_next_event,
 };
 
-- 
1.9.1
