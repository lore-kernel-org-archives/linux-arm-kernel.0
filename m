From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:29 -0300
Subject: [PATCH v3 22/28] mtd: nand: pxa3xx: Introduce multiple page I/O
 support
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As preparation work to fully support large pages, this commit adds
the initial infrastructure to support splitted (aka chunked) I/O
operation. This commit adds support for read, and follow-up patches
will add write support.

When a read (aka READ0) command is issued, the driver loops issuing
the same command until all the requested data is transfered, changing
the 'extended' command field as needed.

For instance, if the driver is required to read a 4 KiB page, using a
chunk size of 2 KiB, the transaction is splitted in:
1. Monolithic read, first 2 KiB page chunk is read
2. Last naked read, second and last 2KiB page chunk is read

If ECC is enabled it is calculated on each chunk transfered and added
at a controller-fixed location after the data chunk that must be
spare area.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 192 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 185 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 9b42832..b9acd66 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -7,6 +7,20 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * Large pages implementation
+ * --------------------------
+ *
+ * NAND stack expects data in the following format:
+ * ---------------------------
+ * | Data (4K) | Spare | ECC |
+ * ---------------------------
+ *
+ * While NAND controller expects data to be in the following format:
+ * -----------------------------------------------------
+ * | Data (2K) | Spare | ECC | Data (2K) | Spare | ECC |
+ * -----------------------------------------------------
+ *
  */
 
 #include <linux/kernel.h>
@@ -101,6 +115,8 @@
 #define NDCB0_ST_ROW_EN         (0x1 << 26)
 #define NDCB0_AUTO_RS		(0x1 << 25)
 #define NDCB0_CSEL		(0x1 << 24)
+#define NDCB0_EXT_CMD_TYPE_MASK	(0x7 << 29)
+#define NDCB0_EXT_CMD_TYPE(x)	(((x) << 29) & NDCB0_EXT_CMD_TYPE_MASK)
 #define NDCB0_CMD_TYPE_MASK	(0x7 << 21)
 #define NDCB0_CMD_TYPE(x)	(((x) << 21) & NDCB0_CMD_TYPE_MASK)
 #define NDCB0_NC		(0x1 << 20)
@@ -111,6 +127,14 @@
 #define NDCB0_CMD1_MASK		(0xff)
 #define NDCB0_ADDR_CYC_SHIFT	(16)
 
+#define EXT_CMD_TYPE_DISPATCH	6 /* Command dispatch */
+#define EXT_CMD_TYPE_NAKED_RW	5 /* Naked read or Naked write */
+#define EXT_CMD_TYPE_READ	4 /* Read */
+#define EXT_CMD_TYPE_DISP_WR	4 /* Command dispatch with write */
+#define EXT_CMD_TYPE_FINAL	3 /* Final command */
+#define EXT_CMD_TYPE_LAST_RW	1 /* Last naked read/write */
+#define EXT_CMD_TYPE_MONO	0 /* Monolithic read/write */
+
 /* macros for registers read/write */
 #define nand_writel(info, off, val)	\
 	__raw_writel((val), (info)->mmio_base + (off))
@@ -212,6 +236,7 @@ struct pxa3xx_nand_info {
 
 	unsigned int		fifo_size;	/* max. data size in the FIFO */
 	unsigned int		data_size;	/* data to be read from FIFO */
+	unsigned int		chunk_size;	/* split commands chunk size */
 	unsigned int		oob_size;
 	unsigned int		spare_size;
 	unsigned int		ecc_size;
@@ -275,6 +300,31 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = bbt_mirror_pattern
 };
 
+static struct nand_ecclayout ecc_layout_4KB_bch4bit = {
+	.eccbytes = 64,
+	.eccpos = {
+		32,  33,  34,  35,  36,  37,  38,  39,
+		40,  41,  42,  43,  44,  45,  46,  47,
+		48,  49,  50,  51,  52,  53,  54,  55,
+		56,  57,  58,  59,  60,  61,  62,  63,
+		96,  97,  98,  99,  100, 101, 102, 103,
+		104, 105, 106, 107, 108, 109, 110, 111,
+		112, 113, 114, 115, 116, 117, 118, 119,
+		120, 121, 122, 123, 124, 125, 126, 127},
+	/* Bootrom looks in bytes 0 & 5 for bad blocks */
+	.oobfree = { {6, 26}, { 64, 32} }
+};
+
+static struct nand_ecclayout ecc_layout_4KB_bch8bit = {
+	.eccbytes = 128,
+	.eccpos = {
+		32,  33,  34,  35,  36,  37,  38,  39,
+		40,  41,  42,  43,  44,  45,  46,  47,
+		48,  49,  50,  51,  52,  53,  54,  55,
+		56,  57,  58,  59,  60,  61,  62,  63},
+	.oobfree = { }
+};
+
 /* Define a default flash type setting serve as flash detecting only */
 #define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
 
@@ -437,7 +487,7 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
 
 static void handle_data_pio(struct pxa3xx_nand_info *info)
 {
-	unsigned int do_bytes = min(info->data_size, info->fifo_size);
+	unsigned int do_bytes = min(info->data_size, info->chunk_size);
 
 	switch (info->state) {
 	case STATE_PIO_WRITING:
@@ -675,7 +725,7 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 }
 
 static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
-		uint16_t column, int page_addr)
+		int ext_cmd_type, uint16_t column, int page_addr)
 {
 	int addr_cycle, exec_cmd;
 	struct pxa3xx_nand_host *host;
@@ -708,9 +758,20 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
 		if (command == NAND_CMD_READOOB)
 			info->buf_start += mtd->writesize;
 
-		/* Second command setting for large pages */
-		if (mtd->writesize >= PAGE_CHUNK_SIZE)
+		/*
+		 * Multiple page read needs an 'extended command type' field,
+		 * which is either naked-read or last-read according to the
+		 * state.
+		 */
+		if (mtd->writesize == PAGE_CHUNK_SIZE) {
 			info->ndcb0 |= NDCB0_DBC | (NAND_CMD_READSTART << 8);
+		} else if (mtd->writesize > PAGE_CHUNK_SIZE) {
+			info->ndcb0 |= NDCB0_DBC | (NAND_CMD_READSTART << 8)
+					| NDCB0_LEN_OVRD
+					| NDCB0_EXT_CMD_TYPE(ext_cmd_type);
+			info->ndcb3 = info->chunk_size +
+				      info->oob_size;
+		}
 
 		set_command_address(info, mtd->writesize, column, page_addr);
 		break;
@@ -826,7 +887,8 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	prepare_start_command(info, command);
 
 	info->state = STATE_PREPARED;
-	exec_cmd = prepare_set_command(info, command, column, page_addr);
+	exec_cmd = prepare_set_command(info, command, -1, column, page_addr);
+
 	if (exec_cmd) {
 		init_completion(&info->cmd_complete);
 		init_completion(&info->dev_ready);
@@ -844,6 +906,91 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	info->state = STATE_IDLE;
 }
 
+static void armada370_nand_cmdfunc(struct mtd_info *mtd,
+				   const unsigned command,
+				   int column, int page_addr)
+{
+	struct pxa3xx_nand_host *host = mtd->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
+	int ret, exec_cmd, ext_cmd_type;
+
+	/*
+	 * if this is a x16 device ,then convert the input
+	 * "byte" address into a "word" address appropriate
+	 * for indexing a word-oriented device
+	 */
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
+	/* Select the extended command for the first command */
+	switch (command) {
+	case NAND_CMD_READ0:
+	case NAND_CMD_READOOB:
+		ext_cmd_type = EXT_CMD_TYPE_MONO;
+		break;
+	}
+
+	prepare_start_command(info, command);
+
+	/*
+	 * Prepare the "is ready" completion before starting a command
+	 * transaction sequence. If the command is not executed the
+	 * completion will be completed, see below.
+	 *
+	 * We can do that inside the loop because the command variable
+	 * is invariant and thus so is the exec_cmd.
+	 */
+	atomic_set(&info->is_ready, 0);
+	init_completion(&info->dev_ready);
+	do {
+		info->state = STATE_PREPARED;
+		exec_cmd = prepare_set_command(info, command, ext_cmd_type,
+					       column, page_addr);
+		if (!exec_cmd) {
+			atomic_set(&info->is_ready, 1);
+			complete(&info->dev_ready);
+			break;
+		}
+
+		init_completion(&info->cmd_complete);
+		pxa3xx_nand_start(info);
+
+		ret = wait_for_completion_timeout(&info->cmd_complete,
+				CHIP_DELAY_TIMEOUT);
+		if (!ret) {
+			dev_err(&info->pdev->dev, "Wait time out!!!\n");
+			/* Stop State Machine for next command cycle */
+			pxa3xx_nand_stop(info);
+			break;
+		}
+
+		/* Check if the sequence is complete */
+		if (info->data_size == 0)
+			break;
+
+		if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB) {
+			/* Last read: issue a 'last naked read' */
+			if (info->data_size == info->chunk_size)
+				ext_cmd_type = EXT_CMD_TYPE_LAST_RW;
+			else
+				ext_cmd_type = EXT_CMD_TYPE_NAKED_RW;
+		}
+	} while (1);
+
+	info->state = STATE_IDLE;
+}
+
 static int pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, const uint8_t *buf, int oob_required)
 {
@@ -1029,6 +1176,8 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 		host->read_id_bytes = 2;
 	}
 
+	/* Set an initial chunk size */
+	info->chunk_size = info->fifo_size;
 	info->reg_ndcr = ndcr & ~NDCR_INT_MASK;
 	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
 	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
@@ -1135,6 +1284,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		ecc->size = 512;
 		ecc->strength = 1;
 
+		info->chunk_size = 2048;
 		info->spare_size = 40;
 		info->ecc_size = 24;
 		return 1;
@@ -1144,6 +1294,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		ecc->size = 512;
 		ecc->strength = 1;
 
+		info->chunk_size = 512;
 		info->spare_size = 8;
 		info->ecc_size = 8;
 		return 1;
@@ -1155,7 +1306,30 @@ static int armada370_ecc_init(struct pxa3xx_nand_info *info,
 			      struct nand_ecc_ctrl *ecc,
 			      int strength, int page_size)
 {
-	/* Unimplemented yet */
+	if (strength == 4 && page_size == 4096) {
+		ecc->mode = NAND_ECC_HW;
+		ecc->size = 512;
+		ecc->layout = &ecc_layout_4KB_bch4bit;
+		ecc->strength = 4;
+
+		info->ecc_bch = 1;
+		info->chunk_size = 2048;
+		info->spare_size = 32;
+		info->ecc_size = 32;
+		return 1;
+
+	} else if (strength == 8 && page_size == 4096) {
+		ecc->mode = NAND_ECC_HW;
+		ecc->size = 512;
+		ecc->layout = &ecc_layout_4KB_bch8bit;
+		ecc->strength = 8;
+
+		info->ecc_bch = 1;
+		info->chunk_size = 1024;
+		info->spare_size = 0;
+		info->ecc_size = 32;
+		return 1;
+	}
 	return 0;
 }
 
@@ -1319,12 +1493,16 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		chip->controller        = &info->controller;
 		chip->waitfunc		= pxa3xx_nand_waitfunc;
 		chip->select_chip	= pxa3xx_nand_select_chip;
-		chip->cmdfunc		= pxa3xx_nand_cmdfunc;
 		chip->read_word		= pxa3xx_nand_read_word;
 		chip->read_byte		= pxa3xx_nand_read_byte;
 		chip->read_buf		= pxa3xx_nand_read_buf;
 		chip->write_buf		= pxa3xx_nand_write_buf;
 		chip->options		|= NAND_NO_SUBPAGE_WRITE;
+
+		if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
+			chip->cmdfunc = armada370_nand_cmdfunc;
+		else
+			chip->cmdfunc = pxa3xx_nand_cmdfunc;
 	}
 
 	spin_lock_init(&chip->controller->lock);
-- 
1.8.1.5
