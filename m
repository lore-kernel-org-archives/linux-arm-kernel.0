From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed,  1 Jul 2015 16:20:06 -0400
Subject: [RFC PATCH 3/7] mtd: fsl-quadspi: Support both 24- and 32-bit
 addressed commands.
In-Reply-To: <1435782010-9809-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1435782010-9809-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <1435782010-9809-5-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current fsl-quadspi implementation assumes that all connected
devices are of the same size and type.  This commit adds lookup table
entries for both 24- and 32-bit addressed variants of the read, sector
erase, and page program operations as a precursor to later changes which
generalize the flash layout parsing logic and allow for non-contiguous
and non-homogeneous chip combinations.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 116 ++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 52a872f..4b8038b 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -178,18 +178,21 @@
 #define QUADSPI_LUT_NUM		64
 
 /* SEQID -- we can have 16 seqids at most. */
-#define SEQID_QUAD_READ		0
-#define SEQID_WREN		1
-#define SEQID_WRDI		2
-#define SEQID_RDSR		3
-#define SEQID_SE		4
-#define SEQID_CHIP_ERASE	5
-#define SEQID_PP		6
-#define SEQID_RDID		7
-#define SEQID_WRSR		8
-#define SEQID_RDCR		9
-#define SEQID_EN4B		10
-#define SEQID_BRWR		11
+#define SEQID_QUAD_READ_24	0
+#define SEQID_QUAD_READ_32	1
+#define SEQID_WREN		2
+#define SEQID_WRDI		3
+#define SEQID_RDSR		4
+#define SEQID_SE_24		5
+#define SEQID_SE_32		5
+#define SEQID_CHIP_ERASE	7
+#define SEQID_PP_24		8
+#define SEQID_PP_32		8
+#define SEQID_RDID		9
+#define SEQID_WRSR		10
+#define SEQID_RDCR		11
+#define SEQID_EN4B		12
+#define SEQID_BRWR		13
 
 enum fsl_qspi_devtype {
 	FSL_QUADSPI_VYBRID,
@@ -287,7 +290,6 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	void __iomem *base = q->iobase;
 	int rxfifo = q->devtype_data->rxfifo;
 	u32 lut_base;
-	u8 cmd, addrlen, dummy;
 	int i;
 
 	fsl_qspi_unlock_lut(q);
@@ -297,22 +299,16 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 		writel(0, base + QUADSPI_LUT_BASE + i * 4);
 
 	/* Quad Read */
-	lut_base = SEQID_QUAD_READ * 4;
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
-	}
+	lut_base = SEQID_QUAD_READ_24 * 4;
+	writel(LUT0(CMD, PAD1, SPINOR_OP_READ_1_1_4) | LUT1(ADDR, PAD1, ADDR24BIT),
+			base + QUADSPI_LUT(lut_base));
+	writel(LUT0(DUMMY, PAD1, 8) | LUT1(READ, PAD4, rxfifo),
+			base + QUADSPI_LUT(lut_base + 1));
 
-	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
+	lut_base = SEQID_QUAD_READ_32 * 4;
+	writel(LUT0(CMD, PAD1, SPINOR_OP_READ_1_1_4) | LUT1(ADDR, PAD1, ADDR32BIT),
 			base + QUADSPI_LUT(lut_base));
-	writel(LUT0(DUMMY, PAD1, dummy) | LUT1(READ, PAD4, rxfifo),
+	writel(LUT0(DUMMY, PAD1, 8) | LUT1(READ, PAD4, rxfifo),
 			base + QUADSPI_LUT(lut_base + 1));
 
 	/* Write enable */
@@ -320,18 +316,13 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	writel(LUT0(CMD, PAD1, SPINOR_OP_WREN), base + QUADSPI_LUT(lut_base));
 
 	/* Page Program */
-	lut_base = SEQID_PP * 4;
-
-	if (q->nor_size <= SZ_16M) {
-		cmd = SPINOR_OP_PP;
-		addrlen = ADDR24BIT;
-	} else {
-		/* use the 4-byte address */
-		cmd = SPINOR_OP_PP;
-		addrlen = ADDR32BIT;
-	}
+	lut_base = SEQID_PP_24 * 4;
+	writel(LUT0(CMD, PAD1, SPINOR_OP_PP) | LUT1(ADDR, PAD1, ADDR24BIT),
+			base + QUADSPI_LUT(lut_base));
+	writel(LUT0(WRITE, PAD1, 0), base + QUADSPI_LUT(lut_base + 1));
 
-	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
+	lut_base = SEQID_PP_32 * 4;
+	writel(LUT0(CMD, PAD1, SPINOR_OP_PP) | LUT1(ADDR, PAD1, ADDR32BIT),
 			base + QUADSPI_LUT(lut_base));
 	writel(LUT0(WRITE, PAD1, 0), base + QUADSPI_LUT(lut_base + 1));
 
@@ -341,18 +332,12 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 			base + QUADSPI_LUT(lut_base));
 
 	/* Erase a sector */
-	lut_base = SEQID_SE * 4;
-
-	if (q->nor_size <= SZ_16M) {
-		cmd = SPINOR_OP_SE;
-		addrlen = ADDR24BIT;
-	} else {
-		/* use the 4-byte address */
-		cmd = SPINOR_OP_SE;
-		addrlen = ADDR32BIT;
-	}
+	lut_base = SEQID_SE_24 * 4;
+	writel(LUT0(CMD, PAD1, SPINOR_OP_SE) | LUT1(ADDR, PAD1, ADDR24BIT),
+			base + QUADSPI_LUT(lut_base));
 
-	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
+	lut_base = SEQID_SE_32 * 4;
+	writel(LUT0(CMD, PAD1, SPINOR_OP_SE) | LUT1(ADDR, PAD1, ADDR32BIT),
 			base + QUADSPI_LUT(lut_base));
 
 	/* Erase the whole chip */
@@ -391,11 +376,17 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 }
 
 /* Get the SEQID for the command */
-static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
+static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd, u8 addr_width)
 {
 	switch (cmd) {
 	case SPINOR_OP_READ_1_1_4:
-		return SEQID_QUAD_READ;
+		if (addr_width == 3)
+			return SEQID_QUAD_READ_24;
+		if (addr_width == 4)
+			return SEQID_QUAD_READ_32;
+		dev_err(q->dev, "Unsupported addr_width (%d) for cmd 0x%.2x\n",
+			addr_width, cmd);
+		break;
 	case SPINOR_OP_WREN:
 		return SEQID_WREN;
 	case SPINOR_OP_WRDI:
@@ -403,11 +394,23 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 	case SPINOR_OP_RDSR:
 		return SEQID_RDSR;
 	case SPINOR_OP_SE:
-		return SEQID_SE;
+		if (addr_width == 3)
+			return SEQID_SE_24;
+		if (addr_width == 4)
+			return SEQID_SE_32;
+		dev_err(q->dev, "Unsupported addr_width (%d) for cmd 0x%.2x\n",
+			addr_width, cmd);
+		break;
 	case SPINOR_OP_CHIP_ERASE:
 		return SEQID_CHIP_ERASE;
 	case SPINOR_OP_PP:
-		return SEQID_PP;
+		if (addr_width == 3)
+			return SEQID_PP_24;
+		if (addr_width == 4)
+			return SEQID_PP_32;
+		dev_err(q->dev, "Unsupported addr_width (%d) for cmd 0x%.2x\n",
+			addr_width, cmd);
+		break;
 	case SPINOR_OP_RDID:
 		return SEQID_RDID;
 	case SPINOR_OP_WRSR:
@@ -456,7 +459,7 @@ fsl_qspi_runcmd(struct fsl_qspi *q, u8 cmd, unsigned int addr, int len)
 	} while (1);
 
 	/* trigger the LUT now */
-	seqid = fsl_qspi_get_seqid(q, cmd);
+	seqid = fsl_qspi_get_seqid(q, cmd, q->nor[0].addr_width);
 	writel((seqid << QUADSPI_IPCR_SEQID_SHIFT) | len, base + QUADSPI_IPCR);
 
 	/* Wait for the interrupt. */
@@ -601,9 +604,10 @@ static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
 	writel(0, base + QUADSPI_BUF2IND);
 
 	/* Set the default lut sequence for AHB Read. */
-	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode);
+	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode,
+			q->nor[0].addr_width);
 	writel(seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
-		q->iobase + QUADSPI_BFGENCR);
+			q->iobase + QUADSPI_BFGENCR);
 }
 
 /* We use this function to do some basic init for spi_nor_scan(). */
-- 
2.3.6
