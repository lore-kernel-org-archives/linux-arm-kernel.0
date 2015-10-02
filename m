From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  2 Oct 2015 07:53:25 +0200
Subject: [PATCH v3] mtd: nand: pass page number to ecc->write_xxx() methods
Message-ID: <1443765205-8730-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->read_xxx() methods are all passed the page number the NAND controller
is supposed to read, but ->write_xxx() do not have such a parameter.

This is a problem if we want to properly implement data
scrambling/randomization in order to mitigate MLC sensibility to repeated
pattern: to prevent bitflips in adjacent pages in the same block we need
to avoid repeating the same pattern at the same offset in those pages,
hence the randomizer/scrambler engine need to be passed the page value
in order to adapt its seed accordingly.

Moreover, adding the page parameter to the ->write_xxx() methods add some
consistency to the current API.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
CC: Josh Wu <josh.wu@atmel.com>
CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Huang Shijie <shijie.huang@arm.com>
CC: Stefan Agner <stefan@agner.ch>
CC: devel at driverdev.osuosl.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-kernel at vger.kernel.org
---
Changes since v2:
- fixed compilation error in the gpmi driver
- compile tested all impacted drivers except the bf5xx_nand,
  fsl_elbc_nand and fsl_ifc_nand ones

Changes since v1:
- rebased on l2-mtd/master
- fixed compilation error in the docg4 driver
---
 drivers/mtd/nand/atmel_nand.c                 |  6 ++++--
 drivers/mtd/nand/bf5xx_nand.c                 |  3 ++-
 drivers/mtd/nand/brcmnand/brcmnand.c          |  4 ++--
 drivers/mtd/nand/cafe_nand.c                  |  3 ++-
 drivers/mtd/nand/denali.c                     |  5 +++--
 drivers/mtd/nand/docg4.c                      |  6 +++---
 drivers/mtd/nand/fsl_elbc_nand.c              |  4 ++--
 drivers/mtd/nand/fsl_ifc_nand.c               |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c        |  8 +++----
 drivers/mtd/nand/hisi504_nand.c               |  3 ++-
 drivers/mtd/nand/lpc32xx_mlc.c                |  3 ++-
 drivers/mtd/nand/lpc32xx_slc.c                |  5 +++--
 drivers/mtd/nand/nand_base.c                  | 31 ++++++++++++++++++---------
 drivers/mtd/nand/omap2.c                      |  3 ++-
 drivers/mtd/nand/pxa3xx_nand.c                |  3 ++-
 drivers/mtd/nand/sh_flctl.c                   |  3 ++-
 drivers/mtd/nand/sunxi_nand.c                 |  5 +++--
 drivers/mtd/nand/vf610_nfc.c                  |  2 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c |  3 ++-
 include/linux/mtd/nand.h                      |  6 +++---
 20 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 46010bd..d0f50c9 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -954,7 +954,8 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 }
 
 static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
-		struct nand_chip *chip, const uint8_t *buf, int oob_required)
+		struct nand_chip *chip, const uint8_t *buf, int oob_required,
+		int page)
 {
 	struct atmel_nand_host *host = chip->priv;
 	uint32_t *eccpos = chip->ecc.layout->eccpos;
@@ -2005,7 +2006,8 @@ static int nfc_sram_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 	if (likely(!raw))
 		/* Need to write ecc into oob */
-		status = chip->ecc.write_page(mtd, chip, buf, oob_required);
+		status = chip->ecc.write_page(mtd, chip, buf, oob_required,
+					      page);
 
 	if (status < 0)
 		return status;
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 4d8d4ba..17b3727 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -566,7 +566,8 @@ static int bf5xx_nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip
 }
 
 static int bf5xx_nand_write_page_raw(struct mtd_info *mtd,
-		struct nand_chip *chip,	const uint8_t *buf, int oob_required)
+		struct nand_chip *chip,	const uint8_t *buf, int oob_required,
+		int page)
 {
 	bf5xx_nand_write_buf(mtd, buf, mtd->writesize);
 	bf5xx_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 048e4e0..e577109 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1606,7 +1606,7 @@ out:
 }
 
 static int brcmnand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-			       const uint8_t *buf, int oob_required)
+			       const uint8_t *buf, int oob_required, int page)
 {
 	struct brcmnand_host *host = chip->priv;
 	void *oob = oob_required ? chip->oob_poi : NULL;
@@ -1617,7 +1617,7 @@ static int brcmnand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 static int brcmnand_write_page_raw(struct mtd_info *mtd,
 				   struct nand_chip *chip, const uint8_t *buf,
-				   int oob_required)
+				   int oob_required, int page)
 {
 	struct brcmnand_host *host = chip->priv;
 	void *oob = oob_required ? chip->oob_poi : NULL;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 9a0f45f..d6854be 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -516,7 +516,8 @@ static struct nand_bbt_descr cafe_bbt_mirror_descr_512 = {
 
 static int cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
 					  struct nand_chip *chip,
-					  const uint8_t *buf, int oob_required)
+					  const uint8_t *buf, int oob_required,
+					  int page)
 {
 	struct cafe_priv *cafe = mtd->priv;
 
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 43c0771..461b253 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1114,7 +1114,7 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *chip,
  * by write_page above.
  */
 static int denali_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-				const uint8_t *buf, int oob_required)
+				const uint8_t *buf, int oob_required, int page)
 {
 	/*
 	 * for regular page writes, we let HW handle all the ECC
@@ -1129,7 +1129,8 @@ static int denali_write_page(struct mtd_info *mtd, struct nand_chip *chip,
  * write_page() function above.
  */
 static int denali_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-					const uint8_t *buf, int oob_required)
+				 const uint8_t *buf, int oob_required,
+				 int page)
 {
 	/*
 	 * for raw page writes, we want to disable ECC and simply write
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index e5d7bca..a956ff7 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -977,13 +977,13 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 }
 
 static int docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip *nand,
-				 const uint8_t *buf, int oob_required)
+				const uint8_t *buf, int oob_required, int page)
 {
 	return write_page(mtd, nand, buf, false);
 }
 
 static int docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
-			     const uint8_t *buf, int oob_required)
+			     const uint8_t *buf, int oob_required, int page)
 {
 	return write_page(mtd, nand, buf, true);
 }
@@ -1113,7 +1113,7 @@ static int docg4_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 	/* write first page of block */
 	write_page_prologue(mtd, g4_addr);
-	docg4_write_page(mtd, nand, buf, 1);
+	docg4_write_page(mtd, nand, buf, 1, page);
 	ret = pageprog(mtd);
 
 	kfree(buf);
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index b812074..401664a 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -715,7 +715,7 @@ static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
  * waitfunc.
  */
 static int fsl_elbc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-				const uint8_t *buf, int oob_required)
+				const uint8_t *buf, int oob_required, int page)
 {
 	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -728,7 +728,7 @@ static int fsl_elbc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
  */
 static int fsl_elbc_write_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 				uint32_t offset, uint32_t data_len,
-				const uint8_t *buf, int oob_required)
+				const uint8_t *buf, int oob_required, int page)
 {
 	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 429142e..b2d9a03 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -772,7 +772,7 @@ static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
  * waitfunc.
  */
 static int fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-			       const uint8_t *buf, int oob_required)
+			       const uint8_t *buf, int oob_required, int page)
 {
 	fsl_ifc_write_buf(mtd, buf, mtd->writesize);
 	fsl_ifc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 1b8f350..62e68b0 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1160,7 +1160,7 @@ static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-				const uint8_t *buf, int oob_required)
+				const uint8_t *buf, int oob_required, int page)
 {
 	struct gpmi_nand_data *this = chip->priv;
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
@@ -1446,7 +1446,7 @@ static int gpmi_ecc_read_page_raw(struct mtd_info *mtd,
 static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
 				   struct nand_chip *chip,
 				   const uint8_t *buf,
-				   int oob_required)
+				   int oob_required, int page)
 {
 	struct gpmi_nand_data *this = chip->priv;
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
@@ -1533,7 +1533,7 @@ static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0, page);
 
-	return gpmi_ecc_write_page_raw(mtd, chip, NULL, 1);
+	return gpmi_ecc_write_page_raw(mtd, chip, NULL, 1, page);
 }
 
 static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
@@ -1717,7 +1717,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 		/* Write the first page of the current stride. */
 		dev_dbg(dev, "Writing an NCB fingerprint in page 0x%x\n", page);
 		chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
-		chip->ecc.write_page_raw(mtd, chip, buffer, 0);
+		chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
 		chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
 
 		/* Wait for the write to finish. */
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 8dcc7b8..04b9c3d 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -590,7 +590,8 @@ static int hisi_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 static int hisi_nand_write_page_hwecc(struct mtd_info *mtd,
-		struct nand_chip *chip, const uint8_t *buf, int oob_required)
+		struct nand_chip *chip, const uint8_t *buf, int oob_required,
+		int page)
 {
 	chip->write_buf(mtd, buf, mtd->writesize);
 	if (oob_required)
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 79c3b78..510cb49 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -495,7 +495,8 @@ static int lpc32xx_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 static int lpc32xx_write_page_lowlevel(struct mtd_info *mtd,
 				       struct nand_chip *chip,
-				       const uint8_t *buf, int oob_required)
+				       const uint8_t *buf, int oob_required,
+				       int page)
 {
 	struct lpc32xx_nand_host *host = chip->priv;
 	const uint8_t *oobbuf = chip->oob_poi;
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index abfec13..1d80995 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -660,7 +660,8 @@ static int lpc32xx_nand_read_page_raw_syndrome(struct mtd_info *mtd,
  */
 static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 					    struct nand_chip *chip,
-					    const uint8_t *buf, int oob_required)
+					    const uint8_t *buf,
+					    int oob_required, int page)
 {
 	struct lpc32xx_nand_host *host = chip->priv;
 	uint8_t *pb = chip->oob_poi + chip->ecc.layout->eccpos[0];
@@ -689,7 +690,7 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
 						struct nand_chip *chip,
 						const uint8_t *buf,
-						int oob_required)
+						int oob_required, int page)
 {
 	/* Raw writes can just use the FIFO interface */
 	chip->write_buf(mtd, buf, chip->ecc.size * chip->ecc.steps);
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index a8230b1..d87c7d0 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2155,11 +2155,12 @@ out:
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
  *
  * Not for syndrome calculating ECC controllers, which use a special oob layout.
  */
 static int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				const uint8_t *buf, int oob_required)
+			       const uint8_t *buf, int oob_required, int page)
 {
 	chip->write_buf(mtd, buf, mtd->writesize);
 	if (oob_required)
@@ -2174,12 +2175,14 @@ static int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
  *
  * We need a special oob layout and handling even when ECC isn't checked.
  */
 static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 					struct nand_chip *chip,
-					const uint8_t *buf, int oob_required)
+					const uint8_t *buf, int oob_required,
+					int page)
 {
 	int eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
@@ -2216,9 +2219,11 @@ static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
  */
 static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
-				  const uint8_t *buf, int oob_required)
+				 const uint8_t *buf, int oob_required,
+				 int page)
 {
 	int i, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
@@ -2234,7 +2239,7 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < chip->ecc.total; i++)
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
 
-	return chip->ecc.write_page_raw(mtd, chip, buf, 1);
+	return chip->ecc.write_page_raw(mtd, chip, buf, 1, page);
 }
 
 /**
@@ -2243,9 +2248,11 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
  */
 static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				  const uint8_t *buf, int oob_required)
+				  const uint8_t *buf, int oob_required,
+				  int page)
 {
 	int i, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
@@ -2277,11 +2284,12 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
  * @data_len:	data length
  * @buf:	data buffer
  * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
  */
 static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 				struct nand_chip *chip, uint32_t offset,
 				uint32_t data_len, const uint8_t *buf,
-				int oob_required)
+				int oob_required, int page)
 {
 	uint8_t *oob_buf  = chip->oob_poi;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
@@ -2336,13 +2344,15 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
  *
  * The hw generator calculates the error syndrome automatically. Therefore we
  * need a special oob layout and handling.
  */
 static int nand_write_page_syndrome(struct mtd_info *mtd,
 				    struct nand_chip *chip,
-				    const uint8_t *buf, int oob_required)
+				    const uint8_t *buf, int oob_required,
+				    int page)
 {
 	int i, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
@@ -2406,12 +2416,13 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 	if (unlikely(raw))
 		status = chip->ecc.write_page_raw(mtd, chip, buf,
-							oob_required);
+						  oob_required, page);
 	else if (subpage)
 		status = chip->ecc.write_subpage(mtd, chip, offset, data_len,
-							 buf, oob_required);
+						 buf, oob_required, page);
 	else
-		status = chip->ecc.write_page(mtd, chip, buf, oob_required);
+		status = chip->ecc.write_page(mtd, chip, buf, oob_required,
+					      page);
 
 	if (status < 0)
 		return status;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 60fa899..b85696f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1500,11 +1500,12 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
  * @chip:		nand chip info structure
  * @buf:		data buffer
  * @oob_required:	must write chip->oob_poi to OOB
+ * @page:		page
  *
  * Custom write page method evolved to support multi sector writing in one shot
  */
 static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
-				  const uint8_t *buf, int oob_required)
+			       const uint8_t *buf, int oob_required, int page)
 {
 	int i;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 232c707..5ff5d39 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1160,7 +1160,8 @@ static void nand_cmdfunc_extended(struct mtd_info *mtd,
 }
 
 static int pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
-		struct nand_chip *chip, const uint8_t *buf, int oob_required)
+		struct nand_chip *chip, const uint8_t *buf, int oob_required,
+		int page)
 {
 	chip->write_buf(mtd, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index c3ce81c..f6c059d 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -569,7 +569,8 @@ static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 static int flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				   const uint8_t *buf, int oob_required)
+				  const uint8_t *buf, int oob_required,
+				  int page)
 {
 	chip->write_buf(mtd, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index dc44435..45f9cf6 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -630,7 +630,8 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 
 static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 				       struct nand_chip *chip,
-				       const uint8_t *buf, int oob_required)
+				       const uint8_t *buf, int oob_required,
+				       int page)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -764,7 +765,7 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 						struct nand_chip *chip,
 						const uint8_t *buf,
-						int oob_required)
+						int oob_required, int page)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index ae1f84e..d275691 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -612,7 +612,7 @@ static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 static int vf610_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-			       const uint8_t *buf, int oob_required)
+				const uint8_t *buf, int oob_required, int page)
 {
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index ad30ce4..536c723 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -612,7 +612,8 @@ static int spinand_erase_block(struct spi_device *spi_nand, u16 block_id)
 
 #ifdef CONFIG_MTD_SPINAND_ONDIEECC
 static int spinand_write_page_hwecc(struct mtd_info *mtd,
-		struct nand_chip *chip, const uint8_t *buf, int oob_required)
+		struct nand_chip *chip, const uint8_t *buf, int oob_required,
+		int page)
 {
 	const uint8_t *p = buf;
 	int eccsize = chip->ecc.size;
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 50e1f94..5a9d1d4 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -504,16 +504,16 @@ struct nand_ecc_ctrl {
 	int (*read_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint8_t *buf, int oob_required, int page);
 	int (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-			const uint8_t *buf, int oob_required);
+			const uint8_t *buf, int oob_required, int page);
 	int (*read_page)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint8_t *buf, int oob_required, int page);
 	int (*read_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint32_t offs, uint32_t len, uint8_t *buf, int page);
 	int (*write_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint32_t offset, uint32_t data_len,
-			const uint8_t *data_buf, int oob_required);
+			const uint8_t *data_buf, int oob_required, int page);
 	int (*write_page)(struct mtd_info *mtd, struct nand_chip *chip,
-			const uint8_t *buf, int oob_required);
+			const uint8_t *buf, int oob_required, int page);
 	int (*write_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			int page);
 	int (*read_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.1.4
