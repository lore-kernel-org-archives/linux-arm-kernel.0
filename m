From: leiwen@marvell.com (Lei Wen)
Date: Thu,  7 Jul 2011 20:34:44 -0700
Subject: [PATCH 3/3] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309771536-10597-1-git-send-email-leiwen@marvell.com>
References: <1309771536-10597-1-git-send-email-leiwen@marvell.com>
Message-ID: <1310096084-14646-4-git-send-email-leiwen@marvell.com>
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
 arch/arm/mach-mmp/aspenite.c                 |    5 +-
 arch/arm/mach-pxa/cm-x300.c                  |    5 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c           |    5 +-
 arch/arm/mach-pxa/littleton.c                |    5 +-
 arch/arm/mach-pxa/mxm8x10.c                  |    9 +-
 arch/arm/mach-pxa/raumfeld.c                 |    5 +-
 arch/arm/mach-pxa/zylonite.c                 |    5 +-
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   20 +++-
 drivers/mtd/nand/pxa3xx_nand.c               |  151 ++++++++++++++++++--------
 9 files changed, 146 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5fa8..c4996f3 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -167,8 +167,9 @@ static struct mtd_partition aspenite_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data aspenite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= aspenite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(aspenite_nand_partitions),
+	.num_cs = 1,
+	.parts[0]	= aspenite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(aspenite_nand_partitions),
 };
 
 static struct i2c_board_info aspenite_i2c_info[] __initdata = {
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index b2248e7..969d252 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -423,8 +423,9 @@ static struct mtd_partition cm_x300_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data cm_x300_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= cm_x300_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(cm_x300_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= cm_x300_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(cm_x300_nand_partitions),
 };
 
 static void __init cm_x300_init_nand(void)
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 3f9be41..2b8ca0d 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -139,8 +139,9 @@ static struct mtd_partition colibri_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data colibri_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= colibri_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(colibri_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= colibri_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(colibri_nand_partitions),
 };
 
 void __init colibri_pxa3xx_init_nand(void)
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index e5e326d..f6d1f9d 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -325,8 +325,9 @@ static struct mtd_partition littleton_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data littleton_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= littleton_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(littleton_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= littleton_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(littleton_nand_partitions),
 };
 
 static void __init littleton_init_nand(void)
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index b5a8fd3..90928d6 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -389,10 +389,11 @@ static struct mtd_partition mxm_8x10_nand_partitions[] = {
 };
 
 static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
-	.enable_arbiter = 1,
-	.keep_config = 1,
-	.parts = mxm_8x10_nand_partitions,
-	.nr_parts = ARRAY_SIZE(mxm_8x10_nand_partitions)
+	.enable_arbiter	= 1,
+	.keep_config	= 1,
+	.num_cs		= 1,
+	.parts[0]	= mxm_8x10_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(mxm_8x10_nand_partitions)
 };
 
 static void __init mxm_8x10_nand_init(void)
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d130f77..c7ec847 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -349,8 +349,9 @@ static struct mtd_partition raumfeld_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data raumfeld_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= raumfeld_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(raumfeld_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= raumfeld_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(raumfeld_nand_partitions),
 };
 
 /**
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 5821185..64fdac9 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -366,8 +366,9 @@ static struct mtd_partition zylonite_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data zylonite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= zylonite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(zylonite_nand_partitions),
+	.num_cs		= 1,
+	.parts[0]	= zylonite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(zylonite_nand_partitions),
 };
 
 static void __init zylonite_init_nand(void)
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
index d94896a..ceabd51 100644
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
@@ -884,9 +915,9 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 
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
@@ -918,7 +949,8 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	ret = pxa3xx_nand_sensing(info);
 	if (ret) {
 		host->mtd = NULL;
-		dev_info(&info->pdev->dev, "There is no nand chip on cs 0!\n");
+		dev_info(&info->pdev->dev, "There is no nand chip on cs %d!\n",
+			 info->cs);
 
 		return ret;
 	}
@@ -999,41 +1031,47 @@ KEEP_CONFIG:
 
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
@@ -1131,12 +1169,14 @@ fail_free_mtd:
 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
+	struct pxa3xx_nand_platform_data *pdata;
 	struct resource *r;
-	int irq;
+	int irq, cs;
 
 	if (!info)
 		return 0;
 
+	pdata = pdev->dev.platform_data;
 	platform_set_drvdata(pdev, NULL);
 
 	irq = platform_get_irq(pdev, 0);
@@ -1156,7 +1196,8 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_disable(info->clk);
 	clk_put(info->clk);
 
-	nand_release(info->host->mtd);
+	for (cs = 0; cs < pdata->num_cs; cs++)
+		nand_release(info->host[cs]->mtd);
 	kfree(info);
 	return 0;
 }
@@ -1165,7 +1206,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
-	int ret;
+	int ret, cs, probe_success;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -1180,14 +1221,28 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
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
@@ -1207,8 +1262,12 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
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
