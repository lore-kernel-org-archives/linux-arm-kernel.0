From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:17:21 +0000
Subject: [PATCH 07/24] ARM: mmp: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDth-0008Ck-JC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-mmp/time.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 6652819..0c0ab09 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -146,7 +146,6 @@ static cycle_t clksrc_read(struct clocksource *cs)
 
 static struct clocksource cksrc = {
 	.name		= "clocksource",
-	.shift		= 20,
 	.rating		= 200,
 	.read		= clksrc_read,
 	.mask		= CLOCKSOURCE_MASK(32),
@@ -193,10 +192,8 @@ void __init timer_init(int irq)
 	ckevt.min_delta_ns = clockevent_delta2ns(MIN_DELTA, &ckevt);
 	ckevt.cpumask = cpumask_of(0);
 
-	cksrc.mult = clocksource_hz2mult(CLOCK_TICK_RATE, cksrc.shift);
-
 	setup_irq(irq, &timer_irq);
 
-	clocksource_register(&cksrc);
+	clocksource_register_hz(&cksrc, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt);
 }
-- 
1.6.2.5
