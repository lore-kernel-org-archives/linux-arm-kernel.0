From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Jun 2014 11:31:44 +0800
Subject: [PATCH v2 2/5] ASoC: wm8904: switch to CCF
In-Reply-To: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
References: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1402284707-23354-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable WM8904 to support common clock framework.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - Remove the mclk checking when try to enable or disable it,
    as it is checked when required.

 sound/soc/codecs/wm8904.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index f7c5499..da46c2a 100644
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
 
@@ -1828,6 +1830,7 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		clk_prepare_enable(wm8904->mclk);
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
@@ -1894,6 +1897,7 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
 				       wm8904->supplies);
+		clk_disable_unprepare(wm8904->mclk);
 		break;
 	}
 	codec->dapm.bias_level = level;
@@ -2110,6 +2114,13 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	if (wm8904 == NULL)
 		return -ENOMEM;
 
+	wm8904->mclk = devm_clk_get(&i2c->dev, "mclk");
+	if (IS_ERR(wm8904->mclk)) {
+		ret = PTR_ERR(wm8904->mclk);
+		dev_err(&i2c->dev, "Failed to get MCLK\n");
+		return ret;
+	}
+
 	wm8904->regmap = devm_regmap_init_i2c(i2c, &wm8904_regmap);
 	if (IS_ERR(wm8904->regmap)) {
 		ret = PTR_ERR(wm8904->regmap);
-- 
1.8.5.2
