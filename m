From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:19:03 +0000
Subject: [PATCH 12/24] ARM: PXA: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDvL-0008D4-Oi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/time.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index 293e40a..caf92c0 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -127,7 +127,6 @@ static struct clocksource cksrc_pxa_oscr0 = {
 	.rating         = 200,
 	.read           = pxa_read_oscr,
 	.mask           = CLOCKSOURCE_MASK(32),
-	.shift          = 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -155,12 +154,9 @@ static void __init pxa_timer_init(void)
 		clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_pxa_osmr0) + 1;
 	ckevt_pxa_osmr0.cpumask = cpumask_of(0);
 
-	cksrc_pxa_oscr0.mult =
-		clocksource_hz2mult(clock_tick_rate, cksrc_pxa_oscr0.shift);
-
 	setup_irq(IRQ_OST0, &pxa_ost0_irq);
 
-	clocksource_register(&cksrc_pxa_oscr0);
+	clocksource_register_hz(&cksrc_pxa_oscr0, clock_tick_rate);
 	clockevents_register_device(&ckevt_pxa_osmr0);
 }
 
-- 
1.6.2.5
