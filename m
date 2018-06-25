From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 25 Jun 2018 17:29:17 +0200
Subject: [PATCH 6/9] ARM: davinci: da830-evm: use aemif platform driver
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
Message-ID: <20180625152920.11549-7-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in da830-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 56 +++++++++++++++++++------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index b2470141dba3..666db3cee08a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
+#include <linux/platform_data/ti-aemif.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
@@ -333,14 +334,48 @@ static struct resource da830_evm_nand_resources[] = {
 	},
 };
 
-static struct platform_device da830_evm_nand_device = {
-	.name		= "davinci_nand",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &da830_evm_nand_pdata,
+static struct platform_device da830_evm_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &da830_evm_nand_pdata,
+		},
+		.num_resources	= ARRAY_SIZE(da830_evm_nand_resources),
+		.resource	= da830_evm_nand_resources,
+	},
+};
+
+static struct resource da830_evm_aemif_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct aemif_abus_data da830_evm_aemif_abus_data[] = {
+	{
+		.cs	= 3,
 	},
-	.num_resources	= ARRAY_SIZE(da830_evm_nand_resources),
-	.resource	= da830_evm_nand_resources,
+};
+
+static struct aemif_platform_data da830_evm_aemif_pdata = {
+	.abus_data		= da830_evm_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(da830_evm_aemif_abus_data),
+	.sub_devices		= da830_evm_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(da830_evm_aemif_devices),
+	.cs_offset		= 2,
+};
+
+static struct platform_device da830_evm_aemif_device = {
+	.name		= "ti-aemif",
+	.dev = {
+		.platform_data = &da830_evm_aemif_pdata,
+	},
+	.resource	= da830_evm_aemif_resource,
+	.num_resources	= ARRAY_SIZE(da830_evm_aemif_resource),
+	.id		= -1,
 };
 
 /*
@@ -371,12 +406,9 @@ static inline void da830_evm_init_nand(int mux_mode)
 	if (ret)
 		pr_warn("%s: emif25 mux setup failed: %d\n", __func__, ret);
 
-	ret = platform_device_register(&da830_evm_nand_device);
+	ret = platform_device_register(&da830_evm_aemif_device);
 	if (ret)
-		pr_warn("%s: NAND device not registered\n", __func__);
-
-	if (davinci_aemif_setup(&da830_evm_nand_device))
-		pr_warn("%s: Cannot configure AEMIF\n", __func__);
+		pr_warn("%s: AEMIF device not registered\n", __func__);
 
 	gpio_direction_output(mux_mode, 1);
 }
-- 
2.17.1
