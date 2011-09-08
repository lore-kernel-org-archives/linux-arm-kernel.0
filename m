From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 8 Sep 2011 15:09:35 +0800
Subject: [PATCH REPOST 2/2] i2c-imx: add device tree probe support
In-Reply-To: <1315465775-31335-1-git-send-email-shawn.guo@linaro.org>
References: <1315465775-31335-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1315465775-31335-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for i2c-imx driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   25 ++++++++++++++++++++
 drivers/i2c/busses/i2c-imx.c                       |   25 +++++++++++++++----
 2 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt b/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
new file mode 100644
index 0000000..f3cf43b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
@@ -0,0 +1,25 @@
+* Freescale Inter IC (I2C) and High Speed Inter IC (HS-I2C) for i.MX
+
+Required properties:
+- compatible : Should be "fsl,<chip>-i2c"
+- reg : Should contain I2C/HS-I2C registers location and length
+- interrupts : Should contain I2C/HS-I2C interrupt
+
+Optional properties:
+- clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
+  The absence of the propoerty indicates the default frequency 100 kHz.
+
+Examples:
+
+i2c at 83fc4000 { /* I2C2 on i.MX51 */
+	compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+	reg = <0x83fc4000 0x4000>;
+	interrupts = <63>;
+};
+
+i2c at 70038000 { /* HS-I2C on i.MX51 */
+	compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+	reg = <0x70038000 0x4000>;
+	interrupts = <64>;
+	clock-frequency = <400000>;
+};
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 54d809e..58832e5 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -48,6 +48,9 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_i2c.h>
 
 #include <mach/irqs.h>
 #include <mach/hardware.h>
@@ -125,6 +128,11 @@ struct imx_i2c_struct {
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
 };
 
+static const struct of_device_id i2c_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx1-i2c", },
+	{ /* sentinel */ }
+};
+
 /** Functions for IMX I2C adapter driver ***************************************
 *******************************************************************************/
 
@@ -469,7 +477,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
 	void __iomem *base;
 	resource_size_t res_size;
-	int irq;
+	int irq, bitrate;
 	int ret;
 
 	dev_dbg(&pdev->dev, "<%s>\n", __func__);
@@ -512,6 +520,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.algo		= &i2c_imx_algo;
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
 	i2c_imx->adapter.nr 		= pdev->id;
+	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
 	i2c_imx->irq			= irq;
 	i2c_imx->base			= base;
 	i2c_imx->res			= res;
@@ -538,10 +547,12 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
 
 	/* Set up clock divider */
-	if (pdata && pdata->bitrate)
-		i2c_imx_set_clk(i2c_imx, pdata->bitrate);
-	else
-		i2c_imx_set_clk(i2c_imx, IMX_I2C_BIT_RATE);
+	bitrate = IMX_I2C_BIT_RATE;
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   "clock-frequency", &bitrate);
+	if (ret < 0 && pdata && pdata->bitrate)
+		bitrate = pdata->bitrate;
+	i2c_imx_set_clk(i2c_imx, bitrate);
 
 	/* Set up chip registers to defaults */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
@@ -554,6 +565,8 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 		goto fail5;
 	}
 
+	of_i2c_register_devices(&i2c_imx->adapter);
+
 	/* Set up platform driver data */
 	platform_set_drvdata(pdev, i2c_imx);
 
@@ -584,7 +597,6 @@ fail1:
 static int __exit i2c_imx_remove(struct platform_device *pdev)
 {
 	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
-	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
 
 	/* remove adapter */
 	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
@@ -613,6 +625,7 @@ static struct platform_driver i2c_imx_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = i2c_imx_dt_ids,
 	}
 };
 
-- 
1.7.4.1
