From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Apr 2015 17:11:23 -0700
Subject: [PATCH] ARM: OMAP1: Fix OSK5912 wake-up key by removing useless
 CONFIG_PM defines
Message-ID: <1429834283-29683-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wake-up key does not depend on CONFIG_PM, that just keeps it
from getting compiled producing the following warning:

board-osk.c:513:7: warning: unused variable ?ret? [-Wunused-variable]

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 7436d4c..8d65309d 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -441,13 +441,11 @@ static struct spi_board_info __initdata mistral_boardinfo[] = { {
 	.chip_select		= 0,
 } };
 
-#ifdef	CONFIG_PM
 static irqreturn_t
 osk_mistral_wake_interrupt(int irq, void *ignored)
 {
 	return IRQ_HANDLED;
 }
-#endif
 
 static void __init osk_mistral_init(void)
 {
@@ -515,7 +513,7 @@ static void __init osk_mistral_init(void)
 
 		gpio_direction_input(OMAP_MPUIO(2));
 		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
-#ifdef	CONFIG_PM
+
 		/* share the IRQ in case someone wants to use the
 		 * button for more than wakeup from system sleep.
 		 */
@@ -529,7 +527,6 @@ static void __init osk_mistral_init(void)
 				ret);
 		} else
 			enable_irq_wake(irq);
-#endif
 	} else
 		printk(KERN_ERR "OSK+Mistral: wakeup button is awol\n");
 
-- 
2.1.4
