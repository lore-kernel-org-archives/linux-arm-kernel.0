From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed,  8 Jan 2014 18:07:18 -0500
Subject: [RFC 2/5] mtd:fsl_nfc: Add hardware 45 byte BHC-ECC support for 24
 bit corrections.
In-Reply-To: <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
---
 drivers/mtd/nand/Kconfig   |   5 +-
 drivers/mtd/nand/fsl_nfc.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7e0c695..8ac9923 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -458,8 +458,9 @@ config MTD_NAND_FSL_NFC
 	help
 	  Enables support for NAND Flash controller on some Freescale
 	  processors like the MPC5125, VF610, MCF54418, and Kinetis K70.
-	  The driver supports a maximum 2k page size.
-	  The driver currently does not support hardware ECC.
+	  The driver supports a maximum 2k page size.  With 2k pages and
+	  64 bytes or more of OOB, hardware ECC with 24bit correction is
+	  supported.  Only MTD_OF (device tree) can enable the hardware ECC.
 
 config MTD_NAND_MXC
 	tristate "MXC NAND support"
diff --git a/drivers/mtd/nand/fsl_nfc.c b/drivers/mtd/nand/fsl_nfc.c
index eb4e353..703511d 100644
--- a/drivers/mtd/nand/fsl_nfc.c
+++ b/drivers/mtd/nand/fsl_nfc.c
@@ -17,6 +17,7 @@
  * - Untested on MPC5125 and M54418.
  * - DMA not used.
  * - 2K pages or less.
+ * - Only 2K page w. 64+OOB and hardware ECC.
  */
 
 #include <linux/module.h>
@@ -68,6 +69,7 @@
 
 /* NFC ECC mode define */
 #define ECC_BYPASS			0
+#define ECC_45_BYTE			6
 
 /*** Register Mask and bit definitions */
 
@@ -100,6 +102,8 @@
 #define STATUS_BYTE1_MASK			0x000000FF
 
 /* NFC_FLASH_CONFIG Field */
+#define CONFIG_ECC_SRAM_ADDR_MASK		0x7FC00000
+#define CONFIG_ECC_SRAM_ADDR_SHIFT		22
 #define CONFIG_ECC_SRAM_REQ_BIT			(1<<21)
 #define CONFIG_DMA_REQ_BIT			(1<<20)
 #define CONFIG_ECC_MODE_MASK			0x000E0000
@@ -120,6 +124,11 @@
 
 #define NFC_TIMEOUT		(HZ)
 
+/* ECC status placed@end of buffers. */
+#define ECC_SRAM_ADDR	((PAGE_2K+256-8) >> 3)
+#define ECC_STATUS_MASK	0x80
+#define ECC_ERR_COUNT	0x3F
+
 struct fsl_nfc {
 	struct mtd_info	   mtd;
 	struct nand_chip   chip;
@@ -160,6 +169,19 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = mirror_pattern,
 };
 
+static struct nand_ecclayout nfc_ecc45 = {
+	.eccbytes = 45,
+	.eccpos = {19, 20, 21, 22, 23,
+		   24, 25, 26, 27, 28, 29, 30, 31,
+		   32, 33, 34, 35, 36, 37, 38, 39,
+		   40, 41, 42, 43, 44, 45, 46, 47,
+		   48, 49, 50, 51, 52, 53, 54, 55,
+		   56, 57, 58, 59, 60, 61, 62, 63},
+	.oobfree = {
+		{.offset = 8,
+		 .length = 11} }
+};
+
 static u32 nfc_read(struct mtd_info *mtd, uint reg)
 {
 	struct fsl_nfc *nfc = mtd_to_nfc(mtd);
@@ -458,7 +480,61 @@ nfc_select_chip(struct mtd_info *mtd, int chip)
 #endif
 }
 
+/* Count the number of 0's in buff upto max_bits */
+static int count_written_bits(uint8_t *buff, int size, int max_bits)
+{
+	int k, written_bits = 0;
+
+	for (k = 0; k < size; k++) {
+		written_bits += hweight8(~buff[k]);
+		if (written_bits > max_bits)
+			break;
+	}
+
+	return written_bits;
+}
+
+static int nfc_correct_data(struct mtd_info *mtd, u_char *dat,
+				 u_char *read_ecc, u_char *calc_ecc)
+{
+	struct fsl_nfc *nfc = mtd_to_nfc(mtd);
+	u32 ecc_status;
+	u8 ecc_count;
+	int flip;
+
+	/* Errata: ECC status is stored at NFC_CFG[ECCADD] +4 for
+	   little-endian and +7 for big-endian SOC.  Access as 32 bits
+	   and use low byte.
+	*/
+	ecc_status = __raw_readl(nfc->regs + ECC_SRAM_ADDR * 8 + 4);
+	ecc_count = ecc_status & ECC_ERR_COUNT;
+	if (!(ecc_status & ECC_STATUS_MASK))
+		return ecc_count;
+
+	/* If 'ecc_count' zero or less then buffer is all 0xff or erased. */
+	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
+
+	/* ECC failed. */
+	if (flip > ecc_count)
+		return -1;
+
+	/* Erased page. */
+	memset(dat, 0xff, nfc->chip.ecc.size);
+	return 0;
+}
+
+static int nfc_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
+				  u_char *ecc_code)
+{
+	return 0;
+}
+
+static void nfc_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+}
+
 struct nfc_config {
+	int hardware_ecc;
 	int width;
 	int flash_bbt;
 	u32 clkrate;
@@ -483,6 +559,9 @@ static int __init nfc_probe_dt(struct device *dev, struct nfc_config *cfg)
 	if (!np)
 		return 1;
 
+	if (of_get_nand_ecc_mode(np) >= NAND_ECC_HW)
+		cfg->hardware_ecc = 1;
+
 	cfg->flash_bbt = of_get_nand_on_flash_bbt(np);
 
 	if (!of_property_read_u32(np, "clock-frequency", &clkrate))
@@ -608,6 +687,11 @@ static int nfc_probe(struct platform_device *pdev)
 	nfc_set_field(mtd, NFC_FLASH_CONFIG, CONFIG_PAGE_CNT_MASK,
 			CONFIG_PAGE_CNT_SHIFT, 1);
 
+	/* Set ECC_STATUS offset */
+	nfc_set_field(mtd, NFC_FLASH_CONFIG,
+		      CONFIG_ECC_SRAM_ADDR_MASK,
+		      CONFIG_ECC_SRAM_ADDR_SHIFT, ECC_SRAM_ADDR);
+
 	/* first scan to find the device and get the page size */
 	if (nand_scan_ident(mtd, 1, NULL)) {
 		err = -ENXIO;
@@ -627,6 +711,36 @@ static int nfc_probe(struct platform_device *pdev)
 	page_sz += cfg.width == 16 ? 1 : 0;
 	nfc_write(mtd, NFC_SECTOR_SIZE, page_sz);
 
+	if (cfg.hardware_ecc) {
+		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
+			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
+			err = -ENXIO;
+			goto error;
+		}
+
+		chip->ecc.layout = &nfc_ecc45;
+
+		/* propagate ecc.layout to mtd_info */
+		mtd->ecclayout = chip->ecc.layout;
+		chip->ecc.calculate = nfc_calculate_ecc;
+		chip->ecc.hwctl = nfc_enable_hwecc;
+		chip->ecc.correct = nfc_correct_data;
+		chip->ecc.mode = NAND_ECC_HW;
+
+		chip->ecc.bytes = 45;
+		chip->ecc.size = PAGE_2K;
+		chip->ecc.strength = 24;
+
+		/* set ECC mode to 45 bytes OOB with 24 bits correction */
+		nfc_set_field(mtd, NFC_FLASH_CONFIG,
+				CONFIG_ECC_MODE_MASK,
+				CONFIG_ECC_MODE_SHIFT, ECC_45_BYTE);
+
+		/* Enable ECC_STATUS */
+		nfc_set(mtd, NFC_FLASH_CONFIG, CONFIG_ECC_SRAM_REQ_BIT);
+
+	}
+
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
 		err = -ENXIO;
-- 
1.8.0.2
