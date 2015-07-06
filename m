From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 15:39:18 +0530
Subject: [PATCH 1/2] clockevents/drivers/timer-imx-gpt: Migrate to new
 'set-state' interface
In-Reply-To: <cover.1436177111.git.viresh.kumar@linaro.org>
References: <cover.1436177111.git.viresh.kumar@linaro.org>
Message-ID: <e9e1301d9f4ec32949260f507369012a3ed60fef.1436177111.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate timer-imx-gpt driver to the new 'set-state' interface provided
by clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Also drop:
- 'imx_timer.cem': It was caching the last state of the clockevent
  device. The same behavior can be achieved by using clockevents state
  helpers. These helpers are only required for oneshot mode as
  shutdown/resume wouldn't be done twice by the core.

- 'clock_event_mode_label': CLOCK_EVT_MODE_* shouldn't be used anymore
  by drivers. The prints are modified to print the set-state functions
  name now to debug the driver.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-imx-gpt.c | 75 +++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 879c78423546..5a3ccb7f914f 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -83,7 +83,6 @@ struct imx_timer {
 	struct clk *clk_ipg;
 	const struct imx_gpt_data *gpt;
 	struct clock_event_device ced;
-	enum clock_event_mode cem;
 	struct irqaction act;
 };
 
@@ -212,18 +211,38 @@ static int v2_set_next_event(unsigned long evt,
 				-ETIME : 0;
 }
 
+static int mxc_shutdown(struct clock_event_device *ced)
+{
+	struct imx_timer *imxtm = to_imx_timer(ced);
+	unsigned long flags;
+	u32 tcn;
+
+	/*
+	 * The timer interrupt generation is disabled at least
+	 * for enough time to call mxc_set_next_event()
+	 */
+	local_irq_save(flags);
+
+	/* Disable interrupt in GPT module */
+	imxtm->gpt->gpt_irq_disable(imxtm);
+
+	tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
+	/* Set event time into far-far future */
+	writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
+
+	/* Clear pending interrupt */
+	imxtm->gpt->gpt_irq_acknowledge(imxtm);
+
 #ifdef DEBUG
-static const char *clock_event_mode_label[] = {
-	[CLOCK_EVT_MODE_PERIODIC] = "CLOCK_EVT_MODE_PERIODIC",
-	[CLOCK_EVT_MODE_ONESHOT]  = "CLOCK_EVT_MODE_ONESHOT",
-	[CLOCK_EVT_MODE_SHUTDOWN] = "CLOCK_EVT_MODE_SHUTDOWN",
-	[CLOCK_EVT_MODE_UNUSED]   = "CLOCK_EVT_MODE_UNUSED",
-	[CLOCK_EVT_MODE_RESUME]   = "CLOCK_EVT_MODE_RESUME",
-};
+	printk(KERN_INFO "%s: changing mode\n", __func__);
 #endif /* DEBUG */
 
-static void mxc_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *ced)
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int mxc_set_oneshot(struct clock_event_device *ced)
 {
 	struct imx_timer *imxtm = to_imx_timer(ced);
 	unsigned long flags;
@@ -237,7 +256,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	/* Disable interrupt in GPT module */
 	imxtm->gpt->gpt_irq_disable(imxtm);
 
-	if (mode != imxtm->cem) {
+	if (!clockevent_state_oneshot(ced)) {
 		u32 tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
 		/* Set event time into far-far future */
 		writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
@@ -247,37 +266,19 @@ static void mxc_set_mode(enum clock_event_mode mode,
 	}
 
 #ifdef DEBUG
-	printk(KERN_INFO "mxc_set_mode: changing mode from %s to %s\n",
-		clock_event_mode_label[imxtm->cem],
-		clock_event_mode_label[mode]);
+	printk(KERN_INFO "%s: changing mode\n", __func__);
 #endif /* DEBUG */
 
-	/* Remember timer mode */
-	imxtm->cem = mode;
-	local_irq_restore(flags);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		printk(KERN_ERR"mxc_set_mode: Periodic mode is not "
-				"supported for i.MX\n");
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
 	/*
 	 * Do not put overhead of interrupt enable/disable into
 	 * mxc_set_next_event(), the core has about 4 minutes
 	 * to call mxc_set_next_event() or shutdown clock after
 	 * mode switching
 	 */
-		local_irq_save(flags);
-		imxtm->gpt->gpt_irq_enable(imxtm);
-		local_irq_restore(flags);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_RESUME:
-		/* Left event sources disabled, no more interrupts appear */
-		break;
-	}
+	imxtm->gpt->gpt_irq_enable(imxtm);
+	local_irq_restore(flags);
+
+	return 0;
 }
 
 /*
@@ -303,11 +304,11 @@ static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 	struct clock_event_device *ced = &imxtm->ced;
 	struct irqaction *act = &imxtm->act;
 
-	imxtm->cem = CLOCK_EVT_MODE_UNUSED;
-
 	ced->name = "mxc_timer1";
 	ced->features = CLOCK_EVT_FEAT_ONESHOT;
-	ced->set_mode = mxc_set_mode;
+	ced->set_state_shutdown = mxc_shutdown;
+	ced->set_state_oneshot = mxc_set_oneshot;
+	ced->tick_resume = mxc_shutdown;
 	ced->set_next_event = imxtm->gpt->set_next_event;
 	ced->rating = 200;
 	ced->cpumask = cpumask_of(0);
-- 
2.4.0
