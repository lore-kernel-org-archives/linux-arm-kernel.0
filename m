From: juergen.lambrecht@gmail.com (=?UTF-8?q?J=C3=BCrgen=20Lambrecht?=)
Date: Tue,  5 Jul 2011 15:33:48 +0200
Subject: [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block
	Indicator, and use for imx27pdk nand support.
Message-ID: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
  in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
  Warning: The same solution needs to be applied to the boot loader and the
  flash programmer.
- Enable NAND support for the imx27pdk (3ds), and use BISWAP.

Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
---
 arch/arm/mach-imx/Kconfig         |   30 ++++++++++++++++++++++++++++--
 arch/arm/mach-imx/mach-mx27_3ds.c |   14 ++++++++++++++
 drivers/mtd/nand/mxc_nand.c       |   29 +++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..e8b16a9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -274,7 +274,7 @@ config MACH_EUKREA_MBIMX27_BASEBOARD
 endchoice
 
 config MACH_MX27_3DS
-	bool "MX27PDK platform"
+	bool "MX27PDK (3DS) platform"
 	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
@@ -284,13 +284,39 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
 	select MXC_ULPI if USB_ULPI
 	help
-	  Include support for MX27PDK platform. This includes specific
+	  Include support for MX27PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_MXC_NAND_USE_BBT
+	bool "Make the MXC NAND driver use the in flash Bad Block Table"
+	depends on MACH_MX27_3DS
+	depends on MTD_NAND_MXC
+	help
+	  Enable this if you want that the MXC NAND driver uses the in flash
+	  Bad Block Table to know what blocks are bad instead of scanning the
+	  entire flash looking for bad block markers.
+
+config IMX_NFC_V1_BISWAP
+	bool "Make the MXC 2kB-page NAND driver swap the Bad Block Indicator"
+	depends on MACH_MX27_3DS
+	depends on MTD_NAND_MXC
+	help
+	  Enable this if you want that the MXC NAND driver swaps the Bad Block
+	  Indicator (BBI) byte. The IMX NFC v1 (present in IMX27 and IMX31)
+	  contains a bug for 2kB-page flashes: the 2kB page is read out in
+	  4x512B chunks, so also the spare area is read out in 4
+	  chunks. Therefore the data area and the spare area becomes
+	  mixed. This causes a problem for the factory programmed BBI: it
+	  appears in the data area instead of the spare area, and is
+	  overwritten. This patch swaps that byte to the "real" spare
+	  area. WARNING: then also the bootloader and the flash programmer must
+	  be patched!!
+
 config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
 	select SOC_IMX27
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 526cbe1..84114aa 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -40,6 +40,7 @@
 #include <mach/ulpi.h>
 #include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
+#include <mach/mxc_nand.h>
 
 #include "devices-imx27.h"
 
@@ -369,6 +370,18 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 	},
 };
 
+/*
+ * NAND Flash
+ */
+static const struct mxc_nand_platform_data
+mx27_3ds_nand_board_info __initconst = {
+	.width		= 1,
+	.hw_ecc		= 1,
+#ifdef MACH_MXC_NAND_USE_BBT
+	.flash_bbt	= 1,
+#endif
+};
+
 static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
@@ -380,6 +393,7 @@ static void __init mx27pdk_init(void)
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
 		"mx27pdk");
 	mx27_3ds_sdhc1_enable_level_translator();
+	imx27_add_mxc_nand(&mx27_3ds_nand_board_info);
 	imx27_add_imx_uart0(&uart_pdata);
 	imx27_add_fec(NULL);
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 90df34c..83f54d6 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -612,6 +612,30 @@ static int mxc_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 	return 0;
 }
 
+/*
+ * Swap the BI-byte on position 0x7D0 with a data byte at 0x835.
+ * To fix a bug in NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
+ * Warning: The same solution needs to be applied to the boot loader and the
+ * flash programmer.
+ */
+#ifdef CONFIG_IMX_NFC_V1_BISWAP
+static void imx_bi_swap(struct mtd_info *mtd)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	struct mxc_nand_host *host = nand_chip->priv;
+	unsigned short temp1, temp2, new_temp1;
+
+	temp1 = *((volatile unsigned short*)(host->main_area0 + 0x7D0));
+	temp2 = *((volatile unsigned short*)(host->main_area0 + 0x834));
+	new_temp1 = (temp1 & 0xFF00) | (temp2 >> 8);
+	temp2 = (temp2 & 0x00FF) | (temp1 << 8);
+	*((volatile unsigned short*)(host->main_area0 + 0x7D0)) = new_temp1;
+	*((volatile unsigned short*)(host->main_area0 + 0x834)) = temp2;
+}
+#else
+static inline void imx_bi_swap(struct mtd_info *mtd) {}
+#endif
+
 static u_char mxc_nand_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd->priv;
@@ -971,6 +995,9 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		host->send_page(mtd, NFC_OUTPUT);
 
+		if ((mtd->writesize > 512) && nfc_is_v1())
+			imx_bi_swap(mtd);
+
 		memcpy(host->data_buf, host->main_area0, mtd->writesize);
 		copy_spare(mtd, true);
 		break;
@@ -989,6 +1016,8 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 	case NAND_CMD_PAGEPROG:
 		memcpy(host->main_area0, host->data_buf, mtd->writesize);
 		copy_spare(mtd, false);
+		if ((mtd->writesize > 512) && nfc_is_v1())
+			imx_bi_swap(mtd);
 		host->send_page(mtd, NFC_INPUT);
 		host->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
-- 
1.7.1
