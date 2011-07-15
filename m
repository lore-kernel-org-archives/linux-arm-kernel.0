From: leiwen@marvell.com (Lei Wen)
Date: Thu, 14 Jul 2011 20:44:32 -0700
Subject: [PATCH V8 3/4] MTD: pxa3xx_nand: sperate each chip individual info
In-Reply-To: <1310481336-13230-1-git-send-email-leiwen@marvell.com>
References: <1310481336-13230-1-git-send-email-leiwen@marvell.com>
Message-ID: <1310701473-31632-4-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For support two chip select, we seperate chip specific info in this
patch.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  292 ++++++++++++++++++++++------------------
 1 files changed, 160 insertions(+), 132 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e55d7f8..97b6894 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -110,6 +110,7 @@ enum {
 
 enum {
 	STATE_IDLE = 0,
+	STATE_PREPARED,
 	STATE_CMD_HANDLE,
 	STATE_DMA_READING,
 	STATE_DMA_WRITING,
@@ -120,21 +121,39 @@ enum {
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
+	int			use_ecc;
 
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
+
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
@@ -142,18 +161,11 @@ struct pxa3xx_nand_info {
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
-	/* relate to the command */
+	struct pxa3xx_nand_host *host;
 	unsigned int		state;
 
 	int			use_ecc;	/* use HW ECC ? */
@@ -162,24 +174,13 @@ struct pxa3xx_nand_info {
 
 	unsigned int		page_size;	/* page size of attached chip */
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
@@ -241,9 +242,10 @@ const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
 /* convert nano-seconds to nand flash controller clock cycles */
 #define ns2cycle(ns, clk)	(int)((ns) * (clk / 1000000) / 1000)
 
-static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
+static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 				   const struct pxa3xx_nand_timing *t)
 {
+	struct pxa3xx_nand_info *info = host->info_data;
 	unsigned long nand_clk = clk_get_rate(info->clk);
 	uint32_t ndtr0, ndtr1;
 
@@ -258,23 +260,24 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
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
+	struct pxa3xx_nand_host *host = info->host;
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
@@ -292,9 +295,10 @@ static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
  */
 static void pxa3xx_nand_start(struct pxa3xx_nand_info *info)
 {
+	struct pxa3xx_nand_host *host = info->host;
 	uint32_t ndcr;
 
-	ndcr = info->reg_ndcr;
+	ndcr = host->reg_ndcr;
 	ndcr |= info->use_ecc ? NDCR_ECC_EN : 0;
 	ndcr |= info->use_dma ? NDCR_DMA_EN : 0;
 	ndcr |= NDCR_ND_RUN;
@@ -463,12 +467,6 @@ NORMAL_IRQ_EXIT:
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
@@ -481,10 +479,10 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		uint16_t column, int page_addr)
 {
 	uint16_t cmd;
-	int addr_cycle, exec_cmd, ndcb0;
-	struct mtd_info *mtd = info->mtd;
+	int addr_cycle, exec_cmd;
+	struct pxa3xx_nand_host *host = info->host;
+	struct mtd_info *mtd = host->mtd;
 
-	ndcb0 = 0;
 	addr_cycle = 0;
 	exec_cmd = 1;
 
@@ -494,6 +492,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	info->oob_size		= 0;
 	info->use_ecc		= 0;
 	info->is_ready		= 0;
+	info->ndcb0		= 0;
 	info->retcode		= ERR_NONE;
 
 	switch (command) {
@@ -512,20 +511,19 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
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
@@ -537,7 +535,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 
 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
-		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)) {
+		if (unlikely(host->page_size < PAGE_CHUNK_SIZE)) {
 			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);
 
@@ -564,7 +562,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 			break;
 		}
 
-		cmd = info->cmdset->program;
+		cmd = host->cmdset->program;
 		info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
 				| NDCB0_AUTO_RS
 				| NDCB0_ST_ROW_EN
@@ -574,8 +572,8 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		break;
 
 	case NAND_CMD_READID:
-		cmd = info->cmdset->read_id;
-		info->buf_count = info->read_id_bytes;
+		cmd = host->cmdset->read_id;
+		info->buf_count = host->read_id_bytes;
 		info->ndcb0 |= NDCB0_CMD_TYPE(3)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;
@@ -583,7 +581,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		info->data_size = 8;
 		break;
 	case NAND_CMD_STATUS:
-		cmd = info->cmdset->read_status;
+		cmd = host->cmdset->read_status;
 		info->buf_count = 1;
 		info->ndcb0 |= NDCB0_CMD_TYPE(4)
 				| NDCB0_ADDR_CYC(1)
@@ -593,7 +591,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 		break;
 
 	case NAND_CMD_ERASE1:
-		cmd = info->cmdset->erase;
+		cmd = host->cmdset->erase;
 		info->ndcb0 |= NDCB0_CMD_TYPE(2)
 				| NDCB0_AUTO_RS
 				| NDCB0_ADDR_CYC(3)
@@ -604,7 +602,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 
 		break;
 	case NAND_CMD_RESET:
-		cmd = info->cmdset->reset;
+		cmd = host->cmdset->reset;
 		info->ndcb0 |= NDCB0_CMD_TYPE(5)
 				| cmd;
 
@@ -627,7 +625,8 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 				int column, int page_addr)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	int ret, exec_cmd;
 
 	/*
@@ -635,9 +634,10 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	 * "byte" address into a "word" address appropriate
 	 * for indexing a word-oriented device
 	 */
-	if (info->reg_ndcr & NDCR_DWIDTH_M)
+	if (host->reg_ndcr & NDCR_DWIDTH_M)
 		column /= 2;
 
+	info->state = STATE_PREPARED;
 	exec_cmd = prepare_command_pool(info, command, column, page_addr);
 	if (exec_cmd) {
 		init_completion(&info->cmd_complete);
@@ -650,8 +650,8 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			/* Stop State Machine for next command cycle */
 			pxa3xx_nand_stop(info);
 		}
-		info->state = STATE_IDLE;
 	}
+	info->state = STATE_IDLE;
 }
 
 static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
@@ -664,7 +664,8 @@ static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
 static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, uint8_t *buf, int page)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 
 	chip->read_buf(mtd, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -695,7 +696,8 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 
 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	char retval = 0xFF;
 
 	if (info->buf_start < info->buf_count)
@@ -707,7 +709,8 @@ static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 
 static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	u16 retval = 0xFFFF;
 
 	if (!(info->buf_start & 0x01) && info->buf_start < info->buf_count) {
@@ -719,7 +722,8 @@ static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 
 static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
 	memcpy(buf, info->data_buff + info->buf_start, real_len);
@@ -729,7 +733,8 @@ static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 static void pxa3xx_nand_write_buf(struct mtd_info *mtd,
 		const uint8_t *buf, int len)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
 
 	memcpy(info->data_buff + info->buf_start, buf, real_len);
@@ -749,7 +754,8 @@ static void pxa3xx_nand_select_chip(struct mtd_info *mtd, int chip)
 
 static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
 
 	/* pxa3xx_nand_send_command has waited for command complete */
 	if (this->state == FL_WRITING || this->state == FL_ERASING) {
@@ -772,6 +778,7 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 {
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa3xx_nand_host *host = info->host;
 	uint32_t ndcr = 0x0; /* enable all interrupts */
 
 	if (f->page_size != 2048 && f->page_size != 512) {
@@ -785,45 +792,52 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 	}
 
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
+	struct pxa3xx_nand_host *host = info->host;
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
+
+	host->reg_ndcr = ndcr & ~NDCR_INT_MASK;
+	host->cmdset = &default_cmdset;
+
+	host->ndtr0cs0 = nand_readl(info, NDTR0CS0);
+	host->ndtr1cs0 = nand_readl(info, NDTR1CS0);
 
 	return 0;
 }
@@ -853,7 +867,6 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 		return -ENOMEM;
 	}
 
-	info->data_buff_size = MAX_BUFF_SIZE;
 	info->data_desc = (void *)info->data_buff + data_desc_offset;
 	info->data_desc_addr = info->data_buff_phys + data_desc_offset;
 
@@ -861,7 +874,7 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 				pxa3xx_nand_data_dma_irq, info);
 	if (info->data_dma_ch < 0) {
 		dev_err(&pdev->dev, "failed to request data dma\n");
-		dma_free_coherent(&pdev->dev, info->data_buff_size,
+		dma_free_coherent(&pdev->dev, MAX_BUFF_SIZE,
 				info->data_buff, info->data_buff_phys);
 		return info->data_dma_ch;
 	}
@@ -871,21 +884,25 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 
 static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
 {
-	struct mtd_info *mtd = info->mtd;
-	struct nand_chip *chip = mtd->priv;
+	struct mtd_info *mtd = info->host->mtd;
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
@@ -899,12 +916,10 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		goto KEEP_CONFIG;
 
 	ret = pxa3xx_nand_sensing(info);
-	if (!ret) {
-		kfree(mtd);
-		info->mtd = NULL;
+	if (ret) {
 		dev_info(&info->pdev->dev, "There is no nand chip on cs 0!\n");
 
-		return -EINVAL;
+		return ret;
 	}
 
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
@@ -912,8 +927,6 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (id != 0)
 		dev_info(&info->pdev->dev, "Detect a flash id %x\n", id);
 	else {
-		kfree(mtd);
-		info->mtd = NULL;
 		dev_warn(&info->pdev->dev,
 			 "Read out ID 0, potential timing set wrong!!\n");
 
@@ -933,14 +946,17 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	}
 
 	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
-		kfree(mtd);
-		info->mtd = NULL;
 		dev_err(&info->pdev->dev, "ERROR!! flash not defined!!!\n");
 
 		return -EINVAL;
 	}
 
-	pxa3xx_nand_config_flash(info, f);
+	ret = pxa3xx_nand_config_flash(info, f);
+	if (ret) {
+		dev_err(&info->pdev->dev, "ERROR! Configure failed\n");
+		return ret;
+	}
+
 	pxa3xx_flash_ids[0].name = f->name;
 	pxa3xx_flash_ids[0].id = (f->chip_id >> 8) & 0xffff;
 	pxa3xx_flash_ids[0].pagesize = f->page_size;
@@ -952,47 +968,56 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	pxa3xx_flash_ids[1].name = NULL;
 	def = pxa3xx_flash_ids;
 KEEP_CONFIG:
+	chip->ecc.mode = NAND_ECC_HW;
+	chip->ecc.size = host->page_size;
+
+	chip->options = NAND_NO_AUTOINCR;
+	chip->options |= NAND_NO_READRDY;
+	if (host->reg_ndcr & NDCR_DWIDTH_M)
+		chip->options |= NAND_BUSWIDTH_16;
+
 	if (nand_scan_ident(mtd, 1, def))
 		return -ENODEV;
 	/* calculate addressing information */
-	info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
+	if (mtd->writesize >= 2048)
+		host->col_addr_cycles = 2;
+	else
+		host->col_addr_cycles = 1;
+
 	info->oob_buff = info->data_buff + mtd->writesize;
 	if ((mtd->size >> chip->page_shift) > 65536)
-		info->row_addr_cycles = 3;
+		host->row_addr_cycles = 3;
 	else
-		info->row_addr_cycles = 2;
-	mtd->name = mtd_names[0];
-	chip->ecc.mode = NAND_ECC_HW;
-	chip->ecc.size = info->page_size;
-
-	chip->options = (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16 : 0;
-	chip->options |= NAND_NO_AUTOINCR;
-	chip->options |= NAND_NO_READRDY;
+		host->row_addr_cycles = 2;
 
+	mtd->name = mtd_names[0];
 	return nand_scan_tail(mtd);
 }
 
-static
-struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
+static int alloc_nand_resource(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info;
+	struct pxa3xx_nand_host *host;
 	struct nand_chip *chip;
 	struct mtd_info *mtd;
 	struct resource *r;
 	int ret, irq;
 
-	mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct pxa3xx_nand_info),
+	info = kzalloc(sizeof(*info) + sizeof(*mtd) + sizeof(*host),
 			GFP_KERNEL);
-	if (!mtd) {
+	if (!info) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
-		return NULL;
+		return -ENOMEM;
 	}
 
-	info = (struct pxa3xx_nand_info *)(&mtd[1]);
+	mtd = (struct mtd_info *)(&info[1]);
 	chip = (struct nand_chip *)(&mtd[1]);
+	host = (struct pxa3xx_nand_host *)chip;
 	info->pdev = pdev;
-	info->mtd = mtd;
-	mtd->priv = info;
+	info->host = host;
+	host->mtd = mtd;
+	host->info_data = info;
+	mtd->priv = host;
 	mtd->owner = THIS_MODULE;
 
 	chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
@@ -1000,7 +1025,6 @@ struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 	chip->controller        = &info->controller;
 	chip->waitfunc		= pxa3xx_nand_waitfunc;
 	chip->select_chip	= pxa3xx_nand_select_chip;
-	chip->dev_ready		= pxa3xx_nand_dev_ready;
 	chip->cmdfunc		= pxa3xx_nand_cmdfunc;
 	chip->read_word		= pxa3xx_nand_read_word;
 	chip->read_byte		= pxa3xx_nand_read_byte;
@@ -1079,13 +1103,13 @@ struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	return info;
+	return 0;
 
 fail_free_buf:
 	free_irq(irq, info);
 	if (use_dma) {
 		pxa_free_dma(info->data_dma_ch);
-		dma_free_coherent(&pdev->dev, info->data_buff_size,
+		dma_free_coherent(&pdev->dev, MAX_BUFF_SIZE,
 			info->data_buff, info->data_buff_phys);
 	} else
 		kfree(info->data_buff);
@@ -1097,17 +1121,19 @@ fail_put_clk:
 	clk_disable(info->clk);
 	clk_put(info->clk);
 fail_free_mtd:
-	kfree(mtd);
-	return NULL;
+	kfree(info);
+	return ret;
 }
 
 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
 	struct resource *r;
 	int irq;
 
+	if (!info)
+		return 0;
+
 	platform_set_drvdata(pdev, NULL);
 
 	irq = platform_get_irq(pdev, 0);
@@ -1115,7 +1141,7 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 		free_irq(irq, info);
 	if (use_dma) {
 		pxa_free_dma(info->data_dma_ch);
-		dma_free_writecombine(&pdev->dev, info->data_buff_size,
+		dma_free_writecombine(&pdev->dev, MAX_BUFF_SIZE,
 				info->data_buff, info->data_buff_phys);
 	} else
 		kfree(info->data_buff);
@@ -1127,10 +1153,8 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_disable(info->clk);
 	clk_put(info->clk);
 
-	if (mtd) {
-		nand_release(mtd);
-		kfree(mtd);
-	}
+	nand_release(info->host->mtd);
+	kfree(info);
 	return 0;
 }
 
@@ -1138,6 +1162,7 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
+	int ret;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -1145,17 +1170,20 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info = alloc_nand_resource(pdev);
-	if (info == NULL)
-		return -ENOMEM;
+	ret = alloc_nand_resource(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "alloc nand resource failed\n");
+		return ret;
+	}
 
-	if (pxa3xx_nand_scan(info->mtd)) {
+	info = platform_get_drvdata(pdev);
+	if (pxa3xx_nand_scan(info->host->mtd)) {
 		dev_err(&pdev->dev, "failed to scan nand\n");
 		pxa3xx_nand_remove(pdev);
 		return -ENODEV;
 	}
 
-	return mtd_device_parse_register(info->mtd, NULL, 0,
+	return mtd_device_parse_register(info->host->mtd, NULL, 0,
 			pdata->parts, pdata->nr_parts);
 }
 
@@ -1182,8 +1210,8 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
 	/* We don't want to handle interrupt without calling mtd routine */
 	disable_int(info, NDCR_INT_MASK);
 
-	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
-	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
+	nand_writel(info, NDTR0CS0, info->host->ndtr0cs0);
+	nand_writel(info, NDTR1CS0, info->host->ndtr1cs0);
 
 	/*
 	 * As the spec says, the NDSR would be updated to 0x1800 when
-- 
1.7.0.4
