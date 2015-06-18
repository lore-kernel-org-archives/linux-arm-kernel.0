From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:30 +0530
Subject: [PATCH 16/41] clocksource: pxa: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <3aa5c1a740911258698769cbbb8f60ee02178848.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate pxa driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Both oneshot and shutdown modes had exactly same code and so only a
single callback is sufficient now, which will be called for both the
modes.

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/pxa_timer.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index d9438af2bbd6..45b6a4999713 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -88,26 +88,12 @@ pxa_osmr0_set_next_event(unsigned long delta, struct clock_event_device *dev)
 	return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
 }
 
-static void
-pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
+static int pxa_osmr0_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
-		timer_writel(OSSR_M0, OSSR);
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		/* initializing, released, or preparing for suspend */
-		timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
-		timer_writel(OSSR_M0, OSSR);
-		break;
-
-	case CLOCK_EVT_MODE_RESUME:
-	case CLOCK_EVT_MODE_PERIODIC:
-		break;
-	}
+	/* initializing, released, or preparing for suspend */
+	timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
+	timer_writel(OSSR_M0, OSSR);
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -147,13 +133,14 @@ static void pxa_timer_resume(struct clock_event_device *cedev)
 #endif
 
 static struct clock_event_device ckevt_pxa_osmr0 = {
-	.name		= "osmr0",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 200,
-	.set_next_event	= pxa_osmr0_set_next_event,
-	.set_mode	= pxa_osmr0_set_mode,
-	.suspend	= pxa_timer_suspend,
-	.resume		= pxa_timer_resume,
+	.name			= "osmr0",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.set_next_event		= pxa_osmr0_set_next_event,
+	.set_state_shutdown	= pxa_osmr0_shutdown,
+	.set_state_oneshot	= pxa_osmr0_shutdown,
+	.suspend		= pxa_timer_suspend,
+	.resume			= pxa_timer_resume,
 };
 
 static struct irqaction pxa_ost0_irq = {
-- 
2.4.0
