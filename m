From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Feb 2016 14:26:53 +0100
Subject: [PATCH v3 08/14] mtd: spi-nor: configure the number of dummy clock
 cycles by manufacturer
In-Reply-To: <cover.1454505161.git.cyrille.pitchen@atmel.com>
References: <cover.1454505161.git.cyrille.pitchen@atmel.com>
Message-ID: <e5b618cdf62b1b33cbc07a40740a97034caf43a9.1454505161.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a transitional patch which let us set the number of dummy clock
cycles by manufacturer.

More patches will follow by manufacturer to actually configure the
relevant number of dummy clock cycles following the dedicated procedure.

For instance, some manufacturers like Spansion configure the number of
dummy clock cycles to be used by Fast Read command through some
non-volatile register. In such a case, we should avoid updating its value
but instead read it then set the nor->read_dummy accordingly.

On the other hand, some manufacturers like Micron use some volatile
register. In this case, we'd rather update this register to use a number
of dummy clock cycles, which is a multiple of 8.
Indeed some drivers, like m25p80, only support writing bytes, hence
multiples of 8 bits.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 99 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f9dd1fd3f53c..ef520048edae 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -140,24 +140,6 @@ static int read_cr(struct spi_nor *nor)
 }
 
 /*
- * Dummy Cycle calculation for different type of read.
- * It can be used to support more commands with
- * different dummy cycle requirements.
- */
-static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
-{
-	switch (nor->flash_read) {
-	case SPI_NOR_FAST:
-	case SPI_NOR_DUAL:
-	case SPI_NOR_QUAD:
-		return 8;
-	case SPI_NOR_NORMAL:
-		return 0;
-	}
-	return 0;
-}
-
-/*
  * Write status register 1 byte
  * Returns negative if error occurred.
  */
@@ -1198,6 +1180,7 @@ static int macronix_set_quad_mode(struct spi_nor *nor)
 		 * read (performance enhance) mode by mistake!
 		 */
 		nor->read_opcode = SPINOR_OP_READ_1_4_4;
+		nor->read_dummy = 8;
 		return 0;
 	}
 
@@ -1219,6 +1202,7 @@ static int macronix_set_quad_mode(struct spi_nor *nor)
 	}
 	nor->read_proto = SNOR_PROTO_1_1_4;
 	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	nor->read_dummy = 8;
 	return 0;
 }
 
@@ -1232,12 +1216,27 @@ static int macronix_set_dual_mode(struct spi_nor *nor)
 {
 	nor->read_proto = SNOR_PROTO_1_1_2;
 	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	nor->read_dummy = 8;
 	return 0;
 }
 
 static int macronix_set_single_mode(struct spi_nor *nor)
 {
+	u8 read_dummy;
+
+	switch (nor->read_opcode) {
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ4:
+		read_dummy = 0;
+		break;
+
+	default:
+		read_dummy = 8;
+		break;
+	}
+
 	nor->read_proto = SNOR_PROTO_1_1_1;
+	nor->read_dummy = read_dummy;
 	return 0;
 }
 
@@ -1258,6 +1257,7 @@ static int winbond_set_quad_mode(struct spi_nor *nor)
 		 * Hence the Fast Read 1-1-1 (0x0b) op code is chosen.
 		 */
 		nor->read_opcode = SPINOR_OP_READ_FAST;
+		nor->read_dummy = 8;
 		return 0;
 	}
 
@@ -1276,6 +1276,7 @@ static int winbond_set_quad_mode(struct spi_nor *nor)
 	}
 	nor->read_proto = SNOR_PROTO_1_1_4;
 	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	nor->read_dummy = 8;
 	return 0;
 }
 
@@ -1289,12 +1290,27 @@ static int winbond_set_dual_mode(struct spi_nor *nor)
 {
 	nor->read_proto = SNOR_PROTO_1_1_2;
 	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	nor->read_dummy = 8;
 	return 0;
 }
 
 static int winbond_set_single_mode(struct spi_nor *nor)
 {
+	u8 read_dummy;
+
+	switch (nor->read_opcode) {
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ4:
+		read_dummy = 0;
+		break;
+
+	default:
+		read_dummy = 8;
+		break;
+	}
+
 	nor->read_proto = SNOR_PROTO_1_1_1;
+	nor->read_dummy = read_dummy;
 	return 0;
 }
 
@@ -1386,6 +1402,7 @@ static int micron_set_quad_mode(struct spi_nor *nor)
 	if (nor->read_proto != SNOR_PROTO_4_4_4)
 		nor->read_proto = SNOR_PROTO_1_1_4;
 	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	nor->read_dummy = 8;
 	return 0;
 }
 
@@ -1415,11 +1432,14 @@ static int micron_set_dual_mode(struct spi_nor *nor)
 	if (nor->read_proto != SNOR_PROTO_2_2_2)
 		nor->read_proto = SNOR_PROTO_1_1_2;
 	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	nor->read_dummy = 8;
 	return 0;
 }
 
 static int micron_set_single_mode(struct spi_nor *nor)
 {
+	u8 read_dummy;
+
 	/* Check whether either the Dual or Quad mode is enabled. */
 	if (unlikely(nor->read_proto != SNOR_PROTO_1_1_1)) {
 		int ret;
@@ -1436,6 +1456,18 @@ static int micron_set_single_mode(struct spi_nor *nor)
 		nor->read_proto = SNOR_PROTO_1_1_1;
 	}
 
+	/* Force the number of dummy cycles to 8 for Fast Read, 0 for Read. */
+	switch (nor->read_opcode) {
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ4:
+		read_dummy = 0;
+		break;
+
+	default:
+		read_dummy = 8;
+		break;
+	}
+	nor->read_dummy = read_dummy;
 	return 0;
 }
 
@@ -1450,6 +1482,7 @@ static int spansion_set_quad_mode(struct spi_nor *nor)
 	}
 	nor->read_proto = SNOR_PROTO_1_1_4;
 	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	nor->read_dummy = 8;
 	return 0;
 }
 
@@ -1457,12 +1490,27 @@ static int spansion_set_dual_mode(struct spi_nor *nor)
 {
 	nor->read_proto = SNOR_PROTO_1_1_2;
 	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	nor->read_dummy = 8;
 	return 0;
 }
 
 static int spansion_set_single_mode(struct spi_nor *nor)
 {
+	u8 read_dummy;
+
+	switch (nor->read_opcode) {
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ4:
+		read_dummy = 0;
+		break;
+
+	default:
+		read_dummy = 8;
+		break;
+	}
+
 	nor->read_proto = SNOR_PROTO_1_1_1;
+	nor->read_dummy = read_dummy;
 	return 0;
 }
 
@@ -1677,11 +1725,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (info->flags & SPI_NOR_NO_FR)
 		nor->flash_read = SPI_NOR_NORMAL;
 
-	/* Default commands */
-	if (nor->flash_read == SPI_NOR_NORMAL)
+	/* Default commands and number of dummy cycles */
+	if (nor->flash_read == SPI_NOR_NORMAL) {
 		nor->read_opcode = SPINOR_OP_READ;
-	else
+		nor->read_dummy = 0;
+	} else {
 		nor->read_opcode = SPINOR_OP_READ_FAST;
+		nor->read_dummy = 8;
+	}
 
 	nor->program_opcode = SPINOR_OP_PP;
 
@@ -1696,8 +1747,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	 *  - SNOR_PROTO_2_2_2 is either:
 	 *    + Micron Dual mode enabled
 	 *
-	 * The opcodes and the protocols are updated depending on the
-	 * manufacturer.
+	 * The opcodes, the protocols and the number of dummy cycles are updated
+	 * depending on the manufacturer.
 	 * The read opcode and protocol should be updated by the relevant
 	 * function when entering Quad or Dual mode.
 	 */
@@ -1761,8 +1812,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		return -EINVAL;
 	}
 
-	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
-
 	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
 			(long long)mtd->size >> 10);
 
-- 
1.8.2.2
