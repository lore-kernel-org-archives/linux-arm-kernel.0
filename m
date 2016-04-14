From: B56489@freescale.com (Yunhui Cui)
Date: Thu, 14 Apr 2016 11:50:49 +0800
Subject: [PATCH 3/9] mtd: spi-nor: fsl-quadspi: add fast-read mode support
In-Reply-To: <1460605855-6689-1-git-send-email-B56489@freescale.com>
References: <1460605855-6689-1-git-send-email-B56489@freescale.com>
Message-ID: <1460605855-6689-4-git-send-email-B56489@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yunhui Cui <yunhui.cui@nxp.com>

The qspi driver add generic fast-read mode for different
flash venders. There are some different board flash work on
different mode, such fast-read, quad-mode.

Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 9861290..09adaa4 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -389,11 +389,21 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	/* Read */
 	lut_base = SEQID_READ * 4;
 
-	qspi_writel(q, LUT0(CMD, PAD1, read_op) | LUT1(ADDR, PAD1, addrlen),
-			base + QUADSPI_LUT(lut_base));
-	qspi_writel(q, LUT0(DUMMY, PAD1, read_dm) |
-		    LUT1(FSL_READ, PAD4, rxfifo),
-			base + QUADSPI_LUT(lut_base + 1));
+	if (nor->flash_read == SPI_NOR_FAST) {
+		qspi_writel(q, LUT0(CMD, PAD1, read_op) |
+			    LUT1(ADDR, PAD1, addrlen),
+				base + QUADSPI_LUT(lut_base));
+		qspi_writel(q,  LUT0(DUMMY, PAD1, read_dm) |
+			    LUT1(FSL_READ, PAD1, rxfifo),
+				base + QUADSPI_LUT(lut_base + 1));
+	} else if (nor->flash_read == SPI_NOR_QUAD) {
+		qspi_writel(q, LUT0(CMD, PAD1, read_op) |
+			    LUT1(ADDR, PAD1, addrlen),
+				base + QUADSPI_LUT(lut_base));
+		qspi_writel(q, LUT0(DUMMY, PAD1, read_dm) |
+			    LUT1(FSL_READ, PAD4, rxfifo),
+				base + QUADSPI_LUT(lut_base + 1));
+	}
 
 	/* Write enable */
 	lut_base = SEQID_WREN * 4;
@@ -468,6 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 {
 	switch (cmd) {
 	case SPINOR_OP_READ_1_1_4:
+	case SPINOR_OP_READ_FAST:
 		return SEQID_READ;
 	case SPINOR_OP_WREN:
 		return SEQID_WREN;
-- 
2.1.0.27.g96db324
