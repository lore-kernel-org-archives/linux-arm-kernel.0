From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:47 +0530
Subject: [PATCH 33/41] clocksource: integrator: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <5e78d6f43d81c4f08939a7a6a585be019a1f2e1f.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate integrator driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

For oneshot mode the clkevt device was first getting disabled by
clearing TIMER_CTRL_ENABLE bits in TIMER_CTRL register, followed by
clearing TIMER_CTRL_PERIODIC bit. Both these are done with a single
write operation now.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-integrator-ap.c | 58 ++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index c97d1980c0f8..5b8fb32c1541 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -74,33 +74,37 @@ static irqreturn_t integrator_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void clkevt_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+static int clkevt_shutdown(struct clock_event_device *evt)
 {
 	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
 
 	/* Disable timer */
 	writel(ctrl, clkevt_base + TIMER_CTRL);
+	return 0;
+}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* Enable the timer and start the periodic tick */
-		writel(timer_reload, clkevt_base + TIMER_LOAD);
-		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
-		writel(ctrl, clkevt_base + TIMER_CTRL);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Leave the timer disabled, .set_next_event will enable it */
-		ctrl &= ~TIMER_CTRL_PERIODIC;
-		writel(ctrl, clkevt_base + TIMER_CTRL);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-	default:
-		/* Just leave in disabled state */
-		break;
-	}
+static int clkevt_set_oneshot(struct clock_event_device *evt)
+{
+	u32 ctrl = readl(clkevt_base + TIMER_CTRL) &
+		   ~(TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC);
+
+	/* Leave the timer disabled, .set_next_event will enable it */
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+	return 0;
+}
 
+static int clkevt_set_periodic(struct clock_event_device *evt)
+{
+	u32 ctrl = readl(clkevt_base + TIMER_CTRL) & ~TIMER_CTRL_ENABLE;
+
+	/* Disable timer */
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+
+	/* Enable the timer and start the periodic tick */
+	writel(timer_reload, clkevt_base + TIMER_LOAD);
+	ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+	return 0;
 }
 
 static int clkevt_set_next_event(unsigned long next, struct clock_event_device *evt)
@@ -115,11 +119,15 @@ static int clkevt_set_next_event(unsigned long next, struct clock_event_device *
 }
 
 static struct clock_event_device integrator_clockevent = {
-	.name		= "timer1",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= clkevt_set_mode,
-	.set_next_event	= clkevt_set_next_event,
-	.rating		= 300,
+	.name			= "timer1",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= clkevt_shutdown,
+	.set_state_periodic	= clkevt_set_periodic,
+	.set_state_oneshot	= clkevt_set_oneshot,
+	.tick_resume		= clkevt_shutdown,
+	.set_next_event		= clkevt_set_next_event,
+	.rating			= 300,
 };
 
 static struct irqaction integrator_timer_irq = {
-- 
2.4.0
