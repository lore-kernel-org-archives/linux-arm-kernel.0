From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 20:16:08 +0100
Subject: [PATCH 6/6] ARM: at91/board-dt: remove AIC irq domain from board file
In-Reply-To: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <9fea5224b3a6544bd07c6e877d12870de9403b98.1323975517.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding of irqdomain in AIC code make the specification
of the irq domain in board file useless.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-dt.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index bb6b434..119eda6 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -15,8 +15,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/gpio.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
 #include <mach/hardware.h>
@@ -88,17 +86,6 @@ static void __init ek_add_device_nand(void)
 	at91_add_device_nand(&ek_nand_data);
 }
 
-static const struct of_device_id aic_of_match[] __initconst = {
-	{ .compatible = "atmel,at91rm9200-aic", },
-	{},
-};
-
-static void __init at91_dt_init_irq(void)
-{
-	irq_domain_generate_simple(aic_of_match, 0xfffff000, 0);
-	at91_init_irq_default();
-}
-
 static void __init at91_dt_device_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -118,7 +105,7 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
 	.init_early	= ek_init_early,
-	.init_irq	= at91_dt_init_irq,
+	.init_irq	= at91_init_irq_default,
 	.init_machine	= at91_dt_device_init,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
-- 
1.7.5.4
