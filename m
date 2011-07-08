From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 8 Jul 2011 23:59:43 +0800
Subject: [PATCH 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <1310140790-2132-1-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
Message-ID: <1310140790-2132-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver only supports playback firstly.
For recording, as we have to use two saif instances to implement full
duplex (playback & recording) due to hardware limitation, we need to
figure out a good design to fit in ASoC.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/mach-mxs/include/mach/audio.h |   18 +++
 sound/soc/mxs/mxs-sgtl5000.c           |  181 ++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/audio.h b/arch/arm/mach-mxs/include/mach/audio.h
new file mode 100644
index 0000000..2f543d2
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/audio.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_MXS_SAIF_H__
+#define __MACH_MXS_SAIF_H__
+
+struct mxs_audio_platform_data {
+	int sysclk;
+
+	int (*init) (void);     /* board specific init */
+	int (*finit) (void);    /* board specific finit */
+};
+#endif /* __MACH_MXS_SAIF_H__ */
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
new file mode 100644
index 0000000..7ae7c86
--- /dev/null
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -0,0 +1,181 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/fsl_devices.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/soc-dapm.h>
+#include <asm/mach-types.h>
+
+#include <mach/audio.h>
+#include "../codecs/sgtl5000.h"
+#include "mxs-saif.h"
+
+static struct mxs_sgtl5000_priv {
+	int sysclk;
+	struct platform_device *pdev;
+} card_priv;
+
+static struct snd_soc_card mxs_sgtl5000;
+static struct platform_device *mxs_sgtl5000_snd_device;
+
+static int mxs_sgtl5000_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int rate = params_rate(params);
+	u32 dai_format;
+	int ret;
+
+	/* The SAIF clock should be either 512*fs or 384*fs */
+	card_priv.sysclk = 512 * rate;
+	ret = snd_soc_dai_set_sysclk(cpu_dai, MXS_SAIF_SYS_CLK,
+			card_priv.sysclk,
+			SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	/* set SGTL5000_SYSCLK as 256*fs to support 96k sample rate */
+	snd_soc_dai_set_sysclk(codec_dai, SGTL5000_SYSCLK, 256 * rate, 0);
+
+	/* The MCLK output rate is 256*fs */
+	snd_soc_dai_set_clkdiv(cpu_dai, MXS_SAIF_MCLK, 256);
+
+	/* set codec to slave mode */
+	dai_format = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, dai_format);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, dai_format);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
+	.hw_params = mxs_sgtl5000_hw_params,
+};
+
+static int mxs_sgtl5000_soc_init(struct snd_soc_pcm_runtime *rtd)
+{
+	/* TBD: add dapm widgets */
+
+	return 0;
+}
+
+static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
+	{
+		.name		= "HiFi",
+		.stream_name	= "HiFi Playback",
+		.codec_dai_name	= "sgtl5000",
+		.codec_name	= "sgtl5000.0-000a",
+		.cpu_dai_name	= "mxs-saif.0",
+		.platform_name	= "mxs-pcm-audio.0",
+		.init		= mxs_sgtl5000_soc_init,
+		.ops		= &mxs_sgtl5000_hifi_ops,
+	},
+};
+
+static struct snd_soc_card mxs_sgtl5000 = {
+	.name		= "mxs_sgtl5000",
+	.dai_link	= mxs_sgtl5000_dai,
+	.num_links	= ARRAY_SIZE(mxs_sgtl5000_dai),
+};
+
+static int __devinit mxs_sgtl5000_probe(struct platform_device *pdev)
+{
+	struct mxs_audio_platform_data *plat = pdev->dev.platform_data;
+	int ret;
+
+	card_priv.pdev = pdev;
+
+	ret = -EINVAL;
+	if (plat && plat->init && plat->init())
+		return ret;
+
+	return 0;
+}
+
+static int mxs_sgtl5000_remove(struct platform_device *pdev)
+{
+	struct mxs_audio_platform_data *plat = pdev->dev.platform_data;
+
+	if (plat && plat->finit)
+		plat->finit();
+
+	return 0;
+}
+
+static struct platform_driver mxs_sgtl5000_audio_driver = {
+	.probe = mxs_sgtl5000_probe,
+	.remove = mxs_sgtl5000_remove,
+	.driver = {
+		   .name = "mxs-sgtl5000",
+		   },
+};
+
+static int __init mxs_sgtl5000_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mxs_sgtl5000_audio_driver);
+	if (ret)
+		return ret;
+
+	mxs_sgtl5000_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!mxs_sgtl5000_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(mxs_sgtl5000_snd_device, &mxs_sgtl5000);
+
+	ret = platform_device_add(mxs_sgtl5000_snd_device);
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		platform_device_put(mxs_sgtl5000_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit mxs_sgtl5000_exit(void)
+{
+	platform_driver_unregister(&mxs_sgtl5000_audio_driver);
+	platform_device_unregister(mxs_sgtl5000_snd_device);
+}
+
+late_initcall(mxs_sgtl5000_init);
+module_exit(mxs_sgtl5000_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("MXS ALSA SoC Machine driver");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4
