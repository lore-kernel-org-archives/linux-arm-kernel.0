From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Sep 2015 18:06:34 -0700
Subject: [PATCH v12 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <1441242397-870-1-git-send-email-stefan@agner.ch>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
Message-ID: <1441242397-870-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds hardware ECC support using the BCH encoder in the NFC IP.
The ECC encoder supports up to 32-bit correction by using 60 error
correction bytes. There is no sub-page ECC step, ECC is calculated
always accross the whole page (up to 2k pages).

Limitations:
- HW ECC: Only 2K page with 64+ OOB.
- HW ECC: Only 24 and 32-bit error correction implemented.

Raw writes have been tested using the generic nand_write_page_raw
implementation. However, raw reads are currently not possible
because the controller need to know whether we are going to use
the ECC mode already at NAND_CMD_READ0 command time. At this point
we do not have the information whether it is a raw read or a
regular read at driver level...

Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/Kconfig     |   6 +-
 drivers/mtd/nand/vf610_nfc.c | 203 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 9f9736c..ccd1158 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -466,8 +466,10 @@ config MTD_NAND_VF610_NFC
 	help
 	  Enables support for NAND Flash Controller on some Freescale
 	  processors like the VF610, MPC5125, MCF54418 or Kinetis K70.
-	  The driver supports a maximum 2k page size. The driver
-	  currently does not support hardware ECC.
+	  The driver supports a maximum 2k page size. With 2k pages and
+	  64 bytes or more of OOB, hardware ECC with up to 32-bit error
+	  correction is supported. Hardware ECC is only enabled through
+	  device tree.
 
 config MTD_NAND_MXC
 	tristate "MXC NAND support"
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 0d76b3d1247..4513b08 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -19,8 +19,8 @@
  * - Untested on MPC5125 and M54418.
  * - DMA and pipelining not used.
  * - 2K pages or less.
- * - No chip select, one NAND chip per controller.
- * - No hardware ECC.
+ * - HW ECC: Only 2K page with 64+ OOB.
+ * - HW ECC: Only 24 and 32-bit error correction implemented.
  */
 
 #include <linux/module.h>
@@ -77,6 +77,8 @@
 
 /* NFC ECC mode define */
 #define ECC_BYPASS			0
+#define ECC_45_BYTE			6
+#define ECC_60_BYTE			7
 
 /*** Register Mask and bit definitions */
 
@@ -129,6 +131,18 @@
 #define CMD_DONE_CLEAR_BIT			BIT(18)
 #define IDLE_CLEAR_BIT				BIT(17)
 
+/*
+ * ECC status - seems to consume 8 bytes (double word). The documented
+ * status byte is located in the lowest byte of the second word (which is
+ * the 4th or 7th byte depending on endianness).
+ * Calculate an offset to store the ECC status at the end of the buffer.
+ */
+#define ECC_SRAM_ADDR		(PAGE_2K + OOB_MAX - 8)
+
+#define ECC_STATUS		0x4
+#define ECC_STATUS_MASK		0x80
+#define ECC_STATUS_ERR_COUNT	0x3F
+
 enum vf610_nfc_alt_buf {
 	ALT_BUF_DATA = 0,
 	ALT_BUF_ID = 1,
@@ -152,10 +166,40 @@ struct vf610_nfc {
 	enum vf610_nfc_alt_buf alt_buf;
 	enum vf610_nfc_variant variant;
 	struct clk *clk;
+	bool use_hw_ecc;
+	u32 ecc_mode;
 };
 
 #define mtd_to_nfc(_mtd) container_of(_mtd, struct vf610_nfc, mtd)
 
+static struct nand_ecclayout vf610_nfc_ecc45 = {
+	.eccbytes = 45,
+	.eccpos = {19, 20, 21, 22, 23,
+		   24, 25, 26, 27, 28, 29, 30, 31,
+		   32, 33, 34, 35, 36, 37, 38, 39,
+		   40, 41, 42, 43, 44, 45, 46, 47,
+		   48, 49, 50, 51, 52, 53, 54, 55,
+		   56, 57, 58, 59, 60, 61, 62, 63},
+	.oobfree = {
+		{.offset = 2,
+		 .length = 17} }
+};
+
+static struct nand_ecclayout vf610_nfc_ecc60 = {
+	.eccbytes = 60,
+	.eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
+		   12, 13, 14, 15, 16, 17, 18, 19,
+		   20, 21, 22, 23, 24, 25, 26, 27,
+		   28, 29, 30, 31, 32, 33, 34, 35,
+		   36, 37, 38, 39, 40, 41, 42, 43,
+		   44, 45, 46, 47, 48, 49, 50, 51,
+		   52, 53, 54, 55, 56, 57, 58, 59,
+		   60, 61, 62, 63 },
+	.oobfree = {
+		{.offset = 2,
+		 .length = 2} }
+};
+
 static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
 {
 	return readl(nfc->regs + reg);
@@ -297,6 +341,13 @@ static void vf610_nfc_addr_cycle(struct vf610_nfc *nfc, int column, int page)
 				    ROW_ADDR_SHIFT, page);
 }
 
+static inline void vf610_nfc_ecc_mode(struct vf610_nfc *nfc, int ecc_mode)
+{
+	vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG,
+			    CONFIG_ECC_MODE_MASK,
+			    CONFIG_ECC_MODE_SHIFT, ecc_mode);
+}
+
 static inline void vf610_nfc_transfer_size(struct vf610_nfc *nfc, int size)
 {
 	vf610_nfc_write(nfc, NFC_SECTOR_SIZE, size);
@@ -315,6 +366,8 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
 	case NAND_CMD_SEQIN:
 		/* Use valid column/page from preread... */
 		vf610_nfc_addr_cycle(nfc, column, page);
+		nfc->buf_offset = 0;
+
 		/*
 		 * SEQIN => data => PAGEPROG sequence is done by the controller
 		 * hence we do not need to issue the command here...
@@ -325,6 +378,10 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
 		vf610_nfc_transfer_size(nfc, trfr_sz);
 		vf610_nfc_send_commands(nfc, NAND_CMD_SEQIN,
 					command, PROGRAM_PAGE_CMD_CODE);
+		if (nfc->use_hw_ecc)
+			vf610_nfc_ecc_mode(nfc, nfc->ecc_mode);
+		else
+			vf610_nfc_ecc_mode(nfc, ECC_BYPASS);
 		break;
 
 	case NAND_CMD_RESET:
@@ -339,6 +396,7 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
 		vf610_nfc_send_commands(nfc, NAND_CMD_READ0,
 					NAND_CMD_READSTART, READ_PAGE_CMD_CODE);
 		vf610_nfc_addr_cycle(nfc, column, page);
+		vf610_nfc_ecc_mode(nfc, ECC_BYPASS);
 		break;
 
 	case NAND_CMD_READ0:
@@ -347,6 +405,7 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
 		vf610_nfc_send_commands(nfc, NAND_CMD_READ0,
 					NAND_CMD_READSTART, READ_PAGE_CMD_CODE);
 		vf610_nfc_addr_cycle(nfc, column, page);
+		vf610_nfc_ecc_mode(nfc, nfc->ecc_mode);
 		break;
 
 	case NAND_CMD_PARAM:
@@ -355,6 +414,7 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
 		vf610_nfc_transfer_size(nfc, trfr_sz);
 		vf610_nfc_send_command(nfc, command, READ_ONFI_PARAM_CMD_CODE);
 		vf610_nfc_addr_cycle(nfc, -1, column);
+		vf610_nfc_ecc_mode(nfc, ECC_BYPASS);
 		break;
 
 	case NAND_CMD_ERASE1:
@@ -383,6 +443,7 @@ static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
 
 	vf610_nfc_done(nfc);
 
+	nfc->use_hw_ecc = false;
 	nfc->write_sz = 0;
 }
 
@@ -477,6 +538,94 @@ static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
 	vf610_nfc_write(nfc, NFC_ROW_ADDR, tmp);
 }
 
+/* Count the number of 0's in buff up to max_bits */
+static inline int count_written_bits(uint8_t *buff, int size, int max_bits)
+{
+	uint32_t *buff32 = (uint32_t *)buff;
+	int k, written_bits = 0;
+
+	for (k = 0; k < (size / 4); k++) {
+		written_bits += hweight32(~buff32[k]);
+		if (unlikely(written_bits > max_bits))
+			break;
+	}
+
+	return written_bits;
+}
+
+static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat,
+					 uint8_t *oob, int page)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	u32 ecc_status_off = NFC_MAIN_AREA(0) + ECC_SRAM_ADDR + ECC_STATUS;
+	u8 ecc_status;
+	u8 ecc_count;
+	int flips;
+	int flips_threshold = nfc->chip.ecc.strength / 2;
+
+	ecc_status = vf610_nfc_read(nfc, ecc_status_off) & 0xff;
+	ecc_count = ecc_status & ECC_STATUS_ERR_COUNT;
+
+	if (!(ecc_status & ECC_STATUS_MASK))
+		return ecc_count;
+
+	/* Read OOB without ECC unit enabled */
+	vf610_nfc_command(mtd, NAND_CMD_READOOB, 0, page);
+	vf610_nfc_read_buf(mtd, oob, mtd->oobsize);
+
+	/*
+	 * On an erased page, bit count (including OOB) should be zero or
+	 * at least less then half of the ECC strength.
+	 */
+	flips = count_written_bits(dat, nfc->chip.ecc.size, flips_threshold);
+	flips += count_written_bits(oob, mtd->oobsize, flips_threshold);
+
+	if (unlikely(flips > flips_threshold))
+		return -EINVAL;
+
+	/* Erased page. */
+	memset(dat, 0xff, nfc->chip.ecc.size);
+	memset(oob, 0xff, mtd->oobsize);
+	return flips;
+}
+
+static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
+				uint8_t *buf, int oob_required, int page)
+{
+	int eccsize = chip->ecc.size;
+	int stat;
+
+	vf610_nfc_read_buf(mtd, buf, eccsize);
+	if (oob_required)
+		vf610_nfc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	stat = vf610_nfc_correct_data(mtd, buf, chip->oob_poi, page);
+
+	if (stat < 0) {
+		mtd->ecc_stats.failed++;
+		return 0;
+	} else {
+		mtd->ecc_stats.corrected += stat;
+		return stat;
+	}
+}
+
+static int vf610_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+			       const uint8_t *buf, int oob_required)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+
+	vf610_nfc_write_buf(mtd, buf, mtd->writesize);
+	if (oob_required)
+		vf610_nfc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	/* Always write whole page including OOB due to HW ECC */
+	nfc->use_hw_ecc = true;
+	nfc->write_sz = mtd->writesize + mtd->oobsize;
+
+	return 0;
+}
+
 static const struct of_device_id vf610_nfc_dt_ids[] = {
 	{ .compatible = "fsl,vf610-nfc", .data = (void *)NFC_VFC610 },
 	{ /* sentinel */ }
@@ -503,6 +652,17 @@ static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
 		vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
 	else
 		vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
+
+	if (nfc->chip.ecc.mode == NAND_ECC_HW) {
+		/* Set ECC status offset in SRAM */
+		vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG,
+				    CONFIG_ECC_SRAM_ADDR_MASK,
+				    CONFIG_ECC_SRAM_ADDR_SHIFT,
+				    ECC_SRAM_ADDR >> 3);
+
+		/* Enable ECC status in SRAM */
+		vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_ECC_SRAM_REQ_BIT);
+	}
 }
 
 static int vf610_nfc_probe(struct platform_device *pdev)
@@ -610,6 +770,45 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	if (chip->ecc.mode == NAND_ECC_HW) {
+		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
+			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
+			err = -ENXIO;
+			goto error;
+		}
+
+		if (chip->ecc.size != mtd->writesize) {
+			dev_err(nfc->dev, "Step size needs to be page size\n");
+			err = -ENXIO;
+			goto error;
+		}
+
+		/* Only 64 byte ECC layouts known */
+		if (mtd->oobsize > 64)
+			mtd->oobsize = 64;
+
+		if (chip->ecc.strength == 32) {
+			nfc->ecc_mode = ECC_60_BYTE;
+			chip->ecc.bytes = 60;
+			chip->ecc.layout = &vf610_nfc_ecc60;
+		} else if (chip->ecc.strength == 24) {
+			nfc->ecc_mode = ECC_45_BYTE;
+			chip->ecc.bytes = 45;
+			chip->ecc.layout = &vf610_nfc_ecc45;
+		} else {
+			dev_err(nfc->dev, "Unsupported ECC strength\n");
+			err = -ENXIO;
+			goto error;
+		}
+
+		/* propagate ecc.layout to mtd_info */
+		mtd->ecclayout = chip->ecc.layout;
+		chip->ecc.read_page = vf610_nfc_read_page;
+		chip->ecc.write_page = vf610_nfc_write_page;
+
+		chip->ecc.size = PAGE_2K;
+	}
+
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
 		err = -ENXIO;
-- 
2.5.1
