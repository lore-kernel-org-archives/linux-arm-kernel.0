From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:28 +0530
Subject: [PATCH 14/41] clocksource: mxs: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <5505013f2020eef13aa55f7d748f79e344ce6c69.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate mxs driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Also drop:
- 'mxs_clockevent_mode': as we have helpers available from core for the
  same.
  same state twice and so perhaps the check wasn't required.
- 'clock_event_mode_label': CLOCK_EVT_MODE_* shouldn't be used anymore
  by drivers and it was used just to print old-state:new-state. The
  debug prints are called from mxs_irq_clear() now based on the
  state-name passed to it. The printed name will be same for shutdown
  and resume states as they use the same callback pointer.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
@Shawn: Please let me know if you want to print "resume" for resume
state, as that will require a separate callback for resume state, just
to print the name correctly. I thought it might not be worth enough :)
---
 drivers/clocksource/mxs_timer.c | 80 +++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 48 deletions(-)

diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index 445b68a01dc5..f5ce2961c0d6 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -77,7 +77,6 @@
 #define BV_TIMROTv2_TIMCTRLn_SELECT__TICK_ALWAYS	0xf
 
 static struct clock_event_device mxs_clockevent_device;
-static enum clock_event_mode mxs_clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
 static void __iomem *mxs_timrot_base;
 static u32 timrot_major_version;
@@ -141,64 +140,49 @@ static struct irqaction mxs_timer_irq = {
 	.handler	= mxs_timer_interrupt,
 };
 
-#ifdef DEBUG
-static const char *clock_event_mode_label[] const = {
-	[CLOCK_EVT_MODE_PERIODIC] = "CLOCK_EVT_MODE_PERIODIC",
-	[CLOCK_EVT_MODE_ONESHOT]  = "CLOCK_EVT_MODE_ONESHOT",
-	[CLOCK_EVT_MODE_SHUTDOWN] = "CLOCK_EVT_MODE_SHUTDOWN",
-	[CLOCK_EVT_MODE_UNUSED]   = "CLOCK_EVT_MODE_UNUSED"
-};
-#endif /* DEBUG */
-
-static void mxs_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+static void mxs_irq_clear(char *state)
 {
 	/* Disable interrupt in timer module */
 	timrot_irq_disable();
 
-	if (mode != mxs_clockevent_mode) {
-		/* Set event time into the furthest future */
-		if (timrot_is_v1())
-			__raw_writel(0xffff,
-				mxs_timrot_base + HW_TIMROT_TIMCOUNTn(1));
-		else
-			__raw_writel(0xffffffff,
-				mxs_timrot_base + HW_TIMROT_FIXED_COUNTn(1));
-
-		/* Clear pending interrupt */
-		timrot_irq_acknowledge();
-	}
+	/* Set event time into the furthest future */
+	if (timrot_is_v1())
+		__raw_writel(0xffff, mxs_timrot_base + HW_TIMROT_TIMCOUNTn(1));
+	else
+		__raw_writel(0xffffffff,
+			     mxs_timrot_base + HW_TIMROT_FIXED_COUNTn(1));
+
+	/* Clear pending interrupt */
+	timrot_irq_acknowledge();
 
 #ifdef DEBUG
-	pr_info("%s: changing mode from %s to %s\n", __func__,
-		clock_event_mode_label[mxs_clockevent_mode],
-		clock_event_mode_label[mode]);
+	pr_info("%s: changing mode to %s\n", __func__, state)
 #endif /* DEBUG */
+}
 
-	/* Remember timer mode */
-	mxs_clockevent_mode = mode;
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		pr_err("%s: Periodic mode is not implemented\n", __func__);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		timrot_irq_enable();
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_RESUME:
-		/* Left event sources disabled, no more interrupts appear */
-		break;
-	}
+static int mxs_shutdown(struct clock_event_device *evt)
+{
+	mxs_irq_clear("shutdown");
+
+	return 0;
+}
+
+static int mxs_set_oneshot(struct clock_event_device *evt)
+{
+	if (clockevent_state_oneshot(evt))
+		mxs_irq_clear("oneshot");
+	timrot_irq_enable();
+	return 0;
 }
 
 static struct clock_event_device mxs_clockevent_device = {
-	.name		= "mxs_timrot",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= mxs_set_mode,
-	.set_next_event	= timrotv2_set_next_event,
-	.rating		= 200,
+	.name			= "mxs_timrot",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= mxs_shutdown,
+	.set_state_oneshot	= mxs_set_oneshot,
+	.tick_resume		= mxs_shutdown,
+	.set_next_event		= timrotv2_set_next_event,
+	.rating			= 200,
 };
 
 static int __init mxs_clockevent_init(struct clk *timer_clk)
-- 
2.4.0
