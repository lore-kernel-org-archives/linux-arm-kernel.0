From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:48 +0530
Subject: [PATCH 34/41] clocksource: keystone: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <586b9c3f64a4d84ff4b8e079ad79bce7ab761de8.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate keystone driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Also pass the mode-mask to keystone_timer_config() instead of the mode
as mode macro's aren't valid anymore.

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-keystone.c | 44 +++++++++++++-----------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
index 0250354f7e55..edacf3902e10 100644
--- a/drivers/clocksource/timer-keystone.c
+++ b/drivers/clocksource/timer-keystone.c
@@ -72,10 +72,10 @@ static inline void keystone_timer_barrier(void)
 
 /**
  * keystone_timer_config: configures timer to work in oneshot/periodic modes.
- * @ mode: mode to configure
+ * @ mask: mask of the mode to configure
  * @ period: cycles number to configure for
  */
-static int keystone_timer_config(u64 period, enum clock_event_mode mode)
+static int keystone_timer_config(u64 period, int mask)
 {
 	u32 tcr;
 	u32 off;
@@ -84,16 +84,7 @@ static int keystone_timer_config(u64 period, enum clock_event_mode mode)
 	off = tcr & ~(TCR_ENAMODE_MASK);
 
 	/* set enable mode */
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		tcr |= TCR_ENAMODE_ONESHOT_MASK;
-		break;
-	case CLOCK_EVT_MODE_PERIODIC:
-		tcr |= TCR_ENAMODE_PERIODIC_MASK;
-		break;
-	default:
-		return -1;
-	}
+	tcr |= mask;
 
 	/* disable timer */
 	keystone_timer_writel(off, TCR);
@@ -138,24 +129,19 @@ static irqreturn_t keystone_timer_interrupt(int irq, void *dev_id)
 static int keystone_set_next_event(unsigned long cycles,
 				  struct clock_event_device *evt)
 {
-	return keystone_timer_config(cycles, evt->mode);
+	return keystone_timer_config(cycles, TCR_ENAMODE_ONESHOT_MASK);
 }
 
-static void keystone_set_mode(enum clock_event_mode mode,
-			     struct clock_event_device *evt)
+static int keystone_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		keystone_timer_config(timer.hz_period, CLOCK_EVT_MODE_PERIODIC);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_ONESHOT:
-		keystone_timer_disable();
-		break;
-	default:
-		break;
-	}
+	keystone_timer_disable();
+	return 0;
+}
+
+static int keystone_set_periodic(struct clock_event_device *evt)
+{
+	keystone_timer_config(timer.hz_period, TCR_ENAMODE_PERIODIC_MASK);
+	return 0;
 }
 
 static void __init keystone_timer_init(struct device_node *np)
@@ -222,7 +208,9 @@ static void __init keystone_timer_init(struct device_node *np)
 	/* setup clockevent */
 	event_dev->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	event_dev->set_next_event = keystone_set_next_event;
-	event_dev->set_mode = keystone_set_mode;
+	event_dev->set_state_shutdown = keystone_shutdown;
+	event_dev->set_state_periodic = keystone_set_periodic;
+	event_dev->set_state_oneshot = keystone_shutdown;
 	event_dev->cpumask = cpu_all_mask;
 	event_dev->owner = THIS_MODULE;
 	event_dev->name = TIMER_NAME;
-- 
2.4.0
