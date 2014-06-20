From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 20 Jun 2014 17:01:26 +0200
Subject: [PATCH v3 6/7] ARM: at91: make use of the new AIC driver for dt
 enabled boards
In-Reply-To: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1403276487-8792-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove selection of OLD_IRQ_AT91 when selecting dt boards.
Select ATMEL_AIC_IRQ for sama5 SoCs (a kernel compiled for this SoC will
always use ATMEL_AIC_IRQ driver).
Select ATMEL_AIC_IRQ for at91rm9200 and at91sam9 SoCs only if OLD_IRQ_AT91
is not selected (which means we are compiling a pure DT kernel, without
any legacy board support).

Remove specific irq init code in all dt board files: this init procedure
is automatically handled in of_irq_init which is called by the arm irq core
code and is in charge of calling the appropriate aic init functions.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig           |  6 +++---
 arch/arm/mach-at91/board-dt-rm9200.c | 13 -------------
 arch/arm/mach-at91/board-dt-sam9.c   | 13 -------------
 arch/arm/mach-at91/board-dt-sama5.c  | 13 -------------
 4 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index fbc1b68..7526a93 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -52,12 +52,14 @@ config SOC_AT91SAM9
 	select AT91_SAM9_TIME
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
 
 config SOC_SAMA5
 	bool
 	select AT91_SAM9_TIME
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
+	select ATMEL_AIC_IRQ
 	select USE_OF
 
 menu "Atmel AT91 System-on-Chip"
@@ -111,6 +113,7 @@ config SOC_AT91RM9200
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_DBGU0
+	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
 	select AT91_USE_OLD_CLK
 	select HAVE_AT91_USB_CLK
 
@@ -198,7 +201,6 @@ config MACH_AT91RM9200_DT
 	bool "Atmel AT91RM9200 Evaluation Kits with device-tree support"
 	depends on SOC_AT91RM9200
 	select USE_OF
-	select OLD_IRQ_AT91
 	help
 	  Select this if you want to experiment device-tree with
 	  an Atmel RM9200 Evaluation Kit.
@@ -207,7 +209,6 @@ config MACH_AT91SAM9_DT
 	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
 	depends on SOC_AT91SAM9
 	select USE_OF
-	select OLD_IRQ_AT91
 	help
 	  Select this if you want to experiment device-tree with
 	  an Atmel Evaluation Kit.
@@ -216,7 +217,6 @@ config MACH_SAMA5_DT
 	bool "Atmel SAMA5 Evaluation Kits with device-tree support"
 	depends on SOC_SAMA5
 	select USE_OF
-	select OLD_IRQ_AT91
 	select PHYLIB if NETDEVICES
 	help
 	  Select this if you want to experiment device-tree with
diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
index 3a185fa..61ea214 100644
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ b/arch/arm/mach-at91/board-dt-rm9200.c
@@ -24,17 +24,6 @@
 #include "at91_aic.h"
 #include "generic.h"
 
-
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
 static const char *at91rm9200_dt_board_compat[] __initdata = {
 	"atmel,at91rm9200",
 	NULL
@@ -43,8 +32,6 @@ static const char *at91rm9200_dt_board_compat[] __initdata = {
 DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
 	.init_time      = at91rm9200_timer_init,
 	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91rm9200_dt_initialize,
-	.init_irq	= at91rm9200_dt_init_irq,
 	.dt_compat	= at91rm9200_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
index 575b0be..dfa8d48 100644
--- a/arch/arm/mach-at91/board-dt-sam9.c
+++ b/arch/arm/mach-at91/board-dt-sam9.c
@@ -34,17 +34,6 @@ static void __init sam9_dt_timer_init(void)
 	at91sam926x_pit_init();
 }
 
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
 static const char *at91_dt_board_compat[] __initdata = {
 	"atmel,at91sam9",
 	NULL
@@ -54,8 +43,6 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	/* Maintainer: Atmel */
 	.init_time	= sam9_dt_timer_init,
 	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91_dt_initialize,
-	.init_irq	= at91_dt_init_irq,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
index 075ec05..d6fe04b 100644
--- a/arch/arm/mach-at91/board-dt-sama5.c
+++ b/arch/arm/mach-at91/board-dt-sama5.c
@@ -35,17 +35,6 @@ static void __init sama5_dt_timer_init(void)
 	at91sam926x_pit_init();
 }
 
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
@@ -82,9 +71,7 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
 	/* Maintainer: Atmel */
 	.init_time	= sama5_dt_timer_init,
 	.map_io		= at91_map_io,
-	.handle_irq	= at91_aic5_handle_irq,
 	.init_early	= at91_dt_initialize,
-	.init_irq	= at91_dt_init_irq,
 	.init_machine	= sama5_dt_device_init,
 	.dt_compat	= sama5_dt_board_compat,
 MACHINE_END
-- 
1.8.3.2
