From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:49:05 -0700
Subject: [PATCH 04/12] ARM: clps711x: Remove LATCH and CLOCK_TICK_RATE
	dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804134905.GB1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
clps711x code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-clps711x/time.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-clps711x/time.c b/arch/arm/mach-clps711x/time.c
index d581ef0..88c86f2 100644
--- a/arch/arm/mach-clps711x/time.c
+++ b/arch/arm/mach-clps711x/time.c
@@ -30,18 +30,20 @@
 
 #include <asm/mach/time.h>
 
+#define	CLPS711x_TICK_RATE	512000
+#define TIMER_LATCH		((CLPS711x_TICK_RATE + HZ/2) / HZ)
 
 /*
  * gettimeoffset() returns time since last timer tick, in usecs.
  *
- * 'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
+ * 'LATCH' is hwclock ticks per jiffy.
  * 'tick' is usecs per jiffy.
  */
 static unsigned long clps711x_gettimeoffset(void)
 {
 	unsigned long hwticks;
-	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
-	return (hwticks * (tick_nsec / 1000)) / LATCH;
+	hwticks = TIMER_LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
+	return (hwticks * (tick_nsec / 1000)) / TIMER_LATCH;
 }
 
 /*
@@ -69,7 +71,7 @@ static void __init clps711x_timer_init(void)
 	syscon |= SYSCON1_TC2S | SYSCON1_TC2M;
 	clps_writel(syscon, SYSCON1);
 
-	clps_writel(LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
+	clps_writel(TIMER_LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
 
 	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
 
-- 
1.7.4.1
