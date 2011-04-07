From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu,  7 Apr 2011 09:31:10 +0900
Subject: [alsa-devel][PATCH 3/3] SoC: SAMSUNG: Add WM8580 PCM Machine driver
In-Reply-To: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
References: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1302136270-28776-4-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add WM8580 PCM machine driver to support PCM audio
on SMDKC110, SMDKV210, SMDK6450, SMDK6440 boards.
Playback and Capture supports 8kHz sampling rates.
and It is tested on SMDKC110, SMDKV210, SMDK6450.

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/Kconfig          |   12 +++
 sound/soc/samsung/Makefile         |   14 ++-
 sound/soc/samsung/pcm.c            |    4 +-
 sound/soc/samsung/smdk_wm8580pcm.c |  190 ++++++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/samsung/smdk_wm8580pcm.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a3fdfb6..01f1560 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -23,6 +23,9 @@ config SND_S3C2412_SOC_I2S
 config SND_SAMSUNG_PCM
 	tristate
 
+config SND_SOC_SAMSUNG_SMDK_WM8580_PCM
+	tristate
+
 config SND_SAMSUNG_AC97
 	tristate
 	select SND_SOC_AC97_BUS
@@ -162,3 +165,12 @@ config SND_SOC_SAMSUNG_SMDK_SPDIF
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
+
+config SND_SOC_SMDK_WM8580_PCM
+	tristate "SoC PCM Audio support for WM8580 on SMDK"
+	depends on SND_SOC_SAMSUNG && (MACH_SMDK6450 || MACH_SMDKV210 || MACH_SMDKC110)
+	select SND_SOC_SAMSUNG_SMDK_WM8580_PCM if (MACH_SMDK6450 || MACH_SMDKV210 || MACH_SMDKC110)
+	select SND_SOC_WM8580
+	select SND_SAMSUNG_PCM
+	help
+	  Say Y if you want to add support for SoC audio on the SMDK.
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 294dec0..fff9744 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -1,12 +1,12 @@
-# S3c24XX Platform Support
+# SAMSUNG Platform Support
 snd-soc-s3c24xx-objs := dma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
 snd-soc-ac97-objs := ac97.o
 snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 snd-soc-samsung-spdif-objs := spdif.o
-snd-soc-pcm-objs := pcm.o
-snd-soc-i2s-objs := i2s.o
+snd-soc-samsung-pcm-objs := pcm.o
+snd-soc-samsung-i2s-objs := i2s.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG) += snd-soc-s3c24xx.o
 obj-$(CONFIG_SND_S3C24XX_I2S) += snd-soc-s3c24xx-i2s.o
@@ -14,10 +14,10 @@ obj-$(CONFIG_SND_SAMSUNG_AC97) += snd-soc-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 obj-$(CONFIG_SND_SAMSUNG_SPDIF) += snd-soc-samsung-spdif.o
-obj-$(CONFIG_SND_SAMSUNG_PCM) += snd-soc-pcm.o
-obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SAMSUNG_PCM) += snd-soc-samsung-pcm.o
+obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-samsung-i2s.o
 
-# S3C24XX Machine Support
+# SAMSUNG Machine Support
 snd-soc-jive-wm8750-objs := jive_wm8750.o
 snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
 snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
@@ -34,6 +34,7 @@ snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
 snd-soc-smdk-spdif-objs := smdk_spdif.o
+snd-soc-smdk-wm8580pcm-objs := smdk_wm8580pcm.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -51,3 +52,4 @@ obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
 obj-$(CONFIG_SND_SOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
+obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_WM8580_PCM) += snd-soc-smdk-wm8580pcm.o
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 38aac7d..9c7e8b4 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -350,8 +350,8 @@ static int s3c_pcm_set_fmt(struct snd_soc_dai *cpu_dai,
 	ctl = readl(regs + S3C_PCM_CTL);
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		/* Nothing to do, NB_NF by default */
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Nothing to do, IB_NF by default */
 		break;
 	default:
 		dev_err(pcm->dev, "Unsupported clock inversion!\n");
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
new file mode 100644
index 0000000..940eccc
--- /dev/null
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -0,0 +1,190 @@
+/*
+ *  sound/soc/samsung/smdk_wm8580pcm.c
+ *
+ *  Copyright (c) 2011 Samsung Electronics Co. Ltd
+ *
+ *  This program is free software; you can redistribute  it and/or  modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/wm8580.h"
+#include "dma.h"
+#include "pcm.h"
+
+/*
+ * Board Settings:
+ *  o '1' means 'ON'
+ *  o '0' means 'OFF'
+ *  o 'X' means 'Don't care'
+ *
+ * SMDK6410, SMDK6440, SMDK6450 Base B/D: CFG1-0000, CFG2-1111
+ * SMDKC110, SMDKV210: CFGB11-100100, CFGB12-0000
+ */
+
+#define SMDK_WM8580_EXT_OSC 12000000
+#define SMDK_WM8580_EXT_MCLK 4096000
+#define SMDK_WM8580_EXT_VOICE 2048000
+
+static unsigned long mclk_freq;
+static unsigned long xtal_freq;
+
+/*
+ * If MCLK clock directly gets from XTAL, we don't have to use PLL
+ * to make MCLK, but if XTAL clock source connects with other codec
+ * pin (like XTI), we should have to set codec's PLL to make MCLK.
+ * Because Samsung SoC does not support pcmcdclk output like I2S.
+ */
+
+static int smdk_wm8580_pcm_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int rfs, ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+		break;
+	default:
+		printk(KERN_ERR "%s:%d Sampling Rate %u not supported!\n",
+		__func__, __LINE__, params_rate(params));
+		return -EINVAL;
+	}
+
+	rfs = mclk_freq / params_rate(params) / 2;
+
+	/* Set the codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B
+				| SND_SOC_DAIFMT_IB_NF
+				| SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* Set the cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_B
+				| SND_SOC_DAIFMT_IB_NF
+				| SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	if (mclk_freq == xtal_freq) {
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8580_CLKSRC_MCLK,
+						mclk_freq, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
+						WM8580_CLKSRC_MCLK);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8580_CLKSRC_PLLA,
+						mclk_freq, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
+						WM8580_CLKSRC_PLLA);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
+						xtal_freq, mclk_freq);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Set PCM source clock on CPU */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C_PCM_CLKSRC_MUX,
+					mclk_freq, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* Set SCLK_DIV for making bclk */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_PCM_SCLK_PER_FS, rfs);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops smdk_wm8580_pcm_ops = {
+	.hw_params = smdk_wm8580_pcm_hw_params,
+};
+
+static struct snd_soc_dai_link smdk_dai[] = {
+	{
+		.name = "WM8580 PAIF PCM RX",
+		.stream_name = "Playback",
+		.cpu_dai_name = "samsung-pcm.0",
+		.codec_dai_name = "wm8580-hifi-playback",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8580-codec.0-001b",
+		.ops = &smdk_wm8580_pcm_ops,
+	}, {
+		.name = "WM8580 PAIF PCM TX",
+		.stream_name = "Capture",
+		.cpu_dai_name = "samsung-pcm.0",
+		.codec_dai_name = "wm8580-hifi-capture",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8580-codec.0-001b",
+		.ops = &smdk_wm8580_pcm_ops,
+	},
+};
+
+static struct snd_soc_card smdk = {
+	.name = "SMDK-PCM",
+	.dai_link = smdk_dai,
+	.num_links = 2,
+};
+
+static struct platform_device *smdk_snd_device;
+
+/*
+ * After SMDKC110 Base Board's Rev is '0.1', 12MHz External OSC(X1)
+ * is absent (or not connected), so we connect EXT_VOICE_CLK(OSC4),
+ * 2.0484Mhz, directly with MCLK both Codec and SoC.
+ */
+
+static int __init smdk_audio_init(void)
+{
+	int ret = 0;
+
+	xtal_freq = SMDK_WM8580_EXT_OSC;
+	mclk_freq = SMDK_WM8580_EXT_MCLK;
+
+	if (machine_is_smdkc110() || machine_is_smdkv210())
+		xtal_freq = mclk_freq = SMDK_WM8580_EXT_VOICE;
+
+	smdk_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk_snd_device, &smdk);
+
+	ret = platform_device_add(smdk_snd_device);
+	if (ret)
+		platform_device_put(smdk_snd_device);
+
+	return ret;
+}
+
+module_init(smdk_audio_init);
+
+static void __exit smdk_audio_exit(void)
+{
+	platform_device_unregister(smdk_snd_device);
+}
+module_exit(smdk_audio_exit);
+
+MODULE_AUTHOR("Sangbeom Kim, <sbkim73@samsung.com>");
+MODULE_DESCRIPTION("ALSA SoC SMDK WM8580 for PCM");
+MODULE_LICENSE("GPL");
-- 
1.7.1
