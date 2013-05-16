From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 16 May 2013 14:53:04 +0800
Subject: [PATCH] ASoC: dfbmcs320: make the driver common for other BT modules
Message-ID: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
we don't want everyone to have a seperate codec driver. anyway, the
feature of Bluetooth handsfree is same on all platforms, so this patch
makes the DFBM-CS320 driver become a common BT handsfree driver.

Cc: Graeme Gregory <graeme@openmoko.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/Kconfig                         |  4 ++--
 sound/soc/codecs/Makefile                        |  4 ++--
 sound/soc/codecs/{dfbmcs320.c => bt-handsfree.c} | 28 ++++++++++++------------
 sound/soc/samsung/neo1973_wm8753.c               |  6 ++---
 4 files changed, 21 insertions(+), 21 deletions(-)
 rename sound/soc/codecs/{dfbmcs320.c => bt-handsfree.c} (57%)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d8c4f3d..618928a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -40,7 +40,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA7213 if I2C
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
-	select SND_SOC_DFBMCS320
+	select SND_SOC_BT_HANDSFREE
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -263,7 +263,7 @@ config SND_SOC_DA732X
 config SND_SOC_DA9055
 	tristate
 
-config SND_SOC_DFBMCS320
+config SND_SOC_BT_HANDSFREE
 	tristate
 
 config SND_SOC_DMIC
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 49ff127..23a8c06 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -27,7 +27,7 @@ snd-soc-da7210-objs := da7210.o
 snd-soc-da7213-objs := da7213.o
 snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
-snd-soc-dfbmcs320-objs := dfbmcs320.o
+snd-soc-bt-handsfree-objs := bt-handsfree.o
 snd-soc-dmic-objs := dmic.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
@@ -154,7 +154,7 @@ obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_DA7213)	+= snd-soc-da7213.o
 obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
-obj-$(CONFIG_SND_SOC_DFBMCS320)	+= snd-soc-dfbmcs320.o
+obj-$(CONFIG_SND_SOC_BT_HANDSFREE)	+= snd-soc-bt-handsfree.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
diff --git a/sound/soc/codecs/dfbmcs320.c b/sound/soc/codecs/bt-handsfree.c
similarity index 57%
rename from sound/soc/codecs/dfbmcs320.c
rename to sound/soc/codecs/bt-handsfree.c
index 4f4f7f4..99291e0 100644
--- a/sound/soc/codecs/dfbmcs320.c
+++ b/sound/soc/codecs/bt-handsfree.c
@@ -1,5 +1,5 @@
 /*
- * Driver for the DFBM-CS320 bluetooth module
+ * Driver for generic Bluetooth Handsfree
  * Copyright 2011 Lars-Peter Clausen <lars@metafoo.de>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -15,8 +15,8 @@
 
 #include <sound/soc.h>
 
-static struct snd_soc_dai_driver dfbmcs320_dai = {
-	.name = "dfbmcs320-pcm",
+static struct snd_soc_dai_driver bt_handsfree_dai = {
+	.name = "bt-handsfree-pcm",
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 1,
@@ -31,32 +31,32 @@ static struct snd_soc_dai_driver dfbmcs320_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_dfbmcs320;
+static struct snd_soc_codec_driver soc_codec_dev_bt_handsfree;
 
-static int dfbmcs320_probe(struct platform_device *pdev)
+static int bt_handsfree_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_dfbmcs320,
-			&dfbmcs320_dai, 1);
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_bt_handsfree,
+			&bt_handsfree_dai, 1);
 }
 
-static int dfbmcs320_remove(struct platform_device *pdev)
+static int bt_handsfree_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 
 	return 0;
 }
 
-static struct platform_driver dfmcs320_driver = {
+static struct platform_driver bt_handsfree_driver = {
 	.driver = {
-		.name = "dfbmcs320",
+		.name = "bt-handsfree",
 		.owner = THIS_MODULE,
 	},
-	.probe = dfbmcs320_probe,
-	.remove = dfbmcs320_remove,
+	.probe = bt_handsfree_probe,
+	.remove = bt_handsfree_remove,
 };
 
-module_platform_driver(dfmcs320_driver);
+module_platform_driver(bt_handsfree_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("ASoC DFBM-CS320 bluethooth module driver");
+MODULE_DESCRIPTION("ASoC generic bluethooth handsfree driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index e591c38..bae5144 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -373,7 +373,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 { /* Voice via BT */
 	.name = "Bluetooth",
 	.stream_name = "Voice",
-	.cpu_dai_name = "dfbmcs320-pcm",
+	.cpu_dai_name = "bt-handsfree-pcm",
 	.codec_dai_name = "wm8753-voice",
 	.codec_name = "wm8753.0-001a",
 	.ops = &neo1973_voice_ops,
@@ -382,8 +382,8 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 
 static struct snd_soc_aux_dev neo1973_aux_devs[] = {
 	{
-		.name = "dfbmcs320",
-		.codec_name = "dfbmcs320.0",
+		.name = "bt_handsfree",
+		.codec_name = "bt_handsfree.0",
 	},
 };
 
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
