From: triad@df.lth.se (Linus Walleij)
Date: Tue,  6 Jul 2010 17:21:26 +0200
Subject: [PATCH 3/3] ARM: register character LCD for RealView EB
Message-ID: <1278429686-5109-1-git-send-email-triad@df.lth.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers the character LCD device for the ARM RealView
Emulation Baseboard variants.

Signed-off-by: Linus Walleij <triad@df.lth.se>
---
The remaining PB11MPCore, PB-A8 and PBX-A9 seem to be those boxen
without any LCD fitted, so no point in adding the device on those,
even though the driver logic appears to be in the circuitry for all
of them.
---
 arch/arm/mach-realview/Kconfig       |    1 +
 arch/arm/mach-realview/realview_eb.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 511d67d..3c66ba8 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -4,6 +4,7 @@ menu "RealView platform type"
 config MACH_REALVIEW_EB
 	bool "Support RealView/EB platform"
 	select ARM_GIC
+	select ARM_CHAR_LCD
 	help
 	  Include support for the ARM(R) RealView Emulation Baseboard platform.
 
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 4425018..8770d26 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -324,6 +324,26 @@ static struct platform_device pmu_device = {
 	.resource		= pmu_resources,
 };
 
+static struct resource char_lcd_resources[] = {
+	{
+		.start = REALVIEW_CHAR_LCD_BASE,
+		.end   = (REALVIEW_CHAR_LCD_BASE + SZ_4K - 1),
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_EB_CHARLCD,
+		.end	= IRQ_EB_CHARLCD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device char_lcd_device = {
+	.name		=	"arm-charlcd",
+	.id		=	-1,
+	.num_resources	=	ARRAY_SIZE(char_lcd_resources),
+	.resource	=	char_lcd_resources,
+};
+
 static void __init gic_init_irq(void)
 {
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
@@ -442,6 +462,7 @@ static void __init realview_eb_init(void)
 
 	realview_flash_register(&realview_eb_flash_resource, 1);
 	platform_device_register(&realview_i2c_device);
+	platform_device_register(&char_lcd_device);
 	eth_device_register();
 	realview_usb_register(realview_eb_isp1761_resources);
 
-- 
1.7.0.1
