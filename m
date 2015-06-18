From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:40 +0530
Subject: [PATCH 26/41] clocksource: time-armada-370-xp: Migrate to new
 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <632796e451d257f8bd5f90f779e866870be02db2.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate time-armada-370-xp driver to the new 'set-state' interface
provided by clockevents core, the earlier 'set-mode' interface is marked
obsolete now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/time-armada-370-xp.c | 53 +++++++++++++++++---------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 0c8c5e337540..2162796fd504 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -121,33 +121,33 @@ armada_370_xp_clkevt_next_event(unsigned long delta,
 	return 0;
 }
 
-static void
-armada_370_xp_clkevt_mode(enum clock_event_mode mode,
-			  struct clock_event_device *dev)
+static int armada_370_xp_clkevt_shutdown(struct clock_event_device *evt)
 {
-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+	/*
+	 * Disable timer.
+	 */
+	local_timer_ctrl_clrset(TIMER0_EN, 0);
 
-		/*
-		 * Setup timer to fire at 1/HZ intervals.
-		 */
-		writel(ticks_per_jiffy - 1, local_base + TIMER0_RELOAD_OFF);
-		writel(ticks_per_jiffy - 1, local_base + TIMER0_VAL_OFF);
+	/*
+	 * ACK pending timer interrupt.
+	 */
+	writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
+	return 0;
+}
 
-		/*
-		 * Enable timer.
-		 */
-		local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
-	} else {
-		/*
-		 * Disable timer.
-		 */
-		local_timer_ctrl_clrset(TIMER0_EN, 0);
+static int armada_370_xp_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	/*
+	 * Setup timer to fire at 1/HZ intervals.
+	 */
+	writel(ticks_per_jiffy - 1, local_base + TIMER0_RELOAD_OFF);
+	writel(ticks_per_jiffy - 1, local_base + TIMER0_VAL_OFF);
 
-		/*
-		 * ACK pending timer interrupt.
-		 */
-		writel(TIMER0_CLR_MASK, local_base + LCL_TIMER_EVENTS_STATUS);
-	}
+	/*
+	 * Enable timer.
+	 */
+	local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
+	return 0;
 }
 
 static int armada_370_xp_clkevt_irq;
@@ -185,7 +185,10 @@ static int armada_370_xp_timer_setup(struct clock_event_device *evt)
 	evt->shift		= 32,
 	evt->rating		= 300,
 	evt->set_next_event	= armada_370_xp_clkevt_next_event,
-	evt->set_mode		= armada_370_xp_clkevt_mode,
+	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
+	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
+	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
+	evt->tick_resume	= armada_370_xp_clkevt_shutdown;
 	evt->irq		= armada_370_xp_clkevt_irq;
 	evt->cpumask		= cpumask_of(cpu);
 
@@ -197,7 +200,7 @@ static int armada_370_xp_timer_setup(struct clock_event_device *evt)
 
 static void armada_370_xp_timer_stop(struct clock_event_device *evt)
 {
-	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 }
 
-- 
2.4.0
