From: leiwen@marvell.com (Lei Wen)
Date: Fri, 22 Oct 2010 18:14:44 +0800
Subject: [PATCH V3 6/6] pxa3xx_nand: clean the keep configure code
In-Reply-To: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
References: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
Message-ID: <1287742484-4276-7-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    1 +
 drivers/mtd/nand/pxa3xx_nand.c               |  104 +++++++++-----------------
 2 files changed, 36 insertions(+), 69 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 01a8448..0bd4e88 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -30,6 +30,7 @@ struct pxa3xx_nand_cmdset {
 };
 
 struct pxa3xx_nand_flash {
+	char		*name;
 	uint32_t	chip_id;
 	unsigned int	page_per_block; /* Pages per block (PG_PER_BLK) */
 	unsigned int	page_size;	/* Page size in bytes (PAGE_SZ) */
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index b5dc5d7..7901bde 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -211,15 +211,15 @@ static struct pxa3xx_nand_timing timing[] = {
 };
 
 static struct pxa3xx_nand_flash builtin_flash_types[] = {
-	{      0,   0, 2048,  8,  8,    0, &default_cmdset, &timing[0] },
-	{ 0x46ec,  32,  512, 16, 16, 4096, &default_cmdset, &timing[1] },
-	{ 0xdaec,  64, 2048,  8,  8, 2048, &default_cmdset, &timing[1] },
-	{ 0xd7ec, 128, 4096,  8,  8, 8192, &default_cmdset, &timing[1] },
-	{ 0xa12c,  64, 2048,  8,  8, 1024, &default_cmdset, &timing[2] },
-	{ 0xb12c,  64, 2048, 16, 16, 1024, &default_cmdset, &timing[2] },
-	{ 0xdc2c,  64, 2048,  8,  8, 4096, &default_cmdset, &timing[2] },
-	{ 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[2] },
-	{ 0xba20,  64, 2048, 16, 16, 2048, &default_cmdset, &timing[3] },
+{ "DEFAULT FLASH",      0,   0, 2048,  8,  8,    0, &default_cmdset, &timing[0] },
+{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, &default_cmdset, &timing[1] },
+{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, &default_cmdset, &timing[1] },
+{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &default_cmdset, &timing[1] },
+{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, &default_cmdset, &timing[2] },
+{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, &default_cmdset, &timing[2] },
+{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &default_cmdset, &timing[2] },
+{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[2] },
+{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &default_cmdset, &timing[3] },
 };
 
 /* Define a default flash type setting serve as flash detecting only */
@@ -772,7 +772,6 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 	/* calculate flash information */
 	info->cmdset = f->cmdset;
 	info->page_size = f->page_size;
-	info->oob_buff = info->data_buff + f->page_size;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
 
 	/* calculate addressing information */
@@ -802,44 +801,12 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 {
 	uint32_t ndcr = nand_readl(info, NDCR);
-	struct nand_flash_dev *type = NULL;
-	uint32_t id = -1, page_per_block, num_blocks;
-	int i;
 
-	page_per_block = ndcr & NDCR_PG_PER_BLK ? 64 : 32;
 	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
 	/* set info fields needed to read id */
 	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr;
 
-	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(info->data_buff));
-	if (id == 0)
-		return -ENODEV;
-
-	/* Lookup the flash id */
-	for (i = 0; nand_flash_ids[i].name != NULL; i++) {
-		if (id == nand_flash_ids[i].id) {
-			type =  &nand_flash_ids[i];
-			break;
-		}
-	}
-
-	if (!type)
-		return -ENODEV;
-
-	/* fill the missing flash information */
-	i = __ffs(page_per_block * info->page_size);
-	num_blocks = type->chipsize << (20 - i);
-
-	/* calculate addressing information */
-	info->col_addr_cycles = (info->page_size == 2048) ? 2 : 1;
-
-	if (num_blocks * page_per_block > 65536)
-		info->row_addr_cycles = 3;
-	else
-		info->row_addr_cycles = 2;
-
 	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
 	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
 	info->cmdset = &default_cmdset;
@@ -951,13 +918,15 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	struct pxa3xx_nand_info *info = mtd->priv;
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
+	struct nand_flash_dev pxa3xx_flash_ids[2] = {{NULL,}, {NULL,}};
 	const struct pxa3xx_nand_flash *f = NULL;
 	struct nand_chip *chip = mtd->priv;
 	uint32_t id = -1;
+	uint64_t chipsize;
 	int i, ret;
 
 	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
-		return 0;
+		goto KEEP_CONFIG;
 
 	ret = pxa3xx_nand_sensing(info);
 	if (!ret) {
@@ -987,22 +956,11 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 			f = &builtin_flash_types[i - pdata->num_flash + 1];
 
 		/* find the chip in default list */
-		if (f->chip_id == id) {
-			pxa3xx_nand_config_flash(info, f);
-			mtd->writesize = f->page_size;
-			mtd->writesize_shift = ffs(mtd->writesize) - 1;
-			mtd->writesize_mask = (1 << mtd->writesize_shift) - 1;
-			mtd->oobsize = mtd->writesize / 32;
-			mtd->erasesize = f->page_size * f->page_per_block;
-			mtd->erasesize_shift = ffs(mtd->erasesize) - 1;
-			mtd->erasesize_mask = (1 << mtd->erasesize_shift) - 1;
-
-			mtd->name = mtd_names[0];
+		if (f->chip_id == id)
 			break;
-		}
 	}
 
-	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash)) {
+	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
 		kfree(mtd);
 		info->mtd = NULL;
 		printk(KERN_ERR "ERROR!! flash not defined!!!\n");
@@ -1010,20 +968,28 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		return -EINVAL;
 	}
 
+	pxa3xx_nand_config_flash(info, f);
+	pxa3xx_flash_ids[0].name = f->name;
+	pxa3xx_flash_ids[0].id = (f->chip_id >> 8) & 0xffff;
+	pxa3xx_flash_ids[0].pagesize = f->page_size;
+	chipsize = (uint64_t)f->num_blocks * f->page_per_block * f->page_size;
+	pxa3xx_flash_ids[0].chipsize = chipsize >> 20;
+	pxa3xx_flash_ids[0].erasesize = f->page_size * f->page_per_block;
+	pxa3xx_flash_ids[0].options = (f->flash_width == 16) ? NAND_BUSWIDTH_16 : 0;
+KEEP_CONFIG:
+	if (nand_scan_ident(mtd, 1, pxa3xx_flash_ids))
+		return -ENODEV;
+	/* calculate addressing information */
+	info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
+	info->oob_buff = info->data_buff + mtd->writesize;
+	if ((mtd->size >> chip->page_shift) > 65536)
+		info->row_addr_cycles = 3;
+	else
+		info->row_addr_cycles = 2;
+	mtd->name = mtd_names[0];
 	chip->ecc.mode = NAND_ECC_HW;
-	chip->ecc.size = f->page_size;
-	chip->chipsize 	= (uint64_t)f->num_blocks * f->page_per_block
-			  * f->page_size;
-	mtd->size = chip->chipsize;
-
-	/* Calculate the address shift from the page size */
-	chip->page_shift = ffs(mtd->writesize) - 1;
-	chip->pagemask = mtd_div_by_ws(chip->chipsize, mtd) - 1;
-	chip->numchips = 1;
-	chip->bbt_erase_shift = chip->phys_erase_shift = ffs(mtd->erasesize) - 1;
-
-	chip->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
-	chip->options |= NAND_NO_AUTOINCR;
+	chip->ecc.size = mtd->writesize;
+	chip->options = (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16: 0;
 	chip->options |= NAND_NO_READRDY;
 	chip->options |= NAND_USE_FLASH_BBT;
 
-- 
1.7.0.4
