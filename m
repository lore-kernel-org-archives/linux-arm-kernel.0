From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 18 May 2013 20:25:00 +0800
Subject: [PATCH v4] ASoC: dfbmcs320: make the driver common for other BT
 modules
Message-ID: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
we don't want everyone to have a seperate codec driver. anyway, the
feature of Bluetooth SCO is same on all platforms, so this patch
makes the DFBM-CS320 driver become a common BT SCO link driver.

Cc: Graeme Gregory <graeme@openmoko.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 v4:
 change "select SND_SOC_DFBMCS320" to "select SND_SOC_BT_SCO" for OpenMOKO user
 as v3 missed this

 sound/soc/codecs/Kconfig                   |  4 ++--
 sound/soc/codecs/Makefile                  |  4 ++--
 sound/soc/codecs/{dfbmcs320.c => bt-sco.c} | 37 +++++++++++++++++++-----------
 sound/soc/samsung/Kconfig                  |  2 +-
 sound/soc/samsung/neo1973_wm8753.c         |  2 +-
 5 files changed, 29 insertions(+), 20 deletions(-)
 rename sound/soc/codecs/{dfbmcs320.c => bt-sco.c} (53%)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d8c4f3d..386292d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -40,7 +40,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA7213 if I2C
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
-	select SND_SOC_DFBMCS320
+	select SND_SOC_BT_SCO
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -263,7 +263,7 @@ config SND_SOC_DA732X
 config SND_SOC_DA9055
 	tristate
 
-config SND_SOC_DFBMCS320
+config SND_SOC_BT_SCO
 	tristate
 
 config SND_SOC_DMIC
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 49ff127..82aa34e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -27,7 +27,7 @@ snd-soc-da7210-objs := da7210.o
 snd-soc-da7213-objs := da7213.o
 snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
-snd-soc-dfbmcs320-objs := dfbmcs320.o
+snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-dmic-objs := dmic.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
@@ -154,7 +154,7 @@ obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_DA7213)	+= snd-soc-da7213.o
 obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
-obj-$(CONFIG_SND_SOC_DFBMCS320)	+= snd-soc-dfbmcs320.o
+obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
diff --git a/sound/soc/codecs/dfbmcs320.c b/sound/soc/codecs/bt-sco.c
similarity index 53%
rename from sound/soc/codecs/dfbmcs320.c
rename to sound/soc/codecs/bt-sco.c
index 4f4f7f4..a081d9f 100644
--- a/sound/soc/codecs/dfbmcs320.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -1,5 +1,5 @@
 /*
- * Driver for the DFBM-CS320 bluetooth module
+ * Driver for generic Bluetooth SCO link
  * Copyright 2011 Lars-Peter Clausen <lars@metafoo.de>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -15,8 +15,8 @@
 
 #include <sound/soc.h>
 
-static struct snd_soc_dai_driver dfbmcs320_dai = {
-	.name = "dfbmcs320-pcm",
+static struct snd_soc_dai_driver bt_sco_dai = {
+	.name = "bt-sco-pcm",
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 1,
@@ -31,32 +31,41 @@ static struct snd_soc_dai_driver dfbmcs320_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_dfbmcs320;
+static struct snd_soc_codec_driver soc_codec_dev_bt_sco;
 
-static int dfbmcs320_probe(struct platform_device *pdev)
+static int bt_sco_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_dfbmcs320,
-			&dfbmcs320_dai, 1);
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_bt_sco,
+			&bt_sco_dai, 1);
 }
 
-static int dfbmcs320_remove(struct platform_device *pdev)
+static int bt_sco_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 
 	return 0;
 }
 
-static struct platform_driver dfmcs320_driver = {
+static struct platform_device_id bt_sco_driver_ids[] = {
+	{
+		.name		= "dfbmcs320",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
+
+static struct platform_driver bt_sco_driver = {
 	.driver = {
-		.name = "dfbmcs320",
+		.name = "bt-sco",
 		.owner = THIS_MODULE,
 	},
-	.probe = dfbmcs320_probe,
-	.remove = dfbmcs320_remove,
+	.probe = bt_sco_probe,
+	.remove = bt_sco_remove,
+	.id_table = bt_sco_driver_ids,
 };
 
-module_platform_driver(dfmcs320_driver);
+module_platform_driver(bt_sco_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("ASoC DFBM-CS320 bluethooth module driver");
+MODULE_DESCRIPTION("ASoC generic bluethooth sco link driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 475fb0d..ae0ea87 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -39,7 +39,7 @@ config SND_SOC_SAMSUNG_NEO1973_WM8753
 	depends on SND_SOC_SAMSUNG && MACH_NEO1973_GTA02
 	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
-	select SND_SOC_DFBMCS320
+	select SND_SOC_SCO
 	help
 	  Say Y here to enable audio support for the Openmoko Neo1973
 	  Smartphones.
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index e591c38..807db41 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -373,7 +373,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 { /* Voice via BT */
 	.name = "Bluetooth",
 	.stream_name = "Voice",
-	.cpu_dai_name = "dfbmcs320-pcm",
+	.cpu_dai_name = "bt-sco-pcm",
 	.codec_dai_name = "wm8753-voice",
 	.codec_name = "wm8753.0-001a",
 	.ops = &neo1973_voice_ops,
-- 
1.8.2.3
