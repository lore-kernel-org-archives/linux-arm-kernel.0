From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:21 +0530
Subject: [PATCH 07/41] clocksource: fsl_ftm: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <a97938170f9eab52b8d48bb2aaf3b58a09f5f2f8.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate fsl_ftm driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Xiubo Li <Li.Xiubo@freescale.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/fsl_ftm_timer.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
index 454227d4f895..ef434699c80a 100644
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ b/drivers/clocksource/fsl_ftm_timer.c
@@ -153,19 +153,16 @@ static int ftm_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void ftm_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+static int ftm_set_oneshot(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		ftm_set_next_event(priv->periodic_cyc, evt);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		ftm_counter_disable(priv->clkevt_base);
-		break;
-	default:
-		return;
-	}
+	ftm_counter_disable(priv->clkevt_base);
+	return 0;
+}
+
+static int ftm_set_periodic(struct clock_event_device *evt)
+{
+	ftm_set_next_event(priv->periodic_cyc, evt);
+	return 0;
 }
 
 static irqreturn_t ftm_evt_interrupt(int irq, void *dev_id)
@@ -174,7 +171,7 @@ static irqreturn_t ftm_evt_interrupt(int irq, void *dev_id)
 
 	ftm_irq_acknowledge(priv->clkevt_base);
 
-	if (likely(evt->mode == CLOCK_EVT_MODE_ONESHOT)) {
+	if (likely(clockevent_state_oneshot(evt))) {
 		ftm_irq_disable(priv->clkevt_base);
 		ftm_counter_disable(priv->clkevt_base);
 	}
@@ -185,11 +182,13 @@ static irqreturn_t ftm_evt_interrupt(int irq, void *dev_id)
 }
 
 static struct clock_event_device ftm_clockevent = {
-	.name		= "Freescale ftm timer",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= ftm_set_mode,
-	.set_next_event	= ftm_set_next_event,
-	.rating		= 300,
+	.name			= "Freescale ftm timer",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_periodic	= ftm_set_periodic,
+	.set_state_oneshot	= ftm_set_oneshot,
+	.set_next_event		= ftm_set_next_event,
+	.rating			= 300,
 };
 
 static struct irqaction ftm_timer_irq = {
-- 
2.4.0
