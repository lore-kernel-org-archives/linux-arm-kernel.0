From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:50:14 -0700
Subject: [PATCH 06/12] ARM: IXP23xx: Remove LATCH and CLOCK_TICK_RATE
	dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804135014.GD1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
ixp23xx code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-ixp23xx/core.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index a1bee33..03eba95 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -336,7 +336,9 @@ void __init ixp23xx_init_irq(void)
 /*************************************************************************
  * Timer-tick functions for IXP23xx
  *************************************************************************/
-#define CLOCK_TICKS_PER_USEC	(CLOCK_TICK_RATE / USEC_PER_SEC)
+#define IXP23XX_TICK_RATE 75000000
+#define IXP23XX_TICKS_PER_USEC	(IXP23XX_TICK_RATE / USEC_PER_SEC)
+#define IXP23XX_TIMER_LATCH	((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
 
 static unsigned long next_jiffy_time;
 
@@ -345,7 +347,7 @@ ixp23xx_gettimeoffset(void)
 {
 	unsigned long elapsed;
 
-	elapsed = *IXP23XX_TIMER_CONT - (next_jiffy_time - LATCH);
+	elapsed = *IXP23XX_TIMER_CONT - (next_jiffy_time - IXP23XX_TIMER_LATCH);
 
 	return elapsed / CLOCK_TICKS_PER_USEC;
 }
@@ -355,9 +357,9 @@ ixp23xx_timer_interrupt(int irq, void *dev_id)
 {
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP23XX_TIMER_STATUS = IXP23XX_TIMER1_INT_PEND;
-	while ((signed long)(*IXP23XX_TIMER_CONT - next_jiffy_time) >= LATCH) {
+	while ((signed long)(*IXP23XX_TIMER_CONT - next_jiffy_time) >= IXP23XX_TIMER_LATCH) {
 		timer_tick();
-		next_jiffy_time += LATCH;
+		next_jiffy_time += IXP23XX_TIMER_LATCH;
 	}
 
 	return IRQ_HANDLED;
@@ -376,10 +378,10 @@ void __init ixp23xx_init_timer(void)
 
 	/* Setup the Timer counter value */
 	*IXP23XX_TIMER1_RELOAD =
-		(LATCH & ~IXP23XX_TIMER_RELOAD_MASK) | IXP23XX_TIMER_ENABLE;
+		(IXP23XX_TIMER_LATCH & ~IXP23XX_TIMER_RELOAD_MASK) | IXP23XX_TIMER_ENABLE;
 
 	*IXP23XX_TIMER_CONT = 0;
-	next_jiffy_time = LATCH;
+	next_jiffy_time = IXP23XX_TIMER_LATCH;
 
 	/* Connect the interrupt handler and enable the interrupt */
 	setup_irq(IRQ_IXP23XX_TIMER1, &ixp23xx_timer_irq);
-- 
1.7.4.1
