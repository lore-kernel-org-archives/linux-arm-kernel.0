From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Mon, 11 Jun 2012 18:04:38 +0800
Subject: [PATCH v2 2/5] ASoC: mmp: add audio dma support
In-Reply-To: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1339409081-10097-3-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmp-pcm handle audio dma based on soc-dmaengine
Support mmp and pxa910

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Leo Yan <leoy@marvell.com>
Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 include/linux/platform_data/mmp_audio.h |   22 +++
 sound/soc/pxa/Kconfig                   |    9 +
 sound/soc/pxa/Makefile                  |    2 +
 sound/soc/pxa/mmp-pcm.c                 |  297 +++++++++++++++++++++++++++++++
 4 files changed, 330 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/mmp_audio.h
 create mode 100644 sound/soc/pxa/mmp-pcm.c

diff --git a/include/linux/platform_data/mmp_audio.h b/include/linux/platform_data/mmp_audio.h
new file mode 100644
index 0000000..0f25d16
--- /dev/null
+++ b/include/linux/platform_data/mmp_audio.h
@@ -0,0 +1,22 @@
+/*
+ *  MMP Platform AUDIO Management
+ *
+ *  Copyright (c) 2011 Marvell Semiconductors Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#ifndef MMP_AUDIO_H
+#define MMP_AUDIO_H
+
+struct mmp_audio_platdata {
+	u32 period_max_capture;
+	u32 buffer_max_capture;
+	u32 period_max_playback;
+	u32 buffer_max_playback;
+};
+
+#endif /* MMP_AUDIO_H */
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index a0f7d3c..5d76e29 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -8,6 +8,15 @@ config SND_PXA2XX_SOC
 	  the PXA2xx AC97, I2S or SSP interface. You will also need
 	  to select the audio interfaces to support below.
 
+config SND_MMP_SOC
+	bool "Soc Audio for Marvell MMP chips"
+	depends on ARCH_MMP
+	select SND_SOC_DMAENGINE_PCM
+	select SND_ARM
+	help
+	  Say Y if you want to add support for codecs attached to
+	  the MMP SSPA interface.
+
 config SND_PXA2XX_AC97
 	tristate
 	select SND_AC97_CODEC
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index af35762..f913e9b 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -3,11 +3,13 @@ snd-soc-pxa2xx-objs := pxa2xx-pcm.o
 snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
 snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
 snd-soc-pxa-ssp-objs := pxa-ssp.o
+snd-soc-mmp-objs := mmp-pcm.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
 obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
 obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
 obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
+obj-$(CONFIG_SND_MMP_SOC) += snd-soc-mmp.o
 
 # PXA Machine Support
 snd-soc-corgi-objs := corgi.o
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
new file mode 100644
index 0000000..73ac546
--- /dev/null
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -0,0 +1,297 @@
+/*
+ * linux/sound/soc/pxa/mmp-pcm.c
+ *
+ * Copyright (C) 2011 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/platform_data/mmp_audio.h>
+#include <sound/pxa2xx-lib.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <mach/sram.h>
+#include <sound/dmaengine_pcm.h>
+
+struct mmp_dma_data {
+	int ssp_id;
+	struct resource *dma_res;
+};
+
+#define MMP_PCM_INFO (SNDRV_PCM_INFO_MMAP |	\
+		SNDRV_PCM_INFO_MMAP_VALID |	\
+		SNDRV_PCM_INFO_INTERLEAVED |	\
+		SNDRV_PCM_INFO_PAUSE |		\
+		SNDRV_PCM_INFO_RESUME)
+
+#define MMP_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE | \
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_pcm_hardware mmp_pcm_hardware[] = {
+	{
+		.info			= MMP_PCM_INFO,
+		.formats		= MMP_PCM_FORMATS,
+		.period_bytes_min	= 1024,
+		.period_bytes_max	= 2048,
+		.periods_min		= 2,
+		.periods_max		= 32,
+		.buffer_bytes_max	= 4096,
+		.fifo_size		= 32,
+	},
+	{
+		.info			= MMP_PCM_INFO,
+		.formats		= MMP_PCM_FORMATS,
+		.period_bytes_min	= 1024,
+		.period_bytes_max	= 2048,
+		.periods_min		= 2,
+		.periods_max		= 32,
+		.buffer_bytes_max	= 4096,
+		.fifo_size		= 32,
+	},
+};
+
+static int mmp_pcm_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct pxa2xx_pcm_dma_params *dma_params;
+	struct dma_slave_config slave_config;
+	int ret;
+
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	if (!dma_params)
+		return 0;
+
+	ret = snd_hwparams_to_dma_slave_config(substream, params, &slave_config);
+	if (ret)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		slave_config.dst_addr     = dma_params->dev_addr;
+		slave_config.dst_maxburst = 4;
+	} else {
+		slave_config.src_addr	  = dma_params->dev_addr;
+		slave_config.src_maxburst = 4;
+	}
+
+	ret = dmaengine_slave_config(chan, &slave_config);
+	if (ret)
+		return ret;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	return 0;
+}
+
+static bool filter(struct dma_chan *chan, void *param)
+{
+	struct mmp_dma_data *dma_data = param;
+	bool found = false;
+	char *devname;
+
+	devname = kasprintf(GFP_KERNEL, "%s.%d", dma_data->dma_res->name,
+		dma_data->ssp_id);
+	if ((strcmp(dev_name(chan->device->dev), devname) == 0) &&
+		(chan->chan_id == dma_data->dma_res->start)) {
+		found = true;
+	}
+
+	kfree(devname);
+	return found;
+}
+
+static int mmp_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct mmp_dma_data *dma_data;
+	struct resource *r;
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, substream->stream);
+	if (!r)
+		return -EBUSY;
+
+	snd_soc_set_runtime_hwparams(substream,
+				&mmp_pcm_hardware[substream->stream]);
+	dma_data = devm_kzalloc(&pdev->dev,
+			sizeof(struct mmp_dma_data), GFP_KERNEL);
+	if (dma_data == NULL)
+		return -ENOMEM;
+
+	dma_data->dma_res = r;
+	dma_data->ssp_id = cpu_dai->id;
+
+	ret = snd_dmaengine_pcm_open(substream, filter, dma_data);
+	if (ret) {
+		devm_kfree(&pdev->dev, dma_data);
+		return ret;
+	}
+
+	snd_dmaengine_pcm_set_data(substream, dma_data);
+	return 0;
+}
+
+static int mmp_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct mmp_dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
+
+	snd_dmaengine_pcm_close(substream);
+	devm_kfree(&pdev->dev, dma_data);
+	return 0;
+}
+
+static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
+			 struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long off = vma->vm_pgoff;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	return remap_pfn_range(vma, vma->vm_start,
+		__phys_to_pfn(runtime->dma_addr) + off,
+		vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+struct snd_pcm_ops mmp_pcm_ops = {
+	.open		= mmp_pcm_open,
+	.close		= mmp_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= mmp_pcm_hw_params,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= snd_dmaengine_pcm_pointer,
+	.mmap		= mmp_pcm_mmap,
+};
+
+static void mmp_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+	struct gen_pool *gpool;
+
+	gpool = sram_get_gpool("asram");
+	if (!gpool)
+		return;
+
+	for (stream = 0; stream < 2; stream++) {
+		size_t size = mmp_pcm_hardware[stream].buffer_bytes_max;
+
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+		gen_pool_free(gpool, (unsigned long)buf->area, size);
+		buf->area = NULL;
+	}
+
+	return;
+}
+
+static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm_substream *substream,
+								int stream)
+{
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = mmp_pcm_hardware[stream].buffer_bytes_max;
+	struct gen_pool *gpool;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = substream->pcm->card->dev;
+	buf->private_data = NULL;
+
+	gpool = sram_get_gpool("asram");
+	if (!gpool)
+		return -ENOMEM;
+
+	buf->area = (unsigned char *)gen_pool_alloc(gpool, size);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->addr = gen_pool_virt_to_phys(gpool, (unsigned long)buf->area);
+	buf->bytes = size;
+	return 0;
+}
+
+int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_pcm *pcm = rtd->pcm;
+	int ret = 0, stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+
+		ret = mmp_pcm_preallocate_dma_buffer(substream,	stream);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	mmp_pcm_free_dma_buffers(pcm);
+	return ret;
+}
+
+struct snd_soc_platform_driver mmp_soc_platform = {
+	.ops		= &mmp_pcm_ops,
+	.pcm_new	= mmp_pcm_new,
+	.pcm_free	= mmp_pcm_free_dma_buffers,
+};
+
+static __devinit int mmp_pcm_probe(struct platform_device *pdev)
+{
+	struct mmp_audio_platdata *pdata = pdev->dev.platform_data;
+
+	if (pdata) {
+		mmp_pcm_hardware[SNDRV_PCM_STREAM_PLAYBACK].buffer_bytes_max =
+						pdata->buffer_max_playback;
+		mmp_pcm_hardware[SNDRV_PCM_STREAM_PLAYBACK].period_bytes_max =
+						pdata->period_max_playback;
+		mmp_pcm_hardware[SNDRV_PCM_STREAM_CAPTURE].buffer_bytes_max =
+						pdata->buffer_max_capture;
+		mmp_pcm_hardware[SNDRV_PCM_STREAM_CAPTURE].period_bytes_max =
+						pdata->period_max_capture;
+	}
+	return snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
+}
+
+static int __devexit mmp_pcm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver mmp_pcm_driver = {
+	.driver = {
+		.name = "mmp-pcm-audio",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = mmp_pcm_probe,
+	.remove = __devexit_p(mmp_pcm_remove),
+};
+
+module_platform_driver(mmp_pcm_driver);
+
+MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
+MODULE_DESCRIPTION("MMP Soc Audio DMA module");
+MODULE_LICENSE("GPL");
-- 
1.7.1
