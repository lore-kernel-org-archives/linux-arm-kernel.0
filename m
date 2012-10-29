From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Oct 2012 15:24:18 +0100
Subject: [PATCH] clocksource: arm_generic: use integer math helpers
Message-ID: <1351520658-23028-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will make the two crucial integer divisions in the generic
ARM arch timer used for ARMv8 use the kernel DIV_ROUND_CLOSEST()
helper inline from <linux/kernel.h> so they get more precise.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/arm_generic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_generic.c b/drivers/clocksource/arm_generic.c
index c4d9f95..6cd1b30 100644
--- a/drivers/clocksource/arm_generic.c
+++ b/drivers/clocksource/arm_generic.c
@@ -127,7 +127,7 @@ static void __init arch_timer_calibrate(void)
 
 	/* Cache the sched_clock multiplier to save a divide in the hot path. */
 
-	sched_clock_mult = NSEC_PER_SEC / arch_timer_rate;
+	sched_clock_mult = DIV_ROUND_CLOSEST(NSEC_PER_SEC, arch_timer_rate);
 
 	pr_info("Architected local timer running at %u.%02uMHz.\n",
 		 arch_timer_rate / 1000000, (arch_timer_rate / 10000) % 100);
@@ -221,7 +221,7 @@ int __init arm_generic_timer_init(void)
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 
 	/* Calibrate the delay loop directly */
-	lpj_fine = arch_timer_rate / HZ;
+	lpj_fine = DIV_ROUND_CLOSEST(arch_timer_rate, HZ);
 
 	/* Immediately configure the timer on the boot CPU */
 	arch_timer_setup(per_cpu_ptr(&arch_timer_evt, smp_processor_id()));
-- 
1.7.7.6
