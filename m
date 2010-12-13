From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:15:19 +0000
Subject: [PATCH 01/24] ARM: AT91: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDrj-0008CM-A2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-at91/at91rm9200_time.c  |    4 +---
 arch/arm/mach-at91/at91sam926x_time.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 2500f41..1dd69c8 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -101,7 +101,6 @@ static struct clocksource clk32k = {
 	.rating		= 150,
 	.read		= read_clk32k,
 	.mask		= CLOCKSOURCE_MASK(20),
-	.shift		= 10,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -201,8 +200,7 @@ void __init at91rm9200_timer_init(void)
 	clockevents_register_device(&clkevt);
 
 	/* register clocksource */
-	clk32k.mult = clocksource_hz2mult(AT91_SLOW_CLOCK, clk32k.shift);
-	clocksource_register(&clk32k);
+	clocksource_register_hz(&clk32k, AT91_SLOW_CLOCK);
 }
 
 struct sys_timer at91rm9200_timer = {
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 608a632..4ba8549 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -51,7 +51,6 @@ static struct clocksource pit_clk = {
 	.name		= "pit",
 	.rating		= 175,
 	.read		= read_pit_clk,
-	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -163,10 +162,9 @@ static void __init at91sam926x_pit_init(void)
 	 * Register clocksource.  The high order bits of PIV are unused,
 	 * so this isn't a 32-bit counter unless we get clockevent irqs.
 	 */
-	pit_clk.mult = clocksource_hz2mult(pit_rate, pit_clk.shift);
 	bits = 12 /* PICNT */ + ilog2(pit_cycle) /* PIV */;
 	pit_clk.mask = CLOCKSOURCE_MASK(bits);
-	clocksource_register(&pit_clk);
+	clocksource_register_hz(&pit_clk, pit_rate);
 
 	/* Set up irq handler */
 	setup_irq(AT91_ID_SYS, &at91sam926x_pit_irq);
-- 
1.6.2.5
