From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:37:00 +0000
Subject: [PATCH 05/40] ARM: ixp4xx: update clock source registration
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYcO-0006hx-UO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ixp4xx/common.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0bce097..82fc003 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -411,7 +411,6 @@ static struct clocksource clocksource_ixp4xx = {
 	.rating		= 200,
 	.read		= ixp4xx_get_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift 		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -419,10 +418,7 @@ unsigned long ixp4xx_timer_freq = FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-	clocksource_ixp4xx.mult =
-		clocksource_hz2mult(ixp4xx_timer_freq,
-				    clocksource_ixp4xx.shift);
-	clocksource_register(&clocksource_ixp4xx);
+	clocksource_register_hz(&clocksource_ixp4xx, ixp4xx_timer_freq);
 }
 
 /*
-- 
1.6.2.5
