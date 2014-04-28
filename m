From: b32955@freescale.com (Huang Shijie)
Date: Mon, 28 Apr 2014 11:53:43 +0800
Subject: [PATCH v2 06/10] mtd: fsl-quadspi: use the information stored in
 spi-nor{}
In-Reply-To: <1398657227-20721-1-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
Message-ID: <1398657227-20721-7-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can get the read/write/erase opcode from the spi nor framework now.
What's more is that we can get the correct dummy cycles.

This patch uses the information stored in the spi_nor{} to remove the
hardcode in the fsl_qspi_init_lut().

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c |   57 ++++++++++++------------------------
 1 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 8d659a2..4adf79e 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -280,8 +280,10 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	int rxfifo = q->devtype_data->rxfifo;
+	struct spi_nor *nor = &q->nor[0];
+	u8 addrlen = (nor->addr_width == 3) ? ADDR24BIT : ADDR32BIT;
 	u32 lut_base;
-	u8 cmd, addrlen, dummy;
+	u8 op, dm;
 	int i;
 
 	fsl_qspi_unlock_lut(q);
@@ -292,40 +294,28 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 
 	/* Quad Read */
 	lut_base = SEQID_QUAD_READ * 4;
-
-	if (q->nor_size <= SZ_16M) {
-		cmd = SPINOR_OP_READ_1_1_4;
-		addrlen = ADDR24BIT;
-		dummy = 8;
-	} else {
-		/* use the 4-byte address */
-		cmd = SPINOR_OP_READ_1_1_4;
-		addrlen = ADDR32BIT;
-		dummy = 8;
+	op = nor->read_opcode;
+	dm = nor->read_dummy;
+	if (nor->flash_read == SPI_NOR_QUAD) {
+		if (op == SPINOR_OP_READ_1_1_4 || op == SPINOR_OP_READ4_1_1_4) {
+			/* read mode : 1-1-4 */
+			writel(LUT0(CMD, PAD1, op) | LUT1(ADDR, PAD1, addrlen),
+				base + QUADSPI_LUT(lut_base));
+
+			writel(LUT0(DUMMY, PAD1, dm) | LUT1(READ, PAD4, rxfifo),
+				base + QUADSPI_LUT(lut_base + 1));
+		} else {
+			dev_err(nor->dev, "Unsupported opcode : 0x%.2x\n", op);
+		}
 	}
 
-	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
-			base + QUADSPI_LUT(lut_base));
-	writel(LUT0(DUMMY, PAD1, dummy) | LUT1(READ, PAD4, rxfifo),
-			base + QUADSPI_LUT(lut_base + 1));
-
 	/* Write enable */
 	lut_base = SEQID_WREN * 4;
 	writel(LUT0(CMD, PAD1, SPINOR_OP_WREN), base + QUADSPI_LUT(lut_base));
 
 	/* Page Program */
 	lut_base = SEQID_PP * 4;
-
-	if (q->nor_size <= SZ_16M) {
-		cmd = SPINOR_OP_PP;
-		addrlen = ADDR24BIT;
-	} else {
-		/* use the 4-byte address */
-		cmd = SPINOR_OP_PP;
-		addrlen = ADDR32BIT;
-	}
-
-	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
+	writel(LUT0(CMD, PAD1, nor->program_opcode) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
 	writel(LUT0(WRITE, PAD1, 0), base + QUADSPI_LUT(lut_base + 1));
 
@@ -336,17 +326,7 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 
 	/* Erase a sector */
 	lut_base = SEQID_SE * 4;
-
-	if (q->nor_size <= SZ_16M) {
-		cmd = SPINOR_OP_SE;
-		addrlen = ADDR24BIT;
-	} else {
-		/* use the 4-byte address */
-		cmd = SPINOR_OP_SE;
-		addrlen = ADDR32BIT;
-	}
-
-	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
+	writel(LUT0(CMD, PAD1, nor->erase_opcode) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
 
 	/* Erase the whole chip */
@@ -396,6 +376,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 		return SEQID_WRDI;
 	case SPINOR_OP_RDSR:
 		return SEQID_RDSR;
+	case SPINOR_OP_BE_4K:
 	case SPINOR_OP_SE:
 		return SEQID_SE;
 	case SPINOR_OP_CHIP_ERASE:
-- 
1.7.2.rc3
