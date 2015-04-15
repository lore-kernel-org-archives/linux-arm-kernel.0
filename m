From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 15 Apr 2015 19:24:02 +0200
Subject: [PATCH v4 04/10] mtd: pxa3xx_nand: rework flash detection and timing
 setup
In-Reply-To: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1429118648-19416-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the pxa3xx_nand driver to allow using functions exported by the
nand framework to detect the flash and to configure the timings.

Because this driver supports some non-ONFI devices, we also keep the
custom timing setup of this driver so these devices won't break.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c                | 220 ++++++++++++++------------
 include/linux/platform_data/mtd-nand-pxa3xx.h |  11 +-
 2 files changed, 123 insertions(+), 108 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index dc0edbc406bb..438770c56bd3 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -251,15 +251,14 @@ static struct pxa3xx_nand_timing timing[] = {
 };
 
 static struct pxa3xx_nand_flash builtin_flash_types[] = {
-{ "DEFAULT FLASH",      0,   0, 2048,  8,  8,    0, &timing[0] },
-{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, &timing[1] },
-{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, &timing[1] },
-{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1] },
-{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, &timing[2] },
-{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, &timing[2] },
-{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2] },
-{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2] },
-{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
+	{ 0x46ec, 16, 16, &timing[1] },
+	{ 0xdaec,  8,  8, &timing[1] },
+	{ 0xd7ec,  8,  8, &timing[1] },
+	{ 0xa12c,  8,  8, &timing[2] },
+	{ 0xb12c, 16, 16, &timing[2] },
+	{ 0xdc2c,  8,  8, &timing[2] },
+	{ 0xcc2c, 16, 16, &timing[2] },
+	{ 0xba20, 16, 16, &timing[3] },
 };
 
 static u8 bbt_pattern[] = {'M', 'V', 'B', 'b', 't', '0' };
@@ -320,9 +319,6 @@ static struct nand_ecclayout ecc_layout_4KB_bch8bit = {
 	.oobfree = { }
 };
 
-/* Define a default flash type setting serve as flash detecting only */
-#define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
-
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -384,6 +380,92 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 	nand_writel(info, NDTR1CS0, ndtr1);
 }
 
+static void pxa3xx_nand_set_sdr_timing(struct pxa3xx_nand_host *host,
+				       const struct nand_sdr_timings *t)
+{
+	struct pxa3xx_nand_info *info = host->info_data;
+	unsigned long nand_clk = clk_get_rate(info->clk);
+	uint32_t ndtr0, ndtr1;
+
+	u32 tCH_min = DIV_ROUND_UP(t->tCH_min, 1000);
+	u32 tCS_min = DIV_ROUND_UP(t->tCS_min, 1000);
+	u32 tWH_min = DIV_ROUND_UP(t->tWH_min, 1000);
+	u32 tWP_min = DIV_ROUND_UP(t->tWP_min, 1000);
+	u32 tREH_min = DIV_ROUND_UP(t->tREH_min, 1000);
+	u32 tRP_min = DIV_ROUND_UP(t->tRP_min, 1000);
+	u32 tRST_max = DIV_ROUND_UP_ULL(t->tRST_max, 1000);
+	u32 tWHR_min = DIV_ROUND_UP(t->tWHR_min, 1000);
+	u32 tAR_min = DIV_ROUND_UP(t->tAR_min, 1000);
+
+	ndtr0 = NDTR0_tCH(ns2cycle(tCH_min, nand_clk)) |
+		NDTR0_tCS(ns2cycle(tCS_min, nand_clk)) |
+		NDTR0_tWH(ns2cycle(tWH_min, nand_clk)) |
+		NDTR0_tWP(ns2cycle(tWP_min, nand_clk)) |
+		NDTR0_tRH(ns2cycle(tREH_min, nand_clk)) |
+		NDTR0_tRP(ns2cycle(tRP_min, nand_clk));
+
+	ndtr1 = NDTR1_tR(ns2cycle(tRST_max, nand_clk)) |
+		NDTR1_tWHR(ns2cycle(tWHR_min, nand_clk)) |
+		NDTR1_tAR(ns2cycle(tAR_min, nand_clk));
+
+	info->ndtr0cs0 = ndtr0;
+	info->ndtr1cs0 = ndtr1;
+	nand_writel(info, NDTR0CS0, ndtr0);
+	nand_writel(info, NDTR1CS0, ndtr1);
+}
+
+static int pxa3xx_nand_init_timings(struct pxa3xx_nand_host *host)
+{
+	const struct nand_sdr_timings *timings;
+	struct nand_chip *chip = &host->chip;
+	struct pxa3xx_nand_info *info = host->info_data;
+	const struct pxa3xx_nand_flash *f = NULL;
+	int mode, id, ntypes, i;
+
+	mode = onfi_get_async_timing_mode(chip);
+	if (mode == ONFI_TIMING_MODE_UNKNOWN) {
+		ntypes = ARRAY_SIZE(builtin_flash_types);
+
+		chip->cmdfunc(host->mtd, NAND_CMD_READID, 0x00, -1);
+
+		id = chip->read_byte(host->mtd);
+		id |= chip->read_byte(host->mtd) << 0x8;
+
+		for (i = 0; i < ntypes; i++) {
+			f = &builtin_flash_types[i];
+
+			if (f->chip_id == id)
+				break;
+		}
+
+		if (i == ntypes) {
+			dev_err(&info->pdev->dev, "Error: timings not found\n");
+			return -EINVAL;
+		}
+
+		pxa3xx_nand_set_timing(host, f->timing);
+
+		if (f->flash_width == 16) {
+			info->reg_ndcr |= NDCR_DWIDTH_M;
+			chip->options |= NAND_BUSWIDTH_16;
+		}
+
+		info->reg_ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
+	} else {
+		mode = fls(mode) - 1;
+		if (mode < 0)
+			mode = 0;
+
+		timings = onfi_async_timing_mode_to_sdr_timings(mode);
+		if (IS_ERR(timings))
+			return PTR_ERR(timings);
+
+		pxa3xx_nand_set_sdr_timing(host, timings);
+	}
+
+	return 0;
+}
+
 /*
  * Set the data and OOB size, depending on the selected
  * spare and ECC configuration.
@@ -1185,48 +1267,25 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 	return NAND_STATUS_READY;
 }
 
-static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
-				    const struct pxa3xx_nand_flash *f)
+static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info)
 {
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct pxa3xx_nand_host *host = info->host[info->cs];
+	struct mtd_info *mtd = host->mtd;
+	struct nand_chip *chip = mtd->priv;
 	uint32_t ndcr = 0x0; /* enable all interrupts */
 
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
-	/* calculate flash information */
-	host->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
-
-	/* calculate addressing information */
-	host->col_addr_cycles = (f->page_size == 2048) ? 2 : 1;
-
-	if (f->num_blocks * f->page_per_block > 65536)
-		host->row_addr_cycles = 3;
-	else
-		host->row_addr_cycles = 2;
-
 	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
 	ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
-	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
-	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
-	ndcr |= (f->flash_width == 16) ? NDCR_DWIDTH_M : 0;
-	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
+	ndcr |= (chip->page_shift == 6) ? NDCR_PG_PER_BLK : 0;
+	ndcr |= (mtd->writesize == 2048) ? NDCR_PAGE_SZ : 0;
 
 	ndcr |= NDCR_RD_ID_CNT(host->read_id_bytes);
 	ndcr |= NDCR_SPARE_EN; /* enable spare by default */
 
 	info->reg_ndcr = ndcr;
 
-	pxa3xx_nand_set_timing(host, f->timing);
 	return 0;
 }
 
@@ -1321,20 +1380,28 @@ static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
 }
 #endif
 
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
 
-	/* use the common timing to make a try */
-	ret = pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
+	ret = pxa3xx_nand_config_flash(info);
 	if (ret)
 		return ret;
 
+	/* use the common timing to make a try */
+	timings = onfi_async_timing_mode_to_sdr_timings(0);
+	if (IS_ERR(timings))
+		return PTR_ERR(timings);
+
+	pxa3xx_nand_set_sdr_timing(host, timings);
+
 	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
 	ret = chip->waitfunc(mtd, chip);
 	if (ret & NAND_STATUS_FAIL)
@@ -1418,12 +1485,8 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
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
@@ -1432,7 +1495,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	/* Set a default chunk size */
 	info->chunk_size = 512;
 
-	ret = pxa3xx_nand_sensing(info);
+	ret = pxa3xx_nand_sensing(host);
 	if (ret) {
 		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",
 			 info->cs);
@@ -1440,64 +1503,20 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
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
-	num = ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1;
-	for (i = 0; i < num; i++) {
-		if (i < pdata->num_flash)
-			f = pdata->flash + i;
-		else
-			f = &builtin_flash_types[i - pdata->num_flash + 1];
-
-		/* find the chip in default list */
-		if (f->chip_id == id)
-			break;
-	}
-
-	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
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
-	if (info->reg_ndcr & NDCR_DWIDTH_M)
-		chip->options |= NAND_BUSWIDTH_16;
-
 	/* Device detection must be done with ECC disabled */
 	if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
 		nand_writel(info, NDECCCTRL, 0x0);
 
-	if (nand_scan_ident(mtd, 1, def))
+	if (nand_scan_ident(mtd, 1, NULL))
 		return -ENODEV;
 
+	ret = pxa3xx_nand_init_timings(host);
+	if (ret) {
+		dev_err(&info->pdev->dev, "Failed to set timings: %d\n", ret);
+		return ret;
+	}
+
 	if (pdata->flash_bbt) {
 		/*
 		 * We'll use a bad block table stored in-flash and don't
@@ -1593,6 +1612,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		host->mtd = mtd;
 		host->cs = cs;
 		host->info_data = info;
+		host->read_id_bytes = 4;
 		mtd->priv = host;
 		mtd->owner = THIS_MODULE;
 
diff --git a/include/linux/platform_data/mtd-nand-pxa3xx.h b/include/linux/platform_data/mtd-nand-pxa3xx.h
index ac4ea2e641c7..25538cfeee26 100644
--- a/include/linux/platform_data/mtd-nand-pxa3xx.h
+++ b/include/linux/platform_data/mtd-nand-pxa3xx.h
@@ -17,15 +17,10 @@ struct pxa3xx_nand_timing {
 };
 
 struct pxa3xx_nand_flash {
-	char		*name;
 	uint32_t	chip_id;
-	unsigned int	page_per_block; /* Pages per block (PG_PER_BLK) */
-	unsigned int	page_size;	/* Page size in bytes (PAGE_SZ) */
-	unsigned int	flash_width;	/* Width of Flash memory (DWIDTH_M) */
-	unsigned int	dfc_width;	/* Width of flash controller(DWIDTH_C) */
-	unsigned int	num_blocks;	/* Number of physical blocks in Flash */
-
-	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
+	unsigned int	flash_width;    /* Width of Flash memory (DWIDTH_M) */
+	unsigned int	dfc_width;      /* Width of flash controller(DWIDTH_C) */
+	struct pxa3xx_nand_timing *timing; /* NAND Flash timing */
 };
 
 /*
-- 
2.3.5
