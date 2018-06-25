From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 25 Jun 2018 17:29:14 +0200
Subject: [PATCH 3/9] ARM: davinci: da850-evm: use aemif platform driver in
 legacy mode
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
Message-ID: <20180625152920.11549-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support board files in the aemif driver. Register a platform
device instead of using the handcrafted API in da850-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 93 ++++++++++++++-----------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 442c16773f09..0ae7c47ed2b0 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -33,6 +33,7 @@
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/ti-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/uio_pruss.h>
 #include <linux/regulator/machine.h>
@@ -185,16 +186,6 @@ static struct resource da850_evm_norflash_resource[] = {
 	},
 };
 
-static struct platform_device da850_evm_norflash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data  = &da850_evm_norflash_data,
-	},
-	.num_resources	= 1,
-	.resource	= da850_evm_norflash_resource,
-};
-
 /* DA850/OMAP-L138 EVM includes a 512 MByte large-page NAND flash
  * (128K blocks). It may be used instead of the (default) SPI flash
  * to boot, using TI's tools to install the secondary boot loader
@@ -266,37 +257,58 @@ static struct resource da850_evm_nandflash_resource[] = {
 	},
 };
 
-static struct platform_device da850_evm_nandflash_device = {
-	.name		= "davinci_nand",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &da850_evm_nandflash_data,
-	},
-	.num_resources	= ARRAY_SIZE(da850_evm_nandflash_resource),
-	.resource	= da850_evm_nandflash_resource,
+static struct resource da850_evm_aemif_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K,
+		.flags	= IORESOURCE_MEM,
+	}
 };
 
-static struct platform_device *da850_evm_devices[] = {
-	&da850_evm_nandflash_device,
-	&da850_evm_norflash_device,
+static struct aemif_abus_data da850_evm_aemif_abus_data[] = {
+	{
+		.cs	= 3,
+	}
 };
 
-#define DA8XX_AEMIF_CE2CFG_OFFSET	0x10
-#define DA8XX_AEMIF_ASIZE_16BIT		0x1
-
-static void __init da850_evm_init_nor(void)
-{
-	void __iomem *aemif_addr;
-
-	aemif_addr = ioremap(DA8XX_AEMIF_CTL_BASE, SZ_32K);
+static struct platform_device da850_evm_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &da850_evm_nandflash_data,
+		},
+		.num_resources	= ARRAY_SIZE(da850_evm_nandflash_resource),
+		.resource	= da850_evm_nandflash_resource,
+	},
+	{
+		.name		= "physmap-flash",
+		.id		= 0,
+		.dev		= {
+			.platform_data  = &da850_evm_norflash_data,
+		},
+		.num_resources	= 1,
+		.resource	= da850_evm_norflash_resource,
+	}
+};
 
-	/* Configure data bus width of CS2 to 16 bit */
-	writel(readl(aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET) |
-		DA8XX_AEMIF_ASIZE_16BIT,
-		aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET);
+static struct aemif_platform_data da850_evm_aemif_pdata = {
+	.cs_offset = 2,
+	.abus_data = da850_evm_aemif_abus_data,
+	.num_abus_data = ARRAY_SIZE(da850_evm_aemif_abus_data),
+	.sub_devices = da850_evm_aemif_devices,
+	.num_sub_devices = ARRAY_SIZE(da850_evm_aemif_devices),
+};
 
-	iounmap(aemif_addr);
-}
+static struct platform_device da850_evm_aemif_device = {
+	.name		= "ti-aemif",
+	.dev = {
+		.platform_data	= &da850_evm_aemif_pdata,
+	},
+	.resource	= da850_evm_aemif_resource,
+	.num_resources	= ARRAY_SIZE(da850_evm_aemif_resource),
+	.id		= -1,
+};
 
 static const short da850_evm_nand_pins[] = {
 	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
@@ -339,13 +351,10 @@ static inline void da850_evm_setup_nor_nand(void)
 			pr_warn("%s: NOR mux setup failed: %d\n",
 				__func__, ret);
 
-		da850_evm_init_nor();
-
-		platform_add_devices(da850_evm_devices,
-					ARRAY_SIZE(da850_evm_devices));
-
-		if (davinci_aemif_setup(&da850_evm_nandflash_device))
-			pr_warn("%s: Cannot configure AEMIF.\n", __func__);
+		ret = platform_device_register(&da850_evm_aemif_device);
+		if (ret)
+			pr_warn("%s: registering aemif failed: %d\n",
+				__func__, ret);
 	}
 }
 
-- 
2.17.1
