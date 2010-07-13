From: triad@df.lth.se (Linus Walleij)
Date: Wed, 14 Jul 2010 01:08:11 +0200
Subject: [PATCH] ARM: add character LCD platform data to the Versatile
Message-ID: <1279062491-21164-1-git-send-email-triad@df.lth.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This activates the character LCD found on the Versatile boards.
This silicon does not seem to have an IRQ line routed to the char
LCD so we're not definining this and the code shall fall back to
polling mode.

Signed-off-by: Linus Walleij <triad@df.lth.se>
---
I don't have this hardware (if you have one you can send me, thank
you very much) so I cannot test this on real HW. Testing
appreciated.
---
 arch/arm/Kconfig               |    1 +
 arch/arm/mach-versatile/core.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf30fc9..c50669a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -254,6 +254,7 @@ config ARCH_VERSATILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
 	select ARM_TIMER_SP804
+	select ARM_CHAR_LCD
 	help
 	  This enables support for ARM Ltd Versatile board.
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index f3a0e07..6ccd261 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -355,6 +355,21 @@ static struct mmci_platform_data mmc0_plat_data = {
 	.gpio_cd	= -1,
 };
 
+static struct resource char_lcd_resources[] = {
+	{
+		.start = VERSATILE_CHAR_LCD_BASE,
+		.end   = (VERSATILE_CHAR_LCD_BASE + SZ_4K - 1),
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device char_lcd_device = {
+	.name           =       "arm-charlcd",
+	.id             =       -1,
+	.num_resources  =       ARRAY_SIZE(char_lcd_resources),
+	.resource       =       char_lcd_resources,
+};
+
 /*
  * Clock handling
  */
@@ -853,6 +868,7 @@ void __init versatile_init(void)
 	platform_device_register(&versatile_flash_device);
 	platform_device_register(&versatile_i2c_device);
 	platform_device_register(&smc91x_device);
+	platform_device_register(&char_lcd_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
-- 
1.7.1
