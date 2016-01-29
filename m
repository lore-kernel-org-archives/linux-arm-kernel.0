From: B56489@freescale.com (Yunhui Cui)
Date: Fri, 29 Jan 2016 19:41:09 +0800
Subject: [PATCH 3/3] mtd:spi-nor:fsl-quadspi:Add fast-read mode support
In-Reply-To: <1454067669-35274-1-git-send-email-B56489@freescale.com>
References: <1454067669-35274-1-git-send-email-B56489@freescale.com>
Message-ID: <1454067669-35274-4-git-send-email-B56489@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qspi driver add generic fast-read mode for different
flash venders, including Micron family. Also add some special
operations for Micron flash read/write in spi-nor.c.

Signed-off-by: Yunhui Cui <B56489@freescale.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 27 +++++++++++++++++++++------
 drivers/mtd/spi-nor/spi-nor.c     |  6 +++++-
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 9861290..fc4451d 100644
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
@@ -963,6 +974,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	struct spi_nor *nor;
 	struct mtd_info *mtd;
 	int ret, i = 0;
+	enum read_mode mode = SPI_NOR_QUAD;
 
 	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
 	if (!q)
@@ -1064,7 +1076,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
 
-		ret = spi_nor_scan(nor, NULL, SPI_NOR_QUAD);
+		ret = of_property_read_bool(np, "fast-read");
+		mode = (ret) ? SPI_NOR_FAST : SPI_NOR_QUAD;
+
+		ret = spi_nor_scan(nor, NULL, mode);
 		if (ret)
 			goto mutex_failed;
 
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index ed0c19c..79a025c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -763,7 +763,8 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SPI_NOR_QUAD_READ) },
-	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SPI_NOR_QUAD_READ) },
+	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SPI_NOR_FAST |
+			SPI_NOR_QUAD_READ) },
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
@@ -1233,6 +1234,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 
 	if (JEDEC_MFR(info) == SNOR_MFR_ATMEL ||
 	    JEDEC_MFR(info) == SNOR_MFR_INTEL ||
+	    JEDEC_MFR(info) == SNOR_MFR_MICRON ||
 	    JEDEC_MFR(info) == SNOR_MFR_SST) {
 		write_enable(nor);
 		write_sr(nor, 0);
@@ -1317,6 +1319,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		nor->flash_read = SPI_NOR_QUAD;
 	} else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
 		nor->flash_read = SPI_NOR_DUAL;
+	} else if (mode == SPI_NOR_FAST && info->flags & SPI_NOR_FAST) {
+		nor->flash_read = SPI_NOR_FAST;
 	}
 
 	/* Default commands */
-- 
2.1.0.27.g96db324
