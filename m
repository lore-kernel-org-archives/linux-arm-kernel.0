From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:38 +0530
Subject: [PATCH 24/41] clocksource: tcb_clksrc: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <e3c07837d6539c802eeb29382d54ab371940975c.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate tcb_clksrc driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/tcb_clksrc.c | 93 ++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 8bdbc45c6dad..d28d2fe798d5 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -91,55 +91,62 @@ static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
  */
 static u32 timer_clock;
 
-static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
+static int tc_shutdown(struct clock_event_device *d)
 {
 	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
 	void __iomem		*regs = tcd->regs;
 
-	if (tcd->clkevt.mode == CLOCK_EVT_MODE_PERIODIC
-			|| tcd->clkevt.mode == CLOCK_EVT_MODE_ONESHOT) {
-		__raw_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
-		__raw_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
-		clk_disable(tcd->clk);
-	}
+	__raw_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
+	__raw_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
+	clk_disable(tcd->clk);
 
-	switch (m) {
+	return 0;
+}
 
-	/* By not making the gentime core emulate periodic mode on top
-	 * of oneshot, we get lower overhead and improved accuracy.
-	 */
-	case CLOCK_EVT_MODE_PERIODIC:
-		clk_enable(tcd->clk);
+static int tc_set_oneshot(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+	void __iomem		*regs = tcd->regs;
 
-		/* slow clock, count up to RC, then irq and restart */
-		__raw_writel(timer_clock
-				| ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
-				regs + ATMEL_TC_REG(2, CMR));
-		__raw_writel((32768 + HZ/2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_shutdown(d);
 
-		/* Enable clock and interrupts on RC compare */
-		__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+	clk_enable(tcd->clk);
 
-		/* go go gadget! */
-		__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
-				regs + ATMEL_TC_REG(2, CCR));
-		break;
+	/* slow clock, count up to RC, then irq and stop */
+	__raw_writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
+		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
+	__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
 
-	case CLOCK_EVT_MODE_ONESHOT:
-		clk_enable(tcd->clk);
+	/* set_next_event() configures and starts the timer */
+	return 0;
+}
 
-		/* slow clock, count up to RC, then irq and stop */
-		__raw_writel(timer_clock | ATMEL_TC_CPCSTOP
-				| ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
-				regs + ATMEL_TC_REG(2, CMR));
-		__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+static int tc_set_periodic(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+	void __iomem		*regs = tcd->regs;
 
-		/* set_next_event() configures and starts the timer */
-		break;
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_shutdown(d);
 
-	default:
-		break;
-	}
+	/* By not making the gentime core emulate periodic mode on top
+	 * of oneshot, we get lower overhead and improved accuracy.
+	 */
+	clk_enable(tcd->clk);
+
+	/* slow clock, count up to RC, then irq and restart */
+	__raw_writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
+		     regs + ATMEL_TC_REG(2, CMR));
+	__raw_writel((32768 + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+
+	/* Enable clock and interrupts on RC compare */
+	__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+
+	/* go go gadget! */
+	__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG, regs +
+		     ATMEL_TC_REG(2, CCR));
+	return 0;
 }
 
 static int tc_next_event(unsigned long delta, struct clock_event_device *d)
@@ -154,13 +161,15 @@ static int tc_next_event(unsigned long delta, struct clock_event_device *d)
 
 static struct tc_clkevt_device clkevt = {
 	.clkevt	= {
-		.name		= "tc_clkevt",
-		.features	= CLOCK_EVT_FEAT_PERIODIC
-					| CLOCK_EVT_FEAT_ONESHOT,
+		.name			= "tc_clkevt",
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
 		/* Should be lower than at91rm9200's system timer */
-		.rating		= 125,
-		.set_next_event	= tc_next_event,
-		.set_mode	= tc_mode,
+		.rating			= 125,
+		.set_next_event		= tc_next_event,
+		.set_state_shutdown	= tc_shutdown,
+		.set_state_periodic	= tc_set_periodic,
+		.set_state_oneshot	= tc_set_oneshot,
 	},
 };
 
-- 
2.4.0
