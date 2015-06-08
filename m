From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  8 Jun 2015 19:10:43 +0530
Subject: [PATCH 2/6] clocksource: arm_global_timer: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <54f346e663f605e2f078a3114de85ba281d1e6d0.1433768426.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate arm_global_timer driver to the new 'set-state' interface
provided by the clockevents core, the earlier 'set-mode' interface is
marked obsolete now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/arm_global_timer.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e6833771a716..29ea50ac366a 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -107,26 +107,21 @@ static void gt_compare_set(unsigned long delta, int periodic)
 	writel(ctrl, gt_base + GT_CONTROL);
 }
 
-static void gt_clockevent_set_mode(enum clock_event_mode mode,
-				   struct clock_event_device *clk)
+static int gt_clockevent_shutdown(struct clock_event_device *evt)
 {
 	unsigned long ctrl;
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		gt_compare_set(DIV_ROUND_CLOSEST(gt_clk_rate, HZ), 1);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		ctrl = readl(gt_base + GT_CONTROL);
-		ctrl &= ~(GT_CONTROL_COMP_ENABLE |
-				GT_CONTROL_IRQ_ENABLE | GT_CONTROL_AUTO_INC);
-		writel(ctrl, gt_base + GT_CONTROL);
-		break;
-	default:
-		break;
-	}
+	ctrl = readl(gt_base + GT_CONTROL);
+	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
+		  GT_CONTROL_AUTO_INC);
+	writel(ctrl, gt_base + GT_CONTROL);
+	return 0;
+}
+
+static int gt_clockevent_set_periodic(struct clock_event_device *evt)
+{
+	gt_compare_set(DIV_ROUND_CLOSEST(gt_clk_rate, HZ), 1);
+	return 0;
 }
 
 static int gt_clockevent_set_next_event(unsigned long evt,
@@ -155,7 +150,7 @@ static irqreturn_t gt_clockevent_interrupt(int irq, void *dev_id)
 	 *	the Global Timer flag _after_ having incremented
 	 *	the Comparator register	value to a higher value.
 	 */
-	if (evt->mode == CLOCK_EVT_MODE_ONESHOT)
+	if (clockevent_state_oneshot(evt))
 		gt_compare_set(ULONG_MAX, 0);
 
 	writel_relaxed(GT_INT_STATUS_EVENT_FLAG, gt_base + GT_INT_STATUS);
@@ -171,7 +166,9 @@ static int gt_clockevents_init(struct clock_event_device *clk)
 	clk->name = "arm_global_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 		CLOCK_EVT_FEAT_PERCPU;
-	clk->set_mode = gt_clockevent_set_mode;
+	clk->set_state_shutdown = gt_clockevent_shutdown;
+	clk->set_state_periodic = gt_clockevent_set_periodic;
+	clk->set_state_oneshot = gt_clockevent_shutdown;
 	clk->set_next_event = gt_clockevent_set_next_event;
 	clk->cpumask = cpumask_of(cpu);
 	clk->rating = 300;
@@ -184,7 +181,7 @@ static int gt_clockevents_init(struct clock_event_device *clk)
 
 static void gt_clockevents_stop(struct clock_event_device *clk)
 {
-	gt_clockevent_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+	gt_clockevent_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 }
 
-- 
2.4.0
