From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 16:24:16 +0530
Subject: [PATCH 09/18] ARM/lpc32xx/timer: Migrate to new 'set-state' interface
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <79792dd6257c2dbdde4f90a4abbdc742490843b7.1436178990.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate lpc32xx driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Roland Stigge <stigge@antcom.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-lpc32xx/timer.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 4e5837299c04..ff3499d1fb1a 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -43,36 +43,24 @@ static int lpc32xx_clkevt_next_event(unsigned long delta,
 	return 0;
 }
 
-static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
-    struct clock_event_device *dev)
+static int lpc32xx_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		WARN_ON(1);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		/*
-		 * Disable the timer. When using oneshot, we must also
-		 * disable the timer to wait for the first call to
-		 * set_next_event().
-		 */
-		__raw_writel(0, LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	/*
+	 * Disable the timer. When using oneshot, we must also
+	 * disable the timer to wait for the first call to
+	 * set_next_event().
+	 */
+	__raw_writel(0, LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+	return 0;
 }
 
 static struct clock_event_device lpc32xx_clkevt = {
-	.name		= "lpc32xx_clkevt",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 300,
-	.set_next_event	= lpc32xx_clkevt_next_event,
-	.set_mode	= lpc32xx_clkevt_mode,
+	.name			= "lpc32xx_clkevt",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 300,
+	.set_next_event		= lpc32xx_clkevt_next_event,
+	.set_state_shutdown	= lpc32xx_shutdown,
+	.set_state_oneshot	= lpc32xx_shutdown,
 };
 
 static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
