From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 13 Sep 2011 09:46:05 +0530
Subject: [PATCH v3 2/2] i2c: s3c2410: Add device tree support
In-Reply-To: <1315887365-30532-2-git-send-email-thomas.abraham@linaro.org>
References: <1315887365-30532-1-git-send-email-thomas.abraham@linaro.org>
	<1315887365-30532-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1315887365-30532-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree probe support for Samsung's s3c2410 i2c driver.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/i2c/samsung-i2c.txt        |   39 +++++++
 drivers/i2c/busses/i2c-s3c2410.c                   |  110 +++++++++++++++++++-
 2 files changed, 145 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/samsung-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/samsung-i2c.txt b/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
new file mode 100644
index 0000000..d04186d
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
@@ -0,0 +1,39 @@
+* Samsung's I2C controller
+
+The Samsung's I2C controller is used to interface with I2C devices.
+
+Required properties:
+  - compatible: value should be either of the following.
+      (a) "samsung, s3c2410-i2c", for i2c compatible with s3c2410 i2c.
+      (b) "samsung, s3c2440-i2c", for i2c compatible with s3c2440 i2c.
+  - reg: physical base address of the controller and length of memory mapped
+    region.
+  - interrupts: interrupt number to the cpu.
+  - samsung,i2c-sda-delay: Delay (in ns) applied to data line (SDA) edges.
+  - gpios: The order of the gpios should be the following: <SDA, SCL>.
+    The gpio specifier depends on the gpio controller.
+
+Optional properties:
+  - samsung,i2c-slave-addr: Slave address in multi-master enviroment. If not
+    specified, default value is 0.
+  - samsung,i2c-max-bus-freq: Desired frequency in Hz of the bus. If not
+    specified, the default value in Hz is 100000.
+
+Example:
+
+	i2c at 13870000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13870000 0x100>;
+		interrupts = <345>;
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <100000>;
+		gpios = <&gpd1 2 0 /* SDA */
+			 &gpd1 3 0 /* SCL */>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		wm8994 at 1a {
+			compatible = "wlf,wm8994";
+			reg = <0x1a>;
+		};
+	};
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 266dd83..aaeabf9 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -35,6 +35,8 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of_i2c.h>
+#include <linux/of_gpio.h>
 
 #include <asm/irq.h>
 
@@ -79,6 +81,7 @@ struct s3c24xx_i2c {
 	struct i2c_adapter	adap;
 
 	struct s3c2410_platform_i2c	*pdata;
+	int			gpios[2];
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
@@ -96,6 +99,12 @@ static inline int s3c24xx_i2c_is2440(struct s3c24xx_i2c *i2c)
 	struct platform_device *pdev = to_platform_device(i2c->dev);
 	enum s3c24xx_i2c_type type;
 
+#ifdef CONFIG_OF
+	if (i2c->dev->of_node)
+		return of_device_is_compatible(i2c->dev->of_node,
+				"samsung,s3c2440-i2c");
+#endif
+
 	type = platform_get_device_id(pdev)->driver_data;
 	return type == TYPE_S3C2440;
 }
@@ -742,6 +751,49 @@ static inline void s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c)
 }
 #endif
 
+#ifdef CONFIG_OF
+static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
+{
+	int idx, gpio, ret;
+
+	for (idx = 0; idx < 2; idx++) {
+		gpio = of_get_gpio(i2c->dev->of_node, idx);
+		if (!gpio_is_valid(gpio)) {
+			dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
+			goto free_gpio;
+		}
+
+		ret = gpio_request(gpio, "i2c-bus");
+		if (ret) {
+			dev_err(i2c->dev, "gpio [%d] request failed\n", gpio);
+			goto free_gpio;
+		}
+	}
+	return 0;
+
+free_gpio:
+	while (--idx >= 0)
+		gpio_free(i2c->gpios[idx]);
+	return -EINVAL;
+}
+
+static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
+{
+	unsigned int idx;
+	for (idx = 0; idx < 2; idx++)
+		gpio_free(i2c->gpios[idx]);
+}
+#else
+static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
+{
+	return -EINVAL;
+}
+
+static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
+{
+}
+#endif
+
 /* s3c24xx_i2c_init
  *
  * initialise the controller, set the IO lines and frequency
@@ -761,6 +813,9 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 	if (pdata->cfg_gpio)
 		pdata->cfg_gpio(to_platform_device(i2c->dev));
+	else
+		if (s3c24xx_i2c_parse_dt_gpio(i2c))
+			return -EINVAL;
 
 	/* write slave address */
 
@@ -786,6 +841,34 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+/* s3c24xx_i2c_parse_dt
+ *
+ * Parse the device tree node and retreive the platform data.
+*/
+
+static void
+s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
+{
+	struct s3c2410_platform_i2c *pdata = i2c->pdata;
+
+	if (!np)
+		return;
+
+	pdata->bus_num = -1; /* i2c bus number is dynamically assigned */
+	of_property_read_u32(np, "samsung,i2c-sda-delay", &pdata->sda_delay);
+	of_property_read_u32(np, "samsung,i2c-slave-addr", &pdata->slave_addr);
+	of_property_read_u32(np, "samsung,i2c-max-bus-freq",
+				(u32 *)&pdata->frequency);
+}
+#else
+static void
+s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
+{
+	return;
+}
+#endif
+
 /* s3c24xx_i2c_probe
  *
  * called by the bus driver when a suitable device is found
@@ -798,10 +881,12 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
+	if (!pdev->dev.of_node) {
+		pdata = pdev->dev.platform_data;
+		if (!pdata) {
+			dev_err(&pdev->dev, "no platform data\n");
+			return -EINVAL;
+		}
 	}
 
 	i2c = kzalloc(sizeof(struct s3c24xx_i2c), GFP_KERNEL);
@@ -818,6 +903,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 
 	if (pdata)
 		memcpy(i2c->pdata, pdata, sizeof(*pdata));
+	else
+		s3c24xx_i2c_parse_dt(pdev->dev.of_node, i2c);
 
 	strlcpy(i2c->adap.name, "s3c2410-i2c", sizeof(i2c->adap.name));
 	i2c->adap.owner   = THIS_MODULE;
@@ -914,6 +1001,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	 */
 
 	i2c->adap.nr = i2c->pdata->bus_num;
+	i2c->adap.dev.of_node = pdev->dev.of_node;
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
@@ -921,6 +1009,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		goto err_cpufreq;
 	}
 
+	of_i2c_register_devices(&i2c->adap);
 	platform_set_drvdata(pdev, i2c);
 
 	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev));
@@ -969,6 +1058,7 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 	iounmap(i2c->regs);
 
 	release_resource(i2c->ioarea);
+	s3c24xx_i2c_dt_gpio_free(i2c);
 	kfree(i2c->ioarea);
 	kfree(i2c);
 
@@ -1022,6 +1112,17 @@ static struct platform_device_id s3c24xx_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c24xx_i2c_match[] = {
+	{ .compatible = "samsung,s3c2410-i2c" },
+	{ .compatible = "samsung,s3c2440-i2c" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, s3c24xx_i2c_match);
+#else
+#define s3c24xx_i2c_match NULL
+#endif
+
 static struct platform_driver s3c24xx_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
@@ -1030,6 +1131,7 @@ static struct platform_driver s3c24xx_i2c_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "s3c-i2c",
 		.pm	= S3C24XX_DEV_PM_OPS,
+		.of_match_table = s3c24xx_i2c_match,
 	},
 };
 
-- 
1.6.6.rc2
