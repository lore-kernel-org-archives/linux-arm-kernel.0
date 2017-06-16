From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jun 2017 13:12:48 +0200
Subject: [PATCH] clocksource/drivers/tcb_clksrc: make IO endian agnostic
Message-ID: <20170616111248.27312-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that AVR32 is gone, we can use the proper IO accessors that are
correctly handling endianness.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/tcb_clksrc.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index d4ca9962a759..85102f91f408 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -48,9 +48,9 @@ static u64 tc_get_cycles(struct clocksource *cs)
 
 	raw_local_irq_save(flags);
 	do {
-		upper = __raw_readl(tcaddr + ATMEL_TC_REG(1, CV));
-		lower = __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
-	} while (upper != __raw_readl(tcaddr + ATMEL_TC_REG(1, CV)));
+		upper = readl_relaxed(tcaddr + ATMEL_TC_REG(1, CV));
+		lower = readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
+	} while (upper != readl_relaxed(tcaddr + ATMEL_TC_REG(1, CV)));
 
 	raw_local_irq_restore(flags);
 	return (upper << 16) | lower;
@@ -58,7 +58,7 @@ static u64 tc_get_cycles(struct clocksource *cs)
 
 static u64 tc_get_cycles32(struct clocksource *cs)
 {
-	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
+	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
 static struct clocksource clksrc = {
@@ -96,8 +96,8 @@ static int tc_shutdown(struct clock_event_device *d)
 	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
 	void __iomem		*regs = tcd->regs;
 
-	__raw_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
-	__raw_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
+	writel(0xff, regs + ATMEL_TC_REG(2, IDR));
+	writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
 	if (!clockevent_state_detached(d))
 		clk_disable(tcd->clk);
 
@@ -115,9 +115,9 @@ static int tc_set_oneshot(struct clock_event_device *d)
 	clk_enable(tcd->clk);
 
 	/* slow clock, count up to RC, then irq and stop */
-	__raw_writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
+	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
 		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
-	__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
 
 	/* set_next_event() configures and starts the timer */
 	return 0;
@@ -137,25 +137,25 @@ static int tc_set_periodic(struct clock_event_device *d)
 	clk_enable(tcd->clk);
 
 	/* slow clock, count up to RC, then irq and restart */
-	__raw_writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
+	writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
 		     regs + ATMEL_TC_REG(2, CMR));
-	__raw_writel((32768 + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+	writel((32768 + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
 
 	/* Enable clock and interrupts on RC compare */
-	__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
 
 	/* go go gadget! */
-	__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG, regs +
+	writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG, regs +
 		     ATMEL_TC_REG(2, CCR));
 	return 0;
 }
 
 static int tc_next_event(unsigned long delta, struct clock_event_device *d)
 {
-	__raw_writel(delta, tcaddr + ATMEL_TC_REG(2, RC));
+	writel(delta, tcaddr + ATMEL_TC_REG(2, RC));
 
 	/* go go gadget! */
-	__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
+	writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
 			tcaddr + ATMEL_TC_REG(2, CCR));
 	return 0;
 }
@@ -179,7 +179,7 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	struct tc_clkevt_device	*dev = handle;
 	unsigned int		sr;
 
-	sr = __raw_readl(dev->regs + ATMEL_TC_REG(2, SR));
+	sr = readl_relaxed(dev->regs + ATMEL_TC_REG(2, SR));
 	if (sr & ATMEL_TC_CPCS) {
 		dev->clkevt.event_handler(&dev->clkevt);
 		return IRQ_HANDLED;
@@ -239,43 +239,43 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 {
 	/* channel 0:  waveform mode, input mclk/8, clock TIOA0 on overflow */
-	__raw_writel(mck_divisor_idx			/* likely divide-by-8 */
+	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
-	__raw_writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
-	__raw_writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
+	writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
+	writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
+	writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
 
 	/* channel 1:  waveform mode, input TIOA0 */
-	__raw_writel(ATMEL_TC_XC1			/* input: TIOA0 */
+	writel(ATMEL_TC_XC1			/* input: TIOA0 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP,		/* free-run */
 			tcaddr + ATMEL_TC_REG(1, CMR));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
+	writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
+	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
 
 	/* chain channel 0 to channel 1*/
-	__raw_writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
+	writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
 	/* then reset all the timers */
-	__raw_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
 static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_idx)
 {
 	/* channel 0:  waveform mode, input mclk/8 */
-	__raw_writel(mck_divisor_idx			/* likely divide-by-8 */
+	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP,		/* free-run */
 			tcaddr + ATMEL_TC_REG(0, CMR));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
+	writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
 
 	/* then reset all the timers */
-	__raw_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
 static int __init tcb_clksrc_init(void)
-- 
2.11.0
