From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 28 Jun 2018 11:57:43 +0200
Subject: [PATCH v3 08/13] ARM: davinci: dm365-evm: use the ti-aemif soc driver
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Message-ID: <20180628095748.4462-9-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in dm365-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 59 +++++++++++++++++++------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 307e88d99dd3..8143756ff38b 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/v4l2-dv-timings.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -159,14 +160,47 @@ static struct resource davinci_nand_resources[] = {
 	},
 };
 
-static struct platform_device davinci_nand_device = {
-	.name			= "davinci_nand",
-	.id			= 0,
-	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
-	.resource		= davinci_nand_resources,
-	.dev			= {
-		.platform_data	= &davinci_nand_data,
+static struct platform_device davinci_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 0,
+		.num_resources	= ARRAY_SIZE(davinci_nand_resources),
+		.resource	= davinci_nand_resources,
+		.dev		= {
+			.platform_data	= &davinci_nand_data,
+		},
+	}
+};
+
+static struct resource davinci_aemif_resources[] = {
+	{
+		.start		= DM365_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM365_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct aemif_abus_data da850_evm_aemif_abus_data[] = {
+	{
+		.cs		= 1,
+	},
+};
+
+static struct aemif_platform_data davinci_aemif_pdata = {
+	.abus_data		= da850_evm_aemif_abus_data,
+	.num_abus_data		= ARRAY_SIZE(da850_evm_aemif_abus_data),
+	.sub_devices		= davinci_aemif_devices,
+	.num_sub_devices	= ARRAY_SIZE(davinci_aemif_devices),
+};
+
+static struct platform_device davinci_aemif_device = {
+	.name			= "ti-aemif",
+	.id			= -1,
+	.dev = {
+		.platform_data	= &davinci_aemif_pdata,
 	},
+	.resource		= davinci_aemif_resources,
+	.num_resources		= ARRAY_SIZE(davinci_aemif_resources),
 };
 
 static struct at24_platform_data eeprom_info = {
@@ -537,10 +571,6 @@ static void __init evm_init_i2c(void)
 	i2c_register_board_info(1, i2c_info, ARRAY_SIZE(i2c_info));
 }
 
-static struct platform_device *dm365_evm_nand_devices[] __initdata = {
-	&davinci_nand_device,
-};
-
 static inline int have_leds(void)
 {
 #ifdef CONFIG_LEDS_CLASS
@@ -628,6 +658,7 @@ static void __init evm_init_cpld(void)
 	u8 mux, resets;
 	const char *label;
 	struct clk *aemif_clk;
+	int rc;
 
 	/* Make sure we can configure the CPLD through CS1.  Then
 	 * leave it on for later access to MMC and LED registers.
@@ -660,8 +691,10 @@ static void __init evm_init_cpld(void)
 		/* external keypad mux */
 		mux |= BIT(7);
 
-		platform_add_devices(dm365_evm_nand_devices,
-				ARRAY_SIZE(dm365_evm_nand_devices));
+		rc = platform_device_register(&davinci_aemif_device);
+		if (rc)
+			pr_warn("%s(): error registering the aemif device: %d\n",
+				__func__, rc);
 	} else {
 		/* no OneNAND support yet */
 	}
-- 
2.17.1
