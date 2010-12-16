From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 09:30:42 +0000
Subject: [PATCH 09/13] ARM: nomadik: convert sched_clock() to use new
	infrastructure
In-Reply-To: <20101216092527.GL9937@n2100.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTAAc-00079o-1o@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert nomadik platforms to use the new sched_clock() infrastructure
for extending 32bit counters to full 64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-nomadik/Kconfig |    1 +
 arch/arm/plat-nomadik/timer.c |   76 +++++------------------------------------
 2 files changed, 10 insertions(+), 67 deletions(-)

diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index 5da3f97..187f4e8 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -14,6 +14,7 @@ if PLAT_NOMADIK
 
 config HAS_MTU
 	bool
+	select HAVE_SCHED_CLOCK
 	help
 	  Support for Multi Timer Unit. MTU provides access
 	  to multiple interrupt generating programmable
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index b0bd6df..1d81891 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -17,9 +17,8 @@
 #include <linux/clk.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
-#include <linux/cnt32_to_63.h>
-#include <linux/timer.h>
 #include <asm/mach/time.h>
+#include <asm/sched_clock.h>
 
 #include <plat/mtu.h>
 
@@ -52,81 +51,24 @@ static struct clocksource nmdk_clksrc = {
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
  * better resolution when scheduling the kernel.
- *
- * Because the hardware timer period may be quite short
- * (32.3 secs on the 133 MHz MTU timer selection on ux500)
- * and because cnt32_to_63() needs to be called at least once per
- * half period to work properly, a kernel keepwarm() timer is set up
- * to ensure this requirement is always met.
- *
- * Also the sched_clock timer will wrap around at some point,
- * here we set it to run continously for a year.
  */
-#define SCHED_CLOCK_MIN_WRAP 3600*24*365
-static struct timer_list cnt32_to_63_keepwarm_timer;
-static u32 sched_mult;
-static u32 sched_shift;
+static DEFINE_CLOCK_DATA(cd);
 
 unsigned long long notrace sched_clock(void)
 {
-	u64 cycles;
+	u32 cyc;
 
 	if (unlikely(!mtu_base))
 		return 0;
 
-	cycles = cnt32_to_63(-readl(mtu_base + MTU_VAL(0)));
-	/*
-	 * sched_mult is guaranteed to be even so will
-	 * shift out bit 63
-	 */
-	return (cycles * sched_mult) >> sched_shift;
+	cyc = -readl(mtu_base + MTU_VAL(0));
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
 
-/* Just kick sched_clock every so often */
-static void cnt32_to_63_keepwarm(unsigned long data)
+static void notrace nomadik_update_sched_clock(void)
 {
-	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
-	(void) sched_clock();
-}
-
-/*
- * Set up a timer to keep sched_clock():s 32_to_63 algorithm warm
- * once in half a 32bit timer wrap interval.
- */
-static void __init nmdk_sched_clock_init(unsigned long rate)
-{
-	u32 v;
-	unsigned long delta;
-	u64 days;
-
-	/* Find the apropriate mult and shift factors */
-	clocks_calc_mult_shift(&sched_mult, &sched_shift,
-			       rate, NSEC_PER_SEC, SCHED_CLOCK_MIN_WRAP);
-	/* We need to multiply by an even number to get rid of bit 63 */
-	if (sched_mult & 1)
-		sched_mult++;
-
-	/* Let's see what we get, take max counter and scale it */
-	days = (0xFFFFFFFFFFFFFFFFLLU * sched_mult) >> sched_shift;
-	do_div(days, NSEC_PER_SEC);
-	do_div(days, (3600*24));
-
-	pr_info("sched_clock: using %d bits @ %lu Hz wrap in %lu days\n",
-		(64 - sched_shift), rate, (unsigned long) days);
-
-	/*
-	 * Program a timer to kick us at half 32bit wraparound
-	 * Formula: seconds per wrap = (2^32) / f
-	 */
-	v = 0xFFFFFFFFUL / rate;
-	/* We want half of the wrap time to keep cnt32_to_63 warm */
-	v /= 2;
-	pr_debug("sched_clock: prescaled timer rate: %lu Hz, "
-		 "initialize keepwarm timer every %d seconds\n", rate, v);
-	/* Convert seconds to jiffies */
-	delta = msecs_to_jiffies(v*1000);
-	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, delta);
-	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + delta));
+	u32 cyc = -readl(mtu_base + MTU_VAL(0));
+	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 /* Clockevent device: use one-shot mode */
@@ -236,7 +178,7 @@ void __init nmdk_timer_init(void)
 		pr_err("timer: failed to initialize clock source %s\n",
 		       nmdk_clksrc.name);
 
-	nmdk_sched_clock_init(rate);
+	init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
 
 	/* Timer 1 is used for events */
 
-- 
1.6.2.5
