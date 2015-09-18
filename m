From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 18 Sep 2015 17:49:27 +0200
Subject: [PATCH linux-next 3/4] mtd: spi-nor: fix Quad SPI mode support for
 Spansion, Micron and Macronix
In-Reply-To: <cover.1442590224.git.cyrille.pitchen@atmel.com>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
Message-ID: <5b2be2ffd893b3ea7c2b3d9743d35fa557b8d9f7.1442590224.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reworks the support of Quad and Dual SPI protocols for Micron,
Spansion and Macronix Quad/Dual capable memories. Indeed, in the best
case, only Spansion memories are correctly supported by the current
spi-nor framework.

1 - Micron:
When their Quad SPI mode is enabled, Micron spi-nor memories expect all
commands to use the SPI 4-4-4 protocol. Also when the Dual SPI mode is
enabled, all commands must use the SPI 2-2-2 protocol.

Before this patch, the spi-nor framework used to always enable the Quad
mode when the mode argument of spi_nor_scan() took the value SPI_NOR_QUAD.
That was not suited with drivers only supporting SPI 1-x-4 protocols but
not the 4-4-4 (e.g. the m25p80 driver). Also the SPI controller was not
notified about which SPI protocol to use to transfert command. We cannot
rely only on the op code: in Extended SPI mode the 0x6b command must  use
the SPI 1-1-4 protocol whereas in Quad SPi mode the SPI 4-4-4 protocol
must be use instead.

After this patch, the spi-nor framework uses the result of the
spi_nor_read_id() function to choose the right SPI protocol to be used.
If the reg_proto was set to SPI_PROTO_4_4_4, we already know that the Quad
SPI mode is already enabled and that the SPI controller supports the SPI
4-4-4 protocol (otherwise it would have fail to read the JEDEC ID with the
0xaf op code). For the very same reason, if the reg_proto was set to
SPI_PROTO_2_2_2, we already know that the Dual mode is already enabled and
that the SPI controller supports the SPI 2-2-2 protocol.
Otherwise we switch back to the Extended SPI protocol, which supports at
least the Fast Read commands:
- 1-1-1 (0x0b)
- Dual Output 1-1-2 (0x3b)
- Quad Output 1-1-4 (0x6b)

We also safely set the number of dummy cycles to 8 for Fast Read commands
through the Volatile Configuration Register (VCR): some drivers (m25p80)
or SPI controllers only support a number of dummy cycles multiple of 8.
This number may have previouly been set to an unsupported value by an
early bootloader or at reset thanks to the Non-Volatile Configuration
Register.

Finally the XIP bit is always set in the VCR to disable the Continuous
Read mode as we don't want to care about mode cycles.

2 - Macronix:
When the QPI mode is enabled, all commands must use the SPI 4-4-4 protocol
and only the 0xeb op code is supported for Fast Read commands.
Before this patch, the spi-nor framework used to force the QPI mode but
used the 0x6b op code for Fast Read commands when the SPI controller
claims to support Quad SPI mode.
This patch uses the result of spi_nor_read_id() to guess whether the QPI
mode is both enable and supported by the SPI controller (otherwise it
would have failed to read the JEDEC ID with the 0xaf op code).
When the QPI mode is disabled, Macronix memories still support the
following Fast Read commands:
- 1-1-1 (0x0b)
- Dual Output 1-1-2 (0x3b)
- Quad Output 1-1-4 (0x6b)
So if the QPI mode has not already been enabled, there is not need to
enable it. We also avoid the 0xbb (Dual I/O 1-2-2) and 0xeb (Quad I/O
1-4-4) op codes on purpose as we don't want to care about the value to set
in mode cycles not to enter the Continuous Read (Performance Enhance)
mode.

As for Micron memories, the spi-nor framework now safely sets the number
of dummy cycles to 8 thanks to 2 volatile bits inside the Configuration
Register.

3 - Spansion:
As for Macronix, we avoid the 0xbb (Dual I/O 1-2-2) and 0xeb (Quad I/O
1-4-4) op codes on purpose as we don't want to care about the value to set
in mode cycles not to enter in the Continuous Read mode.

Besides, we only care about the Quad Enable bit inside the Configuration
Register (CR) when using Quad operations. In such a case, we first check
its state before trying to set it. Now we also notify the user about the
update of this non-volatile bit.

We also check the Latency Code (LC) in CR to know the exact number of
dummy cycles to use when performing a Fast Read operation. Currently only
the 0x0b, 0x3b and 0x6b op codes are used to perform Fast Read operation
so the number of dummy cycles is always either 0 or 8. Hence no regression
should be introduced.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 759 ++++++++++++++++++++++++++++++++++++------
 include/linux/mtd/spi-nor.h   |  15 +-
 2 files changed, 675 insertions(+), 99 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b857e9be2026..4fce01ea16c5 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -126,24 +126,6 @@ static int read_cr(struct spi_nor *nor)
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
@@ -899,39 +881,225 @@ write_err:
 	return ret;
 }
 
-static int macronix_quad_enable(struct spi_nor *nor)
+/*
+ * Write status Register and configuration register with 2 bytes
+ * The first byte will be written to the status register, while the
+ * second byte will be written to the configuration register.
+ * Return negative if error occured.
+ */
+static int write_sr_cr(struct spi_nor *nor, u16 val)
 {
-	int ret, val;
+	nor->cmd_buf[0] = val & 0xff;
+	nor->cmd_buf[1] = (val >> 8);
 
-	val = read_sr(nor);
-	write_enable(nor);
+	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 2);
+}
 
-	write_sr(nor, val | SR_QUAD_EN_MX);
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
 
-	if (spi_nor_wait_till_ready(nor))
-		return 1;
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
 
-	ret = read_sr(nor);
-	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
-		dev_err(nor->dev, "Macronix Quad bit not set\n");
+	default:
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-/*
- * Write status Register and configuration register with 2 bytes
- * The first byte will be written to the status register, while the
- * second byte will be written to the configuration register.
- * Return negative if error occured.
- */
-static int write_sr_cr(struct spi_nor *nor, u16 val)
+static int macronix_set_dummy_cycles(struct spi_nor *nor, u8 read_dummy)
 {
-	nor->cmd_buf[0] = val & 0xff;
-	nor->cmd_buf[1] = (val >> 8);
+	int ret, sr, cr, mask, val;
+	u16 sr_cr;
+	u8 dc;
 
-	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 2);
+	/* Convert the number of dummy cycles into Macronix DC volatile bits */
+	ret = macronix_dummy2code(nor->read_opcode, read_dummy, &dc);
+	if (ret)
+		return ret;
+
+	mask = GENMASK(7, 6);
+	val = (dc << 6) & mask;
+
+	cr = read_cr(nor);
+	if (cr < 0) {
+		dev_err(nor->dev, "error while reading the config register\n");
+		return cr;
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
+			"error while writting the SR and CR registers\n");
+		return ret;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	cr = read_cr(nor);
+	if (cr < 0 || (cr & mask) != val) {
+		dev_err(nor->dev, "Macronix Dummy Cycle bits not updated\n");
+		return -EINVAL;
+	}
+
+	/* Save the number of dummy cycles to use with Fast Read commands */
+	nor->read_dummy = read_dummy;
+	return 0;
+}
+
+static int macronix_set_quad_mode(struct spi_nor *nor)
+{
+	/* Check whether the QPI mode is enabled. */
+	if (nor->reg_proto == SPI_PROTO_4_4_4) {
+		/* 
+		 * In QPI mode, only the Fast Read Quad I/O (0xeb) command is
+		 * supported by the memory. Also the memory expects ALL commands
+		 * to use the SPI 4-4-4 protocol.
+		 * We already know that the SPI controller supports this
+		 * protocol as we succeeded in reading the JEDEC ID with the
+		 * 0xaf command and SPI-4-4-4 protocol.
+		 * However, using the 0xeb command we must take care about the
+		 * values sent during the dummy cycles as we don't want the
+		 * memory to enter its Continuous Read (Performance Enhance)
+		 * mode.
+		 */
+		nor->erase_proto = SPI_PROTO_4_4_4;
+		nor->write_proto = SPI_PROTO_4_4_4;
+		nor->read_proto = SPI_PROTO_4_4_4;
+		nor->read_opcode = SPINOR_OP_READ_1_4_4;
+		return macronix_set_dummy_cycles(nor, 8);
+	}
+
+	/*
+	 * Use the Fast Read Quad Output 1-1-4 (0x6b) command with 8 dummy
+	 * cycles (up to 133MHz for STR and 66MHz for DTR).
+	 */
+	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	return macronix_set_dummy_cycles(nor, 8);
+}
+
+static int macronix_set_dual_mode(struct spi_nor *nor)
+{
+	/*
+	 * Use the Fast Read Dual Output 1-1-2 (0x3b) command with 8 dummy
+	 * cycles (up to 133MHz for STR and 66MHz for DTR).
+	 */
+	nor->read_proto = SPI_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	return macronix_set_dummy_cycles(nor, 8);
+}
+
+static int macronix_set_single_mode(struct spi_nor *nor)
+{
+	/*
+	 * Configure 8 dummy cycles for Fast Read 1-1-1 (0x0b) command (up to
+	 * 133MHz for STR and 66MHz for DTR). The Read 1-1-1 (0x03) command
+	 * doesn't care about this setting.
+	 * read_opcode should not be overridden here!
+	 */
+	nor->read_proto = SPI_PROTO_1_1_1;
+	return macronix_set_dummy_cycles(nor, 8);
+}
+
+static inline int spansion_get_config(struct spi_nor *nor,
+				      bool *quad_enabled,
+				      u8 *latency_code)
+{
+	int cr;
+
+	cr = read_cr(nor);
+	if (cr < 0) {
+		dev_err(nor->dev,
+			"error while reading the configuration register\n");
+		return cr;
+	}
+
+	if (quad_enabled)
+		*quad_enabled = !!(cr & CR_QUAD_EN_SPAN);
+
+	if (latency_code)
+		*latency_code = (u8)((cr & GENMASK(7, 6)) >> 6);
+
+	return 0;
 }
 
 static int spansion_quad_enable(struct spi_nor *nor)
@@ -958,24 +1126,170 @@ static int spansion_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static int micron_quad_enable(struct spi_nor *nor)
+static int spansion_set_dummy_cycles(struct spi_nor *nor, u8 latency_code)
 {
+	/* SDR dummy cycles */
+	switch (nor->read_opcode) {
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ4:
+		nor->read_dummy = 0;
+		break;
+
+	case SPINOR_OP_READ_FAST:
+	case SPINOR_OP_READ_1_1_2:
+	case SPINOR_OP_READ_1_1_4:
+	case SPINOR_OP_READ4_FAST:
+	case SPINOR_OP_READ4_1_1_2:
+	case SPINOR_OP_READ4_1_1_4:
+		nor->read_dummy = (latency_code == 3) ? 0 : 8;
+		break;
+
+	case SPINOR_OP_READ_1_2_2:
+	case SPINOR_OP_READ4_1_2_2:
+		switch (latency_code) {
+		default:
+		case 0:
+		case 3:
+			nor->read_dummy = 4;
+			break;
+		case 1:
+			nor->read_dummy = 5;
+			break;
+		case 2:
+			nor->read_dummy = 6;
+			break;
+		}
+		break;
+
+
+	case SPINOR_OP_READ_1_4_4:
+	case SPINOR_OP_READ4_1_4_4:
+		switch (latency_code) {
+		default:
+		case 0:
+		case 1:
+			nor->read_dummy = 4;
+			break;
+		case 2:
+			nor->read_dummy = 5;
+			break;
+		case 3:
+			nor->read_dummy = 1;
+			break;
+		}
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spansion_set_quad_mode(struct spi_nor *nor)
+{
+	bool quad_enabled;
+	u8 latency_code;
 	int ret;
-	u8 val;
 
-	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &val, 1);
+	/*
+	 * The QUAD bit of Configuration Register must be set (CR Bit1=1) for
+	 * using any Quad SPI command.
+	 */
+	ret = spansion_get_config(nor, &quad_enabled, &latency_code);
+	if (ret)
+		return ret;
+
+	/* The Quad mode should be enabled ... */
+	if (!quad_enabled) {
+		/* ... if not try to enable it. */
+		dev_warn(nor->dev, "Spansion Quad mode disabled, enable it\n");
+		ret = spansion_quad_enable(nor);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Don't use the Fast Read Quad I/O (0xeb / 0xec) commands as their
+	 * number of dummy cycles can not be set to a multiple of 8: some SPI
+	 * controllers, especially those relying on the m25p80 driver, expect
+	 * the number of dummy cycles to be a multiple of 8.
+	 * Also when using a Fast Read Quad I/O command, the memory checks the 
+	 * value of the first mode/dummy cycles to decice whether it enters or
+	 * leaves the Countinuous Read mode. We should never enter the
+	 * Countinuous Read mode as the spi-nor framework doesn't support it.
+	 * For all these reason, we'd rather use the Fast Read Quad Output
+	 * 1-1-4 (0x6b / 0x6c) commands instead.
+	 */
+	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	return spansion_set_dummy_cycles(nor, latency_code);
+}
+
+static int spansion_set_dual_output(struct spi_nor *nor)
+{
+	u8 latency_code;
+	int ret;
+
+	/* We don't care about the quad mode status */
+	ret = spansion_get_config(nor, NULL, &latency_code);
+	if (ret)
+		return ret;
+
+	/*
+	 * Don't use the Fast Read Dual I/O (0xbb / 0xbc) commands as their
+	 * number of dummy cycles can not bet set to a multiple of 8: some SPI
+	 * controllers, especially those relying on the m25p80 driver, expect
+	 * the number of dummy cycles to be a multiple of 8.
+	 * For this reason, w'd rather use the Fast Read Dual Output 1-1-2
+	 * (0x3b / 0x3c) commands instead.
+	 */
+	nor->read_proto = SPI_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	return spansion_set_dummy_cycles(nor, latency_code);
+}
+
+static int spansion_set_single(struct spi_nor *nor)
+{
+	u8 latency_code;
+	int ret;
+
+	/* We don't care about the quad mode status */
+	ret = spansion_get_config(nor, NULL, &latency_code);
+	if (ret)
+		return ret;
+
+	nor->read_proto = SPI_PROTO_1_1_1;
+	return spansion_set_dummy_cycles(nor, latency_code);
+}
+
+static int micron_set_dummy_cycles(struct spi_nor *nor, u8 read_dummy)
+{
+	u8 vcr, val, mask;
+	int ret;
+
+	/* Set bit3 (XIP) to disable the Continuous Read mode */
+	mask = GENMASK(7, 4) | BIT(3);
+	val = ((read_dummy << 4) | BIT(3)) & mask;
+
+	/* Read the Volatile Configuration Register (VCR). */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_VCR, &vcr, 1);
 	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading EVCR\n", ret);
+		dev_err(nor->dev, "error while reading VCR register\n");
 		return ret;
 	}
 
-	write_enable(nor);
+	/* Check whether we need to update the number of dummy cycles. */
+	if ((vcr & mask) == val) {
+		nor->read_dummy = read_dummy;
+		return 0;
+	}
 
-	/* set EVCR, enable quad I/O */
-	nor->cmd_buf[0] = val & ~EVCR_QUAD_EN_MICRON;
-	ret = nor->write_reg(nor, SPINOR_OP_WD_EVCR, nor->cmd_buf, 1);
+	/* Update the number of dummy into the VCR. */
+	write_enable(nor);
+	vcr = (vcr & ~mask) | val;
+	ret = nor->write_reg(nor, SPINOR_OP_WR_VCR, &vcr, 1);
 	if (ret < 0) {
-		dev_err(nor->dev, "error while writing EVCR register\n");
+		dev_err(nor->dev, "error while writing VCR register\n");
 		return ret;
 	}
 
@@ -983,47 +1297,298 @@ static int micron_quad_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	/* read EVCR and check it */
-	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &val, 1);
+	/* Read VCR and check it. */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_VCR, &vcr, 1);
+	if (ret < 0 || (vcr & mask) != val) {
+		dev_err(nor->dev, "Micron VCR dummy cycles not updated\n");
+		return -EINVAL;
+	}
+
+	/* Save the number of dummy cycles to use with Fast Read commands */
+	nor->read_dummy = read_dummy;
+	return 0;
+}
+
+static int micron_set_protocol(struct spi_nor *nor, u8 mask, u8 val,
+			       enum spi_protocol proto)
+{
+	u8 evcr;
+	int ret;
+
+	/* Read the Exhanced Volatile Configuration Register (EVCR). */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &evcr, 1);
 	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading EVCR\n", ret);
+		dev_err(nor->dev, "error while reading EVCR register\n");
 		return ret;
 	}
-	if (val & EVCR_QUAD_EN_MICRON) {
-		dev_err(nor->dev, "Micron EVCR Quad bit not clear\n");
+
+	/* Check whether we need to update the protocol bits. */
+	if ((evcr & mask) == val)
+		return 0;
+
+	/* Set EVCR protocol bits. */
+	write_enable(nor);
+	evcr = (evcr & ~mask) | val;
+	ret = nor->write_reg(nor, SPINOR_OP_WD_EVCR, &evcr, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error while writing EVCR register\n");
+		return ret;
+	}
+
+	/* Switch reg protocol now before accessing any other registers. */
+	nor->reg_proto = proto;
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	/* Read EVCR and check it. */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &evcr, 1);
+	if (ret < 0 || (evcr & mask) != val) {
+		dev_err(nor->dev, "Micron EVCR protocol bits not updated\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
+static int micron_set_quad_protocol(struct spi_nor *nor)
+{
+	int ret;
+
+	/* Set Quad bit to 0 to select the Quad SPI mode. */
+	ret = micron_set_protocol(nor,
+				  EVCR_QUAD_EN_MICRON,
+				  0,
+				  SPI_PROTO_4_4_4);
+	if (ret) {
+		dev_err(nor->dev, "Failed to set Micron Quad SPI mode\n");
+		return ret;
+	}
+
+	nor->read_proto = SPI_PROTO_4_4_4;
+	nor->write_proto = SPI_PROTO_4_4_4;
+	nor->erase_proto = SPI_PROTO_4_4_4;
+	return 0;
+}
+
+static int micron_set_dual_protocol(struct spi_nor *nor)
+{
+	int ret;
+
+	/* Set Quad/Dual bits to 10 to select the Dual SPI mode. */
+	ret = micron_set_protocol(nor,
+				  EVCR_QUAD_EN_MICRON | EVCR_DUAL_EN_MICRON,
+				  EVCR_QUAD_EN_MICRON,
+				  SPI_PROTO_2_2_2);
+	if (ret) {
+		dev_err(nor->dev, "Failed to set Micron Dual SPI mode\n");
+		return ret;
+	}
+
+	nor->read_proto = SPI_PROTO_2_2_2;
+	nor->write_proto = SPI_PROTO_2_2_2;
+	nor->erase_proto = SPI_PROTO_2_2_2;
+	return 0;
+}
+
+static int micron_set_extended_spi_protocol(struct spi_nor *nor)
+{
+	int ret;
+
+	/* Set Quad/Dual bits to 11 to select the Extended SPI mode */
+	ret = micron_set_protocol(nor,
+				  EVCR_QUAD_EN_MICRON | EVCR_DUAL_EN_MICRON,
+				  EVCR_QUAD_EN_MICRON | EVCR_DUAL_EN_MICRON,
+				  SPI_PROTO_1_1_1);
+	if (ret) {
+		dev_err(nor->dev, "Failed to set Micron Extended SPI mode\n");
+		return ret;
+	}
+
+	nor->write_proto = SPI_PROTO_1_1_1;
+	nor->erase_proto = SPI_PROTO_1_1_1;
+	return 0;
+}
+
+static int micron_set_quad_mode(struct spi_nor *nor)
+{
+	int ret;
+
+	/* Check whether the Quad SPI mode is enabled. */
+	if (nor->reg_proto == SPI_PROTO_4_4_4) {
+		/*
+		 * If here, the Quad mode should have already been enabled and
+		 * is supported by the SPI controller since the memory replied
+		 * to the Read ID Multiple I/O (0xaf) command in SPI 4-4-4
+		 * protocol. So it might be enough to only set the read, write
+		 * and erase protocols to SPI 4-4-4 but just in case...
+		 */
+		ret = micron_set_quad_protocol(nor);
+		if (ret)
+			return ret;
+
+		/*
+		 * In Quad mode, the memory doesn't make any difference between
+		 * the Fast Read Quad Output 1-1-4 (0x6b) and Fast Read Quad I/O
+		 * 1-4-4 (0xeb) commands: they are both processed in SPI 4-4-4
+		 * protocol. The 1-4-4 command is chosen here only for debug
+		 * purpose to easily detect the chosen mode when logging
+		 * commands.
+		 */
+		nor->read_opcode = SPINOR_OP_READ_1_4_4;
+		return micron_set_dummy_cycles(nor, 8);
+	}
+
+	/*
+	 * Exit Dual or Quad mode if not done yet: the Fast Read Quad Output
+	 * 1-1-4 (0x6b) command is also supported by the Extended SPI Protocol.
+	 * We can change the mode safely as we write into a volatile register.
+	 */
+	ret = micron_set_extended_spi_protocol(nor);
+	if (ret)
+		return ret;
+
+	/*
+	 * Use the Fast Read Quad Output 1-1-4 command.
+	 * Force the number of dummy cycles to 8 and disable the Continuous Read
+	 * mode to prevent some drivers from using it by mistake (m25p80).
+	 * We can change these settings safely as we write into a volatile
+	 * register.
+	 */
+	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	return micron_set_dummy_cycles(nor, 8);
+}
+
+static int micron_set_dual_mode(struct spi_nor *nor)
+{
+	int ret;
+
+	/* Check whether the Dual SPI mode is enabled. */
+	if (nor->reg_proto == SPI_PROTO_2_2_2) {
+		/*
+		 * If here, the Dual mode should have already been enabled and
+		 * is supported by the SPI controller since the memory replied
+		 * to the Read ID Multiple I/O (0xaf) command in SPI 2-2-2
+		 * protocol. So it might be enough to only set the read, write
+		 * and erase protocols to SPI 2-2-2 but just in case...
+		 */
+		ret = micron_set_dual_protocol(nor);
+		if (ret)
+			return ret;
+
+		/*
+		 * In Dual mode, the memory doesn't make any difference between
+		 * the Fast Read Dual Output 1-1-2 (0x3b) and Fast Read Dual I/O
+		 * 1-2-2 (0xbb) commands: they are both processed in SPI 2-2-2
+		 * protocol. The 1-2-2 command is chosen here only for debug
+		 * purpose to easily detect the chosen mode when logging
+		 * commands.
+		 */
+		nor->read_opcode = SPINOR_OP_READ_1_2_2;
+		return micron_set_dummy_cycles(nor, 8);
+	}
+
+	/*
+	 * Exit Dual or Quad mode if not done yet: the Fast Read Dual Output
+	 * 1-1-2 (0x3b) command is also supported by the Extended SPI Protocol.
+	 * We can change the mode safely as we write into a volatile register.
+	 */
+	ret = micron_set_extended_spi_protocol(nor);
+	if (ret)
+		return ret;
+
+	/*
+	 * Use the Fast Read Dual Output 1-1-2 command.
+	 * Force the number of dummy cycles to 8 and disable the Continuous Read
+	 * mode to prevent some drivers from using it by mistake (m25p80).
+	 * We can change these settings safely as we write into a volatile
+	 * register.
+	 */
+	nor->read_proto = SPI_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	return micron_set_dummy_cycles(nor, 8);
+}
+
+static int micron_set_single_mode(struct spi_nor *nor)
+{
+	int ret;
+
+	/*
+	 * Exit Dual or Quad mode if not done yet.
+	 * We can change the mode safely as we write into a volatile register.
+	 */
+	ret = micron_set_extended_spi_protocol(nor);
+	if (ret)
+		return ret;
+
+	/*
+	 * Force the number of dummy cycles to 8 (Fast Read only, Read doesn't
+	 * care) and disable the Continuous Read mode to prevent some drivers
+	 * from using it by mistake (m25p80).
+	 * We can change these settings safely as we write into a volatile
+	 * register.
+	 */
+	nor->read_proto = SPI_PROTO_1_1_1;
+	return micron_set_dummy_cycles(nor, 8);
+}
+
 static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
 {
-	int status;
+	switch (JEDEC_MFR(info)) {
+	case CFI_MFR_MACRONIX:
+		return macronix_set_quad_mode(nor);
+
+	case CFI_MFR_ST:
+		return micron_set_quad_mode(nor);
+
+	case CFI_MFR_AMD:
+		return spansion_set_quad_mode(nor);
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
 
+static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
+{
 	switch (JEDEC_MFR(info)) {
 	case CFI_MFR_MACRONIX:
-		status = macronix_quad_enable(nor);
-		if (status) {
-			dev_err(nor->dev, "Macronix quad-read not enabled\n");
-			return -EINVAL;
-		}
-		return status;
+		return macronix_set_dual_mode(nor);
+
 	case CFI_MFR_ST:
-		status = micron_quad_enable(nor);
-		if (status) {
-			dev_err(nor->dev, "Micron quad-read not enabled\n");
-			return -EINVAL;
-		}
-		return status;
+		return micron_set_dual_mode(nor);
+
+	case CFI_MFR_AMD:
+		return spansion_set_dual_output(nor);
+
 	default:
-		status = spansion_quad_enable(nor);
-		if (status) {
-			dev_err(nor->dev, "Spansion quad-read not enabled\n");
-			return -EINVAL;
-		}
-		return status;
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int set_single_mode(struct spi_nor *nor, const struct flash_info *info)
+{
+	switch (JEDEC_MFR(info)) {
+	case CFI_MFR_MACRONIX:
+		return macronix_set_single_mode(nor);
+
+	case CFI_MFR_ST:
+		return micron_set_single_mode(nor);
+
+	case CFI_MFR_AMD:
+		return spansion_set_single(nor);
+
+	default:
+		break;
 	}
+
+	return -EINVAL;
 }
 
 static int spi_nor_check(struct spi_nor *nor)
@@ -1169,7 +1734,22 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (info->flags & SPI_NOR_NO_FR)
 		nor->flash_read = SPI_NOR_NORMAL;
 
-	/* Quad/Dual-read mode takes precedence over fast/normal */
+	/* Default commands and number of dummy cycles */
+	nor->program_opcode = SPINOR_OP_PP;
+	if (nor->flash_read == SPI_NOR_NORMAL) {
+		nor->read_opcode = SPINOR_OP_READ;
+		nor->read_dummy = 0;
+	} else {
+		nor->read_opcode = SPINOR_OP_READ_FAST;
+		nor->read_dummy = 8;
+	}
+
+	/*
+	 * Quad/Dual-read mode takes precedence over fast/normal. The opcodes,
+	 * the protocols and the number of dummy cycles are updated depending
+	 * on the manufacturer. The read opcode and protocol should be updated
+	 * by the relevant function when entering Quad or Dual mode.
+	 */
 	if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
 		ret = set_quad_mode(nor, info);
 		if (ret) {
@@ -1178,30 +1758,21 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		}
 		nor->flash_read = SPI_NOR_QUAD;
 	} else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
+		ret = set_dual_mode(nor, info);
+		if (ret) {
+			dev_err(dev, "dual mode not supported\n");
+			return ret;
+		}
 		nor->flash_read = SPI_NOR_DUAL;
+	} else if (info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) {
+		/* We may need to leave a Quad or Dual mode */
+		ret = set_single_mode(nor, info);
+		if (ret) {
+			dev_err(dev, "failed to switch back to single mode\n");
+			return ret;
+		}
 	}
 
-	/* Default commands */
-	switch (nor->flash_read) {
-	case SPI_NOR_QUAD:
-		nor->read_opcode = SPINOR_OP_READ_1_1_4;
-		break;
-	case SPI_NOR_DUAL:
-		nor->read_opcode = SPINOR_OP_READ_1_1_2;
-		break;
-	case SPI_NOR_FAST:
-		nor->read_opcode = SPINOR_OP_READ_FAST;
-		break;
-	case SPI_NOR_NORMAL:
-		nor->read_opcode = SPINOR_OP_READ;
-		break;
-	default:
-		dev_err(dev, "No Read opcode defined\n");
-		return -EINVAL;
-	}
-
-	nor->program_opcode = SPINOR_OP_PP;
-
 	if (info->addr_width)
 		nor->addr_width = info->addr_width;
 	else if (mtd->size > 0x1000000) {
@@ -1233,8 +1804,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		nor->addr_width = 3;
 	}
 
-	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
-
 	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
 			(long long)mtd->size >> 10);
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 97e52ee475e9..3eed672347dc 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -24,8 +24,10 @@
 #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
 #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
 #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
-#define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual SPI) */
-#define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual Output SPI) */
+#define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
+#define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
+#define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
@@ -39,8 +41,10 @@
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ4		0x13	/* Read data bytes (low frequency) */
 #define SPINOR_OP_READ4_FAST	0x0c	/* Read data bytes (high frequency) */
-#define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual SPI) */
-#define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual Output SPI) */
+#define SPINOR_OP_READ4_1_2_2	0xbc	/* Read data bytes (Dual I/O SPI) */
+#define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad Output SPI) */
+#define SPINOR_OP_READ4_1_4_4	0xec	/* Read data bytes (Quad I/O SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
 
@@ -58,6 +62,8 @@
 
 /* Used for Micron flashes only. */
 #define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
+#define SPINOR_OP_RD_VCR	0x85	/* Read VCR register */
+#define SPINOR_OP_WR_VCR	0x81	/* Write VCR register */
 #define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
 #define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
 
@@ -74,6 +80,7 @@
 
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON    0x80    /* Micron Quad I/O */
+#define EVCR_DUAL_EN_MICRON    0x40    /* Micron Dual I/O */
 
 /* Flag Status Register bits */
 #define FSR_READY		0x80
-- 
1.8.2.2
