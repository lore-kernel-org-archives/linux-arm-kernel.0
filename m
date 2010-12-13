From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:19:44 +0000
Subject: [PATCH 14/24] ARM: SA11x0: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDw0-0008DC-KA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/time.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 74b6e0e..96154f5 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -81,7 +81,6 @@ static struct clocksource cksrc_sa1100_oscr = {
 	.rating		= 200,
 	.read		= sa1100_read_oscr,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -105,12 +104,9 @@ static void __init sa1100_timer_init(void)
 		clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_sa1100_osmr0) + 1;
 	ckevt_sa1100_osmr0.cpumask = cpumask_of(0);
 
-	cksrc_sa1100_oscr.mult =
-		clocksource_hz2mult(CLOCK_TICK_RATE, cksrc_sa1100_oscr.shift);
-
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 
-	clocksource_register(&cksrc_sa1100_oscr);
+	clocksource_register_hz(&cksrc_sa1100_oscr, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt_sa1100_osmr0);
 }
 
-- 
1.6.2.5
