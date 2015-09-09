From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 9 Sep 2015 15:24:14 +0200
Subject: [PATCH linux-next v6 4/8] mtd: spi-nor: use optimized commands for
 read/write/erase operations
In-Reply-To: <cover.1441803609.git.cyrille.pitchen@atmel.com>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com>
Message-ID: <3a917bbb1408e89239255a780bf991e5511f5535.1441803609.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The op codes used by the spi-nor framework are now tuned depending on the
memory manufacturer.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 156 +++++++++++++++++++++++++++++++++++-------
 include/linux/mtd/spi-nor.h   |   6 ++
 2 files changed, 138 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4b36aada3f4c..820a2177ed5e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -193,6 +193,8 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 			write_disable(nor);
 
 		return status;
+	case CFI_MFR_AMD:
+		return 0;
 	default:
 		/* Spansion style */
 		nor->cmd_buf[0] = enable << 7;
@@ -945,7 +947,7 @@ static int spansion_quad_enable(struct spi_nor *nor)
 	}
 
 	/* set read/write protocols */
-	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->read_proto = SPI_PROTO_1_4_4;
 	nor->write_proto = SPI_PROTO_1_1_4;
 
 	return 0;
@@ -1059,7 +1061,7 @@ static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
 		return status;
 	case CFI_MFR_MACRONIX:
 	case CFI_MFR_AMD:
-		nor->read_proto = SPI_PROTO_1_1_2;
+		nor->read_proto = SPI_PROTO_1_2_2;
 		break;
 	default:
 		break;
@@ -1068,6 +1070,130 @@ static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
 	return 0;
 }
 
+static void macronix_set_commands(struct spi_nor *nor)
+{
+	switch (nor->flash_read) {
+	case SPI_NOR_QUAD: /* QPI mode */
+		nor->read_opcode = SPINOR_OP_READ_1_4_4;
+		break;
+
+	case SPI_NOR_DUAL:
+		nor->read_opcode = SPINOR_OP_READ_1_2_2;
+		break;
+
+	case SPI_NOR_FAST:
+		nor->read_opcode = SPINOR_OP_READ_FAST;
+		break;
+
+	case SPI_NOR_NORMAL:
+	default:
+		nor->read_opcode = SPINOR_OP_READ;
+		break;
+	}
+
+	nor->program_opcode = SPINOR_OP_PP;
+}
+
+static void micron_set_commands(struct spi_nor *nor)
+{
+	switch (nor->flash_read) {
+	case SPI_NOR_QUAD: /* Quad I/O operations */
+		nor->read_opcode = SPINOR_OP_READ_1_4_4;
+		break;
+
+	case SPI_NOR_DUAL: /* Dual I/O operations */
+		nor->read_opcode = SPINOR_OP_READ_1_2_2;
+		break;
+
+	case SPI_NOR_FAST:
+		nor->read_opcode = SPINOR_OP_READ_FAST;
+		break;
+
+	case SPI_NOR_NORMAL:
+	default:
+		nor->read_opcode = SPINOR_OP_READ;
+		break;
+	}
+
+	nor->program_opcode = SPINOR_OP_PP;
+}
+
+static void spansion_set_commands(struct spi_nor *nor,
+				  const struct flash_info *info)
+{
+	bool addr_4byte = (nor->addr_width == 4);
+	struct mtd_info *mtd = nor->mtd;
+
+	switch (nor->flash_read) {
+	case SPI_NOR_QUAD:
+		if (addr_4byte) {
+			nor->read_opcode = SPINOR_OP_READ4_1_4_4;
+			nor->program_opcode = SPINOR_OP_PP_4B_1_1_4;
+		} else {
+			nor->read_opcode = SPINOR_OP_READ_1_4_4;
+			nor->program_opcode = SPINOR_OP_PP_1_1_4;
+		}
+		break;
+
+	case SPI_NOR_DUAL:
+		if (addr_4byte) {
+			nor->read_opcode = SPINOR_OP_READ4_1_2_2;
+			nor->program_opcode = SPINOR_OP_PP_4B;
+		} else {
+			nor->read_opcode = SPINOR_OP_READ_1_2_2;
+			nor->program_opcode = SPINOR_OP_PP;
+		}
+		break;
+
+	case SPI_NOR_FAST:
+		if (addr_4byte) {
+			nor->read_opcode = SPINOR_OP_READ4_FAST;
+			nor->program_opcode = SPINOR_OP_PP_4B;
+		} else {
+			nor->read_opcode = SPINOR_OP_READ_FAST;
+			nor->program_opcode = SPINOR_OP_PP;
+		}
+		break;
+
+	case SPI_NOR_NORMAL:
+	default:
+		if (addr_4byte) {
+			nor->read_opcode = SPINOR_OP_READ4;
+			nor->program_opcode = SPINOR_OP_PP_4B;
+		} else {
+			nor->read_opcode = SPINOR_OP_READ;
+			nor->program_opcode = SPINOR_OP_PP;
+		}
+		break;
+	}
+
+	if (addr_4byte) {
+		nor->erase_opcode = SPINOR_OP_SE_4B;
+		mtd->erasesize = info->sector_size;
+	}
+}
+
+static void tune_manufacturer_commands(struct spi_nor *nor,
+				       const struct flash_info *info)
+{
+	switch (JEDEC_MFR(info)) {
+	case CFI_MFR_MACRONIX:
+		macronix_set_commands(nor);
+		break;
+
+	case CFI_MFR_ST:
+		micron_set_commands(nor);
+		break;
+
+	case CFI_MFR_AMD:
+		spansion_set_commands(nor, info);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static int spi_nor_check(struct spi_nor *nor)
 {
 	if (!nor->dev || !nor->read || !nor->write ||
@@ -1253,32 +1379,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	else if (mtd->size > 0x1000000) {
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
-		if (JEDEC_MFR(info) == CFI_MFR_AMD) {
-			/* Dedicated 4-byte command set */
-			switch (nor->flash_read) {
-			case SPI_NOR_QUAD:
-				nor->read_opcode = SPINOR_OP_READ4_1_1_4;
-				break;
-			case SPI_NOR_DUAL:
-				nor->read_opcode = SPINOR_OP_READ4_1_1_2;
-				break;
-			case SPI_NOR_FAST:
-				nor->read_opcode = SPINOR_OP_READ4_FAST;
-				break;
-			case SPI_NOR_NORMAL:
-				nor->read_opcode = SPINOR_OP_READ4;
-				break;
-			}
-			nor->program_opcode = SPINOR_OP_PP_4B;
-			/* No small sector erase for 4-byte command set */
-			nor->erase_opcode = SPINOR_OP_SE_4B;
-			mtd->erasesize = info->sector_size;
-		} else
-			set_4byte(nor, info, 1);
+		set_4byte(nor, info, 1);
 	} else {
 		nor->addr_width = 3;
 	}
 
+	/* Tune read, page program and erase commands */
+	tune_manufacturer_commands(nor, info);
+
 	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
 
 	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index ce81b0e2cb37..f13cd2cb3ac5 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -25,8 +25,11 @@
 #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
 #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
 #define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual SPI) */
+#define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual SPI) */
 #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
+#define SPINOR_OP_PP_1_1_4	0x32	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
 #define SPINOR_OP_BE_32K	0x52	/* Erase 32KiB block */
@@ -40,8 +43,11 @@
 #define SPINOR_OP_READ4		0x13	/* Read data bytes (low frequency) */
 #define SPINOR_OP_READ4_FAST	0x0c	/* Read data bytes (high frequency) */
 #define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual SPI) */
+#define SPINOR_OP_READ4_1_2_2	0xbc	/* Read data bytes (Dual SPI) */
 #define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ4_1_4_4	0xec	/* Read data bytes (Quad SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
+#define SPINOR_OP_PP_4B_1_1_4	0x34	/* Page Program (up to 512 bytes) */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
 
 /* Used for SST flashes only. */
-- 
1.8.2.2
