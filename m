From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 16 Jul 2015 17:27:52 +0200
Subject: [PATCH 5/7] mtd: spi-nor: allow the set the latency code on Spansion
 memories
In-Reply-To: <cover.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
Message-ID: <12f0bceb57e1bf25279a995f76103b4e75091e82.1437059658.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the SPI controller and the flash memory must agree on the number of
dummy cycles to use for Fast Read commands. For Spansion memories, this
number of dummy cycles is configured through a so called latency code in
their Control Register.
The right latency code can be found in the memory datasheet and depends
on the SPI clock frequency, the op code of the Fast Read command and the
Single/Dual Data Rate mode.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5df6e4712a9e..32fddf06da3f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -989,6 +989,50 @@ static int set_quad_mode(struct spi_nor *nor, struct flash_info *info)
 	}
 }
 
+static int spansion_set_latency_code(struct spi_nor *nor)
+{
+	struct device_node *np = nor->dev->of_node;
+	u8 cr, mask = GENMASK(7, 6);
+	u32 lc;
+	int ret;
+
+	if (!np || of_property_read_u32(np, "spansion,latency-code", &lc))
+		return 0;
+
+	if (lc & ~(mask >> 6)) {
+		dev_err(nor->dev, "invalid latency code: %u\n", lc);
+		return -EINVAL;
+	}
+
+	ret = read_cr(nor);
+	if (ret < 0) {
+		dev_err(nor->dev,
+			"error while reading configuration register\n");
+		return ret;
+	}
+
+	write_enable(nor);
+
+	cr = ret;
+	cr &= ~mask;
+	cr |= (lc << 6);
+	ret = write_sr_cr(nor, cr << 8);
+	if (ret < 0) {
+		dev_err(nor->dev,
+			"error while updating configuration register\n");
+		return -EINVAL;
+	}
+
+	/* read back and check it */
+	ret = read_cr(nor);
+	if (!(ret >= 0 && (ret & mask) == (lc << 6))) {
+		dev_err(nor->dev, "Spansion latency code not set\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int micron_set_dummy_cycles(struct spi_nor *nor)
 {
 	int ret;
@@ -1045,6 +1089,8 @@ static int spi_nor_read_dummy_cycles(struct spi_nor *nor,
 		 * backward compatibility.
 		 */
 		switch (JEDEC_MFR(info)) {
+		case CFI_MFR_AMD:
+			return spansion_set_latency_code(nor);
 		case CFI_MFR_ST:
 			return micron_set_dummy_cycles(nor);
 		default:
-- 
1.8.2.2
