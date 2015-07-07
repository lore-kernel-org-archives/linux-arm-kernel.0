From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Jul 2015 17:27:23 +0200
Subject: [PATCH v2 3/7] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1436282847-21137-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nand controller on Marvell Berlin SoC reuse the pxa3xx nand driver
as it quite close. The process of sending commands can be compared to
the one of the Marvell armada 370: read and write commands are done in
chunks.

But the Berlin nand controller has some other specificities which
require some modifications of the pxa3xx nand driver:
- there are no IRQ available so we need to poll the status register: we
  have to use our own cmdfunc Berlin function, and early on the probing
  function.
- PAGEPROG are very different from the one used in the pxa3xx driver,
  so we're using a specific process for this one
- the SEQIN command is equivalent to a READ0 command

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 182 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 172 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 665e6cf06c9b..cc4496b3eab1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -110,6 +110,8 @@
 #define NDCB0_EXT_CMD_TYPE(x)	(((x) << 29) & NDCB0_EXT_CMD_TYPE_MASK)
 #define NDCB0_CMD_TYPE_MASK	(0x7 << 21)
 #define NDCB0_CMD_TYPE(x)	(((x) << 21) & NDCB0_CMD_TYPE_MASK)
+#define NDCB0_CMD_XTYPE_MASK	(0x7 << 29)
+#define NDCB0_CMD_XTYPE(x)	(((x) << 29) & NDCB0_CMD_XTYPE_MASK)
 #define NDCB0_NC		(0x1 << 20)
 #define NDCB0_DBC		(0x1 << 19)
 #define NDCB0_ADDR_CYC_MASK	(0x7 << 16)
@@ -118,13 +120,15 @@
 #define NDCB0_CMD1_MASK		(0xff)
 #define NDCB0_ADDR_CYC_SHIFT	(16)
 
-#define EXT_CMD_TYPE_DISPATCH	6 /* Command dispatch */
-#define EXT_CMD_TYPE_NAKED_RW	5 /* Naked read or Naked write */
-#define EXT_CMD_TYPE_READ	4 /* Read */
-#define EXT_CMD_TYPE_DISP_WR	4 /* Command dispatch with write */
-#define EXT_CMD_TYPE_FINAL	3 /* Final command */
-#define EXT_CMD_TYPE_LAST_RW	1 /* Last naked read/write */
-#define EXT_CMD_TYPE_MONO	0 /* Monolithic read/write */
+#define EXT_CMD_TYPE_LAST_PAGEPROG	8
+#define EXT_CMD_TYPE_CHUNK_PAGEPROG	7
+#define EXT_CMD_TYPE_DISPATCH		6 /* Command dispatch */
+#define EXT_CMD_TYPE_NAKED_RW		5 /* Naked read or Naked write */
+#define EXT_CMD_TYPE_READ		4 /* Read */
+#define EXT_CMD_TYPE_DISP_WR		4 /* Command dispatch with write */
+#define EXT_CMD_TYPE_FINAL		3 /* Final command */
+#define EXT_CMD_TYPE_LAST_RW		1 /* Last naked read/write */
+#define EXT_CMD_TYPE_MONO		0 /* Monolithic read/write */
 
 /* macros for registers read/write */
 #define nand_writel(info, off, val)	\
@@ -159,6 +163,7 @@ enum {
 enum pxa3xx_nand_variant {
 	PXA3XX_NAND_VARIANT_PXA,
 	PXA3XX_NAND_VARIANT_ARMADA370,
+	PXA3XX_NAND_VARIANT_BERLIN2,
 };
 
 struct pxa3xx_nand_host {
@@ -320,6 +325,18 @@ static struct nand_ecclayout ecc_layout_4KB_bch8bit = {
 	.oobfree = { }
 };
 
+static struct nand_ecclayout ecc_layout_oob_128 = {
+	.eccbytes = 48,
+	.eccpos = {
+		80, 81, 82, 83, 84, 85, 86, 87,
+		88, 89, 90, 91, 92, 93, 94, 95,
+		96, 97, 98, 99, 100, 101, 102, 103,
+		104, 105, 106, 107, 108, 109, 110, 111,
+		112, 113, 114, 115, 116, 117, 118, 119,
+		120, 121, 122, 123, 124, 125, 126, 127},
+	.oobfree = { {.offset = 2, .length = 78} }
+};
+
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -343,6 +360,10 @@ static const struct of_device_id pxa3xx_nand_dt_ids[] = {
 		.compatible = "marvell,armada370-nand",
 		.data       = (void *)PXA3XX_NAND_VARIANT_ARMADA370,
 	},
+	{
+		.compatible = "marvell,berlin2-nand",
+		.data       = (void *)PXA3XX_NAND_VARIANT_BERLIN2,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, pxa3xx_nand_dt_ids);
@@ -780,7 +801,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 		nand_writel(info, NDCB0, info->ndcb2);
 
 		/* NDCB3 register is available in NFCv2 (Armada 370/XP SoC) */
-		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
+		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370 ||
+				info->variant == PXA3XX_NAND_VARIANT_BERLIN2)
 			nand_writel(info, NDCB0, info->ndcb3);
 	}
 
@@ -890,6 +912,16 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 	if (command == NAND_CMD_SEQIN)
 		exec_cmd = 0;
 
+	/* Berlin specific */
+	if (info->variant == PXA3XX_NAND_VARIANT_BERLIN2) {
+		if ((command == NAND_CMD_READ0 && !ext_cmd_type) ||
+				command == NAND_CMD_READOOB)
+			exec_cmd = 0;
+
+		if (command == NAND_CMD_SEQIN)
+			command = NAND_CMD_READ0;
+	}
+
 	addr_cycle = NDCB0_ADDR_CYC(host->row_addr_cycles
 				    + host->col_addr_cycles);
 
@@ -949,6 +981,37 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 			break;
 		}
 
+		if (info->variant == PXA3XX_NAND_VARIANT_BERLIN2) {
+			if (ext_cmd_type == EXT_CMD_TYPE_LAST_PAGEPROG) {
+				info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+						| NDCB0_CMD_XTYPE(0x3)
+						| NDCB0_ST_ROW_EN
+						| NDCB0_DBC
+						| (NAND_CMD_PAGEPROG << 8);
+			} else if (ext_cmd_type == EXT_CMD_TYPE_CHUNK_PAGEPROG) {
+				info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+						| NDCB0_CMD_XTYPE(0x5)
+						| NDCB0_NC
+						| NDCB0_AUTO_RS
+						| NDCB0_LEN_OVRD
+						| (NAND_CMD_PAGEPROG << 8)
+						| NAND_CMD_SEQIN;
+				info->ndcb3 = info->chunk_size;
+			} else {
+				info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+						| NDCB0_CMD_XTYPE(0x4)
+						| NDCB0_NC
+						| NDCB0_AUTO_RS
+						| NDCB0_LEN_OVRD
+						| addr_cycle
+						| (NAND_CMD_PAGEPROG << 8)
+						| NAND_CMD_SEQIN;
+				info->ndcb3 = info->chunk_size;
+			}
+
+			break;
+		}
+
 		/* Second command setting for large pages */
 		if (mtd->writesize > PAGE_CHUNK_SIZE) {
 			/*
@@ -1005,6 +1068,7 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 
 		info->data_size = 8;
 		break;
+
 	case NAND_CMD_STATUS:
 		info->buf_count = 1;
 		info->ndcb0 |= NDCB0_CMD_TYPE(4)
@@ -1013,7 +1077,6 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 
 		info->data_size = 8;
 		break;
-
 	case NAND_CMD_ERASE1:
 		info->ndcb0 |= NDCB0_CMD_TYPE(2)
 				| NDCB0_AUTO_RS
@@ -1211,6 +1274,92 @@ static int pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
 	return 0;
 }
 
+static void nand_cmdfunc_berlin(struct mtd_info *mtd, const unsigned command,
+		int column, int page_addr)
+{
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
+	unsigned long timeout;
+	int exec_cmd, ext_cmd_type = 0;
+	unsigned cmd = command;
+	irqreturn_t irq_ret;
+
+	if (info->reg_ndcr & NDCR_DWIDTH_M)
+		column /= 2;
+
+	/*
+	 * There may be different NAND chip hooked to
+	 * different chip select, so check whether
+	 * chip select has been changed, if yes, reset the timing
+	 */
+	if (info->cs != host->cs) {
+		info->cs = host->cs;
+		nand_writel(info, NDTR0CS0, info->ndtr0cs0);
+		nand_writel(info, NDTR1CS0, info->ndtr1cs0);
+	}
+
+	prepare_start_command(info, cmd);
+
+	info->need_wait = 1;
+	init_completion(&info->dev_ready);
+
+	pxa3xx_nand_start(info);
+
+	do {
+		init_completion(&info->cmd_complete);
+		info->state = STATE_PREPARED;
+		exec_cmd = prepare_set_command(info, cmd, ext_cmd_type,
+				column, page_addr);
+
+		if (cmd == NAND_CMD_READ0 && !ext_cmd_type) {
+			ext_cmd_type = NDCB0_CMD_XTYPE(0x5);
+			continue;
+		}
+
+		if (!exec_cmd) {
+			info->need_wait = 0;
+			complete(&info->dev_ready);
+			break;
+		}
+
+		/* no IRQ, poll */
+		timeout = jiffies + CHIP_DELAY_TIMEOUT;
+		do {
+			irq_ret = pxa3xx_nand_irq(0, info);
+			if (irq_ret == IRQ_WAKE_THREAD)
+				handle_data_pio(info);
+
+			if (cmd == NAND_CMD_PAGEPROG &&
+					ext_cmd_type != EXT_CMD_TYPE_LAST_PAGEPROG)
+				break;
+
+			if (time_after(jiffies, timeout))
+				goto berlin_timeout;
+		} while (!completion_done(&info->cmd_complete));
+
+		/* sequence completed */
+		if (info->data_size == 0)
+			break;
+
+		if (cmd == NAND_CMD_PAGEPROG &&
+				ext_cmd_type == EXT_CMD_TYPE_LAST_PAGEPROG) {
+			complete(&info->dev_ready);
+			break;
+		}
+
+		if (cmd == NAND_CMD_PAGEPROG) {
+			/* last command */
+			if (info->data_size == info->chunk_size * 2)
+				ext_cmd_type = EXT_CMD_TYPE_LAST_PAGEPROG;
+			else
+				ext_cmd_type = EXT_CMD_TYPE_CHUNK_PAGEPROG;
+		}
+	} while (1);
+
+berlin_timeout:
+	info->state = STATE_IDLE;
+}
+
 static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, uint8_t *buf, int oob_required,
 		int page)
@@ -1511,6 +1660,16 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		ecc->size = info->chunk_size;
 		ecc->layout = &ecc_layout_4KB_bch8bit;
 		ecc->strength = 16;
+	} else if (strength == 48 && ecc_stepsize == 1024 &&
+			page_size == 8192) {
+		info->ecc_bch = 1;
+		info->chunk_size = 2048;
+		info->spare_size = 0;
+		info->ecc_size = 32;
+		ecc->mode = NAND_ECC_HW;
+		ecc->size = info->chunk_size;
+		ecc->layout = &ecc_layout_oob_128;
+		ecc->strength = 48;
 	} else {
 		dev_err(&info->pdev->dev,
 			"ECC strength %d at page size %d is not supported\n",
@@ -1539,6 +1698,9 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	/* Set a default chunk size */
 	info->chunk_size = 512;
 
+	if (info->variant == PXA3XX_NAND_VARIANT_BERLIN2)
+		chip->cmdfunc = nand_cmdfunc_berlin;
+
 	ret = pxa3xx_nand_sensing(host);
 	if (ret) {
 		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",
@@ -1586,7 +1748,7 @@ KEEP_CONFIG:
 	if (mtd->writesize > PAGE_CHUNK_SIZE) {
 		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370) {
 			chip->cmdfunc = nand_cmdfunc_extended;
-		} else {
+		} else if (info->variant != PXA3XX_NAND_VARIANT_BERLIN2) {
 			dev_err(&info->pdev->dev,
 				"unsupported page size on this variant\n");
 			return -ENODEV;
-- 
2.4.5
