From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:22:47 +0000
Subject: [PATCH 23/24] ARM: stmp: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDyx-0008Dm-SC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-stmp3xxx/timer.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-stmp3xxx/timer.c b/arch/arm/plat-stmp3xxx/timer.c
index 063c7bc..c395630 100644
--- a/arch/arm/plat-stmp3xxx/timer.c
+++ b/arch/arm/plat-stmp3xxx/timer.c
@@ -89,7 +89,6 @@ static struct clocksource cksrc_stmp3xxx = {
 	.rating         = 250,
 	.read           = stmp3xxx_clock_read,
 	.mask           = CLOCKSOURCE_MASK(16),
-	.shift          = 10,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -106,8 +105,6 @@ static struct irqaction stmp3xxx_timer_irq = {
  */
 static void __init stmp3xxx_init_timer(void)
 {
-	cksrc_stmp3xxx.mult = clocksource_hz2mult(CLOCK_TICK_RATE,
-				cksrc_stmp3xxx.shift);
 	ckevt_timrot.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
 				ckevt_timrot.shift);
 	ckevt_timrot.min_delta_ns = clockevent_delta2ns(2, &ckevt_timrot);
@@ -140,7 +137,7 @@ static void __init stmp3xxx_init_timer(void)
 
 	setup_irq(IRQ_TIMER0, &stmp3xxx_timer_irq);
 
-	clocksource_register(&cksrc_stmp3xxx);
+	clocksource_register_hz(&cksrc_stmp3xxx, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt_timrot);
 }
 
-- 
1.6.2.5
