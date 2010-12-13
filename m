From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:15:39 +0000
Subject: [PATCH 02/24] ARM: bcmring: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDs3-0008CQ-FW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcmring/core.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index d3f959e..b91b1b0 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -294,7 +294,6 @@ static struct clocksource clocksource_bcmring_timer1 = {
 	.rating = 200,
 	.read = bcmring_get_cycles_timer1,
 	.mask = CLOCKSOURCE_MASK(32),
-	.shift = 20,
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -303,7 +302,6 @@ static struct clocksource clocksource_bcmring_timer3 = {
 	.rating = 100,
 	.read = bcmring_get_cycles_timer3,
 	.mask = CLOCKSOURCE_MASK(32),
-	.shift = 20,
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -316,10 +314,8 @@ static int __init bcmring_clocksource_init(void)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 	       TIMER1_VA_BASE + TIMER_CTRL);
 
-	clocksource_bcmring_timer1.mult =
-	    clocksource_khz2mult(TIMER1_FREQUENCY_MHZ * 1000,
-				 clocksource_bcmring_timer1.shift);
-	clocksource_register(&clocksource_bcmring_timer1);
+	clocksource_register_khz(&clocksource_bcmring_timer1,
+				 TIMER1_FREQUENCY_MHZ * 1000);
 
 	/* setup timer3 as free-running clocksource */
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
@@ -328,10 +324,8 @@ static int __init bcmring_clocksource_init(void)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 	       TIMER3_VA_BASE + TIMER_CTRL);
 
-	clocksource_bcmring_timer3.mult =
-	    clocksource_khz2mult(TIMER3_FREQUENCY_KHZ,
-				 clocksource_bcmring_timer3.shift);
-	clocksource_register(&clocksource_bcmring_timer3);
+	clocksource_register_khz(&clocksource_bcmring_timer3,
+				 TIMER3_FREQUENCY_KHZ);
 
 	return 0;
 }
-- 
1.6.2.5
