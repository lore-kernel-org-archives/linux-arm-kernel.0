From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:41:12 +0530
Subject: [PATCH 18/18] ARM/orion/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <10dca88a4be632678088f5cbc20b54c2113ecb91.1437101996.git.viresh.kumar@linaro.org>
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
 arch/arm/plat-orion/time.c | 93 ++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 45 deletions(-)

diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 261258f717fc..8085a8aac812 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -106,60 +106,63 @@ orion_clkevt_next_event(unsigned long delta, struct clock_event_device *dev)
 	return 0;
 }
 
-static void
-orion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
+static int orion_clkevt_shutdown(struct clock_event_device *evt)
 {
 	unsigned long flags;
 	u32 u;
 
 	local_irq_save(flags);
-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
-		/*
-		 * Setup timer to fire at 1/HZ intervals.
-		 */
-		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
-		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
-
-		/*
-		 * Enable timer interrupt.
-		 */
-		u = readl(bridge_base + BRIDGE_MASK_OFF);
-		writel(u | BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
-
-		/*
-		 * Enable timer.
-		 */
-		u = readl(timer_base + TIMER_CTRL_OFF);
-		writel(u | TIMER1_EN | TIMER1_RELOAD_EN,
-		       timer_base + TIMER_CTRL_OFF);
-	} else {
-		/*
-		 * Disable timer.
-		 */
-		u = readl(timer_base + TIMER_CTRL_OFF);
-		writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
-
-		/*
-		 * Disable timer interrupt.
-		 */
-		u = readl(bridge_base + BRIDGE_MASK_OFF);
-		writel(u & ~BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
-
-		/*
-		 * ACK pending timer interrupt.
-		 */
-		writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
-
-	}
+
+	/* Disable timer */
+	u = readl(timer_base + TIMER_CTRL_OFF);
+	writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
+
+	/* Disable timer interrupt */
+	u = readl(bridge_base + BRIDGE_MASK_OFF);
+	writel(u & ~BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
+
+	/* ACK pending timer interrupt */
+	writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int orion_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	unsigned long flags;
+	u32 u;
+
+	local_irq_save(flags);
+
+	/* Setup timer to fire at 1/HZ intervals */
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
+	writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
+
+	/* Enable timer interrupt */
+	u = readl(bridge_base + BRIDGE_MASK_OFF);
+	writel(u | BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
+
+	/* Enable timer */
+	u = readl(timer_base + TIMER_CTRL_OFF);
+	writel(u | TIMER1_EN | TIMER1_RELOAD_EN, timer_base + TIMER_CTRL_OFF);
+
 	local_irq_restore(flags);
+
+	return 0;
 }
 
 static struct clock_event_device orion_clkevt = {
-	.name		= "orion_tick",
-	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-	.rating		= 300,
-	.set_next_event	= orion_clkevt_next_event,
-	.set_mode	= orion_clkevt_mode,
+	.name			= "orion_tick",
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC,
+	.rating			= 300,
+	.set_next_event		= orion_clkevt_next_event,
+	.set_state_shutdown	= orion_clkevt_shutdown,
+	.set_state_periodic	= orion_clkevt_set_periodic,
+	.set_state_oneshot	= orion_clkevt_shutdown,
+	.tick_resume		= orion_clkevt_shutdown,
 };
 
 static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
