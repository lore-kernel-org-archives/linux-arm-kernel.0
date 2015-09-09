From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 9 Sep 2015 15:24:16 +0200
Subject: [PATCH linux-next v6 6/8] mtd: spi-nor: allow to tune the number of
 dummy cycles
In-Reply-To: <cover.1441803609.git.cyrille.pitchen@atmel.com>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com>
Message-ID: <e149e4b9737c8fe09c0c1f8a781a5b0e07c540ef.1441803609.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of dummy cycles used during Fast Read commands can be reduced
to improve transfer performances. Each manufacturer has a dedicated set of
registers to provide the memory with the exact number of dummy cycles it
should expect. Both the memory and the (Q)SPI controller must agree on
this number of dummy cycles.

The number of dummy cycles can be found into the memory datasheet and
mostly depends on the SPI clock frequency, the Fast Read op code and the
Single/Dual Data Rate mode.

Probing JEDEC Serial Flash Discoverable Parameters (SFDP) tables would
only provide the driver with a high enough number of dummy cycles for each
Fast Read command to be used for all clock frequencies: this solution
would not be optimized.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 102 ++++++++++++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h   |   2 +
 2 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 820a2177ed5e..7405a1450dd1 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -121,24 +121,6 @@ static int read_cr(struct spi_nor *nor)
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
@@ -1194,6 +1176,86 @@ static void tune_manufacturer_commands(struct spi_nor *nor,
 	}
 }
 
+static int micron_set_dummy_cycles(struct spi_nor *nor)
+{
+	int ret;
+	u8 val, mask;
+
+	/* Read the Volatile Configuration Register (VCR). */
+	ret = nor->read_reg(nor, SPINOR_OP_RD_VCR, &val, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d reading VCR\n", ret);
+		return ret;
+	}
+
+	write_enable(nor);
+
+	/* Update the number of dummy into the VCR. */
+	mask = GENMASK(7, 4);
+	val &= ~mask;
+	val |= (nor->read_dummy << 4) & mask;
+	ret = nor->write_reg(nor, SPINOR_OP_WR_VCR, &val, 1, 0);
+	if (ret < 0) {
+		dev_err(nor->dev, "error while writing VCR register\n");
+		return ret;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Dummy Cycle calculation for different type of read.
+ * It can be used to support more commands with
+ * different dummy cycle requirements.
+ */
+static int spi_nor_read_dummy_cycles(struct spi_nor *nor,
+				     const struct flash_info *info)
+{
+	struct device_node *np = nor->dev->of_node;
+	struct device *dev = nor->dev;
+	u32 num_dummy_cycles;
+
+	if (np && !of_property_read_u32(np, "m25p,num-dummy-cycles",
+					&num_dummy_cycles)) {
+		nor->read_dummy = num_dummy_cycles;
+
+		/*
+		 * This switch block might be moved at the end of the function,
+		 * once nor->read_dummy has been set, but it was not tested with
+		 * all Micron memories.
+		 * Now the "m25p,num-dummy-cycles" property needs to be
+		 * explicitly set in the device tree so the switch statement is
+		 * executed. This should avoid unwanted side effects and keep
+		 * backward compatibility.
+		 */
+		switch (JEDEC_MFR(info)) {
+		case CFI_MFR_ST:
+			return micron_set_dummy_cycles(nor);
+		default:
+			dev_warn(dev,
+				 "Tuning of the number of dummy cycles is not implemented for spi-nor of this manufacturer,\n"
+				 "ignoring the DT property value and falling back to the framework default settings.\n");
+			break;
+		}
+	}
+
+	/* Fallback to legacy code. */
+	switch (nor->flash_read) {
+	case SPI_NOR_FAST:
+	case SPI_NOR_DUAL:
+	case SPI_NOR_QUAD:
+		nor->read_dummy = 8;
+	case SPI_NOR_NORMAL:
+		nor->read_dummy = 0;
+	}
+
+	return 0;
+}
+
 static int spi_nor_check(struct spi_nor *nor)
 {
 	if (!nor->dev || !nor->read || !nor->write ||
@@ -1387,7 +1449,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	/* Tune read, page program and erase commands */
 	tune_manufacturer_commands(nor, info);
 
-	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
+	ret = spi_nor_read_dummy_cycles(nor, info);
+	if (ret)
+		return ret;
 
 	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
 			(long long)mtd->size >> 10);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f13cd2cb3ac5..4a3f5d8655d8 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -66,6 +66,8 @@
 #define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
 #define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
 #define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
+#define SPINOR_OP_RD_VCR	0x85	/* Read VCR register */
+#define SPINOR_OP_WR_VCR	0x81	/* Write VCR register */
 
 /* Status Register bits. */
 #define SR_WIP			1	/* Write in progress */
-- 
1.8.2.2
