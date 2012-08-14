From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 14 Aug 2012 18:12:05 +0530
Subject: [PATCH 5/5] ASoC: tlv320aic3x: Add device tree bindings
In-Reply-To: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1344948125-5649-6-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree support for tlv320aic3x CODEC driver.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
:000000 100644 0000000... f4dee26... A	Documentation/devicetree/bindings/sound/tlv320aic3x.txt
:100644 100644 01485bd... 91fc421... M	sound/soc/codecs/tlv320aic3x.c
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   18 ++++++++++++
 sound/soc/codecs/tlv320aic3x.c                     |   30 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
new file mode 100644
index 0000000..f4dee26
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -0,0 +1,18 @@
+Texas Instruments - tlv320aic3x Codec module
+
+The tlv320aic3x serial control bus communicates through I2C protocols
+
+Required properties:
+- compatible - "string" -  "ti,tlv320aic3x"
+- reg - <int> -  I2C slave address
+- gpio-reset - <int> -  gpio pin number used for codec reset
+- ai3x-gpio-func - <array of 2 int> - AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
+
+Example:
+
+tlv320aic3x: tlv320aic3x at 1b {
+	compatible = "ti,tlv320aic3x";
+	reg = <0x1b>;
+	gpio-reset = <60>;
+	ai3x-gpio-func = <0 5>;
+};
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 01485bd..91fc421 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1457,6 +1457,9 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 {
 	struct aic3x_pdata *pdata = i2c->dev.platform_data;
 	struct aic3x_priv *aic3x;
+	struct aic3x_setup_data *ai3x_setup;
+	struct device_node *np = i2c->dev.of_node;
+	u32 val;
 	int ret;
 
 	aic3x = devm_kzalloc(&i2c->dev, sizeof(struct aic3x_priv), GFP_KERNEL);
@@ -1471,6 +1474,24 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	if (pdata) {
 		aic3x->gpio_reset = pdata->gpio_reset;
 		aic3x->setup = pdata->setup;
+	} else if (np) {
+		ai3x_setup = devm_kzalloc(&i2c->dev, sizeof(*ai3x_setup),
+								GFP_KERNEL);
+		if (ai3x_setup == NULL) {
+			dev_err(&i2c->dev, "failed to create private data\n");
+			return -ENOMEM;
+		}
+
+		if (of_property_read_u32(np, "gpio-reset", &val) >= 0)
+			aic3x->gpio_reset = val;
+		else
+			aic3x->gpio_reset = -1;
+
+		if (of_property_read_u32_array(np, "ai3x-gpio-func",
+					ai3x_setup->gpio_func, 2) >= 0) {
+			aic3x->setup = ai3x_setup;
+		}
+
 	} else {
 		aic3x->gpio_reset = -1;
 	}
@@ -1488,11 +1509,20 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id tlv320aic3x_of_match[] = {
+	{ .compatible = "ti,tlv320aic3x", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tlv320aic3x_of_match);
+#endif
+
 /* machine i2c codec control layer */
 static struct i2c_driver aic3x_i2c_driver = {
 	.driver = {
 		.name = "tlv320aic3x-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tlv320aic3x_of_match),
 	},
 	.probe	= aic3x_i2c_probe,
 	.remove = aic3x_i2c_remove,
-- 
1.7.1
