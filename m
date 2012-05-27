From: marex@denx.de (Marek Vasut)
Date: Sun, 27 May 2012 04:10:55 +0200
Subject: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
Message-ID: <1338084656-11961-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures the I2C bus timing registers according
to information passed via DT. Currently, 100kHz and 400kHz
modes are supported.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: linux-i2c at vger.kernel.org
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    1 +
 arch/arm/boot/dts/imx28.dtsi                      |    2 +
 drivers/i2c/busses/i2c-mxs.c                      |   64 +++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
index 1bfc02d..790b5c6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Should be "fsl,<chip>-i2c"
 - reg: Should contain registers location and length
 - interrupts: Should contain ERROR and DMA interrupts
+- speed: Speed of the bus in kHz (400 or 100 are supported)
 
 Examples:
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..d927155 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -381,6 +381,7 @@
 				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 2000>;
 				interrupts = <111 68>;
+				fsl,speed = <400>;
 				status = "disabled";
 			};
 
@@ -390,6 +391,7 @@
 				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 2000>;
 				interrupts = <110 69>;
+				fsl,speed = <400>;
 				status = "disabled";
 			};
 
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 04eb441..fff0a09 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -46,6 +46,10 @@
 #define MXS_I2C_CTRL0_DIRECTION			0x00010000
 #define MXS_I2C_CTRL0_XFER_COUNT(v)		((v) & 0x0000FFFF)
 
+#define MXS_I2C_TIMING0		(0x10)
+#define MXS_I2C_TIMING1		(0x20)
+#define MXS_I2C_TIMING2		(0x30)
+
 #define MXS_I2C_CTRL1		(0x40)
 #define MXS_I2C_CTRL1_SET	(0x44)
 #define MXS_I2C_CTRL1_CLR	(0x48)
@@ -97,6 +101,24 @@
 #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
 				 MXS_I2C_CTRL0_MASTER_MODE)
 
+struct mxs_i2c_speed_config {
+	uint32_t	timing0;
+	uint32_t	timing1;
+	uint32_t	timing2;
+};
+
+const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
+	.timing0	= 0x00780030,
+	.timing1	= 0x00800030,
+	.timing2	= 0x0015000d,
+};
+
+const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
+	.timing0	= 0x000f0007,
+	.timing1	= 0x001f000f,
+	.timing2	= 0x0015000d,
+};
+
 /**
  * struct mxs_i2c_dev - per device, private MXS-I2C data
  *
@@ -112,11 +134,17 @@ struct mxs_i2c_dev {
 	struct completion cmd_complete;
 	u32 cmd_err;
 	struct i2c_adapter adapter;
+	const struct mxs_i2c_speed_config *speed;
 };
 
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 {
 	stmp_reset_block(i2c->regs);
+
+	writel(i2c->speed->timing0, i2c->regs + MXS_I2C_TIMING0);
+	writel(i2c->speed->timing1, i2c->regs + MXS_I2C_TIMING1);
+	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
+
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
 	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
@@ -319,6 +347,38 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 	.functionality = mxs_i2c_func,
 };
 
+#ifdef CONFIG_OF
+static int mxs_i2c_get_ofdata(struct platform_device *pdev,
+				struct mxs_i2c_dev *i2c)
+{
+	const __be32 *speed;
+	uint32_t speed_khz;
+	struct device_node *node = pdev->dev.of_node;
+
+	if (!node)
+		return -EINVAL;
+
+	i2c->speed = &mxs_i2c_95kHz_config;
+	speed = of_get_property(node, "fsl,speed", NULL);
+	if (!speed)
+		dev_warn(&pdev->dev,
+			"No I2C speed selected, using 100kHz\n");
+
+	speed_khz = be32_to_cpup(speed);
+	if (speed_khz == 400)
+		i2c->speed = &mxs_i2c_400kHz_config;
+	else if (speed_khz != 100)
+		dev_warn(&pdev->dev,
+			"Invalid I2C speed selected, using 100kHz\n");
+
+	return 0;
+}
+#else
+static int mxs_i2c_get_ofdata(struct platform_device *pdev,
+				struct mxs_i2c_dev *i2c)
+{ }
+#endif /* CONFIG_OF */
+
 static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -357,6 +417,10 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = mxs_i2c_get_ofdata(pdev, i2c);
+	if (err)
+		return err;
+
 	i2c->dev = dev;
 	platform_set_drvdata(pdev, i2c);
 
-- 
1.7.10
