From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 17 Dec 2011 12:49:51 +0100
Subject: [PATCH] mioa701: add newly available DoC G3 chip
Message-ID: <1324122591-1756-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Jarzmik <robert.jarzmik@atosorigin.com>

As the mioa701 board has a M-Systems DiskOnChip G3 chip, add
it to the platform resources of the board.

Signed-off-by: Robert Jarzmik <robert.jarzmik@atosorigin.com>
---
 arch/arm/mach-pxa/mioa701.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index b938fc2..dba02b7 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -53,6 +53,7 @@
 #include <mach/pxa27x-udc.h>
 #include <mach/camera.h>
 #include <mach/audio.h>
+#include <mach/smemc.h>
 #include <media/soc_camera.h>
 
 #include <mach/mioa701.h>
@@ -390,24 +391,19 @@ static struct pxamci_platform_data mioa701_mci_info = {
 };
 
 /* FlashRAM */
-static struct resource strataflash_resource = {
+static struct resource docg3_resource = {
 	.start = PXA_CS0_PHYS,
-	.end   = PXA_CS0_PHYS + SZ_64M - 1,
+	.end   = PXA_CS0_PHYS + SZ_8K - 1,
 	.flags = IORESOURCE_MEM,
 };
 
-static struct physmap_flash_data strataflash_data = {
-	.width = 2,
-	/* .set_vpp = mioa701_set_vpp, */
-};
-
-static struct platform_device strataflash = {
-	.name	       = "physmap-flash",
+static struct platform_device docg3 = {
+	.name	       = "docg3",
 	.id	       = -1,
-	.resource      = &strataflash_resource,
+	.resource      = &docg3_resource,
 	.num_resources = 1,
 	.dev = {
-		.platform_data = &strataflash_data,
+		.platform_data = NULL,
 	},
 };
 
@@ -685,7 +681,7 @@ static struct platform_device *devices[] __initdata = {
 	&pxa2xx_pcm,
 	&mioa701_sound,
 	&power_dev,
-	&strataflash,
+	&docg3,
 	&gpio_vbus,
 	&mioa701_camera,
 	&mioa701_board,
@@ -720,6 +716,15 @@ static void __init mioa701_machine_init(void)
 	RTTR = 32768 - 1; /* Reset crazy WinCE value */
 	UP2OCR = UP2OCR_HXOE;
 
+	/*
+	 * Set up the flash memory : DiskOnChip G3 on first static memory bank
+	 */
+	__raw_writel(0x7ff02dd8, MSC0);
+	__raw_writel(0x0001c391, MCMEM0);
+	__raw_writel(0x0001c391, MCATT0);
+	__raw_writel(0x0001c391, MCIO0);
+
+
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(mioa701_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
-- 
1.7.5.4
