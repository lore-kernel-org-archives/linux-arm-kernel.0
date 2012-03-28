From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:57 +0200
Subject: [PATCH v5 15/16] pwm-backlight: Add rudimentary device tree support
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-16-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds very basic support for device tree probing. Currently,
only a PWM and a list of distinct brightness levels can be specified.
Enabling or disabling backlight power via GPIOs is not yet supported.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v5:
- use "pwms" fixed property name
- document brightness-levels and default-brightness-level properties
- check default-brightness-level against brightness-levels
- use new PWM API (pwm_get() and pwm_put()), legacy API (pwm_request())
  as fallback

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

 .../bindings/video/backlight/pwm-backlight         |   30 ++++
 drivers/video/backlight/Kconfig                    |    2 +-
 drivers/video/backlight/pwm_bl.c                   |  145 +++++++++++++++++---
 include/linux/pwm_backlight.h                      |    1 +
 4 files changed, 157 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/pwm-backlight

diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
new file mode 100644
index 0000000..bc2d08d
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
@@ -0,0 +1,30 @@
+pwm-backlight bindings
+
+Required properties:
+  - compatible: "pwm-backlight"
+  - pwms: OF device-tree PWM specification (see PWM binding[0])
+  - num-brightness-levels: number of distinct brightness levels
+  - brightness-levels: Array of distinct brightness levels. Typically these
+      are in the range from 0 to 255, but any range starting at 0 will do.
+      The actual brightness level (PWM duty cycle) will be interpolated
+      from these values. 0 means a 0% duty cycle (darkest/off), while the
+      last value in the array represents a 100% duty cycle (brightest).
+  - default-brightness-level: the default brightness level (index into the
+      array defined by the "brightness-levels" property)
+
+Optional properties:
+  - pwm-names: a list of names for the PWM devices specified in the
+               "pwms" property (see PWM binding[0])
+
+[0]: Documentation/devicetree/bindings/pwm/pwm.txt
+
+Example:
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 5000000>;
+
+		num-brightness-levels = <8>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7ed9991..cd77e79 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -233,7 +233,7 @@ config BACKLIGHT_CARILLO_RANCH
 
 config BACKLIGHT_PWM
 	tristate "Generic PWM based Backlight Driver"
-	depends on HAVE_PWM
+	depends on PWM
 	help
 	  If you have a LCD backlight adjustable by PWM, say Y to enable
 	  this driver.
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 342b7d7..b996548 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -26,11 +26,13 @@ struct pwm_bl_data {
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
@@ -52,6 +54,11 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
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
@@ -83,17 +90,94 @@ static const struct backlight_ops pwm_backlight_ops = {
 	.check_fb	= pwm_backlight_check_fb,
 };
 
+#ifdef CONFIG_OF
+static int pwm_backlight_parse_dt(struct device *dev,
+				  struct platform_pwm_backlight_data *data)
+{
+	struct device_node *node = dev->of_node;
+	u32 value;
+	int ret;
+
+	if (!node)
+		return -ENODEV;
+
+	memset(data, 0, sizeof(*data));
+
+	ret = of_property_read_u32(node, "num-brightness-levels", &value);
+	if (ret < 0)
+		return ret;
+
+	data->max_brightness = value;
+
+	if (data->max_brightness > 0) {
+		size_t size = sizeof(*data->levels) * data->max_brightness;
+
+		data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
+		if (!data->levels)
+			return -ENOMEM;
+
+		ret = of_property_read_u32_array(node, "brightness-levels",
+						 data->levels,
+						 data->max_brightness);
+		if (ret < 0)
+			return ret;
+
+		ret = of_property_read_u32(node, "default-brightness-level",
+					   &value);
+		if (ret < 0)
+			return ret;
+
+		if (value >= data->max_brightness) {
+			dev_warn(dev, "invalid default brightness level: %u, using %u\n",
+				 value, data->max_brightness - 1);
+			value = data->max_brightness - 1;
+		}
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
-	struct backlight_properties props;
 	struct platform_pwm_backlight_data *data = pdev->dev.platform_data;
+	struct platform_pwm_backlight_data defdata;
+	struct backlight_properties props;
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
@@ -109,21 +193,42 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	pb->period = data->pwm_period_ns;
+	if (data->levels) {
+		max = data->levels[data->max_brightness];
+		pb->levels = data->levels;
+	} else
+		max = data->max_brightness;
+
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
 	pb->check_fb = data->check_fb;
-	pb->lth_brightness = data->lth_brightness *
-		(data->pwm_period_ns / data->max_brightness);
+	pb->exit = data->exit;
 	pb->dev = &pdev->dev;
 
-	pb->pwm = pwm_request(data->pwm_id, "backlight");
+	pb->pwm = pwm_get(&pdev->dev, "pwm-backlight");
 	if (IS_ERR(pb->pwm)) {
-		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
-		ret = PTR_ERR(pb->pwm);
-		goto err_alloc;
-	} else
-		dev_dbg(&pdev->dev, "got pwm for backlight\n");
+		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
+
+		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
+		if (IS_ERR(pb->pwm)) {
+			dev_err(&pdev->dev, "unable to request legacy PWM\n");
+			ret = PTR_ERR(pb->pwm);
+			goto err_alloc;
+		}
+	}
+
+	dev_dbg(&pdev->dev, "got pwm for backlight\n");
+
+	/*
+	 * The DT case will set the pwm_period_ns field to 0 and store the
+	 * period, parsed from the DT, in the PWM device. For the non-DT case,
+	 * set the period from platform data.
+	 */
+	if (data->pwm_period_ns > 0)
+		pwm_set_period(pb->pwm, data->pwm_period_ns);
+
+	pb->period = pwm_get_period(pb->pwm);
+	pb->lth_brightness = data->lth_brightness * (pb->period / max);
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
@@ -143,7 +248,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	return 0;
 
 err_bl:
-	pwm_free(pb->pwm);
+	pwm_put(pb->pwm);
 err_alloc:
 	if (data->exit)
 		data->exit(&pdev->dev);
@@ -152,16 +257,15 @@ err_alloc:
 
 static int pwm_backlight_remove(struct platform_device *pdev)
 {
-	struct platform_pwm_backlight_data *data = pdev->dev.platform_data;
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
 
 	backlight_device_unregister(bl);
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
-	pwm_free(pb->pwm);
-	if (data->exit)
-		data->exit(&pdev->dev);
+	pwm_put(pb->pwm);
+	if (pb->exit)
+		pb->exit(&pdev->dev);
 	return 0;
 }
 
@@ -195,11 +299,12 @@ static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
 
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
index 63d2df4..56f4a86 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -12,6 +12,7 @@ struct platform_pwm_backlight_data {
 	unsigned int dft_brightness;
 	unsigned int lth_brightness;
 	unsigned int pwm_period_ns;
+	unsigned int *levels;
 	int (*init)(struct device *dev);
 	int (*notify)(struct device *dev, int brightness);
 	void (*notify_after)(struct device *dev, int brightness);
-- 
1.7.9.4
