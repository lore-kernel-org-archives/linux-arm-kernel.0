From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 30 Oct 2015 16:50:40 -0700
Subject: [PATCH v3 3/3] mfd: lm3533: Support initialization from Device Tree
In-Reply-To: <1446249040-16552-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1446249040-16552-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1446249040-16552-3-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement Device Tree parsing functions to support initialization of the
lm3533 drivers.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

Changes since v2:
- Included and changed unit in various dt properties
- Fix compilation issue with !CONFIG_OF

Changes since v1:
- Added units to bost-freq and als resistance

 drivers/mfd/lm3533-core.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 5abcbb2e8849..dbf26d86fe85 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
+#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -25,6 +26,7 @@
 
 #include <linux/mfd/lm3533.h>
 
+#define LM3533_DEFAULT_BRIGHTNESS	200
 
 #define LM3533_BOOST_OVP_MASK		0x06
 #define LM3533_BOOST_OVP_SHIFT		1
@@ -588,10 +590,266 @@ static const struct regmap_config regmap_config = {
 	.precious_reg	= lm3533_precious_register,
 };
 
+static int lm3533_of_parse_enum(struct device_node *node,
+				const char *propname,
+				const unsigned *match, size_t num_matches)
+{
+	size_t i;
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(node, propname, &val);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < num_matches; i++) {
+		if (val == match[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int lm3533_of_parse_pwm_zones(struct device_node *node)
+{
+	const char *propname = "ti,pwm-zones";
+	u32 zones[5];
+	int count;
+	int ret;
+	int i;
+
+	count = of_property_count_u32_elems(node, propname);
+	if (count == -EINVAL)
+		return 0;
+	if (count <= 0)
+		return count;
+	if (count >= ARRAY_SIZE(zones))
+		return -EINVAL;
+
+	ret = of_property_read_u32_array(node, propname, zones, count);
+	if (ret < 0)
+		return ret;
+
+	/* Enable pwm input, and enable the selected zones */
+	ret = BIT(0);
+	for (i = 0; i < count; i++)
+		ret |= BIT(zones[i] + 1);
+
+	return ret;
+}
+
+static int lm3533_of_parse_als_node(struct device *dev,
+				    struct device_node *node,
+				    struct lm3533_platform_data *pdata)
+{
+	struct lm3533_als_platform_data *als_pdata;
+	int ret;
+	u32 val;
+
+	als_pdata = devm_kzalloc(dev,
+				 sizeof(struct lm3533_als_platform_data),
+				 GFP_KERNEL);
+	if (!als_pdata)
+		return -ENOMEM;
+
+	als_pdata->pwm_mode = of_property_read_bool(node, "ti,pwm-mode");
+
+	ret = of_property_read_u32(node, "ti,als-resistance-ohm", &val);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "unable to read ti,als-resistance-ohm");
+		return ret;
+	}
+
+	/* Leave@high-Z, if the property was omitted or specified as 0 */
+	if (!ret && val != 0)
+		als_pdata->r_select = 200000 / val;
+
+	pdata->als = als_pdata;
+
+	return 0;
+}
+
+static int lm3533_of_parse_bl_node(struct device *dev,
+				   struct device_node *node,
+				   struct lm3533_platform_data *pdata)
+{
+	struct lm3533_bl_platform_data *bl_pdata;
+	int ret;
+	u32 reg;
+	u32 val;
+
+	ret = of_property_read_u32(node, "reg", &reg);
+	if (ret < 0 || reg >= ARRAY_SIZE(lm3533_bl_devs)) {
+		dev_err(dev, "invalid reg property\n");
+		return ret;
+	}
+
+	bl_pdata = &pdata->backlights[reg];
+
+	/* Increment num_backlights if we're filling a new space */
+	if (reg + 1 > pdata->num_backlights)
+		pdata->num_backlights = reg + 1;
+
+	ret = of_property_read_string(node, "label",
+				      (const char **)&bl_pdata->name);
+	if (ret < 0) {
+		dev_err(dev, "unable to parse label\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "led-max-microamp", &val);
+	if (ret < 0) {
+		dev_err(dev, "unable to parse led-max-microamp\n");
+		return ret;
+	}
+	bl_pdata->max_current = val;
+
+	val = LM3533_DEFAULT_BRIGHTNESS;
+	ret = of_property_read_u32(node, "default-brightness", &val);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "unable to parse default-brightness\n");
+		return ret;
+	}
+	bl_pdata->default_brightness = val;
+
+	ret = lm3533_of_parse_pwm_zones(node);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse ti,pwm-zones\n");
+		return ret;
+	}
+	bl_pdata->pwm = ret;
+
+	return 0;
+}
+
+static int lm3533_of_parse_led_node(struct device *dev,
+				    struct device_node *node,
+				    struct lm3533_platform_data *pdata)
+{
+	struct lm3533_led_platform_data *led_pdata;
+	int ret;
+	u32 reg;
+	u32 val;
+
+	ret = of_property_read_u32(node, "reg", &reg);
+	if (ret < 0 || reg >= ARRAY_SIZE(lm3533_led_devs)) {
+		dev_err(dev, "invalid reg property\n");
+		return ret;
+	}
+
+	led_pdata = &pdata->leds[reg];
+
+	/* Increment num_leds if we're filling a new space */
+	if (reg + 1 > pdata->num_leds)
+		pdata->num_leds = reg + 1;
+
+	ret = of_property_read_string(node, "label",
+				      (const char **)&led_pdata->name);
+	if (ret < 0) {
+		dev_err(dev, "unable to parse label\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "led-max-microamp", &val);
+	if (ret < 0) {
+		dev_err(dev, "unable to parse led-max-microamp\n");
+		return ret;
+	}
+	led_pdata->max_current = val;
+
+	ret = of_property_read_string(node, "linux,default-trigger",
+				      &led_pdata->default_trigger);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "unable to parse default-trigger\n");
+		return ret;
+	}
+
+	ret = lm3533_of_parse_pwm_zones(node);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse ti,pwm-zones\n");
+		return ret;
+	}
+	led_pdata->pwm = ret;
+
+	return 0;
+}
+
+static int lm3533_pdata_from_of_node(struct device *dev)
+{
+	struct lm3533_platform_data *pdata;
+	struct device_node *node;
+	int ret;
+	const unsigned freqs[] = {
+		[LM3533_BOOST_FREQ_500KHZ] = 500000,
+		[LM3533_BOOST_FREQ_1000KHZ] = 1000000,
+	};
+	const unsigned ovps[] = {
+		[LM3533_BOOST_OVP_16V] = 16000,
+		[LM3533_BOOST_OVP_24V] = 24000,
+		[LM3533_BOOST_OVP_32V] = 32000,
+		[LM3533_BOOST_OVP_40V] = 40000,
+	};
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->backlights = devm_kcalloc(dev,
+					 ARRAY_SIZE(lm3533_bl_devs),
+					 sizeof(struct lm3533_bl_platform_data),
+					 GFP_KERNEL);
+	if (!pdata->backlights)
+		return -ENOMEM;
+
+	pdata->leds = devm_kcalloc(dev,
+				   ARRAY_SIZE(lm3533_led_devs),
+				   sizeof(struct lm3533_led_platform_data),
+				   GFP_KERNEL);
+	if (!pdata->leds)
+		return -ENOMEM;
+
+	pdata->gpio_hwen = of_get_named_gpio(dev->of_node, "hwen-gpios", 0);
+	if (pdata->gpio_hwen < 0)
+		return pdata->gpio_hwen;
+
+	ret = lm3533_of_parse_enum(dev->of_node, "ti,boost-freq-hz", freqs, 2);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse ti,boost-freq-hz\n");
+		return ret;
+	}
+	pdata->boost_freq = ret;
+
+	ret = lm3533_of_parse_enum(dev->of_node, "ti,boost-ovp-mv", ovps, 4);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse ti,boost-ovp-mv\n");
+		return ret;
+	}
+	pdata->boost_ovp = ret;
+
+	for_each_child_of_node(dev->of_node, node) {
+		if (!strcmp(node->name, "als"))
+			ret = lm3533_of_parse_als_node(dev, node, pdata);
+		else if (!strcmp(node->name, "backlight"))
+			ret = lm3533_of_parse_bl_node(dev, node, pdata);
+		else if (!strcmp(node->name, "led"))
+			ret = lm3533_of_parse_led_node(dev, node, pdata);
+
+		if (ret < 0) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	dev->platform_data = pdata;
+
+	return 0;
+}
+
 static int lm3533_i2c_probe(struct i2c_client *i2c,
 					const struct i2c_device_id *id)
 {
 	struct lm3533 *lm3533;
+	int ret;
 
 	dev_dbg(&i2c->dev, "%s\n", __func__);
 
@@ -608,6 +866,12 @@ static int lm3533_i2c_probe(struct i2c_client *i2c,
 	lm3533->dev = &i2c->dev;
 	lm3533->irq = i2c->irq;
 
+	if (i2c->dev.of_node) {
+		ret = lm3533_pdata_from_of_node(lm3533->dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.4.2
