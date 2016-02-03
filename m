From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Feb 2016 14:26:51 +0100
Subject: [PATCH v3 06/14] mtd: spi-nor: fix support of Micron memories
In-Reply-To: <cover.1454505161.git.cyrille.pitchen@atmel.com>
References: <cover.1454505161.git.cyrille.pitchen@atmel.com>
Message-ID: <00471284afedfd58a6b3bb17dbd4e51ea509de03.1454505161.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing mode transitions. Indeed depending on both the
current memory mode and the new protocol wanted by the user, we may need
to perform a switch back to the Extended SPI mode.

However when the current mode is the Quad mode and the user has asked for
a Quad SPI protocol, we'd rather stay in Quad mode and use the Fast Read
4-4-4 command than switch to the Extended SPI mode and use the Fast Read
1-1-4 command.

Also we'd rather stay in Dual mode than swith to the Extended SPI mode
whenever the user has asked for Dual SPI protocol.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 154 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |   1 +
 2 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 980da91e84a4..6785e699106d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1298,6 +1298,147 @@ static int winbond_set_single_mode(struct spi_nor *nor)
 	return 0;
 }
 
+static int micron_set_protocol(struct spi_nor *nor, u8 mask, u8 val,
+			       enum spi_nor_protocol proto)
+{
+	u8 evcr;
+	int ret;
+
+	/* Read the Enhanced Volatile Configuration Register (EVCR). */
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
+		return -EINVAL;
+	}
+
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
+				  SNOR_PROTO_1_1_1);
+	if (ret) {
+		dev_err(nor->dev, "Failed to set Micron Extended SPI mode\n");
+		return ret;
+	}
+
+	nor->write_proto = SNOR_PROTO_1_1_1;
+	nor->erase_proto = SNOR_PROTO_1_1_1;
+	return 0;
+}
+
+static int micron_set_quad_mode(struct spi_nor *nor)
+{
+	/* Check whether the Dual SPI mode is enabled. */
+	if (unlikely(nor->read_proto == SNOR_PROTO_2_2_2)) {
+		int ret;
+
+		/*
+		 * Exit Micron Dual mode and switch to the Extended SPI mode:
+		 * we can change the mode safely as we write into a volatile
+		 * register.
+		 * Also the Quad mode is not worth it for MTD usages: it
+		 * should only be relevant for eXecution In Place (XIP) usages,
+		 * which are out of the scope of the spi-nor framework.
+		 */
+		ret = micron_set_extended_spi_protocol(nor);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Whatever the Quad mode is enabled or not, the
+	 * Fast Read Quad Output 1-1-4 (0x6b) op code is supported.
+	 */
+	if (nor->read_proto != SNOR_PROTO_4_4_4)
+		nor->read_proto = SNOR_PROTO_1_1_4;
+	nor->read_opcode = SPINOR_OP_READ_1_1_4;
+	return 0;
+}
+
+static int micron_set_dual_mode(struct spi_nor *nor)
+{
+	/* Check whether Quad mode is enabled. */
+	if (unlikely(nor->read_proto == SNOR_PROTO_4_4_4)) {
+		int ret;
+
+		/*
+		 * Exit Micron Quad mode and switch to the Extended SPI mode:
+		 * we can change the mode safely as we write into a volatile
+		 * register.
+		 * Also the Dual mode is not worth it for MTD usages: it
+		 * should only be relevant for eXecution In Place (XIP) usages,
+		 * which are out of the scope of the spi-nor framework.
+		 */
+		ret = micron_set_extended_spi_protocol(nor);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Whatever the Dual mode is enabled or not, the
+	 * Fast Read Dual Output 1-1-2 (0x3b) op code is supported.
+	 */
+	if (nor->read_proto != SNOR_PROTO_2_2_2)
+		nor->read_proto = SNOR_PROTO_1_1_2;
+	nor->read_opcode = SPINOR_OP_READ_1_1_2;
+	return 0;
+}
+
+static int micron_set_single_mode(struct spi_nor *nor)
+{
+	/* Check whether either the Dual or Quad mode is enabled. */
+	if (unlikely(nor->read_proto != SNOR_PROTO_1_1_1)) {
+		int ret;
+
+		/*
+		 * Exit Micron Dual or Quad mode and switch to the Extended SPI
+		 * mode: we can change the mode safely as we write into a
+		 * volatile register.
+		 */
+		ret = micron_set_extended_spi_protocol(nor);
+		if (ret)
+			return ret;
+
+		nor->read_proto = SNOR_PROTO_1_1_1;
+	}
+
+	return 0;
+}
+
 static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
 {
 	int status;
@@ -1310,10 +1451,7 @@ static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
 		return winbond_set_quad_mode(nor);
 
 	case SNOR_MFR_MICRON:
-		/* Check whether Micron Quad mode is enabled. */
-		if (nor->read_proto != SNOR_PROTO_4_4_4)
-			nor->read_proto = SNOR_PROTO_1_1_4;
-		break;
+		return micron_set_quad_mode(nor);
 
 	case SNOR_MFR_SPANSION:
 		status = spansion_quad_enable(nor);
@@ -1342,10 +1480,7 @@ static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
 		return winbond_set_dual_mode(nor);
 
 	case SNOR_MFR_MICRON:
-		/* Check whether Micron Dual mode is enabled. */
-		if (nor->read_proto != SNOR_PROTO_2_2_2)
-			nor->read_proto = SNOR_PROTO_1_1_2;
-		break;
+		return micron_set_dual_mode(nor);
 
 	default:
 		nor->read_proto = SNOR_PROTO_1_1_2;
@@ -1365,6 +1500,9 @@ static int set_single_mode(struct spi_nor *nor, const struct flash_info *info)
 	case SNOR_MFR_WINBOND:
 		return winbond_set_single_mode(nor);
 
+	case SNOR_MFR_MICRON:
+		return micron_set_single_mode(nor);
+
 	default:
 		nor->read_proto = SNOR_PROTO_1_1_1;
 		break;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 46343f5a8162..d0a6f343a063 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -102,6 +102,7 @@
 
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
+#define EVCR_DUAL_EN_MICRON	BIT(6)	/* Micron Dual I/O */
 
 /* Flag Status Register bits */
 #define FSR_READY		BIT(7)
-- 
1.8.2.2
