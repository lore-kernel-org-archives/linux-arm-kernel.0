From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:28:35 +0100
Subject: [PATCH 09/19] clocksource: convert W90x900 24-bit down counting
	clocksource
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1at-0003Dp-C1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the W90x900 24-bit down-counting clocksource to the generic
mmio clocksource infrastructure

Cc: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-w90x900/time.c |   17 ++---------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0a05a57..bab25a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -575,6 +575,7 @@ config ARCH_W90X900
 	select CPU_ARM926T
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index 4b089cb..a2c4e2d 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -43,7 +43,6 @@
 #define PRESCALE	0x63 /* Divider = prescale + 1 */
 
 #define	TDR_SHIFT	24
-#define	TDR_MASK	((1 << TDR_SHIFT) - 1)
 
 static unsigned int timer0_load;
 
@@ -143,19 +142,6 @@ static void __init nuc900_clockevents_init(void)
 	clockevents_register_device(&nuc900_clockevent_device);
 }
 
-static cycle_t nuc900_get_cycles(struct clocksource *cs)
-{
-	return (~__raw_readl(REG_TDR1)) & TDR_MASK;
-}
-
-static struct clocksource clocksource_nuc900 = {
-	.name	= "nuc900-timer1",
-	.rating	= 200,
-	.read	= nuc900_get_cycles,
-	.mask	= CLOCKSOURCE_MASK(TDR_SHIFT),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static void __init nuc900_clocksource_init(void)
 {
 	unsigned int val;
@@ -175,7 +161,8 @@ static void __init nuc900_clocksource_init(void)
 	val |= (COUNTEN | PERIOD | PRESCALE);
 	__raw_writel(val, REG_TCSR1);
 
-	clocksource_register_hz(&clocksource_nuc900, rate);
+	clocksource_mmio_init(REG_TDR1, "nuc900-timer1", rate, 200,
+		TDR_SHIFT, clocksource_mmio_readl_down);
 }
 
 static void __init nuc900_timer_init(void)
-- 
1.7.4.4
