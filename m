From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:40:58 +0530
Subject: [PATCH 04/18] ARM/dc21285-timer: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <947d9cf53f5c9c4dfbbffe68f07dd4d02da2093d.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate footbridge driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-footbridge/dc21285-timer.c | 48 +++++++++++++++-----------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index bf7aa7d298e7..810edc78c817 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -57,34 +57,32 @@ static int ckevt_dc21285_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void ckevt_dc21285_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *c)
+static int ckevt_dc21285_shutdown(struct clock_event_device *c)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_RESUME:
-	case CLOCK_EVT_MODE_PERIODIC:
-		*CSR_TIMER1_CLR = 0;
-		*CSR_TIMER1_LOAD = (mem_fclk_21285 + 8 * HZ) / (16 * HZ);
-		*CSR_TIMER1_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_AUTORELOAD |
-				   TIMER_CNTL_DIV16;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		*CSR_TIMER1_CNTL = 0;
-		break;
-	}
+	*CSR_TIMER1_CNTL = 0;
+	return 0;
+}
+
+static int ckevt_dc21285_set_periodic(struct clock_event_device *c)
+{
+	*CSR_TIMER1_CLR = 0;
+	*CSR_TIMER1_LOAD = (mem_fclk_21285 + 8 * HZ) / (16 * HZ);
+	*CSR_TIMER1_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_AUTORELOAD |
+			   TIMER_CNTL_DIV16;
+	return 0;
 }
 
 static struct clock_event_device ckevt_dc21285 = {
-	.name		= "dc21285_timer1",
-	.features	= CLOCK_EVT_FEAT_PERIODIC |
-			  CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 200,
-	.irq		= IRQ_TIMER1,
-	.set_next_event	= ckevt_dc21285_set_next_event,
-	.set_mode	= ckevt_dc21285_set_mode,
+	.name			= "dc21285_timer1",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.irq			= IRQ_TIMER1,
+	.set_next_event		= ckevt_dc21285_set_next_event,
+	.set_state_shutdown	= ckevt_dc21285_shutdown,
+	.set_state_periodic	= ckevt_dc21285_set_periodic,
+	.set_state_oneshot	= ckevt_dc21285_shutdown,
+	.tick_resume		= ckevt_dc21285_set_periodic,
 };
 
 static irqreturn_t timer1_interrupt(int irq, void *dev_id)
@@ -94,7 +92,7 @@ static irqreturn_t timer1_interrupt(int irq, void *dev_id)
 	*CSR_TIMER1_CLR = 0;
 
 	/* Stop the timer if in one-shot mode */
-	if (ce->mode == CLOCK_EVT_MODE_ONESHOT)
+	if (clockevent_state_oneshot(ce))
 		*CSR_TIMER1_CNTL = 0;
 
 	ce->event_handler(ce);
-- 
2.4.0
