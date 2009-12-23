From: eltshanli@gmail.com (Li Jie)
Date: Wed, 23 Dec 2009 16:15:02 +0800
Subject: [PATCH] ARM: NUC900: Fix bugs of clocksource driver
Message-ID: <8fb2581d0912230015p4d423e4eg44b13190b184cc4c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wan:

This patch fix following bugs of clocksource in nuc900 cpus:

1. Enable timer1 before call clocksource_register(...)
2. change mask, 32 -> 24, because the max value of TDR1 is 0xFFFFFF
3. change shift. 20 -> 10, 20 is too big caused mult overflow


Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/mach-w90x900/time.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index 4128af8..b80e508 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -42,6 +42,10 @@
 #define TICKS_PER_SEC	100
 #define PRESCALE	0x63 /* Divider = prescale + 1 */

+#define	TDR_SHIFT	24
+#define	TDR_MASK	((1 << TDR_SHIFT) - 1)
+
+#define	TIMER1_CLKEN	(1 << 20)
 unsigned int timer0_load;

 static void nuc900_clockevent_setmode(enum clock_event_mode mode,
@@ -110,6 +114,7 @@ static struct irqaction nuc900_timer0_irq = {
 	.name		= "nuc900-timer0",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= nuc900_timer0_interrupt,
+	.dev_id		= &nuc900_clockevent_device,
 };

 static void __init nuc900_clockevents_init(unsigned int rate)
@@ -127,15 +132,15 @@ static void __init
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

@@ -143,10 +148,15 @@ static void __init
nuc900_clocksource_init(unsigned int rate)
 {
 	unsigned int val;

+	/* enable timer1 clk */
+	val = __raw_readl(W90X900_VA_CLKPWR);
+	val |= TIMER1_CLKEN;
+	__raw_writel(val, W90X900_VA_CLKPWR);
+
 	__raw_writel(0xffffffff, REG_TICR1);

 	val = __raw_readl(REG_TCSR1);
-	val |= (COUNTEN | PERIOD);
+	val |= (COUNTEN | PERIOD | PRESCALE);
 	__raw_writel(val, REG_TCSR1);

 	clocksource_nuc900.mult =
-- 
1.6.5.4
