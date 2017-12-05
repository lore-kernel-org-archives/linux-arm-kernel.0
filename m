From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  5 Dec 2017 17:47:16 +0900
Subject: [PATCH v2 3/3] mtd: nand: squash struct nand_buffers into struct
 nand_chip
In-Reply-To: <1512463636-28934-1-git-send-email-yamada.masahiro@socionext.com>
References: <1512463636-28934-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1512463636-28934-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_buffers is malloc'ed in nand_scan_tail() just for
containing three pointers.  Squash this struct into nand_chip.

Move and rename as follows:

  chip->buffers->ecccalc   ->  chip->ecc.calc_buf
  chip->buffers->ecccode   ->  chip->ecc.code_buf
  chip->buffers->databuf   ->  chip->data_buf

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rename as Boris suggested
  - Based on cafe_nand rework

 drivers/mtd/nand/brcmnand/brcmnand.c   |  2 +-
 drivers/mtd/nand/denali.c              |  2 +-
 drivers/mtd/nand/fsmc_nand.c           |  4 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |  4 +-
 drivers/mtd/nand/nand_base.c           | 91 ++++++++++++++--------------------
 drivers/mtd/nand/nand_bbt.c            |  2 +-
 drivers/mtd/nand/omap2.c               | 10 ++--
 drivers/mtd/nand/sunxi_nand.c          |  6 +--
 include/linux/mtd/rawnand.h            | 23 +++------
 9 files changed, 59 insertions(+), 85 deletions(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index e0eb51d..cc13c88 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1681,7 +1681,7 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	int ret;
 
 	if (!buf) {
-		buf = chip->buffers->databuf;
+		buf = chip->data_buf;
 		/* Invalidate page cache */
 		chip->pagebuf = -1;
 	}
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 2fc964b..3e61ac4 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -328,7 +328,7 @@ static int denali_check_erased_page(struct mtd_info *mtd,
 				    unsigned long uncor_ecc_flags,
 				    unsigned int max_bitflips)
 {
-	uint8_t *ecc_code = chip->buffers->ecccode;
+	uint8_t *ecc_code = chip->ecc.code_buf;
 	int ecc_steps = chip->ecc.steps;
 	int ecc_size = chip->ecc.size;
 	int ecc_bytes = chip->ecc.bytes;
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index eac15d9..574b043 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -684,8 +684,8 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint8_t *ecc_code = chip->buffers->ecccode;
+	uint8_t *ecc_calc = chip->ecc.calc_buf;
+	uint8_t *ecc_code = chip->ecc.code_buf;
 	int off, len, group = 0;
 	/*
 	 * ecc_oob is intentionally taken as uint16_t. In 16bit devices, we
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 50f8d4a..a760ae7 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1712,7 +1712,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 	unsigned int search_area_size_in_strides;
 	unsigned int stride;
 	unsigned int page;
-	uint8_t *buffer = chip->buffers->databuf;
+	uint8_t *buffer = chip->data_buf;
 	int saved_chip_number;
 	int found_an_ncb_fingerprint = false;
 
@@ -1771,7 +1771,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 	unsigned int block;
 	unsigned int stride;
 	unsigned int page;
-	uint8_t      *buffer = chip->buffers->databuf;
+	uint8_t      *buffer = chip->data_buf;
 	int saved_chip_number;
 	int status;
 
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 0cc61b1..fe583e4 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1456,8 +1456,8 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint8_t *ecc_code = chip->buffers->ecccode;
+	uint8_t *ecc_calc = chip->ecc.calc_buf;
+	uint8_t *ecc_code = chip->ecc.code_buf;
 	unsigned int max_bitflips = 0;
 
 	chip->ecc.read_page_raw(mtd, chip, buf, 1, page);
@@ -1529,7 +1529,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 
 	/* Calculate ECC */
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size)
-		chip->ecc.calculate(mtd, p, &chip->buffers->ecccalc[i]);
+		chip->ecc.calculate(mtd, p, &chip->ecc.calc_buf[i]);
 
 	/*
 	 * The performance is faster if we position offsets according to
@@ -1563,7 +1563,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->read_buf(mtd, &chip->oob_poi[aligned_pos], aligned_len);
 	}
 
-	ret = mtd_ooblayout_get_eccbytes(mtd, chip->buffers->ecccode,
+	ret = mtd_ooblayout_get_eccbytes(mtd, chip->ecc.code_buf,
 					 chip->oob_poi, index, eccfrag_len);
 	if (ret)
 		return ret;
@@ -1572,13 +1572,13 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size) {
 		int stat;
 
-		stat = chip->ecc.correct(mtd, p,
-			&chip->buffers->ecccode[i], &chip->buffers->ecccalc[i]);
+		stat = chip->ecc.correct(mtd, p, &chip->ecc.code_buf[i],
+					 &chip->ecc.calc_buf[i]);
 		if (stat == -EBADMSG &&
 		    (chip->ecc.options & NAND_ECC_GENERIC_ERASED_CHECK)) {
 			/* check for empty pages with bitflips */
 			stat = nand_check_erased_ecc_chunk(p, chip->ecc.size,
-						&chip->buffers->ecccode[i],
+						&chip->ecc.code_buf[i],
 						chip->ecc.bytes,
 						NULL, 0,
 						chip->ecc.strength);
@@ -1611,8 +1611,8 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint8_t *ecc_code = chip->buffers->ecccode;
+	uint8_t *ecc_calc = chip->ecc.calc_buf;
+	uint8_t *ecc_code = chip->ecc.code_buf;
 	unsigned int max_bitflips = 0;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
@@ -1674,8 +1674,8 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
-	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
+	uint8_t *ecc_code = chip->ecc.code_buf;
+	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	unsigned int max_bitflips = 0;
 
 	/* Read the OOB area first */
@@ -1894,7 +1894,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 
 		/* Is the current page in the buffer? */
 		if (realpage != chip->pagebuf || oob) {
-			bufpoi = use_bufpoi ? chip->buffers->databuf : buf;
+			bufpoi = use_bufpoi ? chip->data_buf : buf;
 
 			if (use_bufpoi && aligned)
 				pr_debug("%s: using read bounce buffer for buf@%p\n",
@@ -1938,7 +1938,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 					/* Invalidate page cache */
 					chip->pagebuf = -1;
 				}
-				memcpy(buf, chip->buffers->databuf + col, bytes);
+				memcpy(buf, chip->data_buf + col, bytes);
 			}
 
 			if (unlikely(oob)) {
@@ -1979,7 +1979,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 			buf += bytes;
 			max_bitflips = max_t(unsigned int, max_bitflips, ret);
 		} else {
-			memcpy(buf, chip->buffers->databuf + col, bytes);
+			memcpy(buf, chip->data_buf + col, bytes);
 			buf += bytes;
 			max_bitflips = max_t(unsigned int, max_bitflips,
 					     chip->pagebuf_bitflips);
@@ -2403,7 +2403,7 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
+	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	const uint8_t *p = buf;
 
 	/* Software ECC calculation */
@@ -2433,7 +2433,7 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
+	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	const uint8_t *p = buf;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
@@ -2469,7 +2469,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 				int oob_required, int page)
 {
 	uint8_t *oob_buf  = chip->oob_poi;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
+	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	int ecc_size      = chip->ecc.size;
 	int ecc_bytes     = chip->ecc.bytes;
 	int ecc_steps     = chip->ecc.steps;
@@ -2503,7 +2503,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 
 	/* copy calculated ECC for whole page to chip->buffer->oob */
 	/* this include masked-value(0xFF) for unwritten subpages */
-	ecc_calc = chip->buffers->ecccalc;
+	ecc_calc = chip->ecc.calc_buf;
 	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
 					 chip->ecc.total);
 	if (ret)
@@ -2737,9 +2737,9 @@ static int nand_do_write_ops(struct mtd_info *mtd, loff_t to,
 			if (part_pagewr)
 				bytes = min_t(int, bytes - column, writelen);
 			chip->pagebuf = -1;
-			memset(chip->buffers->databuf, 0xff, mtd->writesize);
-			memcpy(&chip->buffers->databuf[column], buf, bytes);
-			wbuf = chip->buffers->databuf;
+			memset(chip->data_buf, 0xff, mtd->writesize);
+			memcpy(&chip->data_buf[column], buf, bytes);
+			wbuf = chip->data_buf;
 		}
 
 		if (unlikely(oob)) {
@@ -4632,7 +4632,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct nand_buffers *nbuf = NULL;
 	int ret, i;
 
 	/* New bad blocks should be marked in OOB, flash-based BBT, or both */
@@ -4646,30 +4645,22 @@ int nand_scan_tail(struct mtd_info *mtd)
 		return -EINVAL;
 	}
 
-	nbuf = kzalloc(sizeof(*nbuf), GFP_KERNEL);
-	if (!nbuf)
+	ecc->calc_buf = kmalloc(mtd->oobsize, GFP_KERNEL);
+	if (!ecc->calc_buf)
 		return -ENOMEM;
 
-	nbuf->ecccalc = kmalloc(mtd->oobsize, GFP_KERNEL);
-	if (!nbuf->ecccalc) {
+	ecc->code_buf = kmalloc(mtd->oobsize, GFP_KERNEL);
+	if (!ecc->code_buf) {
 		ret = -ENOMEM;
-		goto err_free_nbuf;
+		goto err_free_buf;
 	}
 
-	nbuf->ecccode = kmalloc(mtd->oobsize, GFP_KERNEL);
-	if (!nbuf->ecccode) {
+	chip->data_buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
+	if (!chip->data_buf) {
 		ret = -ENOMEM;
-		goto err_free_nbuf;
+		goto err_free_buf;
 	}
 
-	nbuf->databuf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
-	if (!nbuf->databuf) {
-		ret = -ENOMEM;
-		goto err_free_nbuf;
-	}
-
-	chip->buffers = nbuf;
-
 	/*
 	 * FIXME: some NAND manufacturer drivers expect the first die to be
 	 * selected when manufacturer->init() is called. They should be fixed
@@ -4680,10 +4671,10 @@ int nand_scan_tail(struct mtd_info *mtd)
 	ret = nand_manufacturer_init(chip);
 	chip->select_chip(mtd, -1);
 	if (ret)
-		goto err_free_nbuf;
+		goto err_free_buf;
 
 	/* Set the internal oob buffer location, just after the page data */
-	chip->oob_poi = chip->buffers->databuf + mtd->writesize;
+	chip->oob_poi = chip->data_buf + mtd->writesize;
 
 	/*
 	 * If no default placement scheme is given, select an appropriate one.
@@ -4969,13 +4960,10 @@ int nand_scan_tail(struct mtd_info *mtd)
 err_nand_manuf_cleanup:
 	nand_manufacturer_cleanup(chip);
 
-err_free_nbuf:
-	if (nbuf) {
-		kfree(nbuf->databuf);
-		kfree(nbuf->ecccode);
-		kfree(nbuf->ecccalc);
-		kfree(nbuf);
-	}
+err_free_buf:
+	kfree(chip->data_buf);
+	kfree(ecc->code_buf);
+	kfree(ecc->calc_buf);
 
 	return ret;
 }
@@ -5027,12 +5015,9 @@ void nand_cleanup(struct nand_chip *chip)
 
 	/* Free bad block table memory */
 	kfree(chip->bbt);
-	if (chip->buffers) {
-		kfree(chip->buffers->databuf);
-		kfree(chip->buffers->ecccode);
-		kfree(chip->buffers->ecccalc);
-		kfree(chip->buffers);
-	}
+	kfree(chip->data_buf);
+	kfree(chip->ecc.code_buf);
+	kfree(chip->ecc.calc_buf);
 
 	/* Free bad block descriptor memory */
 	if (chip->badblock_pattern && chip->badblock_pattern->options
diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index 2915b67..3609285 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -898,7 +898,7 @@ static inline int nand_memory_bbt(struct mtd_info *mtd, struct nand_bbt_descr *b
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 
-	return create_bbt(mtd, this->buffers->databuf, bd, -1);
+	return create_bbt(mtd, this->data_buf, bd, -1);
 }
 
 /**
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index dad438c..7870cb1 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1530,7 +1530,7 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 			       const uint8_t *buf, int oob_required, int page)
 {
 	int ret;
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
+	uint8_t *ecc_calc = chip->ecccalc;
 
 	/* Enable GPMC ecc engine */
 	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
@@ -1568,7 +1568,7 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
 				  u32 data_len, const u8 *buf,
 				  int oob_required, int page)
 {
-	u8 *ecc_calc = chip->buffers->ecccalc;
+	u8 *ecc_calc = chip->ecccalc;
 	int ecc_size      = chip->ecc.size;
 	int ecc_bytes     = chip->ecc.bytes;
 	int ecc_steps     = chip->ecc.steps;
@@ -1605,7 +1605,7 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
 
 	/* copy calculated ECC for whole page to chip->buffer->oob */
 	/* this include masked-value(0xFF) for unwritten subpages */
-	ecc_calc = chip->buffers->ecccalc;
+	ecc_calc = chip->ecccalc;
 	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
 					 chip->ecc.total);
 	if (ret)
@@ -1635,8 +1635,8 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
 static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint8_t *ecc_code = chip->buffers->ecccode;
+	uint8_t *ecc_calc = chip->ecccalc;
+	uint8_t *ecc_code = chip->ecccode;
 	int stat, ret;
 	unsigned int max_bitflips = 0;
 
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 82244be..9fe5994 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1544,7 +1544,7 @@ static int sunxi_nfc_hw_common_ecc_read_oob(struct mtd_info *mtd,
 
 	chip->pagebuf = -1;
 
-	return chip->ecc.read_page(mtd, chip, chip->buffers->databuf, 1, page);
+	return chip->ecc.read_page(mtd, chip, chip->data_buf, 1, page);
 }
 
 static int sunxi_nfc_hw_common_ecc_write_oob(struct mtd_info *mtd,
@@ -1557,8 +1557,8 @@ static int sunxi_nfc_hw_common_ecc_write_oob(struct mtd_info *mtd,
 
 	chip->pagebuf = -1;
 
-	memset(chip->buffers->databuf, 0xff, mtd->writesize);
-	ret = chip->ecc.write_page(mtd, chip, chip->buffers->databuf, 1, page);
+	memset(chip->data_buf, 0xff, mtd->writesize);
+	ret = chip->ecc.write_page(mtd, chip, chip->data_buf, 1, page);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 5b24a8e..254f847 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -520,6 +520,8 @@ static const struct nand_ecc_caps __name = {			\
  * @postpad:	padding information for syndrome based ECC generators
  * @options:	ECC specific options (see NAND_ECC_XXX flags defined above)
  * @priv:	pointer to private ECC control data
+ * @calc_buf:	buffer for calculated ECC, size is oobsize.
+ * @code_buf:	buffer for ECC read from flash, size is oobsize.
  * @hwctl:	function to control hardware ECC generator. Must only
  *		be provided if an hardware ECC is available
  * @calculate:	function for ECC calculation or readback from ECC hardware
@@ -570,6 +572,8 @@ struct nand_ecc_ctrl {
 	int postpad;
 	unsigned int options;
 	void *priv;
+	u8 *calc_buf;
+	u8 *code_buf;
 	void (*hwctl)(struct mtd_info *mtd, int mode);
 	int (*calculate)(struct mtd_info *mtd, const uint8_t *dat,
 			uint8_t *ecc_code);
@@ -603,21 +607,6 @@ static inline int nand_standard_page_accessors(struct nand_ecc_ctrl *ecc)
 }
 
 /**
- * struct nand_buffers - buffer structure for read/write
- * @ecccalc:	buffer pointer for calculated ECC, size is oobsize.
- * @ecccode:	buffer pointer for ECC read from flash, size is oobsize.
- * @databuf:	buffer pointer for data, size is (page size + oobsize).
- *
- * Do not change the order of buffers. databuf and oobrbuf must be in
- * consecutive order.
- */
-struct nand_buffers {
-	uint8_t	*ecccalc;
-	uint8_t	*ecccode;
-	uint8_t *databuf;
-};
-
-/**
  * struct nand_sdr_timings - SDR NAND chip timings
  *
  * This struct defines the timing requirements of a SDR NAND chip.
@@ -785,7 +774,6 @@ struct nand_manufacturer_ops {
  * @setup_read_retry:	[FLASHSPECIFIC] flash (vendor) specific function for
  *			setting the read-retry mode. Mostly needed for MLC NAND.
  * @ecc:		[BOARDSPECIFIC] ECC control structure
- * @buffers:		buffer structure for read/write
  * @buf_align:		minimum buffer alignment required by a platform
  * @hwcontrol:		platform-specific hardware control structure
  * @erase:		[REPLACEABLE] erase function
@@ -825,6 +813,7 @@ struct nand_manufacturer_ops {
  * @numchips:		[INTERN] number of physical chips
  * @chipsize:		[INTERN] the size of one chip for multichip arrays
  * @pagemask:		[INTERN] page number mask = number of (pages / chip) - 1
+ * @data_buf:		[INTERN] buffer for data, size is (page size + oobsize).
  * @pagebuf:		[INTERN] holds the pagenumber which is currently in
  *			data_buf.
  * @pagebuf_bitflips:	[INTERN] holds the bitflip count for the page which is
@@ -903,6 +892,7 @@ struct nand_chip {
 	int numchips;
 	uint64_t chipsize;
 	int pagemask;
+	u8 *data_buf;
 	int pagebuf;
 	unsigned int pagebuf_bitflips;
 	int subpagesize;
@@ -933,7 +923,6 @@ struct nand_chip {
 	struct nand_hw_control *controller;
 
 	struct nand_ecc_ctrl ecc;
-	struct nand_buffers *buffers;
 	unsigned long buf_align;
 	struct nand_hw_control hwcontrol;
 
-- 
2.7.4
