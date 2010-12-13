From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:18:22 +0000
Subject: [PATCH 10/24] ARM: ns9xxx: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDug-0008Cw-Sl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ns9xxx/time-ns9360.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ns9xxx/time-ns9360.c b/arch/arm/mach-ns9xxx/time-ns9360.c
index 7728126..9ca32f5 100644
--- a/arch/arm/mach-ns9xxx/time-ns9360.c
+++ b/arch/arm/mach-ns9xxx/time-ns9360.c
@@ -35,7 +35,6 @@ static struct clocksource ns9360_clocksource = {
 	.rating	= 300,
 	.read	= ns9360_clocksource_read,
 	.mask	= CLOCKSOURCE_MASK(32),
-	.shift	= 20,
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -148,10 +147,7 @@ static void __init ns9360_timer_init(void)
 
 	__raw_writel(tc, SYS_TC(TIMER_CLOCKSOURCE));
 
-	ns9360_clocksource.mult = clocksource_hz2mult(ns9360_cpuclock(),
-			ns9360_clocksource.shift);
-
-	clocksource_register(&ns9360_clocksource);
+	clocksource_register_hz(&ns9360_clocksource, ns9360_cpuclock());
 
 	latch = SH_DIV(ns9360_cpuclock(), HZ, 0);
 
-- 
1.6.2.5
