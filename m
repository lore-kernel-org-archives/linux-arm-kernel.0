From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 28 Jun 2018 11:57:46 +0200
Subject: [PATCH v3 11/13] ARM: davinci: dm646x-evm: use aemif platform driver
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Message-ID: <20180628095748.4462-12-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in dm646x-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 52 +++++++++++++++++++-----
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 867ab2fa6cfd..3e5ee09ee717 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
 #include <linux/platform_data/pcf857x.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include <media/i2c/tvp514x.h>
 #include <media/i2c/adv7343.h>
@@ -106,16 +107,47 @@ static struct resource davinci_nand_resources[] = {
 	},
 };
 
-static struct platform_device davinci_nand_device = {
-	.name			= "davinci_nand",
-	.id			= 0,
+static struct platform_device davinci_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 0,
+		.num_resources	= ARRAY_SIZE(davinci_nand_resources),
+		.resource	= davinci_nand_resources,
+		.dev		= {
+			.platform_data	= &davinci_nand_data,
+		},
+	},
+};
+
+static struct resource davinci_aemif_resources[] = {
+	{
+		.start	= DM646X_ASYNC_EMIF_CONTROL_BASE,
+		.end	= DM646X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
 
-	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
-	.resource		= davinci_nand_resources,
+static struct aemif_abus_data davinci_aemif_abus_data[] = {
+	{
+		.cs	= 1,
+	},
+};
 
-	.dev			= {
-		.platform_data	= &davinci_nand_data,
+static struct aemif_platform_data davinci_aemif_pdata = {
+	.abus_data		= davinci_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(davinci_aemif_abus_data),
+	.sub_devices		= davinci_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(davinci_aemif_devices),
+};
+
+static struct platform_device davinci_aemif_device = {
+	.name		= "ti-aemif",
+	.id		= -1,
+	.dev = {
+		.platform_data	= &davinci_aemif_pdata,
 	},
+	.resource	= davinci_aemif_resources,
+	.num_resources	= ARRAY_SIZE(davinci_aemif_resources),
 };
 
 #define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
@@ -793,10 +825,8 @@ static __init void evm_init(void)
 	if (machine_is_davinci_dm6467tevm())
 		davinci_nand_data.timing = &dm6467tevm_nandflash_timing;
 
-	platform_device_register(&davinci_nand_device);
-
-	if (davinci_aemif_setup(&davinci_nand_device))
-		pr_warn("%s: Cannot configure AEMIF.\n", __func__);
+	if (platform_device_register(&davinci_aemif_device))
+		pr_warn("%s: Cannot register AEMIF device.\n", __func__);
 
 	dm646x_init_edma(dm646x_edma_rsv);
 
-- 
2.17.1
