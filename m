From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 28 Jun 2018 11:57:47 +0200
Subject: [PATCH v3 12/13] ARM: davinci: mityomapl138: use aemif platform driver
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Message-ID: <20180628095748.4462-13-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in mityomapl138.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 55 ++++++++++++++++------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2cce0d7d2f2a..2933e0c87cfa 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -30,6 +30,7 @@
 #include <mach/da8xx.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/ti-aemif.h>
 #include <mach/mux.h>
 #include <linux/platform_data/spi-davinci.h>
 
@@ -422,27 +423,53 @@ static struct resource mityomapl138_nandflash_resource[] = {
 	},
 };
 
-static struct platform_device mityomapl138_nandflash_device = {
-	.name		= "davinci_nand",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &mityomapl138_nandflash_data,
+static struct platform_device mityomapl138_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &mityomapl138_nandflash_data,
+		},
+		.num_resources	= ARRAY_SIZE(mityomapl138_nandflash_resource),
+		.resource	= mityomapl138_nandflash_resource,
 	},
-	.num_resources	= ARRAY_SIZE(mityomapl138_nandflash_resource),
-	.resource	= mityomapl138_nandflash_resource,
 };
 
-static struct platform_device *mityomapl138_devices[] __initdata = {
-	&mityomapl138_nandflash_device,
+static struct resource mityomapl138_aemif_resources[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct aemif_abus_data mityomapl138_aemif_abus_data[] = {
+	{
+		.cs	= 1,
+	},
+};
+
+static struct aemif_platform_data mityomapl138_aemif_pdata = {
+	.abus_data		= mityomapl138_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(mityomapl138_aemif_abus_data),
+	.sub_devices		= mityomapl138_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(mityomapl138_aemif_devices),
+};
+
+static struct platform_device mityomapl138_aemif_device = {
+	.name		= "ti-aemif",
+	.id		= -1,
+	.dev = {
+		.platform_data	= &mityomapl138_aemif_pdata,
+	},
+	.resource	= mityomapl138_aemif_resources,
+	.num_resources	= ARRAY_SIZE(mityomapl138_aemif_resources),
 };
 
 static void __init mityomapl138_setup_nand(void)
 {
-	platform_add_devices(mityomapl138_devices,
-				 ARRAY_SIZE(mityomapl138_devices));
-
-	if (davinci_aemif_setup(&mityomapl138_nandflash_device))
-		pr_warn("%s: Cannot configure AEMIF\n", __func__);
+	if (platform_device_register(&mityomapl138_aemif_device))
+		pr_warn("%s: Cannot register AEMIF device\n", __func__);
 }
 
 static const short mityomap_mii_pins[] = {
-- 
2.17.1
