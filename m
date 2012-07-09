From: marex@denx.de (Marek Vasut)
Date: Mon,  9 Jul 2012 18:22:53 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Message-ID: <1341850974-11977-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures the I2C bus timing registers according
to information passed via DT. Currently, 100kHz and 400kHz
modes are supported.

The TIMING2 register value is wrong in the documentation for
i.MX28! This was found and fixed by:
  Shawn Guo <shawn.guo@linaro.org>

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
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    3 +
 arch/arm/boot/dts/imx28.dtsi                      |    2 +
 drivers/i2c/busses/i2c-mxs.c                      |   66 +++++++++++++++++++++
 3 files changed, 71 insertions(+)

V2: Fixed static const struct mxs_i2c_speed_config
V3: Use 100kHz by default
    Document support only for 100kHz and 400kHz
    Document why the bus is configured to 95kHz instead of 100kHz
    Replace "Invalid speed ..." message with "Unsupported speed ..." message

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
index 1bfc02d..30ac3a0 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
@@ -4,6 +4,8 @@ Required properties:
 - compatible: Should be "fsl,<chip>-i2c"
 - reg: Should contain registers location and length
 - interrupts: Should contain ERROR and DMA interrupts
+- clock-frequency: Desired I2C bus clock frequency in Hz.
+                   Only 100000Hz and 400000Hz modes are supported.
 
 Examples:
 
@@ -13,4 +15,5 @@ i2c0: i2c at 80058000 {
 	compatible = "fsl,imx28-i2c";
 	reg = <0x80058000 2000>;
 	interrupts = <111 68>;
+	clock-frequency = <100000>;
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index adb5ffc..e2e9a2b 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -586,6 +586,7 @@
 				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 2000>;
 				interrupts = <111 68>;
+				clock-frequency = <100000>;
 				status = "disabled";
 			};
 
@@ -595,6 +596,7 @@
 				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 2000>;
 				interrupts = <110 69>;
+				clock-frequency = <100000>;
 				status = "disabled";
 			};
 
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 04eb441..877b169 100644
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
@@ -97,6 +101,35 @@
 #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
 				 MXS_I2C_CTRL0_MASTER_MODE)
 
+struct mxs_i2c_speed_config {
+	uint32_t	timing0;
+	uint32_t	timing1;
+	uint32_t	timing2;
+};
+
+/*
+ * Timing values for the default 24MHz clock supplied into the i2c block.
+ *
+ * The bus can operate at 95kHz or at 400kHz with the following timing
+ * register configurations. The 100kHz mode isn't present because it's
+ * values are not stated in the i.MX233/i.MX28 datasheet. The 95kHz mode
+ * shall be close enough replacement. Therefore when the bus is configured
+ * for 100kHz operation, 95kHz timing settings are actually loaded.
+ *
+ * For details, see i.MX233 [25.4.2 - 25.4.4] and i.MX28 [27.5.2 - 27.5.4].
+ */
+static const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
+	.timing0	= 0x00780030,
+	.timing1	= 0x00800030,
+	.timing2	= 0x00300030,
+};
+
+static const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
+	.timing0	= 0x000f0007,
+	.timing1	= 0x001f000f,
+	.timing2	= 0x00300030,
+};
+
 /**
  * struct mxs_i2c_dev - per device, private MXS-I2C data
  *
@@ -112,11 +145,17 @@ struct mxs_i2c_dev {
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
@@ -319,6 +358,28 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 	.functionality = mxs_i2c_func,
 };
 
+static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
+{
+	uint32_t speed;
+	struct device *dev = i2c->dev;
+	struct device_node *node = dev->of_node;
+	int ret;
+
+	if (!node)
+		return -EINVAL;
+
+	i2c->speed = &mxs_i2c_95kHz_config;
+	ret = of_property_read_u32(node, "clock-frequency", &speed);
+	if (ret)
+		dev_warn(dev, "No I2C speed selected, using 100kHz\n");
+	else if (speed == 400000)
+		i2c->speed = &mxs_i2c_400kHz_config;
+	else if (speed != 100000)
+		dev_warn(dev, "Unsupported I2C speed selected, using 100kHz\n");
+
+	return 0;
+}
+
 static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -358,6 +419,11 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 		return err;
 
 	i2c->dev = dev;
+
+	err = mxs_i2c_get_ofdata(i2c);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, i2c);
 
 	/* Do reset to enforce correct startup after pinmuxing */
-- 
1.7.10.4
