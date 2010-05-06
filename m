From: leiwen@marvell.com (Lei Wen)
Date: Thu, 6 May 2010 10:43:57 +0800
Subject: [PATCH] mtd: pxa3xx_nand: reimplment read oob command to
Message-ID: <mailman.443.1273818314.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

increase performance

For read oob command only care about the spare area part, we truly
need not to transfer all page data to the controller side.

By random data out, we could do the naked read first to let one page
data transfer
from NAND chip to its internal ram. Then we use random data out
command to change
the offset to the start of oob part. After all this, we toggle only oob size of
RE# to the controller side.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  122 ++++++++++++++++++++++++++++++----------
 1 files changed, 92 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 7c871af..2e1c8b6 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -129,6 +129,7 @@

 #define NDCB0_CMD_XTYPE_MASK    (0x7 << 29)
 #define NDCB0_CMD_XTYPE(x)      (((x) << 29) & NDCB0_CMD_XTYPE_MASK)
+#define NDCB0_LEN_OVRD		(0x1 << 28)
 #define NDCB0_ST_ROW_EN         (0x1 << 26)
 #define NDCB0_AUTO_RS		(0x1 << 25)
 #define NDCB0_CSEL		(0x1 << 24)
@@ -257,8 +258,9 @@ struct pxa3xx_nand_info {
 	uint8_t			total_cmds;
 	uint8_t			wait_ready[CMD_POOL_SIZE];
 	uint32_t		ndcb0[CMD_POOL_SIZE];
-	uint32_t		ndcb1;
-	uint32_t		ndcb2;
+	uint32_t		ndcb1[CMD_POOL_SIZE];
+	uint32_t		ndcb2[CMD_POOL_SIZE];
+	uint32_t		ndcb3[CMD_POOL_SIZE];
 	uint32_t		reg_ndcr;
 	uint32_t		ndtr0cs0;
 	uint32_t		ndtr1cs0;
@@ -646,9 +648,9 @@ static void nand_error_dump(struct pxa3xx_nand *nand)
 	printk(KERN_ERR "Totally %d command for sending\n",
 			info->total_cmds);
 	for (i = 0; i < info->total_cmds; i ++)
-		printk(KERN_ERR "NDCB0:%d: %x\n",
-				i, info->ndcb0[i]);
-	printk(KERN_ERR "NDCB1: %x; NDCB2 %x\n", info->ndcb1, info->ndcb2);
+		printk(KERN_ERR "==%d: NDCB0 %x, NDCB1 %x, NDCB2 %x, NDCB3 %x\n",
+				i, info->ndcb0[i], info->ndcb1[i],
+				info->ndcb2[i], info->ndcb3[i]);

 	printk(KERN_ERR "\nRegister DUMPing ##############\n");
 	printk(KERN_ERR "NDCR %x\n"
@@ -775,7 +777,7 @@ static void pxa3xx_nand_data_dma_irq(int channel,
void *data)
 static int pxa3xx_nand_transaction(struct pxa3xx_nand *nand)
 {
 	struct pxa3xx_nand_info *info;
-	unsigned int status, is_completed = 0, cs, cmd_seqs, ndcb1, ndcb2;
+	unsigned int status, is_completed = 0, cs, cmd_seqs;
 	unsigned int ready, cmd_done, page_done, badblock_detect;

 	cs		= nand->chip_select;
@@ -842,24 +844,20 @@ static int pxa3xx_nand_transaction(struct
pxa3xx_nand *nand)

 		nand_writel(nand, NDSR, NDSR_WRCMDREQ);
 		if (cmd_seqs < info->total_cmds) {
-			info->cmd_seqs ++;
-			if (cmd_seqs == 0) {
-				ndcb1 = info->ndcb1;
-				ndcb2 = info->ndcb2;
-			}
-			else {
-				ndcb1 = 0;
-				ndcb2 = 0;
-			}
+			info->cmd_seqs++;
 			nand->state &= ~STATE_MASK;
 			nand->state |= STATE_CMD_WAIT_DONE;
 			nand_writel(nand, NDCB0, info->ndcb0[cmd_seqs]);
-			nand_writel(nand, NDCB0, ndcb1);
-			nand_writel(nand, NDCB0, ndcb2);
-			DBG_NAND(printk("\tndcb0 %x ndcb1 %x ndcb2 %x\n",
-						info->ndcb0[cmd_seqs], ndcb1, ndcb2));
-		}
-		else
+			nand_writel(nand, NDCB0, info->ndcb1[cmd_seqs]);
+			nand_writel(nand, NDCB0, info->ndcb2[cmd_seqs]);
+			if (info->ndcb0[cmd_seqs] & NDCB0_LEN_OVRD)
+				nand_writel(nand, NDCB0, info->ndcb3[cmd_seqs]);
+			DBG_NAND(printk("\tndcb0 %x ndcb1 %x ndcb2 %x, ndcb3 %x\n",
+						info->ndcb0[cmd_seqs],
+						info->ndcb1[cmd_seqs],
+						info->ndcb2[cmd_seqs],
+						info->ndcb3[cmd_seqs]));
+		} else
 			is_completed = 1;
 	}

@@ -938,6 +936,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	case NAND_CMD_PAGEPROG:
 		nand->use_ecc = info->use_ecc;
 	case NAND_CMD_READOOB:
+	case NAND_CMD_RNDOUT:
 		pxa3xx_set_datasize(info);
 		nand->use_dma = use_dma;
 		chunks = info->page_size / nand->data_size;
@@ -946,8 +945,8 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		exec_cmd = 0;
 		break;
 	default:
-		info->ndcb1 = 0;
-		info->ndcb2 = 0;
+		info->ndcb1[0] = 0;
+		info->ndcb2[0] = 0;
 		break;
 	}

@@ -1005,26 +1004,73 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)) {
-			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
+			info->ndcb1[0] = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);

-			info->ndcb2 = 0;
+			info->ndcb2[0] = 0;
 		}
 		else {
-			info->ndcb1 = ((page_addr & 0xFFFF) << 16)
+			info->ndcb1[0] = ((page_addr & 0xFFFF) << 16)
 					| (column & 0xFFFF);

 			if (page_addr & 0xFF0000)
-				info->ndcb2 = (page_addr & 0xFF0000) >> 16;
+				info->ndcb2[0] = (page_addr & 0xFF0000) >> 16;
 			else
-				info->ndcb2 = 0;
+				info->ndcb2[0] = 0;
 		}

+		for (i = 1; i <=chunks; i ++) {
+			info->ndcb1[i] = info->ndcb1[0];
+			info->ndcb2[i] = info->ndcb2[0];
+		}
 		info->buf_count = mtd->writesize + mtd->oobsize;
 		memset(info->data_buff, 0xFF, info->buf_count);

 		break;

+	case NAND_CMD_RNDOUT:
+		/* current RNDOUT only support 2k nand */
+		if (info->page_size > PAGE_CHUNK_SIZE)
+			BUG();
+
+		cmd  = cmdset.read1;
+		info->total_cmds = 3;
+		info->ndcb0[0] |= NDCB0_CMD_XTYPE(0x6)
+				| NDCB0_CMD_TYPE(0)
+				| NDCB0_DBC
+				| NDCB0_NC
+				| addr_cycle
+				| cmd;
+
+		info->ndcb0[1] |= NDCB0_CMD_XTYPE(0x6)
+				| NDCB0_CMD_TYPE(0)
+				| NDCB0_DBC
+				| NDCB0_NC
+				| NDCB0_ADDR_CYC(info->col_addr_cycles)
+				| (NAND_CMD_RNDOUTSTART << 8)
+				| NAND_CMD_RNDOUT;
+
+		info->ndcb0[2] |= NDCB0_CMD_XTYPE(0x5)
+				| NDCB0_LEN_OVRD;
+
+		info->ndcb1[0] = ((page_addr & 0xFFFF) << 16)
+				| (column & 0xFFFF);
+		info->ndcb1[1] = mtd->writesize;
+		info->ndcb1[2] = 0;
+
+		if (page_addr & 0xFF0000)
+			info->ndcb2[0] = (page_addr & 0xFF0000) >> 16;
+		else
+			info->ndcb2[0] = 0;
+		info->ndcb2[1] = info->ndcb2[2] = 0;
+		info->ndcb3[0] = info->ndcb3[1] = 0;
+		info->ndcb3[2] = mtd->oobsize;
+		info->buf_count = mtd->oobsize;
+		info->wait_ready[1] = 1;
+		nand->data_size = mtd->oobsize;
+		nand->oob_size = 0;
+		break;
+
 	case NAND_CMD_PAGEPROG:
 		if (is_buf_blank(info->data_buff, (mtd->writesize + mtd->oobsize))) {
 			exec_cmd = 0;
@@ -1096,8 +1142,8 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 				| NDCB0_ADDR_CYC(3)
 				| NDCB0_DBC
 				| cmd;
-		info->ndcb1 = page_addr;
-		info->ndcb2 = 0;
+		info->ndcb1[0] = page_addr;
+		info->ndcb2[0] = 0;

 		break;
 	case NAND_CMD_RESET:
@@ -1245,6 +1291,21 @@ static int pxa3xx_nand_waitfunc(struct mtd_info
*mtd, struct nand_chip *this)
 	return 0;
 }

+static int pxa3xx_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
+		int page, int sndcmd)
+{
+	struct pxa3xx_nand_info *info = (struct pxa3xx_nand_info *)chip;
+	if (sndcmd) {
+		if ((info->page_size <= PAGE_CHUNK_SIZE) && naked_cmd_support)
+			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, 0, page);
+		else
+			chip->cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
+		sndcmd = 0;
+	}
+	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	return sndcmd;
+}
+
 static void pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 			    struct pxa3xx_nand_flash *f, int show_timing)
 {
@@ -1626,6 +1687,7 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 		chip->controller        = &nand->controller;
 		chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
 		chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
+		chip->ecc.read_oob      = pxa3xx_nand_read_oob;
 		chip->waitfunc		= pxa3xx_nand_waitfunc;
 		chip->select_chip	= pxa3xx_nand_select_chip;
 		chip->cmdfunc		= pxa3xx_nand_cmdfunc;
-- 
1.5.6.5
