From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 21 Oct 2015 10:29:03 +0200
Subject: [PATCH v4 4/5] mtd: pxa3xx_nand: rework flash detection and timing
 setup
In-Reply-To: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1445416144-9194-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the pxa3xx_nand driver to allow using functions exported by the
nand framework to detect the flash and the timings. Then setup the
timings using the helpers previously added.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 123 ++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 88 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 54f92837be8a..2761282df353 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1396,45 +1396,23 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 	return NAND_STATUS_READY;
 }
 
-static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
-				    const struct pxa3xx_nand_flash *f)
+static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info)
 {
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct pxa3xx_nand_host *host = info->host[info->cs];
-	uint32_t ndcr = 0x0; /* enable all interrupts */
-
-	if (f->page_size != 2048 && f->page_size != 512) {
-		dev_err(&pdev->dev, "Current only support 2048 and 512 size\n");
-		return -EINVAL;
-	}
-
-	if (f->flash_width != 16 && f->flash_width != 8) {
-		dev_err(&pdev->dev, "Only support 8bit and 16 bit!\n");
-		return -EINVAL;
-	}
-
-	/* calculate addressing information */
-	host->col_addr_cycles = (f->page_size == 2048) ? 2 : 1;
-
-	if (f->num_blocks * f->page_per_block > 65536)
-		host->row_addr_cycles = 3;
-	else
-		host->row_addr_cycles = 2;
-
-	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
-	ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
-	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
-	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
-	ndcr |= (f->flash_width == 16) ? NDCR_DWIDTH_M : 0;
-	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
-
-	ndcr |= NDCR_RD_ID_CNT(READ_ID_BYTES);
-	ndcr |= NDCR_SPARE_EN; /* enable spare by default */
+	struct mtd_info *mtd = host->mtd;
+	struct nand_chip *chip = mtd->priv;
 
-	info->reg_ndcr = ndcr;
+	/* configure default flash values */
+	info->reg_ndcr = 0x0; /* enable all interrupts */
+	info->reg_ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
+	info->reg_ndcr |= NDCR_RD_ID_CNT(READ_ID_BYTES);
+	info->reg_ndcr |= NDCR_SPARE_EN; /* enable spare by default */
+	info->reg_ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
+	info->reg_ndcr |= (chip->page_shift == 6) ? NDCR_PG_PER_BLK : 0;
+	info->reg_ndcr |= (mtd->writesize == 2048) ? NDCR_PAGE_SZ : 0;
 
-	pxa3xx_nand_set_timing(host, f->timing);
 	return 0;
 }
 
@@ -1514,19 +1492,23 @@ static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
 	kfree(info->data_buff);
 }
 
-static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
+static int pxa3xx_nand_sensing(struct pxa3xx_nand_host *host)
 {
+	struct pxa3xx_nand_info *info = host->info_data;
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
+	const struct nand_sdr_timings *timings;
 	int ret;
 
 	mtd = info->host[info->cs]->mtd;
 	chip = mtd->priv;
 
 	/* use the common timing to make a try */
-	ret = pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
-	if (ret)
-		return ret;
+	timings = onfi_async_timing_mode_to_sdr_timings(0);
+	if (IS_ERR(timings))
+		return PTR_ERR(timings);
+
+	pxa3xx_nand_set_sdr_timing(host, timings);
 
 	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
 	ret = chip->waitfunc(mtd, chip);
@@ -1611,12 +1593,8 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	struct pxa3xx_nand_info *info = host->info_data;
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct nand_flash_dev pxa3xx_flash_ids[2], *def = NULL;
-	const struct pxa3xx_nand_flash *f = NULL;
 	struct nand_chip *chip = mtd->priv;
-	uint32_t id = -1;
-	uint64_t chipsize;
-	int i, ret, num;
+	int ret;
 	uint16_t ecc_strength, ecc_step;
 
 	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
@@ -1625,7 +1603,11 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	/* Set a default chunk size */
 	info->chunk_size = 512;
 
-	ret = pxa3xx_nand_sensing(info);
+	ret = pxa3xx_nand_config_flash(info);
+	if (ret)
+		return ret;
+
+	ret = pxa3xx_nand_sensing(host);
 	if (ret) {
 		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",
 			 info->cs);
@@ -1633,50 +1615,6 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		return ret;
 	}
 
-	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(info->data_buff));
-	if (id != 0)
-		dev_info(&info->pdev->dev, "Detect a flash id %x\n", id);
-	else {
-		dev_warn(&info->pdev->dev,
-			 "Read out ID 0, potential timing set wrong!!\n");
-
-		return -EINVAL;
-	}
-
-	num = ARRAY_SIZE(builtin_flash_types) - 1;
-	for (i = 0; i < num; i++) {
-		f = &builtin_flash_types[i + 1];
-
-		/* find the chip in default list */
-		if (f->chip_id == id)
-			break;
-	}
-
-	if (i >= (ARRAY_SIZE(builtin_flash_types) - 1)) {
-		dev_err(&info->pdev->dev, "ERROR!! flash not defined!!!\n");
-
-		return -EINVAL;
-	}
-
-	ret = pxa3xx_nand_config_flash(info, f);
-	if (ret) {
-		dev_err(&info->pdev->dev, "ERROR! Configure failed\n");
-		return ret;
-	}
-
-	memset(pxa3xx_flash_ids, 0, sizeof(pxa3xx_flash_ids));
-
-	pxa3xx_flash_ids[0].name = f->name;
-	pxa3xx_flash_ids[0].dev_id = (f->chip_id >> 8) & 0xffff;
-	pxa3xx_flash_ids[0].pagesize = f->page_size;
-	chipsize = (uint64_t)f->num_blocks * f->page_per_block * f->page_size;
-	pxa3xx_flash_ids[0].chipsize = chipsize >> 20;
-	pxa3xx_flash_ids[0].erasesize = f->page_size * f->page_per_block;
-	if (f->flash_width == 16)
-		pxa3xx_flash_ids[0].options = NAND_BUSWIDTH_16;
-	pxa3xx_flash_ids[1].name = NULL;
-	def = pxa3xx_flash_ids;
 KEEP_CONFIG:
 	info->reg_ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
 	if (info->reg_ndcr & NDCR_DWIDTH_M)
@@ -1686,9 +1624,18 @@ KEEP_CONFIG:
 	if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
 		nand_writel(info, NDECCCTRL, 0x0);
 
-	if (nand_scan_ident(mtd, 1, def))
+	if (nand_scan_ident(mtd, 1, NULL))
 		return -ENODEV;
 
+	if (!pdata->keep_config) {
+		ret = pxa3xx_nand_init(host);
+		if (ret) {
+			dev_err(&info->pdev->dev, "Failed to init nand: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	if (pdata->flash_bbt) {
 		/*
 		 * We'll use a bad block table stored in-flash and don't
-- 
2.6.2
