From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 22 Feb 2011 08:37:03 -0500
Subject: [PATCH v3 8/9] davinci: add spi devices support for
	da850/omap-l138/am18x evm
In-Reply-To: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
References: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1298381824-7723-9-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch adds the on-board SPI flash device to the
DA850/OMAP-L138/AM18x EVM. It also registers the SPI flash
device to the MTD subsystem.

Based on SPI flash device support for MityDSP-L138F platform.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[michael.williamson at criticallink.com: moved da850_evm_spi1_pdata to devices-da8xx.c]
Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   86 +++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 11f986b..ee2094f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -29,6 +29,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps6507x.h>
 #include <linux/input/tps6507x-ts.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -38,6 +40,7 @@
 #include <mach/nand.h>
 #include <mach/mux.h>
 #include <mach/aemif.h>
+#include <mach/spi.h>
 
 #define DA850_EVM_PHY_ID		"0:00"
 #define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
@@ -48,6 +51,87 @@
 
 #define DA850_MII_MDIO_CLKEN_PIN	GPIO_TO_PIN(2, 6)
 
+static struct mtd_partition da850evm_spiflash_part[] = {
+	[0] = {
+		.name = "UBL",
+		.offset = 0,
+		.size = SZ_64K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	[1] = {
+		.name = "U-Boot",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_512K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	[2] = {
+		.name = "U-Boot-Env",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_64K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	[3] = {
+		.name = "Kernel",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_2M + SZ_512K,
+		.mask_flags = 0,
+	},
+	[4] = {
+		.name = "Filesystem",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_4M,
+		.mask_flags = 0,
+	},
+	[5] = {
+		.name = "MAC-Address",
+		.offset = SZ_8M - SZ_64K,
+		.size = SZ_64K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+};
+
+static struct flash_platform_data da850evm_spiflash_data = {
+	.name		= "m25p80",
+	.parts		= da850evm_spiflash_part,
+	.nr_parts	= ARRAY_SIZE(da850evm_spiflash_part),
+	.type		= "m25p64",
+};
+
+static struct davinci_spi_config da850evm_spiflash_cfg = {
+	.io_type	= SPI_IO_TYPE_DMA,
+	.c2tdelay	= 8,
+	.t2cdelay	= 8,
+};
+
+static struct spi_board_info da850evm_spi_info[] = {
+	{
+		.modalias		= "m25p80",
+		.platform_data		= &da850evm_spiflash_data,
+		.controller_data	= &da850evm_spiflash_cfg,
+		.mode			= SPI_MODE_0,
+		.max_speed_hz		= 30000000,
+		.bus_num		= 1,
+		.chip_select		= 0,
+	},
+};
+
+static void __init da850evm_init_spi1(struct spi_board_info *info, unsigned len)
+{
+	int ret;
+
+	ret = spi_register_board_info(info, len);
+	if (ret)
+		pr_warning("%s: failed to register board info : %d\n",
+			   __func__, ret);
+
+	da8xx_spi_pdata[1].num_chipselect = len;
+
+	ret = da8xx_register_spi(1);
+	if (ret)
+		pr_warning("%s: failed to register spi 1 device : %d\n",
+			   __func__, ret);
+}
+
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
 		.name           = "bootloaders + env",
@@ -1167,6 +1251,8 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: suspend registration failed: %d\n",
 				ret);
+
+	da850evm_init_spi1(da850evm_spi_info, ARRAY_SIZE(da850evm_spi_info));
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.0.4
