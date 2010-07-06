From: triad@df.lth.se (Linus Walleij)
Date: Tue,  6 Jul 2010 17:21:18 +0200
Subject: [PATCH 2/3] ARM: register character LCD for PB1176
Message-ID: <1278429678-4837-1-git-send-email-triad@df.lth.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers the character LCD device for the ARM RealView
PB1176.

Signed-off-by: Linus Walleij <triad@df.lth.se>
---
This one is tested on the PB1176 and works fine.
---
 arch/arm/mach-realview/Kconfig           |    1 +
 arch/arm/mach-realview/realview_pb1176.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index ee5e392..511d67d 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -44,6 +44,7 @@ config MACH_REALVIEW_PB1176
 	bool "Support RealView/PB1176 platform"
 	select CPU_V6
 	select ARM_GIC
+	select ARM_CHAR_LCD
 	help
 	  Include support for the ARM(R) RealView ARM1176 Platform Baseboard.
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 9f02350..eb7979c 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -274,6 +274,26 @@ static struct platform_device pmu_device = {
 	.resource		= &pmu_resource,
 };
 
+static struct resource char_lcd_resources[] = {
+	{
+		.start = REALVIEW_CHAR_LCD_BASE,
+		.end   = (REALVIEW_CHAR_LCD_BASE + SZ_4K - 1),
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_PB1176_CHARLCD,
+		.end	= IRQ_PB1176_CHARLCD,
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
 	/* ARM1176 DevChip GIC, primary */
@@ -336,6 +356,7 @@ static void __init realview_pb1176_init(void)
 	platform_device_register(&realview_i2c_device);
 	realview_usb_register(realview_pb1176_isp1761_resources);
 	platform_device_register(&pmu_device);
+	platform_device_register(&char_lcd_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
-- 
1.7.0.1
