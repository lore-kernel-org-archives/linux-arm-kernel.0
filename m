From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 3 Aug 2010 09:37:32 +0200
Subject: [PATCH 3/3] ARM: move U300 timer to dynamic clock lookup
Message-ID: <1280821052-14390-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the U300 timer code to look up its clock rate from the
clock framework as is apropriate and also switches it over to use
the generic code for *calc_mult_shift() on clock source and clock
event.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/clock.c |    6 +++++-
 arch/arm/mach-u300/timer.c |   17 ++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
index 7a94729..60acf9e 100644
--- a/arch/arm/mach-u300/clock.c
+++ b/arch/arm/mach-u300/clock.c
@@ -1204,10 +1204,14 @@ static struct clk timer_clk = {
 	.lock       = __SPIN_LOCK_UNLOCKED(timer_clk.lock),
 };
 
+/*
+ * There is a binary divider in the hardware that divides
+ * the 13MHz PLL by 13 down to 1 MHz.
+ */
 static struct clk app_timer_clk = {
 	.name       = "TIMER_APP",
 	.parent	    = &slow_clk,
-	.rate       = 13000000,
+	.rate       = 1000000,
 	.hw_ctrld   = true,
 	.reset	    = true,
 	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 16465e3..9a7cfbf 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -25,6 +25,8 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
+/* Be able to sleep for atleast 4 seconds (usually more) */
+#define APPTIMER_MIN_RANGE 4
 
 /*
  * APP side special timer registers
@@ -308,8 +310,6 @@ static struct clock_event_device clockevent_u300_1mhz = {
 	.name           = "GPT1",
 	.rating         = 300, /* Reasonably fast and accurate clock event */
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	/* 22 calculated using the algorithm in arch/mips/kernel/time.c */
-	.shift          = 22,
 	.set_next_event = u300_set_next_event,
 	.set_mode       = u300_set_mode,
 };
@@ -342,8 +342,6 @@ static struct clocksource clocksource_u300_1mhz = {
 	.rating         = 300, /* Reasonably fast and accurate clock source */
 	.read           = u300_get_cycles,
 	.mask           = CLOCKSOURCE_MASK(32), /* 32 bits */
-	/* 22 calculated using the algorithm in arch/mips/kernel/time.c */
-	.shift          = 22,
 	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -369,11 +367,13 @@ unsigned long long notrace sched_clock(void)
 static void __init u300_timer_init(void)
 {
 	struct clk *clk;
+	unsigned long rate;
 
 	/* Clock the interrupt controller */
 	clk = clk_get_sys("apptimer", NULL);
 	BUG_ON(IS_ERR(clk));
 	clk_enable(clk);
+	rate = clk_get_rate(clk);
 
 	/*
 	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
@@ -412,15 +412,14 @@ static void __init u300_timer_init(void)
 	writel(U300_TIMER_APP_EGPT2_TIMER_ENABLE,
 		U300_TIMER_APP_VBASE + U300_TIMER_APP_EGPT2);
 
-	/* This is a pure microsecond clock source */
-	clocksource_u300_1mhz.mult =
-		clocksource_khz2mult(1000, clocksource_u300_1mhz.shift);
+	clocksource_calc_mult_shift(&clocksource_u300_1mhz,
+				    rate, APPTIMER_MIN_RANGE);
 	if (clocksource_register(&clocksource_u300_1mhz))
 		printk(KERN_ERR "timer: failed to initialize clock "
 		       "source %s\n", clocksource_u300_1mhz.name);
 
-	clockevent_u300_1mhz.mult =
-		div_sc(1000000, NSEC_PER_SEC, clockevent_u300_1mhz.shift);
+	clockevents_calc_mult_shift(&clockevent_u300_1mhz,
+				    rate, APPTIMER_MIN_RANGE);
 	/* 32bit counter, so 32bits delta is max */
 	clockevent_u300_1mhz.max_delta_ns =
 		clockevent_delta2ns(0xffffffff, &clockevent_u300_1mhz);
-- 
1.6.3.3
