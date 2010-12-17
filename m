From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:48:54 +0000
Subject: [PATCH 31/40] ARM: pxa: convert sched_clock() to use new
	infrastructure
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYnu-0006je-2K@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert pxa to use the new sched_clock() infrastructure for extending
32bit counters to full 64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig         |    1 +
 arch/arm/mach-pxa/time.c |   29 +++++++++--------------------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0208e1e..23035d6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -593,6 +593,7 @@ config ARCH_PXA
 	select COMMON_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index b8d9dff..e7f64d9 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -17,11 +17,11 @@
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
 #include <linux/sched.h>
-#include <linux/cnt32_to_63.h>
 
 #include <asm/div64.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
+#include <asm/sched_clock.h>
 #include <mach/regs-ost.h>
 
 /*
@@ -32,29 +32,18 @@
  * long as there is always less than 582 seconds between successive
  * calls to sched_clock() which should always be the case in practice.
  */
+static DEFINE_CLOCK_DATA(cd);
 
-#define OSCR2NS_SCALE_FACTOR 10
-
-static unsigned long oscr2ns_scale;
-
-static void __init set_oscr2ns_scale(unsigned long oscr_rate)
+unsigned long long notrace sched_clock(void)
 {
-	unsigned long long v = 1000000000ULL << OSCR2NS_SCALE_FACTOR;
-	do_div(v, oscr_rate);
-	oscr2ns_scale = v;
-	/*
-	 * We want an even value to automatically clear the top bit
-	 * returned by cnt32_to_63() without an additional run time
-	 * instruction. So if the LSB is 1 then round it up.
-	 */
-	if (oscr2ns_scale & 1)
-		oscr2ns_scale++;
+	u32 cyc = OSCR;
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
 
-unsigned long long notrace sched_clock(void)
+static void notrace pxa_update_sched_clock(void)
 {
-	unsigned long long v = cnt32_to_63(OSCR);
-	return (v * oscr2ns_scale) >> OSCR2NS_SCALE_FACTOR;
+	u32 cyc = OSCR;
+	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 
@@ -144,7 +133,7 @@ static void __init pxa_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	set_oscr2ns_scale(clock_tick_rate);
+	init_sched_clock(&cd, pxa_update_sched_clock, 32, clock_tick_rate);
 
 	ckevt_pxa_osmr0.mult =
 		div_sc(clock_tick_rate, NSEC_PER_SEC, ckevt_pxa_osmr0.shift);
-- 
1.6.2.5
