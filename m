From: stefan@agner.ch (Stefan Agner)
Date: Thu,  5 Mar 2015 00:10:21 +0100
Subject: [PATCH 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <1425510624-22250-1-git-send-email-stefan@agner.ch>
References: <1425510624-22250-1-git-send-email-stefan@agner.ch>
Message-ID: <1425510624-22250-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds hardware ECC support using the BCH encoder in the NFC IP.
The ECC encoder supports up to 32-bit correction by using 60 error
correction bytes. There is no sub-page ECC step, ECC is calculated
always accross the whole page (up to 2k pages).

Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/Kconfig     |   6 +-
 drivers/mtd/nand/vf610_nfc.c | 193 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 172 insertions(+), 27 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 1be30a6..0fb97b3 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -464,8 +464,10 @@ config MTD_NAND_VF610_NFC
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
index 101fd20..c6fb379 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -19,6 +19,7 @@
  * - Untested on MPC5125 and M54418.
  * - DMA not used.
  * - 2K pages or less.
+ * - Only 2K page w. 64+OOB and hardware ECC.
  */
 
 #include <linux/module.h>
@@ -71,6 +72,8 @@
 
 /* NFC ECC mode define */
 #define ECC_BYPASS			0
+#define ECC_45_BYTE			6
+#define ECC_60_BYTE			7
 
 /*** Register Mask and bit definitions */
 
@@ -103,6 +106,8 @@
 #define STATUS_BYTE1_MASK			0x000000FF
 
 /* NFC_FLASH_CONFIG Field */
+#define CONFIG_ECC_SRAM_ADDR_MASK		0x7FC00000
+#define CONFIG_ECC_SRAM_ADDR_SHIFT		22
 #define CONFIG_ECC_SRAM_REQ_BIT			(1<<21)
 #define CONFIG_DMA_REQ_BIT			(1<<20)
 #define CONFIG_ECC_MODE_MASK			0x000E0000
@@ -123,13 +128,32 @@
 
 #define NFC_TIMEOUT		(HZ)
 
+/* ECC status placed@end of buffers. */
+#define ECC_SRAM_ADDR	((PAGE_2K+256-8) >> 3)
+#define ECC_STATUS_MASK	0x80
+#define ECC_ERR_COUNT	0x3F
+
+/*
+ * ECC status is stored at NFC_CFG[ECCADD] +4 for little-endian
+ * and +7 for big-endian SoCs.
+ */
+#ifdef CONFIG_SOC_VF610
+#define ECC_OFFSET	4
+#else
+#define ECC_OFFSET	7
+#endif
+
 struct vf610_nfc_config {
+	bool hardware_ecc;
+	int ecc_strength;
+	int ecc_step_size;
 	int width;
 	int flash_bbt;
 	u32 clkrate;
+	u32 ecc_mode;
 };
 
-struct fsl_nfc {
+struct vf610_nfc {
 	struct mtd_info	   mtd;
 	struct nand_chip   chip;
 	struct device	  *dev;
@@ -149,27 +173,32 @@ struct fsl_nfc {
 
 #define mtd_to_nfc(_mtd) container_of(_mtd, struct vf610_nfc, mtd)
 
-static u8 bbt_pattern[] = {'B', 'b', 't', '0' };
-static u8 mirror_pattern[] = {'1', 't', 'b', 'B' };
-
-static struct nand_bbt_descr bbt_main_descr = {
-	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE |
-		   NAND_BBT_2BIT | NAND_BBT_VERSION,
-	.offs =	11,
-	.len = 4,
-	.veroffs = 15,
-	.maxblocks = 4,
-	.pattern = bbt_pattern,
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
 };
 
-static struct nand_bbt_descr bbt_mirror_descr = {
-	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE |
-		   NAND_BBT_2BIT | NAND_BBT_VERSION,
-	.offs =	11,
-	.len = 4,
-	.veroffs = 15,
-	.maxblocks = 4,
-	.pattern = mirror_pattern,
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
 };
 
 static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
@@ -470,6 +499,60 @@ static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
 #endif
 }
 
+/* Count the number of 0's in buff up to max_bits */
+static inline int count_written_bits(uint8_t *buff, int size, int max_bits)
+{
+	uint32_t *buff32 = (uint32_t *)buff;
+	int k, written_bits = 0;
+
+	for (k = 0; k < (size / 4); k++) {
+		written_bits += hweight32(~buff32[k]);
+		if (written_bits > max_bits)
+			break;
+	}
+
+	return written_bits;
+}
+
+static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat,
+					 uint8_t *read_ecc, uint8_t *calc_ecc)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	u8 ecc_status;
+	u8 ecc_count;
+	int flip;
+
+	ecc_status = __raw_readb(nfc->regs + ECC_SRAM_ADDR * 8 + ECC_OFFSET);
+	ecc_count = ecc_status & ECC_ERR_COUNT;
+	if (!(ecc_status & ECC_STATUS_MASK))
+		return ecc_count;
+
+	/*
+	 * On an erased page, bit count should be zero or at least
+	 * less then half of the ECC strength
+	 */
+	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
+
+	if (flip > ecc_count && flip > (nfc->chip.ecc.strength / 2)) {
+		nfc->page = -1;
+		return -1;
+	}
+
+	/* Erased page. */
+	memset(dat, 0xff, nfc->chip.ecc.size);
+	return 0;
+}
+
+static int vf610_nfc_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
+				   u_char *ecc_code)
+{
+	return 0;
+}
+
+static void vf610_nfc_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+}
+
 #ifdef CONFIG_OF_MTD
 static const struct of_device_id vf610_nfc_dt_ids[] = {
 	{ .compatible = "fsl,vf610-nfc" },
@@ -487,7 +570,17 @@ static int vf610_nfc_probe_dt(struct device *dev, struct vf610_nfc_config *cfg)
 	if (!np)
 		return 1;
 
+	if (of_get_nand_ecc_mode(np) >= NAND_ECC_HW)
+		cfg->hardware_ecc = 1;
+
 	cfg->flash_bbt = of_get_nand_on_flash_bbt(np);
+	cfg->ecc_strength = of_get_nand_ecc_strength(np);
+	if (cfg->ecc_strength < 0)
+		cfg->ecc_strength = 0;
+
+	cfg->ecc_step_size = of_get_nand_ecc_step_size(np);
+	if (cfg->ecc_step_size < 0)
+		cfg->ecc_step_size = 0;
 
 	if (!of_property_read_u32(np, "clock-frequency", &clkrate))
 		cfg->clkrate = clkrate;
@@ -534,6 +627,15 @@ static int vf610_nfc_init_controller(struct vf610_nfc *nfc, int page_sz)
 
 	vf610_nfc_write(nfc, NFC_SECTOR_SIZE, page_sz);
 
+	if (cfg->hardware_ecc) {
+		vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG,
+				    CONFIG_ECC_MODE_MASK,
+				    CONFIG_ECC_MODE_SHIFT, cfg->ecc_mode);
+
+		/* Enable ECC_STATUS */
+		vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_ECC_SRAM_REQ_BIT);
+	}
+
 	return 0;
 }
 
@@ -610,10 +712,8 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 
 	/* Bad block options. */
 	if (cfg->flash_bbt)
-		chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_CREATE;
-
-	chip->bbt_td = &bbt_main_descr;
-	chip->bbt_md = &bbt_mirror_descr;
+		chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB |
+				    NAND_BBT_CREATE;
 
 	init_waitqueue_head(&nfc->irq_waitq);
 
@@ -640,13 +740,56 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 
 	/* Single buffer only, max 256 OOB minus ECC status */
 	if (page_sz > PAGE_2K + 256 - 8) {
-		dev_err(nfc->dev, "Unsupported flash size\n");
+		dev_err(nfc->dev, "Unsupported flash page size\n");
 		err = -ENXIO;
 		goto error;
 	}
 	page_sz += cfg->width == 16 ? 1 : 0;
 	vf610_nfc_write(nfc, NFC_SECTOR_SIZE, page_sz);
 
+	if (cfg->hardware_ecc) {
+		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
+			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
+			err = -ENXIO;
+			goto error;
+		}
+
+		if (cfg->ecc_step_size != mtd->writesize) {
+			dev_err(nfc->dev, "Step size needs to be page size\n");
+			err = -ENXIO;
+			goto error;
+		}
+
+		if (cfg->ecc_strength == 32) {
+			cfg->ecc_mode = ECC_60_BYTE;
+			chip->ecc.bytes = 60;
+			chip->ecc.layout = &vf610_nfc_ecc60;
+		} else if (cfg->ecc_strength == 24) {
+			cfg->ecc_mode = ECC_45_BYTE;
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
+		chip->ecc.calculate = vf610_nfc_calculate_ecc;
+		chip->ecc.hwctl = vf610_nfc_enable_hwecc;
+		chip->ecc.correct = vf610_nfc_correct_data;
+		chip->ecc.mode = NAND_ECC_HW;
+
+		chip->ecc.size = PAGE_2K;
+		chip->ecc.strength = cfg->ecc_strength;
+
+		/* set ECC mode according to required ECC strength */
+		vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG,
+				    CONFIG_ECC_MODE_MASK,
+				    CONFIG_ECC_MODE_SHIFT, cfg->ecc_mode);
+	}
+
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
 		err = -ENXIO;
-- 
2.3.0
