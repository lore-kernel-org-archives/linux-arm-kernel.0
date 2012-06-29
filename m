From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 29 Jun 2012 11:42:42 +0400
Subject: [PATCH] ARM: clps711x: Remove the setting of the time
Message-ID: <1340955762-8318-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes "bug: interrupts were enabled early" due to
do_settimeofday() which used in common code for clps711x-platform.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index c965fd8..f15293b 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -26,7 +26,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/sched.h>
-#include <linux/timex.h>
 
 #include <asm/sizes.h>
 #include <mach/hardware.h>
@@ -188,7 +187,6 @@ static struct irqaction clps711x_timer_irq = {
 
 static void __init clps711x_timer_init(void)
 {
-	struct timespec tv;
 	unsigned int syscon;
 
 	syscon = clps_readl(SYSCON1);
@@ -198,10 +196,6 @@ static void __init clps711x_timer_init(void)
 	clps_writel(LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
 
 	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = clps_readl(RTCDR);
-	do_settimeofday(&tv);
 }
 
 struct sys_timer clps711x_timer = {
-- 
1.7.3.4
