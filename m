From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 15 Sep 2015 17:28:01 +0200
Subject: [linux-next RFC v7 3/6] mtd: spi-nor: set the read op code and
 protocol based on the manufacturer
In-Reply-To: <cover.1442330503.git.cyrille.pitchen@atmel.com>
References: <cover.1442330503.git.cyrille.pitchen@atmel.com>
Message-ID: <524b416852aa9554eca01a3a5d6020ba6836ea95.1442330503.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Micron:
Once their Quad SPI protocol enabled, Micron spi-nor memories expect all
commands to use the SPI 4-4-4 protocol. Also when the Dual SPI protocol is
enabled, all commands must use the SPI 2-2-2 protocol.

Macronix:
When the QPI mode is enabled, all commands must use the SPI 4-4-4 protocol.
If the QPI mode is disabled, the Fast Read Dual Output (0x3b) command uses
the SPI 1-1-2 protocol whereas other commands use the SPI 1-1-1 protocol.

Spansion:
When Quad I/O operations are enabled, the Fast Read Quad Output (0x6b / 0x6c)
commands use the SPI 1-1-4 protocol.
Also when using the Fast Read Dual Output (0x3b / 0x3c) commands, the
SPI 1-1-2 protocol must be used. Other commands use the SPI 1-1-1 protocol.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 544 ++++++++++++++++++++++++++++++++++++------
 include/linux/mtd/spi-nor.h   |  10 +-
 2 files changed, 481 insertions(+), 73 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1908038c8f2e..7fbcccb3d02e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -900,27 +900,110 @@ write_err:
 	return ret;
 }
 
-static int macronix_quad_enable(struct spi_nor *nor)
+static int macronix_set_qpi_mode(struct spi_nor *nor, bool enable)
 {
-	int ret, val;
+	int sr, mask, qpi_bit;
+
+	mask = SR_QUAD_EN_MX;
+	qpi_bit = (enable) ? SR_QUAD_EN_MX : 0;
+
+	sr = read_sr(nor);
+	if ((sr & mask) == qpi_bit)
+		return 0;
 
-	val = read_sr(nor);
 	write_enable(nor);
+	write_sr(nor, (sr & ~mask) | qpi_bit);
 
-	write_sr(nor, val | SR_QUAD_EN_MX);
+	/* Set the reg protocol now before accessing any other register. */
+	nor->reg_proto = (enable) ? SPI_PROTO_4_4_4 : SPI_PROTO_1_1_1;
 
-	if (spi_nor_wait_till_ready(nor))
+	if (spi_nor_wait_till_ready(nor)) {
+		dev_err(nor->dev, "Failed to %s the QPI mode.\n",
+			enable ? "enable" : "disable");
 		return 1;
+	}
 
-	ret = read_sr(nor);
-	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
-		dev_err(nor->dev, "Macronix Quad bit not set\n");
+	sr = read_sr(nor);
+	if (!(sr > 0 && ((sr & mask) != qpi_bit))) {
+		dev_err(nor->dev, "Macronix Quad bit was not %s.\n",
+			enable ? "set" : "cleared");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
+static int macronix_set_quad_io(struct spi_nor *nor)
+{
+	/* Enable the QPI mode if not done yet. */
+	if (macronix_set_qpi_mode(nor, true))
+		return -EINVAL;
+
+	/* Use SPI 4-4-4 protocol for all commands. */
+	nor->read_proto = SPI_PROTO_4_4_4;
+	nor->write_proto = SPI_PROTO_4_4_4;
+	nor->erase_proto = SPI_PROTO_4_4_4;
+
+	/*
+	 * The Fast Read Quad Output 1-1-4 command (0x6b) command is not
+	 * supported in QPI mode, use the Fast Read Quad I/O 1-4-4 (0xeb)
+	 * instead.
+	 */
+	nor->read_opcode = SPINOR_OP_READ_1_4_4;
+
+	return 0;
+}
+
+static int macronix_set_quad_output(struct spi_nor *nor)
+{
+	/* Disable the QPI mode if not done yet. */
+	if (macronix_set_qpi_mode(nor, false))
+		return -EINVAL;
+
+	/* Use the Fast Read Quad Output 1-1-4 command. */
+	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+
+	return 0;
+}
+
+static int macronix_set_dual_io(struct spi_nor *nor)
+{
+	/* Disable the QPI mode if not done yet. */
+	if (macronix_set_qpi_mode(nor, false))
+		return -EINVAL;
+
+	/* Use the Fast Read Dual I/O 1-2-2 command. */
+	nor->read_proto = SPI_PROTO_1_2_2;
+	nor->read_opcode = SPINOR_OP_READ_1_2_2;
+
+	return 0;
+}
+
+static int macronix_set_dual_output(struct spi_nor *nor)
+{
+	/* Disable the QPI mode if not done yet. */
+	if (macronix_set_qpi_mode(nor, false))
+		return -EINVAL;
+
+	/* Use the Fast Read Dual Output 1-1-2 command. */
+	nor->read_proto = SPI_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+
+	return 0;
+}
+
+static int macronix_set_single(struct spi_nor *nor)
+{
+	/* Disable the QPI mode if not done yet. */
+	if (macronix_set_qpi_mode(nor, false))
+		return -EINVAL;
+
+	nor->read_proto = SPI_PROTO_1_1_1;
+
+	return 0;
+}
+
 /*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
@@ -935,96 +1018,416 @@ static int write_sr_cr(struct spi_nor *nor, u16 val)
 	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 2);
 }
 
-static int spansion_quad_enable(struct spi_nor *nor)
+static int spansion_write_cr(struct spi_nor *nor, bool quad_mode, u8 lc)
 {
-	int ret;
-	int quad_en = CR_QUAD_EN_SPAN << 8;
+	int cr, mask, value;
 
-	write_enable(nor);
+	mask = CR_QUAD_EN_SPAN | CR_LC_MASK;
+	value = (lc << 6) & CR_LC_MASK;
+	if (quad_mode)
+		value |= CR_QUAD_EN_SPAN;
 
-	ret = write_sr_cr(nor, quad_en);
-	if (ret < 0) {
+	/* Read the control register */
+	cr = read_cr(nor);
+	if (cr < 0) {
+		dev_err(nor->dev,
+			"error while reading configuration register\n");
+		return -EINVAL;
+	}
+
+	/* Check whether the Quad bit and the Latency Code need to be updated */
+	if ((cr & mask) == value)
+		return 0;
+
+	/* Update the configuration register. */
+	cr = (cr & ~mask) | value;
+	write_enable(nor);
+	if (write_sr_cr(nor, cr << 8) < 0) {
 		dev_err(nor->dev,
 			"error while writing configuration register\n");
 		return -EINVAL;
 	}
 
 	/* read back and check it */
-	ret = read_cr(nor);
-	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
-		dev_err(nor->dev, "Spansion Quad bit not set\n");
+	cr = read_cr(nor);
+	if (!(cr > 0 && ((cr & mask) == value))) {
+		dev_err(nor->dev,
+			"error while updating configuration register\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int micron_quad_enable(struct spi_nor *nor)
+static int spansion_set_quad_output(struct spi_nor *nor)
+{
+	int ret;
+
+	/*
+	 * Set the Latency Code to 0 so the memory expects 8 dummy cycles when
+	 * processing a Fast Read Quad Output 1-1-4 command.
+	 */
+	ret = spansion_write_cr(nor, true, 0);
+	if (ret)
+		return ret;
+
+	/* Use the Fast Read Quad Output 1-1-4 command. */
+	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+
+	return 0;
+}
+
+static int spansion_set_dual_output(struct spi_nor *nor)
+{
+	int ret;
+
+	/*
+	 * Set the Latency Code to 0 so the memory expects 8 dummy cycles when
+	 * processing a Fast Read Dual Output 1-1-2 command.
+	 */
+	ret = spansion_write_cr(nor, false, 0);
+	if (ret)
+		return ret;
+
+	/* Use the Fast Read Dual Output 1-1-2 command. */
+	nor->read_proto = SPI_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+
+	return 0;
+}
+
+static int spansion_set_single(struct spi_nor *nor)
 {
 	int ret;
-	u8 val;
 
-	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &val, 1);
+	/*
+	 * Set the Latency Code to 0 so the memory expects 8 dummy cycles when
+	 * processing a Fast Read 1-1-1 command. The Latency Code is not
+	 * relevant for Read command since no dummy cycle is expected.
+	 */
+	ret = spansion_write_cr(nor, false, 0);
+	if (ret)
+		return ret;
+
+	nor->read_proto = SPI_PROTO_1_1_1;
+
+	return 0;
+}
+
+static int micron_set_dummy_cycles(struct spi_nor *nor, u8 num_dummy_cycles)
+{
+	u8 vcr, val, mask;
+	int ret;
+
+	mask = GENMASK(7, 4);
+	val = (num_dummy_cycles << 4) & mask;
+
+	/* Read the Volatile Configuration Register (VCR). */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_VCR, &vcr, 1);
 	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading EVCR\n", ret);
+		dev_err(nor->dev, "error while reading VCR register\n");
 		return ret;
 	}
 
+	/* Check whether we need to update the number of dummy cycles. */
+	if ((vcr & mask) == val)
+		return 0;
+
+	/* Update the number of dummy into the VCR. */
 	write_enable(nor);
+	vcr = (vcr & ~mask) | val;
+	ret = nor->write_reg(nor, SPINOR_OP_WR_VCR, &vcr, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error while writing VCR register\n");
+		return ret;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
 
-	/* set EVCR, enable quad I/O */
-	nor->cmd_buf[0] = val & ~EVCR_QUAD_EN_MICRON;
-	ret = nor->write_reg(nor, SPINOR_OP_WD_EVCR, nor->cmd_buf, 1);
+	/* Read VCR and check it. */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_VCR, &vcr, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error while reading VCR\n");
+		return ret;
+	}
+	if ((vcr & mask) != val) {
+		dev_err(nor->dev, "Micron VCR dummy cycles not updated\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int micron_set_protocol(struct spi_nor *nor, u8 val,
+			       enum spi_protocol proto)
+{
+	u8 evcr, mask;
+	int ret;
+
+	mask = EVCR_QUAD_EN_MICRON | EVCR_DUAL_EN_MICRON;
+
+	/* Read the Exhanced Volatile Configuration Register (EVCR). */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &evcr, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error while reading EVCR register\n");
+		return ret;
+	}
+
+	/* Check whether we need to update the protocol bits. */
+	if ((evcr & mask) == val)
+		return 0;
+
+	/* Set EVCR protocol bits. */
+	write_enable(nor);
+	evcr = (evcr & ~mask) | val;
+	ret = nor->write_reg(nor, SPINOR_OP_WD_EVCR, &evcr, 1);
 	if (ret < 0) {
 		dev_err(nor->dev, "error while writing EVCR register\n");
 		return ret;
 	}
 
+	/* Switch reg protocol now before accessing any other registers. */
+	nor->reg_proto = proto;
+
 	ret = spi_nor_wait_till_ready(nor);
 	if (ret)
 		return ret;
 
-	/* read EVCR and check it */
-	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &val, 1);
+	/* Read EVCR and check it. */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_EVCR, &evcr, 1);
 	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading EVCR\n", ret);
+		dev_err(nor->dev, "error while reading EVCR\n");
 		return ret;
 	}
-	if (val & EVCR_QUAD_EN_MICRON) {
-		dev_err(nor->dev, "Micron EVCR Quad bit not clear\n");
+	if ((evcr & mask) != val) {
+		dev_err(nor->dev, "Micron EVCR protocol bits not updated\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
+static inline int micron_set_extended_spi_protocol(struct spi_nor *nor)
 {
-	int status;
+	int ret;
 
+	/* Set both the Quad and Dual bits to select the Extended SPI mode */
+	ret = micron_set_protocol(nor,
+				  EVCR_QUAD_EN_MICRON | EVCR_DUAL_EN_MICRON,
+				  SPI_PROTO_1_1_1);
+	if (ret) {
+		dev_err(nor->dev, "Failed to set Micron Extended SPI mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int micron_set_quad_io(struct spi_nor *nor)
+{
+	int ret;
+
+	/* Clear at least the Quad bit to enable quad mode */
+	ret = micron_set_protocol(nor,
+				  EVCR_DUAL_EN_MICRON,
+				  SPI_PROTO_4_4_4);
+	if (ret) {
+		dev_err(nor->dev, "Failed to set Micron Quad mode\n");
+		return ret;
+	}
+
+	/* Force the number of dummy cycles to 8 */
+	ret = micron_set_dummy_cycles(nor, 8);
+	if (ret)
+		return ret;
+
+	/* Use SPI 4-4-4 protocol for all commands. */
+	nor->read_proto = SPI_PROTO_4_4_4;
+	nor->write_proto = SPI_PROTO_4_4_4;
+	nor->erase_proto = SPI_PROTO_4_4_4;
+
+	/*
+	 * The Fast Read Quad Output 1-1-4 command (0x6b) is processed with
+	 * SPI 4-4-4 protocol.
+	 */
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+
+	return 0;
+}
+
+static int micron_set_quad_output(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = micron_set_extended_spi_protocol(nor);
+	if (ret)
+		return ret;
+
+	/* Force the number of dummy cycles to 8 */
+	ret = micron_set_dummy_cycles(nor, 8);
+	if (ret)
+		return ret;
+
+	/* Use the Fast Read Quad Output 1-1-4 command. */
+	nor->read_proto = SPI_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+
+	return 0;
+}
+
+static int micron_set_dual_io(struct spi_nor *nor)
+{
+	int ret;
+
+	/* Clear Dual bit but keep Quad bit set to enable dual mode */
+	ret = micron_set_protocol(nor,
+				  EVCR_QUAD_EN_MICRON,
+				  SPI_PROTO_2_2_2);
+	if (ret) {
+		dev_err(nor->dev, "Failed to set Micron Dual mode\n");
+		return ret;
+	}
+
+	/* Force the number of dummy cycles to 8 */
+	ret = micron_set_dummy_cycles(nor, 8);
+	if (ret)
+		return ret;
+
+	/* Use SPI 2-2-2 protocol for all commands. */
+	nor->read_proto = SPI_PROTO_2_2_2;
+	nor->write_proto = SPI_PROTO_2_2_2;
+	nor->erase_proto = SPI_PROTO_2_2_2;
+
+	/*
+	 * The Fast Read Dual Output 1-1-2 command (0x3b) is processed with
+	 * SPI 2-2-2 protocol.
+	 */
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+
+	return 0;
+}
+
+static int micron_set_dual_output(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = micron_set_extended_spi_protocol(nor);
+	if (ret)
+		return ret;
+
+	/* Force the number of dummy cycles to 8 */
+	ret = micron_set_dummy_cycles(nor, 8);
+	if (ret)
+		return ret;
+
+	/* Use the Fast Read Dual Output 1-1-4 command. */
+	nor->read_proto = SPI_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+
+	return 0;
+}
+
+static int micron_set_single(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = micron_set_extended_spi_protocol(nor);
+	if (ret)
+		return ret;
+
+	/* Force the number of dummy cycles to 8 (Fast Read only) */
+	ret = micron_set_dummy_cycles(nor, 8);
+	if (ret)
+		return ret;
+
+	nor->read_proto = SPI_PROTO_1_1_1;
+
+	return 0;
+}
+
+static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info,
+			 u16 mode)
+{
 	switch (JEDEC_MFR(info)) {
 	case CFI_MFR_MACRONIX:
-		status = macronix_quad_enable(nor);
-		if (status) {
-			dev_err(nor->dev, "Macronix quad-read not enabled\n");
-			return -EINVAL;
-		}
-		return status;
+		if (mode & SPI_TX_QUAD)
+			return macronix_set_quad_io(nor);
+		return macronix_set_quad_output(nor);
+
 	case CFI_MFR_ST:
-		status = micron_quad_enable(nor);
-		if (status) {
-			dev_err(nor->dev, "Micron quad-read not enabled\n");
-			return -EINVAL;
-		}
-		return status;
+		if (mode & SPI_TX_QUAD)
+			return micron_set_quad_io(nor);
+		return micron_set_quad_output(nor);
+
+	case CFI_MFR_AMD:
+		/*
+		 * Don't use the Fast Read Quad I/O (0xeb / 0xec) commands as
+		 * their number of dummy cycles is not a multiple of 8. Some
+		 * SPI controllers, especially those relying on the m25p80
+		 * driver, expect the number of dummy cycles to be a multiple
+		 * of 8.
+		 */
+		return spansion_set_quad_output(nor);
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
+static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info,
+			 u16 mode)
+{
+	switch (JEDEC_MFR(info)) {
+	case CFI_MFR_MACRONIX:
+		if (mode & SPI_TX_DUAL)
+			return macronix_set_dual_io(nor);
+		return macronix_set_dual_output(nor);
+
+	case CFI_MFR_ST:
+		if (mode & SPI_TX_DUAL)
+			return micron_set_dual_io(nor);
+		return micron_set_dual_output(nor);
+
+	case CFI_MFR_AMD:
+		/*
+		 * Don't use the Fast Read Dual I/O (0xbb / 0xbc) commands as
+		 * their number of dummy cycles is not a multiple of 8. Some
+		 * SPI controllers, especially those relying on the m25p80
+		 * driver, expect the number of dummy cycles to be a multiple
+		 * of 8.
+		 */
+		return spansion_set_dual_output(nor);
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int set_single_mode(struct spi_nor *nor, const struct flash_info *info,
+			   u16 mode)
+{
+	switch (JEDEC_MFR(info)) {
+	case CFI_MFR_MACRONIX:
+		return macronix_set_single(nor);
+
+	case CFI_MFR_ST:
+		return micron_set_single(nor);
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
@@ -1170,39 +1573,38 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, u16 mode)
 	if (info->flags & SPI_NOR_NO_FR)
 		nor->flash_read = SPI_NOR_NORMAL;
 
+	/* Default commands */
+	nor->program_opcode = SPINOR_OP_PP;
+	if (nor->flash_read == SPI_NOR_NORMAL)
+		nor->read_opcode = SPINOR_OP_READ;
+	else
+		nor->read_opcode = SPINOR_OP_READ_FAST;
+
 	/* Quad/Dual-read mode takes precedence over fast/normal */
 	if (mode & SPI_RX_QUAD && info->flags & SPI_NOR_QUAD_READ) {
-		ret = set_quad_mode(nor, info);
+		/* At least SPI 1-1-4 should be supported */
+		ret = set_quad_mode(nor, info, mode);
 		if (ret) {
 			dev_err(dev, "quad mode not supported\n");
 			return ret;
 		}
 		nor->flash_read = SPI_NOR_QUAD;
 	} else if (mode & SPI_RX_DUAL && info->flags & SPI_NOR_DUAL_READ) {
+		/* At lest SPI 1-1-2 should be supported */
+		ret = set_dual_mode(nor, info, mode);
+		if (ret) {
+			dev_err(dev, "dual mode not supported\n");
+			return ret;
+		}
 		nor->flash_read = SPI_NOR_DUAL;
+	} else if (info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) {
+		ret = set_single_mode(nor, info, mode);
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
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 32339e82cb9d..1cdc905a3077 100644
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
+#define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Out SPI) */
+#define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
@@ -58,6 +60,8 @@
 
 /* Used for Micron flashes only. */
 #define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
+#define SPINOR_OP_RD_VCR	0x85	/* Read VCR register */
+#define SPINOR_OP_WR_VCR	0x81	/* Write VCR register */
 #define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
 #define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
 
@@ -74,12 +78,14 @@
 
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON    0x80    /* Micron Quad I/O */
+#define EVCR_DUAL_EN_MICRON    0x40    /* Micron Dual I/O */
 
 /* Flag Status Register bits */
 #define FSR_READY		0x80
 
 /* Configuration Register bits. */
 #define CR_QUAD_EN_SPAN		0x2	/* Spansion Quad I/O */
+#define CR_LC_MASK		0xc0	/* Spansion Latency Code */
 
 enum read_mode {
 	SPI_NOR_NORMAL = 0,
-- 
1.8.2.2
