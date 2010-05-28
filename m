From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 May 2010 19:33:16 +0200
Subject: [PATCH 1/2] ARM: move SPEAr to use common mult/shift calculation code
Message-ID: <1275067996-17233-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the infrastructure for determining shift/mult values from a
clock rate and a minimum programmable rate is now in the kernel,
lets remove this custom code.

Cc: Viresh KUMAR <viresh.kumar@st.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Viresh: I cannot test this change, but I have compiled it against
spear600_defconfig. You'd have to test it and Acked-by: it before
I do anything else with it. Try to think about what a minimum range
would be for the generic SPEAr platform...
---
 arch/arm/plat-spear/time.c |   47 ++++++-------------------------------------
 1 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index a1025d3..ab21165 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -58,6 +58,11 @@
 
 #define INT_STATUS		0x1
 
+/*
+ * Minimum clocksource/clockevent timer range in seconds
+ */
+#define SPEAR_MIN_RANGE 4
+
 static __iomem void *gpt_base;
 static struct clk *gpt_clk;
 
@@ -66,44 +71,6 @@ static void clockevent_set_mode(enum clock_event_mode mode,
 static int clockevent_next_event(unsigned long evt,
 				 struct clock_event_device *clk_event_dev);
 
-/*
- * Following clocksource_set_clock and clockevent_set_clock picked
- * from arch/mips/kernel/time.c
- */
-
-void __init clocksource_set_clock(struct clocksource *cs, unsigned int clock)
-{
-	u64 temp;
-	u32 shift;
-
-	/* Find a shift value */
-	for (shift = 32; shift > 0; shift--) {
-		temp = (u64) NSEC_PER_SEC << shift;
-		do_div(temp, clock);
-		if ((temp >> 32) == 0)
-			break;
-	}
-	cs->shift = shift;
-	cs->mult = (u32) temp;
-}
-
-void __init clockevent_set_clock(struct clock_event_device *cd,
-	unsigned int clock)
-{
-	u64 temp;
-	u32 shift;
-
-	/* Find a shift value */
-	for (shift = 32; shift > 0; shift--) {
-		temp = (u64) clock << shift;
-		do_div(temp, NSEC_PER_SEC);
-		if ((temp >> 32) == 0)
-			break;
-	}
-	cd->shift = shift;
-	cd->mult = (u32) temp;
-}
-
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
 	return (cycle_t) readw(gpt_base + COUNT(CLKSRC));
@@ -138,7 +105,7 @@ static void spear_clocksource_init(void)
 	val |= CTRL_ENABLE ;
 	writew(val, gpt_base + CR(CLKSRC));
 
-	clocksource_set_clock(&clksrc, tick_rate);
+	clocksource_calc_mult_shift(&clksrc, tick_rate, SPEAR_MIN_RANGE);
 
 	/* register the clocksource */
 	clocksource_register(&clksrc);
@@ -233,7 +200,7 @@ static void __init spear_clockevent_init(void)
 	tick_rate = clk_get_rate(gpt_clk);
 	tick_rate >>= CTRL_PRESCALER16;
 
-	clockevent_set_clock(&clkevt, tick_rate);
+	clockevents_calc_mult_shift(&clkevt, tick_rate, SPEAR_MIN_RANGE);
 
 	clkevt.max_delta_ns = clockevent_delta2ns(0xfff0,
 			&clkevt);
-- 
1.6.3.3
