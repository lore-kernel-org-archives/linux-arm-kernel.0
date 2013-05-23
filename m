From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 23 May 2013 17:48:55 +0200
Subject: [PATCH v2 3/3] ARM: at91: use IRQCHIP_DECLARE instead of machine
 specific init_irq
In-Reply-To: <1369324135-31211-1-git-send-email-b.brezillon@overkiz.com>
References: <1369324135-31211-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1369324135-31211-4-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace machine specific init_irq functions with IRQCHIP_DECLARE.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/board-dt-rm9200.c |   11 -----------
 arch/arm/mach-at91/board-dt-sam9.c   |   12 ------------
 arch/arm/mach-at91/board-dt-sama5.c  |   12 ------------
 arch/arm/mach-at91/generic.h         |    5 -----
 drivers/irqchip/irq-at91.c           |    4 ++++
 5 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
index 67fff54..7ee7e5f 100644
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ b/arch/arm/mach-at91/board-dt-rm9200.c
@@ -26,16 +26,6 @@
 #include "generic.h"
 
 
-static const struct of_device_id irq_of_match[] __initconst = {
-	{ .compatible = "atmel,at91rm9200-aic", .data = at91_aic_of_init },
-	{ /*sentinel*/ }
-};
-
-static void __init at91rm9200_dt_init_irq(void)
-{
-	of_irq_init(irq_of_match);
-}
-
 static void __init at91rm9200_dt_device_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -50,7 +40,6 @@ DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
 	.init_time      = at91rm9200_timer_init,
 	.map_io		= at91_map_io,
 	.init_early	= at91rm9200_dt_initialize,
-	.init_irq	= at91rm9200_dt_init_irq,
 	.init_machine	= at91rm9200_dt_device_init,
 	.dt_compat	= at91rm9200_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
index 65edc6e..e7aa089 100644
--- a/arch/arm/mach-at91/board-dt-sam9.c
+++ b/arch/arm/mach-at91/board-dt-sam9.c
@@ -26,17 +26,6 @@
 #include "generic.h"
 
 
-static const struct of_device_id irq_of_match[] __initconst = {
-
-	{ .compatible = "atmel,at91rm9200-aic", .data = at91_aic_of_init },
-	{ /*sentinel*/ }
-};
-
-static void __init at91_dt_init_irq(void)
-{
-	of_irq_init(irq_of_match);
-}
-
 static void __init at91_dt_device_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -52,7 +41,6 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	.init_time	= at91sam926x_pit_init,
 	.map_io		= at91_map_io,
 	.init_early	= at91_dt_initialize,
-	.init_irq	= at91_dt_init_irq,
 	.init_machine	= at91_dt_device_init,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
index 015178f..b3b6a1b 100644
--- a/arch/arm/mach-at91/board-dt-sama5.c
+++ b/arch/arm/mach-at91/board-dt-sama5.c
@@ -27,17 +27,6 @@
 #include "generic.h"
 
 
-static const struct of_device_id irq_of_match[] __initconst = {
-
-	{ .compatible = "atmel,sama5d3-aic", .data = at91_aic5_of_init },
-	{ /*sentinel*/ }
-};
-
-static void __init at91_dt_init_irq(void)
-{
-	of_irq_init(irq_of_match);
-}
-
 static int ksz9021rn_phy_fixup(struct phy_device *phy)
 {
 	int value;
@@ -79,7 +68,6 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
 	.init_time	= at91sam926x_pit_init,
 	.map_io		= at91_map_io,
 	.init_early	= at91_dt_initialize,
-	.init_irq	= at91_dt_init_irq,
 	.init_machine	= sama5_dt_device_init,
 	.dt_compat	= sama5_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 78ab065..23077cf 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -29,11 +29,6 @@ extern void __init at91_init_interrupts(unsigned int priority[]);
 extern void __init at91x40_init_interrupts(unsigned int priority[]);
 extern void __init at91_aic_init(unsigned int priority[],
 				 unsigned int ext_irq_mask);
-extern int  __init at91_aic_of_init(struct device_node *node,
-				    struct device_node *parent);
-extern int  __init at91_aic5_of_init(struct device_node *node,
-				    struct device_node *parent);
-
 
  /* Timer */
 extern void at91rm9200_ioremap_st(u32 addr);
diff --git a/drivers/irqchip/irq-at91.c b/drivers/irqchip/irq-at91.c
index ca49096..137d428 100644
--- a/drivers/irqchip/irq-at91.c
+++ b/drivers/irqchip/irq-at91.c
@@ -43,6 +43,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
+#include "irqchip.h"
+
 
 void __iomem *at91_aic_base;
 static struct irq_domain *at91_aic_domain;
@@ -473,6 +475,7 @@ int __init at91_aic_of_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(at91rm9200_aic, "atmel,at91rm9200-aic", at91_aic_of_init);
 
 int __init at91_aic5_of_init(struct device_node *node,
 				     struct device_node *parent)
@@ -497,6 +500,7 @@ int __init at91_aic5_of_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(sama5d3_aic, "atmel,sama5d3-aic", at91_aic5_of_init);
 #endif
 
 /*
-- 
1.7.9.5
