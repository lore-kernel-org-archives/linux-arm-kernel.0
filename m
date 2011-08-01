From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 2 Aug 2011 00:43:10 +0200
Subject: [PATCH 1/3] ARM: mmp: Also start timer 1 on boot.
Message-ID: <20110801224309.GG912@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, arch-mmp/time.c uses timer 0 both as a clocksource timer
and as a clockevent timer, the latter by setting up a comparator
interrupt to match on 'current_time + delta'.  This is problematic
if delta is small enough, as that can lead to 'current_time + delta'
already being in the past when comparator setup has finished, leading
to the requested event not triggering.

As there is also a silicon issue that requires stopping a timer's
counter while writing to one of its match registers, we'll switch to
using two separate timers -- timer 0 as clockevent timer, which we'll
start and stop on every invocation of ->set_next_event(), and timer 1
as clocksource timer, which will be free-running.

This first patch enables timer 1 on boot, so that we can use it as
clocksource timer.

Signed-off-by: Lennert Buytenhek <buytenh@laptop.org>
---
 arch/arm/mach-mmp/time.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 99833b9..b0ce1a8 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -145,23 +145,26 @@ static struct clocksource cksrc = {
 static void __init timer_config(void)
 {
 	uint32_t ccr = __raw_readl(TIMERS_VIRT_BASE + TMR_CCR);
-	uint32_t cer = __raw_readl(TIMERS_VIRT_BASE + TMR_CER);
-	uint32_t cmr = __raw_readl(TIMERS_VIRT_BASE + TMR_CMR);
 
-	__raw_writel(cer & ~0x1, TIMERS_VIRT_BASE + TMR_CER); /* disable */
+	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_CER); /* disable */
 
-	ccr &= (cpu_is_mmp2()) ? TMR_CCR_CS_0(0) : TMR_CCR_CS_0(3);
+	ccr &= (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
+		(TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
 	__raw_writel(ccr, TIMERS_VIRT_BASE + TMR_CCR);
 
 	/* free-running mode */
-	__raw_writel(cmr | 0x01, TIMERS_VIRT_BASE + TMR_CMR);
+	__raw_writel(0x3, TIMERS_VIRT_BASE + TMR_CMR);
 
 	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_PLCR(0)); /* free-running */
 	__raw_writel(0x7, TIMERS_VIRT_BASE + TMR_ICR(0));  /* clear status */
 	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_IER(0));
 
+	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_PLCR(1)); /* free-running */
+	__raw_writel(0x7, TIMERS_VIRT_BASE + TMR_ICR(1));  /* clear status */
+	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_IER(1));
+
 	/* enable timer counter */
-	__raw_writel(cer | 0x01, TIMERS_VIRT_BASE + TMR_CER);
+	__raw_writel(0x3, TIMERS_VIRT_BASE + TMR_CER);
 }
 
 static struct irqaction timer_irq = {
-- 
1.7.6
