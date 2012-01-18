From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2012 16:14:50 +0000
Subject: [PATCH v2 1/3] ARM: davinci: convert to common sched_clock()
 implementation
In-Reply-To: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
References: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326903292-15794-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Davinci has its own sched_clock() implementation, which gets in the
way of a single zImage. Moving to the common sched_clock framework
makes the code slightly cleaner.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-davinci/time.c |   24 +++++++-----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..cb75734 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -932,6 +932,7 @@ config ARCH_DAVINCI
 	select ARCH_REQUIRE_GPIOLIB
 	select ZONE_DMA
 	select HAVE_IDE
+	select HAVE_SCHED_CLOCK
 	select CLKDEV_LOOKUP
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index e1969ce..187fcda 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
+#include <asm/sched_clock.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <mach/cputype.h>
@@ -272,19 +273,9 @@ static cycle_t read_cycles(struct clocksource *cs)
 	return (cycles_t)timer32_read(t);
 }
 
-/*
- * Kernel assumes that sched_clock can be called early but may not have
- * things ready yet.
- */
-static cycle_t read_dummy(struct clocksource *cs)
-{
-	return 0;
-}
-
-
 static struct clocksource clocksource_davinci = {
 	.rating		= 300,
-	.read		= read_dummy,
+	.read		= read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -292,12 +283,9 @@ static struct clocksource clocksource_davinci = {
 /*
  * Overwrite weak default sched_clock with something more precise
  */
-unsigned long long notrace sched_clock(void)
+static u32 notrace davinci_read_sched_clock(void)
 {
-	const cycle_t cyc = clocksource_davinci.read(&clocksource_davinci);
-
-	return clocksource_cyc2ns(cyc, clocksource_davinci.mult,
-				clocksource_davinci.shift);
+	return timer32_read(&timers[TID_CLOCKSOURCE]);
 }
 
 /*
@@ -397,12 +385,14 @@ static void __init davinci_timer_init(void)
 	davinci_clock_tick_rate = clk_get_rate(timer_clk);
 
 	/* setup clocksource */
-	clocksource_davinci.read = read_cycles;
 	clocksource_davinci.name = id_to_name[clocksource_id];
 	if (clocksource_register_hz(&clocksource_davinci,
 				    davinci_clock_tick_rate))
 		printk(err, clocksource_davinci.name);
 
+	setup_sched_clock(davinci_read_sched_clock, 32,
+			  davinci_clock_tick_rate);
+
 	/* setup clockevent */
 	clockevent_davinci.name = id_to_name[timers[TID_CLOCKEVENT].id];
 	clockevent_davinci.mult = div_sc(davinci_clock_tick_rate, NSEC_PER_SEC,
-- 
1.7.7.1
