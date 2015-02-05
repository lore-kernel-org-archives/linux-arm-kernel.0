From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 5 Feb 2015 15:35:13 +0800
Subject: [PATCH] ASoC: wm8731: let codec to manage clock by itself
Message-ID: <1423121713-19434-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the wm8731 codec to manage clock by itself.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 sound/soc/codecs/wm8731.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index b115ed8..ecd8424 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -45,6 +46,7 @@ static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8731_priv {
 	struct regmap *regmap;
+	struct clk *mclk;
 	struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
 	const struct snd_pcm_hw_constraint_list *constraints;
 	unsigned int sysclk;
@@ -389,6 +391,9 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	switch (clk_id) {
 	case WM8731_SYSCLK_XTAL:
 	case WM8731_SYSCLK_MCLK:
+		if (IS_ENABLED(CONFIG_COMMON_CLK))
+			if (clk_set_rate(wm8731->mclk, freq))
+				return -EINVAL;
 		wm8731->sysclk_type = clk_id;
 		break;
 	default:
@@ -490,6 +495,9 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		if (IS_ENABLED(CONFIG_COMMON_CLK))
+			if (clk_prepare_enable(wm8731->mclk))
+				return -EINVAL;
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
@@ -508,6 +516,8 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
+		if (IS_ENABLED(CONFIG_COMMON_CLK))
+			clk_disable_unprepare(wm8731->mclk);
 		snd_soc_write(codec, WM8731_PWR, 0xffff);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
@@ -666,6 +676,15 @@ static int wm8731_spi_probe(struct spi_device *spi)
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
+		wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
+		if (IS_ERR(wm8731->mclk)) {
+			ret = PTR_ERR(wm8731->mclk);
+			dev_err(&spi->dev, "Failed to get MCLK\n");
+			return ret;
+		}
+	}
+
 	mutex_init(&wm8731->lock);
 
 	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
@@ -717,6 +736,15 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
+		wm8731->mclk = devm_clk_get(&i2c->dev, "mclk");
+		if (IS_ERR(wm8731->mclk)) {
+			ret = PTR_ERR(wm8731->mclk);
+			dev_err(&i2c->dev, "Failed to get MCLK\n");
+			return ret;
+		}
+	}
+
 	mutex_init(&wm8731->lock);
 
 	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
-- 
2.3.0.rc0
