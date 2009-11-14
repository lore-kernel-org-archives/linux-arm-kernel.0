From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 14 Nov 2009 15:58:50 +0100
Subject: [PATCH] Convert viper to use plat_serial8250_port irqflags field
Message-ID: <20091114155850.3adfdf86@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use .irqflags in the plat_serial8250_port structure to set IRQ
polarity, and get rid of the corresponding set_irq_type().

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/viper.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index d33c232..df168b9 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -301,15 +301,6 @@ static void __init viper_init_irq(void)
 	set_irq_chained_handler(gpio_to_irq(VIPER_CPLD_GPIO),
 				viper_irq_handler);
 	set_irq_type(gpio_to_irq(VIPER_CPLD_GPIO), IRQ_TYPE_EDGE_BOTH);
-
-#ifndef CONFIG_SERIAL_PXA
-	/*
-	 * 8250 doesn't support IRQ_TYPE being passed as part
-	 * of the plat_serial8250_port structure...
-	 */
-	set_irq_type(gpio_to_irq(VIPER_UARTA_GPIO), IRQ_TYPE_EDGE_RISING);
-	set_irq_type(gpio_to_irq(VIPER_UARTB_GPIO), IRQ_TYPE_EDGE_RISING);
-#endif
 }
 
 /* Flat Panel */
@@ -539,6 +530,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase	= VIPER_UARTA_PHYS,
 		.irq		= gpio_to_irq(VIPER_UARTA_GPIO),
+		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 1843200,
 		.regshift	= 1,
 		.iotype		= UPIO_MEM,
@@ -548,6 +540,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase	= VIPER_UARTB_PHYS,
 		.irq		= gpio_to_irq(VIPER_UARTB_GPIO),
+		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 1843200,
 		.regshift	= 1,
 		.iotype		= UPIO_MEM,
-- 
1.6.0.4



-- 
I'm the slime oozin' out from your TV set...
