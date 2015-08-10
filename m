From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:51:19 +0200
Subject: [PATCH 02/74] clockevents/drivers/arm_global_timer: Migrate to new
 'set-state' interface
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate arm_global_timer driver to the new 'set-state' interface
provided by the clockevents core, the earlier 'set-mode' interface is
marked obsolete now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_global_timer.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e683377..29ea50a 100644
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
1.9.1
