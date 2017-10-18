From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed, 18 Oct 2017 16:36:19 +0200
Subject: [RFC 02/12] mtd: nand: force drivers to explicitly send READ/PROG
 commands
In-Reply-To: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
Message-ID: <20171018143629.29302-3-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The core currently send the READ0 and SEQIN+PAGEPROG commands in
nand_do_read/write_ops(). This is inconsistent with
->read/write_oob[_raw]() hooks behavior which are expected to send
these commands.

There's already a flag (NAND_ECC_CUSTOM_PAGE_ACCESS) to inform the core
that a specific controller wants to send the READ/SEQIN+PAGEPROG
commands on its own, but it's an opt-in flag, and existing drivers are
unlikely to be updated to pass it.

Moreover, some controllers cannot dissociate the READ/PAGEPROG commands
from the associated data transfer and ECC engine activation, and
developers have to hack things in their ->cmdfunc() implementation to
handle such complex cases, or have to accept the perf penalty of sending
twice the same command.
To address this problem we are planning on adding a new interface which
is passed all information about a NAND operation (including the amount
of data to transfer) and replacing all calls to ->cmdfunc() to calls to
this new ->exec_op() hook. But, in order to do that, we need to have all
->cmdfunc() calls placed near their associated ->read/write_buf/byte()
calls.

Modify the core and relevant drivers to make NAND_ECC_CUSTOM_PAGE_ACCESS
the default case, and remove this flag.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
[miquel.raynal at free-electrons.com: rebased and fixed some conflicts]
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/mtd/nand/atmel/nand-controller.c      |  7 ++-
 drivers/mtd/nand/bf5xx_nand.c                 |  6 ++-
 drivers/mtd/nand/brcmnand/brcmnand.c          | 13 +++--
 drivers/mtd/nand/cafe_nand.c                  |  6 +--
 drivers/mtd/nand/denali.c                     | 14 +++++-
 drivers/mtd/nand/docg4.c                      | 12 +++--
 drivers/mtd/nand/fsl_elbc_nand.c              |  6 +--
 drivers/mtd/nand/fsl_ifc_nand.c               |  6 +--
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c        | 30 ++++++------
 drivers/mtd/nand/hisi504_nand.c               |  6 +--
 drivers/mtd/nand/lpc32xx_mlc.c                |  5 +-
 drivers/mtd/nand/lpc32xx_slc.c                | 11 +++--
 drivers/mtd/nand/mtk_nand.c                   | 10 ++--
 drivers/mtd/nand/nand_base.c                  | 68 +++++++++------------------
 drivers/mtd/nand/nand_micron.c                |  1 -
 drivers/mtd/nand/sh_flctl.c                   |  6 +--
 drivers/mtd/nand/sunxi_nand.c                 | 34 +++++++++-----
 drivers/mtd/nand/tango_nand.c                 |  1 -
 drivers/mtd/nand/vf610_nfc.c                  |  6 +--
 drivers/staging/mt29f_spinand/mt29f_spinand.c |  7 ++-
 include/linux/mtd/rawnand.h                   | 11 -----
 21 files changed, 142 insertions(+), 124 deletions(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index 0b2c82727b24..6add993ea1e0 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -841,6 +841,8 @@ static int atmel_nand_pmecc_write_pg(struct nand_chip *chip, const u8 *buf,
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	int ret;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	ret = atmel_nand_pmecc_enable(chip, NAND_ECC_WRITE, raw);
 	if (ret)
 		return ret;
@@ -857,7 +859,7 @@ static int atmel_nand_pmecc_write_pg(struct nand_chip *chip, const u8 *buf,
 
 	atmel_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
@@ -881,6 +883,8 @@ static int atmel_nand_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	ret = atmel_nand_pmecc_enable(chip, NAND_ECC_READ, raw);
 	if (ret)
 		return ret;
@@ -1178,7 +1182,6 @@ static int atmel_hsmc_nand_ecc_init(struct atmel_nand *nand)
 	chip->ecc.write_page = atmel_hsmc_nand_pmecc_write_page;
 	chip->ecc.read_page_raw = atmel_hsmc_nand_pmecc_read_page_raw;
 	chip->ecc.write_page_raw = atmel_hsmc_nand_pmecc_write_page_raw;
-	chip->ecc.options |= NAND_ECC_CUSTOM_PAGE_ACCESS;
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 5655dca6ce43..87bbd177b3e5 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -572,6 +572,8 @@ static void bf5xx_nand_dma_write_buf(struct mtd_info *mtd,
 static int bf5xx_nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 		uint8_t *buf, int oob_required, int page)
 {
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	bf5xx_nand_read_buf(mtd, buf, mtd->writesize);
 	bf5xx_nand_read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -582,10 +584,10 @@ static int bf5xx_nand_write_page_raw(struct mtd_info *mtd,
 		struct nand_chip *chip,	const uint8_t *buf, int oob_required,
 		int page)
 {
-	bf5xx_nand_write_buf(mtd, buf, mtd->writesize);
+	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	bf5xx_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 /*
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 3f441096a14c..e6879d4d53ca 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1689,7 +1689,6 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	sas = mtd->oobsize / chip->ecc.steps;
 
 	/* read without ecc for verification */
-	nand_read_page_op(chip, page, 0, NULL, 0);
 	ret = chip->ecc.read_page_raw(mtd, chip, buf, true, page);
 	if (ret)
 		return ret;
@@ -1793,6 +1792,8 @@ static int brcmnand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	u8 *oob = oob_required ? (u8 *)chip->oob_poi : NULL;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	return brcmnand_read(mtd, chip, host->last_addr,
 			mtd->writesize >> FC_SHIFT, (u32 *)buf, oob);
 }
@@ -1804,6 +1805,8 @@ static int brcmnand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	u8 *oob = oob_required ? (u8 *)chip->oob_poi : NULL;
 	int ret;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	brcmnand_set_ecc_enabled(host, 0);
 	ret = brcmnand_read(mtd, chip, host->last_addr,
 			mtd->writesize >> FC_SHIFT, (u32 *)buf, oob);
@@ -1909,8 +1912,10 @@ static int brcmnand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	void *oob = oob_required ? chip->oob_poi : NULL;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	brcmnand_write(mtd, chip, host->last_addr, (const u32 *)buf, oob);
-	return 0;
+
+	return nand_prog_page_end_op(chip);
 }
 
 static int brcmnand_write_page_raw(struct mtd_info *mtd,
@@ -1920,10 +1925,12 @@ static int brcmnand_write_page_raw(struct mtd_info *mtd,
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	void *oob = oob_required ? chip->oob_poi : NULL;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	brcmnand_set_ecc_enabled(host, 0);
 	brcmnand_write(mtd, chip, host->last_addr, (const u32 *)buf, oob);
 	brcmnand_set_ecc_enabled(host, 1);
-	return 0;
+
+	return nand_prog_page_end_op(chip);
 }
 
 static int brcmnand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 95c2cfa68b66..de36762e3058 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -383,7 +383,7 @@ static int cafe_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 		     cafe_readl(cafe, NAND_ECC_RESULT),
 		     cafe_readl(cafe, NAND_ECC_SYN01));
 
-	chip->read_buf(mtd, buf, mtd->writesize);
+	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
 	if (checkecc && cafe_readl(cafe, NAND_ECC_RESULT) & (1<<18)) {
@@ -541,13 +541,13 @@ static int cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
 {
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
-	chip->write_buf(mtd, buf, mtd->writesize);
+	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
 	/* Set up ECC autogeneration */
 	cafe->ctl2 |= (1<<30);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int cafe_nand_block_bad(struct mtd_info *mtd, loff_t ofs)
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index f90f93a8fb08..e5f38359f6df 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -550,11 +550,14 @@ static int denali_pio_read(struct denali_nand_info *denali, void *buf,
 static int denali_pio_write(struct denali_nand_info *denali,
 			    const void *buf, size_t size, int page, int raw)
 {
+	struct nand_chip *chip = &denali->nand;
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
 	const uint32_t *buf32 = (uint32_t *)buf;
 	uint32_t irq_status;
 	int i;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	denali_reset_irq(denali);
 
 	for (i = 0; i < size / 4; i++)
@@ -580,6 +583,7 @@ static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
 static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 			   size_t size, int page, int raw, int write)
 {
+	struct nand_chip *chip = &denali->nand;
 	dma_addr_t dma_addr;
 	uint32_t irq_mask, irq_status, ecc_err_mask;
 	enum dma_data_direction dir = write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
@@ -625,7 +629,10 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 	if (irq_status & INTR__ERASED_PAGE)
 		memset(buf, 0xff, size);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return nand_prog_page_end_op(chip);
 }
 
 static int denali_data_xfer(struct denali_nand_info *denali, void *buf,
@@ -790,6 +797,8 @@ static int denali_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	int status;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	denali_reset_irq(denali);
 
 	denali_oob_xfer(mtd, chip, page, 1);
@@ -846,6 +855,8 @@ static int denali_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	size_t size = writesize + oobsize;
 	int i, pos, len;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	/*
 	 * Fill the buffer with 0xff first except the full page transfer.
 	 * This simplifies the logic.
@@ -1359,7 +1370,6 @@ int denali_init(struct denali_nand_info *denali)
 		chip->read_buf = denali_read_buf;
 		chip->write_buf = denali_write_buf;
 	}
-	chip->ecc.options |= NAND_ECC_CUSTOM_PAGE_ACCESS;
 	chip->ecc.read_page = denali_read_page;
 	chip->ecc.read_page_raw = denali_read_page_raw;
 	chip->ecc.write_page = denali_write_page;
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index 45c01b4b34c7..156fdf683b2f 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -785,6 +785,8 @@ static int read_page(struct mtd_info *mtd, struct nand_chip *nand,
 
 	dev_dbg(doc->dev, "%s: page %08x\n", __func__, page);
 
+	nand_read_page_op(nand, page, 0, NULL, 0);
+
 	writew(DOC_ECCCONF0_READ_MODE |
 	       DOC_ECCCONF0_ECC_ENABLE |
 	       DOC_ECCCONF0_UNKNOWN |
@@ -948,7 +950,7 @@ static int docg4_erase_block(struct mtd_info *mtd, int page)
 }
 
 static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
-		       const uint8_t *buf, bool use_ecc)
+		      const uint8_t *buf, int page, bool use_ecc)
 {
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
@@ -956,6 +958,8 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 
 	dev_dbg(doc->dev, "%s...\n", __func__);
 
+	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+
 	writew(DOC_ECCCONF0_ECC_ENABLE |
 	       DOC_ECCCONF0_UNKNOWN |
 	       DOCG4_BCH_SIZE,
@@ -1000,19 +1004,19 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 	writew(0, docptr + DOC_DATAEND);
 	write_nop(docptr);
 
-	return 0;
+	return nand_prog_page_end_op(nand);
 }
 
 static int docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip *nand,
 				const uint8_t *buf, int oob_required, int page)
 {
-	return write_page(mtd, nand, buf, false);
+	return write_page(mtd, nand, buf, page, false);
 }
 
 static int docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
 			     const uint8_t *buf, int oob_required, int page)
 {
-	return write_page(mtd, nand, buf, true);
+	return write_page(mtd, nand, buf, page, true);
 }
 
 static int docg4_write_oob(struct mtd_info *mtd, struct nand_chip *nand,
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 17db2f90aa2c..a24c308a0b8a 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -713,7 +713,7 @@ static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
 
-	fsl_elbc_read_buf(mtd, buf, mtd->writesize);
+	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
 		fsl_elbc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -729,10 +729,10 @@ static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 static int fsl_elbc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 				const uint8_t *buf, int oob_required, int page)
 {
-	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
+	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 /* ECC will be calculated automatically, and errors will be detected in
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 9e03bac7f34c..857038fe874f 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -688,7 +688,7 @@ static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_nand_ctrl *nctrl = ifc_nand_ctrl;
 
-	fsl_ifc_read_buf(mtd, buf, mtd->writesize);
+	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
 		fsl_ifc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -711,10 +711,10 @@ static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 static int fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 			       const uint8_t *buf, int oob_required, int page)
 {
-	fsl_ifc_write_buf(mtd, buf, mtd->writesize);
+	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	fsl_ifc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index c8ceaecd8065..3f2b903158c1 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1043,6 +1043,8 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	unsigned int  max_bitflips = 0;
 	int           ret;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	dev_dbg(this->dev, "page number is : %d\n", page);
 	ret = read_page_prepare(this, buf, nfc_geo->payload_size,
 					this->payload_virt, this->payload_phys,
@@ -1220,12 +1222,13 @@ static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	meta = geo->metadata_size;
 	if (first) {
 		col = meta + (size + ecc_parity_size) * first;
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, col, -1);
 
 		meta = 0;
 		buf = buf + first * size;
 	}
 
+	nand_read_page_op(chip, page, col, NULL, 0);
+
 	/* Save the old environment */
 	r1_old = r1_new = readl(bch_regs + HW_BCH_FLASH0LAYOUT0);
 	r2_old = r2_new = readl(bch_regs + HW_BCH_FLASH0LAYOUT1);
@@ -1277,6 +1280,9 @@ static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	int        ret;
 
 	dev_dbg(this->dev, "ecc write page.\n");
+
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	if (this->swap_block_mark) {
 		/*
 		 * If control arrives here, we're doing block mark swapping.
@@ -1338,7 +1344,10 @@ static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 				payload_virt, payload_phys);
 	}
 
-	return 0;
+	if (ret)
+		return ret;
+
+	return nand_prog_page_end_op(chip);
 }
 
 /*
@@ -1472,8 +1481,8 @@ static int gpmi_ecc_read_page_raw(struct mtd_info *mtd,
 	uint8_t *oob = chip->oob_poi;
 	int step;
 
-	chip->read_buf(mtd, tmp_buf,
-		       mtd->writesize + mtd->oobsize);
+	nand_read_page_op(chip, page, 0, tmp_buf,
+			  mtd->writesize + mtd->oobsize);
 
 	/*
 	 * If required, swap the bad block marker and the data stored in the
@@ -1617,24 +1626,19 @@ static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
 		tmp_buf[mtd->writesize] = swap;
 	}
 
-	chip->write_buf(mtd, tmp_buf, mtd->writesize + mtd->oobsize);
-
-	return 0;
+	return nand_prog_page_op(chip, page, 0, tmp_buf,
+				 mtd->writesize + mtd->oobsize);
 }
 
 static int gpmi_ecc_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				 int page)
 {
-	nand_read_page_op(chip, page, 0, NULL, 0);
-
 	return gpmi_ecc_read_page_raw(mtd, chip, NULL, 1, page);
 }
 
 static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
 				 int page)
 {
-	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-
 	return gpmi_ecc_write_page_raw(mtd, chip, NULL, 1, page);
 }
 
@@ -1806,9 +1810,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 		/* Write the first page of the current stride. */
 		dev_dbg(dev, "Writing an NCB fingerprint in page 0x%x\n", page);
 
-		nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-		chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
-		status = nand_prog_page_end_op(chip);
+		status = chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
 		if (status)
 			dev_err(dev, "[%s] Write failed.\n", __func__);
 	}
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 184d765c8bbe..cb862793ab6d 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -544,7 +544,7 @@ static int hisi_nand_read_page_hwecc(struct mtd_info *mtd,
 	int max_bitflips = 0, stat = 0, stat_max = 0, status_ecc;
 	int stat_1, stat_2;
 
-	chip->read_buf(mtd, buf, mtd->writesize);
+	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
 	/* errors which can not be corrected by ECC */
@@ -589,11 +589,11 @@ static int hisi_nand_write_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, const uint8_t *buf, int oob_required,
 		int page)
 {
-	chip->write_buf(mtd, buf, mtd->writesize);
+	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
 		chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static void hisi_nfc_host_init(struct hinfc_host *host)
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 0723ded232ff..fcab1900a764 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -522,6 +522,8 @@ static int lpc32xx_write_page_lowlevel(struct mtd_info *mtd,
 		memcpy(dma_buf, buf, mtd->writesize);
 	}
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	for (i = 0; i < host->mlcsubpages; i++) {
 		/* Start Encode */
 		writeb(0x00, MLC_ECC_ENC_REG(host->io_base));
@@ -550,7 +552,8 @@ static int lpc32xx_write_page_lowlevel(struct mtd_info *mtd,
 		/* Wait for Controller Ready */
 		lpc32xx_waitfunc_controller(mtd, chip);
 	}
-	return 0;
+
+	return nand_prog_page_end_op(chip);
 }
 
 static int lpc32xx_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 2b96c281b1a2..5f7cc6da0a7f 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -686,6 +686,8 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 	uint8_t *pb;
 	int error;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	/* Write data, calculate ECC on outbound data */
 	error = lpc32xx_xfer(mtd, (uint8_t *)buf, chip->ecc.steps, 0);
 	if (error)
@@ -704,7 +706,8 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 
 	/* Write ECC data to device */
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
-	return 0;
+
+	return nand_prog_page_end_op(chip);
 }
 
 /*
@@ -717,9 +720,11 @@ static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
 						int oob_required, int page)
 {
 	/* Raw writes can just use the FIFO interface */
-	chip->write_buf(mtd, buf, chip->ecc.size * chip->ecc.steps);
+	nand_prog_page_begin_op(chip, page, 0, buf,
+				chip->ecc.size * chip->ecc.steps);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
-	return 0;
+
+	return nand_prog_page_end_op(chip);
 }
 
 static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
index 1a3fcb65f478..005dabfc7f37 100644
--- a/drivers/mtd/nand/mtk_nand.c
+++ b/drivers/mtd/nand/mtk_nand.c
@@ -761,6 +761,8 @@ static int mtk_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	u32 reg;
 	int ret;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	if (!raw) {
 		/* OOB => FDM: from register,  ECC: from HW */
 		reg = nfi_readw(nfc, NFI_CNFG) | CNFG_AUTO_FMT_EN;
@@ -794,7 +796,10 @@ static int mtk_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	if (!raw)
 		mtk_ecc_disable(nfc->ecc);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return nand_prog_page_end_op(chip);
 }
 
 static int mtk_nfc_write_page_hwecc(struct mtd_info *mtd,
@@ -889,8 +894,7 @@ static int mtk_nfc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	len = sectors * chip->ecc.size + (raw ? sectors * spare : 0);
 	buf = bufpoi + start * chip->ecc.size;
 
-	if (column != 0)
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, column, -1);
+	nand_read_page_op(chip, page, column, NULL, 0);
 
 	addr = dma_map_single(nfc->dev, buf, len, DMA_FROM_DEVICE);
 	rc = dma_mapping_error(nfc->dev, addr);
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index f7dd7d5a84b3..318595c29053 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1908,7 +1908,7 @@ int nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int ret;
 
-	ret = nand_read_data_op(chip, buf, mtd->writesize, false);
+	ret = nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (ret)
 		return ret;
 
@@ -1942,6 +1942,10 @@ static int nand_read_page_raw_syndrome(struct mtd_info *mtd,
 	uint8_t *oob = chip->oob_poi;
 	int steps, size, ret;
 
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
 	for (steps = chip->ecc.steps; steps > 0; steps--) {
 		ret = nand_read_data_op(chip, buf, eccsize, false);
 		if (ret)
@@ -2064,11 +2068,10 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 
 	data_col_addr = start_step * chip->ecc.size;
 	/* If we read not a page aligned data */
-	if (data_col_addr != 0)
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, data_col_addr, -1);
-
 	p = bufpoi + data_col_addr;
-	nand_read_data_op(chip, p, datafrag_len, false);
+	ret = nand_read_page_op(chip, page, data_col_addr, p, datafrag_len);
+	if (ret)
+		return ret;
 
 	/* Calculate ECC */
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size)
@@ -2164,6 +2167,10 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	uint8_t *ecc_code = chip->buffers->ecccode;
 	unsigned int max_bitflips = 0;
 
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		chip->ecc.hwctl(mtd, NAND_ECC_READ);
 
@@ -2299,6 +2306,10 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 	uint8_t *oob = chip->oob_poi;
 	unsigned int max_bitflips = 0;
 
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
@@ -2481,9 +2492,6 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 						 __func__, buf);
 
 read_retry:
-			if (nand_standard_page_accessors(&chip->ecc))
-				nand_read_page_op(chip, page, 0, NULL, 0);
-
 			/*
 			 * Now read the page into the buffer.  Absent an error,
 			 * the read methods return max bitflips per ecc step.
@@ -2931,7 +2939,7 @@ int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int ret;
 
-	ret = nand_write_data_op(chip, buf, mtd->writesize, false);
+	ret = nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	if (ret)
 		return ret;
 
@@ -2942,7 +2950,7 @@ int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 			return ret;
 	}
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 EXPORT_SYMBOL(nand_write_page_raw);
 
@@ -2966,6 +2974,10 @@ static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 	uint8_t *oob = chip->oob_poi;
 	int steps, size, ret;
 
+	ret = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
 	for (steps = chip->ecc.steps; steps > 0; steps--) {
 		ret = nand_write_data_op(chip, buf, eccsize, false);
 		if (ret)
@@ -3005,7 +3017,7 @@ static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 			return ret;
 	}
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 /**
  * nand_write_page_swecc - [REPLACEABLE] software ECC based page write function
@@ -3236,12 +3248,6 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	else
 		subpage = 0;
 
-	if (nand_standard_page_accessors(&chip->ecc)) {
-		status = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-		if (status)
-			return status;
-	}
-
 	if (unlikely(raw))
 		status = chip->ecc.write_page_raw(mtd, chip, buf,
 						  oob_required, page);
@@ -3255,9 +3261,6 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	if (status < 0)
 		return status;
 
-	if (nand_standard_page_accessors(&chip->ecc))
-		return nand_prog_page_end_op(chip);
-
 	return 0;
 }
 
@@ -5235,26 +5238,6 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
 	return corr >= ds_corr && ecc->strength >= chip->ecc_strength_ds;
 }
 
-static bool invalid_ecc_page_accessors(struct nand_chip *chip)
-{
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-
-	if (nand_standard_page_accessors(ecc))
-		return false;
-
-	/*
-	 * NAND_ECC_CUSTOM_PAGE_ACCESS flag is set, make sure the NAND
-	 * controller driver implements all the page accessors because
-	 * default helpers are not suitable when the core does not
-	 * send the READ0/PAGEPROG commands.
-	 */
-	return (!ecc->read_page || !ecc->write_page ||
-		!ecc->read_page_raw || !ecc->write_page_raw ||
-		(NAND_HAS_SUBPAGE_READ(chip) && !ecc->read_subpage) ||
-		(NAND_HAS_SUBPAGE_WRITE(chip) && !ecc->write_subpage &&
-		 ecc->hwctl && ecc->calculate));
-}
-
 /**
  * nand_scan_tail - [NAND Interface] Scan for the NAND device
  * @mtd: MTD device structure
@@ -5276,11 +5259,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 		return -EINVAL;
 	}
 
-	if (invalid_ecc_page_accessors(chip)) {
-		pr_err("Invalid ECC page accessors setup\n");
-		return -EINVAL;
-	}
-
 	if (!(chip->options & NAND_OWN_BUFFERS)) {
 		nbuf = kzalloc(sizeof(*nbuf), GFP_KERNEL);
 		if (!nbuf)
diff --git a/drivers/mtd/nand/nand_micron.c b/drivers/mtd/nand/nand_micron.c
index 3934539a7468..543352380ffa 100644
--- a/drivers/mtd/nand/nand_micron.c
+++ b/drivers/mtd/nand/nand_micron.c
@@ -272,7 +272,6 @@ static int micron_nand_init(struct nand_chip *chip)
 			return -EINVAL;
 		}
 
-		chip->ecc.options = NAND_ECC_CUSTOM_PAGE_ACCESS;
 		chip->ecc.bytes = 8;
 		chip->ecc.size = 512;
 		chip->ecc.strength = 4;
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 3c5008a4f5f3..c4e7755448e6 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -614,7 +614,7 @@ static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_va
 static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	chip->read_buf(mtd, buf, mtd->writesize);
+	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
 		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 	return 0;
@@ -624,9 +624,9 @@ static int flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				  const uint8_t *buf, int oob_required,
 				  int page)
 {
-	chip->write_buf(mtd, buf, mtd->writesize);
+	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 230d037d05d2..2354410d8c48 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1245,6 +1245,8 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	int ret, i, cur_off = 0;
 	bool raw_mode = false;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
@@ -1278,14 +1280,14 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct mtd_info *mtd,
 {
 	int ret;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(mtd, buf, oob_required, page,
 					       chip->ecc.steps);
 	if (ret >= 0)
 		return ret;
 
 	/* Fallback to PIO mode */
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, 0, -1);
-
 	return sunxi_nfc_hw_ecc_read_page(mtd, chip, buf, oob_required, page);
 }
 
@@ -1298,6 +1300,8 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
 	int ret, i, cur_off = 0;
 	unsigned int max_bitflips = 0;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = data_offs / ecc->size;
@@ -1329,13 +1333,13 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct mtd_info *mtd,
 	int nchunks = DIV_ROUND_UP(data_offs + readlen, chip->ecc.size);
 	int ret;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	ret = sunxi_nfc_hw_ecc_read_chunks_dma(mtd, buf, false, page, nchunks);
 	if (ret >= 0)
 		return ret;
 
 	/* Fallback to PIO mode */
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, 0, -1);
-
 	return sunxi_nfc_hw_ecc_read_subpage(mtd, chip, data_offs, readlen,
 					     buf, page);
 }
@@ -1348,6 +1352,8 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
@@ -1369,7 +1375,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
@@ -1381,6 +1387,8 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = data_offs / ecc->size;
@@ -1399,7 +1407,7 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
@@ -1429,6 +1437,8 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
 		sunxi_nfc_hw_ecc_set_prot_oob_bytes(mtd, oob, i, !i, page);
 	}
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	sunxi_nfc_hw_ecc_enable(mtd);
 	sunxi_nfc_randomizer_config(mtd, page, false);
 	sunxi_nfc_randomizer_enable(mtd);
@@ -1459,7 +1469,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
 		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi,
 						 NULL, page);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 
 pio_fallback:
 	return sunxi_nfc_hw_ecc_write_page(mtd, chip, buf, oob_required, page);
@@ -1475,6 +1485,8 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 	int ret, i, cur_off = 0;
 	bool raw_mode = false;
 
+	nand_read_page_op(chip, page, 0, NULL, 0);
+
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
@@ -1511,6 +1523,8 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
@@ -1532,15 +1546,13 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 
 	sunxi_nfc_hw_ecc_disable(mtd);
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static int sunxi_nfc_hw_common_ecc_read_oob(struct mtd_info *mtd,
 					    struct nand_chip *chip,
 					    int page)
 {
-	nand_read_page_op(chip, page, 0, NULL, 0);
-
 	chip->pagebuf = -1;
 
 	return chip->ecc.read_page(mtd, chip, chip->buffers->databuf, 1, page);
@@ -1552,8 +1564,6 @@ static int sunxi_nfc_hw_common_ecc_write_oob(struct mtd_info *mtd,
 {
 	int ret;
 
-	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-
 	chip->pagebuf = -1;
 
 	memset(chip->buffers->databuf, 0xff, mtd->writesize);
diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index 97a300b46b1d..c5bee00b7f5e 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -580,7 +580,6 @@ static int chip_init(struct device *dev, struct device_node *np)
 	ecc->write_page = tango_write_page;
 	ecc->read_oob = tango_read_oob;
 	ecc->write_oob = tango_write_oob;
-	ecc->options = NAND_ECC_CUSTOM_PAGE_ACCESS;
 
 	err = nand_scan_tail(mtd);
 	if (err)
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 8037d4b48a05..80d31a58e558 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -560,7 +560,7 @@ static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	int eccsize = chip->ecc.size;
 	int stat;
 
-	vf610_nfc_read_buf(mtd, buf, eccsize);
+	nand_read_page_op(chip, page, 0, buf, eccsize);
 	if (oob_required)
 		vf610_nfc_read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -580,7 +580,7 @@ static int vf610_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 
-	vf610_nfc_write_buf(mtd, buf, mtd->writesize);
+	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
 		vf610_nfc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -588,7 +588,7 @@ static int vf610_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	nfc->use_hw_ecc = true;
 	nfc->write_sz = mtd->writesize + mtd->oobsize;
 
-	return 0;
+	return nand_prog_page_end_op(chip);
 }
 
 static const struct of_device_id vf610_nfc_dt_ids[] = {
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 87595c594b12..e396075dd508 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -636,9 +636,12 @@ static int spinand_write_page_hwecc(struct mtd_info *mtd,
 	int eccsize = chip->ecc.size;
 	int eccsteps = chip->ecc.steps;
 
+	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+
 	enable_hw_ecc = 1;
 	chip->write_buf(mtd, p, eccsize * eccsteps);
-	return 0;
+
+	return nand_prog_page_end_op(chip);
 }
 
 static int spinand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
@@ -653,7 +656,7 @@ static int spinand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 	enable_read_hw_ecc = 1;
 
-	chip->read_buf(mtd, p, eccsize * eccsteps);
+	nand_read_page_op(chip, page, 0, p, eccsize * eccsteps);
 	if (oob_required)
 		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 8b8acde72465..04f4cfbe6c09 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -133,12 +133,6 @@ enum nand_ecc_algo {
  */
 #define NAND_ECC_GENERIC_ERASED_CHECK	BIT(0)
 #define NAND_ECC_MAXIMIZE		BIT(1)
-/*
- * If your controller already sends the required NAND commands when
- * reading or writing a page, then the framework is not supposed to
- * send READ0 and SEQIN/PAGEPROG respectively.
- */
-#define NAND_ECC_CUSTOM_PAGE_ACCESS	BIT(2)
 
 /* Bit mask for flags passed to do_nand_read_ecc */
 #define NAND_GET_DEVICE		0x80
@@ -602,11 +596,6 @@ struct nand_ecc_ctrl {
 			int page);
 };
 
-static inline int nand_standard_page_accessors(struct nand_ecc_ctrl *ecc)
-{
-	return !(ecc->options & NAND_ECC_CUSTOM_PAGE_ACCESS);
-}
-
 /**
  * struct nand_buffers - buffer structure for read/write
  * @ecccalc:	buffer pointer for calculated ECC, size is oobsize.
-- 
2.11.0
