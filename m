From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 07 Feb 2014 10:12:51 +0530
Subject: [PATCH 1/2 v4] i2c: exynos5: add support for HSI2C on Exynos5260 SoC
In-Reply-To: <1385100726-32165-1-git-send-email-ch.naveen@samsung.com>
References: <1385100726-32165-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1391748171-12451-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new compatible and uses variant struct to support
HSI2C module on Exynos5260. Updates the Documentation dt bindings.
Also resets the module as an init sequence (Needed by Exynos5260).

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
Changes since v3:
1. split patches as (v1 version does)
   add exynso5260 suppport and handle fifo depths
2. keep the old - compatible = "samsung,exynos5-hsi2c";
   mark it as (DEPRECATED)

 .../devicetree/bindings/i2c/i2c-exynos5.txt        |   11 ++++-
 drivers/i2c/busses/i2c-exynos5.c                   |   46 ++++++++++++++++++--
 2 files changed, 52 insertions(+), 5 deletions(-)

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
index 9fd711c..12730d1 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -183,14 +183,54 @@ struct exynos5_i2c {
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
+	unsigned int		    fifo_depth;
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
+		.compatible = "samsung,exynos5-hsi2c"
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
@@ -691,7 +731,7 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	exynos5_i2c_init(i2c);
+	exynos5_i2c_reset(i2c);
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
-- 
1.7.9.5
