From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 16:24:13 +0530
Subject: [PATCH 06/18] ARM/imx/epit: Migrate to new 'set-state' interface
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <4c6c9bae16987a2f2b29af153d6db98f3cfa1b63.1436178990.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate imx driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Also drop 'clockevent_mode': It was caching the last state of the
clockevent device. The same behavior can be achieved by using
clockevents state helpers. These helpers are only required for oneshot
mode as shutdown/resume wouldn't be done twice by the core.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-imx/epit.c | 67 +++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
index 074b1a81ba76..08ce20771bb3 100644
--- a/arch/arm/mach-imx/epit.c
+++ b/arch/arm/mach-imx/epit.c
@@ -57,7 +57,6 @@
 #include "hardware.h"
 
 static struct clock_event_device clockevent_epit;
-static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
 static void __iomem *timer_base;
 
@@ -106,8 +105,8 @@ static int epit_set_next_event(unsigned long evt,
 	return 0;
 }
 
-static void epit_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+/* Left event sources disabled, no more interrupts appear */
+static int epit_shutdown(struct clock_event_device *evt)
 {
 	unsigned long flags;
 
@@ -120,39 +119,41 @@ static void epit_set_mode(enum clock_event_mode mode,
 	/* Disable interrupt in GPT module */
 	epit_irq_disable();
 
-	if (mode != clockevent_mode) {
-		/* Set event time into far-far future */
-
-		/* Clear pending interrupt */
-		epit_irq_acknowledge();
-	}
+	/* Clear pending interrupt */
+	epit_irq_acknowledge();
 
-	/* Remember timer mode */
-	clockevent_mode = mode;
 	local_irq_restore(flags);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		printk(KERN_ERR "epit_set_mode: Periodic mode is not "
-				"supported for i.MX EPIT\n");
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
+	return 0;
+}
+
+static int epit_set_oneshot(struct clock_event_device *evt)
+{
+	unsigned long flags;
+
+	/*
+	 * The timer interrupt generation is disabled at least
+	 * for enough time to call epit_set_next_event()
+	 */
+	local_irq_save(flags);
+
+	/* Disable interrupt in GPT module */
+	epit_irq_disable();
+
+	/* Clear pending interrupt, only while switching mode */
+	if (!clockevent_state_oneshot(evt))
+		epit_irq_acknowledge();
+
 	/*
 	 * Do not put overhead of interrupt enable/disable into
 	 * epit_set_next_event(), the core has about 4 minutes
 	 * to call epit_set_next_event() or shutdown clock after
 	 * mode switching
 	 */
-		local_irq_save(flags);
-		epit_irq_enable();
-		local_irq_restore(flags);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_RESUME:
-		/* Left event sources disabled, no more interrupts appear */
-		break;
-	}
+	epit_irq_enable();
+	local_irq_restore(flags);
+
+	return 0;
 }
 
 /*
@@ -176,11 +177,13 @@ static struct irqaction epit_timer_irq = {
 };
 
 static struct clock_event_device clockevent_epit = {
-	.name		= "epit",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= epit_set_mode,
-	.set_next_event	= epit_set_next_event,
-	.rating		= 200,
+	.name			= "epit",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= epit_shutdown,
+	.tick_resume		= epit_shutdown,
+	.set_state_oneshot	= epit_set_oneshot,
+	.set_next_event		= epit_set_next_event,
+	.rating			= 200,
 };
 
 static int __init epit_clockevent_init(struct clk *timer_clk)
-- 
2.4.0
