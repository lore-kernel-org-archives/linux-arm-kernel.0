From: leiwen@marvell.com (Lei Wen)
Date: Fri, 22 Oct 2010 18:14:42 +0800
Subject: [PATCH V3 4/6] pxa3xx_nand: unify prepare command
In-Reply-To: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
References: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
Message-ID: <1287742484-4276-5-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the interface simpler which could make both debug
and enhancement easier.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/mtd/nand/pxa3xx_nand.c |  260 +++++++++++++++++++++-------------------
 1 files changed, 134 insertions(+), 126 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index a7f623f..0ca2b88 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -28,6 +28,7 @@
 
 #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
 #define NAND_STOP_DELAY		(2 * HZ/50)
+#define PAGE_CHUNK_SIZE		(2048)
 
 /* registers and bit definitions */
 #define NDCR		(0x00) /* Control register */
@@ -77,6 +78,7 @@
 #define NDSR_RDDREQ		(0x1 << 1)
 #define NDSR_WRCMDREQ		(0x1)
 
+#define NDCB0_ST_ROW_EN         (0x1 << 26)
 #define NDCB0_AUTO_RS		(0x1 << 25)
 #define NDCB0_CSEL		(0x1 << 24)
 #define NDCB0_CMD_TYPE_MASK	(0x7 << 21)
@@ -319,66 +321,6 @@ static void pxa3xx_nand_stop(struct pxa3xx_nand_info *info)
 	nand_writel(info, NDSR, NDSR_MASK);
 }
 
-static void prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
-		uint16_t cmd, int column, int page_addr)
-{
-	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
-	pxa3xx_set_datasize(info);
-
-	/* generate values for NDCBx registers */
-	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
-	info->ndcb1 = 0;
-	info->ndcb2 = 0;
-	info->ndcb0 |= NDCB0_ADDR_CYC(info->row_addr_cycles + info->col_addr_cycles);
-
-	if (info->col_addr_cycles == 2) {
-		/* large block, 2 cycles for column address
-		 * row address starts from 3rd cycle
-		 */
-		info->ndcb1 |= page_addr << 16;
-		if (info->row_addr_cycles == 3)
-			info->ndcb2 = (page_addr >> 16) & 0xff;
-	} else
-		/* small block, 1 cycles for column address
-		 * row address starts from 2nd cycle
-		 */
-		info->ndcb1 = page_addr << 8;
-
-	if (cmd == cmdset->program)
-		info->ndcb0 |= NDCB0_CMD_TYPE(1) | NDCB0_AUTO_RS;
-}
-
-static void prepare_erase_cmd(struct pxa3xx_nand_info *info,
-			uint16_t cmd, int page_addr)
-{
-	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
-	info->ndcb0 |= NDCB0_CMD_TYPE(2) | NDCB0_AUTO_RS | NDCB0_ADDR_CYC(3);
-	info->ndcb1 = page_addr;
-	info->ndcb2 = 0;
-}
-
-static void prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
-{
-	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
-
-	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
-	info->ndcb1 = 0;
-	info->ndcb2 = 0;
-
-	info->oob_size = 0;
-	if (cmd == cmdset->read_id) {
-		info->ndcb0 |= NDCB0_CMD_TYPE(3) | NDCB0_ADDR_CYC(1);
-		info->data_size = 8;
-	} else if (cmd == cmdset->read_status) {
-		info->ndcb0 |= NDCB0_CMD_TYPE(4);
-		info->data_size = 8;
-	} else if (cmd == cmdset->reset || cmd == cmdset->lock ||
-		   cmd == cmdset->unlock) {
-		info->ndcb0 |= NDCB0_CMD_TYPE(5);
-	} else
-		BUG();
-}
-
 static void enable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
 {
 	uint32_t ndcr;
@@ -529,94 +471,164 @@ static inline int is_buf_blank(uint8_t *buf, size_t len)
 	return 1;
 }
 
-static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
-				int column, int page_addr)
+static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
+		uint16_t column, int page_addr)
 {
-	struct pxa3xx_nand_info *info = mtd->priv;
-	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
-	int ret, exec_cmd = 0;
+	uint16_t cmd;
+	int addr_cycle, exec_cmd, ndcb0;
+	struct mtd_info *mtd = info->mtd;
+
+	ndcb0 = 0;
+	addr_cycle = 0;
+	exec_cmd = 1;
 
-	info->use_dma = (use_dma) ? 1 : 0;
-	info->use_ecc = 0;
-	info->data_size = 0;
-	info->state = 0;
+	/* reset data and oob column point to handle data */
+	info->buf_start		= 0;
+	info->buf_count		= 0;
+	info->oob_size		= 0;
+	info->use_ecc		= 0;
 
 	switch (command) {
+	case NAND_CMD_READ0:
+	case NAND_CMD_PAGEPROG:
+		info->use_ecc = 1;
 	case NAND_CMD_READOOB:
-		/* disable HW ECC to get all the OOB data */
-		info->buf_count = mtd->writesize + mtd->oobsize;
-		info->buf_start = mtd->writesize + column;
-		memset(info->data_buff, 0xFF, info->buf_count);
-
-		prepare_read_prog_cmd(info, cmdset->read1, column, page_addr);
-		/* We only are OOB, so if the data has error, does not matter */
-		if (info->retcode == ERR_DBERR)
-			info->retcode = ERR_NONE;
-
-		exec_cmd = 1;
+		pxa3xx_set_datasize(info);
+		break;
+	case NAND_CMD_SEQIN:
+		exec_cmd = 0;
+		break;
+	default:
+		info->ndcb1 = 0;
+		info->ndcb2 = 0;
 		break;
+	}
+
+	info->ndcb0 = ndcb0;
+	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
+		     + info->col_addr_cycles);
 
+	switch (command) {
+	case NAND_CMD_READOOB:
 	case NAND_CMD_READ0:
-		info->use_ecc = 1;
-		info->retcode = ERR_NONE;
-		info->buf_start = column;
-		info->buf_count = mtd->writesize + mtd->oobsize;
-		memset(info->data_buff, 0xFF, info->buf_count);
+		cmd  = info->cmdset->read1;
+		if (command == NAND_CMD_READOOB)
+			info->buf_start = mtd->writesize + column;
+		else
+			info->buf_start = column;
 
-		prepare_read_prog_cmd(info, cmdset->read1, column, page_addr);
-		if (info->retcode == ERR_DBERR) {
-			/* for blank page (all 0xff), HW will calculate its ECC as
-			 * 0, which is different from the ECC information within
-			 * OOB, ignore such double bit errors
-			 */
-			if (is_buf_blank(info->data_buff, mtd->writesize))
-				info->retcode = ERR_NONE;
-		}
+		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
+			info->ndcb0 |= NDCB0_CMD_TYPE(0)
+					| addr_cycle
+					| (cmd & NDCB0_CMD1_MASK);
+		else
+			info->ndcb0 |= NDCB0_CMD_TYPE(0)
+					| NDCB0_DBC
+					| addr_cycle
+					| cmd;
 
-		exec_cmd = 1;
-		break;
 	case NAND_CMD_SEQIN:
-		info->buf_start = column;
+		/* small page addr setting */
+		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)) {
+			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
+					| (column & 0xFF);
+
+			info->ndcb2 = 0;
+		}
+		else {
+			info->ndcb1 = ((page_addr & 0xFFFF) << 16)
+					| (column & 0xFFFF);
+
+			if (page_addr & 0xFF0000)
+				info->ndcb2 = (page_addr & 0xFF0000) >> 16;
+			else
+				info->ndcb2 = 0;
+		}
+
 		info->buf_count = mtd->writesize + mtd->oobsize;
-		memset(info->data_buff, 0xff, info->buf_count);
+		memset(info->data_buff, 0xFF, info->buf_count);
 
-		/* save column/page_addr for next CMD_PAGEPROG */
-		info->seqin_column = column;
-		info->seqin_page_addr = page_addr;
 		break;
+
 	case NAND_CMD_PAGEPROG:
-		info->use_ecc = (info->seqin_column >= mtd->writesize) ? 0 : 1;
+		if (is_buf_blank(info->data_buff, (mtd->writesize + mtd->oobsize))) {
+			exec_cmd = 0;
+			break;
+		}
 
-		prepare_read_prog_cmd(info, cmdset->program,
-				info->seqin_column, info->seqin_page_addr);
-		exec_cmd = 1;
-		break;
-	case NAND_CMD_ERASE1:
-		prepare_erase_cmd(info, cmdset->erase, page_addr);
-		exec_cmd = 1;
-		break;
-	case NAND_CMD_ERASE2:
+		cmd = info->cmdset->program;
+		info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+				| NDCB0_AUTO_RS
+				| NDCB0_ST_ROW_EN
+				| NDCB0_DBC
+				| cmd
+				| addr_cycle;
 		break;
+
 	case NAND_CMD_READID:
+		cmd = info->cmdset->read_id;
+		info->buf_count = info->read_id_bytes;
+		info->ndcb0 |= NDCB0_CMD_TYPE(3)
+				| NDCB0_ADDR_CYC(1)
+				| cmd;
+
+		info->data_size = 8;
+		break;
 	case NAND_CMD_STATUS:
-		info->use_dma = 0;	/* force PIO read */
-		info->buf_start = 0;
-		info->buf_count = (command == NAND_CMD_READID) ?
-				info->read_id_bytes : 1;
-
-		prepare_other_cmd(info, (command == NAND_CMD_READID) ?
-				cmdset->read_id : cmdset->read_status);
-		exec_cmd = 1;
+		cmd = info->cmdset->read_status;
+		info->buf_count = 1;
+		info->ndcb0 |= NDCB0_CMD_TYPE(4)
+				| NDCB0_ADDR_CYC(1)
+				| cmd;
+
+		info->data_size = 8;
+		break;
+
+	case NAND_CMD_ERASE1:
+		cmd = info->cmdset->erase;
+		info->ndcb0 |= NDCB0_CMD_TYPE(2)
+				| NDCB0_AUTO_RS
+				| NDCB0_ADDR_CYC(3)
+				| NDCB0_DBC
+				| cmd;
+		info->ndcb1 = page_addr;
+		info->ndcb2 = 0;
+
 		break;
 	case NAND_CMD_RESET:
-		prepare_other_cmd(info, cmdset->reset);
-		exec_cmd = 1;
+		cmd = info->cmdset->reset;
+		info->ndcb0 |= NDCB0_CMD_TYPE(5)
+				| cmd;
+
+		break;
+
+	case NAND_CMD_ERASE2:
+		exec_cmd = 0;
 		break;
+
 	default:
-		printk(KERN_ERR "non-supported command.\n");
+		exec_cmd = 0;
+		printk(KERN_ERR "pxa3xx-nand: non-supported command %x\n", command);
 		break;
 	}
 
+	return exec_cmd;
+}
+
+static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
+		int column, int page_addr)
+{
+	struct pxa3xx_nand_info *info = mtd->priv;
+	int ret, exec_cmd;
+
+	/* if this is a x16 device ,then convert the input
+	 * "byte" address into a "word" address appropriate
+	 * for indexing a word-oriented device
+	 */
+	if (info->reg_ndcr & NDCR_DWIDTH_M)
+		column /= 2;
+
+	exec_cmd = prepare_command_pool(info, command, column, page_addr);
 	if (exec_cmd) {
 		init_completion(&info->cmd_complete);
 		pxa3xx_nand_start(info);
@@ -629,10 +641,6 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			pxa3xx_nand_stop(info);
 		}
 		info->state = STATE_IDLE;
-		if (info->retcode == ERR_DBERR) {
-			printk(KERN_ERR "double bit error @ page %08x\n", page_addr);
-			info->retcode = ERR_NONE;
-		}
 	}
 }
 
-- 
1.7.0.4
