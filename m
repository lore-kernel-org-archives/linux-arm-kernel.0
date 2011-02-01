From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue,  1 Feb 2011 16:49:37 -0500
Subject: [PATCH v1 2/4] davinci: add spi devices support for
	MityDSP-L138/MityARM-1808 platform
In-Reply-To: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1296596979-18524-3-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for accessing the on board SPI NOR FLASH
device for MityDSP-L138 and MityARM-1808 SoMs.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Tested-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c |  100 ++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 0ea5932..dc4c3f1 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -17,6 +17,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/etherdevice.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -25,6 +27,7 @@
 #include <mach/da8xx.h>
 #include <mach/nand.h>
 #include <mach/mux.h>
+#include <mach/spi.h>
 
 #define MITYOMAPL138_PHY_ID		"0:03"
 
@@ -294,6 +297,100 @@ static int __init pmic_tps65023_init(void)
 }
 
 /*
+ * SPI Devices:
+ *	SPI1_CS0: 8M Flash ST-M25P64-VME6G
+ */
+static struct mtd_partition spi_flash_partitions[] = {
+	[0] = {
+		.name		= "ubl",
+		.offset		= 0,
+		.size		= SZ_64K,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	[1] = {
+		.name		= "u-boot",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_512K,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	[2] = {
+		.name		= "u-boot-env",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_64K,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	[3] = {
+		.name		= "periph-config",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_64K,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	[4] = {
+		.name		= "reserved",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_256K + SZ_64K,
+	},
+	[5] = {
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_2M + SZ_1M,
+	},
+	[6] = {
+		.name		= "fpga",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_2M,
+	},
+	[7] = {
+		.name		= "spare",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct flash_platform_data mityomapl138_spi_flash_data = {
+	.name		= "m25p80",
+	.parts		= spi_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(spi_flash_partitions),
+	.type		= "m24p64",
+};
+
+static struct davinci_spi_config spi_eprom_config = {
+	.io_type	= SPI_IO_TYPE_DMA,
+	.c2tdelay	= 8,
+	.t2cdelay	= 8,
+};
+
+static struct spi_board_info mityomapl138_spi_flash_info[] = {
+	{
+		.modalias		= "m25p80",
+		.platform_data		= &mityomapl138_spi_flash_data,
+		.controller_data	= &spi_eprom_config,
+		.mode			= SPI_MODE_0,
+		.max_speed_hz		= 30000000,
+		.bus_num		= 1,
+		.chip_select		= 0,
+	},
+};
+
+static void __init mityomapl138_init_spi1(struct spi_board_info *info,
+					  unsigned len)
+{
+	int ret;
+
+	ret = spi_register_board_info(info, len);
+	if (ret)
+		pr_warning("%s: failed to register board info : %d\n",
+				__func__, ret);
+
+	da8xx_spi_pdata[1].num_chipselect = len;
+
+	ret = da8xx_register_spi(1);
+	if (ret)
+		pr_warning("%s: failed to register spi 1 device : %d\n",
+				__func__, ret);
+}
+
+/*
  * MityDSP-L138 includes a 256 MByte large-page NAND flash
  * (128K blocks).
  */
@@ -448,6 +545,9 @@ static void __init mityomapl138_init(void)
 
 	mityomapl138_setup_nand();
 
+	mityomapl138_init_spi1(mityomapl138_spi_flash_info,
+			       ARRAY_SIZE(mityomapl138_spi_flash_info));
+
 	mityomapl138_config_emac();
 
 	ret = da8xx_register_rtc();
-- 
1.7.0.4
