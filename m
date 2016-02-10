From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue,  9 Feb 2016 22:54:26 -0300
Subject: [PATCH v2 2/3] clocksource/drivers/lpc32xx: Support periodic mode
In-Reply-To: <1455069267-4784-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1455069267-4784-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1455069267-4784-3-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the support for periodic mode. This is done by not
setting the MR0S (Stop on TnMR0) bit on MCR, thus allowing
interrupts to be periodically generated on MR0 matches.

In order to do this, move the initial configuration that is specific to
the one-shot mode to set_state_oneshot().

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/clocksource/time-lpc32xx.c | 39 +++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
index 50d1a63cbe1e..5694eddade15 100644
--- a/drivers/clocksource/time-lpc32xx.c
+++ b/drivers/clocksource/time-lpc32xx.c
@@ -43,6 +43,7 @@
 struct lpc32xx_clock_event_ddata {
 	struct clock_event_device evtdev;
 	void __iomem *base;
+	u32 ticks_per_jiffy;
 };
 
 /* Needed for the sched clock */
@@ -85,11 +86,39 @@ static int lpc32xx_clkevt_shutdown(struct clock_event_device *evtdev)
 
 static int lpc32xx_clkevt_oneshot(struct clock_event_device *evtdev)
 {
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
 	/*
 	 * When using oneshot, we must also disable the timer
 	 * to wait for the first call to set_next_event().
 	 */
-	return lpc32xx_clkevt_shutdown(evtdev);
+	writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
+
+	/* Enable interrupt, reset on match and stop on match (MCR). */
+	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
+		       LPC32XX_TIMER_MCR_MR0S, ddata->base + LPC32XX_TIMER_MCR);
+	return 0;
+}
+
+static int lpc32xx_clkevt_periodic(struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	/* Enable interrupt and reset on match. */
+	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R,
+		       ddata->base + LPC32XX_TIMER_MCR);
+
+	/*
+	 * Place timer in reset and program the delta in the match
+	 * channel 0 (MR0).
+	 */
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
+	writel_relaxed(ddata->ticks_per_jiffy, ddata->base + LPC32XX_TIMER_MR0);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
 }
 
 static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
@@ -107,11 +136,13 @@ static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
 static struct lpc32xx_clock_event_ddata lpc32xx_clk_event_ddata = {
 	.evtdev = {
 		.name			= "lpc3220 clockevent",
-		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.features		= CLOCK_EVT_FEAT_ONESHOT |
+					  CLOCK_EVT_FEAT_PERIODIC,
 		.rating			= 300,
 		.set_next_event		= lpc32xx_clkevt_next_event,
 		.set_state_shutdown	= lpc32xx_clkevt_shutdown,
 		.set_state_oneshot	= lpc32xx_clkevt_oneshot,
+		.set_state_periodic	= lpc32xx_clkevt_periodic,
 	},
 };
 
@@ -210,17 +241,15 @@ static int __init lpc32xx_clockevent_init(struct device_node *np)
 	/*
 	 * Disable timer and clear any pending interrupt (IR) on match
 	 * channel 0 (MR0). Clear the prescaler as it's not used.
-	 * Enable interrupt, reset on match and stop on match (MCR).
 	 */
 	writel_relaxed(0, base + LPC32XX_TIMER_TCR);
 	writel_relaxed(0, base + LPC32XX_TIMER_PR);
 	writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
 	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
-	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
-		       LPC32XX_TIMER_MCR_MR0S, base + LPC32XX_TIMER_MCR);
 
 	rate = clk_get_rate(clk);
 	lpc32xx_clk_event_ddata.base = base;
+	lpc32xx_clk_event_ddata.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
 	clockevents_config_and_register(&lpc32xx_clk_event_ddata.evtdev,
 					rate, 1, -1);
 
-- 
2.7.0
