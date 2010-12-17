From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:48:33 +0000
Subject: [PATCH 30/40] ARM: mmp: convert sched_clock() to use new
	infrastructure
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYnZ-0006ja-JI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert mmp to use the new sched_clock() infrastructure for extending
32bit counters to full 64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig         |    1 +
 arch/arm/mach-mmp/time.c |   32 +++++++++++---------------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6f58bce..0208e1e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -513,6 +513,7 @@ config ARCH_MMP
 	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLKDEV
 	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index a2ea33d..aeb9ae2 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -26,8 +26,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/sched.h>
-#include <linux/cnt32_to_63.h>
 
+#include <asm/sched_clock.h>
 #include <mach/addr-map.h>
 #include <mach/regs-timers.h>
 #include <mach/regs-apbc.h>
@@ -42,23 +42,7 @@
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
-#define TCR2NS_SCALE_FACTOR	10
-
-static unsigned long tcr2ns_scale;
-
-static void __init set_tcr2ns_scale(unsigned long tcr_rate)
-{
-	unsigned long long v = 1000000000ULL << TCR2NS_SCALE_FACTOR;
-	do_div(v, tcr_rate);
-	tcr2ns_scale = v;
-	/*
-	 * We want an even value to automatically clear the top bit
-	 * returned by cnt32_to_63() without an additional run time
-	 * instruction. So if the LSB is 1 then round it up.
-	 */
-	if (tcr2ns_scale & 1)
-		tcr2ns_scale++;
-}
+static DEFINE_CLOCK_DATA(cd);
 
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
@@ -77,8 +61,14 @@ static inline uint32_t timer_read(void)
 
 unsigned long long notrace sched_clock(void)
 {
-	unsigned long long v = cnt32_to_63(timer_read());
-	return (v * tcr2ns_scale) >> TCR2NS_SCALE_FACTOR;
+	u32 cyc = timer_read();
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+static void notrace mmp_update_sched_clock(void)
+{
+	u32 cyc = timer_read();
+	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id)
@@ -185,7 +175,7 @@ void __init timer_init(int irq)
 {
 	timer_config();
 
-	set_tcr2ns_scale(CLOCK_TICK_RATE);
+	init_sched_clock(&cd, mmp_update_sched_clock, 32, CLOCK_TICK_RATE);
 
 	ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt.shift);
 	ckevt.max_delta_ns = clockevent_delta2ns(MAX_DELTA, &ckevt);
-- 
1.6.2.5
