From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:25 +0000
Subject: [PATCHv5 02/16] arm: arch_timer: remove redundant available check
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This check is a holdover from the pre-devicetree days. As the timer
is not probed except by platforms which register it via devicetree,
it's not strictly necessary.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/arch_timer.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 6dd73c6..1bb3b582 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -20,11 +20,9 @@
 #include <linux/of_irq.h>
 #include <linux/io.h>
 
-#include <asm/cputype.h>
 #include <asm/delay.h>
 #include <asm/localtimer.h>
 #include <asm/arch_timer.h>
-#include <asm/system_info.h>
 #include <asm/sched_clock.h>
 
 static unsigned long arch_timer_rate;
@@ -259,20 +257,10 @@ static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
 	return 0;
 }
 
-/* Is the optional system timer available? */
-static int local_timer_is_architected(void)
-{
-	return (cpu_architecture() >= CPU_ARCH_ARMv7) &&
-	       ((read_cpuid_ext(CPUID_EXT_PFR1) >> 16) & 0xf) == 1;
-}
-
 static int arch_timer_available(void)
 {
 	unsigned long freq;
 
-	if (!local_timer_is_architected())
-		return -ENXIO;
-
 	if (arch_timer_rate == 0) {
 		freq = arch_timer_reg_read(ARCH_TIMER_PHYS_ACCESS,
 					   ARCH_TIMER_REG_FREQ);
-- 
1.8.1.1
