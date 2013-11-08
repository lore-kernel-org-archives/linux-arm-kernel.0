From: denis@eukrea.com (Denis Carikli)
Date: Fri,  8 Nov 2013 17:31:30 +0100
Subject: [PATCHv6][ 2/2] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <1383928290-9487-1-git-send-email-denis@eukrea.com>
References: <1383928290-9487-1-git-send-email-denis@eukrea.com>
Message-ID: <1383928290-9487-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- The default state handling was reworked:
  - it's now called default-state, and looks like the gpio-leds default-state.
  - it now has a "keep" option, like for the gpio-leds.
  - that "keep" option is the default when the default-state property is not set.
- The documentation was updated accordingly.

ChangeLog v4->v5:
- The default-brightness property now defaults to 0 in the driver.
- def_value int becomes a bool.
- The check for the gpio validity has been reworked.
---
 .../bindings/video/backlight/gpio-backlight.txt    |   23 +++++++
 drivers/video/backlight/gpio_backlight.c           |   72 +++++++++++++++++---
 2 files changed, 87 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
new file mode 100644
index 0000000..f36f6e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
@@ -0,0 +1,23 @@
+gpio-backlight bindings
+
+Required properties:
+  - compatible: "gpio-backlight"
+  - gpios: describes the gpio that is used for enabling/disabling the backlight
+     (see GPIO binding[0] for more details).
+
+Optional properties:
+  - default-state: The initial state of the backlight.
+    Valid values are "on", "off", and "keep".
+    The "keep" setting will keep the backlight at whatever its current
+    state is, without producing a glitch. The default is keep if this
+    property is not present.
+
+[0]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+	backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpio3 4 0>;
+		default-state = "on";
+	};
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 6ddeba9..66e3aa2 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -13,6 +13,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_data/gpio_backlight.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -61,6 +63,43 @@ static const struct backlight_ops gpio_backlight_ops = {
 	.check_fb	= gpio_backlight_check_fb,
 };
 
+static int gpio_backlight_probe_dt(struct platform_device *pdev,
+				   struct gpio_backlight *gbl)
+{
+	struct device_node *np = pdev->dev.of_node;
+	enum of_gpio_flags gpio_flags;
+	const char *state;
+	int ret;
+
+	gbl->fbdev = NULL;
+	gbl->gpio = of_get_gpio_flags(np, 0, &gpio_flags);
+
+	if (!gpio_is_valid(gbl->gpio)) {
+		if (gbl->gpio != -EPROBE_DEFER) {
+			dev_err(&pdev->dev,
+				"Error: The gpios parameter is missing or invalid.\n");
+		}
+		return gbl->gpio;
+	}
+
+	gbl->active = (gpio_flags & OF_GPIO_ACTIVE_LOW) ? 0 : 1;
+
+	state = of_get_property(np, "default-state", NULL);
+	if (state) {
+		if (!strcmp(state, "keep"))
+			gbl->def_value = BACKLIGHT_GPIO_DEFSTATE_KEEP;
+		else if (!strcmp(state, "on"))
+			gbl->def_value = BACKLIGHT_GPIO_DEFSTATE_ON;
+		else
+			gbl->def_value = BACKLIGHT_GPIO_DEFSTATE_OFF;
+	} else {
+		/* we don't want to touch the hardware if we're not told to */
+		gbl->def_value = BACKLIGHT_GPIO_DEFSTATE_KEEP;
+	}
+
+	return 0;
+}
+
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct gpio_backlight_platform_data *pdata =
@@ -68,10 +107,12 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "failed to find platform data\n");
+	if (!pdata && !np) {
+		dev_err(&pdev->dev,
+			"failed to find platform data or device tree node.\n");
 		return -ENODEV;
 	}
 
@@ -80,14 +121,23 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gbl->dev = &pdev->dev;
-	gbl->fbdev = pdata->fbdev;
-	gbl->gpio = pdata->gpio;
-	gbl->active = pdata->active_low ? 0 : 1;
+
+	if (np) {
+		ret = gpio_backlight_probe_dt(pdev, gbl);
+		if (ret)
+			return ret;
+	} else {
+		gbl->fbdev = pdata->fbdev;
+		gbl->gpio = pdata->gpio;
+		gbl->active = pdata->active_low ? 0 : 1;
+		if (pdata->def_value != BACKLIGHT_GPIO_DEFSTATE_KEEP)
+			gbl->def_value = pdata->def_value;
+	}
 
 	ret = devm_gpio_request_one(gbl->dev, gbl->gpio, GPIOF_DIR_OUT |
 				    (gbl->active ? GPIOF_INIT_LOW
 						 : GPIOF_INIT_HIGH),
-				    pdata->name);
+				    pdata ? pdata->name : "backlight");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to request GPIO\n");
 		return ret;
@@ -104,8 +154,8 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	if (pdata->def_value != BACKLIGHT_GPIO_DEFSTATE_KEEP) {
-		bl->props.brightness = pdata->def_value;
+	if (gbl->def_value != BACKLIGHT_GPIO_DEFSTATE_KEEP) {
+		bl->props.brightness = gbl->def_value;
 		backlight_update_status(bl);
 	}
 
@@ -113,10 +163,16 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id gpio_backlight_of_match[] = {
+	{ .compatible = "gpio-backlight" },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver gpio_backlight_driver = {
 	.driver		= {
 		.name		= "gpio-backlight",
 		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(gpio_backlight_of_match),
 	},
 	.probe		= gpio_backlight_probe,
 };
-- 
1.7.9.5
