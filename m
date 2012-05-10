From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 15:31:02 +0800
Subject: [PATCH 1/2] i2c: mxs: add device tree probe support
In-Reply-To: <1336635063-11122-1-git-send-email-shawn.guo@linaro.org>
References: <1336635063-11122-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336635063-11122-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree probe support for i2c-mxs driver.  So far, it's only
been tested on imx28.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt |   16 ++++++++++++++++
 drivers/i2c/busses/i2c-mxs.c                      |   13 +++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mxs.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
new file mode 100644
index 0000000..1bfc02d
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
@@ -0,0 +1,16 @@
+* Freescale MXS Inter IC (I2C) Controller
+
+Required properties:
+- compatible: Should be "fsl,<chip>-i2c"
+- reg: Should contain registers location and length
+- interrupts: Should contain ERROR and DMA interrupts
+
+Examples:
+
+i2c0: i2c at 80058000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,imx28-i2c";
+	reg = <0x80058000 2000>;
+	interrupts = <111 68>;
+};
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index d7b1046..cdbda7c 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -28,6 +28,9 @@
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/stmp_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_i2c.h>
 
 #define DRIVER_NAME "mxs-i2c"
 
@@ -364,6 +367,7 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	adap->algo = &mxs_i2c_algo;
 	adap->dev.parent = dev;
 	adap->nr = pdev->id;
+	adap->dev.of_node = pdev->dev.of_node;
 	i2c_set_adapdata(adap, i2c);
 	err = i2c_add_numbered_adapter(adap);
 	if (err) {
@@ -373,6 +377,8 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	of_i2c_register_devices(adap);
+
 	return 0;
 }
 
@@ -394,10 +400,17 @@ static int __devexit mxs_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id mxs_i2c_dt_ids[] = {
+	{ .compatible = "fsl,imx28-i2c", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_i2c_dt_ids);
+
 static struct platform_driver mxs_i2c_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
+		   .of_match_table = mxs_i2c_dt_ids,
 		   },
 	.remove = __devexit_p(mxs_i2c_remove),
 };
-- 
1.7.5.4
