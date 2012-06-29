From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 29 Jun 2012 13:01:31 +0100
Subject: [PATCH] ARM: pxa: hx4700: Use DEFINE_RES_* macros consistently
Message-ID: <mailman.21.1340971296.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the remaining inline struct resource definitions
with equivalent DEFINE_RES_* macro calls.
The source file is reduced in size; the object file is unchanged.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/hx4700.c |   56 +++++++++----------------------------------
 1 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index d3de84b..e631198 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -296,27 +296,11 @@ static struct asic3_led asic3_leds[ASIC3_NUM_LEDS] = {
 
 static struct resource asic3_resources[] = {
 	/* GPIO part */
-	[0] = {
-		.start	= ASIC3_PHYS,
-		.end	= ASIC3_PHYS + ASIC3_MAP_SIZE_16BIT - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= PXA_GPIO_TO_IRQ(GPIO12_HX4700_ASIC3_IRQ),
-		.end	= PXA_GPIO_TO_IRQ(GPIO12_HX4700_ASIC3_IRQ),
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(ASIC3_PHYS, ASIC3_MAP_SIZE_16BIT),
+	[1] = DEFINE_RES_IRQ(PXA_GPIO_TO_IRQ(GPIO12_HX4700_ASIC3_IRQ)),
 	/* SD part */
-	[2] = {
-		.start	= ASIC3_SD_PHYS,
-		.end	= ASIC3_SD_PHYS + ASIC3_MAP_SIZE_16BIT - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[3] = {
-		.start	= PXA_GPIO_TO_IRQ(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
-		.end	= PXA_GPIO_TO_IRQ(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
-		.flags	= IORESOURCE_IRQ,
-	},
+	[2] = DEFINE_RES_MEM(ASIC3_SD_PHYS, ASIC3_MAP_SIZE_16BIT),
+	[3] = DEFINE_RES_IRQ(PXA_GPIO_TO_IRQ(GPIO66_HX4700_ASIC3_nSDIO_IRQ)),
 };
 
 static struct asic3_platform_data asic3_platform_data = {
@@ -343,11 +327,7 @@ static struct platform_device asic3 = {
  */
 
 static struct resource egpio_resources[] = {
-	[0] = {
-		.start = PXA_CS5_PHYS,
-		.end   = PXA_CS5_PHYS + 0x4 - 1,
-		.flags = IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM(PXA_CS5_PHYS, 0x4),
 };
 
 static struct htc_egpio_chip egpio_chips[] = {
@@ -537,11 +517,7 @@ static struct w100fb_mach_info w3220_info = {
 };
 
 static struct resource w3220_resources[] = {
-	[0] = {
-		.start	= ATI_W3220_PHYS,
-		.end	= ATI_W3220_PHYS + 0x00ffffff,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM(ATI_W3220_PHYS, SZ_16M),
 };
 
 static struct platform_device w3220 = {
@@ -683,20 +659,12 @@ static struct pda_power_pdata power_supply_info = {
 };
 
 static struct resource power_supply_resources[] = {
-	[0] = {
-		.name  = "ac",
-		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
-		         IORESOURCE_IRQ_LOWEDGE,
-		.start = PXA_GPIO_TO_IRQ(GPIOD9_nAC_IN),
-		.end   = PXA_GPIO_TO_IRQ(GPIOD9_nAC_IN),
-	},
-	[1] = {
-		.name  = "usb",
-		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
-		         IORESOURCE_IRQ_LOWEDGE,
-		.start = PXA_GPIO_TO_IRQ(GPIOD14_nUSBC_DETECT),
-		.end   = PXA_GPIO_TO_IRQ(GPIOD14_nUSBC_DETECT),
-	},
+	[0] = DEFINE_RES_NAMED(PXA_GPIO_TO_IRQ(GPIOD9_nAC_IN), 1, "ac",
+		IORESOURCE_IRQ |
+		IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE),
+	[1] = DEFINE_RES_NAMED(PXA_GPIO_TO_IRQ(GPIOD14_nUSBC_DETECT), 1, "usb",
+		IORESOURCE_IRQ |
+		IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE),
 };
 
 static struct platform_device power_supply = {
-- 
1.7.3.4
