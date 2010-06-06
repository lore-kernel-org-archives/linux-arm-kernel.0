From: leiwen@marvell.com (Lei Wen)
Date: Sun, 6 Jun 2010 22:05:06 +0800
Subject: [PATCH 13/25] pxa3xx_nand: enable 4k page operation
Message-ID: <mailman.24.1276839437.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For limitation of our controller, we only could do large page
nand chip by dividing the original page size into what we could
afford. We call one divide operation as chunk.

The divide operation need naked command support, which may not
be existed in so old version. You should check it first before
you want to use this feature.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  355 +++++++++++++++++++++++++++++++---------
 1 files changed, 280 insertions(+), 75 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 8ec9172..1e75df4 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -29,7 +29,10 @@
 #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
 #define NAND_STOP_DELAY		(2 * HZ/50)
 #define PAGE_CHUNK_SIZE		(2048)
+#define OOB_CHUNK_SIZE		(64)
 #define BCH_THRESHOLD           (8)
+#define CMD_POOL_SIZE           (5)
+#define READ_ID_BYTES		(4)

 /* registers and bit definitions */
 #define NDCR		(0x00) /* Control register */
@@ -39,33 +42,50 @@
 #define NDPCR		(0x18) /* Page Count Register */
 #define NDBDR0		(0x1C) /* Bad Block Register 0 */
 #define NDBDR1		(0x20) /* Bad Block Register 1 */
+#define NDREDEL		(0x24) /* Read Enable Return Delay Register */
 #define NDECCCTRL	(0x28) /* ECC Control Register */
+#define NDBZCNT		(0x2C) /* Timer for NDRnB0 and NDRnB1 */
 #define NDDB		(0x40) /* Data Buffer */
 #define NDCB0		(0x48) /* Command Buffer0 */
 #define NDCB1		(0x4C) /* Command Buffer1 */
 #define NDCB2		(0x50) /* Command Buffer2 */

 #define NDCR_SPARE_EN		(0x1 << 31)
-#define NDSR_ERR_CNT_MASK       (0x1F << 16)
-#define NDSR_ERR_CNT(x)         (((x) << 16) & NDSR_ERR_CNT_MASK)
 #define NDCR_ECC_EN		(0x1 << 30)
 #define NDCR_DMA_EN		(0x1 << 29)
 #define NDCR_ND_RUN		(0x1 << 28)
 #define NDCR_DWIDTH_C		(0x1 << 27)
 #define NDCR_DWIDTH_M		(0x1 << 26)
-#define NDCR_PAGE_SZ		(0x1 << 24)
-#define NDCR_NCSX		(0x1 << 23)
-#define NDCR_ND_MODE		(0x3 << 21)
+#define NDCR_PAGE_SZ_MASK	(0x3 << 24)
+#define NDCR_PAGE_SZ(x)		(((x) << 24) & NDCR_PAGE_SZ_MASK)
+#define NDCR_SEQ_DIS		(0x1 << 23)
+#define NDCR_ND_STOP		(0x1 << 22)
+#define NDCR_FORCE_CSX		(0x1 << 21)
 #define NDCR_CLR_PG_CNT		(0x1 << 20)
 #define NDCR_STOP_ON_UNCOR	(0x1 << 19)
 #define NDCR_RD_ID_CNT_MASK	(0x7 << 16)
 #define NDCR_RD_ID_CNT(x)	(((x) << 16) & NDCR_RD_ID_CNT_MASK)

 #define NDCR_RA_START		(0x1 << 15)
-#define NDCR_PG_PER_BLK		(0x1 << 14)
+#define NDCR_PG_PER_BLK_MASK	(0x3 << 13)
+#define NDCR_PG_PER_BLK(x)	(((x) << 13) & NDCR_PG_PER_BLK_MASK)
 #define NDCR_ND_ARB_EN		(0x1 << 12)
 #define NDCR_INT_MASK           (0xFFF)
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

+#define NDSR_ERR_CNT_MASK       (0x1F << 16)
+#define NDSR_ERR_CNT(x)         (((x) << 16) & NDSR_ERR_CNT_MASK)
 #define NDSR_MASK		(0xfff)
 #define NDSR_RDY                (0x1 << 12)
 #define NDSR_FLASH_RDY          (0x1 << 11)
@@ -81,6 +101,8 @@
 #define NDSR_RDDREQ		(0x1 << 1)
 #define NDSR_WRCMDREQ		(0x1)

+#define NDCB0_CMD_XTYPE_MASK    (0x7 << 29)
+#define NDCB0_CMD_XTYPE(x)      (((x) << 29) & NDCB0_CMD_XTYPE_MASK)
 #define NDCB0_ST_ROW_EN         (0x1 << 26)
 #define NDCB0_AUTO_RS		(0x1 << 25)
 #define NDCB0_CSEL		(0x1 << 24)
@@ -131,6 +153,7 @@ enum {
 	STATE_IS_WRITE		= (1 << 7),
 };

+#define STATE_MASK		(0x3f)
 /* error code and state */
 enum {
 	ECC_NONE = 0,
@@ -185,7 +208,6 @@ struct pxa3xx_nand_info {
 	/* calculated from pxa3xx_nand_flash data */
 	uint8_t			col_addr_cycles;
 	uint8_t			row_addr_cycles;
-	uint8_t			read_id_bytes;

 	/* cached register value */
 	uint32_t		reg_ndcr;
@@ -221,7 +243,8 @@ struct pxa3xx_nand {
 	unsigned char		*oob_buff;
 	uint32_t		buf_start;
 	uint32_t		buf_count;
-	uint8_t			total_cmds;
+	uint16_t		data_column;
+	uint16_t		oob_column;

 	/* relate to the command */
 	uint8_t			chip_select;
@@ -230,8 +253,11 @@ struct pxa3xx_nand {
 	int			use_dma;	/* use DMA ? */
 	int 			retcode;

-	/* generated NDCBx register values */
-	uint32_t		ndcb0;
+	/* cached register value */
+	uint8_t			cmd_seqs;
+	uint8_t			total_cmds;
+	uint8_t			wait_ready[CMD_POOL_SIZE];
+	uint32_t		ndcb0[CMD_POOL_SIZE];
 	uint32_t		ndcb1;
 	uint32_t		ndcb2;
 };
@@ -274,6 +300,7 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 { "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, ECC_HAMMIN, 1024, &timing[2], },
 { "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, ECC_HAMMIN, 4096, &timing[2], },
 { "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, ECC_HAMMIN, 4096, &timing[2], },
+{ "1GiB 8-bit",    0x382c, 128, 4096,  8,  8, ECC_BCH,    2048, &timing[2], },
 { "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, ECC_HAMMIN, 2048, &timing[3], },
 };

@@ -430,41 +457,98 @@ static void disable_int(struct pxa3xx_nand
*nand, uint32_t int_mask)
 	nand_writel(nand, NDCR, ndcr | int_mask);
 }

+static void nand_error_dump(struct pxa3xx_nand *nand)
+{
+	int i;
+
+	printk(KERN_ERR "NAND controller state wrong!!!\n");
+	printk(KERN_ERR "command %x, state %x, current seqs %d, errcode %x,
bad count %d\n",
+			nand->command, nand->state, nand->cmd_seqs,
+			nand->retcode, nand->bad_count);
+	printk(KERN_ERR "Totally %d command for sending\n",
+			nand->total_cmds);
+	for (i = 0; i < nand->total_cmds; i ++)
+		printk(KERN_ERR "NDCB0:%d: %x\n",
+				i, nand->ndcb0[i]);
+	printk(KERN_ERR "NDCB1: %x; NDCB2 %x\n", nand->ndcb1, nand->ndcb2);
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
+	unsigned int data_size, oob_size;
+
+	data_size = DIV_ROUND_UP(nand->data_size, 4);
+	oob_size = DIV_ROUND_UP(nand->oob_size, 4);
 	if (nand->state & STATE_IS_WRITE) {
-		__raw_writesl(nand->mmio_base + NDDB, nand->data_buff,
-				DIV_ROUND_UP(nand->data_size, 4));
+		__raw_writesl(nand->mmio_base + NDDB,
+				nand->data_buff + nand->data_column, data_size);
 		if (nand->oob_size > 0)
-			__raw_writesl(nand->mmio_base + NDDB, nand->oob_buff,
-					DIV_ROUND_UP(nand->oob_size, 4));
-
+			__raw_writesl(nand->mmio_base + NDDB,
+				nand->oob_buff + nand->oob_column, oob_size);
 	}
 	else {
-		__raw_readsl(nand->mmio_base + NDDB, nand->data_buff,
-				DIV_ROUND_UP(nand->data_size, 4));
+		__raw_readsl(nand->mmio_base + NDDB,
+				nand->data_buff + nand->data_column, data_size);
 		if (nand->oob_size > 0)
-			__raw_readsl(nand->mmio_base + NDDB, nand->oob_buff,
-					DIV_ROUND_UP(nand->oob_size, 4));
+			__raw_readsl(nand->mmio_base + NDDB,
+				nand->oob_buff + nand->oob_column, oob_size);
 	}
+	nand->data_column += (data_size << 2);
+	nand->oob_column += (oob_size << 2);
 }

 static void start_data_dma(struct pxa3xx_nand *nand, int dir_out)
 {
+	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
 	struct pxa_dma_desc *desc = nand->data_desc;
-	int dma_len = ALIGN(nand->data_size + nand->oob_size, 32);
-
-	desc->ddadr = DDADR_STOP;
-	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;
+	struct pxa_dma_desc *desc_oob = nand->data_desc + 1;
+	unsigned int data_len = ALIGN(nand->data_size, 32);
+	unsigned int oob_len = ALIGN(nand->oob_size, 32);

+	desc_oob->ddadr = desc->ddadr = DDADR_STOP;
+	desc_oob->dcmd = desc->dcmd = DCMD_WIDTH4 | DCMD_BURST32;
 	if (dir_out) {
-		desc->dsadr = nand->data_buff_phys;
+		desc->dsadr = nand->data_buff_phys + nand->data_column;
 		desc->dtadr = nand->mmio_phys + NDDB;
-		desc->dcmd |= DCMD_INCSRCADDR | DCMD_FLOWTRG;
+		desc->dcmd |= DCMD_ENDIRQEN | DCMD_INCSRCADDR | DCMD_FLOWTRG |
(data_len + oob_len);
 	} else {
-		desc->dtadr = nand->data_buff_phys;
-		desc->dsadr = nand->mmio_phys + NDDB;
-		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
+		if (nand->oob_size > 0) {
+			desc_oob->dtadr = nand->data_buff_phys
+					+ info->page_size + nand->oob_column;
+			desc_oob->dcmd |= DCMD_ENDIRQEN | DCMD_INCTRGADDR | DCMD_FLOWSRC | oob_len;
+			desc->ddadr = nand->data_desc_addr + sizeof(struct pxa_dma_desc);
+			desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC | data_len;
+		}
+		else
+			desc->dcmd |= DCMD_ENDIRQEN | DCMD_INCTRGADDR | DCMD_FLOWSRC | data_len;
+		desc->dtadr = nand->data_buff_phys + nand->data_column;
+		desc_oob->dsadr = desc->dsadr = nand->mmio_phys + NDDB;
 	}

 	DRCMR(nand->drcmr_dat) = DRCMR_MAPVLD | nand->data_dma_ch;
@@ -484,6 +568,8 @@ static void pxa3xx_nand_data_dma_irq(int channel,
void *data)
 		nand->retcode = ERR_DMABUSERR;
 	}

+	nand->data_column += nand->data_size;
+	nand->oob_column += nand->oob_size;
 	enable_int(nand, NDCR_INT_MASK);
 	nand_writel(nand, NDSR, NDSR_WRDREQ | NDSR_RDDREQ);
 }
@@ -492,7 +578,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 {
 	struct pxa3xx_nand *nand = devid;
 	struct pxa3xx_nand_info *info;
-	unsigned int status, is_completed = 0, cs;
+	unsigned int status, is_completed = 0, cs, cmd_seqs, ndcb1, ndcb2;
 	unsigned int ready, cmd_done, page_done, badblock_detect;

 	cs		= nand->chip_select;
@@ -501,13 +587,14 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	page_done       = (cs) ? NDSR_CS1_PAGED : NDSR_CS0_PAGED;
 	badblock_detect = (cs) ? NDSR_CS1_BBD : NDSR_CS0_BBD;
 	info            = nand->info[cs];
+	cmd_seqs	= nand->cmd_seqs;

 	status = nand_readl(nand, NDSR);
 	nand->bad_count = (status & NDSR_ERR_CNT_MASK) >> 16;
-	if (status & NDSR_DBERR)
-		nand->retcode = ERR_DBERR;
 	if (status & NDSR_SBERR)
 		nand->retcode = ERR_SBERR;
+	if (status & NDSR_DBERR)
+		nand->retcode = ERR_DBERR;
 	if (status & (NDSR_RDDREQ | NDSR_WRDREQ)) {

 		nand->state |= STATE_DATA_PROCESSING;
@@ -521,24 +608,51 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)

 		nand->state |= STATE_DATA_DONE;
 	}
+	if (status & page_done)
+		nand->state |= STATE_PAGE_DONE;
+	if (status & ready) {
+		nand->state |= STATE_READY;
+		if (nand->wait_ready[cmd_seqs]) {
+			enable_int(nand, NDCR_WRCMDREQM);
+			if (cmd_seqs == nand->total_cmds)
+				is_completed = 1;
+		}
+	}
 	if (status & cmd_done) {
 		nand->state |= STATE_CMD_DONE;
-		is_completed = 1;
+		if (cmd_seqs == nand->total_cmds && !nand->wait_ready[cmd_seqs])
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
-		nand_writel(nand, NDCB0, nand->ndcb0);
-		nand_writel(nand, NDCB0, nand->ndcb1);
-		nand_writel(nand, NDCB0, nand->ndcb2);
+		if (nand->wait_ready[cmd_seqs] && !(nand->state & STATE_READY)) {
+			disable_int(nand, NDCR_WRCMDREQM);
+			goto IRQ_FORCE_EXIT;
+		}
+
+		nand_writel(nand, NDSR, NDSR_WRCMDREQ);
+		if (cmd_seqs < nand->total_cmds) {
+			nand->cmd_seqs ++;
+			if (cmd_seqs == 0) {
+				ndcb1 = nand->ndcb1;
+				ndcb2 = nand->ndcb2;
+			}
+			else {
+				ndcb1 = 0;
+				ndcb2 = 0;
+			}
+			nand->state &= ~STATE_MASK;
+			nand->state |= STATE_CMD_WAIT_DONE;
+			nand_writel(nand, NDCB0, nand->ndcb0[cmd_seqs]);
+			nand_writel(nand, NDCB0, ndcb1);
+			nand_writel(nand, NDCB0, ndcb2);
+		}
+		else
+			is_completed = 1;
 	}

+IRQ_FORCE_EXIT:
 	/* clear NDSR to let the controller exit the IRQ */
 	nand_writel(nand, NDSR, status);
 	if (is_completed)
@@ -559,7 +673,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		uint16_t column, int page_addr)
 {
 	uint16_t cmd;
-	int addr_cycle, exec_cmd, ndcb0;
+	int addr_cycle, exec_cmd, ndcb0, i, chunks = 0;
 	struct mtd_info *mtd;
 	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];

@@ -569,14 +683,19 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 	exec_cmd = 1;

 	/* reset data and oob column point to handle data */
+	nand->data_column	= 0;
+	nand->oob_column	= 0;
 	nand->buf_start		= 0;
 	nand->buf_count		= 0;
-	nand->ndcb0		= ndcb0;
+	nand->total_cmds	= 1;
+	nand->cmd_seqs		= 0;
 	nand->data_size		= 0;
 	nand->oob_size		= 0;
 	nand->use_ecc		= 0;
 	nand->use_dma		= 0;
 	nand->state		= 0;
+	nand->bad_count		= 0;
+	nand->retcode		= ERR_NONE;
 	nand->command		= command;

 	switch (command) {
@@ -587,6 +706,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		pxa3xx_set_datasize(info);
 		nand->oob_buff = nand->data_buff + nand->data_size;
 		nand->use_dma = use_dma;
+		chunks = info->page_size / nand->data_size;
 		break;
 	case NAND_CMD_SEQIN:
 		exec_cmd = 0;
@@ -597,6 +717,11 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 		break;
 	}

+	/* clear the command buffer */
+	for (i = 0; i < CMD_POOL_SIZE; i ++) {
+		nand->ndcb0[i] = ndcb0;
+		nand->wait_ready[i] = 0;
+	}
 	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
 			+ info->col_addr_cycles);

@@ -611,14 +736,37 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 			nand->buf_start = column;

 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
-			nand->ndcb0 |= NDCB0_CMD_TYPE(0)
+			nand->ndcb0[0] |= NDCB0_CMD_TYPE(0)
 					| addr_cycle
 					| (cmd & NDCB0_CMD1_MASK);
-		else
-			nand->ndcb0 |= NDCB0_CMD_TYPE(0)
-					| NDCB0_DBC
-					| addr_cycle
-					| cmd;
+		else {
+			if (chunks == 1)
+				nand->ndcb0[0] |= NDCB0_CMD_TYPE(0)
+						| NDCB0_DBC
+						| addr_cycle
+						| cmd;
+			else {
+				nand->total_cmds = chunks + 1;
+				nand->ndcb0[0] |= NDCB0_CMD_XTYPE(0x6)
+						| NDCB0_CMD_TYPE(0)
+						| NDCB0_DBC
+						| NDCB0_NC
+						| addr_cycle
+						| cmd;
+
+				nand->ndcb0[1] |= NDCB0_CMD_XTYPE(0x5)
+						| NDCB0_NC
+						| addr_cycle;
+
+				for (i = 2; i <= chunks; i ++)
+					nand->ndcb0[i] = nand->ndcb0[1];
+
+				nand->ndcb0[chunks] &= ~NDCB0_NC;
+				/* we should wait RnB go high again
+				 * before read out data*/
+				nand->wait_ready[1] = 1;
+			}
+		}

 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
@@ -651,18 +799,46 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,

 		cmd = cmdset.program;
 		nand->state |= STATE_IS_WRITE;
-		nand->ndcb0 |= NDCB0_CMD_TYPE(0x1)
-				| NDCB0_AUTO_RS
-				| NDCB0_ST_ROW_EN
-				| NDCB0_DBC
-				| cmd
-				| addr_cycle;
+		if (chunks == 1)
+			nand->ndcb0[0] |= NDCB0_CMD_TYPE(0x1)
+					| NDCB0_AUTO_RS
+					| NDCB0_ST_ROW_EN
+					| NDCB0_DBC
+					| cmd
+					| addr_cycle;
+		else {
+			nand->total_cmds = chunks + 1;
+			nand->ndcb0[0] |= NDCB0_CMD_XTYPE(0x4)
+					| NDCB0_CMD_TYPE(0x1)
+					| NDCB0_NC
+					| NDCB0_AUTO_RS
+					| (cmd & NDCB0_CMD1_MASK)
+					| addr_cycle;
+
+			for (i = 1; i < chunks; i ++)
+				nand->ndcb0[i] |= NDCB0_CMD_XTYPE(0x5)
+						| NDCB0_NC
+						| NDCB0_AUTO_RS
+						| NDCB0_CMD_TYPE(0x1)
+						| addr_cycle;
+
+			nand->ndcb0[chunks] |= NDCB0_CMD_XTYPE(0x3)
+						| NDCB0_CMD_TYPE(0x1)
+						| NDCB0_ST_ROW_EN
+						| NDCB0_DBC
+						| (cmd & NDCB0_CMD2_MASK)
+						| NDCB0_CMD1_MASK
+						| addr_cycle;
+			/* we should wait for RnB goes high which
+			 * indicate the data has been written succesfully*/
+			nand->wait_ready[nand->total_cmds] = 1;
+		}
 		break;

 	case NAND_CMD_READID:
 		cmd = cmdset.read_id;
-		nand->buf_count = info->read_id_bytes;
-		nand->ndcb0 |= NDCB0_CMD_TYPE(3)
+		nand->buf_count = READ_ID_BYTES;
+		nand->ndcb0[0] |= NDCB0_CMD_TYPE(3)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;

@@ -672,7 +848,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	case NAND_CMD_STATUS:
 		cmd = cmdset.read_status;
 		nand->buf_count = 1;
-		nand->ndcb0 |= NDCB0_CMD_TYPE(4)
+		nand->ndcb0[0] |= NDCB0_CMD_TYPE(4)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;

@@ -681,7 +857,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,

 	case NAND_CMD_ERASE1:
 		cmd = cmdset.erase;
-		nand->ndcb0 |= NDCB0_CMD_TYPE(2)
+		nand->ndcb0[0] |= NDCB0_CMD_TYPE(2)
 				| NDCB0_AUTO_RS
 				| NDCB0_ADDR_CYC(3)
 				| NDCB0_DBC
@@ -692,7 +868,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		break;
 	case NAND_CMD_RESET:
 		cmd = cmdset.reset;
-		nand->ndcb0 |= NDCB0_CMD_TYPE(5)
+		nand->ndcb0[0] |= NDCB0_CMD_TYPE(5)
 				| cmd;

 		break;
@@ -741,10 +917,10 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 				CHIP_DELAY_TIMEOUT);
 		if (!ret) {
 			dev_err(&nand->pdev->dev, "Wait time out!!!\n");
+			nand_error_dump(nand);
+			/* Stop State Machine for next command cycle */
+			pxa3xx_nand_stop(nand);
 		}
-		/* Stop State Machine for next command cycle */
-		pxa3xx_nand_stop(nand);
-		disable_int(nand, NDCR_INT_MASK);
 		nand->state &= ~STATE_CMD_PREPARED;
 	}
 }
@@ -828,7 +1004,7 @@ static int pxa3xx_nand_waitfunc(struct mtd_info
*mtd, struct nand_chip *this)
 	return 0;
 }

-static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
+static void pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 				    const struct pxa3xx_nand_flash *f)
 {
 	struct pxa3xx_nand *nand = info->nand_data;
@@ -836,13 +1012,18 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	uint32_t ndcr = 0;

+	if (f->page_size > PAGE_CHUNK_SIZE
+			&& !(pdata->controller_attrs & PXA3XX_NAKED_CMD_EN)) {
+		printk(KERN_ERR "Your controller don't support 4k or larger "
+			       "page NAND for don't support naked command\n");
+		BUG();
+	}
 	/* calculate flash information */
 	info->use_ecc = f->ecc_type;
 	info->page_size = f->page_size;
-	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;

 	/* calculate addressing information */
-	info->col_addr_cycles = (f->page_size == 2048) ? 2 : 1;
+	info->col_addr_cycles = (f->page_size >= 2048) ? 2 : 1;

 	if (f->num_blocks * f->page_per_block > 65536)
 		info->row_addr_cycles = 3;
@@ -851,18 +1032,42 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,

 	ndcr |= (pdata->controller_attrs & PXA3XX_ARBI_EN) ? NDCR_ND_ARB_EN : 0;
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

-	ndcr |= NDCR_RD_ID_CNT(info->read_id_bytes);
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
+	ndcr |= NDCR_RD_ID_CNT(READ_ID_BYTES);
 	ndcr |= NDCR_SPARE_EN; /* enable spare by default */

 	info->reg_ndcr = ndcr;

 	pxa3xx_nand_set_timing(info, f->timing);
-	return 0;
 }

 static int pxa3xx_nand_detect_config(struct pxa3xx_nand *nand)
@@ -883,11 +1088,10 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand *nand)
 	return 0;
 }

-/* the maximum possible buffer size for large page with OOB data
- * is: 2048 + 64 = 2112 bytes, allocate a page here for both the
- * data buffer and the DMA descriptor
+/* the max buff size should be large than the largest size
+ * of page of NAND flash that currently controller support
  */
-#define MAX_BUFF_SIZE	PAGE_SIZE
+#define MAX_BUFF_SIZE	((PAGE_CHUNK_SIZE + OOB_CHUNK_SIZE) * 2) +
sizeof(struct pxa_dma_desc) * 2
 static void free_cs_resource(struct pxa3xx_nand_info *info, int cs)
 {
 	struct pxa3xx_nand *nand;
@@ -975,6 +1179,7 @@ static int __devinit pxa3xx_nand_scan(struct mtd_info *mtd)
 	uint64_t chipsize;
 	int i, ret;

+	nand->chip_select = info->chip_select;
 	if (pdata->controller_attrs & PXA3XX_KEEP_CONFIG) {
 		if (pxa3xx_nand_detect_config(nand) == 0)
 			goto KEEP_CONFIG;
@@ -1049,7 +1254,7 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 	struct pxa3xx_nand *nand;
 	struct resource *r;
 	int ret, irq, cs;
-	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc);
+	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc) * 2;

 	nand = kzalloc(sizeof(struct pxa3xx_nand), GFP_KERNEL);
 	if (!nand) {
-- 
1.7.0.4
