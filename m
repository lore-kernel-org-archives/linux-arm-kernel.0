From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:20:05 +0000
Subject: [PATCH 15/24] ARM: tcc8k: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDwL-0008DG-25@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-tcc8k/time.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tcc8k/time.c b/arch/arm/mach-tcc8k/time.c
index 78d0600..e0a8d60 100644
--- a/arch/arm/mach-tcc8k/time.c
+++ b/arch/arm/mach-tcc8k/time.c
@@ -35,7 +35,6 @@ static struct clocksource clocksource_tcc = {
 	.rating		= 200,
 	.read		= tcc_get_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 28,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -103,9 +102,7 @@ static int __init tcc_clockevent_init(struct clk *clock)
 {
 	unsigned int c = clk_get_rate(clock);
 
-	clocksource_tcc.mult = clocksource_hz2mult(c,
-					clocksource_tcc.shift);
-	clocksource_register(&clocksource_tcc);
+	clocksource_register_hz(&clocksource_tcc, c);
 
 	clockevent_tcc.mult = div_sc(c, NSEC_PER_SEC,
 					clockevent_tcc.shift);
-- 
1.6.2.5
