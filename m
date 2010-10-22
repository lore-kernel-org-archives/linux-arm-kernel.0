From: leiwen@marvell.com (Lei Wen)
Date: Fri, 22 Oct 2010 18:14:43 +0800
Subject: [PATCH V3 5/6] pxa3xx_nand: mtd scan id process could be defined by
	driver itself
In-Reply-To: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
References: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
Message-ID: <1287742484-4276-6-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Different NAND driver may require its unique detection. For pxa3xx_nand,
it use its self id database to get the necessary info.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/mtd/nand/pxa3xx_nand.c |  258 ++++++++++++++++++++++++++--------------
 1 files changed, 168 insertions(+), 90 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 0ca2b88..b5dc5d7 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -123,6 +123,7 @@ enum {
 struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;
 
+	struct nand_hw_control	controller;
 	struct platform_device	 *pdev;
 	struct pxa3xx_nand_cmdset *cmdset;
 
@@ -157,6 +158,7 @@ struct pxa3xx_nand_info {
 
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */
+	int			is_ready;
 
 	unsigned int		page_size;	/* page size of attached chip */
 	unsigned int		data_size;	/* data size in FIFO */
@@ -223,6 +225,8 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 /* Define a default flash type setting serve as flash detecting only */
 #define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
 
+static const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
+
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -437,8 +441,10 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 		info->state = STATE_CMD_DONE;
 		is_completed = 1;
 	}
-	if (status & NDSR_FLASH_RDY)
+	if (status & NDSR_FLASH_RDY) {
+		info->is_ready = 1;
 		info->state = STATE_READY;
+	}
 
 	if (status & NDSR_WRCMDREQ) {
 		nand_writel(info, NDSR, NDSR_WRCMDREQ);
@@ -487,6 +493,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	info->buf_count		= 0;
 	info->oob_size		= 0;
 	info->use_ecc		= 0;
+	info->is_ready		= 0;
 
 	switch (command) {
 	case NAND_CMD_READ0:
@@ -840,42 +847,6 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
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
-	/* we use default timing to detect id */
-	f = DEFAULT_FLASH_TYPE;
-	pxa3xx_nand_config_flash(info, f);
-	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(info->data_buff));
-
-	for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
-		/* we first choose the flash definition from platfrom */
-		if (i < pdata->num_flash)
-			f = pdata->flash + i;
-		else
-			f = &builtin_flash_types[i - pdata->num_flash + 1];
-		if (f->chip_id == id) {
-			dev_info(&info->pdev->dev, "detect chip id: 0x%x\n", id);
-			pxa3xx_nand_config_flash(info, f);
-			return 0;
-		}
-	}
-
-	dev_warn(&info->pdev->dev,
-		 "failed to detect configured nand flash; found %04x instead of\n",
-		 id);
-	return -ENODEV;
-}
-
 /* the maximum possible buffer size for large page with OOB data
  * is: 2048 + 64 = 2112 bytes, allocate a page here for both the
  * data buffer and the DMA descriptor
@@ -917,56 +888,152 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 	return 0;
 }
 
-static struct nand_ecclayout hw_smallpage_ecclayout = {
-	.eccbytes = 6,
-	.eccpos = {8, 9, 10, 11, 12, 13 },
-	.oobfree = { {2, 6} }
-};
+static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
+		struct nand_chip *chip, uint8_t *buf, int page)
+{
+	struct pxa3xx_nand_info *info = mtd->priv;
 
-static struct nand_ecclayout hw_largepage_ecclayout = {
-	.eccbytes = 24,
-	.eccpos = {
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63},
-	.oobfree = { {2, 38} }
-};
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
+{
+	struct nand_chip *chip = mtd->priv;
+	/* Send commands to erase a block */
+	chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
+}
 
-static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
-				 struct pxa3xx_nand_info *info)
+static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
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
+	struct mtd_info *mtd = info->mtd;
+	struct nand_chip *chip = mtd->priv;
+
+	/* use the common timing to make a try */
+	pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
+	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
+	if (info->is_ready)
+		return 1;
 	else
-		this->ecc.layout = &hw_smallpage_ecclayout;
+		return 0;
+}
 
-	this->chip_delay = 25;
+static int pxa3xx_nand_scan(struct mtd_info *mtd)
+{
+	struct pxa3xx_nand_info *info = mtd->priv;
+	struct platform_device *pdev = info->pdev;
+	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
+	const struct pxa3xx_nand_flash *f = NULL;
+	struct nand_chip *chip = mtd->priv;
+	uint32_t id = -1;
+	int i, ret;
+
+	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
+		return 0;
+
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
+	for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
+		if (i < pdata->num_flash)
+			f = pdata->flash + i;
+		else
+			f = &builtin_flash_types[i - pdata->num_flash + 1];
+
+		/* find the chip in default list */
+		if (f->chip_id == id) {
+			pxa3xx_nand_config_flash(info, f);
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
+	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash)) {
+		kfree(mtd);
+		info->mtd = NULL;
+		printk(KERN_ERR "ERROR!! flash not defined!!!\n");
+
+		return -EINVAL;
+	}
+
+	chip->ecc.mode = NAND_ECC_HW;
+	chip->ecc.size = f->page_size;
+	chip->chipsize 	= (uint64_t)f->num_blocks * f->page_per_block
+			  * f->page_size;
+	mtd->size = chip->chipsize;
+
+	/* Calculate the address shift from the page size */
+	chip->page_shift = ffs(mtd->writesize) - 1;
+	chip->pagemask = mtd_div_by_ws(chip->chipsize, mtd) - 1;
+	chip->numchips = 1;
+	chip->bbt_erase_shift = chip->phys_erase_shift = ffs(mtd->erasesize) - 1;
+
+	chip->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
+	chip->options |= NAND_NO_AUTOINCR;
+	chip->options |= NAND_NO_READRDY;
+	chip->options |= NAND_USE_FLASH_BBT;
+
+	return nand_scan_tail(mtd);
 }
 
 static struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 {
-	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct pxa3xx_nand_info *info;
+	struct nand_chip *chip;
 	struct mtd_info *mtd;
 	struct resource *r;
 	int ret, irq;
@@ -979,12 +1046,32 @@ static struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev
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
+	chip->controller        = &info->controller;
+	chip->waitfunc		= pxa3xx_nand_waitfunc;
+	chip->select_chip	= pxa3xx_nand_select_chip;
+	chip->dev_ready		= pxa3xx_nand_dev_ready;
+	chip->cmdfunc		= pxa3xx_nand_cmdfunc;
+	chip->read_word		= pxa3xx_nand_read_word;
+	chip->read_byte		= pxa3xx_nand_read_byte;
+	chip->read_buf		= pxa3xx_nand_read_buf;
+	chip->write_buf		= pxa3xx_nand_write_buf;
+	chip->verify_buf	= pxa3xx_nand_verify_buf;
+	chip->erase_cmd		= pxa3xx_nand_erase_cmd;
+	chip->scan_bbt		= nand_default_bbt;
+
+	spin_lock_init(&chip->controller->lock);
+	init_waitqueue_head(&chip->controller->wq);
 	info->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed to get nand clock\n");
@@ -1052,21 +1139,12 @@ static struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev
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
 
 	return info;
 
-fail_free_irq:
-	free_irq(irq, info);
 fail_free_buf:
+	free_irq(irq, info);
 	if (use_dma) {
 		pxa_free_dma(info->data_dma_ch);
 		dma_free_coherent(&pdev->dev, info->data_buff_size,
@@ -1136,7 +1214,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	if (info == NULL)
 		return -ENOMEM;
 
-	if (nand_scan(info->mtd, 1)) {
+	if (pxa3xx_nand_scan(info->mtd)) {
 		dev_err(&pdev->dev, "failed to scan nand\n");
 		pxa3xx_nand_remove(pdev);
 		return -ENODEV;
-- 
1.7.0.4
