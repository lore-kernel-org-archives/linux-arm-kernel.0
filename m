From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue,  1 Feb 2011 16:49:39 -0500
Subject: [PATCH v1 4/4] davinci: add spi devices support for
	da830/omap-l137/am17x evm
In-Reply-To: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1296596979-18524-5-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch adds the on-board SPI flash device to the
DA830/OMAP-L137/AM17x EVM. It also registers the SPI flash
device to the MTD subsystem.

Based on SPI flash device support for MityDSP-L138F platform.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[michael.williamson at criticallink.com: moved da830evm_spi0_pdata to devices-da8xx.c]
Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |   78 +++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index b52a3a1..01319bd 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -20,6 +20,8 @@
 #include <linux/i2c/at24.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -30,6 +32,7 @@
 #include <mach/da8xx.h>
 #include <mach/usb.h>
 #include <mach/aemif.h>
+#include <mach/spi.h>
 
 #define DA830_EVM_PHY_ID		""
 /*
@@ -534,6 +537,79 @@ static struct edma_rsv_info da830_edma_rsv[] = {
 	},
 };
 
+static struct mtd_partition da830evm_spiflash_part[] = {
+	[0] = {
+		.name = "DSP-UBL",
+		.offset = 0,
+		.size = SZ_8K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	[1] = {
+		.name = "ARM-UBL",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_16K + SZ_8K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	[2] = {
+		.name = "U-Boot",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_256K - SZ_32K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	[3] = {
+		.name = "U-Boot-Environment",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_16K,
+		.mask_flags = 0,
+	},
+	[4] = {
+		.name = "Kernel",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+		.mask_flags = 0,
+	},
+};
+
+static struct flash_platform_data da830evm_spiflash_data = {
+	.name		= "m25p80",
+	.parts		= da830evm_spiflash_part,
+	.nr_parts	= ARRAY_SIZE(da830evm_spiflash_part),
+	.type		= "w25x32",
+};
+
+static struct davinci_spi_config da830evm_spiflash_cfg = {
+	.io_type	= SPI_IO_TYPE_DMA,
+	.c2tdelay	= 8,
+	.t2cdelay	= 8,
+};
+
+static struct spi_board_info da830evm_spi_info[] = {
+	{
+		.modalias		= "m25p80",
+		.platform_data		= &da830evm_spiflash_data,
+		.controller_data	= &da830evm_spiflash_cfg,
+		.mode			= SPI_MODE_0,
+		.max_speed_hz		= 30000000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+	},
+};
+
+static void __init da830evm_init_spi0(struct spi_board_info *info, unsigned len)
+{
+	int ret;
+
+	ret = spi_register_board_info(info, len);
+	if (ret)
+		pr_warning("failed to register board info : %d\n", ret);
+
+	da8xx_spi_pdata[0].num_chipselect = len;
+
+	ret = da8xx_register_spi(0);
+	if (ret)
+		pr_warning("failed to register spi 0 device : %d\n", ret);
+}
+
 static __init void da830_evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -590,6 +666,8 @@ static __init void da830_evm_init(void)
 	ret = da8xx_register_rtc();
 	if (ret)
 		pr_warning("da830_evm_init: rtc setup failed: %d\n", ret);
+
+	da830evm_init_spi0(da830evm_spi_info, ARRAY_SIZE(da830evm_spi_info));
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.0.4
