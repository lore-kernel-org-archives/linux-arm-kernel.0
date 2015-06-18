From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:34 +0530
Subject: [PATCH 20/41] clocksource: sh_cmt: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <0be5c5579b47ca1f774a89ca2388a3e9389253d1.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate sh_cmt driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index b8ff3c64cc45..855f42a2c64b 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -538,7 +538,7 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	if (ch->flags & FLAG_CLOCKEVENT) {
 		if (!(ch->flags & FLAG_SKIPEVENT)) {
-			if (ch->ced.mode == CLOCK_EVT_MODE_ONESHOT) {
+			if (clockevent_state_oneshot(&ch->ced)) {
 				ch->next_match_value = ch->max_match_value;
 				ch->flags |= FLAG_REPROGRAM;
 			}
@@ -554,7 +554,7 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 		sh_cmt_clock_event_program_verify(ch, 1);
 
 		if (ch->flags & FLAG_CLOCKEVENT)
-			if ((ch->ced.mode == CLOCK_EVT_MODE_SHUTDOWN)
+			if ((clockevent_state_shutdown(&ch->ced))
 			    || (ch->match_value == ch->next_match_value))
 				ch->flags &= ~FLAG_REPROGRAM;
 	}
@@ -720,39 +720,37 @@ static void sh_cmt_clock_event_start(struct sh_cmt_channel *ch, int periodic)
 		sh_cmt_set_next(ch, ch->max_match_value);
 }
 
-static void sh_cmt_clock_event_mode(enum clock_event_mode mode,
-				    struct clock_event_device *ced)
+static int sh_cmt_clock_event_shutdown(struct clock_event_device *ced)
+{
+	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
+
+	sh_cmt_stop(ch, FLAG_CLOCKEVENT);
+	return 0;
+}
+
+static int sh_cmt_clock_event_set_state(struct clock_event_device *ced,
+					int periodic)
 {
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
 
 	/* deal with old setting first */
-	switch (ced->mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-	case CLOCK_EVT_MODE_ONESHOT:
+	if (clockevent_state_oneshot(ced) || clockevent_state_periodic(ced))
 		sh_cmt_stop(ch, FLAG_CLOCKEVENT);
-		break;
-	default:
-		break;
-	}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		dev_info(&ch->cmt->pdev->dev,
-			 "ch%u: used for periodic clock events\n", ch->index);
-		sh_cmt_clock_event_start(ch, 1);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		dev_info(&ch->cmt->pdev->dev,
-			 "ch%u: used for oneshot clock events\n", ch->index);
-		sh_cmt_clock_event_start(ch, 0);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		sh_cmt_stop(ch, FLAG_CLOCKEVENT);
-		break;
-	default:
-		break;
-	}
+	dev_info(&ch->cmt->pdev->dev, "ch%u: used for %s clock events\n",
+		 ch->index, periodic ? "periodic" : "oneshot");
+	sh_cmt_clock_event_start(ch, periodic);
+	return 0;
+}
+
+static int sh_cmt_clock_event_set_oneshot(struct clock_event_device *ced)
+{
+	return sh_cmt_clock_event_set_state(ced, 0);
+}
+
+static int sh_cmt_clock_event_set_periodic(struct clock_event_device *ced)
+{
+	return sh_cmt_clock_event_set_state(ced, 1);
 }
 
 static int sh_cmt_clock_event_next(unsigned long delta,
@@ -760,7 +758,7 @@ static int sh_cmt_clock_event_next(unsigned long delta,
 {
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
 
-	BUG_ON(ced->mode != CLOCK_EVT_MODE_ONESHOT);
+	BUG_ON(!clockevent_state_oneshot(ced));
 	if (likely(ch->flags & FLAG_IRQCONTEXT))
 		ch->next_match_value = delta - 1;
 	else
@@ -814,7 +812,9 @@ static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	ced->rating = 125;
 	ced->cpumask = cpu_possible_mask;
 	ced->set_next_event = sh_cmt_clock_event_next;
-	ced->set_mode = sh_cmt_clock_event_mode;
+	ced->set_state_shutdown = sh_cmt_clock_event_shutdown;
+	ced->set_state_periodic = sh_cmt_clock_event_set_periodic;
+	ced->set_state_oneshot = sh_cmt_clock_event_set_oneshot;
 	ced->suspend = sh_cmt_clock_event_suspend;
 	ced->resume = sh_cmt_clock_event_resume;
 
-- 
2.4.0
