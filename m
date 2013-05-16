From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 16 May 2013 14:08:07 +0800
Subject: [PATCH] ASoC: omap-hdmi-codec: make the driver common for other SoCs
Message-ID: <1368684487-8890-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to support HDMI on CSR SiRFprimaII and atlasVI, we need one more HDMI pseudo
codec, rather than add a new driver, we can make omap HDMI codec common for
other SoCs as well. then the omap-hdmi codec becomes a generic HDMI pseudo-
codec as HDMI audio features depend on HDMI specification not on SoCs.

Cc: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/Kconfig                 |  4 ++--
 sound/soc/codecs/Makefile                |  4 ++--
 sound/soc/codecs/{omap-hdmi.c => hdmi.c} | 26 +++++++++++++-------------
 sound/soc/omap/omap-hdmi-card.c          |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)
 rename sound/soc/codecs/{omap-hdmi.c => hdmi.c} (69%)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2f45f00..d8c4f3d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -53,7 +53,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
-	select SND_SOC_OMAP_HDMI_CODEC if OMAP4_DSS_HDMI
+	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM3008
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_SGTL5000 if I2C
@@ -287,7 +287,7 @@ config SND_SOC_MAX98095
 config SND_SOC_MAX9850
 	tristate
 
-config SND_SOC_OMAP_HDMI_CODEC
+config SND_SOC_HDMI_CODEC
        tristate
 
 config SND_SOC_PCM3008
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b9e41c9..49ff127 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -41,7 +41,7 @@ snd-soc-max98095-objs := max98095.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
-snd-soc-omap-hdmi-codec-objs := omap-hdmi.o
+snd-soc-hdmi-codec-objs := hdmi.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-sgtl5000-objs := sgtl5000.o
@@ -168,7 +168,7 @@ obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
-obj-$(CONFIG_SND_SOC_OMAP_HDMI_CODEC) += snd-soc-omap-hdmi-codec.o
+obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
diff --git a/sound/soc/codecs/omap-hdmi.c b/sound/soc/codecs/hdmi.c
similarity index 69%
rename from sound/soc/codecs/omap-hdmi.c
rename to sound/soc/codecs/hdmi.c
index 529d064..2bcae2b 100644
--- a/sound/soc/codecs/omap-hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -1,5 +1,5 @@
 /*
- * ALSA SoC codec driver for HDMI audio on OMAP processors.
+ * ALSA SoC codec driver for HDMI audio codecs.
  * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
  * Author: Ricardo Neri <ricardo.neri@ti.com>
  *
@@ -23,10 +23,10 @@
 
 #define DRV_NAME "hdmi-audio-codec"
 
-static struct snd_soc_codec_driver omap_hdmi_codec;
+static struct snd_soc_codec_driver hdmi_codec;
 
-static struct snd_soc_dai_driver omap_hdmi_codec_dai = {
-	.name = "omap-hdmi-hifi",
+static struct snd_soc_dai_driver hdmi_codec_dai = {
+	.name = "hdmi-hifi",
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 8,
@@ -39,31 +39,31 @@ static struct snd_soc_dai_driver omap_hdmi_codec_dai = {
 	},
 };
 
-static int omap_hdmi_codec_probe(struct platform_device *pdev)
+static int hdmi_codec_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &omap_hdmi_codec,
-			&omap_hdmi_codec_dai, 1);
+	return snd_soc_register_codec(&pdev->dev, &hdmi_codec,
+			&hdmi_codec_dai, 1);
 }
 
-static int omap_hdmi_codec_remove(struct platform_device *pdev)
+static int hdmi_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
-static struct platform_driver omap_hdmi_codec_driver = {
+static struct platform_driver hdmi_codec_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
 	},
 
-	.probe		= omap_hdmi_codec_probe,
-	.remove		= omap_hdmi_codec_remove,
+	.probe		= hdmi_codec_probe,
+	.remove		= hdmi_codec_remove,
 };
 
-module_platform_driver(omap_hdmi_codec_driver);
+module_platform_driver(hdmi_codec_driver);
 
 MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
-MODULE_DESCRIPTION("ASoC OMAP HDMI codec driver");
+MODULE_DESCRIPTION("ASoC generic HDMI codec driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index d4eaa92..7e66e9c 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -35,7 +35,7 @@ static struct snd_soc_dai_link omap_hdmi_dai = {
 	.cpu_dai_name = "omap-hdmi-audio-dai",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "hdmi-audio-codec",
-	.codec_dai_name = "omap-hdmi-hifi",
+	.codec_dai_name = "hdmi-hifi",
 };
 
 static struct snd_soc_card snd_soc_omap_hdmi = {
-- 
1.8.2.3
