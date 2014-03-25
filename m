From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 25 Mar 2014 17:56:56 +0800
Subject: [RFC v2 PATCH] ASoC: wm8904: add CCF support
Message-ID: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable WM8904 to support common clock framework.
  - Now it supports use SoC provided clock or external oscillator
    as MCLK.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 Documentation/devicetree/bindings/sound/wm8904.txt | 48 ++++++++++++++++++++++
 sound/soc/codecs/wm8904.c                          | 17 ++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Documentation/devicetree/bindings/sound/wm8904.txt
new file mode 100644
index 0000000..bcf4aa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8904.txt
@@ -0,0 +1,48 @@
+WM8904 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+  - compatible: "wlf,wm8904"
+  - reg: the I2C address of the device.
+  - clocks and clock-names: reference to
+    <Documentation/devicetree/bindings/clock/clock-bindings.txt>
+
+Pins on the device (for linking into audio routes):
+
+  * IN1L
+  * IN1R
+  * IN2L
+  * IN2R
+  * IN3L
+  * IN3R
+  * HPOUTL
+  * HPOUTR
+  * LINEOUTL
+  * LINEOUTR
+  * MICBIAS
+
+Examples:
+
+1. Using SoC provided clock as mclk:
+codec: wm8904 at 1a {
+	compatible = "wlf,wm8904";
+	reg = <0x1a>;
+	clocks = <&pck0>;
+	clock-names = "mclk";
+};
+
+2. Using external oscillator as mclk:
+codec: wm8904 at 1a {
+	compatible = "wlf,wm8904";
+	reg = <0x1a>;
+
+	wm8904_osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		#clock-frequency = <12000000>;
+	}
+
+	clocks = <&wm8904_osc>;
+	clock-names = "mclk";
+};
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 49c35c3..4db6a26 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -49,6 +50,7 @@ static const char *wm8904_supply_names[WM8904_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8904_priv {
 	struct regmap *regmap;
+	struct clk *mclk;
 
 	enum wm8904_type devtype;
 
@@ -1828,6 +1830,9 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		if (IS_ENABLED(CONFIG_COMMON_CLK))
+			if (wm8904->mclk)
+				clk_prepare_enable(wm8904->mclk);
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
@@ -1894,6 +1899,9 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
 				       wm8904->supplies);
+		if (IS_ENABLED(CONFIG_COMMON_CLK))
+			if (wm8904->mclk)
+				clk_disable_unprepare(wm8904->mclk);
 		break;
 	}
 	codec->dapm.bias_level = level;
@@ -2139,6 +2147,15 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
+		wm8904->mclk = devm_clk_get(&i2c->dev, "mclk");
+		if (IS_ERR(wm8904->mclk)) {
+			dev_err(&i2c->dev, "Failed to get MCLK\n");
+			ret = PTR_ERR(wm8904->mclk);
+			goto err_enable;
+		}
+	}
+
 	ret = regmap_read(wm8904->regmap, WM8904_SW_RESET_AND_ID, &val);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to read ID register: %d\n", ret);
-- 
1.8.5.2
