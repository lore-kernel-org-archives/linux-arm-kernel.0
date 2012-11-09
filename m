From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  9 Nov 2012 15:00:23 +0100
Subject: [PATCH 4/6] ASoC: wm8974: add SPI as a possible bus master
In-Reply-To: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1352469625-32024-5-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wm8974 can be controlled via i2c or spi. The current driver only supports
i2c. Add SPI as possible bus.

As the driver has to distinguish the bus type, pass this info via the wm8974_priv.
This reverts c2562a8e3b5f871ad0b73caf98bb7541e8724efc, because the driver now
needs it back.

This is based on earlier work by Uwe Kleine-K?nig.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 sound/soc/codecs/Kconfig  |    2 +-
 sound/soc/codecs/wm8974.c |   62 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b92759a..cc6069d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -104,7 +104,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8961 if I2C
 	select SND_SOC_WM8962 if I2C
 	select SND_SOC_WM8971 if I2C
-	select SND_SOC_WM8974 if I2C
+	select SND_SOC_WM8974 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8978 if I2C
 	select SND_SOC_WM8983 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8985 if SND_SOC_I2C_AND_SPI
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index b012e4d..8af553c 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -48,6 +49,10 @@ static const u16 wm8974_reg[WM8974_CACHEREGNUM] = {
 #define WM8974_POWER1_BIASEN  0x08
 #define WM8974_POWER1_BUFIOEN 0x04
 
+struct wm8974_priv {
+	enum snd_soc_control_type control_type;
+};
+
 #define wm8974_reset(c)	snd_soc_write(c, WM8974_RESET, 0)
 
 static const char *wm8974_companding[] = {"Off", "NC", "u-law", "A-law" };
@@ -617,8 +622,9 @@ static int wm8974_resume(struct snd_soc_codec *codec)
 static int wm8974_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
+	struct wm8974_priv *wm8974 = snd_soc_codec_get_drvdata(codec);
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8974->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -660,13 +666,64 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8974_dapm_routes),
 };
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8974_spi_probe(struct spi_device *spi)
+{
+	struct wm8974_priv *wm8974;
+	int ret;
+
+	wm8974 = kzalloc(sizeof(*wm8974), GFP_KERNEL);
+	if (!wm8974)
+		return -ENOMEM;
+
+	wm8974->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8974);
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_wm8974, &wm8974_dai, 1);
+	if (ret)
+		kfree(wm8974);
+
+	return ret;
+}
+
+static int __devexit wm8974_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
+
+static struct spi_driver wm8974_spi_driver = {
+	.driver = {
+		.name = "wm8974",
+		.owner = THIS_MODULE,
+	},
+	.probe = wm8974_spi_probe,
+	.remove = __devexit_p(wm8974_spi_remove),
+};
+
+module_spi_driver(wm8974_spi_driver);
+#endif
+
+#if IS_ENABLED(CONFIG_I2C)
 static __devinit int wm8974_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
+	struct wm8974_priv *wm8974;
 	int ret;
 
+	wm8974 = kzalloc(sizeof(*wm8974), GFP_KERNEL);
+	if (!wm8974)
+		return -ENOMEM;
+
+	wm8974->control_type = SND_SOC_I2C;
+	i2c_set_clientdata(i2c, wm8974);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8974, &wm8974_dai, 1);
+	if (ret)
+		kfree(wm8974);
 
 	return ret;
 }
@@ -674,7 +731,7 @@ static __devinit int wm8974_i2c_probe(struct i2c_client *i2c,
 static __devexit int wm8974_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -695,6 +752,7 @@ static struct i2c_driver wm8974_i2c_driver = {
 };
 
 module_i2c_driver(wm8974_i2c_driver);
+#endif
 
 MODULE_DESCRIPTION("ASoC WM8974 driver");
 MODULE_AUTHOR("Liam Girdwood");
-- 
1.7.10.4
