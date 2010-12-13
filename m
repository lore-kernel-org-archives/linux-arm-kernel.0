From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:15:59 +0000
Subject: [PATCH 03/24] ARM: davinci: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDsN-0008CU-Sz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-davinci/time.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 0f21c36..c148671 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -276,7 +276,6 @@ static struct clocksource clocksource_davinci = {
 	.rating		= 300,
 	.read		= read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 24,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -378,10 +377,8 @@ static void __init davinci_timer_init(void)
 
 	/* setup clocksource */
 	clocksource_davinci.name = id_to_name[clocksource_id];
-	clocksource_davinci.mult =
-		clocksource_khz2mult(davinci_clock_tick_rate/1000,
-				     clocksource_davinci.shift);
-	if (clocksource_register(&clocksource_davinci))
+	if (clocksource_register_hz(&clocksource_davinci,
+				    davinci_clock_tick_rate))
 		printk(err, clocksource_davinci.name);
 
 	/* setup clockevent */
-- 
1.6.2.5
