From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu,  9 Mar 2017 17:58:38 +0100
Subject: [PATCH v1] Revert "clocksource/drivers/tcb_clksrc: Use 32 bit tcb as
 sched_clock"
Message-ID: <20170309165838.7683-1-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 7b9f1d16e6d1 ("clocksource/drivers/tcb_clksrc: Use
32 bit tcb as sched_clock"). In the current state, the kernel warns
against a late registration of the new sched_clock, the printk clock
resets after only a few minutes, and it seems that scheduling can be
affected as well.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/clocksource/tcb_clksrc.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 745844ee973e..d4ca9962a759 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/atmel_tc.h>
-#include <linux/sched_clock.h>
 
 
 /*
@@ -57,14 +56,9 @@ static u64 tc_get_cycles(struct clocksource *cs)
 	return (upper << 16) | lower;
 }
 
-static u32 tc_get_cv32(void)
-{
-	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
-}
-
 static u64 tc_get_cycles32(struct clocksource *cs)
 {
-	return tc_get_cv32();
+	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
 static struct clocksource clksrc = {
@@ -75,11 +69,6 @@ static struct clocksource clksrc = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace tc_read_sched_clock(void)
-{
-	return tc_get_cv32();
-}
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -350,9 +339,6 @@ static int __init tcb_clksrc_init(void)
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(tc, best_divisor_idx);
-
-		/* register sched_clock on chips with single 32 bit counter */
-		sched_clock_register(tc_read_sched_clock, 32, divided_rate);
 	} else {
 		/* tclib will give us three clocks no matter what the
 		 * underlying platform supports.
-- 
2.9.3
