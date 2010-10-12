From: sw.youn@samsung.com (Seungwhan Youn)
Date: Tue, 12 Oct 2010 20:58:52 +0900
Subject: [PATCH v2 6/6] ASoC: SAMSUNG: Add Machine driver for S/PDIF PCM audio
In-Reply-To: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1286884732-27958-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add S/PDIF machine driver to support S/PDIF PCM audio
on SMDKC100, SMDKC110 and SMDKV210 boards.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/Kconfig      |    7 ++
 sound/soc/s3c24xx/Makefile     |    2 +
 sound/soc/s3c24xx/smdk_spdif.c |  223 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/smdk_spdif.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index e2cba93..8a6b53c 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -161,3 +161,10 @@ config SND_S5PV210_SOC_GONI_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on goni
 	  with the WM8994.
+
+config SND_SOC_SMDK_SPDIF
+	tristate "SoC S/PDIF Audio support for SMDK"
+	depends on SND_S3C24XX_SOC && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210)
+	select SND_S5P_SOC_SPDIF
+	help
+	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 0a02735..ee8f41d 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -35,6 +35,7 @@ snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-aquila-wm8994-objs := aquila_wm8994.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
+snd-soc-smdk-spdif-objs := smdk_spdif.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -51,3 +52,4 @@ obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_S5PC110_SOC_AQUILA_WM8994) += snd-soc-aquila-wm8994.o
 obj-$(CONFIG_SND_S5PV210_SOC_GONI_WM8994) += snd-soc-goni-wm8994.o
+obj-$(CONFIG_SND_SOC_SMDK_SPDIF) += snd-soc-smdk-spdif.o
diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/s3c24xx/smdk_spdif.c
new file mode 100644
index 0000000..5daf32f
--- /dev/null
+++ b/sound/soc/s3c24xx/smdk_spdif.c
@@ -0,0 +1,223 @@
+/*
+ * smdk_spdif.c  --  S/PDIF audio for SMDK
+ *
+ * Copyright 2010 Samsung Electronics Co. Ltd.
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
+#include <linux/clk.h>
+
+#include <plat/devs.h>
+
+#include <sound/soc.h>
+
+#include "s3c-dma.h"
+#include "spdif.h"
+
+/* Audio clock settings are belonged to board specific part. Every
+ * board can set audio source clock setting which is matched with H/W
+ * like this function-'set_audio_clock_heirachy'.
+ */
+static int set_audio_clock_heirachy(struct platform_device *pdev)
+{
+	struct clk *fout_epll, *mout_epll, *sclk_audio0, *sclk_spdif;
+	int ret;
+
+	fout_epll = clk_get(NULL, "fout_epll");
+	if (IS_ERR(fout_epll)) {
+		printk(KERN_WARNING "%s: Cannot find fout_epll.\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	mout_epll = clk_get(NULL, "mout_epll");
+	if (IS_ERR(fout_epll)) {
+		printk(KERN_WARNING "%s: Cannot find mout_epll.\n",
+				__func__);
+		ret = -EINVAL;
+		goto out1;
+	}
+
+	sclk_audio0 = clk_get(&pdev->dev, "sclk_audio");
+	if (IS_ERR(sclk_audio0)) {
+		printk(KERN_WARNING "%s: Cannot find sclk_audio.\n",
+				__func__);
+		ret = -EINVAL;
+		goto out2;
+	}
+
+	sclk_spdif = clk_get(NULL, "sclk_spdif");
+	if (IS_ERR(fout_epll)) {
+		printk(KERN_WARNING "%s: Cannot find sclk_spdif.\n",
+				__func__);
+		ret = -EINVAL;
+		goto out3;
+	}
+
+	/* Set audio clock heirachy for S/PDIF */
+	clk_set_parent(mout_epll, fout_epll);
+	clk_set_parent(sclk_audio0, mout_epll);
+	clk_set_parent(sclk_spdif, sclk_audio0);
+
+	clk_put(sclk_spdif);
+out3:
+	clk_put(sclk_audio0);
+out2:
+	clk_put(mout_epll);
+out1:
+	clk_put(fout_epll);
+
+	return ret;
+}
+
+/* We should haved to set clock directly on this part because of clock
+ * scheme of Samsudng SoCs did not support to set rates from abstrct
+ * clock of it's heirachy.
+ */
+static int set_audio_clock_rate(unsigned long epll_rate,
+				unsigned long audio_rate)
+{
+	struct clk *fout_epll, *sclk_spdif;
+
+	fout_epll = clk_get(NULL, "fout_epll");
+	if (IS_ERR(fout_epll)) {
+		printk(KERN_ERR "%s: failed to get fout_epll\n", __func__);
+		return -ENOENT;
+	}
+
+	clk_set_rate(fout_epll, epll_rate);
+	clk_put(fout_epll);
+
+	sclk_spdif = clk_get(NULL, "sclk_spdif");
+	if (IS_ERR(sclk_spdif)) {
+		printk(KERN_ERR "%s: failed to get sclk_spdif\n", __func__);
+		return -ENOENT;
+	}
+
+	clk_set_rate(sclk_spdif, audio_rate);
+	clk_put(sclk_spdif);
+
+	return 0;
+}
+
+static int smdk_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned long pll_out, rclk_rate;
+	int ret, ratio;
+
+	switch (params_rate(params)) {
+	case 44100:
+		pll_out = 45158400;
+		break;
+	case 32000:
+	case 48000:
+	case 96000:
+		pll_out = 49152000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Setting ratio to 512fs helps to use S/PDIF with HDMI without
+	 * modify S/PDIF ASoC machine driver.
+	 */
+	ratio = 512;
+	rclk_rate = params_rate(params) * ratio;
+
+	/* Set audio source clock rates */
+	ret = set_audio_clock_rate(pll_out, rclk_rate);
+	if (ret < 0)
+		return ret;
+
+	/* Set S/PDIF uses internal source clock */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SND_SOC_SPDIF_INT_MCLK,
+					rclk_rate, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static struct snd_soc_ops smdk_spdif_ops = {
+	.hw_params = smdk_hw_params,
+};
+
+static struct snd_soc_card smdk;
+
+static struct snd_soc_dai_link smdk_dai = {
+	.name = "S/PDIF",
+	.stream_name = "S/PDIF PCM Playback",
+	.platform_name = "s3c24xx-pcm-audio",
+	.cpu_dai_name = "samsung-spdif",
+	.codec_dai_name = "dit-hifi",
+	.codec_name = "spdif-dit",
+	.ops = &smdk_spdif_ops,
+};
+
+static struct snd_soc_card smdk = {
+	.name = "SMDK-S/PDIF",
+	.dai_link = &smdk_dai,
+	.num_links = 1,
+};
+
+static struct platform_device *smdk_snd_spdif_dit_device;
+static struct platform_device *smdk_snd_spdif_device;
+
+static int __init smdk_init(void)
+{
+	int ret;
+
+	smdk_snd_spdif_dit_device = platform_device_alloc("spdif-dit", -1);
+	if (!smdk_snd_spdif_dit_device)
+		return -ENOMEM;
+
+	ret = platform_device_add(smdk_snd_spdif_dit_device);
+	if (ret)
+		goto err2;
+
+	smdk_snd_spdif_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_spdif_device) {
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	platform_set_drvdata(smdk_snd_spdif_device, &smdk);
+
+	ret = platform_device_add(smdk_snd_spdif_device);
+	if (ret)
+		goto err1;
+
+	/* Set audio clock heirachy manually */
+	ret = set_audio_clock_heirachy(smdk_snd_spdif_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+err1:
+	platform_device_put(smdk_snd_spdif_device);
+err2:
+	platform_device_put(smdk_snd_spdif_dit_device);
+	return ret;
+}
+
+static void __exit smdk_exit(void)
+{
+	platform_device_unregister(smdk_snd_spdif_device);
+}
+
+module_init(smdk_init);
+module_exit(smdk_exit);
+
+MODULE_AUTHOR("Seungwhan Youn, <sw.youn@samsung.com>");
+MODULE_DESCRIPTION("ALSA SoC SMDK+S/PDIF");
+MODULE_LICENSE("GPL");
-- 
1.6.2.5
