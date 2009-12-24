From: eltshanli@gmail.com (Li Jie)
Date: Thu, 24 Dec 2009 14:45:59 +0800
Subject: [PATCH v2] ARM: NUC900: Fix bugs of clocksource driver
Message-ID: <8fb2581d0912232245ie92859ekf3840e9c0c574a06@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Wan:

v2:  use clk_xxx() api to enable timer0 and timer1 clock.


Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/mach-w90x900/time.c |   62 ++++++++++++++++++++++++-----------------
 1 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index 4128af8..40ee87a 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -42,7 +42,10 @@
 #define TICKS_PER_SEC	100
 #define PRESCALE	0x63 /* Divider = prescale + 1 */

-unsigned int timer0_load;
+#define	TDR_SHIFT	24
+#define	TDR_MASK	((1 << TDR_SHIFT) - 1)
+
+static unsigned int timer0_load;

 static void nuc900_clockevent_setmode(enum clock_event_mode mode,
 		struct clock_event_device *clk)
@@ -112,8 +115,23 @@ static struct irqaction nuc900_timer0_irq = {
 	.handler	= nuc900_timer0_interrupt,
 };

-static void __init nuc900_clockevents_init(unsigned int rate)
+static void __init nuc900_clockevents_init(void)
 {
+	unsigned int rate;
+	struct clk *clk = clk_get(NULL, "timer0");
+
+	BUG_ON(IS_ERR(clk));
+
+	__raw_writel(0x00, REG_TCSR0);
+
+	clk_enable(clk);
+	rate = clk_get_rate(clk) / (PRESCALE + 1);
+
+	timer0_load = (rate / TICKS_PER_SEC);
+
+	__raw_writel(RESETINT, REG_TISR);
+	setup_irq(IRQ_TIMER0, &nuc900_timer0_irq);
+
 	nuc900_clockevent_device.mult = div_sc(rate, NSEC_PER_SEC,
 					nuc900_clockevent_device.shift);
 	nuc900_clockevent_device.max_delta_ns = clockevent_delta2ns(0xffffffff,
@@ -127,26 +145,35 @@ static void __init
nuc900_clockevents_init(unsigned int rate)

 static cycle_t nuc900_get_cycles(struct clocksource *cs)
 {
-	return ~__raw_readl(REG_TDR1);
+	return (~__raw_readl(REG_TDR1)) & TDR_MASK;
 }

 static struct clocksource clocksource_nuc900 = {
 	.name	= "nuc900-timer1",
 	.rating	= 200,
 	.read	= nuc900_get_cycles,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.shift	= 20,
+	.mask	= CLOCKSOURCE_MASK(TDR_SHIFT),
+	.shift	= 10,
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };

-static void __init nuc900_clocksource_init(unsigned int rate)
+static void __init nuc900_clocksource_init(void)
 {
 	unsigned int val;
+	unsigned int rate;
+	struct clk *clk = clk_get(NULL, "timer1");
+
+	BUG_ON(IS_ERR(clk));
+
+	__raw_writel(0x00, REG_TCSR1);
+
+	clk_enable(clk);
+	rate = clk_get_rate(clk) / (PRESCALE + 1);

 	__raw_writel(0xffffffff, REG_TICR1);

 	val = __raw_readl(REG_TCSR1);
-	val |= (COUNTEN | PERIOD);
+	val |= (COUNTEN | PERIOD | PRESCALE);
 	__raw_writel(val, REG_TCSR1);

 	clocksource_nuc900.mult =
@@ -156,25 +183,8 @@ static void __init
nuc900_clocksource_init(unsigned int rate)

 static void __init nuc900_timer_init(void)
 {
-	struct clk *ck_ext = clk_get(NULL, "ext");
-	unsigned int	rate;
-
-	BUG_ON(IS_ERR(ck_ext));
-
-	rate = clk_get_rate(ck_ext);
-	clk_put(ck_ext);
-	rate = rate / (PRESCALE + 0x01);
-
-	 /* set a known state */
-	__raw_writel(0x00, REG_TCSR0);
-	__raw_writel(0x00, REG_TCSR1);
-	__raw_writel(RESETINT, REG_TISR);
-	timer0_load = (rate / TICKS_PER_SEC);
-
-	setup_irq(IRQ_TIMER0, &nuc900_timer0_irq);
-
-	nuc900_clocksource_init(rate);
-	nuc900_clockevents_init(rate);
+	nuc900_clocksource_init();
+	nuc900_clockevents_init();
 }

 struct sys_timer nuc900_timer = {
-- 
1.6.5.4
