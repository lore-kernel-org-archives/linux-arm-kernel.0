From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  8 Jun 2015 19:10:47 +0530
Subject: [PATCH 6/6] clocksource: em_sti: Migrate to new 'set-state' interface
In-Reply-To: <cover.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <a2be865369ac18c3fb9e014514f4be4d6fc9ebae.1433768426.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate em_sti driver to the new 'set-state' interface provided by
the clockevents core, the earlier 'set-mode' interface is marked
obsolete now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

NOTE: This also drops a special check:

	if (old_mode == CLOCK_EVT_MODE_ONESHOT)
		em_sti_stop(p, USER_CLOCKEVENT);

as it doesn't look like that important. This driver only supports
ONESHOT and we can only move only to SHUTDOWN from ONESHOT and.
Also on second call (on shutdown), em_sti_stop() would return without
disabling the device again.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/em_sti.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index dc3c6ee04aaa..7a97a34dba70 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -251,33 +251,21 @@ static struct em_sti_priv *ced_to_em_sti(struct clock_event_device *ced)
 	return container_of(ced, struct em_sti_priv, ced);
 }
 
-static void em_sti_clock_event_mode(enum clock_event_mode mode,
-				    struct clock_event_device *ced)
+static int em_sti_clock_event_shutdown(struct clock_event_device *ced)
 {
 	struct em_sti_priv *p = ced_to_em_sti(ced);
+	em_sti_stop(p, USER_CLOCKEVENT);
+	return 0;
+}
 
-	/* deal with old setting first */
-	switch (ced->mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		em_sti_stop(p, USER_CLOCKEVENT);
-		break;
-	default:
-		break;
-	}
+static int em_sti_clock_event_set_oneshot(struct clock_event_device *ced)
+{
+	struct em_sti_priv *p = ced_to_em_sti(ced);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		dev_info(&p->pdev->dev, "used for oneshot clock events\n");
-		em_sti_start(p, USER_CLOCKEVENT);
-		clockevents_config(&p->ced, p->rate);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		em_sti_stop(p, USER_CLOCKEVENT);
-		break;
-	default:
-		break;
-	}
+	dev_info(&p->pdev->dev, "used for oneshot clock events\n");
+	em_sti_start(p, USER_CLOCKEVENT);
+	clockevents_config(&p->ced, p->rate);
+	return 0;
 }
 
 static int em_sti_clock_event_next(unsigned long delta,
@@ -303,11 +291,12 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 	ced->rating = 200;
 	ced->cpumask = cpu_possible_mask;
 	ced->set_next_event = em_sti_clock_event_next;
-	ced->set_mode = em_sti_clock_event_mode;
+	ced->set_state_shutdown = em_sti_clock_event_shutdown;
+	ced->set_state_oneshot = em_sti_clock_event_set_oneshot;
 
 	dev_info(&p->pdev->dev, "used for clock events\n");
 
-	/* Register with dummy 1 Hz value, gets updated in ->set_mode() */
+	/* Register with dummy 1 Hz value, gets updated in ->set_state_oneshot() */
 	clockevents_config_and_register(ced, 1, 2, 0xffffffff);
 }
 
-- 
2.4.0
