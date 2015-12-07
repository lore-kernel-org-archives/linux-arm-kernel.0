From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:07 +0100
Subject: [PATCH 12/23] mtd: use mtd_eccpos() and mtd_oobfree() where
 appropriate
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-13-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtd_eccpos(), mtd_oobfree() and mtd_eccbytes() helper functions have
been added to avoid direct accesses to the ecclayout, and thus allow for
future rework.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
are referenced.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdchar.c                  | 79 ++++++++++++++++++++++++--------
 drivers/mtd/mtdswap.c                  |  4 +-
 drivers/mtd/nand/atmel_nand.c          | 21 ++++-----
 drivers/mtd/nand/fsl_ifc_nand.c        |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |  9 ++--
 drivers/mtd/nand/lpc32xx_slc.c         |  4 +-
 drivers/mtd/nand/nand_base.c           | 83 ++++++++++++++++++----------------
 drivers/mtd/nand/nand_bch.c            |  2 +-
 drivers/mtd/nand/omap2.c               | 11 ++---
 drivers/mtd/onenand/onenand_base.c     | 61 +++++++++++++------------
 10 files changed, 163 insertions(+), 113 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 6d19835..66d0898 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -472,31 +472,78 @@ static int mtdchar_readoob(struct file *file, struct mtd_info *mtd,
  * nand_ecclayout flexibly (i.e. the struct may change size in new
  * releases without requiring major rewrites).
  */
-static int shrink_ecclayout(const struct nand_ecclayout *from,
-		struct nand_ecclayout_user *to)
+static int shrink_ecclayout(struct mtd_info *mtd,
+			    struct nand_ecclayout_user *to)
 {
 	int i;
 
-	if (!from || !to)
+	if (!mtd || !to)
 		return -EINVAL;
 
 	memset(to, 0, sizeof(*to));
 
-	to->eccbytes = min((int)from->eccbytes, MTD_MAX_ECCPOS_ENTRIES);
-	for (i = 0; i < to->eccbytes; i++)
-		to->eccpos[i] = from->eccpos[i];
+	to->eccbytes = 0;
+	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES; i++) {
+		int pos = mtd_eccpos(mtd, i);
+
+		if (pos < 0)
+			break;
+
+		to->eccpos[i] = pos;
+		to->eccbytes++;
+	}
 
 	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES; i++) {
-		if (from->oobfree[i].length == 0 &&
-				from->oobfree[i].offset == 0)
+		mtd_oobfree(mtd, i, &to->oobfree[i]);
+		if (to->oobfree[i].length == 0 &&
+		    to->oobfree[i].offset == 0)
 			break;
-		to->oobavail += from->oobfree[i].length;
-		to->oobfree[i] = from->oobfree[i];
+		to->oobavail += to->oobfree[i].length;
 	}
 
 	return 0;
 }
 
+static int get_oobinfo(struct mtd_info *mtd, struct nand_oobinfo *to)
+{
+	int i;
+
+	if (!mtd || !to)
+		return -EINVAL;
+
+	memset(to, 0, sizeof(*to));
+
+	to->eccbytes = 0;
+	for (i = 0; i < ARRAY_SIZE(to->eccpos); i++) {
+		int pos = mtd_eccpos(mtd, i);
+
+		if (pos < 0)
+			break;
+
+		to->eccpos[i] = pos;
+		to->eccbytes++;
+	}
+
+	if (i == ARRAY_SIZE(to->eccpos))
+		return -EINVAL;
+
+	for (i = 0; i < 8; i++) {
+		struct nand_oobfree oobfree;
+
+		mtd_oobfree(mtd, i, &oobfree);
+		if (oobfree.length == 0 &&
+		    oobfree.offset == 0)
+			break;
+
+		to->oobfree[i][0] = oobfree.offset;
+		to->oobfree[i][1] = oobfree.length;
+	}
+
+	to->useecc = MTD_NANDECC_AUTOPLACE;
+
+	return 0;
+}
+
 static int mtdchar_blkpg_ioctl(struct mtd_info *mtd,
 			       struct blkpg_ioctl_arg *arg)
 {
@@ -817,14 +864,10 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 
 		if (!mtd->ecclayout)
 			return -EOPNOTSUPP;
-		if (mtd->ecclayout->eccbytes > ARRAY_SIZE(oi.eccpos))
-			return -EINVAL;
 
-		oi.useecc = MTD_NANDECC_AUTOPLACE;
-		memcpy(&oi.eccpos, mtd->ecclayout->eccpos, sizeof(oi.eccpos));
-		memcpy(&oi.oobfree, mtd->ecclayout->oobfree,
-		       sizeof(oi.oobfree));
-		oi.eccbytes = mtd->ecclayout->eccbytes;
+		ret = get_oobinfo(mtd, &oi);
+		if (ret)
+			return ret;
 
 		if (copy_to_user(argp, &oi, sizeof(struct nand_oobinfo)))
 			return -EFAULT;
@@ -920,7 +963,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		if (!usrlay)
 			return -ENOMEM;
 
-		shrink_ecclayout(mtd->ecclayout, usrlay);
+		shrink_ecclayout(mtd, usrlay);
 
 		if (copy_to_user(argp, usrlay, sizeof(*usrlay)))
 			ret = -EFAULT;
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index d330eb1..6fe47b0 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1417,7 +1417,6 @@ static void mtdswap_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	unsigned long part;
 	unsigned int eblocks, eavailable, bad_blocks, spare_cnt;
 	uint64_t swap_size, use_size, size_limit;
-	struct nand_ecclayout *oinfo;
 	int ret;
 
 	parts = &partitions[0];
@@ -1447,8 +1446,7 @@ static void mtdswap_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 		return;
 	}
 
-	oinfo = mtd->ecclayout;
-	if (!oinfo) {
+	if (mtd_oobfree(mtd, 0) < 0) {
 		printk(KERN_ERR "%s: mtd%d does not have OOB\n",
 			MTDSWAP_PREFIX, mtd->index);
 		return;
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index f4e1f91..da16b1a 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -833,7 +833,7 @@ static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf, uint8_t *ecc,
 			err_byte = ecc[tmp];
 			ecc[tmp] ^= (1 << bit_pos);
 
-			pos = tmp + nand_chip->ecc.layout->eccpos[0];
+			pos = tmp + mtd_eccpos(mtd, 0);
 			dev_info(host->dev, "Bit flip in OOB, oob_byte_pos: %d, bit_pos: %d, 0x%02x -> 0x%02x\n",
 				pos, bit_pos, err_byte, ecc[tmp]);
 		}
@@ -922,7 +922,6 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	struct atmel_nand_host *host = chip->priv;
 	int eccsize = chip->ecc.size * chip->ecc.steps;
 	uint8_t *oob = chip->oob_poi;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	uint32_t stat;
 	unsigned long end_time;
 	int bitflips = 0;
@@ -944,7 +943,8 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 
 	stat = pmecc_readl_relaxed(host->ecc, ISR);
 	if (stat != 0) {
-		bitflips = pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]);
+		bitflips = pmecc_correction(mtd, stat, buf,
+					    &oob[mtd_eccpos(mtd, 0)]);
 		if (bitflips < 0)
 			/* uncorrectable errors */
 			return 0;
@@ -958,7 +958,6 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 		int page)
 {
 	struct atmel_nand_host *host = chip->priv;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	int i, j;
 	unsigned long end_time;
 
@@ -981,7 +980,7 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 			int pos;
 
 			pos = i * chip->ecc.bytes + j;
-			chip->oob_poi[eccpos[pos]] =
+			chip->oob_poi[mtd_eccpos(mtd, pos)] =
 				pmecc_readb_ecc_relaxed(host->ecc, i, j);
 		}
 	}
@@ -1044,9 +1043,9 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 
 	ecc_layout = nand_chip->ecc.layout;
 	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
-	pmecc_writel(host->ecc, SADDR, ecc_layout->eccpos[0]);
+	pmecc_writel(host->ecc, SADDR, mtd_eccpos(mtd, 0));
 	pmecc_writel(host->ecc, EADDR,
-			ecc_layout->eccpos[ecc_layout->eccbytes - 1]);
+			mtd_eccpos(mtd, ecc_layout->eccbytes - 1));
 	/* See datasheet about PMECC Clock Control Register */
 	pmecc_writel(host->ecc, CLK, 2);
 	pmecc_writel(host->ecc, IDR, 0xff);
@@ -1340,7 +1339,7 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	int eccpos = mtd_eccpos(mtd, 0);
 	uint8_t *p = buf;
 	uint8_t *oob = chip->oob_poi;
 	uint8_t *ecc_pos;
@@ -1363,7 +1362,7 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, p, eccsize);
 
 	/* move to ECC position if needed */
-	if (eccpos[0] != 0) {
+	if (eccpos != 0) {
 		/* This only works on large pages
 		 * because the ECC controller waits for
 		 * NAND_CMD_RNDOUTSTART after the
@@ -1371,11 +1370,11 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 		 * anyway, for small pages, the eccpos[0] == 0
 		 */
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
-				mtd->writesize + eccpos[0], -1);
+				mtd->writesize + eccpos, -1);
 	}
 
 	/* the ECC controller needs to read the ECC just after the data */
-	ecc_pos = oob + eccpos[0];
+	ecc_pos = oob + eccpos;
 	chip->read_buf(mtd, ecc_pos, eccbytes);
 
 	/* check if there's an error */
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index f260831..610308e 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -266,7 +266,7 @@ static int is_blank(struct mtd_info *mtd, unsigned int bufnum)
 	}
 
 	for (i = 0; i < chip->ecc.layout->eccbytes; i++) {
-		int pos = chip->ecc.layout->eccpos[i];
+		int pos = mtd_eccpos(mtd, i);
 
 		if (__raw_readb(&oob[pos]) != 0xff)
 			return 0;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 5a9b696..c208f5e 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1325,18 +1325,19 @@ static int gpmi_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 static int
 gpmi_ecc_write_oob(struct mtd_info *mtd, struct nand_chip *chip, int page)
 {
-	struct nand_oobfree *of = mtd->ecclayout->oobfree;
+	struct nand_oobfree of = { };
 	int status = 0;
 
 	/* Do we have available oob area? */
-	if (!of->length)
+	mtd_oobfree(mtd, 0, &of);
+	if (!of.length)
 		return -EPERM;
 
 	if (!nand_is_slc(chip))
 		return -EPERM;
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize + of->offset, page);
-	chip->write_buf(mtd, chip->oob_poi + of->offset, of->length);
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize + of.offset, page);
+	chip->write_buf(mtd, chip->oob_poi + of.offset, of.length);
 	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
 
 	status = chip->waitfunc(mtd, chip);
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 277626e..47dcfddd 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -621,7 +621,7 @@ static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
 	lpc32xx_slc_ecc_copy(tmpecc, (uint32_t *) host->ecc_buf, chip->ecc.steps);
 
 	/* Pointer to ECC data retrieved from NAND spare area */
-	oobecc = chip->oob_poi + chip->ecc.layout->eccpos[0];
+	oobecc = chip->oob_poi + mtd_eccpos(mtd, 0);
 
 	for (i = 0; i < chip->ecc.steps; i++) {
 		stat = chip->ecc.correct(mtd, buf, oobecc,
@@ -667,7 +667,7 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 					    int oob_required, int page)
 {
 	struct lpc32xx_nand_host *host = chip->priv;
-	uint8_t *pb = chip->oob_poi + chip->ecc.layout->eccpos[0];
+	uint8_t *pb = chip->oob_poi + mtd_eccpos(mtd, 0);
 	int error;
 
 	/* Write data, calculate ECC on outbound data */
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index b99b442..30a0721 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1315,7 +1315,6 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	uint8_t *p = buf;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	unsigned int max_bitflips = 0;
 
 	chip->ecc.read_page_raw(mtd, chip, buf, 1, page);
@@ -1324,7 +1323,7 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 
 	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
+		ecc_code[i] = chip->oob_poi[mtd_eccpos(mtd, i)];
 
 	eccsteps = chip->ecc.steps;
 	p = buf;
@@ -1357,7 +1356,6 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 			int page)
 {
 	int start_step, end_step, num_steps;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	uint8_t *p;
 	int data_col_addr, i, gaps = 0;
 	int datafrag_len, eccfrag_len, aligned_len, aligned_pos;
@@ -1392,7 +1390,8 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	 * ecc.pos. Let's make sure that there are no gaps in ECC positions.
 	 */
 	for (i = 0; i < eccfrag_len - 1; i++) {
-		if (eccpos[i + index] + 1 != eccpos[i + index + 1]) {
+		if (mtd_eccpos(mtd, i + index) + 1 !=
+		    mtd_eccpos(mtd, i + index + 1)) {
 			gaps = 1;
 			break;
 		}
@@ -1405,11 +1404,12 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		 * Send the command to read the particular ECC bytes take care
 		 * about buswidth alignment in read_buf.
 		 */
-		aligned_pos = eccpos[index] & ~(busw - 1);
+		aligned_pos = mtd_eccpos(mtd, index) & ~(busw - 1);
 		aligned_len = eccfrag_len;
-		if (eccpos[index] & (busw - 1))
+		if (mtd_eccpos(mtd, index) & (busw - 1))
 			aligned_len++;
-		if (eccpos[index + (num_steps * chip->ecc.bytes)] & (busw - 1))
+		if (mtd_eccpos(mtd, index + (num_steps * chip->ecc.bytes)) &
+		    (busw - 1))
 			aligned_len++;
 
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
@@ -1418,7 +1418,8 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	for (i = 0; i < eccfrag_len; i++)
-		chip->buffers->ecccode[i] = chip->oob_poi[eccpos[i + index]];
+		chip->buffers->ecccode[i] =
+				chip->oob_poi[mtd_eccpos(mtd, i + index)];
 
 	p = bufpoi + data_col_addr;
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size) {
@@ -1455,7 +1456,6 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	uint8_t *p = buf;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	unsigned int max_bitflips = 0;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
@@ -1466,7 +1466,7 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
 	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
+		ecc_code[i] = chip->oob_poi[mtd_eccpos(mtd, i)];
 
 	eccsteps = chip->ecc.steps;
 	p = buf;
@@ -1507,7 +1507,6 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	unsigned int max_bitflips = 0;
 
@@ -1517,7 +1516,7 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
 
 	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
+		ecc_code[i] = chip->oob_poi[mtd_eccpos(mtd, i)];
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
@@ -1603,9 +1602,11 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
  * @ops: oob ops structure
  * @len: size of oob to transfer
  */
-static uint8_t *nand_transfer_oob(struct nand_chip *chip, uint8_t *oob,
+static uint8_t *nand_transfer_oob(struct mtd_info *mtd, uint8_t *oob,
 				  struct mtd_oob_ops *ops, size_t len)
 {
+	struct nand_chip *chip = mtd->priv;
+
 	switch (ops->mode) {
 
 	case MTD_OPS_PLACE_OOB:
@@ -1614,24 +1615,26 @@ static uint8_t *nand_transfer_oob(struct nand_chip *chip, uint8_t *oob,
 		return oob + len;
 
 	case MTD_OPS_AUTO_OOB: {
-		struct nand_oobfree *free = chip->ecc.layout->oobfree;
+		struct nand_oobfree free = { };
 		uint32_t boffs = 0, roffs = ops->ooboffs;
 		size_t bytes = 0;
+		int i = 0;
 
-		for (; free->length && len; free++, len -= bytes) {
+		for (mtd_oobfree(mtd, i++, &free); free.length && len;
+		     mtd_oobfree(mtd, i++, &free), len -= bytes) {
 			/* Read request not from offset 0? */
 			if (unlikely(roffs)) {
-				if (roffs >= free->length) {
-					roffs -= free->length;
+				if (roffs >= free.length) {
+					roffs -= free.length;
 					continue;
 				}
-				boffs = free->offset + roffs;
+				boffs = free.offset + roffs;
 				bytes = min_t(size_t, len,
-					      (free->length - roffs));
+					      (free.length - roffs));
 				roffs = 0;
 			} else {
-				bytes = min_t(size_t, len, free->length);
-				boffs = free->offset;
+				bytes = min_t(size_t, len, free.length);
+				boffs = free.offset;
 			}
 			memcpy(oob, chip->oob_poi + boffs, bytes);
 			oob += bytes;
@@ -1772,7 +1775,7 @@ read_retry:
 				int toread = min(oobreadlen, max_oobsize);
 
 				if (toread) {
-					oob = nand_transfer_oob(chip,
+					oob = nand_transfer_oob(mtd,
 						oob, ops, toread);
 					oobreadlen -= toread;
 				}
@@ -2073,7 +2076,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 			break;
 
 		len = min(len, readlen);
-		buf = nand_transfer_oob(chip, buf, ops, len);
+		buf = nand_transfer_oob(mtd, buf, ops, len);
 
 		if (chip->options & NAND_NEED_READRDY) {
 			/* Apply delay or wait for ready/busy pin */
@@ -2237,14 +2240,13 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int eccsteps = chip->ecc.steps;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	const uint8_t *p = buf;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 
 	/* Software ECC calculation */
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 
 	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+		chip->oob_poi[mtd_eccpos(mtd, i)] = ecc_calc[i];
 
 	return chip->ecc.write_page_raw(mtd, chip, buf, 1, page);
 }
@@ -2266,7 +2268,6 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	int eccsteps = chip->ecc.steps;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	const uint8_t *p = buf;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
@@ -2275,7 +2276,7 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+		chip->oob_poi[mtd_eccpos(mtd, i)] = ecc_calc[i];
 
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -2303,7 +2304,6 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 	int ecc_size      = chip->ecc.size;
 	int ecc_bytes     = chip->ecc.bytes;
 	int ecc_steps     = chip->ecc.steps;
-	uint32_t *eccpos  = chip->ecc.layout->eccpos;
 	uint32_t start_step = offset / ecc_size;
 	uint32_t end_step   = (offset + data_len - 1) / ecc_size;
 	int oob_bytes       = mtd->oobsize / ecc_steps;
@@ -2336,7 +2336,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 	/* this include masked-value(0xFF) for unwritten subpages */
 	ecc_calc = chip->buffers->ecccalc;
 	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+		chip->oob_poi[mtd_eccpos(mtd, i)] = ecc_calc[i];
 
 	/* write OOB buffer to NAND device */
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -2488,24 +2488,26 @@ static uint8_t *nand_fill_oob(struct mtd_info *mtd, uint8_t *oob, size_t len,
 		return oob + len;
 
 	case MTD_OPS_AUTO_OOB: {
-		struct nand_oobfree *free = chip->ecc.layout->oobfree;
+		struct nand_oobfree free = { };
 		uint32_t boffs = 0, woffs = ops->ooboffs;
 		size_t bytes = 0;
+		int i = 0;
 
-		for (; free->length && len; free++, len -= bytes) {
+		for (mtd_oobfree(mtd, i++, &free); free.length && len;
+		     mtd_oobfree(mtd, i++, &free), len -= bytes) {
 			/* Write request not from offset 0? */
 			if (unlikely(woffs)) {
-				if (woffs >= free->length) {
-					woffs -= free->length;
+				if (woffs >= free.length) {
+					woffs -= free.length;
 					continue;
 				}
-				boffs = free->offset + woffs;
+				boffs = free.offset + woffs;
 				bytes = min_t(size_t, len,
-					      (free->length - woffs));
+					      (free.length - woffs));
 				woffs = 0;
 			} else {
-				bytes = min_t(size_t, len, free->length);
-				boffs = free->offset;
+				bytes = min_t(size_t, len, free.length);
+				boffs = free.offset;
 			}
 			memcpy(chip->oob_poi + boffs, oob, bytes);
 			oob += bytes;
@@ -4087,6 +4089,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 	int i;
 	struct nand_chip *chip = mtd->priv;
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct nand_oobfree oobfree = { };
 	struct nand_buffers *nbuf;
 
 	/* New bad blocks should be marked in OOB, flash-based BBT, or both */
@@ -4284,8 +4287,10 @@ int nand_scan_tail(struct mtd_info *mtd)
 	 * the out of band area.
 	 */
 	mtd->oobavail = 0;
-	for (i = 0; ecc->layout->oobfree[i].length; i++)
-		mtd->oobavail += ecc->layout->oobfree[i].length;
+	i = 0;
+	for (mtd_oobfree(mtd, i++, &oobfree); oobfree.length;
+	     mtd_oobfree(mtd, i++, &oobfree))
+		mtd->oobavail += oobfree.length;
 
 	/* ECC sanity check: warn if it's too weak */
 	if (!nand_ecc_strength_good(mtd))
diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index 3456c20..9cff544 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -196,7 +196,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		printk(KERN_WARNING "eccsize %u is too large\n", eccsize);
 		goto fail;
 	}
-	if (layout->eccbytes != (eccsteps*eccbytes)) {
+	if (mtd_eccbytes(mtd) != (eccsteps*eccbytes)) {
 		printk(KERN_WARNING "invalid ecc layout\n");
 		goto fail;
 	}
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index a2f015d..6a598b1 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1509,7 +1509,6 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int i;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 
 	/* Enable GPMC ecc engine */
 	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
@@ -1521,7 +1520,7 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->ecc.calculate(mtd, buf, &ecc_calc[0]);
 
 	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+		chip->oob_poi[mtd_eccpos(mtd, i)] = ecc_calc[i];
 
 	/* Write ecc vector to OOB area */
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -1548,9 +1547,9 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
-	uint8_t *oob = &chip->oob_poi[eccpos[0]];
-	uint32_t oob_pos = mtd->writesize + chip->ecc.layout->eccpos[0];
+	int ecc0pos = mtd_eccpos(mtd, 0);
+	uint8_t *oob = &chip->oob_poi[ecc0pos];
+	uint32_t oob_pos = mtd->writesize + ecc0pos;
 	int stat;
 	unsigned int max_bitflips = 0;
 
@@ -1567,7 +1566,7 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	/* Calculate ecc bytes */
 	chip->ecc.calculate(mtd, buf, ecc_calc);
 
-	memcpy(ecc_code, &chip->oob_poi[eccpos[0]], chip->ecc.total);
+	memcpy(ecc_code, &chip->oob_poi[ecc0pos], chip->ecc.total);
 
 	stat = chip->ecc.correct(mtd, buf, ecc_code, ecc_calc);
 
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index d70bbfd..25e6bf2 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1024,27 +1024,29 @@ static int onenand_transfer_auto_oob(struct mtd_info *mtd, uint8_t *buf, int col
 				int thislen)
 {
 	struct onenand_chip *this = mtd->priv;
-	struct nand_oobfree *free;
+	struct nand_oobfree free = { };
 	int readcol = column;
 	int readend = column + thislen;
 	int lastgap = 0;
-	unsigned int i;
+	unsigned int i = 0;
 	uint8_t *oob_buf = this->oob_buf;
 
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
+	for (mtd_oobfree(mtd, i++, &free); free.length;
+	     mtd_oobfree(mtd, i++, &free)) {
 		if (readcol >= lastgap)
-			readcol += free->offset - lastgap;
+			readcol += free.offset - lastgap;
 		if (readend >= lastgap)
-			readend += free->offset - lastgap;
-		lastgap = free->offset + free->length;
+			readend += free.offset - lastgap;
+		lastgap = free.offset + free.length;
 	}
 	this->read_bufferram(mtd, ONENAND_SPARERAM, oob_buf, 0, mtd->oobsize);
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
-		int free_end = free->offset + free->length;
-		if (free->offset < readend && free_end > readcol) {
-			int st = max_t(int,free->offset,readcol);
+	memset(&free, 0, sizeof(free));
+	i = 0;
+	for (mtd_oobfree(mtd, i++, &free); free.length;
+	     mtd_oobfree(mtd, i++, &free)) {
+		int free_end = free.offset + free.length;
+		if (free.offset < readend && free_end > readcol) {
+			int st = max_t(int,free.offset,readcol);
 			int ed = min_t(int,free_end,readend);
 			int n = ed - st;
 			memcpy(buf, oob_buf + st, n);
@@ -1816,26 +1818,27 @@ static int onenand_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
 static int onenand_fill_auto_oob(struct mtd_info *mtd, u_char *oob_buf,
 				  const u_char *buf, int column, int thislen)
 {
-	struct onenand_chip *this = mtd->priv;
-	struct nand_oobfree *free;
+	struct nand_oobfree free = { };
 	int writecol = column;
 	int writeend = column + thislen;
 	int lastgap = 0;
-	unsigned int i;
+	unsigned int i = 0;
 
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
+	for (mtd_oobfree(mtd, i++, &free); free.length;
+	     mtd_oobfree(mtd, i++, &free)) {
 		if (writecol >= lastgap)
-			writecol += free->offset - lastgap;
+			writecol += free.offset - lastgap;
 		if (writeend >= lastgap)
-			writeend += free->offset - lastgap;
-		lastgap = free->offset + free->length;
+			writeend += free.offset - lastgap;
+		lastgap = free.offset + free.length;
 	}
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
-		int free_end = free->offset + free->length;
-		if (free->offset < writeend && free_end > writecol) {
-			int st = max_t(int,free->offset,writecol);
+	memset(&free, 0, sizeof(free));
+	i = 0;
+	for (mtd_oobfree(mtd, i++, &free); free.length;
+	     mtd_oobfree(mtd, i++, &free)) {
+		int free_end = free.offset + free.length;
+		if (free.offset < writeend && free_end > writecol) {
+			int st = max_t(int,free.offset,writecol);
 			int ed = min_t(int,free_end,writeend);
 			int n = ed - st;
 			memcpy(oob_buf + st, buf, n);
@@ -3942,6 +3945,7 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 {
 	int i, ret;
 	struct onenand_chip *this = mtd->priv;
+	struct nand_oobfree oobfree = {};
 
 	if (!this->read_word)
 		this->read_word = onenand_readw;
@@ -4050,9 +4054,10 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	 * the out of band area
 	 */
 	mtd->oobavail = 0;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES &&
-	    this->ecclayout->oobfree[i].length; i++)
-		mtd->oobavail += this->ecclayout->oobfree[i].length;
+	i = 0;
+	for (mtd_oobfree(mtd, i++, &oobfree); oobfree.length;
+	     mtd_oobfree(mtd, i++, &oobfree))
+		mtd->oobavail += oobfree.length;
 
 	mtd->ecclayout = this->ecclayout;
 	mtd->ecc_strength = 1;
-- 
2.1.4
