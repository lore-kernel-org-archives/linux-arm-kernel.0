From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:51:16 +0000
Subject: [PATCH 38/40] ARM: orion: convert sched_clock() to use new
	infrastructure
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYqC-0006k6-Q9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert orion platforms to use the new sched_clock() infrastructure for
extending 32bit counters to full 64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig           |    1 +
 arch/arm/plat-orion/time.c |   44 +++++++++-----------------------------------
 2 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 726279f..92e8c01 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -997,6 +997,7 @@ config PLAT_IOP
 
 config PLAT_ORION
 	bool
+	select HAVE_SCHED_CLOCK
 
 config PLAT_PXA
 	bool
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 123f96f..c3da247 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -13,11 +13,11 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/cnt32_to_63.h>
 #include <linux/timer.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <asm/sched_clock.h>
 #include <asm/mach/time.h>
 #include <mach/bridge-regs.h>
 #include <mach/hardware.h>
@@ -44,52 +44,26 @@ static u32 ticks_per_jiffy;
 
 /*
  * Orion's sched_clock implementation. It has a resolution of
- * at least 7.5ns (133MHz TCLK) and a maximum value of 834 days.
- *
- * Because the hardware timer period is quite short (21 secs if
- * 200MHz TCLK) and because cnt32_to_63() needs to be called at
- * least once per half period to work properly, a kernel timer is
- * set up to ensure this requirement is always met.
+ * at least 7.5ns (133MHz TCLK).
  */
-#define TCLK2NS_SCALE_FACTOR 8
-
-static unsigned long tclk2ns_scale;
+static DEFINE_CLOCK_DATA(cd);
 
 unsigned long long notrace sched_clock(void)
 {
-	unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
-	return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
+	u32 cyc = 0xffffffff - readl(TIMER0_VAL);
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
 
-static struct timer_list cnt32_to_63_keepwarm_timer;
 
-static void cnt32_to_63_keepwarm(unsigned long data)
+static void notrace orion_update_sched_clock(void)
 {
-	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
-	(void) sched_clock();
+	u32 cyc = 0xffffffff - readl(TIMER0_VAL);
+	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 static void __init setup_sched_clock(unsigned long tclk)
 {
-	unsigned long long v;
-	unsigned long data;
-
-	v = NSEC_PER_SEC;
-	v <<= TCLK2NS_SCALE_FACTOR;
-	v += tclk/2;
-	do_div(v, tclk);
-	/*
-	 * We want an even value to automatically clear the top bit
-	 * returned by cnt32_to_63() without an additional run time
-	 * instruction. So if the LSB is 1 then round it up.
-	 */
-	if (v & 1)
-		v++;
-	tclk2ns_scale = v;
-
-	data = (0xffffffffUL / tclk / 2 - 2) * HZ;
-	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
-	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	init_sched_clock(&cd, orion_update_sched_clock, 32, tclk);
 }
 
 /*
-- 
1.6.2.5
