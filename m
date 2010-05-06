From: leiwen@marvell.com (Lei Wen)
Date: Thu, 6 May 2010 09:48:30 +0800
Subject: [PATCH] mtd: pxa3xx_nand: mtd scan id process could be
Message-ID: <mailman.419.1273817811.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

defined by driver itself

Different NAND driver may require its unique detection. For pxa3xx_nand,
it use its self id database to get the necessary info.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  257 +++++++++++++++++++++++++++++-----------
 1 files changed, 185 insertions(+), 72 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 854adad..7a8ff38 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -255,6 +255,8 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 { 0xba20, 64, 2048, 16, 16, 2048, { 10, 35, 15, 25, 15, 25, 25000,
60, 10, }, },
 };

+static const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
+
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -893,37 +895,6 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 	return 0;
 }

-static int pxa3xx_nand_detect_flash(struct pxa3xx_nand_info *info,
-				    const struct pxa3xx_nand_platform_data *pdata)
-{
-	const struct pxa3xx_nand_flash *f;
-	uint32_t id = -1;
-	int i;
-
-	if (pdata->keep_config)
-		if (pxa3xx_nand_detect_config(info) == 0)
-			return 0;
-
-	f = &builtin_flash_types[0];
-	pxa3xx_nand_config_flash(info, f);
-	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(info->data_buff));
-
-	for (i = 1; i < ARRAY_SIZE(builtin_flash_types); i++) {
-		f = &builtin_flash_types[i];
-		if (f->chip_id == id) {
-			dev_info(&info->pdev->dev, "detect chip id: 0x%x\n", id);
-			pxa3xx_nand_config_flash(info, f);
-			return 0;
-		}
-	}
-
-	dev_warn(&info->pdev->dev,
-			"failed to detect configured nand flash; found %04x instead of\n",
-		 id);
-	return -ENODEV;
-}
-
 /* the maximum possible buffer size for large page with OOB data
  * is: 2048 + 64 = 2112 bytes, allocate a page here for both the
  * data buffer and the DMA descriptor
@@ -980,41 +951,174 @@ static struct nand_ecclayout hw_largepage_ecclayout = {
 	.oobfree = { {2, 38} }
 };

-static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
-				 struct pxa3xx_nand_info *info)
+static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
+		struct nand_chip *chip, uint8_t *buf, int page)
+{
+	struct pxa3xx_nand_info *info = mtd->priv;
+
+	chip->read_buf(mtd, buf, mtd->writesize);
+	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	if (info->retcode == ERR_SBERR) {
+		switch (info->use_ecc) {
+			case 1:
+				mtd->ecc_stats.corrected ++;
+				break;
+
+			case 0:
+			default:
+				break;
+		}
+	}
+	else if (info->retcode == ERR_DBERR) {
+		int buf_blank;
+
+		buf_blank = is_buf_blank(buf, mtd->writesize);
+		if (!buf_blank)
+			mtd->ecc_stats.failed++;
+	}
+
+	return 0;
+}
+
+static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
+		struct nand_chip *chip, const uint8_t *buf)
+{
+	chip->write_buf(mtd, buf, mtd->writesize);
+	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+}
+
+static void pxa3xx_nand_erase_cmd(struct mtd_info *mtd, int page)
 {
-	struct nand_chip *this = &info->nand_chip;
-
-	this->options = (info->reg_ndcr & NDCR_DWIDTH_C) ? NAND_BUSWIDTH_16: 0;
-
-	this->waitfunc		= pxa3xx_nand_waitfunc;
-	this->select_chip	= pxa3xx_nand_select_chip;
-	this->dev_ready		= pxa3xx_nand_dev_ready;
-	this->cmdfunc		= pxa3xx_nand_cmdfunc;
-	this->read_word		= pxa3xx_nand_read_word;
-	this->read_byte		= pxa3xx_nand_read_byte;
-	this->read_buf		= pxa3xx_nand_read_buf;
-	this->write_buf		= pxa3xx_nand_write_buf;
-	this->verify_buf	= pxa3xx_nand_verify_buf;
-
-	this->ecc.mode		= NAND_ECC_HW;
-	this->ecc.hwctl		= pxa3xx_nand_ecc_hwctl;
-	this->ecc.calculate	= pxa3xx_nand_ecc_calculate;
-	this->ecc.correct	= pxa3xx_nand_ecc_correct;
-	this->ecc.size		= info->page_size;
-
-	if (info->page_size == 2048)
-		this->ecc.layout = &hw_largepage_ecclayout;
+	struct nand_chip *chip = mtd->priv;
+	/* Send commands to erase a block */
+	chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
+}
+
+static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
+{
+	struct mtd_info *mtd = info->mtd;
+	struct nand_chip *chip = mtd->priv;
+
+	/* use the common timing to make a try */
+	pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
+	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
+	if (info->state & STATE_READY)
+		return 1;
 	else
-		this->ecc.layout = &hw_smallpage_ecclayout;
+		return 0;
+}
+
+static int pxa3xx_nand_scan(struct mtd_info *mtd)
+{
+	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_flash *f;
+	struct nand_chip *chip = mtd->priv;
+	uint32_t id = -1;
+	int i, ret;

-	this->chip_delay = 25;
+	ret = pxa3xx_nand_sensing(info);
+	if (!ret) {
+		kfree(mtd);
+		info->mtd = NULL;
+		printk(KERN_INFO "There is no nand chip on cs 0!\n");
+
+		return -EINVAL;
+	}
+
+	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
+	id = *((uint16_t *)(info->data_buff));
+	if (id != 0)
+		printk(KERN_INFO "Detect a flash id %x\n", id);
+	else {
+		kfree(mtd);
+		info->mtd = NULL;
+		printk(KERN_WARNING "Read out ID 0, potential timing set wrong!!\n");
+
+		return -EINVAL;
+	}
+
+	for (i = 1; i < ARRAY_SIZE(builtin_flash_types); i++) {
+
+		f = &builtin_flash_types[i];
+
+		/* find the chip in default list */
+		if (f->chip_id == id) {
+			pxa3xx_nand_config_flash(info, f);
+			chip->cellinfo = info->data_buff[2];
+			mtd->writesize = f->page_size;
+			mtd->writesize_shift = ffs(mtd->writesize) - 1;
+			mtd->writesize_mask = (1 << mtd->writesize_shift) - 1;
+			mtd->oobsize = mtd->writesize / 32;
+			mtd->erasesize = f->page_size * f->page_per_block;
+			mtd->erasesize_shift = ffs(mtd->erasesize) - 1;
+			mtd->erasesize_mask = (1 << mtd->erasesize_shift) - 1;
+
+			mtd->name = mtd_names[0];
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(builtin_flash_types)) {
+		kfree(mtd);
+		info->mtd = NULL;
+		printk(KERN_ERR "ERROR!! flash not defined!!!\n");
+
+		return -EINVAL;
+	}
+
+	chip->ecc.mode		= NAND_ECC_HW;
+	chip->ecc.size		= f->page_size;
+	if (f->page_size == 2048)
+		chip->ecc.layout = &hw_largepage_ecclayout;
+	else
+		chip->ecc.layout = &hw_smallpage_ecclayout;
+
+	chip->chipsize 		= (uint64_t)f->num_blocks 	* \
+				  f->page_per_block 		* \
+				  f->page_size;
+
+	chip->chip_shift 	= ffs(chip->chipsize) - 1;
+	mtd->size 		= chip->chipsize;
+
+	/* Calculate the address shift from the page size */
+	chip->page_shift = ffs(mtd->writesize) - 1;
+	chip->pagemask = mtd_div_by_ws(chip->chipsize, mtd) - 1;
+	chip->numchips		= 1;
+	chip->chip_delay	= 25;
+	chip->bbt_erase_shift = chip->phys_erase_shift = ffs(mtd->erasesize) - 1;
+
+	/* Set the bad block position */
+	chip->badblockpos = mtd->writesize > 512 ?
+		NAND_LARGE_BADBLOCK_POS : NAND_SMALL_BADBLOCK_POS;
+
+	chip->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
+	chip->options |= NAND_NO_AUTOINCR;
+	chip->options |= NAND_NO_READRDY;
+	chip->options |= NAND_USE_FLASH_BBT;
+
+	return nand_scan_tail(mtd);
+}
+
+static int pxa3xx_nand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
+{
+	struct nand_chip *chip = mtd->priv;
+	int block;
+
+	block = (int)(ofs >> chip->bbt_erase_shift);
+	chip->bbt[block >> 2] |= 0x01 << ((block & 0x03) << 1);
+	return nand_update_bbt(mtd, ofs);
+}
+
+static int pxa3xx_nand_block_bad(struct mtd_info *mtd, loff_t ofs, int getchip)
+{
+	return 0;
 }

 static int alloc_nand_resource(struct platform_device *pdev)
 {
-	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct pxa3xx_nand_info *info;
+	struct nand_chip *chip;
 	struct mtd_info *mtd;
 	struct resource *r;
 	int ret, irq;
@@ -1027,12 +1131,31 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 	}

 	info = (struct pxa3xx_nand_info *)(&mtd[1]);
+	chip = (struct nand_chip *)(&mtd[1]);
 	info->pdev = pdev;
-
-	mtd->priv = info;
 	info->mtd = mtd;
+	mtd->priv = info;
 	mtd->owner = THIS_MODULE;

+	chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
+	chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
+	chip->ecc.hwctl		= pxa3xx_nand_ecc_hwctl;
+	chip->ecc.calculate	= pxa3xx_nand_ecc_calculate;
+	chip->ecc.correct	= pxa3xx_nand_ecc_correct;
+	chip->waitfunc		= pxa3xx_nand_waitfunc;
+	chip->select_chip	= pxa3xx_nand_select_chip;
+	chip->dev_ready		= pxa3xx_nand_dev_ready;
+	chip->cmdfunc		= pxa3xx_nand_cmdfunc;
+	chip->read_word		= pxa3xx_nand_read_word;
+	chip->read_byte		= pxa3xx_nand_read_byte;
+	chip->read_buf		= pxa3xx_nand_read_buf;
+	chip->write_buf		= pxa3xx_nand_write_buf;
+	chip->verify_buf	= pxa3xx_nand_verify_buf;
+	chip->block_markbad	= pxa3xx_nand_default_block_markbad;
+	chip->block_bad		= pxa3xx_nand_block_bad;
+	chip->scan_bbt		= nand_default_bbt;
+	chip->erase_cmd		= pxa3xx_nand_erase_cmd;
+
 	info->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed to get nand clock\n");
@@ -1100,21 +1223,11 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 		goto fail_free_buf;
 	}

-	ret = pxa3xx_nand_detect_flash(info, pdata);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to detect flash\n");
-		ret = -ENODEV;
-		goto fail_free_irq;
-	}
-
-	pxa3xx_nand_init_mtd(mtd, info);
 	platform_set_drvdata(pdev, info);
-
 	return 0;

-fail_free_irq:
-	free_irq(irq, info);
 fail_free_buf:
+	free_irq(irq, info);
 	if (use_dma) {
 		pxa_free_dma(info->data_dma_ch);
 		dma_free_coherent(&pdev->dev, info->data_buff_size,
@@ -1182,7 +1295,7 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 		return ret;

 	info = platform_get_drvdata(pdev);
-	if (nand_scan(info->mtd, 1)) {
+	if (pxa3xx_nand_scan(info->mtd)) {
 		dev_err(&pdev->dev, "failed to scan nand\n");
 		pxa3xx_nand_remove(pdev);
 		return -ENODEV;
-- 
1.5.6.5
