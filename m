From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 22 May 2015 10:14:56 -0500
Subject: [RESEND PATCH v1 2/2] drm: bridge/dw_hdmi-i2s-audio: add audio driver
In-Reply-To: <1432307631-7667-1-git-send-email-ykk@rock-chips.com>
References: <1432307631-7667-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1432307696-7806-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ALSA based HDMI I2S audio driver for dw_hdmi. Sound card
driver could connect to this codec through the codec dai name
"dw-hdmi-i2s-audio".

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/bridge/Kconfig             |   9 +
 drivers/gpu/drm/bridge/Makefile            |   1 +
 drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c | 412 +++++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/dw_hdmi.c           |  24 +-
 drivers/gpu/drm/bridge/dw_hdmi.h           |   3 +
 5 files changed, 440 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 9fff41e..fa8a9d2 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -14,6 +14,15 @@ config DRM_DW_HDMI_AHB_AUDIO
 	  Designware HDMI block.  This is used in conjunction with
 	  the i.MX6 HDMI driver.
 
+config DRM_DW_HDMI_I2S_AUDIO
+	tristate "Synopsis Designware I2S Audio interface"
+	depends on DRM_DW_HDMI && SND
+	select SND_PCM
+	help
+	  Support the I2S Audio interface which is part of the Synopsis
+	  Designware HDMI block.  This is used in conjunction with the
+	  RK3288 HDMI driver.
+
 config DRM_PTN3460
 	tristate "PTN3460 DP/LVDS bridge"
 	depends on DRM
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index ebc5190..4aa566a 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -3,3 +3,4 @@ ccflags-y := -Iinclude/drm
 obj-$(CONFIG_DRM_PTN3460) += ptn3460.o
 obj-$(CONFIG_DRM_DW_HDMI) += dw_hdmi.o
 obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw_hdmi-ahb-audio.o
+obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw_hdmi-i2s-audio.o
diff --git a/drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c
new file mode 100644
index 0000000..e0b5b9d
--- /dev/null
+++ b/drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c
@@ -0,0 +1,412 @@
+/*
+ * DesignWare HDMI audio driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Written and tested against the Designware HDMI Tx found in RK3288.
+ */
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/moduleparam.h>
+
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+#include <drm/bridge/dw_hdmi.h>
+
+#include "dw_hdmi-audio.h"
+
+#define DRIVER_NAME "dw-hdmi-i2s-audio"
+
+enum {
+	AUDIO_CONF1_DATWIDTH_MSK = 0x1F,
+	AUDIO_CONF1_DATAMODE_MSK = 0xE0,
+	AUDIO_DAIFMT_IIS = 0x0,
+	AUDIO_DAIFMT_RIGHT_J = 0x20,
+	AUDIO_DAIFMT_LEFT_J = 0x40,
+	AUDIO_DAIFMT_BURST_1 = 0x60,
+	AUDIO_DAIFMT_BURST_2 = 0x80,
+	AUDIO_CONF0_INTERFACE_MSK = BIT(5),
+	AUDIO_INPUTTYPE_IIS = 0x20,
+	AUDIO_INPUTTYPE_SPDIF = 0x00,
+	AUDIO_CONF0_I2SINEN_MSK = 0x0F,
+	AUDIO_CHANNELNUM_2 = 0x01,
+	AUDIO_CHANNELNUM_4 = 0x03,
+	AUDIO_CHANNELNUM_6 = 0x07,
+	AUDIO_CHANNELNUM_8 = 0x0F,
+	HDMI_PHY_HPD = BIT(1),
+	HDMI_PHY_STAT0 = 0x3004,
+	HDMI_AUD_CONF0 = 0x3100,
+	HDMI_AUD_CONF1 = 0x3101,
+	HDMI_AUD_INPUTCLKFS = 0x3206,
+};
+
+struct dw_audio_fmt {
+	int input_type;
+	int chan_num;
+	int sample_rate;
+	int word_length;
+	int dai_fmt;
+};
+
+struct snd_dw_hdmi {
+	struct device *dev;
+	struct dw_hdmi_audio_data data;
+
+	u8 jack_status;
+	bool is_jack_ready;
+	struct snd_soc_jack jack;
+
+	bool is_playback_status;
+	struct dw_audio_fmt fmt;
+};
+
+static void hdmi_writel(struct snd_dw_hdmi *dw, u8 val, int offset)
+{
+	writel(val, dw->data.base + (offset << 2));
+}
+
+static u8 hdmi_readl(struct snd_dw_hdmi *dw, int offset)
+{
+	return readl(dw->data.base + (offset << 2));
+}
+
+static void hdmi_modl(struct snd_dw_hdmi *dw, u8 data,
+		      u8 mask, unsigned reg)
+{
+	u8 val = hdmi_readl(dw, reg) & ~mask;
+
+	val |= data & mask;
+	hdmi_writel(dw, val, reg);
+}
+
+int snd_dw_hdmi_jack_detect(struct snd_dw_hdmi *dw)
+{
+	u8 jack_status;
+
+	if (!dw->is_jack_ready)
+		return -EINVAL;
+
+	jack_status = !!(hdmi_readl(dw, HDMI_PHY_STAT0) & HDMI_PHY_HPD) ?
+			SND_JACK_LINEOUT : 0;
+
+	if (jack_status != dw->jack_status) {
+		snd_soc_jack_report(&dw->jack, jack_status, SND_JACK_LINEOUT);
+		dw->jack_status = jack_status;
+	}
+
+	return 0;
+}
+
+static irqreturn_t snd_dw_hdmi_irq(int irq, void *dev_id)
+{
+	struct snd_dw_hdmi *dw = dev_id;
+
+	snd_dw_hdmi_jack_detect(dw);
+
+	return IRQ_HANDLED;
+}
+
+static void dw_hdmi_audio_set_fmt(struct snd_dw_hdmi *dw,
+				  const struct dw_audio_fmt *fmt)
+{
+	hdmi_modl(dw, fmt->input_type, AUDIO_CONF0_INTERFACE_MSK,
+		  HDMI_AUD_CONF0);
+
+	hdmi_modl(dw, fmt->chan_num, AUDIO_CONF0_I2SINEN_MSK,
+		  HDMI_AUD_CONF0);
+
+	hdmi_modl(dw, fmt->word_length, AUDIO_CONF1_DATWIDTH_MSK,
+		  HDMI_AUD_CONF1);
+
+	hdmi_modl(dw, fmt->dai_fmt, AUDIO_CONF1_DATAMODE_MSK,
+		  HDMI_AUD_CONF1);
+
+	hdmi_writel(dw, 0, HDMI_AUD_INPUTCLKFS);
+
+	dw_hdmi_set_sample_rate(dw->data.hdmi, fmt->sample_rate);
+}
+
+static void dw_audio_set_fmt(struct snd_dw_hdmi *dw,
+			     const struct dw_audio_fmt *fmt)
+{
+	if (fmt)
+		dw->fmt = *fmt;
+	dw_hdmi_audio_set_fmt(dw, &dw->fmt);
+}
+
+static int snd_dw_hdmi_dai_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *codec_dai)
+{
+	struct snd_dw_hdmi *dw = snd_soc_dai_get_drvdata(codec_dai);
+
+	dw->is_playback_status = true;
+	dw_hdmi_audio_enable(dw->data.hdmi);
+
+	return 0;
+}
+
+static int snd_dw_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *codec_dai)
+{
+	struct snd_dw_hdmi *dw = snd_soc_dai_get_drvdata(codec_dai);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct dw_audio_fmt dw_fmt;
+	unsigned int fmt, rate, chan, width;
+
+	fmt = rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+	switch (fmt) {
+	case SND_SOC_DAIFMT_I2S:
+		dw_fmt.dai_fmt = AUDIO_DAIFMT_IIS;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		dw_fmt.dai_fmt = AUDIO_DAIFMT_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		dw_fmt.dai_fmt = AUDIO_DAIFMT_RIGHT_J;
+		break;
+	default:
+		dev_err(codec_dai->dev, "DAI format unsupported");
+		return -EINVAL;
+	}
+
+	width = params_width(params);
+	switch (width) {
+	case 16:
+	case 24:
+		dw_fmt.word_length = width;
+		break;
+	default:
+		dev_err(codec_dai->dev, "width[%d] not support!\n", width);
+		return -EINVAL;
+	}
+
+	chan = params_channels(params);
+	switch (chan) {
+	case 2:
+		dw_fmt.chan_num = AUDIO_CHANNELNUM_2;
+		break;
+	case 4:
+		dw_fmt.chan_num = AUDIO_CHANNELNUM_4;
+		break;
+	case 6:
+		dw_fmt.chan_num = AUDIO_CHANNELNUM_6;
+		break;
+	case 8:
+		dw_fmt.chan_num = AUDIO_CHANNELNUM_8;
+		break;
+	default:
+		dev_err(codec_dai->dev, "channel[%d] not support!\n", chan);
+		return -EINVAL;
+	}
+
+	rate = params_rate(params);
+	switch (rate) {
+	case 32000:
+	case 44100:
+	case 48000:
+	case 88200:
+	case 96000:
+	case 176400:
+	case 192000:
+		dw_fmt.sample_rate = rate;
+		break;
+	default:
+		dev_err(codec_dai->dev, "rate[%d] not support!\n", rate);
+		return -EINVAL;
+	}
+
+	dw_fmt.input_type = AUDIO_INPUTTYPE_IIS;
+
+	dw_audio_set_fmt(dw, &dw_fmt);
+
+	return 0;
+}
+
+static int snd_dw_hdmi_dai_trigger(struct snd_pcm_substream *substream,
+				   int cmd, struct snd_soc_dai *codec_dai)
+{
+	struct snd_dw_hdmi *dw = snd_soc_dai_get_drvdata(codec_dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dw_hdmi_audio_enable(dw->data.hdmi);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dw_hdmi_audio_disable(dw->data.hdmi);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void snd_dw_hdmi_dai_shutdown(struct snd_pcm_substream *substream,
+				     struct snd_soc_dai *codec_dai)
+{
+	struct snd_dw_hdmi *dw = snd_soc_dai_get_drvdata(codec_dai);
+
+	dw->is_playback_status = false;
+	dw_hdmi_audio_disable(dw->data.hdmi);
+}
+
+static int snd_dw_hdmi_audio_probe(struct snd_soc_codec *codec)
+{
+	struct snd_dw_hdmi *dw = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = snd_soc_jack_new(codec, "dw Jack", SND_JACK_LINEOUT,
+			       &dw->jack);
+	if (ret) {
+		dev_err(dw->dev, "jack new failed (%d)\n", ret);
+		dw->is_jack_ready = false;
+		return ret;
+	}
+
+	dw->is_jack_ready = true;
+
+	return snd_dw_hdmi_jack_detect(dw);
+}
+
+static const struct snd_soc_dapm_widget snd_dw_hdmi_audio_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route snd_dw_hdmi_audio_routes[] = {
+	{ "TX", NULL, "Playback" },
+};
+
+static const struct snd_soc_dai_ops dw_hdmi_dai_ops = {
+	.startup = snd_dw_hdmi_dai_startup,
+	.hw_params = snd_dw_hdmi_dai_hw_params,
+	.trigger = snd_dw_hdmi_dai_trigger,
+	.shutdown = snd_dw_hdmi_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver dw_hdmi_audio_dai = {
+	.name = "dw-hdmi-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_32000 |
+			 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops = &dw_hdmi_dai_ops,
+};
+
+static const struct snd_soc_codec_driver dw_hdmi_audio = {
+	.probe = snd_dw_hdmi_audio_probe,
+	.dapm_widgets = snd_dw_hdmi_audio_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(snd_dw_hdmi_audio_widgets),
+	.dapm_routes = snd_dw_hdmi_audio_routes,
+	.num_dapm_routes = ARRAY_SIZE(snd_dw_hdmi_audio_routes),
+};
+
+static int dw_hdmi_audio_probe(struct platform_device *pdev)
+{
+	struct dw_hdmi_audio_data *data = pdev->dev.platform_data;
+	struct snd_dw_hdmi *dw;
+	int ret;
+
+	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	dw->data = *data;
+	dw->dev = &pdev->dev;
+	dw->is_jack_ready = false;
+	platform_set_drvdata(pdev, dw);
+
+	ret = request_irq(dw->data.irq, snd_dw_hdmi_irq, IRQF_SHARED,
+			  "dw-dw-audio", dw);
+	if (ret) {
+		dev_err(&pdev->dev, "request irq failed (%d)\n", ret);
+		goto free_dw_data;
+	}
+
+	ret = snd_soc_register_codec(&pdev->dev, &dw_hdmi_audio,
+				     &dw_hdmi_audio_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "register codec failed (%d)\n", ret);
+		goto free_irq;
+	}
+
+	dev_dbg(&pdev->dev, "dw audio init success.\n");
+
+	return 0;
+
+free_irq:
+	free_irq(dw->data.irq, dw);
+free_dw_data:
+	devm_kfree(&pdev->dev, dw);
+
+	return ret;
+}
+
+static int dw_hdmi_audio_remove(struct platform_device *pdev)
+{
+	struct snd_dw_hdmi *dw = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_codec(&pdev->dev);
+	devm_free_irq(&pdev->dev, dw->data.irq, dw);
+	devm_kfree(&pdev->dev, dw);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int dw_hdmi_audio_resume(struct device *dev)
+{
+	struct snd_dw_hdmi *dw = dev_get_drvdata(dev);
+
+	snd_dw_hdmi_jack_detect(dw);
+
+	if (dw->is_playback_status)
+		dw_hdmi_audio_set_fmt(dw, &dw->fmt);
+
+	return 0;
+}
+
+static int dw_hdmi_audio_suspend(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops dw_hdmi_audio_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(dw_hdmi_audio_suspend, dw_hdmi_audio_resume)
+};
+
+static struct platform_driver dw_hdmi_audio_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.pm = &dw_hdmi_audio_pm,
+	},
+	.probe = dw_hdmi_audio_probe,
+	.remove = dw_hdmi_audio_remove,
+};
+module_platform_driver(dw_hdmi_audio_driver);
+
+MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
+MODULE_DESCRIPTION("DW dw Audio ASoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS(PLATFORM_MODULE_PREFIX DRIVER_NAME);
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 7b70619..5f092de 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1720,20 +1720,26 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
-	pdevinfo.id = PLATFORM_DEVID_AUTO;
 
-	if (hdmi_readb(hdmi, HDMI_CONFIG1_ID) & HDMI_CONFIG1_AHB) {
-		audio.phys = iores->start;
-		audio.base = hdmi->regs;
-		audio.irq = irq;
-		audio.hdmi = hdmi;
-		audio.eld = hdmi->connector.eld;
+	audio.phys = iores->start;
+	audio.base = hdmi->regs;
+	audio.irq = irq;
+	audio.hdmi = hdmi;
+	audio.eld = hdmi->connector.eld;
+
+	pdevinfo.data = &audio;
+	pdevinfo.size_data = sizeof(audio);
 
+	if (hdmi_readb(hdmi, HDMI_CONFIG1_ID) & HDMI_CONFIG1_AHB) {
 		pdevinfo.name = "dw-hdmi-ahb-audio";
-		pdevinfo.data = &audio;
-		pdevinfo.size_data = sizeof(audio);
+		pdevinfo.id = PLATFORM_DEVID_AUTO;
 		pdevinfo.dma_mask = DMA_BIT_MASK(32);
 		hdmi->audio = platform_device_register_full(&pdevinfo);
+
+	} else if (hdmi_readb(hdmi, HDMI_CONFIG0_ID) & HDMI_CONFIG0_I2S) {
+		pdevinfo.name = "dw-hdmi-ahb-audio";
+		pdevinfo.id = PLATFORM_DEVID_NONE;
+		hdmi->audio = platform_device_register_full(&pdevinfo);
 	}
 
 	dev_set_drvdata(dev, hdmi);
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw_hdmi.h
index 78e54e8..9c22377 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.h
+++ b/drivers/gpu/drm/bridge/dw_hdmi.h
@@ -545,6 +545,9 @@
 #define HDMI_I2CM_FS_SCL_LCNT_0_ADDR            0x7E12
 
 enum {
+/* CONFIG0_ID field values */
+	HDMI_CONFIG0_I2S = 0x01,
+
 /* CONFIG1_ID field values */
 	HDMI_CONFIG1_AHB = 0x01,
 
-- 
2.1.2
