From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:29:15 +0100
Subject: [PATCH 11/19] clocksource: convert SPEAr platforms 16-bit up
	counting clocksource
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1bX-0003Dx-JB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert SPEAr platforms 16-bit up counting clocksource, which requires
a 16-bit register access read rather than 32-bit.

Acked-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig           |    1 +
 arch/arm/plat-spear/time.c |   16 ++--------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bab25a0..cbc27fb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -884,6 +884,7 @@ config PLAT_SPEAR
 	select ARM_AMBA
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	help
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index dbb6e4f..0c77e42 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -70,19 +70,6 @@ static void clockevent_set_mode(enum clock_event_mode mode,
 static int clockevent_next_event(unsigned long evt,
 				 struct clock_event_device *clk_event_dev);
 
-static cycle_t clocksource_read_cycles(struct clocksource *cs)
-{
-	return (cycle_t) readw(gpt_base + COUNT(CLKSRC));
-}
-
-static struct clocksource clksrc = {
-	.name = "tmr1",
-	.rating = 200,		/* its a pretty decent clock */
-	.read = clocksource_read_cycles,
-	.mask = 0xFFFF,		/* 16 bits */
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static void spear_clocksource_init(void)
 {
 	u32 tick_rate;
@@ -103,7 +90,8 @@ static void spear_clocksource_init(void)
 	writew(val, gpt_base + CR(CLKSRC));
 
 	/* register the clocksource */
-	clocksource_register_hz(&clksrc, tick_rate);
+	clocksource_mmio_init(gpt_base + COUNT(CLKSRC), "tmr1", tick_rate,
+		200, 16, clocksource_mmio_readw_up);
 }
 
 static struct clock_event_device clkevt = {
-- 
1.7.4.4
