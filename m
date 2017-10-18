From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed, 18 Oct 2017 16:36:18 +0200
Subject: [RFC 01/12] mtd: nand: provide several helpers to do common NAND
 operations
In-Reply-To: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
Message-ID: <20171018143629.29302-2-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

This is part of the process of removing direct calls to ->cmdfunc()
outside of the core in order to introduce a better interface to execute
NAND operations.

Here we provide several helpers and make use of them to remove all
direct calls to ->cmdfunc(). This way, we can easily modify those
helpers to make use of the new ->exec_op() interface when available.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
[miquel.raynal at free-electrons.com: rebased and fixed some conflicts]
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/mtd/nand/atmel/nand-controller.c |   2 +-
 drivers/mtd/nand/brcmnand/brcmnand.c     |   9 +-
 drivers/mtd/nand/cafe_nand.c             |  14 +-
 drivers/mtd/nand/denali.c                |   2 +-
 drivers/mtd/nand/diskonchip.c            |   4 +-
 drivers/mtd/nand/docg4.c                 |   7 +-
 drivers/mtd/nand/fsmc_nand.c             |   5 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c   |  56 +-
 drivers/mtd/nand/hisi504_nand.c          |   3 +-
 drivers/mtd/nand/jz4740_nand.c           |  16 +-
 drivers/mtd/nand/lpc32xx_mlc.c           |   2 +-
 drivers/mtd/nand/lpc32xx_slc.c           |  22 +-
 drivers/mtd/nand/mtk_nand.c              |  11 +-
 drivers/mtd/nand/nand_base.c             | 956 ++++++++++++++++++++++++++-----
 drivers/mtd/nand/nand_hynix.c            |  17 +-
 drivers/mtd/nand/nand_micron.c           |  17 +-
 drivers/mtd/nand/omap2.c                 |   8 +-
 drivers/mtd/nand/pxa3xx_nand.c           |   8 +-
 drivers/mtd/nand/qcom_nandc.c            |  16 +-
 drivers/mtd/nand/r852.c                  |  11 +-
 drivers/mtd/nand/sunxi_nand.c            |  67 +--
 drivers/mtd/nand/tango_nand.c            |  26 +-
 drivers/mtd/nand/tmio_nand.c             |   5 +-
 include/linux/mtd/rawnand.h              |  25 +
 24 files changed, 943 insertions(+), 366 deletions(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index 29182160bb5f..0b2c82727b24 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -1000,7 +1000,7 @@ static int atmel_hsmc_nand_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
 	 * to the non-optimized one.
 	 */
 	if (nand->activecs->rb.type != ATMEL_NAND_NATIVE_RB) {
-		chip->cmdfunc(mtd, NAND_CMD_READ0, 0x00, page);
+		nand_read_page_op(chip, page, 0, NULL, 0);
 
 		return atmel_nand_pmecc_read_pg(chip, buf, oob_required, page,
 						raw);
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index e0eb51d8c012..3f441096a14c 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1071,7 +1071,7 @@ static void brcmnand_wp(struct mtd_info *mtd, int wp)
 			return;
 
 		brcmnand_set_wp(ctrl, wp);
-		chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
+		nand_status_op(chip, NULL);
 		/* NAND_STATUS_WP 0x00 = protected, 0x80 = not protected */
 		ret = bcmnand_ctrl_poll_status(ctrl,
 					       NAND_CTRL_RDY |
@@ -1453,7 +1453,7 @@ static uint8_t brcmnand_read_byte(struct mtd_info *mtd)
 
 		/* At FC_BYTES boundary, switch to next column */
 		if (host->last_byte > 0 && offs == 0)
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, addr, -1);
+			nand_change_read_column_op(chip, addr, NULL, 0, false);
 
 		ret = ctrl->flash_cache[offs];
 		break;
@@ -1689,7 +1689,7 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	sas = mtd->oobsize / chip->ecc.steps;
 
 	/* read without ecc for verification */
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0x00, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 	ret = chip->ecc.read_page_raw(mtd, chip, buf, true, page);
 	if (ret)
 		return ret;
@@ -2369,12 +2369,11 @@ static int brcmnand_resume(struct device *dev)
 
 	list_for_each_entry(host, &ctrl->host_list, node) {
 		struct nand_chip *chip = &host->chip;
-		struct mtd_info *mtd = nand_to_mtd(chip);
 
 		brcmnand_save_restore_cs_config(host, 1);
 
 		/* Reset the chip, required by some chips after power-up */
-		chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+		nand_reset_op(chip);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index bc558c438a57..95c2cfa68b66 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -353,23 +353,15 @@ static void cafe_nand_bug(struct mtd_info *mtd)
 static int cafe_nand_write_oob(struct mtd_info *mtd,
 			       struct nand_chip *chip, int page)
 {
-	int status = 0;
-
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize, page);
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-	status = chip->waitfunc(mtd, chip);
-
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_op(chip, page, mtd->writesize, chip->oob_poi,
+				 mtd->oobsize);
 }
 
 /* Don't use -- use nand_read_oob_std for now */
 static int cafe_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 			      int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
-	return 0;
+	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 /**
  * cafe_nand_read_page_syndrome - [REPLACEABLE] hardware ecc syndrome based page read
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 5124f8ae8c04..f90f93a8fb08 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -951,7 +951,7 @@ static int denali_erase(struct mtd_info *mtd, int page)
 	irq_status = denali_wait_for_irq(denali,
 					 INTR__ERASE_COMP | INTR__ERASE_FAIL);
 
-	return irq_status & INTR__ERASE_COMP ? 0 : NAND_STATUS_FAIL;
+	return irq_status & INTR__ERASE_FAIL ? -EIO : 0;
 }
 
 static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 72671dc52e2e..6bc93ea66f50 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -448,7 +448,7 @@ static int doc200x_wait(struct mtd_info *mtd, struct nand_chip *this)
 	int status;
 
 	DoC_WaitReady(doc);
-	this->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
+	nand_status_op(this, NULL);
 	DoC_WaitReady(doc);
 	status = (int)this->read_byte(mtd);
 
@@ -595,7 +595,7 @@ static void doc2001plus_select_chip(struct mtd_info *mtd, int chip)
 
 	/* Assert ChipEnable and deassert WriteProtect */
 	WriteDOC((DOC_FLASH_CE), docptr, Mplus_FlashSelect);
-	this->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+	nand_reset_op(this);
 
 	doc->curchip = chip;
 	doc->curfloor = floor;
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index 2436cbc71662..45c01b4b34c7 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -900,6 +900,7 @@ static int docg4_erase_block(struct mtd_info *mtd, int page)
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t g4_page;
+	int status;
 
 	dev_dbg(doc->dev, "%s: page %04x\n", __func__, page);
 
@@ -939,7 +940,11 @@ static int docg4_erase_block(struct mtd_info *mtd, int page)
 	poll_status(doc);
 	write_nop(docptr);
 
-	return nand->waitfunc(mtd, nand);
+	status = nand->waitfunc(mtd, nand);
+	if (status < 0)
+		return status;
+
+	return status & NAND_STATUS_FAIL ? -EIO : 0;
 }
 
 static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index eac15d9bf49e..b44e5c6545e0 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -697,7 +697,7 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	unsigned int max_bitflips = 0;
 
 	for (i = 0, s = 0; s < eccsteps; s++, i += eccbytes, p += eccsize) {
-		chip->cmdfunc(mtd, NAND_CMD_READ0, s * eccsize, page);
+		nand_read_page_op(chip, page, s * eccsize, NULL, 0);
 		chip->ecc.hwctl(mtd, NAND_ECC_READ);
 		chip->read_buf(mtd, p, eccsize);
 
@@ -720,8 +720,7 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 			if (chip->options & NAND_BUSWIDTH_16)
 				len = roundup(len, 2);
 
-			chip->cmdfunc(mtd, NAND_CMD_READOOB, off, page);
-			chip->read_buf(mtd, oob + j, len);
+			nand_read_oob_op(chip, page, off, oob + j, len);
 			j += len;
 		}
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 50f8d4a1b983..c8ceaecd8065 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1097,8 +1097,8 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			eccbytes = DIV_ROUND_UP(offset + eccbits, 8);
 			offset /= 8;
 			eccbytes -= offset;
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
-			chip->read_buf(mtd, eccbuf, eccbytes);
+			nand_change_read_column_op(chip, offset, eccbuf,
+						   eccbytes, false);
 
 			/*
 			 * ECC data are not byte aligned and we may have
@@ -1411,7 +1411,7 @@ static int gpmi_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	memset(chip->oob_poi, ~0, mtd->oobsize);
 
 	/* Read out the conventional OOB. */
-	chip->cmdfunc(mtd, NAND_CMD_READ0, mtd->writesize, page);
+	nand_read_page_op(chip, page, mtd->writesize, NULL, 0);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
 	/*
@@ -1421,7 +1421,7 @@ static int gpmi_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	 */
 	if (GPMI_IS_MX23(this)) {
 		/* Read the block mark into the first byte of the OOB buffer. */
-		chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+		nand_read_page_op(chip, page, 0, NULL, 0);
 		chip->oob_poi[0] = chip->read_byte(mtd);
 	}
 
@@ -1432,7 +1432,6 @@ static int
 gpmi_ecc_write_oob(struct mtd_info *mtd, struct nand_chip *chip, int page)
 {
 	struct mtd_oob_region of = { };
-	int status = 0;
 
 	/* Do we have available oob area? */
 	mtd_ooblayout_free(mtd, 0, &of);
@@ -1442,12 +1441,8 @@ gpmi_ecc_write_oob(struct mtd_info *mtd, struct nand_chip *chip, int page)
 	if (!nand_is_slc(chip))
 		return -EPERM;
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize + of.offset, page);
-	chip->write_buf(mtd, chip->oob_poi + of.offset, of.length);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_op(chip, page, mtd->writesize + of.offset,
+				 chip->oob_poi + of.offset, of.length);
 }
 
 /*
@@ -1630,7 +1625,7 @@ static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
 static int gpmi_ecc_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				 int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	return gpmi_ecc_read_page_raw(mtd, chip, NULL, 1, page);
 }
@@ -1638,7 +1633,7 @@ static int gpmi_ecc_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				 int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0, page);
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
 	return gpmi_ecc_write_page_raw(mtd, chip, NULL, 1, page);
 }
@@ -1649,7 +1644,7 @@ static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	int ret = 0;
 	uint8_t *block_mark;
-	int column, page, status, chipnr;
+	int column, page, chipnr;
 
 	chipnr = (int)(ofs >> chip->chip_shift);
 	chip->select_chip(mtd, chipnr);
@@ -1663,13 +1658,7 @@ static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	/* Shift to get page */
 	page = (int)(ofs >> chip->page_shift);
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, column, page);
-	chip->write_buf(mtd, block_mark, 1);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-	if (status & NAND_STATUS_FAIL)
-		ret = -EIO;
+	ret = nand_prog_page_op(chip, page, column, block_mark, 1);
 
 	chip->select_chip(mtd, -1);
 
@@ -1737,7 +1726,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 		 * Read the NCB fingerprint. The fingerprint is four bytes long
 		 * and starts in the 12th byte of the page.
 		 */
-		chip->cmdfunc(mtd, NAND_CMD_READ0, 12, page);
+		nand_read_page_op(chip, page, 12, NULL, 0);
 		chip->read_buf(mtd, buffer, strlen(fingerprint));
 
 		/* Look for the fingerprint. */
@@ -1797,17 +1786,10 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 	dev_dbg(dev, "Erasing the search area...\n");
 
 	for (block = 0; block < search_area_size_in_blocks; block++) {
-		/* Compute the page address. */
-		page = block * block_size_in_pages;
-
 		/* Erase this block. */
 		dev_dbg(dev, "\tErasing block 0x%x\n", block);
-		chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
-		chip->cmdfunc(mtd, NAND_CMD_ERASE2, -1, -1);
-
-		/* Wait for the erase to finish. */
-		status = chip->waitfunc(mtd, chip);
-		if (status & NAND_STATUS_FAIL)
+		status = nand_erase_op(chip, block);
+		if (status)
 			dev_err(dev, "[%s] Erase failed.\n", __func__);
 	}
 
@@ -1823,13 +1805,11 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 
 		/* Write the first page of the current stride. */
 		dev_dbg(dev, "Writing an NCB fingerprint in page 0x%x\n", page);
-		chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
-		chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
-		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
 
-		/* Wait for the write to finish. */
-		status = chip->waitfunc(mtd, chip);
-		if (status & NAND_STATUS_FAIL)
+		nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+		chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
+		status = nand_prog_page_end_op(chip);
+		if (status)
 			dev_err(dev, "[%s] Write failed.\n", __func__);
 	}
 
@@ -1884,7 +1864,7 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 
 		/* Send the command to read the conventional block mark. */
 		chip->select_chip(mtd, chipnr);
-		chip->cmdfunc(mtd, NAND_CMD_READ0, mtd->writesize, page);
+		nand_read_page_op(chip, page, mtd->writesize, NULL, 0);
 		block_mark = chip->read_byte(mtd);
 		chip->select_chip(mtd, -1);
 
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 0897261c3e17..184d765c8bbe 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -574,8 +574,7 @@ static int hisi_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct hinfc_host *host = nand_get_controller_data(chip);
 
-	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 
 	if (host->irq_status & HINFC504_INTS_UE) {
 		host->irq_status = 0;
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index ad827d4af3e9..613b00a9604b 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -313,6 +313,7 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 	uint32_t ctrl;
 	struct nand_chip *chip = &nand->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 id[2];
 
 	/* Request I/O resource. */
 	sprintf(res_name, "bank%d", bank);
@@ -335,17 +336,16 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 
 		/* Retrieve the IDs from the first chip. */
 		chip->select_chip(mtd, 0);
-		chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
-		chip->cmdfunc(mtd, NAND_CMD_READID, 0x00, -1);
-		*nand_maf_id = chip->read_byte(mtd);
-		*nand_dev_id = chip->read_byte(mtd);
+		nand_reset_op(chip);
+		nand_readid_op(chip, 0, id, sizeof(id));
+		*nand_maf_id = id[0];
+		*nand_dev_id = id[1];
 	} else {
 		/* Detect additional chip. */
 		chip->select_chip(mtd, chipnr);
-		chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
-		chip->cmdfunc(mtd, NAND_CMD_READID, 0x00, -1);
-		if (*nand_maf_id != chip->read_byte(mtd)
-		 || *nand_dev_id != chip->read_byte(mtd)) {
+		nand_reset_op(chip);
+		nand_readid_op(chip, 0, id, sizeof(id));
+		if (*nand_maf_id != id[0] || *nand_dev_id != id[1]) {
 			ret = -ENODEV;
 			goto notfound_id;
 		}
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index c3bb358ef01e..0723ded232ff 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -461,7 +461,7 @@ static int lpc32xx_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	/* Writing Command and Address */
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	/* For all sub-pages */
 	for (i = 0; i < host->mlcsubpages; i++) {
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index b61f28a1554d..2b96c281b1a2 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -399,10 +399,7 @@ static void lpc32xx_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf, int
 static int lpc32xx_nand_read_oob_syndrome(struct mtd_info *mtd,
 					  struct nand_chip *chip, int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	return 0;
+	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 
 /*
@@ -411,17 +408,8 @@ static int lpc32xx_nand_read_oob_syndrome(struct mtd_info *mtd,
 static int lpc32xx_nand_write_oob_syndrome(struct mtd_info *mtd,
 	struct nand_chip *chip, int page)
 {
-	int status;
-
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize, page);
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	/* Send command to program the OOB data */
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_op(chip, page, mtd->writesize, chip->oob_poi,
+				 mtd->oobsize);
 }
 
 /*
@@ -632,7 +620,7 @@ static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
 	uint8_t *oobecc, tmpecc[LPC32XX_ECC_SAVE_SIZE];
 
 	/* Issue read command */
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	/* Read data and oob, calculate ECC */
 	status = lpc32xx_xfer(mtd, buf, chip->ecc.steps, 1);
@@ -675,7 +663,7 @@ static int lpc32xx_nand_read_page_raw_syndrome(struct mtd_info *mtd,
 					       int page)
 {
 	/* Issue read command */
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	/* Raw reads can just use the FIFO interface */
 	chip->read_buf(mtd, buf, chip->ecc.size * chip->ecc.steps);
diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
index d86a7d131cc0..1a3fcb65f478 100644
--- a/drivers/mtd/nand/mtk_nand.c
+++ b/drivers/mtd/nand/mtk_nand.c
@@ -834,16 +834,13 @@ static int mtk_nfc_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int ret;
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
 	ret = mtk_nfc_write_page_raw(mtd, chip, NULL, 1, page);
 	if (ret < 0)
 		return -EIO;
 
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-	ret = chip->waitfunc(mtd, chip);
-
-	return ret & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int mtk_nfc_update_ecc_stats(struct mtd_info *mtd, u8 *buf, u32 sectors)
@@ -1016,7 +1013,7 @@ static int mtk_nfc_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 static int mtk_nfc_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
 				int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	return mtk_nfc_read_page_raw(mtd, chip, NULL, 1, page);
 }
@@ -1556,7 +1553,7 @@ static int mtk_nfc_resume(struct device *dev)
 		mtd = nand_to_mtd(nand);
 		for (i = 0; i < chip->nsels; i++) {
 			nand->select_chip(mtd, i);
-			nand->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+			nand_reset_op(nand);
 		}
 	}
 
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index c63e4a88a653..f7dd7d5a84b3 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -561,14 +561,19 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 static int nand_check_wp(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	u8 status;
+	int ret;
 
 	/* Broken xD cards report WP despite being writable */
 	if (chip->options & NAND_BROKEN_XD)
 		return 0;
 
 	/* Check the WP bit */
-	chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
-	return (chip->read_byte(mtd) & NAND_STATUS_WP) ? 0 : 1;
+	ret = nand_status_op(chip, &status);
+	if (ret)
+		return ret;
+
+	return status & NAND_STATUS_WP ? 0 : 1;
 }
 
 /**
@@ -667,10 +672,17 @@ EXPORT_SYMBOL_GPL(nand_wait_ready);
 static void nand_wait_status_ready(struct mtd_info *mtd, unsigned long timeo)
 {
 	register struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
 
 	timeo = jiffies + msecs_to_jiffies(timeo);
 	do {
-		if ((chip->read_byte(mtd) & NAND_STATUS_READY))
+		u8 status;
+
+		ret = nand_read_data_op(chip, &status, sizeof(status), true);
+		if (ret)
+			return;
+
+		if (status & NAND_STATUS_READY)
 			break;
 		touch_softlockup_watchdog();
 	} while (time_before(jiffies, timeo));
@@ -1014,7 +1026,15 @@ static void panic_nand_wait(struct mtd_info *mtd, struct nand_chip *chip,
 			if (chip->dev_ready(mtd))
 				break;
 		} else {
-			if (chip->read_byte(mtd) & NAND_STATUS_READY)
+			int ret;
+			u8 status;
+
+			ret = nand_read_data_op(chip, &status, sizeof(status),
+						true);
+			if (ret)
+				return;
+
+			if (status & NAND_STATUS_READY)
 				break;
 		}
 		mdelay(1);
@@ -1031,8 +1051,9 @@ static void panic_nand_wait(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
 
-	int status;
 	unsigned long timeo = 400;
+	u8 status;
+	int ret;
 
 	/*
 	 * Apply this short delay always to ensure that we do wait tWB in any
@@ -1040,7 +1061,9 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	 */
 	ndelay(100);
 
-	chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
+	ret = nand_status_op(chip, NULL);
+	if (ret)
+		return ret;
 
 	if (in_interrupt() || oops_in_progress)
 		panic_nand_wait(mtd, chip, timeo);
@@ -1051,14 +1074,22 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 				if (chip->dev_ready(mtd))
 					break;
 			} else {
-				if (chip->read_byte(mtd) & NAND_STATUS_READY)
+				ret = nand_read_data_op(chip, &status,
+							sizeof(status), true);
+				if (ret)
+					return ret;
+
+				if (status & NAND_STATUS_READY)
 					break;
 			}
 			cond_resched();
 		} while (time_before(jiffies, timeo));
 	}
 
-	status = (int)chip->read_byte(mtd);
+	ret = nand_read_data_op(chip, &status, sizeof(status), true);
+	if (ret)
+		return ret;
+
 	/* This can happen if in case of timeout or buggy dev_ready */
 	WARN_ON(!(status & NAND_STATUS_READY));
 	return status;
@@ -1213,6 +1244,492 @@ static void nand_release_data_interface(struct nand_chip *chip)
 }
 
 /**
+ * nand_read_page_op - Do a READ PAGE operation
+ * @chip: The NAND chip
+ * @page: page to read
+ * @offset_in_page: offset within the page
+ * @buf: buffer used to store the data
+ * @len: length of the buffer
+ *
+ * This function issues a READ PAGE operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_read_page_op(struct nand_chip *chip, unsigned int page,
+		      unsigned int column, void *buf, unsigned int len)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (len && !buf)
+		return -EINVAL;
+
+	if (column + len > mtd->writesize + mtd->oobsize)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_READ0, column, page);
+	if (len)
+		chip->read_buf(mtd, buf, len);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_read_page_op);
+
+/**
+ * nand_read_param_page_op - Do a READ PARAMETER PAGE operation
+ * @chip: The NAND chip
+ * @page: parameter page to read
+ * @buf: buffer used to store the data
+ * @len: length of the buffer
+ *
+ * This function issues a READ PARAMETER PAGE operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
+				   unsigned int len)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	unsigned int i;
+	u8 *p = buf;
+
+	if (len && !buf)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_PARAM, page, -1);
+	for (i = 0; i < len; i++)
+		p[i] = chip->read_byte(mtd);
+
+	return 0;
+}
+
+/**
+ * nand_change_read_column_op - Do a CHANGE READ COLUMN operation
+ * @chip: The NAND chip
+ * @offset_in_page: offset within the page
+ * @buf: buffer used to store the data
+ * @len: length of the buffer
+ * @force_8bit: force 8-bit bus access
+ *
+ * This function issues a CHANGE READ COLUMN operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_change_read_column_op(struct nand_chip *chip, unsigned int column,
+			       void *buf, unsigned int len, bool force_8bit)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (len && !buf)
+		return -EINVAL;
+
+	if (column + len > mtd->writesize + mtd->oobsize)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, column, -1);
+	if (len)
+		chip->read_buf(mtd, buf, len);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_change_read_column_op);
+
+/**
+ * nand_read_oob_op - Do a READ OOB operation
+ * @chip: The NAND chip
+ * @page: page to read
+ * @offset_in_page: offset within the page
+ * @buf: buffer used to store the data
+ * @len: length of the buffer
+ *
+ * This function issues a READ OOB operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
+		     unsigned int column, void *buf, unsigned int len)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (len && !buf)
+		return -EINVAL;
+
+	if (column + len > mtd->oobsize)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_READOOB, column, page);
+	if (len)
+		chip->read_buf(mtd, buf, len);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_read_oob_op);
+
+/**
+ * nand_prog_page_begin_op - starts a PROG PAGE operation
+ * @chip: The NAND chip
+ * @page: page to write
+ * @offset_in_page: offset within the page
+ * @buf: buffer containing the data to write to the page
+ * @len: length of the buffer
+ *
+ * This function issues the first half of a PROG PAGE operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
+			    unsigned int column, const void *buf,
+			    unsigned int len)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (len && !buf)
+		return -EINVAL;
+
+	if (column + len > mtd->writesize + mtd->oobsize)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, column, page);
+
+	if (buf)
+		chip->write_buf(mtd, buf, len);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_prog_page_begin_op);
+
+/**
+ * nand_prog_page_end_op - ends a PROG PAGE operation
+ * @chip: The NAND chip
+ *
+ * This function issues the second half of a PROG PAGE operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_prog_page_end_op(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int status;
+
+	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+
+	status = chip->waitfunc(mtd, chip);
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_prog_page_end_op);
+
+/**
+ * nand_prog_page_op - Do a full PROG PAGE operation
+ * @chip: The NAND chip
+ * @page: page to write
+ * @offset_in_page: offset within the page
+ * @buf: buffer containing the data to write to the page
+ * @len: length of the buffer
+ *
+ * This function issues a full PROG PAGE operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
+		      unsigned int column, const void *buf, unsigned int len)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int status;
+
+	if (!len || !buf)
+		return -EINVAL;
+
+	if (column + len > mtd->writesize + mtd->oobsize)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, column, page);
+	chip->write_buf(mtd, buf, len);
+	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+
+	status = chip->waitfunc(mtd, chip);
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_prog_page_op);
+
+/**
+ * nand_change_write_column_op - Do a CHANGE WRITE COLUMN operation
+ * @chip: The NAND chip
+ * @offset_in_page: offset within the page
+ * @buf: buffer containing the data to send to the NAND
+ * @len: length of the buffer
+ * @force_8bit: force 8-bit bus access
+ *
+ * This function issues a CHANGE WRITE COLUMN operation.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_change_write_column_op(struct nand_chip *chip, unsigned int column,
+				const void *buf, unsigned int len,
+				bool force_8bit)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (len && !buf)
+		return -EINVAL;
+
+	if (column + len > mtd->writesize + mtd->oobsize)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_RNDIN, column, -1);
+	if (len)
+		chip->write_buf(mtd, buf, len);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_change_write_column_op);
+
+/**
+ * nand_readid_op - Do a READID operation
+ * @chip: The NAND chip
+ * @addr: address cycle to pass after the READID command
+ * @buf: buffer used to store the ID
+ * @len: length of the buffer
+ *
+ * This function sends a READID command and reads back the ID returned by the
+ * NAND.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_readid_op(struct nand_chip *chip, u8 addr,
+		   void *buf, unsigned int len)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	unsigned int i;
+	u8 *id = buf;
+
+	if (!len || !buf)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_READID, addr, -1);
+
+	for (i = 0; i < len; i++)
+		id[i] = chip->read_byte(mtd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_readid_op);
+
+/**
+ * nand_status_op - Do a STATUS operation
+ * @chip: The NAND chip
+ * @status: out variable to store the NAND status
+ *
+ * This function sends a STATUS command and reads back the status returned by
+ * the NAND.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_status_op(struct nand_chip *chip, u8 *status)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
+	if (status)
+		*status = chip->read_byte(mtd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_status_op);
+
+/**
+ * nand_erase_op - Do an erase operation
+ * @chip: The NAND chip
+ * @eraseblock: block to erase
+ *
+ * This function sends an ERASE command and waits for the NAND to be ready
+ * before returning.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	unsigned int page = eraseblock <<
+			    (chip->phys_erase_shift - chip->page_shift);
+	int status;
+
+	chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
+	chip->cmdfunc(mtd, NAND_CMD_ERASE2, -1, -1);
+
+	status = chip->waitfunc(mtd, chip);
+	if (status < 0)
+		return status;
+
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_erase_op);
+
+/**
+ * nand_set_features_op - Do a SET FEATURES operation
+ * @chip: The NAND chip
+ * @feature: feature id
+ * @data: 4 bytes of data
+ *
+ * This function sends a SET FEATURES command and waits for the NAND to be
+ * ready before returning.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+static int nand_set_features_op(struct nand_chip *chip, u8 feature,
+				const void *data)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const u8 *params = data;
+	int i, status;
+
+	chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
+	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
+		chip->write_byte(mtd, params[i]);
+
+	status = chip->waitfunc(mtd, chip);
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * nand_get_features_op - Do a GET FEATURES operation
+ * @chip: The NAND chip
+ * @feature: feature id
+ * @data: 4 bytes of data
+ *
+ * This function sends a GET FEATURES command and waits for the NAND to be
+ * ready before returning.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+static int nand_get_features_op(struct nand_chip *chip, u8 feature,
+				void *data)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 *params = data;
+	int i;
+
+	chip->cmdfunc(mtd, NAND_CMD_GET_FEATURES, feature, -1);
+	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
+		params[i] = chip->read_byte(mtd);
+
+	return 0;
+}
+
+/**
+ * nand_reset_op - Do a reset operation
+ * @chip: The NAND chip
+ *
+ * This function sends a RESET command and waits for the NAND to be ready
+ * before returning.
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_reset_op(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_reset_op);
+
+/**
+ * nand_read_data_op - Read data from the NAND
+ * @chip: The NAND chip
+ * @buf: buffer used to store the data
+ * @len: length of the buffer
+ * @force_8bit: force 8-bit bus access
+ *
+ * This function does a raw data read on the bus. Usually used after launching
+ * another NAND operation like nand_read_page_op().
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
+		      bool force_8bit)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (!len || !buf)
+		return -EINVAL;
+
+	if (force_8bit) {
+		u8 *p = buf;
+		unsigned int i;
+
+		for (i = 0; i < len; i++)
+			p[i] = chip->read_byte(mtd);
+	} else {
+		chip->read_buf(mtd, buf, len);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_read_data_op);
+
+/**
+ * nand_write_data_op - Write data from the NAND
+ * @chip: The NAND chip
+ * @buf: buffer containing the data to send on the bus
+ * @len: length of the buffer
+ * @force_8bit: force 8-bit bus access
+ *
+ * This function does a raw data write on the bus. Usually used after launching
+ * another NAND operation like nand_write_page_begin_op().
+ * This function does not select/unselect the CS line.
+ *
+ * Returns 0 for success or negative error code otherwise
+ */
+int nand_write_data_op(struct nand_chip *chip, const void *buf,
+		       unsigned int len, bool force_8bit)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (!len || !buf)
+		return -EINVAL;
+
+	if (force_8bit) {
+		const u8 *p = buf;
+		unsigned int i;
+
+		for (i = 0; i < len; i++)
+			chip->write_byte(mtd, p[i]);
+	} else {
+		chip->write_buf(mtd, buf, len);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_write_data_op);
+
+/**
  * nand_reset - Reset and initialize a NAND device
  * @chip: The NAND chip
  * @chipnr: Internal die id
@@ -1233,7 +1750,7 @@ int nand_reset(struct nand_chip *chip, int chipnr)
 	 * interface settings, hence this weird ->select_chip() dance.
 	 */
 	chip->select_chip(mtd, chipnr);
-	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+	nand_reset_op(chip);
 	chip->select_chip(mtd, -1);
 
 	chip->select_chip(mtd, chipnr);
@@ -1389,9 +1906,19 @@ EXPORT_SYMBOL(nand_check_erased_ecc_chunk);
 int nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 		       uint8_t *buf, int oob_required, int page)
 {
-	chip->read_buf(mtd, buf, mtd->writesize);
-	if (oob_required)
-		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	int ret;
+
+	ret = nand_read_data_op(chip, buf, mtd->writesize, false);
+	if (ret)
+		return ret;
+
+	if (oob_required) {
+		ret = nand_read_data_op(chip, chip->oob_poi, mtd->oobsize,
+					false);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(nand_read_page_raw);
@@ -1413,29 +1940,46 @@ static int nand_read_page_raw_syndrome(struct mtd_info *mtd,
 	int eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	uint8_t *oob = chip->oob_poi;
-	int steps, size;
+	int steps, size, ret;
 
 	for (steps = chip->ecc.steps; steps > 0; steps--) {
-		chip->read_buf(mtd, buf, eccsize);
+		ret = nand_read_data_op(chip, buf, eccsize, false);
+		if (ret)
+			return ret;
+
 		buf += eccsize;
 
 		if (chip->ecc.prepad) {
-			chip->read_buf(mtd, oob, chip->ecc.prepad);
+			ret = nand_read_data_op(chip, oob, chip->ecc.prepad,
+						false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.prepad;
 		}
 
-		chip->read_buf(mtd, oob, eccbytes);
+		ret = nand_read_data_op(chip, oob, eccbytes, false);
+		if (ret)
+			return ret;
+
 		oob += eccbytes;
 
 		if (chip->ecc.postpad) {
-			chip->read_buf(mtd, oob, chip->ecc.postpad);
+			ret = nand_read_data_op(chip, oob, chip->ecc.postpad,
+						false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.postpad;
 		}
 	}
 
 	size = mtd->oobsize - (oob - chip->oob_poi);
-	if (size)
-		chip->read_buf(mtd, oob, size);
+	if (size) {
+		ret = nand_read_data_op(chip, oob, size, false);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1524,7 +2068,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, data_col_addr, -1);
 
 	p = bufpoi + data_col_addr;
-	chip->read_buf(mtd, p, datafrag_len);
+	nand_read_data_op(chip, p, datafrag_len, false);
 
 	/* Calculate ECC */
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size)
@@ -1542,8 +2086,11 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		gaps = 1;
 
 	if (gaps) {
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize, -1);
-		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+		ret = nand_change_read_column_op(chip, mtd->writesize,
+						 chip->oob_poi, mtd->oobsize,
+						 false);
+		if (ret)
+			return ret;
 	} else {
 		/*
 		 * Send the command to read the particular ECC bytes take care
@@ -1557,9 +2104,12 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		    (busw - 1))
 			aligned_len++;
 
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
-			      mtd->writesize + aligned_pos, -1);
-		chip->read_buf(mtd, &chip->oob_poi[aligned_pos], aligned_len);
+		ret = nand_change_read_column_op(chip,
+						 mtd->writesize + aligned_pos,
+						 &chip->oob_poi[aligned_pos],
+						 aligned_len, false);
+		if (ret)
+			return ret;
 	}
 
 	ret = mtd_ooblayout_get_eccbytes(mtd, chip->buffers->ecccode,
@@ -1616,10 +2166,17 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		chip->ecc.hwctl(mtd, NAND_ECC_READ);
-		chip->read_buf(mtd, p, eccsize);
+
+		ret = nand_read_data_op(chip, p, eccsize, false);
+		if (ret)
+			return ret;
+
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 	}
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	ret = nand_read_data_op(chip, chip->oob_poi, mtd->oobsize, false);
+	if (ret)
+		return ret;
 
 	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
 					 chip->ecc.total);
@@ -1678,9 +2235,11 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	unsigned int max_bitflips = 0;
 
 	/* Read the OOB area first */
-	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	ret = nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
+	if (ret)
+		return ret;
+
+	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
 					 chip->ecc.total);
@@ -1691,7 +2250,11 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 		int stat;
 
 		chip->ecc.hwctl(mtd, NAND_ECC_READ);
-		chip->read_buf(mtd, p, eccsize);
+
+		ret = nand_read_data_op(chip, p, eccsize, false);
+		if (ret)
+			return ret;
+
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 
 		stat = chip->ecc.correct(mtd, p, &ecc_code[i], NULL);
@@ -1728,7 +2291,7 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 				   uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
+	int ret, i, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	int eccpadbytes = eccbytes + chip->ecc.prepad + chip->ecc.postpad;
@@ -1740,21 +2303,36 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 		int stat;
 
 		chip->ecc.hwctl(mtd, NAND_ECC_READ);
-		chip->read_buf(mtd, p, eccsize);
+
+		ret = nand_read_data_op(chip, p, eccsize, false);
+		if (ret)
+			return ret;
 
 		if (chip->ecc.prepad) {
-			chip->read_buf(mtd, oob, chip->ecc.prepad);
+			ret = nand_read_data_op(chip, oob, chip->ecc.prepad,
+						false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.prepad;
 		}
 
 		chip->ecc.hwctl(mtd, NAND_ECC_READSYN);
-		chip->read_buf(mtd, oob, eccbytes);
+
+		ret = nand_read_data_op(chip, oob, eccbytes, false);
+		if (ret)
+			return ret;
+
 		stat = chip->ecc.correct(mtd, p, oob, NULL);
 
 		oob += eccbytes;
 
 		if (chip->ecc.postpad) {
-			chip->read_buf(mtd, oob, chip->ecc.postpad);
+			ret = nand_read_data_op(chip, oob, chip->ecc.postpad,
+						false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.postpad;
 		}
 
@@ -1778,8 +2356,11 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 
 	/* Calculate remaining oob bytes */
 	i = mtd->oobsize - (oob - chip->oob_poi);
-	if (i)
-		chip->read_buf(mtd, oob, i);
+	if (i) {
+		ret = nand_read_data_op(chip, oob, i, false);
+		if (ret)
+			return ret;
+	}
 
 	return max_bitflips;
 }
@@ -1901,7 +2482,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 
 read_retry:
 			if (nand_standard_page_accessors(&chip->ecc))
-				chip->cmdfunc(mtd, NAND_CMD_READ0, 0x00, page);
+				nand_read_page_op(chip, page, 0, NULL, 0);
 
 			/*
 			 * Now read the page into the buffer.  Absent an error,
@@ -2060,9 +2641,7 @@ static int nand_read(struct mtd_info *mtd, loff_t from, size_t len,
  */
 int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
-	return 0;
+	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 EXPORT_SYMBOL(nand_read_oob_std);
 
@@ -2080,25 +2659,39 @@ int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
 	int eccsize = chip->ecc.size;
 	uint8_t *bufpoi = chip->oob_poi;
-	int i, toread, sndrnd = 0, pos;
+	int i, toread, sndrnd = 0, pos, ret;
 
-	chip->cmdfunc(mtd, NAND_CMD_READ0, chip->ecc.size, page);
+	nand_read_page_op(chip, page, chip->ecc.size, NULL, 0);
 	for (i = 0; i < chip->ecc.steps; i++) {
 		if (sndrnd) {
+			int ret;
+
 			pos = eccsize + i * (eccsize + chunk);
 			if (mtd->writesize > 512)
-				chip->cmdfunc(mtd, NAND_CMD_RNDOUT, pos, -1);
+				ret = nand_change_read_column_op(
+					chip, pos, NULL, 0, false);
 			else
-				chip->cmdfunc(mtd, NAND_CMD_READ0, pos, page);
+				ret = nand_read_page_op(chip, page, pos, NULL,
+							0);
+
+			if (ret)
+				return ret;
 		} else
 			sndrnd = 1;
 		toread = min_t(int, length, chunk);
-		chip->read_buf(mtd, bufpoi, toread);
+
+		ret = nand_read_data_op(chip, bufpoi, toread, false);
+		if (ret)
+			return ret;
+
 		bufpoi += toread;
 		length -= toread;
 	}
-	if (length > 0)
-		chip->read_buf(mtd, bufpoi, length);
+	if (length > 0) {
+		ret = nand_read_data_op(chip, bufpoi, length, false);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -2112,18 +2705,8 @@ EXPORT_SYMBOL(nand_read_oob_syndrome);
  */
 int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page)
 {
-	int status = 0;
-	const uint8_t *buf = chip->oob_poi;
-	int length = mtd->oobsize;
-
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize, page);
-	chip->write_buf(mtd, buf, length);
-	/* Send command to program the OOB data */
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_op(chip, page, mtd->writesize, chip->oob_poi,
+				 mtd->oobsize);
 }
 EXPORT_SYMBOL(nand_write_oob_std);
 
@@ -2139,7 +2722,7 @@ int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
 	int eccsize = chip->ecc.size, length = mtd->oobsize;
-	int i, len, pos, status = 0, sndcmd = 0, steps = chip->ecc.steps;
+	int ret, i, len, pos, sndcmd = 0, steps = chip->ecc.steps;
 	const uint8_t *bufpoi = chip->oob_poi;
 
 	/*
@@ -2153,7 +2736,7 @@ int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 	} else
 		pos = eccsize;
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, pos, page);
+	nand_prog_page_begin_op(chip, page, pos, NULL, 0);
 	for (i = 0; i < steps; i++) {
 		if (sndcmd) {
 			if (mtd->writesize <= 512) {
@@ -2162,28 +2745,39 @@ int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 				len = eccsize;
 				while (len > 0) {
 					int num = min_t(int, len, 4);
-					chip->write_buf(mtd, (uint8_t *)&fill,
-							num);
+
+					ret = nand_write_data_op(chip, &fill,
+								 num, false);
+					if (ret)
+						return ret;
+
 					len -= num;
 				}
 			} else {
 				pos = eccsize + i * (eccsize + chunk);
-				chip->cmdfunc(mtd, NAND_CMD_RNDIN, pos, -1);
+				ret = nand_change_write_column_op(
+					chip, pos, NULL, 0, false);
+				if (ret)
+					return ret;
 			}
 		} else
 			sndcmd = 1;
 		len = min_t(int, length, chunk);
-		chip->write_buf(mtd, bufpoi, len);
+
+		ret = nand_write_data_op(chip, bufpoi, len, false);
+		if (ret)
+			return ret;
+
 		bufpoi += len;
 		length -= len;
 	}
-	if (length > 0)
-		chip->write_buf(mtd, bufpoi, length);
-
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-	status = chip->waitfunc(mtd, chip);
+	if (length > 0) {
+		ret = nand_write_data_op(chip, bufpoi, length, false);
+		if (ret)
+			return ret;
+	}
 
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_end_op(chip);
 }
 EXPORT_SYMBOL(nand_write_oob_syndrome);
 
@@ -2335,9 +2929,18 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 			const uint8_t *buf, int oob_required, int page)
 {
-	chip->write_buf(mtd, buf, mtd->writesize);
-	if (oob_required)
-		chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	int ret;
+
+	ret = nand_write_data_op(chip, buf, mtd->writesize, false);
+	if (ret)
+		return ret;
+
+	if (oob_required) {
+		ret = nand_write_data_op(chip, chip->oob_poi, mtd->oobsize,
+					 false);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -2361,29 +2964,46 @@ static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 	int eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	uint8_t *oob = chip->oob_poi;
-	int steps, size;
+	int steps, size, ret;
 
 	for (steps = chip->ecc.steps; steps > 0; steps--) {
-		chip->write_buf(mtd, buf, eccsize);
+		ret = nand_write_data_op(chip, buf, eccsize, false);
+		if (ret)
+			return ret;
+
 		buf += eccsize;
 
 		if (chip->ecc.prepad) {
-			chip->write_buf(mtd, oob, chip->ecc.prepad);
+			ret = nand_write_data_op(chip, oob, chip->ecc.prepad,
+						 false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.prepad;
 		}
 
-		chip->write_buf(mtd, oob, eccbytes);
+		ret = nand_write_data_op(chip, oob, eccbytes, false);
+		if (ret)
+			return ret;
+
 		oob += eccbytes;
 
 		if (chip->ecc.postpad) {
-			chip->write_buf(mtd, oob, chip->ecc.postpad);
+			ret = nand_write_data_op(chip, oob, chip->ecc.postpad,
+						 false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.postpad;
 		}
 	}
 
 	size = mtd->oobsize - (oob - chip->oob_poi);
-	if (size)
-		chip->write_buf(mtd, oob, size);
+	if (size) {
+		ret = nand_write_data_op(chip, oob, size, false);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -2437,7 +3057,11 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
-		chip->write_buf(mtd, p, eccsize);
+
+		ret = nand_write_data_op(chip, p, eccsize, false);
+		if (ret)
+			return ret;
+
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 	}
 
@@ -2446,7 +3070,9 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	if (ret)
 		return ret;
 
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	ret = nand_write_data_op(chip, chip->oob_poi, mtd->oobsize, false);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -2482,7 +3108,9 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
 
 		/* write data (untouched subpages already masked by 0xFF) */
-		chip->write_buf(mtd, buf, ecc_size);
+		ret = nand_write_data_op(chip, buf, ecc_size, false);
+		if (ret)
+			return ret;
 
 		/* mask ECC of un-touched subpages by padding 0xFF */
 		if ((step < start_step) || (step > end_step))
@@ -2509,7 +3137,9 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 		return ret;
 
 	/* write OOB buffer to NAND device */
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	ret = nand_write_data_op(chip, chip->oob_poi, mtd->oobsize, false);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -2536,31 +3166,49 @@ static int nand_write_page_syndrome(struct mtd_info *mtd,
 	int eccsteps = chip->ecc.steps;
 	const uint8_t *p = buf;
 	uint8_t *oob = chip->oob_poi;
+	int ret;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-
 		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
-		chip->write_buf(mtd, p, eccsize);
+
+		ret = nand_write_data_op(chip, p, eccsize, false);
+		if (ret)
+			return ret;
 
 		if (chip->ecc.prepad) {
-			chip->write_buf(mtd, oob, chip->ecc.prepad);
+			ret = nand_write_data_op(chip, oob, chip->ecc.prepad,
+						 false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.prepad;
 		}
 
 		chip->ecc.calculate(mtd, p, oob);
-		chip->write_buf(mtd, oob, eccbytes);
+
+		ret = nand_write_data_op(chip, oob, eccbytes, false);
+		if (ret)
+			return ret;
+
 		oob += eccbytes;
 
 		if (chip->ecc.postpad) {
-			chip->write_buf(mtd, oob, chip->ecc.postpad);
+			ret = nand_write_data_op(chip, oob, chip->ecc.postpad,
+						 false);
+			if (ret)
+				return ret;
+
 			oob += chip->ecc.postpad;
 		}
 	}
 
 	/* Calculate remaining oob bytes */
 	i = mtd->oobsize - (oob - chip->oob_poi);
-	if (i)
-		chip->write_buf(mtd, oob, i);
+	if (i) {
+		ret = nand_write_data_op(chip, oob, i, false);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -2588,8 +3236,11 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	else
 		subpage = 0;
 
-	if (nand_standard_page_accessors(&chip->ecc))
-		chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
+	if (nand_standard_page_accessors(&chip->ecc)) {
+		status = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+		if (status)
+			return status;
+	}
 
 	if (unlikely(raw))
 		status = chip->ecc.write_page_raw(mtd, chip, buf,
@@ -2604,13 +3255,8 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	if (status < 0)
 		return status;
 
-	if (nand_standard_page_accessors(&chip->ecc)) {
-		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-		status = chip->waitfunc(mtd, chip);
-		if (status & NAND_STATUS_FAIL)
-			return -EIO;
-	}
+	if (nand_standard_page_accessors(&chip->ecc))
+		return nand_prog_page_end_op(chip);
 
 	return 0;
 }
@@ -2981,11 +3627,12 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 static int single_erase(struct mtd_info *mtd, int page)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	unsigned int eraseblock;
+
 	/* Send commands to erase a block */
-	chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
-	chip->cmdfunc(mtd, NAND_CMD_ERASE2, -1, -1);
+	eraseblock = page >> (chip->phys_erase_shift - chip->page_shift);
 
-	return chip->waitfunc(mtd, chip);
+	return nand_erase_op(chip, eraseblock);
 }
 
 /**
@@ -3069,7 +3716,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 		status = chip->erase(mtd, page & chip->pagemask);
 
 		/* See if block erase succeeded */
-		if (status & NAND_STATUS_FAIL) {
+		if (status) {
 			pr_debug("%s: failed erase, page 0x%08x\n",
 					__func__, page);
 			instr->state = MTD_ERASE_FAILED;
@@ -3212,22 +3859,12 @@ static int nand_max_bad_blocks(struct mtd_info *mtd, loff_t ofs, size_t len)
 static int nand_onfi_set_features(struct mtd_info *mtd, struct nand_chip *chip,
 			int addr, uint8_t *subfeature_param)
 {
-	int status;
-	int i;
-
 	if (!chip->onfi_version ||
 	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
 	      & ONFI_OPT_CMD_SET_GET_FEATURES))
 		return -EINVAL;
 
-	chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, addr, -1);
-	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		chip->write_byte(mtd, subfeature_param[i]);
-
-	status = chip->waitfunc(mtd, chip);
-	if (status & NAND_STATUS_FAIL)
-		return -EIO;
-	return 0;
+	return nand_set_features_op(chip, addr, subfeature_param);
 }
 
 /**
@@ -3240,17 +3877,12 @@ static int nand_onfi_set_features(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_onfi_get_features(struct mtd_info *mtd, struct nand_chip *chip,
 			int addr, uint8_t *subfeature_param)
 {
-	int i;
-
 	if (!chip->onfi_version ||
 	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
 	      & ONFI_OPT_CMD_SET_GET_FEATURES))
 		return -EINVAL;
 
-	chip->cmdfunc(mtd, NAND_CMD_GET_FEATURES, addr, -1);
-	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		*subfeature_param++ = chip->read_byte(mtd);
-	return 0;
+	return nand_get_features_op(chip, addr, subfeature_param);
 }
 
 /**
@@ -3393,12 +4025,11 @@ static u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
 static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 					    struct nand_onfi_params *p)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct onfi_ext_param_page *ep;
 	struct onfi_ext_section *s;
 	struct onfi_ext_ecc_info *ecc;
 	uint8_t *cursor;
-	int ret = -EINVAL;
+	int ret;
 	int len;
 	int i;
 
@@ -3408,14 +4039,18 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 		return -ENOMEM;
 
 	/* Send our own NAND_CMD_PARAM. */
-	chip->cmdfunc(mtd, NAND_CMD_PARAM, 0, -1);
+	ret = nand_read_param_page_op(chip, 0, NULL, 0);
+	if (ret)
+		return ret;
 
 	/* Use the Change Read Column command to skip the ONFI param pages. */
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
-			sizeof(*p) * p->num_of_param_pages , -1);
+	ret = nand_change_read_column_op(chip,
+					 sizeof(*p) * p->num_of_param_pages,
+					 ep, len, true);
+	if (ret)
+		return ret;
 
-	/* Read out the Extended Parameter Page. */
-	chip->read_buf(mtd, (uint8_t *)ep, len);
+	ret = -EINVAL;
 	if ((onfi_crc16(ONFI_CRC_BASE, ((uint8_t *)ep) + 2, len - 2)
 		!= le16_to_cpu(ep->crc))) {
 		pr_debug("fail in the CRC.\n");
@@ -3468,19 +4103,23 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_onfi_params *p = &chip->onfi_params;
-	int i, j;
-	int val;
+	char id[4];
+	int i, ret, val;
 
 	/* Try ONFI for unknown chip or LP */
-	chip->cmdfunc(mtd, NAND_CMD_READID, 0x20, -1);
-	if (chip->read_byte(mtd) != 'O' || chip->read_byte(mtd) != 'N' ||
-		chip->read_byte(mtd) != 'F' || chip->read_byte(mtd) != 'I')
+	nand_readid_op(chip, 0x20, id, sizeof(id));
+	if (strncmp(id, "ONFI", 4))
 		return 0;
 
-	chip->cmdfunc(mtd, NAND_CMD_PARAM, 0, -1);
+	ret = nand_read_param_page_op(chip, 0, NULL, 0);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < 3; i++) {
-		for (j = 0; j < sizeof(*p); j++)
-			((uint8_t *)p)[j] = chip->read_byte(mtd);
+		ret = nand_read_data_op(chip, p, sizeof(*p), true);
+		if (ret)
+			return ret;
+
 		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==
 				le16_to_cpu(p->crc)) {
 			break;
@@ -3571,20 +4210,22 @@ static int nand_flash_detect_jedec(struct nand_chip *chip)
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_jedec_params *p = &chip->jedec_params;
 	struct jedec_ecc_info *ecc;
-	int val;
-	int i, j;
+	char id[5];
+	int i, val, ret;
 
 	/* Try JEDEC for unknown chip or LP */
-	chip->cmdfunc(mtd, NAND_CMD_READID, 0x40, -1);
-	if (chip->read_byte(mtd) != 'J' || chip->read_byte(mtd) != 'E' ||
-		chip->read_byte(mtd) != 'D' || chip->read_byte(mtd) != 'E' ||
-		chip->read_byte(mtd) != 'C')
+	nand_readid_op(chip, 0x40, id, sizeof(id));
+	if (strncmp(id, "JEDEC", sizeof(id)))
 		return 0;
 
-	chip->cmdfunc(mtd, NAND_CMD_PARAM, 0x40, -1);
+	ret = nand_read_param_page_op(chip, 0x40, NULL, 0);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < 3; i++) {
-		for (j = 0; j < sizeof(*p); j++)
-			((uint8_t *)p)[j] = chip->read_byte(mtd);
+		ret = nand_read_data_op(chip, p, sizeof(*p), true);
+		if (ret)
+			return ret;
 
 		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 510) ==
 				le16_to_cpu(p->crc))
@@ -3864,7 +4505,6 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 	const struct nand_manufacturer *manufacturer;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int busw;
-	int i;
 	u8 *id_data = chip->id.data;
 	u8 maf_id, dev_id;
 
@@ -3878,11 +4518,11 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 	chip->select_chip(mtd, 0);
 
 	/* Send the command for reading device ID */
-	chip->cmdfunc(mtd, NAND_CMD_READID, 0x00, -1);
+	nand_readid_op(chip, 0, id_data, 2);
 
 	/* Read manufacturer and device IDs */
-	maf_id = chip->read_byte(mtd);
-	dev_id = chip->read_byte(mtd);
+	maf_id = id_data[0];
+	dev_id = id_data[1];
 
 	/*
 	 * Try again to make sure, as some systems the bus-hold or other
@@ -3891,11 +4531,8 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 	 * not match, ignore the device completely.
 	 */
 
-	chip->cmdfunc(mtd, NAND_CMD_READID, 0x00, -1);
-
 	/* Read entire ID string */
-	for (i = 0; i < ARRAY_SIZE(chip->id.data); i++)
-		id_data[i] = chip->read_byte(mtd);
+	nand_readid_op(chip, 0, id_data, sizeof(chip->id.data));
 
 	if (id_data[0] != maf_id || id_data[1] != dev_id) {
 		pr_info("second ID read did not match %02x,%02x against %02x,%02x\n",
@@ -4222,15 +4859,16 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 
 	/* Check for a chip array */
 	for (i = 1; i < maxchips; i++) {
+		u8 id[2];
+
 		/* See comment in nand_get_flash_type for reset */
 		nand_reset(chip, i);
 
 		chip->select_chip(mtd, i);
 		/* Send the command for reading device ID */
-		chip->cmdfunc(mtd, NAND_CMD_READID, 0x00, -1);
+		nand_readid_op(chip, 0, id, sizeof(id));
 		/* Read manufacturer and device IDs */
-		if (nand_maf_id != chip->read_byte(mtd) ||
-		    nand_dev_id != chip->read_byte(mtd)) {
+		if (nand_maf_id != id[0] || nand_dev_id != id[1]) {
 			chip->select_chip(mtd, -1);
 			break;
 		}
diff --git a/drivers/mtd/nand/nand_hynix.c b/drivers/mtd/nand/nand_hynix.c
index 985751eda317..04e3ab7a476c 100644
--- a/drivers/mtd/nand/nand_hynix.c
+++ b/drivers/mtd/nand/nand_hynix.c
@@ -67,15 +67,11 @@ struct hynix_read_retry_otp {
 
 static bool hynix_nand_has_valid_jedecid(struct nand_chip *chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	u8 jedecid[6] = { };
-	int i = 0;
+	u8 jedecid[5] = { };
 
-	chip->cmdfunc(mtd, NAND_CMD_READID, 0x40, -1);
-	for (i = 0; i < 5; i++)
-		jedecid[i] = chip->read_byte(mtd);
+	nand_readid_op(chip, 0x40, jedecid, sizeof(jedecid));
 
-	return !strcmp("JEDEC", jedecid);
+	return !strncmp("JEDEC", jedecid, sizeof(jedecid));
 }
 
 static int hynix_nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
@@ -175,7 +171,7 @@ static int hynix_read_rr_otp(struct nand_chip *chip,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i;
 
-	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+	nand_reset_op(chip);
 
 	chip->cmdfunc(mtd, NAND_HYNIX_CMD_SET_PARAMS, -1, -1);
 
@@ -195,11 +191,10 @@ static int hynix_read_rr_otp(struct nand_chip *chip,
 	chip->cmdfunc(mtd, 0x19, -1, -1);
 
 	/* Now read the page */
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0x0, info->page);
-	chip->read_buf(mtd, buf, info->size);
+	nand_read_page_op(chip, info->page, 0, buf, info->size);
 
 	/* Put everything back to normal */
-	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+	nand_reset_op(chip);
 	chip->cmdfunc(mtd, NAND_HYNIX_CMD_SET_PARAMS, 0x38, -1);
 	chip->write_byte(mtd, 0x0);
 	chip->cmdfunc(mtd, NAND_HYNIX_CMD_APPLY_PARAMS, -1, -1);
diff --git a/drivers/mtd/nand/nand_micron.c b/drivers/mtd/nand/nand_micron.c
index abf6a3c376e8..3934539a7468 100644
--- a/drivers/mtd/nand/nand_micron.c
+++ b/drivers/mtd/nand/nand_micron.c
@@ -137,8 +137,6 @@ micron_nand_read_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
 	else if (status & NAND_STATUS_WRITE_RECOMMENDED)
 		max_bitflips = chip->ecc.strength;
 
-	chip->cmdfunc(mtd, NAND_CMD_READ0, -1, -1);
-
 	nand_read_page_raw(mtd, chip, buf, oob_required, page);
 
 	micron_nand_on_die_ecc_setup(chip, false);
@@ -155,10 +153,7 @@ micron_nand_write_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 	micron_nand_on_die_ecc_setup(chip, true);
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
-	nand_write_page_raw(mtd, chip, buf, oob_required, page);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-	status = chip->waitfunc(mtd, chip);
+	status = nand_write_page_raw(mtd, chip, buf, oob_required, page);
 
 	micron_nand_on_die_ecc_setup(chip, false);
 
@@ -171,7 +166,6 @@ micron_nand_read_page_raw_on_die_ecc(struct mtd_info *mtd,
 				     uint8_t *buf, int oob_required,
 				     int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0x00, page);
 	nand_read_page_raw(mtd, chip, buf, oob_required, page);
 
 	return 0;
@@ -183,14 +177,7 @@ micron_nand_write_page_raw_on_die_ecc(struct mtd_info *mtd,
 				      const uint8_t *buf, int oob_required,
 				      int page)
 {
-	int status;
-
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
-	nand_write_page_raw(mtd, chip, buf, oob_required, page);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-	status = chip->waitfunc(mtd, chip);
-
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_write_page_raw(mtd, chip, buf, oob_required, page);
 }
 
 enum {
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 54540c8fa1a2..41e124777579 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1538,10 +1538,10 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, buf, mtd->writesize);
 
 	/* Read oob bytes */
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
-		      mtd->writesize + BADBLOCK_MARKER_LENGTH, -1);
-	chip->read_buf(mtd, chip->oob_poi + BADBLOCK_MARKER_LENGTH,
-		       chip->ecc.total);
+	nand_change_read_column_op(chip,
+				   mtd->writesize + BADBLOCK_MARKER_LENGTH,
+				   chip->oob_poi + BADBLOCK_MARKER_LENGTH,
+				   chip->ecc.total, false);
 
 	/* Calculate ecc bytes */
 	chip->ecc.calculate(mtd, buf, ecc_calc);
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 90b9a9ccbe60..28bcdf64c1fc 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -520,15 +520,13 @@ static int pxa3xx_nand_init_timings_compat(struct pxa3xx_nand_host *host,
 	struct nand_chip *chip = &host->chip;
 	struct pxa3xx_nand_info *info = host->info_data;
 	const struct pxa3xx_nand_flash *f = NULL;
-	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	int i, id, ntypes;
+	u8 idbuf[2];
 
 	ntypes = ARRAY_SIZE(builtin_flash_types);
 
-	chip->cmdfunc(mtd, NAND_CMD_READID, 0x00, -1);
-
-	id = chip->read_byte(mtd);
-	id |= chip->read_byte(mtd) << 0x8;
+	nand_readid_op(chip, 0, idbuf, sizeof(idbuf));
+	id = idbuf[0] | (idbuf[1] << 8);
 
 	for (i = 0; i < ntypes; i++) {
 		f = &builtin_flash_types[i];
diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index 2656c1ac5646..e34313ecd903 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -1990,7 +1990,7 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *oob = chip->oob_poi;
 	int data_size, oob_size;
-	int ret, status = 0;
+	int ret;
 
 	host->use_ecc = true;
 
@@ -2027,11 +2027,7 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 		return -EIO;
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
@@ -2081,7 +2077,7 @@ static int qcom_nandc_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int page, ret, status = 0;
+	int page, ret;
 
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
@@ -2114,11 +2110,7 @@ static int qcom_nandc_block_markbad(struct mtd_info *mtd, loff_t ofs)
 		return -EIO;
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_end_op(chip);
 }
 
 /*
diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
index fc9287af4614..595635b9e9de 100644
--- a/drivers/mtd/nand/r852.c
+++ b/drivers/mtd/nand/r852.c
@@ -364,7 +364,7 @@ static int r852_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	struct r852_device *dev = nand_get_controller_data(chip);
 
 	unsigned long timeout;
-	int status;
+	u8 status;
 
 	timeout = jiffies + (chip->state == FL_ERASING ?
 		msecs_to_jiffies(400) : msecs_to_jiffies(20));
@@ -373,8 +373,7 @@ static int r852_wait(struct mtd_info *mtd, struct nand_chip *chip)
 		if (chip->dev_ready(mtd))
 			break;
 
-	chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
-	status = (int)chip->read_byte(mtd);
+	nand_status_op(chip, &status);
 
 	/* Unfortunelly, no way to send detailed error status... */
 	if (dev->dma_error) {
@@ -522,9 +521,7 @@ static int r852_ecc_correct(struct mtd_info *mtd, uint8_t *dat,
 static int r852_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 			     int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
-	return 0;
+	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 
 /*
@@ -1046,7 +1043,7 @@ static int r852_resume(struct device *device)
 	if (dev->card_registred) {
 		r852_engine_enable(dev);
 		dev->chip->select_chip(mtd, 0);
-		dev->chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
+		nand_reset_op(dev->chip);
 		dev->chip->select_chip(mtd, -1);
 	}
 
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 82244be3e766..230d037d05d2 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -958,12 +958,12 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	int ret;
 
 	if (*cur_off != data_off)
-		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
+		nand_change_read_column_op(nand, data_off, NULL, 0, false);
 
 	sunxi_nfc_randomizer_read_buf(mtd, NULL, ecc->size, false, page);
 
 	if (data_off + ecc->size != oob_off)
-		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+		nand_change_read_column_op(nand, oob_off, NULL, 0, false);
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -991,16 +991,15 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		 * Re-read the data with the randomizer disabled to identify
 		 * bitflips in erased pages.
 		 */
-		if (nand->options & NAND_NEED_SCRAMBLING) {
-			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
-			nand->read_buf(mtd, data, ecc->size);
-		} else {
+		if (nand->options & NAND_NEED_SCRAMBLING)
+			nand_change_read_column_op(nand, data_off, data,
+						   ecc->size, false);
+		else
 			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE,
 				      ecc->size);
-		}
 
-		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-		nand->read_buf(mtd, oob, ecc->bytes + 4);
+		nand_change_read_column_op(nand, oob_off, oob, ecc->bytes + 4,
+					   false);
 
 		ret = nand_check_erased_ecc_chunk(data,	ecc->size,
 						  oob, ecc->bytes + 4,
@@ -1011,7 +1010,8 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
 		if (oob_required) {
-			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+			nand_change_read_column_op(nand, oob_off, NULL, 0,
+						   false);
 			sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4,
 						      true, page);
 
@@ -1038,8 +1038,8 @@ static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
 		return;
 
 	if (!cur_off || *cur_off != offset)
-		nand->cmdfunc(mtd, NAND_CMD_RNDOUT,
-			      offset + mtd->writesize, -1);
+		nand_change_read_column_op(nand, mtd->writesize, NULL, 0,
+					   false);
 
 	if (!randomize)
 		sunxi_nfc_read_buf(mtd, oob + offset, len);
@@ -1116,9 +1116,9 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct mtd_info *mtd, uint8_t *buf,
 
 		if (oob_required && !erased) {
 			/* TODO: use DMA to retrieve OOB */
-			nand->cmdfunc(mtd, NAND_CMD_RNDOUT,
-				      mtd->writesize + oob_off, -1);
-			nand->read_buf(mtd, oob, ecc->bytes + 4);
+			nand_change_read_column_op(nand,
+						   mtd->writesize + oob_off,
+						   oob, ecc->bytes + 4, false);
 
 			sunxi_nfc_hw_ecc_get_prot_oob_bytes(mtd, oob, i,
 							    !i, page);
@@ -1143,18 +1143,17 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct mtd_info *mtd, uint8_t *buf,
 			/*
 			 * Re-read the data with the randomizer disabled to
 			 * identify bitflips in erased pages.
+			 * TODO: use DMA to read page in raw mode
 			 */
-			if (randomized) {
-				/* TODO: use DMA to read page in raw mode */
-				nand->cmdfunc(mtd, NAND_CMD_RNDOUT,
-					      data_off, -1);
-				nand->read_buf(mtd, data, ecc->size);
-			}
+			if (randomized)
+				nand_change_read_column_op(nand, data_off,
+							   data, ecc->size
+							   false);
 
 			/* TODO: use DMA to retrieve OOB */
-			nand->cmdfunc(mtd, NAND_CMD_RNDOUT,
-				      mtd->writesize + oob_off, -1);
-			nand->read_buf(mtd, oob, ecc->bytes + 4);
+			nand_change_read_column_op(nand,
+						   mtd->writesize + oob_off,
+						   oob, ecc->bytes + 4, false);
 
 			ret = nand_check_erased_ecc_chunk(data,	ecc->size,
 							  oob, ecc->bytes + 4,
@@ -1187,12 +1186,12 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	int ret;
 
 	if (data_off != *cur_off)
-		nand->cmdfunc(mtd, NAND_CMD_RNDIN, data_off, -1);
+		nand_change_write_column_op(nand, data_off, NULL, 0, false);
 
 	sunxi_nfc_randomizer_write_buf(mtd, data, ecc->size, false, page);
 
 	if (data_off + ecc->size != oob_off)
-		nand->cmdfunc(mtd, NAND_CMD_RNDIN, oob_off, -1);
+		nand_change_write_column_op(nand, oob_off, NULL, 0, false);
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -1228,8 +1227,8 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
 		return;
 
 	if (!cur_off || *cur_off != offset)
-		nand->cmdfunc(mtd, NAND_CMD_RNDIN,
-			      offset + mtd->writesize, -1);
+		nand_change_write_column_op(nand, offset + mtd->writesize,
+					    NULL, 0, false);
 
 	sunxi_nfc_randomizer_write_buf(mtd, oob + offset, len, false, page);
 
@@ -1540,7 +1539,7 @@ static int sunxi_nfc_hw_common_ecc_read_oob(struct mtd_info *mtd,
 					    struct nand_chip *chip,
 					    int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	chip->pagebuf = -1;
 
@@ -1551,9 +1550,9 @@ static int sunxi_nfc_hw_common_ecc_write_oob(struct mtd_info *mtd,
 					     struct nand_chip *chip,
 					     int page)
 {
-	int ret, status;
+	int ret;
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0, page);
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
 	chip->pagebuf = -1;
 
@@ -1563,11 +1562,7 @@ static int sunxi_nfc_hw_common_ecc_write_oob(struct mtd_info *mtd,
 		return ret;
 
 	/* Send command to program the OOB data */
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-
-	return status & NAND_STATUS_FAIL ? -EIO : 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static const s32 tWB_lut[] = {6, 12, 16, 20};
diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index 766906f03943..97a300b46b1d 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -329,7 +329,7 @@ static void aux_read(struct nand_chip *chip, u8 **buf, int len, int *pos)
 
 	if (!*buf) {
 		/* skip over "len" bytes */
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, *pos, -1);
+		nand_change_read_column_op(chip, *pos, NULL, 0, false);
 	} else {
 		tango_read_buf(mtd, *buf, len);
 		*buf += len;
@@ -344,7 +344,7 @@ static void aux_write(struct nand_chip *chip, const u8 **buf, int len, int *pos)
 
 	if (!*buf) {
 		/* skip over "len" bytes */
-		chip->cmdfunc(mtd, NAND_CMD_RNDIN, *pos, -1);
+		nand_change_write_column_op(chip, *pos, NULL, 0, false);
 	} else {
 		tango_write_buf(mtd, *buf, len);
 		*buf += len;
@@ -427,7 +427,7 @@ static void raw_write(struct nand_chip *chip, const u8 *buf, const u8 *oob)
 static int tango_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 			       u8 *buf, int oob_required, int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 	raw_read(chip, buf, chip->oob_poi);
 	return 0;
 }
@@ -435,23 +435,15 @@ static int tango_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 static int tango_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				const u8 *buf, int oob_required, int page)
 {
-	int status;
-
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0, page);
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	raw_write(chip, buf, chip->oob_poi);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-
-	status = chip->waitfunc(mtd, chip);
-	if (status & NAND_STATUS_FAIL)
-		return -EIO;
-
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int tango_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 			  int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	nand_read_page_op(chip, page, 0, NULL, 0);
 	raw_read(chip, NULL, chip->oob_poi);
 	return 0;
 }
@@ -459,11 +451,9 @@ static int tango_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 static int tango_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 			   int page)
 {
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0, page);
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	raw_write(chip, NULL, chip->oob_poi);
-	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
-	chip->waitfunc(mtd, chip);
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int oob_ecc(struct mtd_info *mtd, int idx, struct mtd_oob_region *res)
diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index 84dbf32332e1..ae3583b092fb 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -192,6 +192,7 @@ tmio_nand_wait(struct mtd_info *mtd, struct nand_chip *nand_chip)
 {
 	struct tmio_nand *tmio = mtd_to_tmio(mtd);
 	long timeout;
+	u8 status;
 
 	/* enable RDYREQ interrupt */
 	tmio_iowrite8(0x0f, tmio->fcr + FCR_ISR);
@@ -212,8 +213,8 @@ tmio_nand_wait(struct mtd_info *mtd, struct nand_chip *nand_chip)
 		dev_warn(&tmio->dev->dev, "timeout waiting for interrupt\n");
 	}
 
-	nand_chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
-	return nand_chip->read_byte(mtd);
+	nand_status_op(chip, &status)
+	return status;
 }
 
 /*
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 749bb08c4772..8b8acde72465 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1316,6 +1316,31 @@ int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 /* Reset and initialize a NAND device */
 int nand_reset(struct nand_chip *chip, int chipnr);
 
+/* NAND operation helpers */
+int nand_reset_op(struct nand_chip *chip);
+int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
+		   unsigned int len);
+int nand_status_op(struct nand_chip *chip, u8 *status);
+int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock);
+int nand_read_page_op(struct nand_chip *chip, unsigned int page,
+		      unsigned int column, void *buf, unsigned int len);
+int nand_change_read_column_op(struct nand_chip *chip, unsigned int column,
+			       void *buf, unsigned int len, bool force_8bit);
+int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
+		     unsigned int column, void *buf, unsigned int len);
+int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
+			    unsigned int column, const void *buf,
+			    unsigned int len);
+int nand_prog_page_end_op(struct nand_chip *chip);
+int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
+		      unsigned int column, const void *buf, unsigned int len);
+int nand_change_write_column_op(struct nand_chip *chip, unsigned int column,
+				const void *buf, unsigned int len, bool force_8bit);
+int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
+		      bool force_8bits);
+int nand_write_data_op(struct nand_chip *chip, const void *buf,
+		       unsigned int len, bool force_8bits);
+
 /* Free resources held by the NAND device */
 void nand_cleanup(struct nand_chip *chip);
 
-- 
2.11.0
