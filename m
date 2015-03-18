From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:06 +0000
Subject: [PATCH 07/13] clocksource: tcb_clksrc: make IO endian agnostic
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-8-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the __raw read and write to use readl/writel_relaxed to make the
code endian agnostic.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/clocksource/tcb_clksrc.c | 66 ++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 8bdbc45..0f819dd3 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -41,6 +41,14 @@
 
 static void __iomem *tcaddr;
 
+#ifdef CONFIG_AVR32
+#define tcb_readl	__raw_readl
+#define tcb_writel	__raw_writel
+#else
+#define tcb_readl	readl_relaxed
+#define tcb_writel	writel_relaxed
+#endif
+
 static cycle_t tc_get_cycles(struct clocksource *cs)
 {
 	unsigned long	flags;
@@ -48,9 +56,9 @@ static cycle_t tc_get_cycles(struct clocksource *cs)
 
 	raw_local_irq_save(flags);
 	do {
-		upper = __raw_readl(tcaddr + ATMEL_TC_REG(1, CV));
-		lower = __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
-	} while (upper != __raw_readl(tcaddr + ATMEL_TC_REG(1, CV)));
+		upper = tcb_readl(tcaddr + ATMEL_TC_REG(1, CV));
+		lower = tcb_readl(tcaddr + ATMEL_TC_REG(0, CV));
+	} while (upper != tcb_readl(tcaddr + ATMEL_TC_REG(1, CV)));
 
 	raw_local_irq_restore(flags);
 	return (upper << 16) | lower;
@@ -58,7 +66,7 @@ static cycle_t tc_get_cycles(struct clocksource *cs)
 
 static cycle_t tc_get_cycles32(struct clocksource *cs)
 {
-	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
+	return tcb_readl(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
 static struct clocksource clksrc = {
@@ -98,8 +106,8 @@ static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
 
 	if (tcd->clkevt.mode == CLOCK_EVT_MODE_PERIODIC
 			|| tcd->clkevt.mode == CLOCK_EVT_MODE_ONESHOT) {
-		__raw_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
-		__raw_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
+		tcb_writel(0xff, regs + ATMEL_TC_REG(2, IDR));
+		tcb_writel(ATMEL_TC_CLKDIS, regs + ATMEL_TC_REG(2, CCR));
 		clk_disable(tcd->clk);
 	}
 
@@ -112,16 +120,16 @@ static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
 		clk_enable(tcd->clk);
 
 		/* slow clock, count up to RC, then irq and restart */
-		__raw_writel(timer_clock
+		tcb_writel(timer_clock
 				| ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
 				regs + ATMEL_TC_REG(2, CMR));
-		__raw_writel((32768 + HZ/2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+		tcb_writel((32768 + HZ/2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
 
 		/* Enable clock and interrupts on RC compare */
-		__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+		tcb_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
 
 		/* go go gadget! */
-		__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
+		tcb_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
 				regs + ATMEL_TC_REG(2, CCR));
 		break;
 
@@ -129,10 +137,10 @@ static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
 		clk_enable(tcd->clk);
 
 		/* slow clock, count up to RC, then irq and stop */
-		__raw_writel(timer_clock | ATMEL_TC_CPCSTOP
+		tcb_writel(timer_clock | ATMEL_TC_CPCSTOP
 				| ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
 				regs + ATMEL_TC_REG(2, CMR));
-		__raw_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
+		tcb_writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
 
 		/* set_next_event() configures and starts the timer */
 		break;
@@ -144,10 +152,10 @@ static void tc_mode(enum clock_event_mode m, struct clock_event_device *d)
 
 static int tc_next_event(unsigned long delta, struct clock_event_device *d)
 {
-	__raw_writel(delta, tcaddr + ATMEL_TC_REG(2, RC));
+	tcb_writel(delta, tcaddr + ATMEL_TC_REG(2, RC));
 
 	/* go go gadget! */
-	__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
+	tcb_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
 			tcaddr + ATMEL_TC_REG(2, CCR));
 	return 0;
 }
@@ -169,7 +177,7 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	struct tc_clkevt_device	*dev = handle;
 	unsigned int		sr;
 
-	sr = __raw_readl(dev->regs + ATMEL_TC_REG(2, SR));
+	sr = tcb_readl(dev->regs + ATMEL_TC_REG(2, SR));
 	if (sr & ATMEL_TC_CPCS) {
 		dev->clkevt.event_handler(&dev->clkevt);
 		return IRQ_HANDLED;
@@ -221,43 +229,43 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 {
 	/* channel 0:  waveform mode, input mclk/8, clock TIOA0 on overflow */
-	__raw_writel(mck_divisor_idx			/* likely divide-by-8 */
+	tcb_writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
-	__raw_writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
-	__raw_writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
+	tcb_writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
+	tcb_writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
+	tcb_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	tcb_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
 
 	/* channel 1:  waveform mode, input TIOA0 */
-	__raw_writel(ATMEL_TC_XC1			/* input: TIOA0 */
+	tcb_writel(ATMEL_TC_XC1			/* input: TIOA0 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP,		/* free-run */
 			tcaddr + ATMEL_TC_REG(1, CMR));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
+	tcb_writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
+	tcb_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
 
 	/* chain channel 0 to channel 1*/
-	__raw_writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
+	tcb_writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
 	/* then reset all the timers */
-	__raw_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+	tcb_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
 static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_idx)
 {
 	/* channel 0:  waveform mode, input mclk/8 */
-	__raw_writel(mck_divisor_idx			/* likely divide-by-8 */
+	tcb_writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP,		/* free-run */
 			tcaddr + ATMEL_TC_REG(0, CMR));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
+	tcb_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	tcb_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
 
 	/* then reset all the timers */
-	__raw_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+	tcb_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
 static int __init tcb_clksrc_init(void)
-- 
2.1.4
