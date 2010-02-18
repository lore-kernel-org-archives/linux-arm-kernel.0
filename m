From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 18 Feb 2010 20:31:43 +0000
Subject: [PATCH 4/5] watchdog: add support for onboard max6369 to Arcom Zeus
Message-ID: <20100218203143.652daad7@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/include/mach/zeus.h |    1 -
 arch/arm/mach-pxa/zeus.c              |   20 ++++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/zeus.h b/arch/arm/mach-pxa/include/mach/zeus.h
index c387046..89e4fb5 100644
--- a/arch/arm/mach-pxa/include/mach/zeus.h
+++ b/arch/arm/mach-pxa/include/mach/zeus.h
@@ -68,7 +68,6 @@
 #define ZEUS_CPLD_VERSION	(ZEUS_CPLD + 0x0000)
 #define ZEUS_CPLD_ISA_IRQ	(ZEUS_CPLD + 0x1000)
 #define ZEUS_CPLD_CONTROL	(ZEUS_CPLD + 0x2000)
-#define ZEUS_CPLD_EXTWDOG	(ZEUS_CPLD + 0x3000)
 
 /* CPLD register bits */
 #define ZEUS_CPLD_CONTROL_CF_RST        0x01
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index c252ea3..ec22bbf 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -457,6 +457,19 @@ static struct platform_device zeus_pcmcia_device = {
 	},
 };
 
+static struct resource zeus_max6369_resource = {
+	.start		= ZEUS_CPLD_EXTWDOG_PHYS,
+	.end		= ZEUS_CPLD_EXTWDOG_PHYS,
+	.flags		= IORESOURCE_MEM,
+};
+
+struct platform_device zeus_max6369_device = {
+	.name		= "max6369_wdt",
+	.id		= -1,
+	.resource	= &zeus_max6369_resource,
+	.num_resources	= 1,
+};
+
 static struct platform_device *zeus_devices[] __initdata = {
 	&zeus_serial_device,
 	&zeus_mtd_devices[0],
@@ -466,6 +479,7 @@ static struct platform_device *zeus_devices[] __initdata = {
 	&pxa2xx_spi_ssp3_device,
 	&zeus_leds_device,
 	&zeus_pcmcia_device,
+	&zeus_max6369_device,
 };
 
 /* AC'97 */
@@ -809,12 +823,6 @@ static struct map_desc zeus_io_desc[] __initdata = {
 		.type    = MT_DEVICE,
 	},
 	{
-		.virtual = ZEUS_CPLD_EXTWDOG,
-		.pfn     = __phys_to_pfn(ZEUS_CPLD_EXTWDOG_PHYS),
-		.length  = 0x1000,
-		.type    = MT_DEVICE,
-	},
-	{
 		.virtual = ZEUS_PC104IO,
 		.pfn     = __phys_to_pfn(ZEUS_PC104IO_PHYS),
 		.length  = 0x00800000,
-- 
1.7.0



-- 
I'm the slime oozin' out from your TV set...
