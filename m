From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 11:38:53 +0100
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
Message-ID: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-i2c at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
---
 .../devicetree/bindings/gpio/gpio_i2c.txt          |   33 ++++++++++++
 drivers/i2c/busses/i2c-gpio.c                      |   55 +++++++++++++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_i2c.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_i2c.txt b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
new file mode 100644
index 0000000..15f288da
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
@@ -0,0 +1,33 @@
+Device-Tree bindings for i2c gpio driver
+
+Required properties:
+	- compatible = "gpio-i2c";
+	- gpios: sda and scl gpio
+
+
+Optional properties:
+	- gpio-i2c,sda_is_open_drain: sda as open drain
+	- gpio-i2c,scl_is_open_drain: scl as open drain
+	- gpio-i2c,scl_is_output_only: scl as output only
+	- udelay: half clock cycle time in us (may depend on each platform)
+	- timeout: timeout to get data
+
+
+Example nodes:
+
+i2c-gpio at 0 {
+	compatible = "gpio-i2c";
+	gpios = <&pioA 23 0 /* sda */
+		 &pioA 24 0 /* scl */
+		>;
+	gpio-i2c,sda_is_open_drain;
+	gpio-i2c,scl_is_open_drain;
+	udelay = <2>;		/* ~100 kHz */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	rv3029c2 at 56 {
+		compatible = "rv3029c2";
+		reg = <0x56>;
+	};
+};
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index a651779..6b5d794 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_i2c.h>
 
 #include <asm/gpio.h>
 
@@ -78,16 +80,51 @@ static int i2c_gpio_getscl(void *data)
 	return gpio_get_value(pdata->scl_pin);
 }
 
+static int of_i2c_gpio_probe(struct device_node *np,
+			     struct i2c_gpio_platform_data *pdata)
+{
+	u32 reg;
+
+	pdata->sda_pin = of_get_gpio(np, 0);
+	pdata->scl_pin = of_get_gpio(np, 1);
+
+	if (of_property_read_u32(np, "udelay", &reg))
+		pdata->udelay = reg;
+
+	if (of_property_read_u32(np, "timeout", &reg))
+		pdata->timeout = reg;
+
+	pdata->sda_is_open_drain =
+		!!of_get_property(np, "gpio-i2c,sda_is_open_drain", NULL);
+	pdata->scl_is_open_drain =
+		!!of_get_property(np, "gpio-i2c,scl_is_open_drain", NULL);
+	pdata->scl_is_output_only =
+		!!of_get_property(np, "gpio-i2c,scl_is_output_only", NULL);
+
+	return 0;
+}
+
 static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
 	int ret;
+	int len = sizeof(struct i2c_gpio_platform_data);
 
-	pdata = pdev->dev.platform_data;
+	pdata = kzalloc(len, GFP_KERNEL);
 	if (!pdata)
-		return -ENXIO;
+		return -ENOMEM;
+
+	if (pdev->dev.of_node) {
+		of_i2c_gpio_probe(pdev->dev.of_node, pdata);
+	} else {
+		if (!pdev->dev.platform_data) {
+			ret = -ENXIO;
+			goto err_alloc_adap;
+		}
+		memcpy(pdata, pdev->dev.platform_data, len);
+	}
 
 	ret = -ENOMEM;
 	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
@@ -143,6 +180,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 	adap->algo_data = bit_data;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	/*
 	 * If "dev->id" is negative we consider it as zero.
@@ -154,6 +192,8 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_bus;
 
+	of_i2c_register_devices(adap);
+
 	platform_set_drvdata(pdev, adap);
 
 	dev_info(&pdev->dev, "using pins %u (SDA) and %u (SCL%s)\n",
@@ -172,6 +212,7 @@ err_request_sda:
 err_alloc_bit_data:
 	kfree(adap);
 err_alloc_adap:
+	kfree(pdata);
 	return ret;
 }
 
@@ -192,10 +233,20 @@ static int __devexit i2c_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id gpio_i2c_dt_ids[] = {
+	{ .compatible = "gpio-i2c", },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, gpio_i2c_dt_ids);
+#endif
+
 static struct platform_driver i2c_gpio_driver = {
 	.driver		= {
 		.name	= "i2c-gpio",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(gpio_i2c_dt_ids),
 	},
 	.probe		= i2c_gpio_probe,
 	.remove		= __devexit_p(i2c_gpio_remove),
-- 
1.7.7
