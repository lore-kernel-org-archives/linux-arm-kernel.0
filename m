From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Feb 2016 14:26:55 +0100
Subject: [PATCH v3 10/14] mtd: spi-nor: configure the number of dummy clock
 cycles on Macronix memories
In-Reply-To: <cover.1454505161.git.cyrille.pitchen@atmel.com>
References: <cover.1454505161.git.cyrille.pitchen@atmel.com>
Message-ID: <fe3d12a04383048a54dd2ffe927f854142fa8db7.1454505161.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi-nor framework currently expects all Fast Read operations to use 8
dummy clock cycles. Especially some drivers like m25p80 can only support
multiple of 8 dummy clock cycles.

On Macronix memories, the number of dummy clock cycles to be used by Fast
Read commands can be safely set to 8 by updating the DC0 and DC1 volatile
bits inside the Configuration Register.

According to the mx66l1g45g datasheet from Macronix, using 8 dummy clock
cycles should be enough to set the SPI bus clock frequency up to:
- 133 MHz for Fast Read 1-1-1, 1-1-2, 1-1-4 and 1-2-2 commands in Single
  Transfer Rate (STR)
- 104 MHz for Fast Read 1-4-4 (or 4-4-4 in QPI mode) commands (STR)

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 155 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |   3 +
 2 files changed, 150 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2b1a26588ae6..c560fbbb8479 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1163,6 +1163,136 @@ static int winbond_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
+static int macronix_dummy2code(u8 read_opcode, u8 read_dummy, u8 *dc)
+{
+	switch (read_opcode) {
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ4:
+		*dc = 0;
+		break;
+
+	case SPINOR_OP_READ_FAST:
+	case SPINOR_OP_READ_1_1_2:
+	case SPINOR_OP_READ_1_1_4:
+	case SPINOR_OP_READ4_FAST:
+	case SPINOR_OP_READ4_1_1_2:
+	case SPINOR_OP_READ4_1_1_4:
+		switch (read_dummy) {
+		case 6:
+			*dc = 1;
+			break;
+		case 8:
+			*dc = 0;
+			break;
+		case 10:
+			*dc = 3;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case SPINOR_OP_READ_1_2_2:
+	case SPINOR_OP_READ4_1_2_2:
+		switch (read_dummy) {
+		case 4:
+			*dc = 0;
+			break;
+		case 6:
+			*dc = 1;
+			break;
+		case 8:
+			*dc = 2;
+			break;
+		case 10:
+			*dc = 3;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case SPINOR_OP_READ_1_4_4:
+	case SPINOR_OP_READ4_1_4_4:
+		switch (read_dummy) {
+		case 4:
+			*dc = 1;
+			break;
+		case 6:
+			*dc = 0;
+			break;
+		case 8:
+			*dc = 2;
+			break;
+		case 10:
+			*dc = 3;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int macronix_set_dummy_cycles(struct spi_nor *nor, u8 read_dummy)
+{
+	int ret, sr, mask, val;
+	u16 sr_cr;
+	u8 dc, cr;
+
+	/* Convert the number of dummy cycles into Macronix DC volatile bits */
+	ret = macronix_dummy2code(nor->read_opcode, read_dummy, &dc);
+	if (ret)
+		return ret;
+
+	mask = GENMASK(7, 6);
+	val = (dc << 6) & mask;
+
+	ret = nor->read_reg(nor, SPINOR_OP_RDCR_MX, &cr, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error while reading the config register\n");
+		return ret;
+	}
+
+	if ((cr & mask) == val) {
+		nor->read_dummy = read_dummy;
+		return 0;
+	}
+
+	sr = read_sr(nor);
+	if (sr < 0) {
+		dev_err(nor->dev, "error while reading the status register\n");
+		return sr;
+	}
+
+	cr = (cr & ~mask) | val;
+	sr_cr = (sr & 0xff) | ((cr & 0xff) << 8);
+	write_enable(nor);
+	ret = write_sr_cr(nor, sr_cr);
+	if (ret) {
+		dev_err(nor->dev,
+			"error while writing the SR and CR registers\n");
+		return ret;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->read_reg(nor, SPINOR_OP_RDCR_MX, &cr, 1);
+	if (ret < 0 || (cr & mask) != val) {
+		dev_err(nor->dev, "Macronix Dummy Cycle bits not updated\n");
+		return -EINVAL;
+	}
+
+	/* Save the number of dummy cycles to use with Fast Read commands */
+	nor->read_dummy = read_dummy;
+	return 0;
+}
+
 static int macronix_set_quad_mode(struct spi_nor *nor)
 {
 	int status;
@@ -1180,8 +1310,7 @@ static int macronix_set_quad_mode(struct spi_nor *nor)
 		 * read (performance enhance) mode by mistake!
 		 */
 		nor->read_opcode = SPINOR_OP_READ_1_4_4;
-		nor->read_dummy = 8;
-		return 0;
+		return macronix_set_dummy_cycles(nor, 8);
 	}
 
 	/*
@@ -1194,6 +1323,9 @@ static int macronix_set_quad_mode(struct spi_nor *nor)
 	 * entering the continuous read mode by mistake if some
 	 * performance enhance toggling bits P0-P7 were written during
 	 * dummy/mode cycles.
+	 *
+	 * Use the Fast Read Quad Output 1-1-4 (0x6b) command with 8 dummy
+	 * cycles (up to 133MHz for STR and 66MHz for DTR).
 	 */
 	status = macronix_quad_enable(nor);
 	if (status) {
@@ -1202,8 +1334,7 @@ static int macronix_set_quad_mode(struct spi_nor *nor)
 	}
 	nor->read_proto = SNOR_PROTO_1_1_4;
 	nor->read_opcode = SPINOR_OP_READ_1_1_4;
-	nor->read_dummy = 8;
-	return 0;
+	return macronix_set_dummy_cycles(nor, 8);
 }
 
 /*
@@ -1214,16 +1345,25 @@ static int macronix_set_quad_mode(struct spi_nor *nor)
 
 static int macronix_set_dual_mode(struct spi_nor *nor)
 {
+	/*
+	 * Use the Fast Read Dual Output 1-1-2 (0x3b) command with 8 dummy
+	 * cycles (up to 133MHz for STR and 66MHz for DTR).
+	 */
 	nor->read_proto = SNOR_PROTO_1_1_2;
 	nor->read_opcode = SPINOR_OP_READ_1_1_2;
-	nor->read_dummy = 8;
-	return 0;
+	return macronix_set_dummy_cycles(nor, 8);
 }
 
 static int macronix_set_single_mode(struct spi_nor *nor)
 {
 	u8 read_dummy;
 
+	/*
+	 * Configure 8 dummy cycles for Fast Read 1-1-1 (0x0b) command (up to
+	 * 133MHz for STR and 66MHz for DTR). The Read 1-1-1 (0x03) command
+	 * expects no dummy cycle.
+	 * read_opcode should not be overridden here!
+	 */
 	switch (nor->read_opcode) {
 	case SPINOR_OP_READ:
 	case SPINOR_OP_READ4:
@@ -1236,8 +1376,7 @@ static int macronix_set_single_mode(struct spi_nor *nor)
 	}
 
 	nor->read_proto = SNOR_PROTO_1_1_1;
-	nor->read_dummy = read_dummy;
-	return 0;
+	return macronix_set_dummy_cycles(nor, read_dummy);
 }
 
 static int winbond_set_quad_mode(struct spi_nor *nor)
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 2dc0f8b429ca..8e0f43cecaca 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -75,6 +75,9 @@
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
 
+/* Used for Macronix flashes only. */
+#define SPINOR_OP_RDCR_MX	0x15	/* Read configuration register */
+
 /* Used for Winbond flashes only. */
 #define SPINOR_OP_RDSR2_WINB	0x35	/* Read status register 2 */
 #define SPINOR_OP_WRSR2_WINB	0x31	/* Write status register 2 */
-- 
1.8.2.2
