From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Mon, 28 Apr 2014 14:29:58 +0530
Subject: [PATCH] i2c: exynos5: add support for HSI2C on Exynos5260 SoC
Message-ID: <1398675598-25991-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HSI2C module on Exynos5260 differs from current modules in
following ways:
1.  HSI2C on Exynos5260 has fifo_depth of 16bytes
2.  Module needs to be reset as a part of init sequence.

Hence, Following changes are involved.
1. Add a new compatible string and Updates the Documentation dt bindings.
2. Introduce a variant struct to support the changes in H/W
3. Reset the module during init. Thus, bringing the module back
to default state irrespective of what firmware did with it.

Signed-off-by: Naveen Krishna Chatradhi <ich.naveen@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
This patch is under review at https://lkml.org/lkml/2014/2/6/590
and https://lkml.org/lkml/2014/2/6/151

As per Wolfram's comments, both the patches were squashed here.

 .../devicetree/bindings/i2c/i2c-exynos5.txt        |   11 +++-
 drivers/i2c/busses/i2c-exynos5.c                   |   67 ++++++++++++++++----
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt b/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
index 056732c..d4745e3 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
@@ -5,7 +5,14 @@ at various speeds ranging from 100khz to 3.4Mhz.
 
 Required properties:
   - compatible: value should be.
-      -> "samsung,exynos5-hsi2c", for i2c compatible with exynos5 hsi2c.
+	-> "samsung,exynos5-hsi2c", (DEPRECATED)
+				for i2c compatible with HSI2C available
+				on Exynos5250 and Exynos5420 SoCs.
+	-> "samsung,exynos5250-hsi2c", for i2c compatible with HSI2C available
+				on Exynos5250 and Exynos5420 SoCs.
+	-> "samsung,exynos5260-hsi2c", for i2c compatible with HSI2C available
+				on Exynos5260 SoCs.
+
   - reg: physical base address of the controller and length of memory mapped
     region.
   - interrupts: interrupt number to the cpu.
@@ -26,7 +33,7 @@ Optional properties:
 Example:
 
 hsi2c at 12ca0000 {
-	compatible = "samsung,exynos5-hsi2c";
+	compatible = "samsung,exynos5250-hsi2c";
 	reg = <0x12ca0000 0x100>;
 	interrupts = <56>;
 	clock-frequency = <100000>;
diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 00af0a0..043d6d8 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -76,12 +76,6 @@
 #define HSI2C_RXFIFO_TRIGGER_LEVEL(x)		((x) << 4)
 #define HSI2C_TXFIFO_TRIGGER_LEVEL(x)		((x) << 16)
 
-/* As per user manual FIFO max depth is 64bytes */
-#define HSI2C_FIFO_MAX				0x40
-/* default trigger levels for Tx and Rx FIFOs */
-#define HSI2C_DEF_TXFIFO_LVL			(HSI2C_FIFO_MAX - 0x30)
-#define HSI2C_DEF_RXFIFO_LVL			(HSI2C_FIFO_MAX - 0x10)
-
 /* I2C_TRAILING_CTL Register bits */
 #define HSI2C_TRAILING_COUNT			(0xf)
 
@@ -183,14 +177,54 @@ struct exynos5_i2c {
 	 * 2. Fast speed upto 1Mbps
 	 */
 	int			speed_mode;
+
+	/* Version of HS-I2C Hardware */
+	struct exynos_hsi2c_variant	*variant;
+};
+
+/**
+ * struct exynos_hsi2c_variant - platform specific HSI2C driver data
+ * @fifo_depth: the fifo depth supported by the HSI2C module
+ *
+ * Specifies platform specific configuration of HSI2C module.
+ * Note: A structure for driver specific platform data is used for future
+ * expansion of its usage.
+ */
+struct exynos_hsi2c_variant {
+	unsigned int	fifo_depth;
+};
+
+static const struct exynos_hsi2c_variant exynos5250_hsi2c_data = {
+	.fifo_depth	= 64,
+};
+
+static const struct exynos_hsi2c_variant exynos5260_hsi2c_data = {
+	.fifo_depth	= 16,
 };
 
 static const struct of_device_id exynos5_i2c_match[] = {
-	{ .compatible = "samsung,exynos5-hsi2c" },
-	{},
+	{
+		.compatible = "samsung,exynos5-hsi2c",
+		.data = &exynos5250_hsi2c_data
+	}, {
+		.compatible = "samsung,exynos5250-hsi2c",
+		.data = &exynos5250_hsi2c_data
+	}, {
+		.compatible = "samsung,exynos5260-hsi2c",
+		.data = &exynos5260_hsi2c_data
+	}, {},
 };
 MODULE_DEVICE_TABLE(of, exynos5_i2c_match);
 
+static inline struct exynos_hsi2c_variant *exynos5_i2c_get_variant
+					(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+
+	match = of_match_node(exynos5_i2c_match, pdev->dev.of_node);
+	return (struct exynos_hsi2c_variant *)match->data;
+}
+
 static void exynos5_i2c_clr_pend_irq(struct exynos5_i2c *i2c)
 {
 	writel(readl(i2c->regs + HSI2C_INT_STATUS),
@@ -415,7 +449,7 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 		fifo_status = readl(i2c->regs + HSI2C_FIFO_STATUS);
 		fifo_level = HSI2C_TX_FIFO_LVL(fifo_status);
 
-		len = HSI2C_FIFO_MAX - fifo_level;
+		len = i2c->variant->fifo_depth - fifo_level;
 		if (len > (i2c->msg->len - i2c->msg_ptr))
 			len = i2c->msg->len - i2c->msg_ptr;
 
@@ -483,6 +517,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	u32 i2c_auto_conf = 0;
 	u32 fifo_ctl;
 	unsigned long flags;
+	unsigned short trig_lvl;
 
 	i2c_ctl = readl(i2c->regs + HSI2C_CTL);
 	i2c_ctl &= ~(HSI2C_TXCHON | HSI2C_RXCHON);
@@ -493,13 +528,19 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 
 		i2c_auto_conf = HSI2C_READ_WRITE;
 
-		fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(HSI2C_DEF_TXFIFO_LVL);
+		trig_lvl = (i2c->msg->len > i2c->variant->fifo_depth) ?
+			(i2c->variant->fifo_depth * 3/4) : i2c->msg->len;
+		fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(trig_lvl);
+
 		int_en |= (HSI2C_INT_RX_ALMOSTFULL_EN |
 			HSI2C_INT_TRAILING_EN);
 	} else {
 		i2c_ctl |= HSI2C_TXCHON;
 
-		fifo_ctl |= HSI2C_TXFIFO_TRIGGER_LEVEL(HSI2C_DEF_RXFIFO_LVL);
+		trig_lvl = (i2c->msg->len > i2c->variant->fifo_depth) ?
+			(i2c->variant->fifo_depth * 1/4) : i2c->msg->len;
+		fifo_ctl |= HSI2C_TXFIFO_TRIGGER_LEVEL(trig_lvl);
+
 		int_en |= HSI2C_INT_TX_ALMOSTEMPTY_EN;
 	}
 
@@ -691,7 +732,9 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	exynos5_i2c_init(i2c);
+	i2c->variant = exynos5_i2c_get_variant(pdev);
+
+	exynos5_i2c_reset(i2c);
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
-- 
1.7.9.5
