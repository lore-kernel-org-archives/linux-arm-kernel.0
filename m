From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 3 Feb 2015 11:33:35 +0800
Subject: [RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
Message-ID: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the wm8731 codec to manage clock by itself.

As all at91 related boards have been switch to CCF framework. So, on
the at91 related boards which use wm8731 will let it manage the clock,
or else the board use wm8731 is broken.

However, at the same time the wm8731 codec is used on other boards,
I am sure this change will broken some boards.

For example: poodle and corgi based on PXA SoC (in default configuration
file, no one use it). DB1200 board which is a mips based board. So I have
no idea how to fix them.

So, my suggestion is to add CCF check based on the following patch? Any
idea or suggestions?

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 sound/soc/codecs/wm8731.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index b9211b4..83f75d66 100644
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
@@ -389,6 +391,8 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	switch (clk_id) {
 	case WM8731_SYSCLK_XTAL:
 	case WM8731_SYSCLK_MCLK:
+		if (clk_set_rate(wm8731->mclk, freq))
+			return -EINVAL;
 		wm8731->sysclk_type = clk_id;
 		break;
 	default:
@@ -490,6 +494,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		clk_prepare_enable(wm8731->mclk);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
@@ -508,6 +513,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
+		clk_disable_unprepare(wm8731->mclk);
 		snd_soc_write(codec, WM8731_PWR, 0xffff);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
@@ -666,6 +672,13 @@ static int wm8731_spi_probe(struct spi_device *spi)
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
+	wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(wm8731->mclk)) {
+		ret = PTR_ERR(wm8731->mclk);
+		dev_err(&spi->dev, "Failed to get MCLK\n");
+		return ret;
+	}
+
 	mutex_init(&wm8731->lock);
 
 	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
@@ -717,6 +730,13 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
+	wm8731->mclk = devm_clk_get(&i2c->dev, "mclk");
+	if (IS_ERR(wm8731->mclk)) {
+		ret = PTR_ERR(wm8731->mclk);
+		dev_err(&i2c->dev, "Failed to get MCLK\n");
+		return ret;
+	}
+
 	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
-- 
2.3.0.rc0
