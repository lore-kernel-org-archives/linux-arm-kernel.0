From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Tue, 26 Jan 2010 14:51:41 +0900
Subject: [PATCH 3/3] ARM: SMDK64XX: Enable AC97 device
In-Reply-To: <1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1264485101-13782-3-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Implementing basic support for Playback/Capture by SMDK's AC97
controller with WM9713 codec, this patch adds the ALSA machine
driver for AC97 device.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    9 ++-
 sound/soc/s3c24xx/Kconfig             |    8 ++
 sound/soc/s3c24xx/Makefile            |    2 +
 sound/soc/s3c24xx/smdk_wm9713.c       |  147 +++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/s3c24xx/smdk_wm9713.c

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index eba345f..259ebbb 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -55,6 +55,7 @@
 #include <plat/gpio-cfg.h>
 
 #include <plat/s3c6410.h>
+#include <plat/audio.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -253,7 +254,9 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&smdk6410_b_pwr_5v,
 #endif
 	&smdk6410_lcd_powerdev,
-
+#ifdef CONFIG_SND_SOC_SMDK_WM9713
+	&s3c64xx_device_ac97,
+#endif
 	&smdk6410_smsc911x,
 };
 
@@ -475,6 +478,10 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
+#ifdef CONFIG_SND_SOC_SMDK_WM9713
+	s3c64xx_ac97_setup_gpio(S3C64XX_AC97_GPD);
+#endif
+
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
 
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
index 0000000..4ce851e
--- /dev/null
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -0,0 +1,147 @@
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
+ Playback :-
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
+
+ Capture (MicIn):-
+	Right Capture Source - Mic1
+	$ amixer cset numid=86 0
+	Left Capture Source - Mic1
+	$ amixer cset numid=87 0
+*/
+
+static int smdk_hifi_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	/* CAPTURE - Stereo LineIn
+	 * Currently there is no other way to change ACLink-In slots
+	 * of Wm9713, so we make do with this call.
+	 */
+	/* Slots-3,4*/
+	soc_ac97_ops.write(NULL, 0x5c, 0);
+
+	return 0;
+}
+
+static struct snd_soc_ops smdk_hifi_ops = {
+	.hw_params = smdk_hifi_hw_params,
+};
+
+static int smdk_mic_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	/* CAPTURE - Mono MicIn
+	 * Currently there is no other way to change ACLink-In slots
+	 * of Wm9713, so we make do with this call.
+	 */
+	/* Slots-6,9*/
+	soc_ac97_ops.write(NULL, 0x5c, 2);
+
+	return 0;
+}
+
+static struct snd_soc_ops smdk_mic_ops = {
+	.hw_params = smdk_mic_hw_params,
+};
+
+static struct snd_soc_dai_link smdk_dai[] = {
+	[0] = {
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+		.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+		.ops = &smdk_hifi_ops,
+	},
+	[1] = {
+		.name = "AC97",
+		.stream_name = "AC97 Mic",
+		.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_MIC],
+		.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+		.ops = &smdk_mic_ops,
+	},
+};
+
+static struct snd_soc_card smdk = {
+	.name = "SMDK",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = smdk_dai,
+	.num_links = ARRAY_SIZE(smdk_dai),
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
