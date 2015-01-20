From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 20 Jan 2015 16:16:57 +0800
Subject: [PATCH 04/12] pm: at91: move the copying the sram function to the
 sram initializationi phase
In-Reply-To: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
References: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1421741825-18226-5-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To decrease the suspend time, move the copying the sram function
to the sram initialization phase, instead of every time go to suspend.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 0990486..609a4f8 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -169,10 +169,6 @@ static int at91_pm_enter(suspend_state_t state)
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
@@ -280,6 +276,9 @@ static void __init at91_pm_sram_init(void)
 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
 	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
 
+	/* Copy slow_clock handler to SRAM, and call it */
+	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
+
 put_node:
 	of_node_put(node);
 }
-- 
1.7.9.5
