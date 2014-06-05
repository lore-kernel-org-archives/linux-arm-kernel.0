From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 16:47:06 +0200
Subject: [PATCH] ASoC: sigmadsp: remove I2C support
Message-ID: <6181626.txoA4bpImf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added ADAU1781 codec comes with separate drivers for
I2C and SPI modes, which gives us a new variation of the dependency
problems: If SPI is enabled and the I2C core is a loadable module,
selecting SND_SOC_ADAU1781_SPI as built-in leads to a link error because
the common base code from sigmadsp.c now also gets built-in:

sound/built-in.o: In function `sigma_action_write_i2c':
:(.text+0x5d8d4): undefined reference to `i2c_master_send'

Rather than adding yet more complex Kconfig logic, this converts the last
user of process_sigma_firmware() to process_sigma_firmware_regmap(),
which seems trivial after the driver itself now uses regmap as well.
With that done, there is no more linker dependency from
SND_SOC_ADAU1781_SPI to i2c_master_send.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
I hope this is the last ASoC patch I have for the moment, sorry for spamming
everybody ;-)

 sound/soc/codecs/adau1701.c |  5 +++--
 sound/soc/codecs/sigmadsp.c | 27 ---------------------------
 sound/soc/codecs/sigmadsp.h |  3 ---
 3 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index d71c59c..1b5e306 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -239,7 +239,6 @@ static int adau1701_reg_read(void *context, unsigned int reg,
 static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
 {
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *client = to_i2c_client(codec->dev);
 	int ret;
 
 	if (clkdiv != ADAU1707_CLKDIV_UNSET &&
@@ -282,7 +281,9 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
 	 * know the correct PLL setup
 	 */
 	if (clkdiv != ADAU1707_CLKDIV_UNSET) {
-		ret = process_sigma_firmware(client, ADAU1701_FIRMWARE);
+		ret = process_sigma_firmware_regmap(codec->dev,
+						    adau1701->regmap,
+						    ADAU1701_FIRMWARE);
 		if (ret) {
 			dev_warn(codec->dev, "Failed to load firmware\n");
 			return ret;
diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 4068f24..209f98f 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -10,7 +10,6 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/kernel.h>
-#include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
 
@@ -198,30 +197,6 @@ static int _process_sigma_firmware(struct device *dev,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_I2C)
-
-static int sigma_action_write_i2c(void *control_data,
-	const struct sigma_action *sa, size_t len)
-{
-	return i2c_master_send(control_data, (const unsigned char *)&sa->addr,
-		len);
-}
-
-int process_sigma_firmware(struct i2c_client *client, const char *name)
-{
-	struct sigma_firmware ssfw;
-
-	ssfw.control_data = client;
-	ssfw.write = sigma_action_write_i2c;
-
-	return _process_sigma_firmware(&client->dev, &ssfw, name);
-}
-EXPORT_SYMBOL(process_sigma_firmware);
-
-#endif
-
-#if IS_ENABLED(CONFIG_REGMAP)
-
 static int sigma_action_write_regmap(void *control_data,
 	const struct sigma_action *sa, size_t len)
 {
@@ -241,6 +216,4 @@ int process_sigma_firmware_regmap(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL(process_sigma_firmware_regmap);
 
-#endif
-
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/sigmadsp.h b/sound/soc/codecs/sigmadsp.h
index e439cbd..38a455b 100644
--- a/sound/soc/codecs/sigmadsp.h
+++ b/sound/soc/codecs/sigmadsp.h
@@ -12,9 +12,6 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
-struct i2c_client;
-
-extern int process_sigma_firmware(struct i2c_client *client, const char *name);
 extern int process_sigma_firmware_regmap(struct device *dev,
 		struct regmap *regmap, const char *name);
 
