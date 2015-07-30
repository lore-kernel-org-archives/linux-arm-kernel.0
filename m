From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 15:50:23 +0200
Subject: [RFC PATCH 4/6] mtd: nand: add an helper to access the ecc controller
 struct
In-Reply-To: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438264225-23796-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ecc controller structure is currently directly accessed (chip->ecc),
but since we are about to add support for per-partition ECC, providing
an helper function to access this field will make the migration easier.

Create the nand_ecc() helper and modify all direct accesses to the ecc
field in the NAND core code.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 270 +++++++++++++++++++++++--------------------
 include/linux/mtd/nand.h     |   5 +
 2 files changed, 147 insertions(+), 128 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 0321126..67a29f5 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1133,26 +1133,26 @@ static int nand_read_page_raw_syndrome(struct mtd_info *mtd,
 				       struct nand_chip *chip, uint8_t *buf,
 				       int oob_required, int page)
 {
-	int eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
+	int eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
 	uint8_t *oob = chip->oob_poi;
 	int steps, size;
 
-	for (steps = chip->ecc.steps; steps > 0; steps--) {
+	for (steps = nand_ecc(chip)->steps; steps > 0; steps--) {
 		chip->read_buf(mtd, buf, eccsize);
 		buf += eccsize;
 
-		if (chip->ecc.prepad) {
-			chip->read_buf(mtd, oob, chip->ecc.prepad);
-			oob += chip->ecc.prepad;
+		if (nand_ecc(chip)->prepad) {
+			chip->read_buf(mtd, oob, nand_ecc(chip)->prepad);
+			oob += nand_ecc(chip)->prepad;
 		}
 
 		chip->read_buf(mtd, oob, eccbytes);
 		oob += eccbytes;
 
-		if (chip->ecc.postpad) {
-			chip->read_buf(mtd, oob, chip->ecc.postpad);
-			oob += chip->ecc.postpad;
+		if (nand_ecc(chip)->postpad) {
+			chip->read_buf(mtd, oob, nand_ecc(chip)->postpad);
+			oob += nand_ecc(chip)->postpad;
 		}
 	}
 
@@ -1174,30 +1174,31 @@ static int nand_read_page_raw_syndrome(struct mtd_info *mtd,
 static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
+	int i, eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
+	int eccsteps = nand_ecc(chip)->steps;
 	uint8_t *p = buf;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	uint32_t *eccpos = nand_ecc(chip)->layout->eccpos;
 	unsigned int max_bitflips = 0;
 
-	chip->ecc.read_page_raw(mtd, chip, buf, 1, page);
+	nand_ecc(chip)->read_page_raw(mtd, chip, buf, 1, page);
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		nand_ecc(chip)->calculate(mtd, p, &ecc_calc[i]);
 
-	for (i = 0; i < chip->ecc.total; i++)
+	for (i = 0; i < nand_ecc(chip)->total; i++)
 		ecc_code[i] = chip->oob_poi[eccpos[i]];
 
-	eccsteps = chip->ecc.steps;
+	eccsteps = nand_ecc(chip)->steps;
 	p = buf;
 
 	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
+		stat = nand_ecc(chip)->correct(mtd, p, &ecc_code[i],
+					       &ecc_calc[i]);
 		if (stat < 0) {
 			mtd->ecc_stats.failed++;
 		} else {
@@ -1222,7 +1223,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 			int page)
 {
 	int start_step, end_step, num_steps;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	uint32_t *eccpos = nand_ecc(chip)->layout->eccpos;
 	uint8_t *p;
 	int data_col_addr, i, gaps = 0;
 	int datafrag_len, eccfrag_len, aligned_len, aligned_pos;
@@ -1231,16 +1232,16 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	unsigned int max_bitflips = 0;
 
 	/* Column address within the page aligned to ECC size (256bytes) */
-	start_step = data_offs / chip->ecc.size;
-	end_step = (data_offs + readlen - 1) / chip->ecc.size;
+	start_step = data_offs / nand_ecc(chip)->size;
+	end_step = (data_offs + readlen - 1) / nand_ecc(chip)->size;
 	num_steps = end_step - start_step + 1;
-	index = start_step * chip->ecc.bytes;
+	index = start_step * nand_ecc(chip)->bytes;
 
 	/* Data size aligned to ECC ecc.size */
-	datafrag_len = num_steps * chip->ecc.size;
-	eccfrag_len = num_steps * chip->ecc.bytes;
+	datafrag_len = num_steps * nand_ecc(chip)->size;
+	eccfrag_len = num_steps * nand_ecc(chip)->bytes;
 
-	data_col_addr = start_step * chip->ecc.size;
+	data_col_addr = start_step * nand_ecc(chip)->size;
 	/* If we read not a page aligned data */
 	if (data_col_addr != 0)
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, data_col_addr, -1);
@@ -1249,8 +1250,9 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, p, datafrag_len);
 
 	/* Calculate ECC */
-	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size)
-		chip->ecc.calculate(mtd, p, &chip->buffers->ecccalc[i]);
+	for (i = 0; i < eccfrag_len;
+	     i += nand_ecc(chip)->bytes, p += nand_ecc(chip)->size)
+		nand_ecc(chip)->calculate(mtd, p, &chip->buffers->ecccalc[i]);
 
 	/*
 	 * The performance is faster if we position offsets according to
@@ -1274,7 +1276,8 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		aligned_len = eccfrag_len;
 		if (eccpos[index] & (busw - 1))
 			aligned_len++;
-		if (eccpos[index + (num_steps * chip->ecc.bytes)] & (busw - 1))
+		if (eccpos[index + (num_steps * nand_ecc(chip)->bytes)] &
+		    (busw - 1))
 			aligned_len++;
 
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
@@ -1286,11 +1289,13 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->buffers->ecccode[i] = chip->oob_poi[eccpos[i + index]];
 
 	p = bufpoi + data_col_addr;
-	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size) {
+	for (i = 0; i < eccfrag_len;
+	     i += nand_ecc(chip)->bytes, p += nand_ecc(chip)->size) {
 		int stat;
 
-		stat = chip->ecc.correct(mtd, p,
-			&chip->buffers->ecccode[i], &chip->buffers->ecccalc[i]);
+		stat = nand_ecc(chip)->correct(mtd, p,
+			&chip->buffers->ecccode[i],
+			&chip->buffers->ecccalc[i]);
 		if (stat < 0) {
 			mtd->ecc_stats.failed++;
 		} else {
@@ -1314,32 +1319,33 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
+	int i, eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
+	int eccsteps = nand_ecc(chip)->steps;
 	uint8_t *p = buf;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	uint32_t *eccpos = nand_ecc(chip)->layout->eccpos;
 	unsigned int max_bitflips = 0;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		nand_ecc(chip)->hwctl(mtd, NAND_ECC_READ);
 		chip->read_buf(mtd, p, eccsize);
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		nand_ecc(chip)->calculate(mtd, p, &ecc_calc[i]);
 	}
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	for (i = 0; i < chip->ecc.total; i++)
+	for (i = 0; i < nand_ecc(chip)->total; i++)
 		ecc_code[i] = chip->oob_poi[eccpos[i]];
 
-	eccsteps = chip->ecc.steps;
+	eccsteps = nand_ecc(chip)->steps;
 	p = buf;
 
 	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
+		stat = nand_ecc(chip)->correct(mtd, p, &ecc_code[i],
+					       &ecc_calc[i]);
 		if (stat < 0) {
 			mtd->ecc_stats.failed++;
 		} else {
@@ -1367,12 +1373,12 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
+	int i, eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
+	int eccsteps = nand_ecc(chip)->steps;
 	uint8_t *p = buf;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	uint32_t *eccpos = nand_ecc(chip)->layout->eccpos;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	unsigned int max_bitflips = 0;
 
@@ -1381,17 +1387,17 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
 
-	for (i = 0; i < chip->ecc.total; i++)
+	for (i = 0; i < nand_ecc(chip)->total; i++)
 		ecc_code[i] = chip->oob_poi[eccpos[i]];
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		nand_ecc(chip)->hwctl(mtd, NAND_ECC_READ);
 		chip->read_buf(mtd, p, eccsize);
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		nand_ecc(chip)->calculate(mtd, p, &ecc_calc[i]);
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], NULL);
+		stat = nand_ecc(chip)->correct(mtd, p, &ecc_code[i], NULL);
 		if (stat < 0) {
 			mtd->ecc_stats.failed++;
 		} else {
@@ -1416,9 +1422,9 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 				   uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
+	int i, eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
+	int eccsteps = nand_ecc(chip)->steps;
 	uint8_t *p = buf;
 	uint8_t *oob = chip->oob_poi;
 	unsigned int max_bitflips = 0;
@@ -1426,17 +1432,17 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		nand_ecc(chip)->hwctl(mtd, NAND_ECC_READ);
 		chip->read_buf(mtd, p, eccsize);
 
-		if (chip->ecc.prepad) {
-			chip->read_buf(mtd, oob, chip->ecc.prepad);
-			oob += chip->ecc.prepad;
+		if (nand_ecc(chip)->prepad) {
+			chip->read_buf(mtd, oob, nand_ecc(chip)->prepad);
+			oob += nand_ecc(chip)->prepad;
 		}
 
-		chip->ecc.hwctl(mtd, NAND_ECC_READSYN);
+		nand_ecc(chip)->hwctl(mtd, NAND_ECC_READSYN);
 		chip->read_buf(mtd, oob, eccbytes);
-		stat = chip->ecc.correct(mtd, p, oob, NULL);
+		stat = nand_ecc(chip)->correct(mtd, p, oob, NULL);
 
 		if (stat < 0) {
 			mtd->ecc_stats.failed++;
@@ -1447,9 +1453,9 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 
 		oob += eccbytes;
 
-		if (chip->ecc.postpad) {
-			chip->read_buf(mtd, oob, chip->ecc.postpad);
-			oob += chip->ecc.postpad;
+		if (nand_ecc(chip)->postpad) {
+			chip->read_buf(mtd, oob, nand_ecc(chip)->postpad);
+			oob += nand_ecc(chip)->postpad;
 		}
 	}
 
@@ -1479,7 +1485,7 @@ static uint8_t *nand_transfer_oob(struct nand_chip *chip, uint8_t *oob,
 		return oob + len;
 
 	case MTD_OPS_AUTO_OOB: {
-		struct nand_oobfree *free = chip->ecc.layout->oobfree;
+		struct nand_oobfree *free = nand_ecc(chip)->layout->oobfree;
 		uint32_t boffs = 0, roffs = ops->ooboffs;
 		size_t bytes = 0;
 
@@ -1599,16 +1605,18 @@ read_retry:
 			 * the read methods return max bitflips per ecc step.
 			 */
 			if (unlikely(ops->mode == MTD_OPS_RAW))
-				ret = chip->ecc.read_page_raw(mtd, chip, bufpoi,
+				ret = nand_ecc(chip)->read_page_raw(mtd, chip,
+							      bufpoi,
 							      oob_required,
 							      page);
 			else if (!aligned && NAND_HAS_SUBPAGE_READ(chip) &&
 				 !oob)
-				ret = chip->ecc.read_subpage(mtd, chip,
+				ret = nand_ecc(chip)->read_subpage(mtd, chip,
 							col, bytes, bufpoi,
 							page);
 			else
-				ret = chip->ecc.read_page(mtd, chip, bufpoi,
+				ret = nand_ecc(chip)->read_page(mtd, chip,
+							  bufpoi,
 							  oob_required, page);
 			if (ret < 0) {
 				if (use_bufpoi)
@@ -1769,13 +1777,14 @@ static int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 				  int page)
 {
 	int length = mtd->oobsize;
-	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
-	int eccsize = chip->ecc.size;
+	int chunk = nand_ecc(chip)->bytes + nand_ecc(chip)->prepad +
+		    nand_ecc(chip)->postpad;
+	int eccsize = nand_ecc(chip)->size;
 	uint8_t *bufpoi = chip->oob_poi;
 	int i, toread, sndrnd = 0, pos;
 
-	chip->cmdfunc(mtd, NAND_CMD_READ0, chip->ecc.size, page);
-	for (i = 0; i < chip->ecc.steps; i++) {
+	chip->cmdfunc(mtd, NAND_CMD_READ0, nand_ecc(chip)->size, page);
+	for (i = 0; i < nand_ecc(chip)->steps; i++) {
 		if (sndrnd) {
 			pos = eccsize + i * (eccsize + chunk);
 			if (mtd->writesize > 512)
@@ -1828,9 +1837,10 @@ static int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_write_oob_syndrome(struct mtd_info *mtd,
 				   struct nand_chip *chip, int page)
 {
-	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
-	int eccsize = chip->ecc.size, length = mtd->oobsize;
-	int i, len, pos, status = 0, sndcmd = 0, steps = chip->ecc.steps;
+	int chunk = nand_ecc(chip)->bytes + nand_ecc(chip)->prepad +
+		    nand_ecc(chip)->postpad;
+	int eccsize = nand_ecc(chip)->size, length = mtd->oobsize;
+	int i, len, pos, status = 0, sndcmd = 0, steps = nand_ecc(chip)->steps;
 	const uint8_t *bufpoi = chip->oob_poi;
 
 	/*
@@ -1838,7 +1848,7 @@ static int nand_write_oob_syndrome(struct mtd_info *mtd,
 	 * or
 	 * data-pad-ecc-pad-data-pad .... ecc-pad-oob
 	 */
-	if (!chip->ecc.prepad && !chip->ecc.postpad) {
+	if (!nand_ecc(chip)->prepad && !nand_ecc(chip)->postpad) {
 		pos = steps * (eccsize + chunk);
 		steps = 0;
 	} else
@@ -1902,7 +1912,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 	stats = mtd->ecc_stats;
 
 	if (ops->mode == MTD_OPS_AUTO_OOB)
-		len = chip->ecc.layout->oobavail;
+		len = nand_ecc(chip)->layout->oobavail;
 	else
 		len = mtd->oobsize;
 
@@ -1930,9 +1940,9 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 
 	while (1) {
 		if (ops->mode == MTD_OPS_RAW)
-			ret = chip->ecc.read_oob_raw(mtd, chip, page);
+			ret = nand_ecc(chip)->read_oob_raw(mtd, chip, page);
 		else
-			ret = chip->ecc.read_oob(mtd, chip, page);
+			ret = nand_ecc(chip)->read_oob(mtd, chip, page);
 
 		if (ret < 0)
 			break;
@@ -2053,26 +2063,26 @@ static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 					struct nand_chip *chip,
 					const uint8_t *buf, int oob_required)
 {
-	int eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
+	int eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
 	uint8_t *oob = chip->oob_poi;
 	int steps, size;
 
-	for (steps = chip->ecc.steps; steps > 0; steps--) {
+	for (steps = nand_ecc(chip)->steps; steps > 0; steps--) {
 		chip->write_buf(mtd, buf, eccsize);
 		buf += eccsize;
 
-		if (chip->ecc.prepad) {
-			chip->write_buf(mtd, oob, chip->ecc.prepad);
-			oob += chip->ecc.prepad;
+		if (nand_ecc(chip)->prepad) {
+			chip->write_buf(mtd, oob, nand_ecc(chip)->prepad);
+			oob += nand_ecc(chip)->prepad;
 		}
 
 		chip->write_buf(mtd, oob, eccbytes);
 		oob += eccbytes;
 
-		if (chip->ecc.postpad) {
-			chip->write_buf(mtd, oob, chip->ecc.postpad);
-			oob += chip->ecc.postpad;
+		if (nand_ecc(chip)->postpad) {
+			chip->write_buf(mtd, oob, nand_ecc(chip)->postpad);
+			oob += nand_ecc(chip)->postpad;
 		}
 	}
 
@@ -2092,21 +2102,21 @@ static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 				  const uint8_t *buf, int oob_required)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
+	int i, eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
+	int eccsteps = nand_ecc(chip)->steps;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	const uint8_t *p = buf;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	uint32_t *eccpos = nand_ecc(chip)->layout->eccpos;
 
 	/* Software ECC calculation */
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		nand_ecc(chip)->calculate(mtd, p, &ecc_calc[i]);
 
-	for (i = 0; i < chip->ecc.total; i++)
+	for (i = 0; i < nand_ecc(chip)->total; i++)
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
 
-	return chip->ecc.write_page_raw(mtd, chip, buf, 1);
+	return nand_ecc(chip)->write_page_raw(mtd, chip, buf, 1);
 }
 
 /**
@@ -2119,20 +2129,20 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				  const uint8_t *buf, int oob_required)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
+	int i, eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
+	int eccsteps = nand_ecc(chip)->steps;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	const uint8_t *p = buf;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	uint32_t *eccpos = nand_ecc(chip)->layout->eccpos;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+		nand_ecc(chip)->hwctl(mtd, NAND_ECC_WRITE);
 		chip->write_buf(mtd, p, eccsize);
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		nand_ecc(chip)->calculate(mtd, p, &ecc_calc[i]);
 	}
 
-	for (i = 0; i < chip->ecc.total; i++)
+	for (i = 0; i < nand_ecc(chip)->total; i++)
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
 
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -2157,10 +2167,10 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 {
 	uint8_t *oob_buf  = chip->oob_poi;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	int ecc_size      = chip->ecc.size;
-	int ecc_bytes     = chip->ecc.bytes;
-	int ecc_steps     = chip->ecc.steps;
-	uint32_t *eccpos  = chip->ecc.layout->eccpos;
+	int ecc_size      = nand_ecc(chip)->size;
+	int ecc_bytes     = nand_ecc(chip)->bytes;
+	int ecc_steps     = nand_ecc(chip)->steps;
+	uint32_t *eccpos  = nand_ecc(chip)->layout->eccpos;
 	uint32_t start_step = offset / ecc_size;
 	uint32_t end_step   = (offset + data_len - 1) / ecc_size;
 	int oob_bytes       = mtd->oobsize / ecc_steps;
@@ -2168,7 +2178,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 
 	for (step = 0; step < ecc_steps; step++) {
 		/* configure controller for WRITE access */
-		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+		nand_ecc(chip)->hwctl(mtd, NAND_ECC_WRITE);
 
 		/* write data (untouched subpages already masked by 0xFF) */
 		chip->write_buf(mtd, buf, ecc_size);
@@ -2177,7 +2187,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 		if ((step < start_step) || (step > end_step))
 			memset(ecc_calc, 0xff, ecc_bytes);
 		else
-			chip->ecc.calculate(mtd, buf, ecc_calc);
+			nand_ecc(chip)->calculate(mtd, buf, ecc_calc);
 
 		/* mask OOB of un-touched subpages by padding 0xFF */
 		/* if oob_required, preserve OOB metadata of written subpage */
@@ -2192,7 +2202,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 	/* copy calculated ECC for whole page to chip->buffer->oob */
 	/* this include masked-value(0xFF) for unwritten subpages */
 	ecc_calc = chip->buffers->ecccalc;
-	for (i = 0; i < chip->ecc.total; i++)
+	for (i = 0; i < nand_ecc(chip)->total; i++)
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
 
 	/* write OOB buffer to NAND device */
@@ -2216,29 +2226,29 @@ static int nand_write_page_syndrome(struct mtd_info *mtd,
 				    struct nand_chip *chip,
 				    const uint8_t *buf, int oob_required)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
+	int i, eccsize = nand_ecc(chip)->size;
+	int eccbytes = nand_ecc(chip)->bytes;
+	int eccsteps = nand_ecc(chip)->steps;
 	const uint8_t *p = buf;
 	uint8_t *oob = chip->oob_poi;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 
-		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+		nand_ecc(chip)->hwctl(mtd, NAND_ECC_WRITE);
 		chip->write_buf(mtd, p, eccsize);
 
-		if (chip->ecc.prepad) {
-			chip->write_buf(mtd, oob, chip->ecc.prepad);
-			oob += chip->ecc.prepad;
+		if (nand_ecc(chip)->prepad) {
+			chip->write_buf(mtd, oob, nand_ecc(chip)->prepad);
+			oob += nand_ecc(chip)->prepad;
 		}
 
-		chip->ecc.calculate(mtd, p, oob);
+		nand_ecc(chip)->calculate(mtd, p, oob);
 		chip->write_buf(mtd, oob, eccbytes);
 		oob += eccbytes;
 
-		if (chip->ecc.postpad) {
-			chip->write_buf(mtd, oob, chip->ecc.postpad);
-			oob += chip->ecc.postpad;
+		if (nand_ecc(chip)->postpad) {
+			chip->write_buf(mtd, oob, nand_ecc(chip)->postpad);
+			oob += nand_ecc(chip)->postpad;
 		}
 	}
 
@@ -2269,7 +2279,7 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	int status, subpage;
 
 	if (!(chip->options & NAND_NO_SUBPAGE_WRITE) &&
-		chip->ecc.write_subpage)
+		nand_ecc(chip)->write_subpage)
 		subpage = offset || (data_len < mtd->writesize);
 	else
 		subpage = 0;
@@ -2277,13 +2287,15 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
 
 	if (unlikely(raw))
-		status = chip->ecc.write_page_raw(mtd, chip, buf,
+		status = nand_ecc(chip)->write_page_raw(mtd, chip, buf,
 							oob_required);
 	else if (subpage)
-		status = chip->ecc.write_subpage(mtd, chip, offset, data_len,
-							 buf, oob_required);
+		status = nand_ecc(chip)->write_subpage(mtd, chip, offset,
+						       data_len, buf,
+						       oob_required);
 	else
-		status = chip->ecc.write_page(mtd, chip, buf, oob_required);
+		status = nand_ecc(chip)->write_page(mtd, chip, buf,
+						    oob_required);
 
 	if (status < 0)
 		return status;
@@ -2342,7 +2354,7 @@ static uint8_t *nand_fill_oob(struct mtd_info *mtd, uint8_t *oob, size_t len,
 		return oob + len;
 
 	case MTD_OPS_AUTO_OOB: {
-		struct nand_oobfree *free = chip->ecc.layout->oobfree;
+		struct nand_oobfree *free = nand_ecc(chip)->layout->oobfree;
 		uint32_t boffs = 0, woffs = ops->ooboffs;
 		size_t bytes = 0;
 
@@ -2582,7 +2594,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 			 __func__, (unsigned int)to, (int)ops->ooblen);
 
 	if (ops->mode == MTD_OPS_AUTO_OOB)
-		len = chip->ecc.layout->oobavail;
+		len = nand_ecc(chip)->layout->oobavail;
 	else
 		len = mtd->oobsize;
 
@@ -2636,9 +2648,11 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 	nand_fill_oob(mtd, ops->oobbuf, ops->ooblen, ops);
 
 	if (ops->mode == MTD_OPS_RAW)
-		status = chip->ecc.write_oob_raw(mtd, chip, page & chip->pagemask);
+		status = nand_ecc(chip)->write_oob_raw(mtd, chip,
+						       page & chip->pagemask);
 	else
-		status = chip->ecc.write_oob(mtd, chip, page & chip->pagemask);
+		status = nand_ecc(chip)->write_oob(mtd, chip,
+						   page & chip->pagemask);
 
 	chip->select_chip(mtd, -1);
 
@@ -3816,13 +3830,13 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	if (ecc_mode >= 0)
-		chip->ecc.mode = ecc_mode;
+		nand_ecc(chip)->mode = ecc_mode;
 
 	if (ecc_strength >= 0)
-		chip->ecc.strength = ecc_strength;
+		nand_ecc(chip)->strength = ecc_strength;
 
 	if (ecc_step > 0)
-		chip->ecc.size = ecc_step;
+		nand_ecc(chip)->size = ecc_step;
 
 	return 0;
 }
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 272f429..2a9b557 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -1030,4 +1030,9 @@ struct nand_sdr_timings {
 
 /* get timing characteristics from ONFI timing mode. */
 const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
+
+static inline struct nand_ecc_ctrl *nand_ecc(struct nand_chip *chip)
+{
+	return &chip->ecc;
+}
 #endif /* __LINUX_MTD_NAND_H */
-- 
1.9.1
