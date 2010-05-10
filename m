From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 10 May 2010 05:02:28 +0200
Subject: [PATCH] pxa/vpac270: Convert to use PATA PXA driver
Message-ID: <1273460548-25698-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/vpac270.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 52e85cb..3e37fc5 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -23,7 +23,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/dm9000.h>
 #include <linux/ucb1400.h>
-#include <linux/ata_platform.h>
 #include <linux/regulator/max1586.h>
 
 #include <asm/mach-types.h>
@@ -37,6 +36,7 @@
 #include <mach/ohci.h>
 #include <mach/pxa27x-udc.h>
 #include <mach/udc.h>
+#include <mach/pata_pxa.h>
 
 #include <plat/i2c.h>
 
@@ -494,10 +494,10 @@ static inline void vpac270_lcd_init(void) {}
 /******************************************************************************
  * PATA IDE
  ******************************************************************************/
-#if defined(CONFIG_PATA_PLATFORM) || \
-	defined(CONFIG_PATA_PLATFORM_MODULE)
-static struct pata_platform_info vpac270_pata_pdata = {
-	.ioport_shift	= 1,
+#if defined(CONFIG_PATA_PXA) ||	defined(CONFIG_PATA_PXA_MODULE)
+static struct pata_pxa_pdata vpac270_pata_pdata = {
+	.reg_shift	= 1,
+	.dma_dreq	= 1,
 	.irq_flags	= IRQF_TRIGGER_RISING,
 };
 
@@ -512,7 +512,12 @@ static struct resource vpac270_ide_resources[] = {
 	       .end	= PXA_CS3_PHYS + 0x15f,
 	       .flags	= IORESOURCE_MEM
 	},
-	[2] = {	/* IDE IRQ pin */
+	[2] = {	/* DMA Base address */
+	       .start	= PXA_CS3_PHYS + 0x20,
+	       .end	= PXA_CS3_PHYS + 0x2f,
+	       .flags	= IORESOURCE_DMA
+	},
+	[3] = {	/* IDE IRQ pin */
 	       .start	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
 	       .end	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
 	       .flags	= IORESOURCE_IRQ
@@ -520,11 +525,12 @@ static struct resource vpac270_ide_resources[] = {
 };
 
 static struct platform_device vpac270_ide_device = {
-	.name		= "pata_platform",
+	.name		= "pata_pxa",
 	.num_resources	= ARRAY_SIZE(vpac270_ide_resources),
 	.resource	= vpac270_ide_resources,
 	.dev		= {
 		.platform_data	= &vpac270_pata_pdata,
+		.coherent_dma_mask	= 0xffffffff,
 	}
 };
 
-- 
1.7.0
