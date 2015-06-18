From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:26 +0530
Subject: [PATCH 12/41] clocksource: moxart: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <8a06c6c0fd6fbb4150ef9313af74d7ed81451910.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate moxart driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/moxart_timer.c | 49 ++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
index 5eb2c35932b1..19857af651c1 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -58,25 +58,24 @@
 static void __iomem *base;
 static unsigned int clock_count_per_tick;
 
-static void moxart_clkevt_mode(enum clock_event_mode mode,
-			       struct clock_event_device *clk)
+static int moxart_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_RESUME:
-	case CLOCK_EVT_MODE_ONESHOT:
-		writel(TIMER1_DISABLE, base + TIMER_CR);
-		writel(~0, base + TIMER1_BASE + REG_LOAD);
-		break;
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(clock_count_per_tick, base + TIMER1_BASE + REG_LOAD);
-		writel(TIMER1_ENABLE, base + TIMER_CR);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		writel(TIMER1_DISABLE, base + TIMER_CR);
-		break;
-	}
+	writel(TIMER1_DISABLE, base + TIMER_CR);
+	return 0;
+}
+
+static int moxart_set_oneshot(struct clock_event_device *evt)
+{
+	writel(TIMER1_DISABLE, base + TIMER_CR);
+	writel(~0, base + TIMER1_BASE + REG_LOAD);
+	return 0;
+}
+
+static int moxart_set_periodic(struct clock_event_device *evt)
+{
+	writel(clock_count_per_tick, base + TIMER1_BASE + REG_LOAD);
+	writel(TIMER1_ENABLE, base + TIMER_CR);
+	return 0;
 }
 
 static int moxart_clkevt_next_event(unsigned long cycles,
@@ -95,11 +94,15 @@ static int moxart_clkevt_next_event(unsigned long cycles,
 }
 
 static struct clock_event_device moxart_clockevent = {
-	.name		= "moxart_timer",
-	.rating		= 200,
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= moxart_clkevt_mode,
-	.set_next_event	= moxart_clkevt_next_event,
+	.name			= "moxart_timer",
+	.rating			= 200,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= moxart_shutdown,
+	.set_state_periodic	= moxart_set_periodic,
+	.set_state_oneshot	= moxart_set_oneshot,
+	.tick_resume		= moxart_set_oneshot,
+	.set_next_event		= moxart_clkevt_next_event,
 };
 
 static irqreturn_t moxart_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
