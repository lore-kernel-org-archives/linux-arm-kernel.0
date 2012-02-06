From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon,  6 Feb 2012 16:19:45 +0100
Subject: [PATCH v2 10/10] pwm-backlight: Add rudimentary device tree support
In-Reply-To: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1328541585-24642-11-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds very basic support for device tree probing. Currently,
only a PWM and maximum and default brightness values can be specified.
Enabling or disabling backlight power via GPIOs is not yet supported.

A pointer to the exit() callback is stored in the driver data to keep it
around until the driver is unloaded.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
  - avoid oops by keeping a reference to the platform-specific exit()
    callback

 .../bindings/video/backlight/pwm-backlight         |   16 ++++
 drivers/video/backlight/Kconfig                    |    2 +-
 drivers/video/backlight/pwm_bl.c                   |   81 ++++++++++++++++++--
 3 files changed, 90 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/pwm-backlight

diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
new file mode 100644
index 0000000..ce65280
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
@@ -0,0 +1,16 @@
+pwm-backlight bindings
+
+Required properties:
+  - compatible: "pwm-backlight"
+  - default-brightness: the default brightness setting
+  - max-brightness: the maximum brightness setting
+  - pwm: OF device-tree PWM specification
+
+Example:
+
+	backlight {
+		compatible = "pwm-backlight";
+		default-brightness = <224>;
+		max-brightness = <255>;
+		pwm = <&pwm 0 5000000>;
+	};
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 49e7d83..37982fa 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -233,7 +233,7 @@ config BACKLIGHT_CARILLO_RANCH
 
 config BACKLIGHT_PWM
 	tristate "Generic PWM based Backlight Driver"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM
 	help
 	  If you have a LCD backlight adjustable by PWM, say Y to enable
 	  this driver.
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 342b7d7..5c81397 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -17,6 +17,7 @@
 #include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/err.h>
+#include <linux/of_pwm.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/slab.h>
@@ -31,6 +32,7 @@ struct pwm_bl_data {
 	void			(*notify_after)(struct device *,
 					int brightness);
 	int			(*check_fb)(struct device *, struct fb_info *);
+	void			(*exit)(struct device *);
 };
 
 static int pwm_backlight_update_status(struct backlight_device *bl)
@@ -83,17 +85,79 @@ static const struct backlight_ops pwm_backlight_ops = {
 	.check_fb	= pwm_backlight_check_fb,
 };
 
+#ifdef CONFIG_OF
+static int pwm_backlight_parse_dt(struct device *dev,
+				  struct platform_pwm_backlight_data *data)
+{
+	struct device_node *node = dev->of_node;
+	struct pwm_spec spec;
+	u32 value;
+	int ret;
+
+	if (!node)
+		return -ENODEV;
+
+	memset(data, 0, sizeof(*data));
+
+	ret = of_get_named_pwm(node, "pwm", 0, &spec);
+	if (ret < 0)
+		return ret;
+
+	data->pwm_period_ns = spec.period;
+	data->pwm_id = ret;
+
+	ret = of_property_read_u32(node, "default-brightness", &value);
+	if (ret < 0)
+		return ret;
+
+	data->dft_brightness = value;
+
+	ret = of_property_read_u32(node, "max-brightness", &value);
+	if (ret < 0)
+		return ret;
+
+	data->max_brightness = value;
+
+	/*
+	 * TODO: Most users of this driver use a number of GPIOs to control
+	 *       backlight power. Support for specifying these needs to be
+	 *       added.
+	 */
+
+	return 0;
+}
+
+static struct of_device_id pwm_backlight_of_match[] = {
+	{ .compatible = "pwm-backlight" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, pwm_backlight_of_match);
+#else
+static int pwm_backlight_parse_dt(struct device *dev,
+				  struct platform_pwm_backlight_data *data)
+{
+	return -ENODEV;
+}
+#endif
+
 static int pwm_backlight_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct platform_pwm_backlight_data *data = pdev->dev.platform_data;
+	struct platform_pwm_backlight_data defdata;
 	struct backlight_device *bl;
 	struct pwm_bl_data *pb;
 	int ret;
 
 	if (!data) {
-		dev_err(&pdev->dev, "failed to find platform data\n");
-		return -EINVAL;
+		ret = pwm_backlight_parse_dt(&pdev->dev, &defdata);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to find platform data\n");
+			return ret;
+		}
+
+		data = &defdata;
 	}
 
 	if (data->init) {
@@ -113,6 +177,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
 	pb->check_fb = data->check_fb;
+	pb->exit = data->exit;
 	pb->lth_brightness = data->lth_brightness *
 		(data->pwm_period_ns / data->max_brightness);
 	pb->dev = &pdev->dev;
@@ -152,7 +217,6 @@ err_alloc:
 
 static int pwm_backlight_remove(struct platform_device *pdev)
 {
-	struct platform_pwm_backlight_data *data = pdev->dev.platform_data;
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
 
@@ -160,8 +224,8 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
 	pwm_free(pb->pwm);
-	if (data->exit)
-		data->exit(&pdev->dev);
+	if (pb->exit)
+		pb->exit(&pdev->dev);
 	return 0;
 }
 
@@ -195,11 +259,12 @@ static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
 
 static struct platform_driver pwm_backlight_driver = {
 	.driver		= {
-		.name	= "pwm-backlight",
-		.owner	= THIS_MODULE,
+		.name		= "pwm-backlight",
+		.owner		= THIS_MODULE,
 #ifdef CONFIG_PM
-		.pm	= &pwm_backlight_pm_ops,
+		.pm		= &pwm_backlight_pm_ops,
 #endif
+		.of_match_table	= of_match_ptr(pwm_backlight_of_match),
 	},
 	.probe		= pwm_backlight_probe,
 	.remove		= pwm_backlight_remove,
-- 
1.7.9
