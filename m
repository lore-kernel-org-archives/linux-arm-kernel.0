From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Wed, 27 Jan 2010 14:59:19 +0900
Subject: [PATCHv2 05/10] ASoC: AC97: SMDK: Add wm9713 machine driver
Message-ID: <1264571959-15115-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

This patch adds the common machine driver for SMDKs that
have a WM9713 codec attched to the AC97 controller.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig       |    8 +++
 sound/soc/s3c24xx/Makefile      |    2 +
 sound/soc/s3c24xx/smdk_wm9713.c |   97 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/smdk_wm9713.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index ad3690e..d1c6f93 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -115,3 +115,11 @@ config SND_S3C24XX_SOC_SIMTEC_HERMES
 	select SND_S3C24XX_SOC_I2S
 	select SND_SOC_TLV320AIC3X
 	select SND_S3C24XX_SOC_SIMTEC
+
+config SND_SOC_SMDK_WM9713
+	tristate "SoC AC97 Audio support for SMDK with WM9713"
+	depends on SND_S3C24XX_SOC && MACH_SMDK6410
+	select SND_SOC_WM9713
+	select SND_S3C_SOC_AC97
+	help
+	  Sat Y if you want to add support for SoC audio on the SMDK.
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index b7411bd..1117678 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -28,6 +28,7 @@ snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
 snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
 snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
+snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -39,3 +40,4 @@ obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
 obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
+obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
new file mode 100644
index 0000000..7dd933f
--- /dev/null
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -0,0 +1,97 @@
+/*
+ * smdk_wm9713.c  --  SoC audio for SMDK
+ *
+ * Copyright 2010 Samsung Electronics Co. Ltd.
+ * Author: Jaswinder Singh Brar <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/soc.h>
+
+#include "../codecs/wm9713.h"
+#include "s3c-dma.h"
+#include "s3c-ac97.h"
+
+static struct snd_soc_card smdk;
+
+/*
+ Playback (HeadPhone):-
+	Headphone Playback Switch - On
+	$ amixer cset numid=4 1
+
+	Right Headphone Out Mux - Headphone
+	$ amixer cset numid=92 2
+	Left Headphone Out Mux - Headphone
+	$ amixer cset numid=93 2
+
+	Right HP Mixer PCM Playback Switch - On
+	$ amixer cset numid=75 1
+	Left HP Mixer PCM Playback Switch - On
+	$ amixer cset numid=81 1
+
+ Capture (LineIn):-
+	Right Capture Source - Line
+	$ amixer cset numid=86 2
+	Left Capture Source - Line
+	$ amixer cset numid=87 2
+*/
+
+static struct snd_soc_dai_link smdk_dai = {
+	.name = "AC97",
+	.stream_name = "AC97 PCM",
+	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+	.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+};
+
+static struct snd_soc_card smdk = {
+	.name = "SMDK",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = &smdk_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device smdk_snd_ac97_devdata = {
+	.card = &smdk,
+	.codec_dev = &soc_codec_dev_wm9713,
+};
+
+static struct platform_device *smdk_snd_ac97_device;
+
+static int __init smdk_init(void)
+{
+	int ret;
+
+	smdk_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_ac97_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk_snd_ac97_device,
+			     &smdk_snd_ac97_devdata);
+	smdk_snd_ac97_devdata.dev = &smdk_snd_ac97_device->dev;
+
+	ret = platform_device_add(smdk_snd_ac97_device);
+	if (ret)
+		platform_device_put(smdk_snd_ac97_device);
+
+	return ret;
+}
+
+static void __exit smdk_exit(void)
+{
+	platform_device_unregister(smdk_snd_ac97_device);
+}
+
+module_init(smdk_init);
+module_exit(smdk_exit);
+
+/* Module information */
+MODULE_AUTHOR("Jaswinder Singh Brar, jassi.brar at samsung.com");
+MODULE_DESCRIPTION("ALSA SoC SMDK+WM9713");
+MODULE_LICENSE("GPL");
-- 
1.6.2.5
