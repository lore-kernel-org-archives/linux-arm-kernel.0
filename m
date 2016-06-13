From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:51 -0000
Subject: [PATCH v3 09/13] spi: sunxi: use register map
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <8a38b24c4e9cfd42bcb9f58d59f8ecc156dc156d.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver code uses the fact that several bits are set in one register
to set them at once.

Between hardware revisions these bits might migrate to different
position or different register altogether but the logical bit groups
that are used together end up in the same register.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 227 ++++++++++++++++++++++++++++++--------------
 drivers/spi/spi-sun6i.c | 243 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 322 insertions(+), 148 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index bbb0996..0b8e6c6 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -23,63 +23,118 @@
 
 #include <linux/spi/spi.h>
 
-#define SUNXI_FIFO_DEPTH		64
+#define SUN4I_FIFO_DEPTH		64
+#define SUN6I_FIFO_DEPTH		128
 
-#define SUNXI_RXDATA_REG		0x00
+#define SUN4I_COMPATIBLE "allwinner,sun4i-a10-spi"
+#define SUN6I_COMPATIBLE "allwinner,sun6i-a31-spi"
 
-#define SUNXI_TXDATA_REG		0x04
+#define SUNXI_TFR_CTL_CS(bitmap, cs)	(((cs) << \
+					  (bitmap)[SUNXI_TFR_CTL_CS_SHIFT]) \
+					 & (bitmap)[SUNXI_TFR_CTL_CS_MASK])
 
-#define SUNXI_TFR_CTL_REG		0x08
-#define SUNXI_CTL_ENABLE		BIT(0)
-#define SUNXI_CTL_MASTER		BIT(1)
-#define SUNXI_TFR_CTL_CPHA		BIT(2)
-#define SUNXI_TFR_CTL_CPOL		BIT(3)
-#define SUNXI_TFR_CTL_SPOL		BIT(4)
-#define SUNXI_TFR_CTL_FBS		BIT(6)
-#define SUNXI_CTL_TF_RST		BIT(8)
-#define SUNXI_CTL_RF_RST		BIT(9)
-#define SUNXI_TFR_CTL_XCH		BIT(10)
-#define SUNXI_TFR_CTL_CS_MASK		0x3000
-#define SUNXI_TFR_CTL_CS(cs)		(((cs) << 12) & SUNXI_TFR_CTL_CS_MASK)
-#define SUNXI_TFR_CTL_DHB		BIT(15)
-#define SUNXI_TFR_CTL_CS_MANUAL		BIT(16)
-#define SUNXI_TFR_CTL_CS_LEVEL		BIT(17)
-#define SUNXI_CTL_TP			BIT(18)
+#define SUNXI_CNT_MASK			0xffffff
+#define SUNXI_XMIT_CNT(cnt)		((cnt) & SUNXI_CNT_MASK)
+#define SUNXI_BURST_CNT(cnt)		((cnt) & SUNXI_CNT_MASK)
+#define SUNXI_BURST_CTL_CNT_STC(cnt)	((cnt) & SUNXI_CNT_MASK)
 
-#define SUNXI_INT_CTL_REG		0x0c
-#define SUNXI_INT_CTL_TC		BIT(16)
-
-#define SUNXI_INT_STA_REG		0x10
-
-#define SUNXI_DMA_CTL_REG		0x14
-
-#define SUNXI_WAIT_REG			0x18
-
-#define SUNXI_CLK_CTL_REG		0x1c
+#define SUNXI_CLK_CTL_DRS		BIT(12)
 #define SUNXI_CLK_CTL_CDR2_MASK		0xff
 #define SUNXI_CLK_CTL_CDR2(div)		(((div) & SUNXI_CLK_CTL_CDR2_MASK) << 0)
 #define SUNXI_CLK_CTL_CDR1_MASK		0xf
 #define SUNXI_CLK_CTL_CDR1(div)		(((div) & SUNXI_CLK_CTL_CDR1_MASK) << 8)
-#define SUNXI_CLK_CTL_DRS		BIT(12)
-
-#define SUNXI_BURST_CNT_REG		0x20
-#define SUNXI_BURST_CNT(cnt)		((cnt) & 0xffffff)
 
-#define SUNXI_XMIT_CNT_REG		0x24
-#define SUNXI_XMIT_CNT(cnt)		((cnt) & 0xffffff)
-
-#define SUNXI_FIFO_STA_REG		0x28
 #define SUNXI_FIFO_STA_RF_CNT_MASK	0x7f
 #define SUNXI_FIFO_STA_RF_CNT_BITS	0
 #define SUNXI_FIFO_STA_TF_CNT_MASK	0x7f
 #define SUNXI_FIFO_STA_TF_CNT_BITS	16
 
+enum SPI_SUNXI_TYPE {
+	SPI_SUN4I = 1,
+	SPI_SUN6I,
+};
+
+enum SUNXI_REG_ENUM {
+	SUNXI_RXDATA_REG,
+	SUNXI_TXDATA_REG,
+	SUNXI_TFR_CTL_REG,
+	SUNXI_INT_CTL_REG,
+	SUNXI_INT_STA_REG,
+	SUNXI_WAIT_REG,
+	SUNXI_CLK_CTL_REG,
+	SUNXI_BURST_CNT_REG,
+	SUNXI_XMIT_CNT_REG,
+	SUNXI_FIFO_STA_REG,
+	SUNXI_VERSION_REG,
+	SUNXI_GBL_CTL_REG,
+	SUNXI_FIFO_CTL_REG,
+	SUNXI_BURST_CTL_CNT_REG,
+	SUNXI_NUM_REGS
+};
+
+static int sun4i_regmap[SUNXI_NUM_REGS] = {
+/* SUNXI_RXDATA_REG */			0x00,
+/* SUNXI_TXDATA_REG */			0x04,
+/* SUNXI_TFR_CTL_REG */			0x08,
+/* SUNXI_INT_CTL_REG */			0x0c,
+/* SUNXI_INT_STA_REG */			0x10,
+/* SUNXI_WAIT_REG */			0x18,
+/* SUNXI_CLK_CTL_REG */			0x1c,
+/* SUNXI_BURST_CNT_REG */		0x20,
+/* SUNXI_XMIT_CNT_REG */		0x24,
+/* SUNXI_FIFO_STA_REG */		0x28,
+-1, -1, -1, -1
+};
+
+enum SUNXI_BITMAP_ENUM {
+	SUNXI_CTL_ENABLE,
+	SUNXI_CTL_MASTER,
+	SUNXI_TFR_CTL_CPHA,
+	SUNXI_TFR_CTL_CPOL,
+	SUNXI_TFR_CTL_CS_ACTIVE_LOW,
+	SUNXI_TFR_CTL_FBS,
+	SUNXI_CTL_TF_RST,
+	SUNXI_CTL_RF_RST,
+	SUNXI_TFR_CTL_XCH,
+	SUNXI_TFR_CTL_CS_MASK,
+	SUNXI_TFR_CTL_CS_SHIFT,
+	SUNXI_TFR_CTL_DHB,
+	SUNXI_TFR_CTL_CS_MANUAL,
+	SUNXI_TFR_CTL_CS_LEVEL,
+	SUNXI_CTL_TP,
+	SUNXI_INT_CTL_TC,
+	SUNXI_BITMAP_SIZE
+};
+
+static int sun4i_bitmap[SUNXI_BITMAP_SIZE] = {
+/* SUNXI_CTL_ENABLE */			BIT(0),
+/* SUNXI_CTL_MASTER */			BIT(1),
+/* SUNXI_TFR_CTL_CPHA */		BIT(2),
+/* SUNXI_TFR_CTL_CPOL */		BIT(3),
+/* SUNXI_TFR_CTL_CS_ACTIVE_LOW */	BIT(4),
+/* SUNXI_TFR_CTL_FBS */			BIT(6),
+/* SUNXI_CTL_TF_RST */			BIT(8),
+/* SUNXI_CTL_RF_RST */			BIT(9),
+/* SUNXI_TFR_CTL_XCH */			BIT(10),
+/* SUNXI_TFR_CTL_CS_MASK */		0x3000,
+/* SUNXI_TFR_CTL_CS_SHIFT */		12,
+/* SUNXI_TFR_CTL_DHB */			BIT(15),
+/* SUNXI_TFR_CTL_CS_MANUAL */		BIT(16),
+/* SUNXI_TFR_CTL_CS_LEVEL */		BIT(17),
+/* SUNXI_CTL_TP */			BIT(18),
+/* SUNXI_INT_CTL_TC */			BIT(16),
+};
+
 struct sunxi_spi {
 	struct spi_master	*master;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
 	struct clk		*mclk;
 	struct reset_control	*rstc;
+	int			(*regmap)[SUNXI_NUM_REGS];
+	int			(*bitmap)[SUNXI_BITMAP_SIZE];
+	int			fifo_depth;
+	int			type;
 
 	struct completion	done;
 
@@ -88,14 +143,31 @@ struct sunxi_spi {
 	int			len;
 };
 
-static inline u32 sunxi_spi_read(struct sunxi_spi *sspi, u32 reg)
+static inline u32 sspi_reg(struct sunxi_spi *sspi, enum SUNXI_REG_ENUM name)
+{
+	BUG_ON((name >= SUNXI_NUM_REGS) || (name < 0) ||
+	       (*sspi->regmap)[name] < 0);
+	return (*sspi->regmap)[name];
+}
+
+static inline u32 sunxi_spi_read(struct sunxi_spi *sspi,
+				 enum SUNXI_REG_ENUM name)
 {
-	return readl(sspi->base_addr + reg);
+	return readl(sspi->base_addr + sspi_reg(sspi, name));
 }
 
-static inline void sunxi_spi_write(struct sunxi_spi *sspi, u32 reg, u32 value)
+static inline void sunxi_spi_write(struct sunxi_spi *sspi,
+				   enum SUNXI_REG_ENUM name, u32 value)
 {
-	writel(value, sspi->base_addr + reg);
+	writel(value, sspi->base_addr + sspi_reg(sspi, name));
+}
+
+static inline u32 sspi_bits(struct sunxi_spi *sspi,
+			    enum SUNXI_BITMAP_ENUM name)
+{
+	BUG_ON((name >= SUNXI_BITMAP_SIZE) || (name < 0) ||
+	       (*sspi->bitmap)[name] <= 0);
+	return (*sspi->bitmap)[name];
 }
 
 static inline void sunxi_spi_drain_fifo(struct sunxi_spi *sspi, int len)
@@ -112,7 +184,8 @@ static inline void sunxi_spi_drain_fifo(struct sunxi_spi *sspi, int len)
 		len = cnt;
 
 	while (len--) {
-		byte = readb(sspi->base_addr + SUNXI_RXDATA_REG);
+		byte = readb(sspi->base_addr +
+			     sspi_reg(sspi, SUNXI_RXDATA_REG));
 		if (sspi->rx_buf)
 			*sspi->rx_buf++ = byte;
 	}
@@ -127,7 +200,8 @@ static inline void sunxi_spi_fill_fifo(struct sunxi_spi *sspi, int len)
 
 	while (len--) {
 		byte = sspi->tx_buf ? *sspi->tx_buf++ : 0;
-		writeb(byte, sspi->base_addr + SUNXI_TXDATA_REG);
+		writeb(byte, sspi->base_addr +
+		       sspi_reg(sspi, SUNXI_TXDATA_REG));
 		sspi->len--;
 	}
 }
@@ -138,16 +212,16 @@ static void sunxi_spi_set_cs(struct spi_device *spi, bool enable)
 	u32 reg;
 
 	reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
-	reg &= ~SUNXI_TFR_CTL_CS_MASK;
-	reg |= SUNXI_TFR_CTL_CS(spi->chip_select);
+	reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CS_MASK);
+	reg |= SUNXI_TFR_CTL_CS(*sspi->bitmap, spi->chip_select);
 
 	/* We want to control the chip select manually */
-	reg |= SUNXI_TFR_CTL_CS_MANUAL;
+	reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CS_MANUAL);
 
 	if (enable)
-		reg |= SUNXI_TFR_CTL_CS_LEVEL;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CS_LEVEL);
 	else
-		reg &= ~SUNXI_TFR_CTL_CS_LEVEL;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CS_LEVEL);
 
 	/*
 	 * Even though this looks irrelevant since we are supposed to
@@ -161,16 +235,19 @@ static void sunxi_spi_set_cs(struct spi_device *spi, bool enable)
 	 * low.
 	 */
 	if (spi->mode & SPI_CS_HIGH)
-		reg &= ~SUNXI_TFR_CTL_SPOL;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CS_ACTIVE_LOW);
 	else
-		reg |= SUNXI_TFR_CTL_SPOL;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CS_ACTIVE_LOW);
 
 	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);
 }
 
 static size_t sunxi_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUNXI_FIFO_DEPTH - 1;
+	struct spi_master *master = spi->master;
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
+
+	return sspi->fifo_depth - 1;
 }
 
 static int sunxi_spi_transfer_one(struct spi_master *master,
@@ -185,10 +262,10 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUNXI_FIFO_DEPTH)
+	if (tfr->len > sspi->fifo_depth)
 		return -EMSGSIZE;
 
-	if (tfr->tx_buf && tfr->len >= SUNXI_FIFO_DEPTH)
+	if (tfr->tx_buf && tfr->len >= sspi->fifo_depth)
 		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
@@ -203,35 +280,36 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 
 	/* Reset FIFOs */
 	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
-			reg | SUNXI_CTL_RF_RST | SUNXI_CTL_TF_RST);
+			reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
+			sspi_bits(sspi, SUNXI_CTL_TF_RST));
 
 	/*
 	 * Setup the transfer control register: Chip Select,
 	 * polarities, etc.
 	 */
 	if (spi->mode & SPI_CPOL)
-		reg |= SUNXI_TFR_CTL_CPOL;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CPOL);
 	else
-		reg &= ~SUNXI_TFR_CTL_CPOL;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CPOL);
 
 	if (spi->mode & SPI_CPHA)
-		reg |= SUNXI_TFR_CTL_CPHA;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CPHA);
 	else
-		reg &= ~SUNXI_TFR_CTL_CPHA;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CPHA);
 
 	if (spi->mode & SPI_LSB_FIRST)
-		reg |= SUNXI_TFR_CTL_FBS;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_FBS);
 	else
-		reg &= ~SUNXI_TFR_CTL_FBS;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_FBS);
 
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
 	 */
 	if (sspi->rx_buf)
-		reg &= ~SUNXI_TFR_CTL_DHB;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_DHB);
 	else
-		reg |= SUNXI_TFR_CTL_DHB;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_DHB);
 
 	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);
 
@@ -282,14 +360,16 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 	 * Filling the FIFO fully causes timeout for some reason
 	 * at least on spi2 on A10s
 	 */
-	sunxi_spi_fill_fifo(sspi, SUNXI_FIFO_DEPTH - 1);
+	sunxi_spi_fill_fifo(sspi, sspi->fifo_depth - 1);
 
 	/* Enable the interrupts */
-	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, SUNXI_INT_CTL_TC);
+	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG,
+			sspi_bits(sspi, SUNXI_INT_CTL_TC));
 
 	/* Start the transfer */
 	reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
-	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg | SUNXI_TFR_CTL_XCH);
+	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
+			reg | sspi_bits(sspi, SUNXI_TFR_CTL_XCH));
 
 	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
 	start = jiffies;
@@ -305,7 +385,7 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sunxi_spi_drain_fifo(sspi, SUNXI_FIFO_DEPTH);
+	sunxi_spi_drain_fifo(sspi, sspi->fifo_depth);
 
 out:
 	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, 0);
@@ -319,8 +399,9 @@ static irqreturn_t sunxi_spi_handler(int irq, void *dev_id)
 	u32 status = sunxi_spi_read(sspi, SUNXI_INT_STA_REG);
 
 	/* Transfer complete */
-	if (status & SUNXI_INT_CTL_TC) {
-		sunxi_spi_write(sspi, SUNXI_INT_STA_REG, SUNXI_INT_CTL_TC);
+	if (status & sspi_bits(sspi, SUNXI_INT_CTL_TC)) {
+		sunxi_spi_write(sspi, SUNXI_INT_STA_REG,
+				sspi_bits(sspi, SUNXI_INT_CTL_TC));
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
@@ -347,7 +428,9 @@ static int sunxi_spi_runtime_resume(struct device *dev)
 	}
 
 	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
-			SUNXI_CTL_ENABLE | SUNXI_CTL_MASTER | SUNXI_CTL_TP);
+			sspi_bits(sspi, SUNXI_CTL_ENABLE) |
+			sspi_bits(sspi, SUNXI_CTL_MASTER) |
+			sspi_bits(sspi, SUNXI_CTL_TP));
 
 	return 0;
 
@@ -408,6 +491,10 @@ static int sunxi_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+	sspi->fifo_depth = SUN4I_FIFO_DEPTH;
+	sspi->type = SPI_SUN4I;
+	sspi->regmap = &sun4i_regmap;
+	sspi->bitmap = &sun4i_bitmap;
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz =          3 * 1000;
 	master->set_cs = sunxi_spi_set_cs;
@@ -473,7 +560,7 @@ static int sunxi_spi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sunxi_spi_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-spi", },
+	{ .compatible = SUN4I_COMPATIBLE, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sunxi_spi_match);
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index d14a953..4215c3e 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -23,58 +23,110 @@
 
 #include <linux/spi/spi.h>
 
-#define SUNXI_FIFO_DEPTH		128
-
-#define SUNXI_GBL_CTL_REG		0x04
-#define SUNXI_CTL_ENABLE		BIT(0)
-#define SUNXI_CTL_MASTER		BIT(1)
-#define SUNXI_CTL_TP			BIT(7)
-
-#define SUNXI_TFR_CTL_REG		0x08
-#define SUNXI_TFR_CTL_CPHA		BIT(0)
-#define SUNXI_TFR_CTL_CPOL		BIT(1)
-#define SUNXI_TFR_CTL_SPOL		BIT(2)
-#define SUNXI_TFR_CTL_CS_MASK		0x30
-#define SUNXI_TFR_CTL_CS(cs)		(((cs) << 4) & SUNXI_TFR_CTL_CS_MASK)
-#define SUNXI_TFR_CTL_CS_MANUAL		BIT(6)
-#define SUNXI_TFR_CTL_CS_LEVEL		BIT(7)
-#define SUNXI_TFR_CTL_DHB		BIT(8)
-#define SUNXI_TFR_CTL_FBS		BIT(12)
-#define SUNXI_TFR_CTL_XCH		BIT(31)
-
-#define SUNXI_INT_CTL_REG		0x10
-#define SUNXI_INT_CTL_TC		BIT(12)
-
-#define SUNXI_INT_STA_REG		0x14
-
-#define SUNXI_FIFO_CTL_REG		0x18
-#define SUNXI_CTL_RF_RST		BIT(15)
-#define SUNXI_CTL_TF_RST		BIT(31)
-
-#define SUNXI_FIFO_STA_REG		0x1c
-#define SUNXI_FIFO_STA_RF_CNT_MASK	0x7f
-#define SUNXI_FIFO_STA_RF_CNT_BITS	0
-#define SUNXI_FIFO_STA_TF_CNT_MASK	0x7f
-#define SUNXI_FIFO_STA_TF_CNT_BITS	16
+#define SUN4I_FIFO_DEPTH		64
+#define SUN6I_FIFO_DEPTH		128
+
+#define SUN4I_COMPATIBLE "allwinner,sun4i-a10-spi"
+#define SUN6I_COMPATIBLE "allwinner,sun6i-a31-spi"
+
+#define SUNXI_TFR_CTL_CS(bitmap, cs)	(((cs) << \
+					  (bitmap)[SUNXI_TFR_CTL_CS_SHIFT]) \
+					 & (bitmap)[SUNXI_TFR_CTL_CS_MASK])
+
+#define SUNXI_CNT_MASK			0xffffff
+#define SUNXI_XMIT_CNT(cnt)		((cnt) & SUNXI_CNT_MASK)
+#define SUNXI_BURST_CNT(cnt)		((cnt) & SUNXI_CNT_MASK)
+#define SUNXI_BURST_CTL_CNT_STC(cnt)	((cnt) & SUNXI_CNT_MASK)
 
-#define SUNXI_CLK_CTL_REG		0x24
+#define SUNXI_CLK_CTL_DRS		BIT(12)
 #define SUNXI_CLK_CTL_CDR2_MASK		0xff
 #define SUNXI_CLK_CTL_CDR2(div)		(((div) & SUNXI_CLK_CTL_CDR2_MASK) << 0)
 #define SUNXI_CLK_CTL_CDR1_MASK		0xf
 #define SUNXI_CLK_CTL_CDR1(div)		(((div) & SUNXI_CLK_CTL_CDR1_MASK) << 8)
-#define SUNXI_CLK_CTL_DRS		BIT(12)
 
-#define SUNXI_BURST_CNT_REG		0x30
-#define SUNXI_BURST_CNT(cnt)		((cnt) & 0xffffff)
+#define SUNXI_FIFO_STA_RF_CNT_MASK	0x7f
+#define SUNXI_FIFO_STA_RF_CNT_BITS	0
+#define SUNXI_FIFO_STA_TF_CNT_MASK	0x7f
+#define SUNXI_FIFO_STA_TF_CNT_BITS	16
+
+enum SPI_SUNXI_TYPE {
+	SPI_SUN4I = 1,
+	SPI_SUN6I,
+};
 
-#define SUNXI_XMIT_CNT_REG		0x34
-#define SUNXI_XMIT_CNT(cnt)		((cnt) & 0xffffff)
+enum SUNXI_REG_ENUM {
+	SUNXI_RXDATA_REG,
+	SUNXI_TXDATA_REG,
+	SUNXI_TFR_CTL_REG,
+	SUNXI_INT_CTL_REG,
+	SUNXI_INT_STA_REG,
+	SUNXI_WAIT_REG,
+	SUNXI_CLK_CTL_REG,
+	SUNXI_BURST_CNT_REG,
+	SUNXI_XMIT_CNT_REG,
+	SUNXI_FIFO_STA_REG,
+	SUNXI_VERSION_REG,
+	SUNXI_GBL_CTL_REG,
+	SUNXI_FIFO_CTL_REG,
+	SUNXI_BURST_CTL_CNT_REG,
+	SUNXI_NUM_REGS
+};
 
-#define SUNXI_BURST_CTL_CNT_REG		0x38
-#define SUNXI_BURST_CTL_CNT_STC(cnt)	((cnt) & 0xffffff)
+static int sun6i_regmap[SUNXI_NUM_REGS] = {
+/* SUNXI_RXDATA_REG */			0x300,
+/* SUNXI_TXDATA_REG */			0x200,
+/* SUNXI_TFR_CTL_REG */			0x08,
+/* SUNXI_INT_CTL_REG */			0x10,
+/* SUNXI_INT_STA_REG */			0x14,
+/* SUNXI_WAIT_REG */			0x20,
+/* SUNXI_CLK_CTL_REG */			0x24,
+/* SUNXI_BURST_CNT_REG */		0x30,
+/* SUNXI_XMIT_CNT_REG */		0x34,
+/* SUNXI_FIFO_STA_REG */		0x1c,
+/* SUNXI_VERSION_REG */			0x00,
+/* SUNXI_GBL_CTL_REG */			0x04,
+/* SUNXI_FIFO_CTL_REG */		0x18,
+/* SUNXI_BURST_CTL_CNT_REG */		0x38,
+};
 
-#define SUNXI_TXDATA_REG		0x200
-#define SUNXI_RXDATA_REG		0x300
+enum SUNXI_BITMAP_ENUM {
+	SUNXI_CTL_ENABLE,
+	SUNXI_CTL_MASTER,
+	SUNXI_TFR_CTL_CPHA,
+	SUNXI_TFR_CTL_CPOL,
+	SUNXI_TFR_CTL_CS_ACTIVE_LOW,
+	SUNXI_TFR_CTL_FBS,
+	SUNXI_CTL_TF_RST,
+	SUNXI_CTL_RF_RST,
+	SUNXI_TFR_CTL_XCH,
+	SUNXI_TFR_CTL_CS_MASK,
+	SUNXI_TFR_CTL_CS_SHIFT,
+	SUNXI_TFR_CTL_DHB,
+	SUNXI_TFR_CTL_CS_MANUAL,
+	SUNXI_TFR_CTL_CS_LEVEL,
+	SUNXI_CTL_TP,
+	SUNXI_INT_CTL_TC,
+	SUNXI_BITMAP_SIZE
+};
+
+static int sun6i_bitmap[SUNXI_BITMAP_SIZE] = {
+/* SUNXI_CTL_ENABLE */			BIT(0),
+/* SUNXI_CTL_MASTER */			BIT(1),
+/* SUNXI_TFR_CTL_CPHA */		BIT(0),
+/* SUNXI_TFR_CTL_CPOL */		BIT(1),
+/* SUNXI_TFR_CTL_CS_ACTIVE_LOW */	BIT(2),
+/* SUNXI_TFR_CTL_FBS */			BIT(12),
+/* SUNXI_CTL_TF_RST */			BIT(31),
+/* SUNXI_CTL_RF_RST */			BIT(15),
+/* SUNXI_TFR_CTL_XCH */			BIT(31),
+/* SUNXI_TFR_CTL_CS_MASK */		0x30,
+/* SUNXI_TFR_CTL_CS_SHIFT */		4,
+/* SUNXI_TFR_CTL_DHB */			BIT(8),
+/* SUNXI_TFR_CTL_CS_MANUAL */		BIT(6),
+/* SUNXI_TFR_CTL_CS_LEVEL */		BIT(7),
+/* SUNXI_CTL_TP */			BIT(7),
+/* SUNXI_INT_CTL_TC */			BIT(12),
+};
 
 struct sunxi_spi {
 	struct spi_master	*master;
@@ -82,6 +134,10 @@ struct sunxi_spi {
 	struct clk		*hclk;
 	struct clk		*mclk;
 	struct reset_control	*rstc;
+	int			(*regmap)[SUNXI_NUM_REGS];
+	int			(*bitmap)[SUNXI_BITMAP_SIZE];
+	int			fifo_depth;
+	int			type;
 
 	struct completion	done;
 
@@ -90,14 +146,31 @@ struct sunxi_spi {
 	int			len;
 };
 
-static inline u32 sunxi_spi_read(struct sunxi_spi *sspi, u32 reg)
+static inline u32 sspi_reg(struct sunxi_spi *sspi, enum SUNXI_REG_ENUM name)
+{
+	BUG_ON((name >= SUNXI_NUM_REGS) || (name < 0) ||
+	       (*sspi->regmap)[name] < 0);
+	return (*sspi->regmap)[name];
+}
+
+static inline u32 sunxi_spi_read(struct sunxi_spi *sspi,
+				 enum SUNXI_REG_ENUM name)
 {
-	return readl(sspi->base_addr + reg);
+	return readl(sspi->base_addr + sspi_reg(sspi, name));
 }
 
-static inline void sunxi_spi_write(struct sunxi_spi *sspi, u32 reg, u32 value)
+static inline void sunxi_spi_write(struct sunxi_spi *sspi,
+				   enum SUNXI_REG_ENUM name, u32 value)
 {
-	writel(value, sspi->base_addr + reg);
+	writel(value, sspi->base_addr + sspi_reg(sspi, name));
+}
+
+static inline u32 sspi_bits(struct sunxi_spi *sspi,
+			    enum SUNXI_BITMAP_ENUM name)
+{
+	BUG_ON((name >= SUNXI_BITMAP_SIZE) || (name < 0) ||
+	       (*sspi->bitmap)[name] <= 0);
+	return (*sspi->bitmap)[name];
 }
 
 static inline void sunxi_spi_drain_fifo(struct sunxi_spi *sspi, int len)
@@ -114,7 +187,8 @@ static inline void sunxi_spi_drain_fifo(struct sunxi_spi *sspi, int len)
 		len = cnt;
 
 	while (len--) {
-		byte = readb(sspi->base_addr + SUNXI_RXDATA_REG);
+		byte = readb(sspi->base_addr +
+			     sspi_reg(sspi, SUNXI_RXDATA_REG));
 		if (sspi->rx_buf)
 			*sspi->rx_buf++ = byte;
 	}
@@ -129,7 +203,8 @@ static inline void sunxi_spi_fill_fifo(struct sunxi_spi *sspi, int len)
 
 	while (len--) {
 		byte = sspi->tx_buf ? *sspi->tx_buf++ : 0;
-		writeb(byte, sspi->base_addr + SUNXI_TXDATA_REG);
+		writeb(byte, sspi->base_addr +
+		       sspi_reg(sspi, SUNXI_TXDATA_REG));
 		sspi->len--;
 	}
 }
@@ -140,16 +215,16 @@ static void sunxi_spi_set_cs(struct spi_device *spi, bool enable)
 	u32 reg;
 
 	reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
-	reg &= ~SUNXI_TFR_CTL_CS_MASK;
-	reg |= SUNXI_TFR_CTL_CS(spi->chip_select);
+	reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CS_MASK);
+	reg |= SUNXI_TFR_CTL_CS(*sspi->bitmap, spi->chip_select);
 
 	/* We want to control the chip select manually */
-	reg |= SUNXI_TFR_CTL_CS_MANUAL;
+	reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CS_MANUAL);
 
 	if (enable)
-		reg |= SUNXI_TFR_CTL_CS_LEVEL;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CS_LEVEL);
 	else
-		reg &= ~SUNXI_TFR_CTL_CS_LEVEL;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CS_LEVEL);
 
 	/*
 	 * Even though this looks irrelevant since we are supposed to
@@ -163,16 +238,19 @@ static void sunxi_spi_set_cs(struct spi_device *spi, bool enable)
 	 * low.
 	 */
 	if (spi->mode & SPI_CS_HIGH)
-		reg &= ~SUNXI_TFR_CTL_SPOL;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CS_ACTIVE_LOW);
 	else
-		reg |= SUNXI_TFR_CTL_SPOL;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CS_ACTIVE_LOW);
 
 	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);
 }
 
 static size_t sunxi_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUNXI_FIFO_DEPTH - 1;
+	struct spi_master *master = spi->master;
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
+
+	return sspi->fifo_depth - 1;
 }
 
 static int sunxi_spi_transfer_one(struct spi_master *master,
@@ -187,8 +265,8 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUNXI_FIFO_DEPTH)
-		return -EINVAL;
+	if (tfr->len > sspi->fifo_depth)
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
@@ -202,35 +280,36 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 
 	/* Reset FIFOs */
 	sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG,
-			SUNXI_CTL_RF_RST | SUNXI_CTL_TF_RST);
+			sspi_bits(sspi, SUNXI_CTL_RF_RST) |
+			sspi_bits(sspi, SUNXI_CTL_TF_RST));
 
 	/*
 	 * Setup the transfer control register: Chip Select,
 	 * polarities, etc.
 	 */
 	if (spi->mode & SPI_CPOL)
-		reg |= SUNXI_TFR_CTL_CPOL;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CPOL);
 	else
-		reg &= ~SUNXI_TFR_CTL_CPOL;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CPOL);
 
 	if (spi->mode & SPI_CPHA)
-		reg |= SUNXI_TFR_CTL_CPHA;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_CPHA);
 	else
-		reg &= ~SUNXI_TFR_CTL_CPHA;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_CPHA);
 
 	if (spi->mode & SPI_LSB_FIRST)
-		reg |= SUNXI_TFR_CTL_FBS;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_FBS);
 	else
-		reg &= ~SUNXI_TFR_CTL_FBS;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_FBS);
 
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
 	 */
 	if (sspi->rx_buf)
-		reg &= ~SUNXI_TFR_CTL_DHB;
+		reg &= ~sspi_bits(sspi, SUNXI_TFR_CTL_DHB);
 	else
-		reg |= SUNXI_TFR_CTL_DHB;
+		reg |= sspi_bits(sspi, SUNXI_TFR_CTL_DHB);
 
 	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);
 
@@ -275,18 +354,19 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 	/* Setup the counters */
 	sunxi_spi_write(sspi, SUNXI_BURST_CNT_REG, SUNXI_BURST_CNT(tfr->len));
 	sunxi_spi_write(sspi, SUNXI_XMIT_CNT_REG, SUNXI_XMIT_CNT(tx_len));
-	sunxi_spi_write(sspi, SUNXI_BURST_CTL_CNT_REG,
-			SUNXI_BURST_CTL_CNT_STC(tx_len));
+	sunxi_spi_write(sspi, SUNXI_BURST_CTL_CNT_REG, SUNXI_BURST_CTL_CNT_STC(tx_len));
 
 	/* Fill the TX FIFO */
-	sunxi_spi_fill_fifo(sspi, SUNXI_FIFO_DEPTH);
+	sunxi_spi_fill_fifo(sspi, sspi->fifo_depth);
 
 	/* Enable the interrupts */
-	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, SUNXI_INT_CTL_TC);
+	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG,
+			sspi_bits(sspi, SUNXI_INT_CTL_TC));
 
 	/* Start the transfer */
 	reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
-	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg | SUNXI_TFR_CTL_XCH);
+	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
+			reg | sspi_bits(sspi, SUNXI_TFR_CTL_XCH));
 
 	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
 	start = jiffies;
@@ -302,7 +382,7 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sunxi_spi_drain_fifo(sspi, SUNXI_FIFO_DEPTH);
+	sunxi_spi_drain_fifo(sspi, sspi->fifo_depth);
 
 out:
 	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, 0);
@@ -316,8 +396,9 @@ static irqreturn_t sunxi_spi_handler(int irq, void *dev_id)
 	u32 status = sunxi_spi_read(sspi, SUNXI_INT_STA_REG);
 
 	/* Transfer complete */
-	if (status & SUNXI_INT_CTL_TC) {
-		sunxi_spi_write(sspi, SUNXI_INT_STA_REG, SUNXI_INT_CTL_TC);
+	if (status & sspi_bits(sspi, SUNXI_INT_CTL_TC)) {
+		sunxi_spi_write(sspi, SUNXI_INT_STA_REG,
+				sspi_bits(sspi, SUNXI_INT_CTL_TC));
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
@@ -350,7 +431,9 @@ static int sunxi_spi_runtime_resume(struct device *dev)
 	}
 
 	sunxi_spi_write(sspi, SUNXI_GBL_CTL_REG,
-			SUNXI_CTL_ENABLE | SUNXI_CTL_MASTER | SUNXI_CTL_TP);
+			sspi_bits(sspi, SUNXI_CTL_ENABLE) |
+			sspi_bits(sspi, SUNXI_CTL_MASTER) |
+			sspi_bits(sspi, SUNXI_CTL_TP));
 
 	return 0;
 
@@ -412,6 +495,10 @@ static int sunxi_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+	sspi->fifo_depth = SUN6I_FIFO_DEPTH;
+	sspi->type = SPI_SUN6I;
+	sspi->regmap = &sun6i_regmap;
+	sspi->bitmap = &sun6i_bitmap;
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz =          3 * 1000;
 	master->set_cs = sunxi_spi_set_cs;
@@ -484,7 +571,7 @@ static int sunxi_spi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sunxi_spi_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-spi", },
+	{ .compatible = SUN6I_COMPATIBLE, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sunxi_spi_match);
-- 
2.8.1
