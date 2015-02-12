From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:46:49 +0800
Subject: [PATCH 2/6] pm: at91: move the copying the sram function to the sram
 initializationi phase
In-Reply-To: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423709209-8108-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To decrease the suspend time, move copying the sram function to the sram
initialization phase, instead of every time go to suspend.

In the meanwhile, substitute fncpy() for memcpy().

If there is no sram allocated for PM, the PM is not supported.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f358e7d..9feee81 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -29,6 +29,7 @@
 #include <linux/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
+#include <asm/fncpy.h>
 
 #include <mach/cpu.h>
 #include <mach/hardware.h>
@@ -161,9 +162,6 @@ static int at91_pm_enter(suspend_state_t state)
 			 * turning off the main oscillator; reverse on wakeup.
 			 */
 			if (slow_clock) {
-				/* copy slow_clock handler to SRAM, and call it */
-				memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
-
 				slow_clock(at91_pmc_base, at91_ramc_base[0],
 					   at91_ramc_base[1],
 					   at91_pm_data.memctrl);
@@ -306,6 +304,13 @@ static void __init at91_pm_sram_init(void)
 
 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
 	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
+	if (!slow_clock) {
+		pr_warn("SRAM: Could not map\n");
+		goto put_node;
+	}
+
+	/* Copy the slow_clock handler to SRAM */
+	slow_clock = fncpy(slow_clock, &at91_slow_clock, at91_slow_clock_sz);
 
 put_node:
 	of_node_put(node);
@@ -318,7 +323,10 @@ static void __init at91_pm_init(void)
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
-	suspend_set_ops(&at91_pm_ops);
+	if (slow_clock)
+		suspend_set_ops(&at91_pm_ops);
+	else
+		pr_info("AT91: PM not supported, due to no SRAM allocated\n");
 }
 
 void __init at91rm9200_pm_init(void)
-- 
1.7.9.5
