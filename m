From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 23 May 2013 10:49:49 +0200
Subject: [PATCH 2/3] ARM: at91: use IRQCHIP_DECLARE instead of machine
 specific init_irq
In-Reply-To: <1369298990-9826-1-git-send-email-b.brezillon@overkiz.com>
References: <1369298990-9826-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1369298990-9826-3-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <brezillonboris@gmail.com>

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
index 0c2a06d..523a9ae 100644
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ b/arch/arm/mach-at91/board-dt-rm9200.c
@@ -27,16 +27,6 @@
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
@@ -52,7 +42,6 @@ DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91rm9200_dt_initialize,
-	.init_irq	= at91rm9200_dt_init_irq,
 	.init_machine	= at91rm9200_dt_device_init,
 	.dt_compat	= at91rm9200_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
index ac899d8..a07da3b 100644
--- a/arch/arm/mach-at91/board-dt-sam9.c
+++ b/arch/arm/mach-at91/board-dt-sam9.c
@@ -27,17 +27,6 @@
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
@@ -54,7 +43,6 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91_dt_initialize,
-	.init_irq	= at91_dt_init_irq,
 	.init_machine	= at91_dt_device_init,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
index 43b8f7a..65cf099 100644
--- a/arch/arm/mach-at91/board-dt-sama5.c
+++ b/arch/arm/mach-at91/board-dt-sama5.c
@@ -28,17 +28,6 @@
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
@@ -81,7 +70,6 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic5_handle_irq,
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
index daf2959..b45fe2c 100644
--- a/drivers/irqchip/irq-at91.c
+++ b/drivers/irqchip/irq-at91.c
@@ -44,6 +44,8 @@
 
 #include <mach/at91_aic.h>
 
+#include "irqchip.h"
+
 void __iomem *at91_aic_base;
 static struct irq_domain *at91_aic_domain;
 static struct device_node *at91_aic_np;
@@ -471,6 +473,7 @@ int __init at91_aic_of_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(at91rm9200_aic, "atmel,at91rm9200-aic", at91_aic_of_init);
 
 int __init at91_aic5_of_init(struct device_node *node,
 				     struct device_node *parent)
@@ -493,6 +496,7 @@ int __init at91_aic5_of_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(sama5d3_aic, "atmel,sama5d3-aic", at91_aic5_of_init);
 #endif
 
 /*
-- 
1.7.9.5
