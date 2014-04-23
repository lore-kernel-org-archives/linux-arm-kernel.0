From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Apr 2014 18:16:50 +0800
Subject: [PATCH v1 2/7] mtd: spi-nor: add DDR quad read support
In-Reply-To: <a>
References: <a>
Message-ID: <1398248215-26768-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DDR quad read support by the following:

  [1] add SPI_NOR_DDR_QUAD read mode.

  [2] add DDR Quad read opcodes:
       SPINOR_OP_READ_1_4_4_D / SPINOR_OP_READ4_1_4_4_D

  [3] add set_ddr_quad_mode() to initialize for the DDR quad read.
      Currently it only works for Spansion NOR.

  [3] set the dummy with 8 for DDR quad read.
      The m25p80.c can not support the DDR quad read, the SPI NOR controller
      can set the dummy value in its driver, such as fsl-quadspi.c.

Test this patch for Spansion s25fl128s NOR flash.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/spi-nor/spi-nor.c |   50 +++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |    8 +++++-
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1a12f81..e2f69db 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -74,6 +74,15 @@ static int read_cr(struct spi_nor *nor)
 static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
 {
 	switch (nor->flash_read) {
+	case SPI_NOR_DDR_QUAD:
+		/*
+		 * The m25p80.c can not support the DDR quad read.
+		 * We set the dummy cycles to 8 by default. If the SPI NOR
+		 * controller driver has already set it before call the
+		 * spi_nor_scan(), we just keep it as it is.
+		 */
+		if (nor->read_dummy)
+			return nor->read_dummy;
 	case SPI_NOR_FAST:
 	case SPI_NOR_DUAL:
 	case SPI_NOR_QUAD:
@@ -402,6 +411,7 @@ struct flash_info {
 #define	SECT_4K_PMC		0x10	/* SPINOR_OP_BE_4K_PMC works uniformly */
 #define	SPI_NOR_DUAL_READ	0x20    /* Flash supports Dual Read */
 #define	SPI_NOR_QUAD_READ	0x40    /* Flash supports Quad Read */
+#define	SPI_NOR_DDR_QUAD_READ	0x80    /* Flash supports DDR Quad Read */
 };
 
 #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
@@ -846,6 +856,24 @@ static int spansion_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
+static int set_ddr_quad_mode(struct spi_nor *nor, u32 jedec_id)
+{
+	int status;
+
+	switch (JEDEC_MFR(jedec_id)) {
+	case CFI_MFR_AMD: /* Spansion, actually */
+		status = spansion_quad_enable(nor);
+		if (status) {
+			dev_err(nor->dev,
+				"Spansion DDR quad-read not enabled\n");
+			return -EINVAL;
+		}
+		return status;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int set_quad_mode(struct spi_nor *nor, u32 jedec_id)
 {
 	int status;
@@ -1016,8 +1044,15 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	if (info->flags & SPI_NOR_NO_FR)
 		nor->flash_read = SPI_NOR_NORMAL;
 
-	/* Quad/Dual-read mode takes precedence over fast/normal */
-	if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
+	/* DDR Quad/Quad/Dual-read mode takes precedence over fast/normal */
+	if (mode == SPI_NOR_DDR_QUAD && info->flags & SPI_NOR_DDR_QUAD_READ) {
+		ret = set_ddr_quad_mode(nor, info->jedec_id);
+		if (ret) {
+			dev_err(dev, "DDR quad mode not supported\n");
+			return ret;
+		}
+		nor->flash_read = SPI_NOR_DDR_QUAD;
+	} else if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
 		ret = set_quad_mode(nor, info->jedec_id);
 		if (ret) {
 			dev_err(dev, "quad mode not supported\n");
@@ -1030,6 +1065,14 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 
 	/* Default commands */
 	switch (nor->flash_read) {
+	case SPI_NOR_DDR_QUAD:
+		if (JEDEC_MFR(info->jedec_id) == CFI_MFR_AMD) { /* Spansion */
+			nor->read_opcode = SPINOR_OP_READ_1_4_4_D;
+		} else {
+			dev_err(dev, "DDR Quad Read is not supported.\n");
+			return -EINVAL;
+		}
+		break;
 	case SPI_NOR_QUAD:
 		nor->read_opcode = SPINOR_OP_READ_1_1_4;
 		break;
@@ -1057,6 +1100,9 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 		if (JEDEC_MFR(info->jedec_id) == CFI_MFR_AMD) {
 			/* Dedicated 4-byte command set */
 			switch (nor->flash_read) {
+			case SPI_NOR_DDR_QUAD:
+				nor->read_opcode = SPINOR_OP_READ4_1_4_4_D;
+				break;
 			case SPI_NOR_QUAD:
 				nor->read_opcode = SPINOR_OP_READ4_1_1_4;
 				break;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5324184..fea7769 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -12,10 +12,11 @@
 
 /*
  * Note on opcode nomenclature: some opcodes have a format like
- * SPINOR_OP_FUNCTION{4,}_x_y_z. The numbers x, y, and z stand for the number
+ * SPINOR_OP_FUNCTION{4,}_x_y_z{_D}. The numbers x, y, and z stand for the number
  * of I/O lines used for the opcode, address, and data (respectively). The
  * FUNCTION has an optional suffix of '4', to represent an opcode which
- * requires a 4-byte (32-bit) address.
+ * requires a 4-byte (32-bit) address. The suffix of 'D' stands for the
+ * DDR mode.
  */
 
 /* Flash opcodes. */
@@ -26,6 +27,7 @@
 #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
 #define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual SPI) */
 #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ_1_4_4_D	0xed	/* Read data bytes (DDR Quad SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
@@ -40,6 +42,7 @@
 #define SPINOR_OP_READ4_FAST	0x0c	/* Read data bytes (high frequency) */
 #define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual SPI) */
 #define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ4_1_4_4_D	0xee	/* Read data bytes (DDR Quad SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
 
@@ -74,6 +77,7 @@ enum read_mode {
 	SPI_NOR_FAST,
 	SPI_NOR_DUAL,
 	SPI_NOR_QUAD,
+	SPI_NOR_DDR_QUAD,
 };
 
 /**
-- 
1.7.2.rc3
