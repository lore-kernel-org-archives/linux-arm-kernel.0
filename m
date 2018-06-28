From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 28 Jun 2018 11:57:44 +0200
Subject: [PATCH v3 09/13] ARM: davinci: dm644x-evm: use aemif platform driver
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Message-ID: <20180628095748.4462-10-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in dm644x-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 55 ++++++++++++++++++------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 738e443ab15f..e4a8f9225d16 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -42,6 +42,7 @@
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include "davinci.h"
 
@@ -174,14 +175,47 @@ static struct resource davinci_evm_nandflash_resource[] = {
 	},
 };
 
-static struct platform_device davinci_evm_nandflash_device = {
-	.name		= "davinci_nand",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &davinci_evm_nandflash_data,
+static struct resource davinci_evm_aemif_resource[] = {
+	{
+		.start		= DM644X_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM644X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
 	},
-	.num_resources	= ARRAY_SIZE(davinci_evm_nandflash_resource),
-	.resource	= davinci_evm_nandflash_resource,
+};
+
+static struct aemif_abus_data davinci_evm_aemif_abus_data[] = {
+	{
+		.cs		= 1,
+	},
+};
+
+static struct platform_device davinci_evm_nandflash_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 0,
+		.dev		= {
+			.platform_data	= &davinci_evm_nandflash_data,
+		},
+		.num_resources	= ARRAY_SIZE(davinci_evm_nandflash_resource),
+		.resource	= davinci_evm_nandflash_resource,
+	},
+};
+
+static struct aemif_platform_data davinci_evm_aemif_pdata = {
+	.abus_data = davinci_evm_aemif_abus_data,
+	.num_abus_data = ARRAY_SIZE(davinci_evm_aemif_abus_data),
+	.sub_devices = davinci_evm_nandflash_devices,
+	.num_sub_devices = ARRAY_SIZE(davinci_evm_nandflash_devices),
+};
+
+static struct platform_device davinci_evm_aemif_device = {
+	.name			= "ti-aemif",
+	.id			= -1,
+	.dev = {
+		.platform_data	= &davinci_evm_aemif_pdata,
+	},
+	.resource		= davinci_evm_aemif_resource,
+	.num_resources		= ARRAY_SIZE(davinci_evm_aemif_resource),
 };
 
 static u64 davinci_fb_dma_mask = DMA_BIT_MASK(32);
@@ -795,12 +829,7 @@ static __init void davinci_evm_init(void)
 
 		/* only one device will be jumpered and detected */
 		if (HAS_NAND) {
-			platform_device_register(&davinci_evm_nandflash_device);
-
-			if (davinci_aemif_setup(&davinci_evm_nandflash_device))
-				pr_warn("%s: Cannot configure AEMIF\n",
-					__func__);
-
+			platform_device_register(&davinci_evm_aemif_device);
 #ifdef CONFIG_I2C
 			evm_leds[7].default_trigger = "nand-disk";
 #endif
-- 
2.17.1
