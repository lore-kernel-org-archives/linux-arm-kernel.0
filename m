From: h.feurstein@gmail.com (h.feurstein)
Date: Thu, 24 Sep 2009 16:53:32 +0200
Subject: [PATCH 2/2] ep93xx/micro9: Update platform code
Message-ID: <385aa7580909240753s4a9121fdl84c90dab13f6cf2b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: Update Contec Micro9 platform code and add Micro9-Slim support

Signed-off-by: Hubert Feurstein <hubert.feurstein@contec.at>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   11 ++
 arch/arm/mach-ep93xx/micro9.c                   |  122 +++++++++++++----------
 2 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 0fbf87b..587756d 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -218,6 +218,17 @@
 #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
+#define EP93XX_SYSCON_SYSCFG		EP93XX_SYSCON_REG(0x9c)
+#define EP93XX_SYSCON_SYSCFG_REV_MASK	(0xf0000000)
+#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	(28)
+#define EP93XX_SYSCON_SYSCFG_SBOOT	(1<<8)
+#define EP93XX_SYSCON_SYSCFG_LCSN7	(1<<7)
+#define EP93XX_SYSCON_SYSCFG_LCSN6	(1<<6)
+#define EP93XX_SYSCON_SYSCFG_LASDO	(1<<5)
+#define EP93XX_SYSCON_SYSCFG_LEEDA	(1<<4)
+#define EP93XX_SYSCON_SYSCFG_LEECLK	(1<<3)
+#define EP93XX_SYSCON_SYSCFG_LCSN2	(1<<1)
+#define EP93XX_SYSCON_SYSCFG_LCSN1	(1<<0)
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)

 #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 72e7a7d..d83b804 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -22,52 +22,78 @@
 #include <asm/mach/arch.h>


-static struct ep93xx_eth_data micro9_eth_data = {
-	.phy_id		= 0x1f,
-};
-
-static void __init micro9_init(void)
-{
-	ep93xx_register_eth(&micro9_eth_data, 1);
-}
-
-/*
- * Micro9-H
- */
-#ifdef CONFIG_MACH_MICRO9H
-static struct physmap_flash_data micro9h_flash_data = {
-	.width		= 4,
-};
-
-static struct resource micro9h_flash_resource = {
+/*************************************************************************
+ * Micro9 NOR Flash
+ *
+ * Micro9-High has up to 64MB of 32-bit flash on CS1
+ * Micro9-Mid has up to 64MB of either 32-bit or 16-bit flash on CS1
+ * Micro9-Lite uses a seperate MTD map driver for flash support
+ * Micro9-Slim has up to 64MB of either 32-bit or 16-bit flash on CS1
+ *************************************************************************/
+static struct physmap_flash_data micro9_flash_data;
+
+static struct resource micro9_flash_resource = {
 	.start		= EP93XX_CS1_PHYS_BASE,
 	.end		= EP93XX_CS1_PHYS_BASE + SZ_64M - 1,
 	.flags		= IORESOURCE_MEM,
 };

-static struct platform_device micro9h_flash = {
+static struct platform_device micro9_flash = {
 	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &micro9h_flash_data,
+		.platform_data	= &micro9_flash_data,
 	},
 	.num_resources	= 1,
-	.resource	= &micro9h_flash_resource,
+	.resource	= &micro9_flash_resource,
 };

-static void __init micro9h_init(void)
+static void __init __micro9_register_flash(unsigned int width)
 {
-	platform_device_register(&micro9h_flash);
+	micro9_flash_data.width = width;
+
+	platform_device_register(&micro9_flash);
 }

-static void __init micro9h_init_machine(void)
+static unsigned int __init micro9_detect_bootwidth(void)
+{
+	u32 v;
+
+	/* Detect the bus width of the external flash memory */
+	v = __raw_readl(EP93XX_SYSCON_SYSCFG);
+	if (v & EP93XX_SYSCON_SYSCFG_LCSN7)
+		return 4; /* 32-bit */
+	else
+		return 2; /* 16-bit */
+}
+
+static void __init micro9_register_flash(void)
+{
+	if (machine_is_micro9())
+		__micro9_register_flash(4);
+	else if (machine_is_micro9m() || machine_is_micro9s())
+		__micro9_register_flash(micro9_detect_bootwidth());
+}
+
+
+/*************************************************************************
+ * Micro9 Ethernet
+ *************************************************************************/
+static struct ep93xx_eth_data micro9_eth_data = {
+	.phy_id		= 0x1f,
+};
+
+
+static void __init micro9_init_machine(void)
 {
 	ep93xx_init_devices();
-	micro9_init();
-	micro9h_init();
+	ep93xx_register_eth(&micro9_eth_data, 1);
+	micro9_register_flash();
 }

-MACHINE_START(MICRO9, "Contec Hypercontrol Micro9-H")
+
+#ifdef CONFIG_MACH_MICRO9H
+MACHINE_START(MICRO9, "Contec Micro9-High")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
@@ -75,43 +101,25 @@ MACHINE_START(MICRO9, "Contec Hypercontrol Micro9-H")
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
-	.init_machine	= micro9h_init_machine,
+	.init_machine	= micro9_init_machine,
 MACHINE_END
 #endif

-/*
- * Micro9-M
- */
 #ifdef CONFIG_MACH_MICRO9M
-static void __init micro9m_init_machine(void)
-{
-	ep93xx_init_devices();
-	micro9_init();
-}
-
-MACHINE_START(MICRO9M, "Contec Hypercontrol Micro9-M")
+MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
-	.init_machine	= micro9m_init_machine,
+	.init_machine	= micro9_init_machine,
 MACHINE_END
 #endif

-/*
- * Micro9-L
- */
 #ifdef CONFIG_MACH_MICRO9L
-static void __init micro9l_init_machine(void)
-{
-	ep93xx_init_devices();
-	micro9_init();
-}
-
-MACHINE_START(MICRO9L, "Contec Hypercontrol Micro9-L")
+MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
@@ -119,7 +127,19 @@ MACHINE_START(MICRO9L, "Contec Hypercontrol Micro9-L")
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
-	.init_machine	= micro9l_init_machine,
+	.init_machine	= micro9_init_machine,
 MACHINE_END
 #endif

+#ifdef CONFIG_MACH_MICRO9S
+MACHINE_START(MICRO9S, "Contec Micro9-Slim")
+	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
+	.phys_io	= EP93XX_APB_PHYS_BASE,
+	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
+	.map_io		= ep93xx_map_io,
+	.init_irq	= ep93xx_init_irq,
+	.timer		= &ep93xx_timer,
+	.init_machine	= micro9_init_machine,
+MACHINE_END
+#endif
-- 
1.6.0.2
