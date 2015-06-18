From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:42 +0530
Subject: [PATCH 28/41] clocksource: orion: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <7797e21f79565a7c078df1c789a2f10cefb37f78.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate orion driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/time-orion.c | 46 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index 0b3ce0399c51..0ece7427b497 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -60,30 +60,36 @@ static int orion_clkevt_next_event(unsigned long delta,
 	return 0;
 }
 
-static void orion_clkevt_mode(enum clock_event_mode mode,
-			      struct clock_event_device *dev)
+static int orion_clkevt_shutdown(struct clock_event_device *dev)
 {
-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
-		/* setup and enable periodic timer at 1/HZ intervals */
-		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
-		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
-		atomic_io_modify(timer_base + TIMER_CTRL,
-			TIMER1_RELOAD_EN | TIMER1_EN,
-			TIMER1_RELOAD_EN | TIMER1_EN);
-	} else {
-		/* disable timer */
-		atomic_io_modify(timer_base + TIMER_CTRL,
-			TIMER1_RELOAD_EN | TIMER1_EN, 0);
-	}
+	/* disable timer */
+	atomic_io_modify(timer_base + TIMER_CTRL,
+			 TIMER1_RELOAD_EN | TIMER1_EN, 0);
+	return 0;
+}
+
+static int orion_clkevt_set_periodic(struct clock_event_device *dev)
+{
+	/* setup and enable periodic timer at 1/HZ intervals */
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+			 TIMER1_RELOAD_EN | TIMER1_EN,
+			 TIMER1_RELOAD_EN | TIMER1_EN);
+	return 0;
 }
 
 static struct clock_event_device orion_clkevt = {
-	.name		= "orion_event",
-	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-	.shift		= 32,
-	.rating		= 300,
-	.set_next_event	= orion_clkevt_next_event,
-	.set_mode	= orion_clkevt_mode,
+	.name			= "orion_event",
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC,
+	.shift			= 32,
+	.rating			= 300,
+	.set_next_event		= orion_clkevt_next_event,
+	.set_state_shutdown	= orion_clkevt_shutdown,
+	.set_state_periodic	= orion_clkevt_set_periodic,
+	.set_state_oneshot	= orion_clkevt_shutdown,
+	.tick_resume		= orion_clkevt_shutdown,
 };
 
 static irqreturn_t orion_clkevt_irq_handler(int irq, void *dev_id)
-- 
2.4.0
