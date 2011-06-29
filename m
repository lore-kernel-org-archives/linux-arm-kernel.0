From: leiwen@marvell.com (Lei Wen)
Date: Tue, 28 Jun 2011 20:51:27 -0700
Subject: [PATCH 2/9] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
Message-ID: <1309319494-17951-3-git-send-email-leiwen@marvell.com>
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
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   19 +-
 drivers/mtd/nand/pxa3xx_nand.c               |  493 +++++++++++++++----------
 2 files changed, 313 insertions(+), 199 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 442301f..4e17309 100644
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
@@ -52,8 +65,10 @@ struct pxa3xx_nand_platform_data {
 	/* allow platform code to keep OBM/bootloader defined NFC config */
 	int	keep_config;
 
-	const struct mtd_partition		*parts;
-	unsigned int				nr_parts;
+	/* indicate how many chip selects will be used */
+	int	num_cs;
+	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
+	unsigned int				nr_parts[NUM_CHIP_SELECT];
 
 	const struct pxa3xx_nand_flash * 	flash;
 	size_t					num_flash;
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 44fb210..3ffa6e0 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -110,6 +110,7 @@ enum {
 
 enum {
 	STATE_IDLE = 0,
+	STATE_PREPARED,
 	STATE_CMD_HANDLE,
 	STATE_DMA_READING,
 	STATE_DMA_WRITING,
@@ -120,21 +121,40 @@ enum {
 	STATE_READY,
 };
 
-struct pxa3xx_nand_info {
-	struct nand_chip	nand_chip;
+struct pxa3xx_nand_host {
+	struct nand_chip	chip;
+	struct pxa3xx_nand_cmdset *cmdset;
+	struct mtd_info         *mtd;
+	void			*info_data;
+
+	/* page size of attached chip */
+	unsigned int		page_size;
+	int			cs;
+	int			use_ecc;
+
+	/* calculated from pxa3xx_nand_flash data */
+	unsigned int		col_addr_cycles;
+	unsigned int		row_addr_cycles;
+	size_t			read_id_bytes;
+
+	/* cached register value */
+	uint32_t		reg_ndcr;
+	uint32_t		ndtr0cs0;
+	uint32_t		ndtr1cs0;
+};
 
+struct pxa3xx_nand_info {
 	struct nand_hw_control	controller;
 	struct platform_device	 *pdev;
-	struct pxa3xx_nand_cmdset *cmdset;
 
 	struct clk		*clk;
 	void __iomem		*mmio_base;
 	unsigned long		mmio_phys;
+	struct completion	cmd_complete;
 
 	unsigned int 		buf_start;
 	unsigned int		buf_count;
 
-	struct mtd_info         *mtd;
 	/* DMA information */
 	int			drcmr_dat;
 	int			drcmr_cmd;
@@ -142,44 +162,27 @@ struct pxa3xx_nand_info {
 	unsigned char		*data_buff;
 	unsigned char		*oob_buff;
 	dma_addr_t 		data_buff_phys;
-	size_t			data_buff_size;
 	int 			data_dma_ch;
 	struct pxa_dma_desc	*data_desc;
 	dma_addr_t 		data_desc_addr;
 
-	uint32_t		reg_ndcr;
-
-	/* saved column/page_addr during CMD_SEQIN */
-	int			seqin_column;
-	int			seqin_page_addr;
-
+	struct pxa3xx_nand_host	*host[NUM_CHIP_SELECT];
 	/* relate to the command */
 	unsigned int		state;
 
+	int			cs;
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */
 	int			is_ready;
 
-	unsigned int		page_size;	/* page size of attached chip */
 	unsigned int		data_size;	/* data size in FIFO */
+	unsigned int		oob_size;
 	int 			retcode;
-	struct completion 	cmd_complete;
 
 	/* generated NDCBx register values */
 	uint32_t		ndcb0;
 	uint32_t		ndcb1;
 	uint32_t		ndcb2;
-
-	/* timing calcuted from setting */
-	uint32_t		ndtr0cs0;
-	uint32_t		ndtr1cs0;
-
-	/* calculated from pxa3xx_nand_flash data */
-	size_t		oob_size;
-	size_t		read_id_bytes;
-
-	unsigned int	col_addr_cycles;
-	unsigned int	row_addr_cycles;
 };
 
 static int use_dma = 1;
@@ -225,7 +228,7 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 /* Define a default flash type setting serve as flash detecting only */
 #define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
 
-const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
+const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};
 
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
@@ -241,9 +244,10 @@ const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
 /* convert nano-seconds to nand flash controller clock cycles */
 #define ns2cycle(ns, clk)	(int)((ns) * (clk / 1000000) / 1000)
 
-static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
+static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 				   const struct pxa3xx_nand_timing *t)
 {
+	struct pxa3xx_nand_info *info = host->info_data;
 	unsigned long nand_clk = clk_get_rate(info->clk);
 	uint32_t ndtr0, ndtr1;
 
@@ -258,23 +262,24 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
 		NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk)) |
 		NDTR1_tAR(ns2cycle(t->tAR, nand_clk));
 
-	info->ndtr0cs0 = ndtr0;
-	info->ndtr1cs0 = ndtr1;
+	host->ndtr0cs0 = ndtr0;
+	host->ndtr1cs0 = ndtr1;
 	nand_writel(info, NDTR0CS0, ndtr0);
 	nand_writel(info, NDTR1CS0, ndtr1);
 }
 
 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
-	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;
+	struct pxa3xx_nand_host *host = info->host[info->cs];
+	int oob_enable = host->reg_ndcr & NDCR_SPARE_EN;
 
-	info->data_size = info->page_size;
+	info->data_size = host->page_size;
 	if (!oob_enable) {
 		info->oob_size = 0;
 		return;
 	}
 
-	switch (info->page_size) {
+	switch (host->page_size) {
 	case 2048:
 		info->oob_size = (info->use_ecc) ? 40 : 64;
 		break;
@@ -292,9 +297,10 @@ static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
  */
 static void pxa3xx_nand_start(struct pxa3xx_nand_info *info)
 {
+	struct pxa3xx_nand_host *host = info->host[info->cs];
 	uint32_t ndcr;
 
-	ndcr = info->reg_ndcr;
+	ndcr = host->reg_ndcr;
 	ndcr |= info->use_ecc ? NDCR_ECC_EN : 0;
 	ndcr |= info->use_dma ? NDCR_DMA_EN : 0;
 	ndcr |= NDCR_ND_RUN;
@@ -416,9 +422,17 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
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
-
 	if (status & NDSR_DBERR)
 		info->retcode = ERR_DBERR;
 	if (status & NDSR_SBERR)
@@ -437,11 +451,11 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
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
@@ -463,12 +477,6 @@ NORMAL_IRQ_EXIT:
 	return IRQ_HANDLED;
 }
 
-static int pxa3xx_nand_dev_ready(struct mtd_info *mtd)
-{
-	struct pxa3xx_nand_info *info = mtd->priv;
-	return (nand_readl(info, NDSR) & NDSR_RDY) ? 1 : 0;
-}
-
 static inline int is_buf_blank(uint8_t *buf, size_t len)
 {
 	for (; len > 0; len--)
@@ -481,10 +489,10 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		uint16_t column, int page_addr)
 {
 	uint16_t cmd;
-	int addr_cycle, exec_cmd, ndcb0;
-	struct mtd_info *mtd = info->mtd;
+	int addr_cycle, exec_cmd;
+	struct pxa3xx_nand_host *host = info->host[info->cs];
+	struct mtd_info *mtd = host->mtd;
 
-	ndcb0 = 0;
 	addr_cycle = 0;
 	exec_cmd = 1;
 
@@ -495,6 +503,10 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	info->use_ecc		= 0;
 	info->is_ready		= 0;
 	info->retcode		= ERR_NONE;
+	if (info->cs != 0)
+		info->ndcb0 = NDCB0_CSEL;
+	else
+		info->ndcb0 = 0;
 
 	switch (command) {
 	case NAND_CMD_READ0:
@@ -512,20 +524,19 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		break;
 	}
 
-	info->ndcb0 = ndcb0;
-	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
-				    + info->col_addr_cycles);
+	addr_cycle = NDCB0_ADDR_CYC(host->row_addr_cycles
+				    + host->col_addr_cycles);
 
 	switch (command) {
 	case NAND_CMD_READOOB:
 	case NAND_CMD_READ0:
-		cmd = info->cmdset->read1;
+		cmd = host->cmdset->read1;
 		if (command == NAND_CMD_READOOB)
 			info->buf_start = mtd->writesize + column;
 		else
 			info->buf_start = column;
 
-		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
+		if (unlikely(host->page_size < PAGE_CHUNK_SIZE))
 			info->ndcb0 |= NDCB0_CMD_TYPE(0)
 					| addr_cycle
 					| (cmd & NDCB0_CMD1_MASK);
@@ -537,7 +548,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 
 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
-		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)) {
+		if (unlikely(host->page_size < PAGE_CHUNK_SIZE)) {
 			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);
 
@@ -564,7 +575,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 			break;
 		}
 
-		cmd = info->cmdset->program;
+		cmd = host->cmdset->program;
 		info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
 				| NDCB0_AUTO_RS
 				| NDCB0_ST_ROW_EN
@@ -574,8 +585,8 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		break;
 
 	case NAND_CMD_READID:
-		cmd = info->cmdset->read_id;
-		info->buf_count = info->read_id_bytes;
+		cmd = host->cmdset->read_id;
+		info->buf_count = host->read_id_bytes;
 		info->ndcb0 |= NDCB0_CMD_TYPE(3)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;
@@ -583,7 +594,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		info->data_size = 8;
 		break;
 	case NAND_CMD_STATUS:
-		cmd = info->cmdset->read_status;
+		cmd = host->cmdset->read_status;
 		info->buf_count = 1;
 		info->ndcb0 |= NDCB0_CMD_TYPE(4)
 				| NDCB0_ADDR_CYC(1)
@@ -593,7 +604,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		break;
 
 	case NAND_CMD_ERASE1:
-		cmd = info->cmdset->erase;
+		cmd = host->cmdset->erase;
 		info->ndcb0 |= NDCB0_CMD_TYPE(2)
 				| NDCB0_AUTO_RS
 				| NDCB0_ADDR_CYC(3)
@@ -604,7 +615,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 
 		break;
 	case NAND_CMD_RESET:
-		cmd = info->cmdset->reset;
+		cmd = host->cmdset->reset;
 		info->ndcb0 |= NDCB0_CMD_TYPE(5)
 				| cmd;
 
@@ -627,7 +638,8 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 				int column, int page_addr)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	int ret, exec_cmd;
 
 	/*
@@ -635,9 +647,21 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	 * "byte" address into a "word" address appropriate
 	 * for indexing a word-oriented device
 	 */
-	if (info->reg_ndcr & NDCR_DWIDTH_M)
+	if (host->reg_ndcr & NDCR_DWIDTH_M)
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
+	info->state = STATE_PREPARED;
 	exec_cmd = prepare_command_pool(info, command, column, page_addr);
 	if (exec_cmd) {
 		init_completion(&info->cmd_complete);
@@ -650,8 +674,8 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			/* Stop State Machine for next command cycle */
 			pxa3xx_nand_stop(info);
 		}
-		info->state = STATE_IDLE;
 	}
+	info->state = STATE_IDLE;
 }
 
 static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
@@ -664,7 +688,8 @@ static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
 static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, uint8_t *buf, int page)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 
 	chip->read_buf(mtd, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -695,7 +720,8 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 
 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	char retval = 0xFF;
 
 	if (info->buf_start < info->buf_count)
@@ -707,7 +733,8 @@ static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 
 static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	u16 retval = 0xFFFF;
 
 	if (!(info->buf_start & 0x01) && info->buf_start < info->buf_count) {
@@ -719,7 +746,8 @@ static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 
 static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
 	memcpy(buf, info->data_buff + info->buf_start, real_len);
@@ -729,7 +757,8 @@ static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static void pxa3xx_nand_write_buf(struct mtd_info *mtd,
 		const uint8_t *buf, int len)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
 	memcpy(info->data_buff + info->buf_start, buf, real_len);
@@ -749,7 +778,8 @@ static void pxa3xx_nand_select_chip(struct mtd_info *mtd, int chip)
 
 static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 
 	/* pxa3xx_nand_send_command has waited for command complete */
 	if (this->state == FL_WRITING || this->state == FL_ERASING) {
@@ -772,54 +802,69 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 {
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa3xx_nand_host *host = info->host[info->cs];
 	uint32_t ndcr = 0x0; /* enable all interrupts */
 
-	if (f->page_size != 2048 && f->page_size != 512)
+	if (f->page_size != 2048 && f->page_size != 512) {
+		dev_err(&pdev->dev, "Current only support 2048 and 512 size\n");
 		return -EINVAL;
+	}
 
-	if (f->flash_width != 16 && f->flash_width != 8)
+	if (f->flash_width != 16 && f->flash_width != 8) {
+		dev_err(&pdev->dev, "Only support 8bit and 16 bit!\n");
 		return -EINVAL;
+	}
 
 	/* calculate flash information */
-	info->cmdset = &default_cmdset;
-	info->page_size = f->page_size;
-	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
+	host->cmdset = &default_cmdset;
+	host->page_size = f->page_size;
+	host->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
 
 	/* calculate addressing information */
-	info->col_addr_cycles = (f->page_size == 2048) ? 2 : 1;
+	host->col_addr_cycles = (f->page_size == 2048) ? 2 : 1;
 
 	if (f->num_blocks * f->page_per_block > 65536)
-		info->row_addr_cycles = 3;
+		host->row_addr_cycles = 3;
 	else
-		info->row_addr_cycles = 2;
+		host->row_addr_cycles = 2;
 
 	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
-	ndcr |= (info->col_addr_cycles == 2) ? NDCR_RA_START : 0;
+	ndcr |= (host->col_addr_cycles == 2) ? NDCR_RA_START : 0;
 	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
 	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
 	ndcr |= (f->flash_width == 16) ? NDCR_DWIDTH_M : 0;
 	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;
 
-	ndcr |= NDCR_RD_ID_CNT(info->read_id_bytes);
+	ndcr |= NDCR_RD_ID_CNT(host->read_id_bytes);
 	ndcr |= NDCR_SPARE_EN; /* enable spare by default */
 
-	info->reg_ndcr = ndcr;
+	host->reg_ndcr = ndcr;
 
-	pxa3xx_nand_set_timing(info, f->timing);
+	pxa3xx_nand_set_timing(host, f->timing);
 	return 0;
 }
 
 static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 {
+	/*
+	 * We set 0 by hard coding here, for we don't support keep_config
+	 * when there is more than one chip attached to the controller
+	 */
+	struct pxa3xx_nand_host *host = info->host[0];
 	uint32_t ndcr = nand_readl(info, NDCR);
-	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
-	/* set info fields needed to read id */
-	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
-	info->reg_ndcr = ndcr & ~NDCR_INT_MASK;
-	info->cmdset = &default_cmdset;
 
-	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
-	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
+	if (ndcr & NDCR_PAGE_SZ) {
+		host->page_size = 2048;
+		host->read_id_bytes = 4;
+	} else {
+		host->page_size = 512;
+		host->read_id_bytes = 2;
+	}
+	host->reg_ndcr = ndcr & ~NDCR_INT_MASK;
+	host->cmdset = &default_cmdset;
+
+	host->ndtr0cs0 = nand_readl(info, NDTR0CS0);
+	host->ndtr1cs0 = nand_readl(info, NDTR1CS0);
 
 	return 0;
 }
@@ -829,59 +874,41 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
  * data buffer and the DMA descriptor
  */
 #define MAX_BUFF_SIZE	PAGE_SIZE
-
-static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
+static void free_cs_resource(struct pxa3xx_nand_info *info, int cs)
 {
-	struct platform_device *pdev = info->pdev;
-	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc);
-
-	if (use_dma == 0) {
-		info->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
-		if (info->data_buff == NULL)
-			return -ENOMEM;
-		return 0;
-	}
-
-	info->data_buff = dma_alloc_coherent(&pdev->dev, MAX_BUFF_SIZE,
-				&info->data_buff_phys, GFP_KERNEL);
-	if (info->data_buff == NULL) {
-		dev_err(&pdev->dev, "failed to allocate dma buffer\n");
-		return -ENOMEM;
-	}
-
-	info->data_buff_size = MAX_BUFF_SIZE;
-	info->data_desc = (void *)info->data_buff + data_desc_offset;
-	info->data_desc_addr = info->data_buff_phys + data_desc_offset;
+	struct pxa3xx_nand_host *host;
+	struct mtd_info *mtd;
 
-	info->data_dma_ch = pxa_request_dma("nand-data", DMA_PRIO_LOW,
-				pxa3xx_nand_data_dma_irq, info);
-	if (info->data_dma_ch < 0) {
-		dev_err(&pdev->dev, "failed to request data dma\n");
-		dma_free_coherent(&pdev->dev, info->data_buff_size,
-				info->data_buff, info->data_buff_phys);
-		return info->data_dma_ch;
-	}
+	if (!info->host[cs])
+		return;
 
-	return 0;
+	host = info->host[cs];
+	mtd = host->mtd;
+	kfree(mtd);
+	info->host[cs] = NULL;
 }
 
 static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
 {
-	struct mtd_info *mtd = info->mtd;
-	struct nand_chip *chip = mtd->priv;
+	struct mtd_info *mtd = info->host[info->cs]->mtd;
+	int ret;
 
 	/* use the common timing to make a try */
-	pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
-	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
+	ret = pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
+	if (ret)
+		return ret;
+
+	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
 	if (info->is_ready)
-		return 1;
-	else
 		return 0;
+
+	return -ENODEV;
 }
 
 static int pxa3xx_nand_scan(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct nand_flash_dev pxa3xx_flash_ids[2], *def = NULL;
@@ -891,16 +918,16 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	uint64_t chipsize;
 	int i, ret, num;
 
+	info->cs = host->cs;
 	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
 		goto KEEP_CONFIG;
 
 	ret = pxa3xx_nand_sensing(info);
-	if (!ret) {
-		kfree(mtd);
-		info->mtd = NULL;
+	if (ret) {
+		free_cs_resource(info, info->cs);
 		dev_info(&info->pdev->dev, "There is no nand chip on cs 0!\n");
 
-		return -EINVAL;
+		return ret;
 	}
 
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
@@ -908,8 +935,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (id != 0)
 		dev_info(&info->pdev->dev, "Detect a flash id %x\n", id);
 	else {
-		kfree(mtd);
-		info->mtd = NULL;
+		free_cs_resource(info, info->cs);
 		dev_warn(&info->pdev->dev, "Read out ID 0, "
 				"potential timing set wrong!!\n");
 
@@ -929,14 +955,17 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	}
 
 	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
-		kfree(mtd);
-		info->mtd = NULL;
+		free_cs_resource(info, info->cs);
 		dev_err(&info->pdev->dev, "ERROR!! flash not defined!!!\n");
 
 		return -EINVAL;
 	}
 
-	pxa3xx_nand_config_flash(info, f);
+	ret = pxa3xx_nand_config_flash(info, f);
+	if (ret) {
+		dev_err(&info->pdev->dev, "ERROR! Configure failed\n");
+		return ret;
+	}
 	pxa3xx_flash_ids[0].name = f->name;
 	pxa3xx_flash_ids[0].id = (f->chip_id >> 8) & 0xffff;
 	pxa3xx_flash_ids[0].pagesize = f->page_size;
@@ -951,66 +980,51 @@ KEEP_CONFIG:
 	if (nand_scan_ident(mtd, 1, def))
 		return -ENODEV;
 	/* calculate addressing information */
-	info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
+	if (mtd->writesize >= 2048)
+		host->col_addr_cycles = 2;
+	else
+		host->col_addr_cycles = 1;
 	info->oob_buff = info->data_buff + mtd->writesize;
 	if ((mtd->size >> chip->page_shift) > 65536)
-		info->row_addr_cycles = 3;
+		host->row_addr_cycles = 3;
 	else
-		info->row_addr_cycles = 2;
-	mtd->name = mtd_names[0];
+		host->row_addr_cycles = 2;
+	mtd->name = mtd_names[info->cs];
 	chip->ecc.mode = NAND_ECC_HW;
-	chip->ecc.size = info->page_size;
+	chip->ecc.size = host->page_size;
 
-	chip->options = (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16 : 0;
+	chip->options = 0;
+	if (host->reg_ndcr & NDCR_DWIDTH_M)
+		chip->options = NAND_BUSWIDTH_16;
 	chip->options |= NAND_NO_AUTOINCR;
 	chip->options |= NAND_NO_READRDY;
 
 	return nand_scan_tail(mtd);
 }
 
-static
-struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
+static int alloc_nand_resource(struct platform_device *pdev)
 {
+	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
+	struct pxa3xx_nand_host *host;
 	struct nand_chip *chip;
 	struct mtd_info *mtd;
 	struct resource *r;
-	int ret, irq;
+	int ret, irq, cs;
+	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc);
 
-	mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct pxa3xx_nand_info),
-			GFP_KERNEL);
-	if (!mtd) {
+	pdata = pdev->dev.platform_data;
+	info = kzalloc(sizeof(struct pxa3xx_nand_info), GFP_KERNEL);
+	if (!info) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
-		return NULL;
+		return -ENOMEM;
 	}
-
-	info = (struct pxa3xx_nand_info *)(&mtd[1]);
-	chip = (struct nand_chip *)(&mtd[1]);
 	info->pdev = pdev;
-	info->mtd = mtd;
-	mtd->priv = info;
-	mtd->owner = THIS_MODULE;
-
-	chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
-	chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
-	chip->controller        = &info->controller;
-	chip->waitfunc		= pxa3xx_nand_waitfunc;
-	chip->select_chip	= pxa3xx_nand_select_chip;
-	chip->dev_ready		= pxa3xx_nand_dev_ready;
-	chip->cmdfunc		= pxa3xx_nand_cmdfunc;
-	chip->read_word		= pxa3xx_nand_read_word;
-	chip->read_byte		= pxa3xx_nand_read_byte;
-	chip->read_buf		= pxa3xx_nand_read_buf;
-	chip->write_buf		= pxa3xx_nand_write_buf;
-	chip->verify_buf	= pxa3xx_nand_verify_buf;
-
-	spin_lock_init(&chip->controller->lock);
-	init_waitqueue_head(&chip->controller->wq);
 	info->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed to get nand clock\n");
 		ret = PTR_ERR(info->clk);
-		goto fail_free_mtd;
+		goto fail_alloc;
 	}
 	clk_enable(info->clk);
 
@@ -1059,10 +1073,6 @@ struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 	}
 	info->mmio_phys = r->start;
 
-	ret = pxa3xx_nand_init_buff(info);
-	if (ret)
-		goto fail_free_io;
-
 	/* initialize all interrupts to be disabled */
 	disable_int(info, NDSR_MASK);
 
@@ -1070,21 +1080,80 @@ struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 			  pdev->name, info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto fail_free_buf;
+		ret = ENXIO;
+		goto fail_free_io;
 	}
 
 	platform_set_drvdata(pdev, info);
 
-	return info;
+	for (cs = 0; cs < pdata->num_cs; cs++) {
+		mtd = kzalloc(sizeof(struct mtd_info)
+				+ sizeof(struct pxa3xx_nand_host),
+				GFP_KERNEL);
+		if (!mtd) {
+			dev_err(&pdev->dev, "failed to allocate memory\n");
+			ret = -ENOMEM;
+			goto fail_free_irq;
+		}
+
+		host = (struct pxa3xx_nand_host *)(&mtd[1]);
+		host->info_data = info;
+		host->cs = cs;
+		host->mtd = mtd;
+		mtd->priv = host;
+		mtd->owner = THIS_MODULE;
+		info->host[cs] = host;
+
+		chip = (struct nand_chip *)(&mtd[1]);
+		chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
+		chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
+		chip->waitfunc		= pxa3xx_nand_waitfunc;
+		chip->select_chip	= pxa3xx_nand_select_chip;
+		chip->cmdfunc		= pxa3xx_nand_cmdfunc;
+		chip->read_word		= pxa3xx_nand_read_word;
+		chip->read_byte		= pxa3xx_nand_read_byte;
+		chip->read_buf		= pxa3xx_nand_read_buf;
+		chip->write_buf		= pxa3xx_nand_write_buf;
+		chip->verify_buf	= pxa3xx_nand_verify_buf;
+	}
+
+	if (use_dma == 0) {
+		info->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
+		if (info->data_buff == NULL) {
+			ret = -ENOMEM;
+			goto fail_free_buf;
+		}
+		goto success_exit;
+	}
+
+	info->data_buff = dma_alloc_coherent(&pdev->dev, MAX_BUFF_SIZE,
+			&info->data_buff_phys, GFP_KERNEL);
+	if (info->data_buff == NULL) {
+		dev_err(&pdev->dev, "failed to allocate dma buffer\n");
+		ret = -ENOMEM;
+		goto fail_free_buf;
+	}
+
+	info->data_desc = (void *)info->data_buff + data_desc_offset;
+	info->data_desc_addr = info->data_buff_phys + data_desc_offset;
+	info->data_dma_ch = pxa_request_dma("nand-data", DMA_PRIO_LOW,
+				pxa3xx_nand_data_dma_irq, info);
+	if (info->data_dma_ch < 0) {
+		dev_err(&pdev->dev, "failed to request data dma\n");
+		ret = -ENXIO;
+		goto fail_free_dma_buf;
+	}
+success_exit:
+	return 0;
 
+fail_free_dma_buf:
+	dma_free_writecombine(&pdev->dev, MAX_BUFF_SIZE,
+			info->data_buff, info->data_buff_phys);
 fail_free_buf:
+	for (cs = 0; cs < pdata->num_cs; cs++)
+		free_cs_resource(info, cs);
+fail_free_irq:
 	free_irq(irq, info);
-	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
-		dma_free_coherent(&pdev->dev, info->data_buff_size,
-			info->data_buff, info->data_buff_phys);
-	} else
-		kfree(info->data_buff);
 fail_free_io:
 	iounmap(info->mmio_base);
 fail_free_res:
@@ -1092,18 +1161,20 @@ fail_free_res:
 fail_put_clk:
 	clk_disable(info->clk);
 	clk_put(info->clk);
-fail_free_mtd:
-	kfree(mtd);
-	return NULL;
+fail_alloc:
+	kfree(info);
+	return ret;
 }
 
 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
+	struct pxa3xx_nand_platform_data *pdata;
+	struct pxa3xx_nand_host *host;
 	struct resource *r;
-	int irq;
+	int irq, cs;
 
+	pdata = pdev->dev.platform_data;
 	platform_set_drvdata(pdev, NULL);
 
 	irq = platform_get_irq(pdev, 0);
@@ -1111,7 +1182,7 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 		free_irq(irq, info);
 	if (use_dma) {
 		pxa_free_dma(info->data_dma_ch);
-		dma_free_writecombine(&pdev->dev, info->data_buff_size,
+		dma_free_writecombine(&pdev->dev, MAX_BUFF_SIZE,
 				info->data_buff, info->data_buff_phys);
 	} else
 		kfree(info->data_buff);
@@ -1123,9 +1194,12 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_disable(info->clk);
 	clk_put(info->clk);
 
-	if (mtd) {
-		nand_release(mtd);
-		kfree(mtd);
+	for (cs = 0; cs < pdata->num_cs; cs++) {
+		host = info->host[cs];
+		if (!host)
+			continue;
+		nand_release(host->mtd);
+		free_cs_resource(info, cs);
 	}
 	return 0;
 }
@@ -1134,6 +1208,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
+	int cs, ret, probe_success = 0;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -1141,18 +1216,38 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info = alloc_nand_resource(pdev);
-	if (info == NULL)
-		return -ENOMEM;
+	if (pdata->keep_config && pdata->num_cs > 1) {
+		dev_warn(&pdev->dev, "keep_config is prohibited with multiple"
+			 " chip selects feature!\n");
+		pdata->keep_config = 0;
+	}
+
+	ret = alloc_nand_resource(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "alloc nand resource failed\n");
+		return ret;
+	}
+
+	info = platform_get_drvdata(pdev);
+	for (cs = 0; cs < pdata->num_cs; cs++) {
+		ret = pxa3xx_nand_scan(info->host[cs]->mtd);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to scan nand\n");
+			continue;
+		}
+
+		ret = mtd_device_parse_register(info->host[cs]->mtd, NULL, 0,
+			pdata->parts[cs], pdata->nr_parts[cs]);
+		if (!ret)
+			probe_success = 1;
+	}
 
-	if (pxa3xx_nand_scan(info->mtd)) {
-		dev_err(&pdev->dev, "failed to scan nand\n");
+	if (!probe_success) {
 		pxa3xx_nand_remove(pdev);
 		return -ENODEV;
 	}
 
-	return mtd_device_parse_register(info->mtd, NULL, 0,
-			pdata->parts, pdata->nr_parts);
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1172,8 +1267,12 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
 
-	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
-	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
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
