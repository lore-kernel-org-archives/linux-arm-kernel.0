From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Sat, 15 Jan 2011 18:50:35 +0100
Subject: [RFC 2/2] AT91: Update board-cpu9krea to support the 9260/9G20
	variants in a single image
In-Reply-To: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
References: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
Message-ID: <1295113835-6776-2-git-send-email-albin.tonnerre@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since patch "Support SAM9260 and SAM9G20-based boards in the same kernel
image" makes it possible to support both types of SoCs, cpu9krea must be
updated to cope with that. Otherwise, selecting both the 9260 and 9G20
variants will result in only the 9260 variant being supported.

Signed-off-by: Albin Tonnerre <albin.tonnerre@free-electrons.com>
---
 arch/arm/mach-at91/board-cpu9krea.c |   48 +++++++++++++++++++++++++++++------
 1 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 3838594..6d741bb 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -38,6 +38,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <mach/cpu.h>
 #include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/gpio.h>
@@ -120,7 +121,7 @@ static struct atmel_nand_data __initdata cpu9krea_nand_data = {
 };
 
 #ifdef CONFIG_MACH_CPU9260
-static struct sam9_smc_config __initdata cpu9krea_nand_smc_config = {
+static struct sam9_smc_config __initdata cpu9krea_9260_nand_smc_config = {
 	.ncs_read_setup		= 0,
 	.nrd_setup		= 1,
 	.ncs_write_setup	= 0,
@@ -138,8 +139,13 @@ static struct sam9_smc_config __initdata cpu9krea_nand_smc_config = {
 		| AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
 	.tdf_cycles		= 2,
 };
+#define CPU9KREA_9260_NAND_CFG (&cpu9krea_9260_nand_smc_config)
 #else
-static struct sam9_smc_config __initdata cpu9krea_nand_smc_config = {
+#define CPU9KREA_9260_NAND_CFG NULL
+#endif
+
+#ifdef CONFIG_MACH_CPU9G20
+static struct sam9_smc_config __initdata cpu9krea_9g20_nand_smc_config = {
 	.ncs_read_setup		= 0,
 	.nrd_setup		= 2,
 	.ncs_write_setup	= 0,
@@ -157,11 +163,17 @@ static struct sam9_smc_config __initdata cpu9krea_nand_smc_config = {
 		| AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
 	.tdf_cycles		= 3,
 };
+#define CPU9KREA_9G20_NAND_CFG (&cpu9krea_9g20_nand_smc_config)
+#else
+#define CPU9KREA_9G20_NAND_CFG NULL
 #endif
 
 static void __init cpu9krea_add_device_nand(void)
 {
-	sam9_smc_configure(3, &cpu9krea_nand_smc_config);
+	if (cpu_is_at91sam9260())
+		sam9_smc_configure(3, CPU9KREA_9260_NAND_CFG);
+	else
+		sam9_smc_configure(3, CPU9KREA_9G20_NAND_CFG);
 	at91_add_device_nand(&cpu9krea_nand_data);
 }
 
@@ -194,7 +206,7 @@ static struct platform_device cpu9krea_nor_flash = {
 };
 
 #ifdef CONFIG_MACH_CPU9260
-static struct sam9_smc_config __initdata cpu9krea_nor_smc_config = {
+static struct sam9_smc_config __initdata cpu9krea_9260_nor_smc_config = {
 	.ncs_read_setup		= 0,
 	.nrd_setup		= 1,
 	.ncs_write_setup	= 0,
@@ -213,8 +225,13 @@ static struct sam9_smc_config __initdata cpu9krea_nor_smc_config = {
 			| AT91_SMC_DBW_16,
 	.tdf_cycles		= 2,
 };
+#define CPU9KREA_9260_NOR_CFG (&cpu9krea_9260_nor_smc_config)
 #else
-static struct sam9_smc_config __initdata cpu9krea_nor_smc_config = {
+#define CPU9KREA_9260_NOR_CFG NULL
+#endif
+
+#ifdef CONFIG_MACH_CPU9G20
+static struct sam9_smc_config __initdata cpu9krea_9g20_nor_smc_config = {
 	.ncs_read_setup		= 0,
 	.nrd_setup		= 1,
 	.ncs_write_setup	= 0,
@@ -233,6 +250,9 @@ static struct sam9_smc_config __initdata cpu9krea_nor_smc_config = {
 			| AT91_SMC_DBW_16,
 	.tdf_cycles		= 2,
 };
+#define CPU9KREA_9G20_NOR_CFG (&cpu9krea_9g20_nor_smc_config)
+#else
+#define CPU9KREA_9G20_NOR_CFG NULL
 #endif
 
 static __init void cpu9krea_add_device_nor(void)
@@ -243,7 +263,10 @@ static __init void cpu9krea_add_device_nor(void)
 	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_VDDIOMSEL_3_3V);
 
 	/* configure chip-select 0 (NOR) */
-	sam9_smc_configure(0, &cpu9krea_nor_smc_config);
+	if (cpu_is_at91sam9260())
+		sam9_smc_configure(0, CPU9KREA_9260_NOR_CFG);
+	else
+		sam9_smc_configure(0, CPU9KREA_9G20_NOR_CFG);
 
 	platform_device_register(&cpu9krea_nor_flash);
 }
@@ -371,9 +394,17 @@ static void __init cpu9krea_board_init(void)
 
 #ifdef CONFIG_MACH_CPU9260
 MACHINE_START(CPUAT9260, "Eukrea CPU9260")
-#else
-MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
+	/* Maintainer: Eric Benard - EUKREA Electromatique */
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= cpu9krea_map_io,
+	.init_irq	= cpu9krea_init_irq,
+	.init_machine	= cpu9krea_board_init,
+MACHINE_END
 #endif
+
+#ifdef CONFIG_MACH_CPU9G20
+MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
@@ -381,3 +412,4 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 	.init_irq	= cpu9krea_init_irq,
 	.init_machine	= cpu9krea_board_init,
 MACHINE_END
+#endif
-- 
1.7.2.3
