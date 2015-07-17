From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:41:05 +0530
Subject: [PATCH 11/18] ARM/netx/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <c22437b78e77ae05768d77d44bb5651ac7ef5da9.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate netx driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We aren't writing zero twice on the control register for shutdown or
resume state now.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-netx/time.c | 61 +++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index 5fb2a590ec17..054a8a61e379 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -34,40 +34,40 @@
 #define TIMER_CLOCKEVENT 0
 #define TIMER_CLOCKSOURCE 1
 
-static void netx_set_mode(enum clock_event_mode mode,
-		struct clock_event_device *clk)
+static inline void timer_shutdown(struct clock_event_device *evt)
 {
-	u32 tmode;
-
 	/* disable timer */
 	writel(0, NETX_GPIO_COUNTER_CTRL(TIMER_CLOCKEVENT));
+}
+
+static int netx_shutdown(struct clock_event_device *evt)
+{
+	timer_shutdown(evt);
+
+	return 0;
+}
+
+static int netx_set_oneshot(struct clock_event_device *evt)
+{
+	u32 tmode = NETX_GPIO_COUNTER_CTRL_IRQ_EN | NETX_GPIO_COUNTER_CTRL_RUN;
+
+	timer_shutdown(evt);
+	writel(0, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
+	writel(tmode, NETX_GPIO_COUNTER_CTRL(TIMER_CLOCKEVENT));
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(NETX_LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
-		tmode = NETX_GPIO_COUNTER_CTRL_RST_EN |
-			NETX_GPIO_COUNTER_CTRL_IRQ_EN |
-			NETX_GPIO_COUNTER_CTRL_RUN;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		writel(0, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
-		tmode = NETX_GPIO_COUNTER_CTRL_IRQ_EN |
-			NETX_GPIO_COUNTER_CTRL_RUN;
-		break;
-
-	default:
-		WARN(1, "%s: unhandled mode %d\n", __func__, mode);
-		/* fall through */
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_RESUME:
-		tmode = 0;
-		break;
-	}
+	return 0;
+}
 
+static int netx_set_periodic(struct clock_event_device *evt)
+{
+	u32 tmode = NETX_GPIO_COUNTER_CTRL_RST_EN |
+		    NETX_GPIO_COUNTER_CTRL_IRQ_EN | NETX_GPIO_COUNTER_CTRL_RUN;
+
+	timer_shutdown(evt);
+	writel(NETX_LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
 	writel(tmode, NETX_GPIO_COUNTER_CTRL(TIMER_CLOCKEVENT));
+
+	return 0;
 }
 
 static int netx_set_next_event(unsigned long evt,
@@ -81,7 +81,10 @@ static struct clock_event_device netx_clockevent = {
 	.name = "netx-timer" __stringify(TIMER_CLOCKEVENT),
 	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_next_event = netx_set_next_event,
-	.set_mode = netx_set_mode,
+	.set_state_shutdown = netx_shutdown,
+	.set_state_periodic = netx_set_periodic,
+	.set_state_oneshot = netx_set_oneshot,
+	.tick_resume = netx_shutdown,
 };
 
 /*
-- 
2.4.0
