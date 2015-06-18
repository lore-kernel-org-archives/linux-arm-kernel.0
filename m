From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:55 +0530
Subject: [PATCH 41/41] clocksource: zevio: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <2492473d6bb8f057af389d6db24af77462af2468.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate zevio driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Daniel Tang <dt.tangr@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/zevio-timer.c | 44 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index 7ce442148c3f..ceaa6133f9c2 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -76,32 +76,28 @@ static int zevio_timer_set_event(unsigned long delta,
 	return 0;
 }
 
-static void zevio_timer_set_mode(enum clock_event_mode mode,
-				 struct clock_event_device *dev)
+static int zevio_timer_shutdown(struct clock_event_device *dev)
 {
 	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
 						 clkevt);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_RESUME:
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Enable timer interrupts */
-		writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
-		writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		/* Disable timer interrupts */
-		writel(0, timer->interrupt_regs + IO_INTR_MSK);
-		writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-		/* Stop timer */
-		writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
-		break;
-	case CLOCK_EVT_MODE_PERIODIC:
-	default:
-		/* Unsupported */
-		break;
-	}
+	/* Disable timer interrupts */
+	writel(0, timer->interrupt_regs + IO_INTR_MSK);
+	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+	/* Stop timer */
+	writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
+	return 0;
+}
+
+static int zevio_timer_set_oneshot(struct clock_event_device *dev)
+{
+	struct zevio_timer *timer = container_of(dev, struct zevio_timer,
+						 clkevt);
+
+	/* Enable timer interrupts */
+	writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
+	writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
+	return 0;
 }
 
 static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
@@ -162,7 +158,9 @@ static int __init zevio_timer_add(struct device_node *node)
 	if (timer->interrupt_regs && irqnr) {
 		timer->clkevt.name		= timer->clockevent_name;
 		timer->clkevt.set_next_event	= zevio_timer_set_event;
-		timer->clkevt.set_mode		= zevio_timer_set_mode;
+		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
+		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
+		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
 		timer->clkevt.rating		= 200;
 		timer->clkevt.cpumask		= cpu_all_mask;
 		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
-- 
2.4.0
