From: manuel.lauss@gmail.com (Manuel Lauss)
Date: Tue, 3 Feb 2015 08:54:57 +0100
Subject: [RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
In-Reply-To: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
Message-ID: <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 4:33 AM, Bo Shen <voice.shen@atmel.com> wrote:
> Let the wm8731 codec to manage clock by itself.
>
> As all at91 related boards have been switch to CCF framework. So, on
> the at91 related boards which use wm8731 will let it manage the clock,
> or else the board use wm8731 is broken.
>
> However, at the same time the wm8731 codec is used on other boards,
> I am sure this change will broken some boards.
>
> For example: poodle and corgi based on PXA SoC (in default configuration
> file, no one use it). DB1200 board which is a mips based board. So I have
> no idea how to fix them.
>
> So, my suggestion is to add CCF check based on the following patch? Any
> idea or suggestions?

What about the patch below?  It makes absence of mclk object non-fatal and
checks if wm8731->mclk is non-NULL before enabling/disabling it.  Works on
my DB1200/DB1300 boards:

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index b115ed8..648b8cd 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */

+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -45,6 +46,7 @@ static const char
*wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8731_priv {
     struct regmap *regmap;
+    struct clk *mclk;
     struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
     const struct snd_pcm_hw_constraint_list *constraints;
     unsigned int sysclk;
@@ -389,6 +391,8 @@ static int wm8731_set_dai_sysclk(struct
snd_soc_dai *codec_dai,
     switch (clk_id) {
     case WM8731_SYSCLK_XTAL:
     case WM8731_SYSCLK_MCLK:
+        if (wm8731->mclk && clk_set_rate(wm8731->mclk, freq))
+            return -EINVAL;
         wm8731->sysclk_type = clk_id;
         break;
     default:
@@ -490,6 +494,8 @@ static int wm8731_set_bias_level(struct
snd_soc_codec *codec,

     switch (level) {
     case SND_SOC_BIAS_ON:
+        if (wm8731->mclk)
+            clk_prepare_enable(wm8731->mclk);
         break;
     case SND_SOC_BIAS_PREPARE:
         break;
@@ -508,6 +514,8 @@ static int wm8731_set_bias_level(struct
snd_soc_codec *codec,
         snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
         break;
     case SND_SOC_BIAS_OFF:
+        if (wm8731->mclk)
+            clk_disable_unprepare(wm8731->mclk);
         snd_soc_write(codec, WM8731_PWR, 0xffff);
         regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
                        wm8731->supplies);
@@ -666,6 +674,12 @@ static int wm8731_spi_probe(struct spi_device *spi)
     if (wm8731 == NULL)
         return -ENOMEM;

+    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
+    if (IS_ERR(wm8731->mclk)) {
+        wm8731->mclk = NULL;
+        dev_warn(&spi->dev, "assuming static MCLK\n");
+    }
+
     mutex_init(&wm8731->lock);

     wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
@@ -719,6 +733,12 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,

     mutex_init(&wm8731->lock);

+    wm8731->mclk = devm_clk_get(&i2c->dev, "mclk");
+    if (IS_ERR(wm8731->mclk)) {
+        wm8731->mclk = NULL;
+        dev_warn(&i2c->dev, "assuming static MCLK\n");
+    }
+
     wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
     if (IS_ERR(wm8731->regmap)) {
         ret = PTR_ERR(wm8731->regmap);

-- 

Manuel
