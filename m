From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:51:29 +0200
Subject: [PATCH 12/74] clockevents/drivers/cadence_ttc: Migrate to new
 'set-state' interface
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-12-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate cadence_ttc driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clocksource/cadence_ttc_timer.c | 59 ++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 510c8a1..e47e0e0 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -191,40 +191,42 @@ static int ttc_set_next_event(unsigned long cycles,
 }
 
 /**
- * ttc_set_mode - Sets the mode of timer
+ * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
  *
- * @mode:	Mode to be set
  * @evt:	Address of clock event instance
  **/
-static void ttc_set_mode(enum clock_event_mode mode,
-					struct clock_event_device *evt)
+static int ttc_shutdown(struct clock_event_device *evt)
 {
 	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
 	struct ttc_timer *timer = &ttce->ttc;
 	u32 ctrl_reg;
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		ttc_set_interval(timer, DIV_ROUND_CLOSEST(ttce->ttc.freq,
-						PRESCALE * HZ));
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		ctrl_reg = readl_relaxed(timer->base_addr +
-					TTC_CNT_CNTRL_OFFSET);
-		ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
-		writel_relaxed(ctrl_reg,
-				timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		ctrl_reg = readl_relaxed(timer->base_addr +
-					TTC_CNT_CNTRL_OFFSET);
-		ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
-		writel_relaxed(ctrl_reg,
-				timer->base_addr + TTC_CNT_CNTRL_OFFSET);
-		break;
-	}
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	return 0;
+}
+
+static int ttc_set_periodic(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+
+	ttc_set_interval(timer,
+			 DIV_ROUND_CLOSEST(ttce->ttc.freq, PRESCALE * HZ));
+	return 0;
+}
+
+static int ttc_resume(struct clock_event_device *evt)
+{
+	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
+	struct ttc_timer *timer = &ttce->ttc;
+	u32 ctrl_reg;
+
+	ctrl_reg = readl_relaxed(timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg &= ~TTC_CNT_CNTRL_DISABLE_MASK;
+	writel_relaxed(ctrl_reg, timer->base_addr + TTC_CNT_CNTRL_OFFSET);
+	return 0;
 }
 
 static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
@@ -430,7 +432,10 @@ static void __init ttc_setup_clockevent(struct clk *clk,
 	ttcce->ce.name = "ttc_clockevent";
 	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ttcce->ce.set_next_event = ttc_set_next_event;
-	ttcce->ce.set_mode = ttc_set_mode;
+	ttcce->ce.set_state_shutdown = ttc_shutdown;
+	ttcce->ce.set_state_periodic = ttc_set_periodic;
+	ttcce->ce.set_state_oneshot = ttc_shutdown;
+	ttcce->ce.tick_resume = ttc_resume;
 	ttcce->ce.rating = 200;
 	ttcce->ce.irq = irq;
 	ttcce->ce.cpumask = cpu_possible_mask;
-- 
1.9.1
