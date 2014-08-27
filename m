From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 27 Aug 2014 15:15:39 +0530
Subject: [PATCH 07/14] i2c: exynos: add support for HSI2C module on Exynos7
Message-ID: <1409132740-1954-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HSI2C module on Exynos7 differs in the transfer status
bits. Transfer status bits were moved to INT_ENABLE and
INT_STATUS registers

This patch adds support for the HSI2C module on Exynos7.
1. Implementes a "hw" field in the variant struct to distinguish
   the hardware.
2. Updates the dt-new compatible in dt-binding documenation

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-i2c at vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 .../devicetree/bindings/i2c/i2c-exynos5.txt        |    2 +
 drivers/i2c/busses/i2c-exynos5.c                   |   71 ++++++++++++++++++--
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt b/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
index d4745e3..2dbc0b6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
@@ -12,6 +12,8 @@ Required properties:
 				on Exynos5250 and Exynos5420 SoCs.
 	-> "samsung,exynos5260-hsi2c", for i2c compatible with HSI2C available
 				on Exynos5260 SoCs.
+	-> "samsung,exynos7-hsi2c", for i2c compatible with HSI2C available
+				on Exynos7 SoCs.
 
   - reg: physical base address of the controller and length of memory mapped
     region.
diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 28073f1..81e6263 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -83,7 +83,6 @@
 #define HSI2C_INT_TX_ALMOSTEMPTY_EN		(1u << 0)
 #define HSI2C_INT_RX_ALMOSTFULL_EN		(1u << 1)
 #define HSI2C_INT_TRAILING_EN			(1u << 6)
-#define HSI2C_INT_I2C_EN			(1u << 9)
 
 /* I2C_INT_STAT Register bits */
 #define HSI2C_INT_TX_ALMOSTEMPTY		(1u << 0)
@@ -95,6 +94,17 @@
 #define HSI2C_INT_TRAILING			(1u << 6)
 #define HSI2C_INT_I2C				(1u << 9)
 
+#define HSI2C_INT_TRANS_DONE			(1u << 7)
+#define HSI2C_INT_TRANS_ABORT			(1u << 8)
+#define HSI2C_INT_NO_DEV_ACK			(1u << 9)
+#define HSI2C_INT_NO_DEV			(1u << 10)
+#define HSI2C_INT_TIMEOUT			(1u << 11)
+#define HSI2C_INT_I2C_TRANS			(HSI2C_INT_TRANS_DONE |	\
+						HSI2C_INT_TRANS_ABORT |	\
+						HSI2C_INT_NO_DEV_ACK |	\
+						HSI2C_INT_NO_DEV |	\
+						HSI2C_INT_TIMEOUT)
+
 /* I2C_FIFO_STAT Register bits */
 #define HSI2C_RX_FIFO_EMPTY			(1u << 24)
 #define HSI2C_RX_FIFO_FULL			(1u << 23)
@@ -143,6 +153,8 @@
 
 #define EXYNOS5_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
+#define HSI2C_EXYNOS7	BIT(0)
+
 struct exynos5_i2c {
 	struct i2c_adapter	adap;
 	unsigned int		suspended:1;
@@ -192,6 +204,7 @@ struct exynos5_i2c {
  */
 struct exynos_hsi2c_variant {
 	unsigned int	fifo_depth;
+	unsigned int	hw;
 };
 
 static const struct exynos_hsi2c_variant exynos5250_hsi2c_data = {
@@ -202,6 +215,11 @@ static const struct exynos_hsi2c_variant exynos5260_hsi2c_data = {
 	.fifo_depth	= 16,
 };
 
+static const struct exynos_hsi2c_variant exynos7_hsi2c_data = {
+	.fifo_depth	= 16,
+	.hw		= HSI2C_EXYNOS7,
+};
+
 static const struct of_device_id exynos5_i2c_match[] = {
 	{
 		.compatible = "samsung,exynos5-hsi2c",
@@ -212,6 +230,9 @@ static const struct of_device_id exynos5_i2c_match[] = {
 	}, {
 		.compatible = "samsung,exynos5260-hsi2c",
 		.data = &exynos5260_hsi2c_data
+	}, {
+		.compatible = "samsung,exynos7-hsi2c",
+		.data = &exynos7_hsi2c_data
 	}, {},
 };
 MODULE_DEVICE_TABLE(of, exynos5_i2c_match);
@@ -256,13 +277,24 @@ static int exynos5_i2c_set_timing(struct exynos5_i2c *i2c, int mode)
 				i2c->hs_clock : i2c->fs_clock;
 
 	/*
+	 * In case of HSI2C controller in Exynos5 series
 	 * FPCLK / FI2C =
 	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + 2 * FLT_CYCLE
+	 *
+	 * In case of HSI2C controllers in Exynos7 series
+	 * FPCLK / FI2C =
+	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + FLT_CYCLE
+	 *
 	 * utemp0 = (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2)
 	 * utemp1 = (TSCLK_L + TSCLK_H + 2)
 	 */
 	t_ftl_cycle = (readl(i2c->regs + HSI2C_CONF) >> 16) & 0x7;
-	utemp0 = (clkin / op_clk) - 8 - 2 * t_ftl_cycle;
+	utemp0 = (clkin / op_clk) - 8;
+
+	if (i2c->variant->hw == HSI2C_EXYNOS7)
+		utemp0 -= t_ftl_cycle;
+	else
+		utemp0 -= 2 * t_ftl_cycle;
 
 	/* CLK_DIV max is 256 */
 	for (div = 0; div < 256; div++) {
@@ -407,7 +439,28 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
 
 	/* handle interrupt related to the transfer status */
-	if (int_status & HSI2C_INT_I2C) {
+	if (i2c->variant->hw == HSI2C_EXYNOS7) {
+		if (int_status & HSI2C_INT_TRANS_DONE) {
+			i2c->trans_done = 1;
+			i2c->state = 0;
+		} else if (int_status & HSI2C_INT_TRANS_ABORT) {
+			dev_dbg(i2c->dev, "Deal with arbitration lose\n");
+			i2c->state = -EAGAIN;
+			goto stop;
+		} else if (int_status & HSI2C_INT_NO_DEV_ACK) {
+			dev_dbg(i2c->dev, "No ACK from device\n");
+			i2c->state = -ENXIO;
+			goto stop;
+		} else if (int_status & HSI2C_INT_NO_DEV) {
+			dev_dbg(i2c->dev, "No device\n");
+			i2c->state = -ENXIO;
+			goto stop;
+		} else if (int_status & HSI2C_INT_TIMEOUT) {
+			dev_dbg(i2c->dev, "Accessing device timed out\n");
+			i2c->state = -EAGAIN;
+			goto stop;
+		}
+	} else if (int_status & HSI2C_INT_I2C) {
 		trans_status = readl(i2c->regs + HSI2C_TRANS_STATUS);
 		if (trans_status & HSI2C_NO_DEV_ACK) {
 			dev_dbg(i2c->dev, "No ACK from device\n");
@@ -512,12 +565,17 @@ static int exynos5_i2c_wait_bus_idle(struct exynos5_i2c *i2c)
 static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 {
 	u32 i2c_ctl;
-	u32 int_en = HSI2C_INT_I2C_EN;
+	u32 int_en = 0;
 	u32 i2c_auto_conf = 0;
 	u32 fifo_ctl;
 	unsigned long flags;
 	unsigned short trig_lvl;
 
+	if (i2c->variant->hw == HSI2C_EXYNOS7)
+		int_en |= HSI2C_INT_I2C_TRANS;
+	else
+		int_en |= HSI2C_INT_I2C;
+
 	i2c_ctl = readl(i2c->regs + HSI2C_CTL);
 	i2c_ctl &= ~(HSI2C_TXCHON | HSI2C_RXCHON);
 	fifo_ctl = HSI2C_RXFIFO_EN | HSI2C_TXFIFO_EN;
@@ -724,12 +782,13 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
+	/* Need to check the variant before setting up. */
+	i2c->variant = exynos5_i2c_get_variant(pdev);
+
 	ret = exynos5_hsi2c_clock_setup(i2c);
 	if (ret)
 		goto err_clk;
 
-	i2c->variant = exynos5_i2c_get_variant(pdev);
-
 	exynos5_i2c_reset(i2c);
 
 	ret = i2c_add_adapter(&i2c->adap);
-- 
1.7.9.5
