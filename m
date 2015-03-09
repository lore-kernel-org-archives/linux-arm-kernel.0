From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:49:01 +0800
Subject: [PATCH v2.0 2/6] pm: at91: move the copying the sram function to the
 sram initializationi phase
In-Reply-To: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
References: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1425872941-7872-1-git-send-email-wenyou.yang@atmel.com>
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
index ea4d888..7cb3a33 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -29,6 +29,7 @@
 #include <linux/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
+#include <asm/fncpy.h>
 
 #include <mach/cpu.h>
 #include <mach/hardware.h>
@@ -149,9 +150,6 @@ static int at91_pm_enter(suspend_state_t state)
 			 * turning off the main oscillator; reverse on wakeup.
 			 */
 			if (slow_clock) {
-				/* copy slow_clock handler to SRAM, and call it */
-				memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
-
 				slow_clock(at91_pmc_base, at91_ramc_base[0],
 					   at91_ramc_base[1],
 					   at91_pm_data.memctrl);
@@ -295,6 +293,13 @@ static void __init at91_pm_sram_init(void)
 
 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
 	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
+	if (!slow_clock) {
+		pr_warn("SRAM: Could not map\n");
+		return;
+	}
+
+	/* Copy the slow_clock handler to SRAM */
+	slow_clock = fncpy(slow_clock, &at91_slow_clock, at91_slow_clock_sz);
 }
 
 static void __init at91_pm_init(void)
@@ -304,7 +309,10 @@ static void __init at91_pm_init(void)
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
