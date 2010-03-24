From: leiwen@marvell.com (Lei Wen)
Date: Wed, 24 Mar 2010 10:10:33 +0800
Subject: [PATCH] pxa3xx_nand: enable 4k page operation
Message-ID: <mailman.383.1273136985.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For limitation of our controller, we only could do large page
nand chip by dividing the original page size into what we could
afford. We call one divide operation as chunk.

The divide operation need naked command support, which may not
be existed in so old version. You could check it first before
you want to use this feature.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    4 +-
 drivers/mtd/nand/pxa3xx_nand.c               |  356 +++++++++++++++++++++-----
 2 files changed, 293 insertions(+), 67 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 76ebd21..7c99390 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -13,8 +13,8 @@ struct pxa3xx_nand_platform_data {
 	 */
 	int	enable_arbiter;

-	/* allow platform code to keep OBM/bootloader defined NFC config */
-	int	keep_config;
+	/* Whether the controller support using naked command set */
+	int	naked_cmd_support;

 	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
 	unsigned int				nr_parts[NUM_CHIP_SELECT];
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 0674b52..94702df 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -30,6 +30,7 @@
 #define NAND_STOP_DELAY		(2 * HZ/50)
 #define PAGE_CHUNK_SIZE		(2048)
 #define BCH_THRESHOLD           (8)
+#define CMD_POOL_SIZE           (5)
 #undef PXA3XX_NAND_DEBUG
 #ifdef PXA3XX_NAND_DEBUG
 #define DBG_NAND(x)	do{x;}while(0)
@@ -45,7 +46,9 @@
 #define NDPCR		(0x18) /* Page Count Register */
 #define NDBDR0		(0x1C) /* Bad Block Register 0 */
 #define NDBDR1		(0x20) /* Bad Block Register 1 */
+#define NDREDEL		(0x24) /* Read Enable Return Delay Register */
 #define NDECCCTRL	(0x28) /* ECC Control Register */
+#define NDBZCNT		(0x2C) /* Timer for NDRnB0 and NDRnB1 */
 #define NDDB		(0x40) /* Data Buffer */
 #define NDCB0		(0x48) /* Command Buffer0 */
 #define NDCB1		(0x4C) /* Command Buffer1 */
@@ -59,19 +62,32 @@
 #define NDCR_ND_RUN		(0x1 << 28)
 #define NDCR_DWIDTH_C		(0x1 << 27)
 #define NDCR_DWIDTH_M		(0x1 << 26)
-#define NDCR_PAGE_SZ		(0x1 << 24)
-#define NDCR_NCSX		(0x1 << 23)
-#define NDCR_STOP_ON_UNCOR	(0x1 << 22)
-#define NDCR_ND_MODE		(0x3 << 21)
-#define NDCR_NAND_MODE   	(0x0)
+#define NDCR_PAGE_SZ_MASK	(0x3 << 24)
+#define NDCR_PAGE_SZ(x)		(((x) << 24) & NDCR_PAGE_SZ_MASK)
+#define NDCR_SEQ_DIS		(0x1 << 23)
+#define NDCR_ND_STOP		(0x1 << 22)
+#define NDCR_FORCE_CSX		(0x1 << 21)
 #define NDCR_CLR_PG_CNT		(0x1 << 20)
-#define NDCR_CLR_ECC		(0x1 << 19)
+#define NDCR_STOP_ON_UNCOR	(0x1 << 19)
 #define NDCR_RD_ID_CNT_MASK	(0x7 << 16)
 #define NDCR_RD_ID_CNT(x)	(((x) << 16) & NDCR_RD_ID_CNT_MASK)

 #define NDCR_RA_START		(0x1 << 15)
-#define NDCR_PG_PER_BLK		(0x1 << 14)
+#define NDCR_PG_PER_BLK_MASK	(0x3 << 13)
+#define NDCR_PG_PER_BLK(x)	(((x) << 13) & NDCR_PG_PER_BLK_MASK)
 #define NDCR_ND_ARB_EN		(0x1 << 12)
+#define NDCR_RDYM               (0x1 << 11)
+#define NDCR_CS0_PAGEDM         (0x1 << 10)
+#define NDCR_CS1_PAGEDM         (0x1 << 9)
+#define NDCR_CS0_CMDDM          (0x1 << 8)
+#define NDCR_CS1_CMDDM          (0x1 << 7)
+#define NDCR_CS0_BBDM           (0x1 << 6)
+#define NDCR_CS1_BBDM           (0x1 << 5)
+#define NDCR_UNCERRM            (0x1 << 4)
+#define NDCR_CORERRM            (0x1 << 3)
+#define NDCR_WRDREQM            (0x1 << 2)
+#define NDCR_RDDREQM            (0x1 << 1)
+#define NDCR_WRCMDREQM          (0x1)
 #define NDCR_INT_MASK           (0xFFF)

 #define NDSR_MASK		(0xfff)
@@ -89,6 +105,8 @@
 #define NDSR_RDDREQ		(0x1 << 1)
 #define NDSR_WRCMDREQ		(0x1)

+#define NDCB0_CMD_XTYPE_MASK    (0x7 << 29)
+#define NDCB0_CMD_XTYPE(x)      (((x) << 29) & NDCB0_CMD_XTYPE_MASK)
 #define NDCB0_ST_ROW_EN         (0x1 << 26)
 #define NDCB0_AUTO_RS		(0x1 << 25)
 #define NDCB0_CSEL		(0x1 << 24)
@@ -139,6 +157,7 @@ enum {
 	STATE_IS_WRITE		= (1 << 7),
 };

+#define STATE_MASK		(0x3f)
 /* error code and state */
 enum {
 	ECC_NONE = 0,
@@ -153,9 +172,9 @@ struct pxa3xx_nand_timing {
 	uint32_t	tWP;  /* ND_nWE pulse time */
 	uint32_t	tRH;  /* ND_nRE high duration */
 	uint32_t	tRP;  /* ND_nRE pulse width */
-	uint32_t	tAR;  /* ND_ALE low to ND_nRE low delay */
-	uint32_t	tWHR; /* ND_nWE high to ND_nRE low for status read */
 	uint32_t	tR;   /* ND_nWE high to ND_nRE low for read */
+	uint32_t	tWHR; /* ND_nWE high to ND_nRE low for status read */
+	uint32_t	tAR;  /* ND_ALE low to ND_nRE low delay */
 };

 struct pxa3xx_nand_cmdset {
@@ -185,7 +204,9 @@ struct pxa3xx_nand_flash {
 struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;

-	uint32_t		page_size;	/* page size of attached chip */
+	uint16_t		page_size;	/* page size of attached chip */
+	uint16_t		data_column;
+	uint16_t		oob_column;
 	unsigned char		*data_buff;
 	unsigned char		*oob_buff;
 	uint32_t		buf_start;
@@ -208,12 +229,15 @@ struct pxa3xx_nand_info {
 	uint8_t			read_id_bytes;

 	/* cached register value */
+	uint8_t			cmd_seqs;
+	uint8_t			total_cmds;
+	uint8_t			wait_ready[CMD_POOL_SIZE];
+	uint32_t		ndcb0[CMD_POOL_SIZE];
+	uint32_t		ndcb1;
+	uint32_t		ndcb2;
 	uint32_t		reg_ndcr;
 	uint32_t		ndtr0cs0;
 	uint32_t		ndtr1cs0;
-	uint32_t		ndcb0;
-	uint32_t		ndcb1;
-	uint32_t		ndcb2;

 	void			*nand_data;
 };
@@ -250,6 +274,10 @@ static int use_dma = 1;
 module_param(use_dma, bool, 0444);
 MODULE_PARM_DESC(use_dma, "enable DMA for data transfering to/from NAND HW");

+static int naked_cmd_support = 0;
+module_param(naked_cmd_support, bool, 0444);
+MODULE_PARM_DESC(naked_cmd_support, "Whether the controller support
using naked command set");
+
 const static struct pxa3xx_nand_cmdset cmdset = {
 	.read1		= 0x3000,
 	.read2		= 0x0050,
@@ -286,6 +314,8 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
 { 0xcc2c, 64, 2048, 16, 16, ECC_HAMMIN, 4096, \
 	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+{ 0x382c, 128, 4096, 8, 8, ECC_BCH, 2048, \
+	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
 { 0xba20, 64, 2048, 16, 16, ECC_HAMMIN, 2048, \
 	{ 10, 35, 15, 25, 15, 25, 25000, 60, 10, }, },
 };
@@ -460,27 +490,77 @@ static void disable_int(struct pxa3xx_nand
*nand, uint32_t int_mask)
 	nand_writel(nand, NDCR, ndcr | int_mask);
 }

+static void nand_error_dump(struct pxa3xx_nand *nand)
+{
+	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
+	int i;
+
+	printk(KERN_ERR "NAND controller state wrong!!!\n");
+	printk(KERN_ERR "command %x, state %x, current seqs %d, errcode %x,
bad count %d\n",
+			nand->command, nand->state, info->cmd_seqs,
+			nand->retcode, nand->bad_count);
+	printk(KERN_ERR "Totally %d command for sending\n",
+			info->total_cmds);
+	for (i = 0; i < info->total_cmds; i ++)
+		printk(KERN_ERR "NDCB0:%d: %x\n",
+				i, info->ndcb0[i]);
+	printk(KERN_ERR "NDCB1: %x; NDCB2 %x\n", info->ndcb1, info->ndcb2);
+
+	printk(KERN_ERR "\nRegister DUMPing ##############\n");
+	printk(KERN_ERR "NDCR %x\n"
+			"NDSR %x\n"
+			"NDCB0 %x\n"
+			"NDCB1 %x\n"
+			"NDCB2 %x\n"
+			"NDTR0CS0 %x\n"
+			"NDTR1CS0 %x\n"
+			"NDBDR0 %x\n"
+			"NDBDR1 %x\n"
+			"NDREDEL %x\n"
+			"NDECCCTRL %x\n"
+			"NDBZCNT %x\n\n",
+			nand_readl(nand, NDCR),
+			nand_readl(nand, NDSR),
+			nand_readl(nand, NDCB0),
+			nand_readl(nand, NDCB1),
+			nand_readl(nand, NDCB2),
+			nand_readl(nand, NDTR0CS0),
+			nand_readl(nand, NDTR1CS0),
+			nand_readl(nand, NDBDR0),
+			nand_readl(nand, NDBDR1),
+			nand_readl(nand, NDREDEL),
+			nand_readl(nand, NDECCCTRL),
+			nand_readl(nand, NDBZCNT));
+}
+
 static void handle_data_pio(struct pxa3xx_nand *nand)
 {
 	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
+	unsigned int data_size, oob_size;

-	DBG_NAND(printk("data size %x, oob size %x\n",
-				nand->data_size, nand->oob_size));
+	data_size = DIV_ROUND_UP(nand->data_size, 4);
+	oob_size = DIV_ROUND_UP(nand->oob_size, 4);
+	DBG_NAND(printk("data col %x, size %x, oob col %x size %x\n",
+				info->data_column, nand->data_size,
+				info->oob_column, nand->oob_size));
 	if (nand->state & STATE_IS_WRITE) {
-		__raw_writesl(nand->mmio_base + NDDB, info->data_buff,
-				DIV_ROUND_UP(nand->data_size, 4));
+		__raw_writesl(nand->mmio_base + NDDB,
+				info->data_buff + info->data_column, data_size);
 		if (nand->oob_size > 0)
-			__raw_writesl(nand->mmio_base + NDDB, info->oob_buff,
-					DIV_ROUND_UP(nand->oob_size, 4));
+			__raw_writesl(nand->mmio_base + NDDB,
+				info->oob_buff + info->oob_column, oob_size);

 	}
 	else {
-		__raw_readsl(nand->mmio_base + NDDB, info->data_buff,
-				DIV_ROUND_UP(nand->data_size, 4));
+		__raw_readsl(nand->mmio_base + NDDB,
+				info->data_buff + info->data_column, data_size);
 		if (nand->oob_size > 0)
-			__raw_readsl(nand->mmio_base + NDDB, info->oob_buff,
-					DIV_ROUND_UP(nand->oob_size, 4));
+			__raw_readsl(nand->mmio_base + NDDB,
+				info->oob_buff + info->oob_column, oob_size);
 	}
+
+	info->data_column += (data_size << 2);
+	info->oob_column += (oob_size << 2);
 }

 static void start_data_dma(struct pxa3xx_nand *nand, int dir_out)
@@ -493,11 +573,11 @@ static void start_data_dma(struct pxa3xx_nand
*nand, int dir_out)
 	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;

 	if (dir_out) {
-		desc->dsadr = info->data_buff_phys;
+		desc->dsadr = info->data_buff_phys + info->data_column;
 		desc->dtadr = nand->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCSRCADDR | DCMD_FLOWTRG;
 	} else {
-		desc->dtadr = info->data_buff_phys;
+		desc->dtadr = info->data_buff_phys + info->data_column;
 		desc->dsadr = nand->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
 	}
@@ -512,7 +592,8 @@ static void start_data_dma(struct pxa3xx_nand
*nand, int dir_out)
 static void pxa3xx_nand_data_dma_irq(int channel, void *data)
 {
 	struct pxa3xx_nand *nand = data;
-	uint32_t dcsr;
+	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
+	uint32_t dcsr, i, tmp;

 	dcsr = DCSR(channel);
 	DCSR(channel) = dcsr;
@@ -522,6 +603,27 @@ static void pxa3xx_nand_data_dma_irq(int channel,
void *data)
 		nand->retcode = ERR_DMABUSERR;
 	}

+	/*
+	 * Here we need a workaround as flash layout is not our need
+	 * Should notice this is only applied to 4K page size NAND
+	 * In the first step, copy the first oob to the last part
+	 * then kick the second chunk data next to the first data.
+	 * After this, the two oob chunk would be at wrong order,
+	 * that is also why we need to swap those two parts.
+	 */
+	if (info->page_size > PAGE_CHUNK_SIZE && nand->oob_size > 0) {
+		if (info->data_column == 0)
+			memcpy(info->oob_buff + nand->oob_size, info->data_buff
+				+ nand->oob_size, nand->oob_size);
+		else
+			for (i = 0; i < nand->oob_size; i ++) {
+				tmp = info->oob_buff[i];
+				info->oob_buff[i] = info->oob_buff[nand->oob_size + i];
+				info->oob_buff[nand->oob_size + i] = tmp;
+			}
+	}
+
+	info->data_column += nand->data_size;
 	enable_int(nand, NDCR_INT_MASK);
 	nand_writel(nand, NDSR, NDSR_WRDREQ | NDSR_RDDREQ);
 }
@@ -530,7 +632,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 {
 	struct pxa3xx_nand *nand = devid;
 	struct pxa3xx_nand_info *info;
-	unsigned int status, is_completed = 0, cs;
+	unsigned int status, is_completed = 0, cs, cmd_seqs, ndcb1, ndcb2;
 	unsigned int ready, cmd_done, page_done, badblock_detect;

 	cs		= nand->chip_select;
@@ -539,10 +641,11 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	page_done       = (cs) ? NDSR_CS1_PAGED : NDSR_CS0_PAGED;
 	badblock_detect = (cs) ? NDSR_CS1_BBD : NDSR_CS0_BBD;
 	info            = nand->info[cs];
+	cmd_seqs	= info->cmd_seqs;

 	status = nand_readl(nand, NDSR);
 	DBG_NAND(if (status != 0)
-		printk("\t\tstatus %x, cs %x\n", status, cs));
+		printk("\t\t==cmd seqs %x, status %x, cs %x\n", cmd_seqs, status, cs));
 	nand->bad_count = (status & NDSR_ERR_CNT_MASK) >> 16;
 	if (status & NDSR_DBERR)
 		nand->retcode = ERR_DBERR;
@@ -561,26 +664,53 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)

 		nand->state |= STATE_DATA_DONE;
 	}
+	if (status & page_done)
+		nand->state |= STATE_PAGE_DONE;
+	if (status & ready) {
+		nand->state |= STATE_READY;
+		if (info->wait_ready[cmd_seqs]) {
+			enable_int(nand, NDCR_WRCMDREQM);
+			if (cmd_seqs == info->total_cmds)
+				is_completed = 1;
+		}
+	}
 	if (status & cmd_done) {
 		nand->state |= STATE_CMD_DONE;
-		is_completed = 1;
+		if (cmd_seqs == info->total_cmds && !info->wait_ready[cmd_seqs])
+			is_completed = 1;
 	}
-	if (status & ready)
-		nand->state |= STATE_READY;
-	if (status & page_done)
-		nand->state |= STATE_PAGE_DONE;

 	if (status & NDSR_WRCMDREQ) {
-		nand_writel(nand, NDSR, NDSR_WRCMDREQ);
 		status &= ~NDSR_WRCMDREQ;
-		nand->state |= STATE_CMD_WAIT_DONE;
-		nand_writel(nand, NDCB0, info->ndcb0);
-		nand_writel(nand, NDCB0, info->ndcb1);
-		nand_writel(nand, NDCB0, info->ndcb2);
-		DBG_NAND(printk("\tndcb0 %x ndcb1 %x ndcb2 %x\n",
-				info->ndcb0, info->ndcb1, info->ndcb2));
+		if (info->wait_ready[cmd_seqs] && !(nand->state & STATE_READY)) {
+			disable_int(nand, NDCR_WRCMDREQM);
+			goto IRQ_FORCE_EXIT;
+		}
+
+		nand_writel(nand, NDSR, NDSR_WRCMDREQ);
+		if (cmd_seqs < info->total_cmds) {
+			info->cmd_seqs ++;
+			if (cmd_seqs == 0) {
+				ndcb1 = info->ndcb1;
+				ndcb2 = info->ndcb2;
+			}
+			else {
+				ndcb1 = 0;
+				ndcb2 = 0;
+			}
+			nand->state &= ~STATE_MASK;
+			nand->state |= STATE_CMD_WAIT_DONE;
+			nand_writel(nand, NDCB0, info->ndcb0[cmd_seqs]);
+			nand_writel(nand, NDCB0, ndcb1);
+			nand_writel(nand, NDCB0, ndcb2);
+			DBG_NAND(printk("\tndcb0 %x ndcb1 %x ndcb2 %x\n",
+						info->ndcb0[cmd_seqs], ndcb1, ndcb2));
+		}
+		else
+			is_completed = 1;
 	}

+IRQ_FORCE_EXIT:
 	/* clear NDSR to let the controller exit the IRQ */
 	nand_writel(nand, NDSR, status);
 	if (is_completed)
@@ -601,7 +731,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		uint16_t column, int page_addr)
 {
 	uint16_t cmd;
-	int addr_cycle, exec_cmd, ndcb0;
+	int addr_cycle, exec_cmd, ndcb0, i, chunks = 0;
 	struct mtd_info *mtd;
 	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];

@@ -611,14 +741,20 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 	exec_cmd = 1;

 	/* reset data and oob column point to handle data */
+	info->data_column	= 0;
+	info->oob_column	= 0;
 	info->buf_start		= 0;
 	info->buf_count		= 0;
-	info->ndcb0		= ndcb0;
+	info->total_cmds	= 1;
+	info->cmd_seqs		= 0;
 	nand->data_size		= 0;
 	nand->oob_size		= 0;
 	nand->use_ecc		= 0;
 	nand->use_dma		= 0;
 	nand->state		= 0;
+	nand->bad_count		= 0;
+	nand->retcode		= ERR_NONE;
+	nand->command		= command;

 	switch (command) {
 	case NAND_CMD_READ0:
@@ -627,6 +763,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	case NAND_CMD_READOOB:
 		pxa3xx_set_datasize(info);
 		nand->use_dma = use_dma;
+		chunks = info->page_size / nand->data_size;
 		break;
 	case NAND_CMD_SEQIN:
 		exec_cmd = 0;
@@ -637,6 +774,11 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 		break;
 	}

+	/* clear the command buffer */
+	for (i = 0; i < CMD_POOL_SIZE; i ++) {
+		info->ndcb0[i] = ndcb0;
+		info->wait_ready[i] = 0;
+	}
 	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
 			+ info->col_addr_cycles);

@@ -651,14 +793,37 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 			info->buf_start = column;

 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
-			info->ndcb0 |= NDCB0_CMD_TYPE(0)
+			info->ndcb0[0] |= NDCB0_CMD_TYPE(0)
 					| addr_cycle
 					| (cmd & NDCB0_CMD1_MASK);
-		else
-			info->ndcb0 |= NDCB0_CMD_TYPE(0)
-					| NDCB0_DBC
-					| addr_cycle
-					| cmd;
+		else {
+			if (chunks == 1)
+				info->ndcb0[0] |= NDCB0_CMD_TYPE(0)
+						| NDCB0_DBC
+						| addr_cycle
+						| cmd;
+			else {
+				info->total_cmds = chunks + 1;
+				info->ndcb0[0] |= NDCB0_CMD_XTYPE(0x6)
+						| NDCB0_CMD_TYPE(0)
+						| NDCB0_DBC
+						| NDCB0_NC
+						| addr_cycle
+						| cmd;
+
+				info->ndcb0[1] |= NDCB0_CMD_XTYPE(0x5)
+						| NDCB0_NC
+						| addr_cycle;
+
+				for (i = 2; i <= chunks; i ++)
+					info->ndcb0[i] = info->ndcb0[1];
+
+				info->ndcb0[chunks] &= ~NDCB0_NC;
+				/* we should wait RnB go high again
+				 * before read out data*/
+				info->wait_ready[1] = 1;
+			}
+		}

 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
@@ -691,18 +856,46 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,

 		cmd = cmdset.program;
 		nand->state |= STATE_IS_WRITE;
-		info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
-				| NDCB0_AUTO_RS
-				| NDCB0_ST_ROW_EN
-				| NDCB0_DBC
-				| cmd
-				| addr_cycle;
+		if (chunks == 1)
+			info->ndcb0[0] |= NDCB0_CMD_TYPE(0x1)
+					| NDCB0_AUTO_RS
+					| NDCB0_ST_ROW_EN
+					| NDCB0_DBC
+					| cmd
+					| addr_cycle;
+		else {
+			info->total_cmds = chunks + 1;
+			info->ndcb0[0] |= NDCB0_CMD_XTYPE(0x4)
+					| NDCB0_CMD_TYPE(0x1)
+					| NDCB0_NC
+					| NDCB0_AUTO_RS
+					| (cmd & NDCB0_CMD1_MASK)
+					| addr_cycle;
+
+			for (i = 1; i < chunks; i ++)
+				info->ndcb0[i] |= NDCB0_CMD_XTYPE(0x5)
+						| NDCB0_NC
+						| NDCB0_AUTO_RS
+						| NDCB0_CMD_TYPE(0x1)
+						| addr_cycle;
+
+			info->ndcb0[chunks] |= NDCB0_CMD_XTYPE(0x3)
+						| NDCB0_CMD_TYPE(0x1)
+						| NDCB0_ST_ROW_EN
+						| NDCB0_DBC
+						| (cmd & NDCB0_CMD2_MASK)
+						| NDCB0_CMD1_MASK
+						| addr_cycle;
+			/* we should wait for RnB goes high which
+			 * indicate the data has been written succesfully*/
+			info->wait_ready[info->total_cmds] = 1;
+		}
 		break;

 	case NAND_CMD_READID:
 		cmd = cmdset.read_id;
 		info->buf_count = info->read_id_bytes;
-		info->ndcb0 |= NDCB0_CMD_TYPE(3)
+		info->ndcb0[0] |= NDCB0_CMD_TYPE(3)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;

@@ -712,7 +905,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	case NAND_CMD_STATUS:
 		cmd = cmdset.read_status;
 		info->buf_count = 1;
-		info->ndcb0 |= NDCB0_CMD_TYPE(4)
+		info->ndcb0[0] |= NDCB0_CMD_TYPE(4)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;

@@ -721,7 +914,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,

 	case NAND_CMD_ERASE1:
 		cmd = cmdset.erase;
-		info->ndcb0 |= NDCB0_CMD_TYPE(2)
+		info->ndcb0[0] |= NDCB0_CMD_TYPE(2)
 				| NDCB0_AUTO_RS
 				| NDCB0_ADDR_CYC(3)
 				| NDCB0_DBC
@@ -732,7 +925,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		break;
 	case NAND_CMD_RESET:
 		cmd = cmdset.reset;
-		info->ndcb0 |= NDCB0_CMD_TYPE(5)
+		info->ndcb0[0] |= NDCB0_CMD_TYPE(5)
 				| cmd;

 		break;
@@ -782,6 +975,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 				CHIP_DELAY_TIMEOUT);
 		if (!ret) {
 			printk(KERN_ERR "Wait time out!!!\n");
+			nand_error_dump(nand);
 		}
 		/* Stop State Machine for next command cycle */
 		pxa3xx_nand_stop(nand);
@@ -865,7 +1059,7 @@ static int pxa3xx_nand_waitfunc(struct mtd_info
*mtd, struct nand_chip *this)
 	return 0;
 }

-static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
+static void pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 				    const struct pxa3xx_nand_flash *f)
 {
 	struct pxa3xx_nand *nand = info->nand_data;
@@ -873,14 +1067,20 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	uint32_t ndcr = 0;

+	info->page_size = f->page_size;
+	if (info->page_size > PAGE_CHUNK_SIZE && !naked_cmd_support) {
+		dev_err(&pdev->dev, "Your controller don't support 4k or"
+				"larger page NAND for don't support naked command\n");
+		BUG();
+	}
+
 	/* calculate flash information */
 	info->use_ecc = f->ecc_type;
-	info->page_size = f->page_size;
 	info->oob_buff = info->data_buff + f->page_size;
-	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
+	info->read_id_bytes = (f->page_size >= 2048) ? 4 : 2;

 	/* calculate addressing information */
-	info->col_addr_cycles = (f->page_size == 2048) ? 2 : 1;
+	info->col_addr_cycles = (f->page_size >= 2048) ? 2 : 1;

 	if (f->num_blocks * f->page_per_block > 65536)
 		info->row_addr_cycles = 3;
@@ -889,18 +1089,43 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,

 	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
 	ndcr |= (info->col_addr_cycles == 2) ? NDCR_RA_START : 0;
-	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
-	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
 	ndcr |= (f->flash_width == 16) ? NDCR_DWIDTH_M : 0;
 	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;

+	switch (f->page_per_block) {
+		case 32:
+			ndcr |= NDCR_PG_PER_BLK(0x0);
+			break;
+		case 128:
+			ndcr |= NDCR_PG_PER_BLK(0x1);
+			break;
+		case 256:
+			ndcr |= NDCR_PG_PER_BLK(0x3);
+			break;
+		case 64:
+		default:
+			ndcr |= NDCR_PG_PER_BLK(0x2);
+			break;
+	}
+
+	switch (f->page_size) {
+		case 512:
+			ndcr |= NDCR_PAGE_SZ(0x0);
+			break;
+		case 2048:
+		default:
+			ndcr |= NDCR_PAGE_SZ(0x1);
+			ndcr |= NDCR_FORCE_CSX;
+			break;
+
+	}
+
 	ndcr |= NDCR_RD_ID_CNT(info->read_id_bytes);
 	ndcr |= NDCR_SPARE_EN; /* enable spare by default */

 	info->reg_ndcr = ndcr;

 	pxa3xx_nand_set_timing(info, &f->timing);
-	return 0;
 }

 /* the maximum possible buffer size for large page with OOB data
@@ -1325,6 +1550,7 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 		return -ENODEV;
 	}

+	naked_cmd_support = pdata->naked_cmd_support;
 	ret = alloc_nand_resource(pdev);
 	if (ret)
 		return ret;
-- 
1.5.6.5
