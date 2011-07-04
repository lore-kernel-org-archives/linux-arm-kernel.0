From: leiwen@marvell.com (Lei Wen)
Date: Mon,  4 Jul 2011 02:25:35 -0700
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
Message-ID: <1309771536-10597-4-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current pxa3xx_nand controller has two chip select which
both be workable. This patch enable this feature.

Update platform driver to support this feature.

Another notice should be taken that:
When you want to use this feature, you should not enable the
keep configuration feature, for two chip select could be
attached with different nand chip. The different page size
and timing requirement make the keep configuration impossible.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   20 +++-
 drivers/mtd/nand/pxa3xx_nand.c               |  152 ++++++++++++++++++--------
 2 files changed, 124 insertions(+), 48 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 442301f..c42f39f 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -41,6 +41,19 @@ struct pxa3xx_nand_flash {
 	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
 };
 
+/*
+ * Current pxa3xx_nand controller has two chip select which
+ * both be workable.
+ *
+ * Notice should be taken that:
+ * When you want to use this feature, you should not enable the
+ * keep configuration feature, for two chip select could be
+ * attached with different nand chip. The different page size
+ * and timing requirement make the keep configuration impossible.
+ */
+
+/* The max num of chip select current support */
+#define NUM_CHIP_SELECT		(2)
 struct pxa3xx_nand_platform_data {
 
 	/* the data flash bus is shared between the Static Memory
@@ -52,8 +65,11 @@ struct pxa3xx_nand_platform_data {
 	/* allow platform code to keep OBM/bootloader defined NFC config */
 	int	keep_config;
 
-	const struct mtd_partition		*parts;
-	unsigned int				nr_parts;
+	/* indicate how many chip selects will be used */
+	int	num_cs;
+
+	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
+	unsigned int				nr_parts[NUM_CHIP_SELECT];
 
 	const struct pxa3xx_nand_flash * 	flash;
 	size_t					num_flash;
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index a16328a..66f1709 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -130,6 +130,7 @@ struct pxa3xx_nand_host {
 	/* page size of attached chip */
 	unsigned int		page_size;
 	int			use_ecc;
+	int			cs;
 
 	/* calculated from pxa3xx_nand_flash data */
 	unsigned int		col_addr_cycles;
@@ -165,9 +166,10 @@ struct pxa3xx_nand_info {
 	struct pxa_dma_desc	*data_desc;
 	dma_addr_t 		data_desc_addr;
 
-	struct pxa3xx_nand_host *host;
+	struct pxa3xx_nand_host *host[NUM_CHIP_SELECT];
 	unsigned int		state;
 
+	int			cs;
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */
 	int			is_ready;
@@ -226,7 +228,7 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 /* Define a default flash type setting serve as flash detecting only */
 #define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
 
-const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
+const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};
 
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
@@ -268,7 +270,7 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 
 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
-	struct pxa3xx_nand_host *host = info->host;
+	struct pxa3xx_nand_host *host = info->host[info->cs];
 	int oob_enable = host->reg_ndcr & NDCR_SPARE_EN;
 
 	info->data_size = host->page_size;
@@ -295,7 +297,7 @@ static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
  */
 static void pxa3xx_nand_start(struct pxa3xx_nand_info *info)
 {
-	struct pxa3xx_nand_host *host = info->host;
+	struct pxa3xx_nand_host *host = info->host[info->cs];
 	uint32_t ndcr;
 
 	ndcr = host->reg_ndcr;
@@ -420,6 +422,15 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 {
 	struct pxa3xx_nand_info *info = devid;
 	unsigned int status, is_completed = 0;
+	unsigned int ready, cmd_done;
+
+	if (info->cs == 0) {
+		ready           = NDSR_FLASH_RDY;
+		cmd_done        = NDSR_CS0_CMDD;
+	} else {
+		ready           = NDSR_RDY;
+		cmd_done        = NDSR_CS1_CMDD;
+	}
 
 	status = nand_readl(info, NDSR);
 
@@ -441,11 +452,11 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 			handle_data_pio(info);
 		}
 	}
-	if (status & NDSR_CS0_CMDD) {
+	if (status & cmd_done) {
 		info->state = STATE_CMD_DONE;
 		is_completed = 1;
 	}
-	if (status & NDSR_FLASH_RDY) {
+	if (status & ready) {
 		info->is_ready = 1;
 		info->state = STATE_READY;
 	}
@@ -480,9 +491,11 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 {
 	uint16_t cmd;
 	int addr_cycle, exec_cmd;
-	struct pxa3xx_nand_host *host = info->host;
-	struct mtd_info *mtd = host->mtd;
+	struct pxa3xx_nand_host *host;
+	struct mtd_info *mtd;
 
+	host = info->host[info->cs];
+	mtd = host->mtd;
 	addr_cycle = 0;
 	exec_cmd = 1;
 
@@ -492,8 +505,11 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	info->oob_size		= 0;
 	info->use_ecc		= 0;
 	info->is_ready		= 0;
-	info->ndcb0		= 0;
 	info->retcode		= ERR_NONE;
+	if (info->cs != 0)
+		info->ndcb0 = NDCB0_CSEL;
+	else
+		info->ndcb0 = 0;
 
 	switch (command) {
 	case NAND_CMD_READ0:
@@ -637,6 +653,17 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	if (host->reg_ndcr & NDCR_DWIDTH_M)
 		column /= 2;
 
+	/*
+	 * There may be different NAND chip hooked to
+	 * different chip select, so check whether
+	 * chip select has been changed, if yes, reset the timing
+	 */
+	if (info->cs != host->cs) {
+		info->cs = host->cs;
+		nand_writel(info, NDTR0CS0, host->ndtr0cs0);
+		nand_writel(info, NDTR1CS0, host->ndtr1cs0);
+	}
+
 	info->state = STATE_PREPARED;
 	exec_cmd = prepare_command_pool(info, command, column, page_addr);
 	if (exec_cmd) {
@@ -778,7 +805,7 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 {
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
-	struct pxa3xx_nand_host *host = info->host;
+	struct pxa3xx_nand_host *host = info->host[info->cs];
 	uint32_t ndcr = 0x0; /* enable all interrupts */
 
 	if (f->page_size != 2048 && f->page_size != 512) {
@@ -822,7 +849,11 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 
 static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 {
-	struct pxa3xx_nand_host *host = info->host;
+	/*
+	 * We set 0 by hard coding here, for we don't support keep_config
+	 * when there is more than one chip attached to the controller
+	 */
+	struct pxa3xx_nand_host *host = info->host[0];
 	uint32_t ndcr = nand_readl(info, NDCR);
 
 	if (ndcr & NDCR_PAGE_SZ) {
@@ -883,9 +914,9 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 
 static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
 {
-	struct mtd_info *mtd = info->host->mtd;
+	struct mtd_info *mtd;
 	int ret;
-
+	mtd = info->host[info->cs]->mtd;
 	/* use the common timing to make a try */
 	ret = pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
 	if (ret)
@@ -917,7 +948,8 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	ret = pxa3xx_nand_sensing(info);
 	if (ret) {
 		host->mtd = NULL;
-		dev_info(&info->pdev->dev, "There is no nand chip on cs 0!\n");
+		dev_info(&info->pdev->dev, "There is no nand chip on cs %d!\n"
+				, info->cs);
 
 		return ret;
 	}
@@ -996,41 +1028,47 @@ KEEP_CONFIG:
 
 static int alloc_nand_resource(struct platform_device *pdev)
 {
+	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
 	struct pxa3xx_nand_host *host;
 	struct nand_chip *chip;
 	struct mtd_info *mtd;
 	struct resource *r;
-	int ret, irq;
+	int ret, irq, cs;
 
-	info = kzalloc(sizeof(*info) + sizeof(*mtd) + sizeof(*host),
-			GFP_KERNEL);
+	pdata = pdev->dev.platform_data;
+	info = kzalloc(sizeof(*info) + (sizeof(*mtd) +
+		       sizeof(*host)) * pdata->num_cs, GFP_KERNEL);
 	if (!info) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
 	}
 
-	mtd = (struct mtd_info *)(&info[1]);
-	chip = (struct nand_chip *)(&mtd[1]);
-	host = (struct pxa3xx_nand_host *)chip;
 	info->pdev = pdev;
-	info->host = host;
-	host->mtd = mtd;
-	host->info_data = info;
-	mtd->priv = host;
-	mtd->owner = THIS_MODULE;
-
-	chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
-	chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
-	chip->controller        = &info->controller;
-	chip->waitfunc		= pxa3xx_nand_waitfunc;
-	chip->select_chip	= pxa3xx_nand_select_chip;
-	chip->cmdfunc		= pxa3xx_nand_cmdfunc;
-	chip->read_word		= pxa3xx_nand_read_word;
-	chip->read_byte		= pxa3xx_nand_read_byte;
-	chip->read_buf		= pxa3xx_nand_read_buf;
-	chip->write_buf		= pxa3xx_nand_write_buf;
-	chip->verify_buf	= pxa3xx_nand_verify_buf;
+	for (cs = 0; cs < pdata->num_cs; cs++) {
+		mtd = (struct mtd_info *)((unsigned int)&info[1] +
+		      (sizeof(*mtd) + sizeof(*host)) * cs);
+		chip = (struct nand_chip *)(&mtd[1]);
+		host = (struct pxa3xx_nand_host *)chip;
+		info->host[cs] = host;
+		host->mtd = mtd;
+		host->cs = cs;
+		host->info_data = info;
+		mtd->priv = host;
+		mtd->owner = THIS_MODULE;
+
+		chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
+		chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
+		chip->controller        = &info->controller;
+		chip->waitfunc		= pxa3xx_nand_waitfunc;
+		chip->select_chip	= pxa3xx_nand_select_chip;
+		chip->cmdfunc		= pxa3xx_nand_cmdfunc;
+		chip->read_word		= pxa3xx_nand_read_word;
+		chip->read_byte		= pxa3xx_nand_read_byte;
+		chip->read_buf		= pxa3xx_nand_read_buf;
+		chip->write_buf		= pxa3xx_nand_write_buf;
+		chip->verify_buf	= pxa3xx_nand_verify_buf;
+	}
 
 	spin_lock_init(&chip->controller->lock);
 	init_waitqueue_head(&chip->controller->wq);
@@ -1128,11 +1166,14 @@ fail_free_mtd:
 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct pxa3xx_nand_platform_data *pdata;
 	struct resource *r;
-	int irq;
+	int irq, cs;
 
 	if (!info)
 		return 0;
+
+	pdata = pdev->dev.platform_data;
 	platform_set_drvdata(pdev, NULL);
 
 	irq = platform_get_irq(pdev, 0);
@@ -1152,7 +1193,8 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_disable(info->clk);
 	clk_put(info->clk);
 
-	nand_release(info->host->mtd);
+	for (cs = 0; cs < pdata->num_cs; cs++)
+		nand_release(info->host[cs]->mtd);
 	kfree(info);
 	return 0;
 }
@@ -1161,7 +1203,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
-	int ret;
+	int ret, cs, probe_success;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -1176,14 +1218,28 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	}
 
 	info = platform_get_drvdata(pdev);
-	if (pxa3xx_nand_scan(info->host->mtd)) {
-		dev_err(&pdev->dev, "failed to scan nand\n");
+	probe_success = 0;
+	for (cs = 0; cs < pdata->num_cs; cs++) {
+		info->cs = cs;
+		ret = pxa3xx_nand_scan(info->host[cs]->mtd);
+		if (ret) {
+			dev_warn(&pdev->dev, "failed to scan nand at cs %d\n",
+				cs);
+			continue;
+		}
+
+		ret = mtd_device_parse_register(info->host[cs]->mtd, NULL, 0,
+				pdata->parts[cs], pdata->nr_parts[cs]);
+		if (!ret)
+			probe_success = 1;
+	}
+
+	if (!probe_success) {
 		pxa3xx_nand_remove(pdev);
 		return -ENODEV;
 	}
 
-	return mtd_device_parse_register(info->host->mtd, NULL, 0,
-			pdata->parts, pdata->nr_parts);
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1203,8 +1259,12 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
 
-	nand_writel(info, NDTR0CS0, info->host->ndtr0cs0);
-	nand_writel(info, NDTR1CS0, info->host->ndtr1cs0);
+	/*
+	 * Directly set the chip select to a invalid value,
+	 * then the driver would reset the timing according
+	 * to current chip select at the beginning of cmdfunc
+	 */
+	info->cs = 0xff;
 	clk_enable(info->clk);
 
 	return 0;
-- 
1.7.0.4
