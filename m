From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 29 Jan 2015 14:38:55 +0800
Subject: [PATCH v5 05/13] pm: at91: move the copying the sram function to the
 sram initializationi phase
In-Reply-To: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
References: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422513535-23885-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To decrease the suspend time, move the copying the sram function
to the sram initialization phase, instead of every time go to suspend.

In the meanwhile, if there is no sram allocated for PM, the PM is not supported.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index daa998d..6df0152 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -163,10 +163,6 @@ static int at91_pm_enter(suspend_state_t state)
 			 * turning off the main oscillator; reverse on wakeup.
 			 */
 			if (slow_clock) {
-#ifdef CONFIG_AT91_SLOW_CLOCK
-				/* copy slow_clock handler to SRAM, and call it */
-				memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
-#endif
 				slow_clock(at91_pmc_base, at91_ramc_base[0],
 					   at91_ramc_base[1],
 					   at91_pm_data.memctrl);
@@ -311,6 +307,9 @@ static void __init at91_pm_sram_init(void)
 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
 	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
 
+	/* Copy the slow_clock handler to SRAM */
+	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
+
 put_node:
 	of_node_put(node);
 }
@@ -328,7 +327,10 @@ static void __init at91_pm_init(void)
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
-	suspend_set_ops(&at91_pm_ops);
+	if (slow_clock)
+		suspend_set_ops(&at91_pm_ops);
+	else
+		pr_info("AT91: PM : Not supported, due to no sram allocated\n");
 }
 
 void __init at91rm9200_pm_init(void)
-- 
1.7.9.5
