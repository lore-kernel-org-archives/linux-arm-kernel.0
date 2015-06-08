From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  8 Jun 2015 19:10:46 +0530
Subject: [PATCH 5/6] clocksource: cs5535: Migrate to new 'set-state' interface
In-Reply-To: <cover.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <9ea6d10fe6578199584a3a3620da9cb6db481a2d.1433768426.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate cs5535 driver to the new 'set-state' interface provided by
the clockevents core, the earlier 'set-mode' interface is marked
obsolete now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Andres Salomon <dilinger@queued.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/cs5535-clockevt.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/cs5535-clockevt.c b/drivers/clocksource/cs5535-clockevt.c
index db2105290898..9a7e37cf56b0 100644
--- a/drivers/clocksource/cs5535-clockevt.c
+++ b/drivers/clocksource/cs5535-clockevt.c
@@ -42,7 +42,6 @@ MODULE_PARM_DESC(irq, "Which IRQ to use for the clock source MFGPT ticks.");
  *  256         128   .125            512.000
  */
 
-static unsigned int cs5535_tick_mode = CLOCK_EVT_MODE_SHUTDOWN;
 static struct cs5535_mfgpt_timer *cs5535_event_clock;
 
 /* Selected from the table above */
@@ -77,15 +76,17 @@ static void start_timer(struct cs5535_mfgpt_timer *timer, uint16_t delta)
 			MFGPT_SETUP_CNTEN | MFGPT_SETUP_CMP2);
 }
 
-static void mfgpt_set_mode(enum clock_event_mode mode,
-		struct clock_event_device *evt)
+static int mfgpt_shutdown(struct clock_event_device *evt)
 {
 	disable_timer(cs5535_event_clock);
+	return 0;
+}
 
-	if (mode == CLOCK_EVT_MODE_PERIODIC)
-		start_timer(cs5535_event_clock, MFGPT_PERIODIC);
-
-	cs5535_tick_mode = mode;
+static int mfgpt_set_periodic(struct clock_event_device *evt)
+{
+	disable_timer(cs5535_event_clock);
+	start_timer(cs5535_event_clock, MFGPT_PERIODIC);
+	return 0;
 }
 
 static int mfgpt_next_event(unsigned long delta, struct clock_event_device *evt)
@@ -97,7 +98,10 @@ static int mfgpt_next_event(unsigned long delta, struct clock_event_device *evt)
 static struct clock_event_device cs5535_clockevent = {
 	.name = DRV_NAME,
 	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode = mfgpt_set_mode,
+	.set_state_shutdown = mfgpt_shutdown,
+	.set_state_periodic = mfgpt_set_periodic,
+	.set_state_oneshot = mfgpt_shutdown,
+	.tick_resume = mfgpt_shutdown,
 	.set_next_event = mfgpt_next_event,
 	.rating = 250,
 };
@@ -113,7 +117,7 @@ static irqreturn_t mfgpt_tick(int irq, void *dev_id)
 	/* Turn off the clock (and clear the event) */
 	disable_timer(cs5535_event_clock);
 
-	if (cs5535_tick_mode == CLOCK_EVT_MODE_SHUTDOWN)
+	if (clockevent_state_shutdown(&cs5535_clockevent))
 		return IRQ_HANDLED;
 
 	/* Clear the counter */
@@ -121,7 +125,7 @@ static irqreturn_t mfgpt_tick(int irq, void *dev_id)
 
 	/* Restart the clock in periodic mode */
 
-	if (cs5535_tick_mode == CLOCK_EVT_MODE_PERIODIC)
+	if (clockevent_state_periodic(&cs5535_clockevent))
 		cs5535_mfgpt_write(cs5535_event_clock, MFGPT_REG_SETUP,
 				MFGPT_SETUP_CNTEN | MFGPT_SETUP_CMP2);
 
-- 
2.4.0
