From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 25 Jun 2012 18:07:45 +0800
Subject: [PATCH v11 3/4] MTD: nand: add return value for
 write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
In-Reply-To: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1340618866-28776-4-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an implemention of hardware ECC write page function which may return an
error indication.
For instance, using Atmel HW PMECC to write one page into a nand flash, the hardware
engine will compute the BCH ecc code for this page. so we need read a the
status register to theck whether the ecc code is generated.
But we cannot assume the status register always can be ready, for example,
incorrect hardware configuration or hardware issue, in such case we need
write_page() to return a error code.

Since the definition of 'write_page' function in struct nand_ecc_ctrl is 'void'.
So this patch will:
  1. add return 'int' value for 'write_page' function.
  2. to be consitent, add return 'int' value for 'write_page_raw' fuctions too.
  3. add code to test the return value, and if negative, indicate an
  error happend when write page with ECC.
  4. fix the compile warning in all impacted nand flash driver.

Note: I couldn't compile-test all of these easily, as some had ARCH dependencies.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
changes:
   remove code to print error message base on suggestion of Brian Norris.

 drivers/mtd/nand/bcm_umi_bch.c         |    6 ++++--
 drivers/mtd/nand/bf5xx_nand.c          |    6 ++++--
 drivers/mtd/nand/cafe_nand.c           |   11 ++++++++---
 drivers/mtd/nand/denali.c              |   12 +++++++-----
 drivers/mtd/nand/docg4.c               |    8 +++++---
 drivers/mtd/nand/fsl_elbc_nand.c       |    4 +++-
 drivers/mtd/nand/fsl_ifc_nand.c        |    4 +++-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    6 ++++--
 drivers/mtd/nand/nand_base.c           |   27 +++++++++++++++++++--------
 drivers/mtd/nand/pxa3xx_nand.c         |    4 +++-
 drivers/mtd/nand/sh_flctl.c            |    4 +++-
 include/linux/mtd/nand.h               |    4 ++--
 12 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/nand/bcm_umi_bch.c b/drivers/mtd/nand/bcm_umi_bch.c
index 5914bb3..c8799a0 100644
--- a/drivers/mtd/nand/bcm_umi_bch.c
+++ b/drivers/mtd/nand/bcm_umi_bch.c
@@ -23,7 +23,7 @@
 /* ---- Private Function Prototypes -------------------------------------- */
 static int bcm_umi_bch_read_page_hwecc(struct mtd_info *mtd,
 	struct nand_chip *chip, uint8_t *buf, int oob_required, int page);
-static void bcm_umi_bch_write_page_hwecc(struct mtd_info *mtd,
+static int bcm_umi_bch_write_page_hwecc(struct mtd_info *mtd,
 	struct nand_chip *chip, const uint8_t *buf, int oob_required);
 
 /* ---- Private Variables ------------------------------------------------ */
@@ -194,7 +194,7 @@ static int bcm_umi_bch_read_page_hwecc(struct mtd_info *mtd,
 *  @oob_required:	must write chip->oob_poi to OOB
 *
 ***************************************************************************/
-static void bcm_umi_bch_write_page_hwecc(struct mtd_info *mtd,
+static int bcm_umi_bch_write_page_hwecc(struct mtd_info *mtd,
 	struct nand_chip *chip, const uint8_t *buf, int oob_required)
 {
 	int sectorIdx = 0;
@@ -214,4 +214,6 @@ static void bcm_umi_bch_write_page_hwecc(struct mtd_info *mtd,
 	}
 
 	bcm_umi_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
 }
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 3f1c185..ab0caa7 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -566,11 +566,13 @@ static int bf5xx_nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip
 	return 0;
 }
 
-static void bf5xx_nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-		const uint8_t *buf, int oob_required)
+static int bf5xx_nand_write_page_raw(struct mtd_info *mtd,
+		struct nand_chip *chip,	const uint8_t *buf, int oob_required)
 {
 	bf5xx_nand_write_buf(mtd, buf, mtd->writesize);
 	bf5xx_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 41371ba..738c970 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -520,7 +520,7 @@ static struct nand_bbt_descr cafe_bbt_mirror_descr_512 = {
 };
 
 
-static void cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
+static int cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
 					  struct nand_chip *chip,
 					  const uint8_t *buf, int oob_required)
 {
@@ -531,6 +531,8 @@ static void cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
 
 	/* Set up ECC autogeneration */
 	cafe->ctl2 |= (1<<30);
+
+	return 0;
 }
 
 static int cafe_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
@@ -542,9 +544,12 @@ static int cafe_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
 
 	if (unlikely(raw))
-		chip->ecc.write_page_raw(mtd, chip, buf, oob_required);
+		status = chip->ecc.write_page_raw(mtd, chip, buf, oob_required);
 	else
-		chip->ecc.write_page(mtd, chip, buf, oob_required);
+		status = chip->ecc.write_page(mtd, chip, buf, oob_required);
+
+	if (status < 0)
+		return status;
 
 	/*
 	 * Cached progamming disabled for now, Not sure if its worth the
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 0650aaf..e706a23 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1028,7 +1028,7 @@ static void denali_setup_dma(struct denali_nand_info *denali, int op)
 
 /* writes a page. user specifies type, and this function handles the
  * configuration details. */
-static void write_page(struct mtd_info *mtd, struct nand_chip *chip,
+static int write_page(struct mtd_info *mtd, struct nand_chip *chip,
 			const uint8_t *buf, bool raw_xfer)
 {
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
@@ -1078,6 +1078,8 @@ static void write_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 	denali_enable_dma(denali, false);
 	dma_sync_single_for_cpu(denali->dev, addr, size, DMA_TO_DEVICE);
+
+	return 0;
 }
 
 /* NAND core entry points */
@@ -1086,24 +1088,24 @@ static void write_page(struct mtd_info *mtd, struct nand_chip *chip,
  * writing a page with ECC or without is similar, all the work is done
  * by write_page above.
  * */
-static void denali_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+static int denali_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 				const uint8_t *buf, int oob_required)
 {
 	/* for regular page writes, we let HW handle all the ECC
 	 * data written to the device. */
-	write_page(mtd, chip, buf, false);
+	return write_page(mtd, chip, buf, false);
 }
 
 /* This is the callback that the NAND core calls to write a page without ECC.
  * raw access is similar to ECC page writes, so all the work is done in the
  * write_page() function above.
  */
-static void denali_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
+static int denali_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 					const uint8_t *buf, int oob_required)
 {
 	/* for raw page writes, we want to disable ECC and simply write
 	   whatever data is in the buffer. */
-	write_page(mtd, chip, buf, true);
+	return write_page(mtd, chip, buf, true);
 }
 
 static int denali_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index a225e49..0f2ffd7 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -898,7 +898,7 @@ static void docg4_erase_block(struct mtd_info *mtd, int page)
 	write_nop(docptr);
 }
 
-static void write_page(struct mtd_info *mtd, struct nand_chip *nand,
+static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 		       const uint8_t *buf, bool use_ecc)
 {
 	struct docg4_priv *doc = nand->priv;
@@ -950,15 +950,17 @@ static void write_page(struct mtd_info *mtd, struct nand_chip *nand,
 	write_nop(docptr);
 	writew(0, docptr + DOC_DATAEND);
 	write_nop(docptr);
+
+	return 0;
 }
 
-static void docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip *nand,
+static int docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip *nand,
 				 const uint8_t *buf, int oob_required)
 {
 	return write_page(mtd, nand, buf, false);
 }
 
-static void docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
+static int docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
 			     const uint8_t *buf, int oob_required)
 {
 	return write_page(mtd, nand, buf, true);
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 7842938..35d731d 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -766,11 +766,13 @@ static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 /* ECC will be calculated automatically, and errors will be detected in
  * waitfunc.
  */
-static void fsl_elbc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+static int fsl_elbc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 				const uint8_t *buf, int oob_required)
 {
 	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
 }
 
 static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 9602c1b..47ba534 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -721,11 +721,13 @@ static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 /* ECC will be calculated automatically, and errors will be detected in
  * waitfunc.
  */
-static void fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+static int fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 			       const uint8_t *buf, int oob_required)
 {
 	fsl_ifc_write_buf(mtd, buf, mtd->writesize);
 	fsl_ifc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
 }
 
 static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index a05b7b4..3bda330 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -930,7 +930,7 @@ exit_nfc:
 	return ret;
 }
 
-static void gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
+static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 				const uint8_t *buf, int oob_required)
 {
 	struct gpmi_nand_data *this = chip->priv;
@@ -972,7 +972,7 @@ static void gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 				&payload_virt, &payload_phys);
 		if (ret) {
 			pr_err("Inadequate payload DMA buffer\n");
-			return;
+			return 0;
 		}
 
 		ret = send_page_prepare(this,
@@ -1002,6 +1002,8 @@ exit_auxiliary:
 				nfc_geo->payload_size,
 				payload_virt, payload_phys);
 	}
+
+	return 0;
 }
 
 /*
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index d47586c..b461ff6 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1927,12 +1927,14 @@ out:
  *
  * Not for syndrome calculating ECC controllers, which use a special oob layout.
  */
-static void nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
+static int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				const uint8_t *buf, int oob_required)
 {
 	chip->write_buf(mtd, buf, mtd->writesize);
 	if (oob_required)
 		chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
 }
 
 /**
@@ -1944,7 +1946,7 @@ static void nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
  *
  * We need a special oob layout and handling even when ECC isn't checked.
  */
-static void nand_write_page_raw_syndrome(struct mtd_info *mtd,
+static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 					struct nand_chip *chip,
 					const uint8_t *buf, int oob_required)
 {
@@ -1974,6 +1976,8 @@ static void nand_write_page_raw_syndrome(struct mtd_info *mtd,
 	size = mtd->oobsize - (oob - chip->oob_poi);
 	if (size)
 		chip->write_buf(mtd, oob, size);
+
+	return 0;
 }
 /**
  * nand_write_page_swecc - [REPLACEABLE] software ECC based page write function
@@ -1982,7 +1986,7 @@ static void nand_write_page_raw_syndrome(struct mtd_info *mtd,
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
  */
-static void nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
+static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 				  const uint8_t *buf, int oob_required)
 {
 	int i, eccsize = chip->ecc.size;
@@ -1999,7 +2003,7 @@ static void nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < chip->ecc.total; i++)
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
 
-	chip->ecc.write_page_raw(mtd, chip, buf, 1);
+	return chip->ecc.write_page_raw(mtd, chip, buf, 1);
 }
 
 /**
@@ -2009,7 +2013,7 @@ static void nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
  */
-static void nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
+static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				  const uint8_t *buf, int oob_required)
 {
 	int i, eccsize = chip->ecc.size;
@@ -2029,6 +2033,8 @@ static void nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
 
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
 }
 
 /**
@@ -2041,7 +2047,7 @@ static void nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
  * The hw generator calculates the error syndrome automatically. Therefore we
  * need a special oob layout and handling.
  */
-static void nand_write_page_syndrome(struct mtd_info *mtd,
+static int nand_write_page_syndrome(struct mtd_info *mtd,
 				    struct nand_chip *chip,
 				    const uint8_t *buf, int oob_required)
 {
@@ -2075,6 +2081,8 @@ static void nand_write_page_syndrome(struct mtd_info *mtd,
 	i = mtd->oobsize - (oob - chip->oob_poi);
 	if (i)
 		chip->write_buf(mtd, oob, i);
+
+	return 0;
 }
 
 /**
@@ -2096,9 +2104,12 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0x00, page);
 
 	if (unlikely(raw))
-		chip->ecc.write_page_raw(mtd, chip, buf, oob_required);
+		status = chip->ecc.write_page_raw(mtd, chip, buf, oob_required);
 	else
-		chip->ecc.write_page(mtd, chip, buf, oob_required);
+		status = chip->ecc.write_page(mtd, chip, buf, oob_required);
+
+	if (status < 0)
+		return status;
 
 	/*
 	 * Cached progamming disabled for now. Not sure if it's worth the
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 252aaef..86640f7 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -681,11 +681,13 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	info->state = STATE_IDLE;
 }
 
-static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
+static int pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, const uint8_t *buf, int oob_required)
 {
 	chip->write_buf(mtd, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
 }
 
 static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index aa9b8a5..0700ad9 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -365,7 +365,7 @@ static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-static void flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
+static int flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				   const uint8_t *buf, int oob_required)
 {
 	int i, eccsize = chip->ecc.size;
@@ -375,6 +375,8 @@ static void flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
 		chip->write_buf(mtd, p, eccsize);
+
+	return 0;
 }
 
 static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 57977c6..4cb6c7fe 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -361,13 +361,13 @@ struct nand_ecc_ctrl {
 			uint8_t *calc_ecc);
 	int (*read_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint8_t *buf, int oob_required, int page);
-	void (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
+	int (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			const uint8_t *buf, int oob_required);
 	int (*read_page)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint8_t *buf, int oob_required, int page);
 	int (*read_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint32_t offs, uint32_t len, uint8_t *buf);
-	void (*write_page)(struct mtd_info *mtd, struct nand_chip *chip,
+	int (*write_page)(struct mtd_info *mtd, struct nand_chip *chip,
 			const uint8_t *buf, int oob_required);
 	int (*write_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			int page);
-- 
1.7.9.5
