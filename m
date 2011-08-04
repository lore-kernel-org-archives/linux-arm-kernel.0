From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:53:32 -0700
Subject: [PATCH 10/12] ARM: pnx4000:  Remove LATCH and CLOCK_TICK_RATE
	dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804135332.GH1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
pnx4000 code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-pnx4008/time.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index 0c8aad4..8aa48a4 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -34,6 +34,9 @@
 
 /*! Note: all timers are UPCOUNTING */
 
+#define HSTIM_TICK_RATE		1000000
+#define HSTIM_TIMER_LATCH	((HSTIM_TICK_RATE + HZ/2) / HZ)
+
 /*!
  * Returns number of us since last clock interrupt.  Note that interrupts
  * will have been disabled by do_gettimeoffset()
@@ -42,8 +45,8 @@ static unsigned long pnx4008_gettimeoffset(void)
 {
 	u32 ticks_to_match =
 	    __raw_readl(HSTIM_MATCH0) - __raw_readl(HSTIM_COUNTER);
-	u32 elapsed = LATCH - ticks_to_match;
-	return (elapsed * (tick_nsec / 1000)) / LATCH;
+	u32 elapsed = HSTIM_TIMER_LATCH - ticks_to_match;
+	return (elapsed * (tick_nsec / 1000)) / HSTIM_TIMER_LATCH;
 }
 
 /*!
@@ -61,7 +64,7 @@ static irqreturn_t pnx4008_timer_interrupt(int irq, void *dev_id)
 			 * for this interrupt handling longer than a normal
 			 * timer period
 			 */
-			__raw_writel(__raw_readl(HSTIM_MATCH0) + LATCH,
+			__raw_writel(__raw_readl(HSTIM_MATCH0) + HSTIM_TIMER_LATCH,
 				     HSTIM_MATCH0);
 			__raw_writel(MATCH0_INT, HSTIM_INT);	/* clear interrupt */
 
@@ -100,7 +103,7 @@ static __init void pnx4008_setup_timer(void)
 	__raw_writel(0, HSTIM_MCTRL);
 	__raw_writel(0, HSTIM_CCR);
 	__raw_writel(12, HSTIM_PMATCH);	/* scale down to 1 MHZ */
-	__raw_writel(LATCH, HSTIM_MATCH0);
+	__raw_writel(HSTIM_TIMER_LATCH, HSTIM_MATCH0);
 	__raw_writel(MR0_INT, HSTIM_MCTRL);
 
 	setup_irq(HSTIMER_INT, &pnx4008_timer_irq);
-- 
1.7.4.1
