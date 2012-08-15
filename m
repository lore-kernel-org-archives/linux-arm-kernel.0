From: gcembed@gmail.com (=?UTF-8?q?Ga=C3=ABtan=20Carlier?=)
Date: Wed, 15 Aug 2012 15:04:32 +0200
Subject: [PATCH v2] mxc_nand : allow swapping the Bad block Indicator for NFC
 v1.
Message-ID: <1345035872-11314-1-git-send-email-gcembed@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
Warning: The same solution needs to be applied to the boot loader and the
flash programmer.

This is a modified version of patch sent by J?rgen Lambrecht :
[PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block Indicator,
and use for imx27pdk nand support.

Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
---
 arch/arm/plat-mxc/include/mach/mxc_nand.h |    2 ++
 drivers/mtd/nand/mxc_nand.c               |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc_nand.h b/arch/arm/plat-mxc/include/mach/mxc_nand.h
index 6bb96ef..7c04437 100644
--- a/arch/arm/plat-mxc/include/mach/mxc_nand.h
+++ b/arch/arm/plat-mxc/include/mach/mxc_nand.h
@@ -26,6 +26,8 @@ struct mxc_nand_platform_data {
 	unsigned int width;	/* data bus width in bytes */
 	unsigned int hw_ecc:1;	/* 0 if suppress hardware ECC */
 	unsigned int flash_bbt:1; /* set to 1 to use a flash based bbt */
+	unsigned int biswap:1;	/* set to 1 to swap the Bad Block Indicator
+				   NFC v1 workaround */
 	struct mtd_partition *parts;	/* partition table */
 	int nr_parts;			/* size of parts */
 };
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 3f94e1f..7f5847a 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -682,6 +682,26 @@ static int mxc_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 	return 0;
 }
 
+/*
+ * Swap the BI-byte on position 0x7D0 with a data byte at 0x835.
+ * To fix a bug in NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
+ * Warning: The same solution needs to be applied to the boot loader and the
+ * flash programmer.
+ */
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
+
 static u_char mxc_nand_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd->priv;
@@ -1093,6 +1113,9 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		host->devtype_data->send_page(mtd, NFC_OUTPUT);
 
+		if ((mtd->writesize > 512) && nfc_is_v1() && host->pdata.biswap)
+			imx_bi_swap(mtd);
+
 		memcpy32_fromio(host->data_buf, host->main_area0,
 				mtd->writesize);
 		copy_spare(mtd, true);
@@ -1112,6 +1135,9 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 	case NAND_CMD_PAGEPROG:
 		memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
 		copy_spare(mtd, false);
+		if ((mtd->writesize > 512) && nfc_is_v1() && host->pdata.biswap)
+			imx_bi_swap(mtd);
+
 		host->devtype_data->send_page(mtd, NFC_INPUT);
 		host->devtype_data->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
-- 
1.7.7.4
