From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:20:45 +0000
Subject: [PATCH 17/24] ARM: nuc: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDwz-0008DO-To@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-w90x900/time.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index b80f769..4b089cb 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -153,7 +153,6 @@ static struct clocksource clocksource_nuc900 = {
 	.rating	= 200,
 	.read	= nuc900_get_cycles,
 	.mask	= CLOCKSOURCE_MASK(TDR_SHIFT),
-	.shift	= 10,
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -176,9 +175,7 @@ static void __init nuc900_clocksource_init(void)
 	val |= (COUNTEN | PERIOD | PRESCALE);
 	__raw_writel(val, REG_TCSR1);
 
-	clocksource_nuc900.mult =
-		clocksource_khz2mult((rate / 1000), clocksource_nuc900.shift);
-	clocksource_register(&clocksource_nuc900);
+	clocksource_register_hz(&clocksource_nuc900, rate);
 }
 
 static void __init nuc900_timer_init(void)
-- 
1.6.2.5
