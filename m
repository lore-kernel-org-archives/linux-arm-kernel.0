From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 14 Mar 2012 16:56:33 +0100
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree support
In-Reply-To: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds very basic support for device tree probing. Currently,
only a PWM and a list of distinct brightness levels can be specified.
Enabling or disabling backlight power via GPIOs is not yet supported.

A pointer to the exit() callback is stored in the driver data to keep it
around until the driver is unloaded.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v4:
  - store a PWM requested with of_pwm_request() in the platform data

Changes in v3:
  - use a list of distinct brightness levels instead of a linear range
    as discussed with Stephen Warren and Mitch Bradley

Changes in v2:
  - avoid oops by keeping a reference to the platform-specific exit()
    callback

TODO:
  - add fixed-regulator support for backlight enable/disable

 .../bindings/video/backlight/pwm-backlight         |   19 +++
 drivers/video/backlight/Kconfig                    |    2 +-
 drivers/video/backlight/pwm_bl.c                   |  136 +++++++++++++++++---
 include/linux/pwm_backlight.h                      |    2 +
 4 files changed, 141 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/pwm-backlight

diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
new file mode 100644
index 0000000..79db3dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
@@ -0,0 +1,19 @@
+pwm-backlight bindings
+
+Required properties:
+  - compatible: "pwm-backlight"
+  - pwm: OF device-tree PWM specification
+  - num-brightness-levels: number of distinct brightness levels
+  - brightness-levels: array of distinct brightness levels
+  - default-brightness-level: the default brightness level
+
+Example:
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwm = <&pwm 0 5000000>;
+
+		num-brightness-levels = <8>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7ed9991..ecfe3a0 100644
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
index 342b7d7..57ff91b 100644
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
@@ -26,11 +27,13 @@ struct pwm_bl_data {
 	struct device		*dev;
 	unsigned int		period;
 	unsigned int		lth_brightness;
+	unsigned int		*levels;
 	int			(*notify)(struct device *,
 					  int brightness);
 	void			(*notify_after)(struct device *,
 					int brightness);
 	int			(*check_fb)(struct device *, struct fb_info *);
+	void			(*exit)(struct device *);
 };
 
 static int pwm_backlight_update_status(struct backlight_device *bl)
@@ -52,6 +55,11 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		pwm_config(pb->pwm, 0, pb->period);
 		pwm_disable(pb->pwm);
 	} else {
+		if (pb->levels) {
+			brightness = pb->levels[brightness];
+			max = pb->levels[max];
+		}
+
 		brightness = pb->lth_brightness +
 			(brightness * (pb->period - pb->lth_brightness) / max);
 		pwm_config(pb->pwm, brightness, pb->period);
@@ -83,17 +91,102 @@ static const struct backlight_ops pwm_backlight_ops = {
 	.check_fb	= pwm_backlight_check_fb,
 };
 
+#ifdef CONFIG_OF
+static int pwm_backlight_parse_dt(struct device *dev,
+				  struct platform_pwm_backlight_data *data)
+{
+	struct device_node *node = dev->of_node;
+	struct pwm_device *pwm;
+	u32 value;
+	int ret;
+
+	if (!node)
+		return -ENODEV;
+
+	pwm = of_pwm_request(node, "pwm", 0);
+	if (IS_ERR(pwm))
+		return PTR_ERR(pwm);
+
+	memset(data, 0, sizeof(*data));
+	data->pwm_period_ns = pwm_get_period(pwm);
+	data->pwm = pwm;
+
+	ret = of_property_read_u32(node, "num-brightness-levels", &value);
+	if (ret < 0)
+		goto free;
+
+	data->max_brightness = value;
+
+	if (data->max_brightness > 0) {
+		size_t size = sizeof(*data->levels) * data->max_brightness;
+
+		data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
+		if (!data->levels) {
+			ret = -ENOMEM;
+			goto free;
+		}
+
+		ret = of_property_read_u32_array(node, "brightness-levels",
+						 data->levels,
+						 data->max_brightness);
+		if (ret < 0)
+			goto free;
+
+		ret = of_property_read_u32(node, "default-brightness-level",
+					   &value);
+		if (ret < 0)
+			goto free;
+
+		data->dft_brightness = value;
+		data->max_brightness--;
+	}
+
+	/*
+	 * TODO: Most users of this driver use a number of GPIOs to control
+	 *       backlight power. Support for specifying these needs to be
+	 *       added.
+	 */
+
+	return 0;
+
+free:
+	pwm_free(pwm);
+
+	return ret;
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
+	unsigned int max;
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
@@ -109,21 +202,30 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	if (data->levels) {
+		max = data->levels[data->max_brightness];
+		pb->levels = data->levels;
+	} else
+		max = data->max_brightness;
+
 	pb->period = data->pwm_period_ns;
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
 	pb->check_fb = data->check_fb;
-	pb->lth_brightness = data->lth_brightness *
-		(data->pwm_period_ns / data->max_brightness);
+	pb->exit = data->exit;
+	pb->lth_brightness = data->lth_brightness * (data->pwm_period_ns / max);
+	pb->pwm = data->pwm;
 	pb->dev = &pdev->dev;
 
-	pb->pwm = pwm_request(data->pwm_id, "backlight");
-	if (IS_ERR(pb->pwm)) {
-		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
-		ret = PTR_ERR(pb->pwm);
-		goto err_alloc;
-	} else
-		dev_dbg(&pdev->dev, "got pwm for backlight\n");
+	if (!pb->pwm) {
+		pb->pwm = pwm_request(data->pwm_id, "backlight");
+		if (IS_ERR(pb->pwm)) {
+			dev_err(&pdev->dev, "unable to request PWM for backlight\n");
+			ret = PTR_ERR(pb->pwm);
+			goto err_alloc;
+		} else
+			dev_dbg(&pdev->dev, "got pwm for backlight\n");
+	}
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
@@ -152,7 +254,6 @@ err_alloc:
 
 static int pwm_backlight_remove(struct platform_device *pdev)
 {
-	struct platform_pwm_backlight_data *data = pdev->dev.platform_data;
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
 
@@ -160,8 +261,8 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
 	pwm_free(pb->pwm);
-	if (data->exit)
-		data->exit(&pdev->dev);
+	if (pb->exit)
+		pb->exit(&pdev->dev);
 	return 0;
 }
 
@@ -195,11 +296,12 @@ static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
 
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
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index 63d2df4..3d1f0da 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -7,11 +7,13 @@
 #include <linux/backlight.h>
 
 struct platform_pwm_backlight_data {
+	struct pwm_device *pwm;
 	int pwm_id;
 	unsigned int max_brightness;
 	unsigned int dft_brightness;
 	unsigned int lth_brightness;
 	unsigned int pwm_period_ns;
+	unsigned int *levels;
 	int (*init)(struct device *dev);
 	int (*notify)(struct device *dev, int brightness);
 	void (*notify_after)(struct device *dev, int brightness);
-- 
1.7.9.4
