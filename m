From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  8 Sep 2011 22:13:22 +0200
Subject: [PATCH 3/4 v2] mach-integrator: modernize clock event registration
Message-ID: <1315512802-21029-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop mult, shift and delta calculations and let the
clockevent core scale this as appropriate.

Set the minimum interval to 1 rather than 15 (0xf), there
is nothing in the data sheets I have indicating that 15
should be some minimum value.

Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Don't screw around with deleting the timer_reload, it was
  there for a perfectly good purpose in periodic mode.
---
 arch/arm/mach-integrator/integrator_ap.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index e66a8bc..0a6f397 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -398,12 +398,10 @@ static int clkevt_set_next_event(unsigned long next, struct clock_event_device *
 
 static struct clock_event_device integrator_clockevent = {
 	.name		= "timer1",
-	.shift		= 34,
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= clkevt_set_mode,
 	.set_next_event	= clkevt_set_next_event,
 	.rating		= 300,
-	.cpumask	= cpu_all_mask,
 };
 
 static struct irqaction integrator_timer_irq = {
@@ -415,9 +413,9 @@ static struct irqaction integrator_timer_irq = {
 
 static void integrator_clockevent_init(u32 khz)
 {
-	struct clock_event_device *evt = &integrator_clockevent;
 	unsigned int ctrl = 0;
 
+	/* Calculate and program a divisor */
 	if (khz * 1000 > 0x100000 * HZ) {
 		khz /= 256;
 		ctrl |= TIMER_CTRL_DIV256;
@@ -425,17 +423,14 @@ static void integrator_clockevent_init(u32 khz)
 		khz /= 16;
 		ctrl |= TIMER_CTRL_DIV16;
 	}
-
 	timer_reload = khz * 1000 / HZ;
 	writel(ctrl, clkevt_base + TIMER_CTRL);
 
-	evt->irq = IRQ_TIMERINT1;
-	evt->mult = div_sc(khz, NSEC_PER_MSEC, evt->shift);
-	evt->max_delta_ns = clockevent_delta2ns(0xffff, evt);
-	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
-
 	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
-	clockevents_register_device(evt);
+	clockevents_config_and_register(&integrator_clockevent,
+					khz * 1000,
+					1,
+					0xffffU);
 }
 
 /*
-- 
1.7.6
