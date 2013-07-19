From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 19 Jul 2013 19:07:17 +0800
Subject: [PATCH 1/6] ASoC: sirf: add sirf platform driver which provides DMA
In-Reply-To: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

this driver uses dmaengine APIs and provides DMA to the CPU DAIs
of I2S, USP and SiRF-soc-inner.
SiRFSoC has 3 audio DAIs: I2S, USP(Universal Serial Ports) and DAI
connected to soc-inner-codec, all of them will use the same DMA
driver here.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/Kconfig         |   1 +
 sound/soc/Makefile        |   1 +
 sound/soc/sirf/Kconfig    |   4 +
 sound/soc/sirf/Makefile   |   3 +
 sound/soc/sirf/sirf-pcm.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sirf/sirf-pcm.h |  17 ++++
 6 files changed, 247 insertions(+)
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-pcm.c
 create mode 100644 sound/soc/sirf/sirf-pcm.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 45eeaa9..2581e55 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -51,6 +51,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index bc02614..e15df84 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
new file mode 100644
index 0000000..3678aed
--- /dev/null
+++ b/sound/soc/sirf/Kconfig
@@ -0,0 +1,4 @@
+config SND_SIRF_SOC
+	tristate "Platform DMA driver for the SiRF SoC chips"
+	depends on ARCH_SIRF && SND_SOC
+	select SND_SOC_DMAENGINE_PCM
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
new file mode 100644
index 0000000..f268b83
--- /dev/null
+++ b/sound/soc/sirf/Makefile
@@ -0,0 +1,3 @@
+snd-soc-sirf-objs := sirf-pcm.o
+
+obj-$(CONFIG_SND_SIRF_SOC) += snd-soc-sirf.o
diff --git a/sound/soc/sirf/sirf-pcm.c b/sound/soc/sirf/sirf-pcm.c
new file mode 100644
index 0000000..d4cb897
--- /dev/null
+++ b/sound/soc/sirf/sirf-pcm.c
@@ -0,0 +1,221 @@
+/*
+ * ALSA PCM interface for the SiRF SoC
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/sirfsoc_dma.h>
+
+#include <sound/dmaengine_pcm.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "sirf-pcm.h"
+
+static struct snd_pcm_hardware sirf_pcm_hardware = {
+	.info                   = (SNDRV_PCM_INFO_MMAP
+			| SNDRV_PCM_INFO_MMAP_VALID
+			| SNDRV_PCM_INFO_INTERLEAVED
+			| SNDRV_PCM_INFO_BLOCK_TRANSFER
+			| SNDRV_PCM_INFO_RESUME
+			| SNDRV_PCM_INFO_PAUSE),
+	.formats                = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates                  = (SNDRV_PCM_RATE_48000),
+	.rate_min               = 512,
+	.rate_max               = 115200,
+	.channels_min           = 1,
+	.channels_max           = 2,
+	.buffer_bytes_max       = 64 * 1024,
+	.period_bytes_min       = 128,
+	.period_bytes_max       = 32 * 1024,
+	.periods_min            = 2,
+	.periods_max            = 2,
+};
+
+static int sirf_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sirf_pcm_dma_data *dma_data;
+	substream->runtime->hw = sirf_pcm_hardware;
+	snd_soc_set_runtime_hwparams(substream, &sirf_pcm_hardware);
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	return snd_dmaengine_pcm_open_request_chan(substream,
+			(dma_filter_fn)sirfsoc_dma_filter_id,
+			(void *)(dma_data->dma_req));
+}
+
+static int sirf_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sirf_pcm_dma_data *dma_data;
+	struct dma_slave_config config;
+	struct dma_chan *chan;
+	int err = 0;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	chan = snd_dmaengine_pcm_get_chan(substream);
+	if (!chan)
+		return -EINVAL;
+
+	/* fills in addr_width and direction */
+	err = snd_hwparams_to_dma_slave_config(substream, params, &config);
+	if (err)
+		return err;
+
+	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+
+	config.src_addr = runtime->dma_addr;
+	config.dst_addr = runtime->dma_addr;
+	config.src_maxburst = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	config.dst_maxburst = DMA_SLAVE_BUSWIDTH_8_BYTES;
+
+	return dmaengine_slave_config(chan, &config);
+}
+
+static int sirf_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+static int sirf_pcm_mmap(struct snd_pcm_substream *substream,
+		struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	return dma_mmap_coherent(substream->pcm->card->dev, vma,
+			runtime->dma_area,
+			runtime->dma_addr,
+			runtime->dma_bytes);
+}
+
+static struct snd_pcm_ops sirf_pcm_ops = {
+	.open		= sirf_pcm_open,
+	.close		= snd_dmaengine_pcm_close_release_chan,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= sirf_pcm_hw_params,
+	.hw_free	= sirf_pcm_hw_free,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= snd_dmaengine_pcm_pointer,
+	.mmap		= sirf_pcm_mmap,
+};
+
+static void sirf_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_coherent(pcm->card->dev, buf->bytes,
+				buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static int sirf_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = sirf_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size,
+			&buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+
+	buf->bytes = size;
+
+	return 0;
+}
+
+static int sirf_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_pcm *pcm = rtd->pcm;
+	int ret;
+
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
+		ret = sirf_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
+		ret = sirf_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+
+	return 0;
+
+out:
+	sirf_pcm_free_dma_buffers(pcm);
+	return ret;
+}
+
+static struct snd_soc_platform_driver sirf_soc_platform = {
+	.ops		= &sirf_pcm_ops,
+	.pcm_new	= sirf_pcm_new,
+	.pcm_free	= sirf_pcm_free_dma_buffers,
+};
+
+static int sirf_pcm_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev,
+			&sirf_soc_platform);
+}
+
+static int sirf_pcm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id sirf_pcm_of_match[] = {
+	{ .compatible = "sirf,pcm-audio", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_pcm_of_match);
+
+static struct platform_driver sirf_pcm_driver = {
+	.driver = {
+		.name = "sirf-pcm-audio",
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_pcm_of_match,
+	},
+	.probe = sirf_pcm_probe,
+	.remove = sirf_pcm_remove,
+};
+module_platform_driver(sirf_pcm_driver);
+
+MODULE_DESCRIPTION("SiRF PCM audio interface driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/sirf/sirf-pcm.h b/sound/soc/sirf/sirf-pcm.h
new file mode 100644
index 0000000..c178016
--- /dev/null
+++ b/sound/soc/sirf/sirf-pcm.h
@@ -0,0 +1,17 @@
+/*
+ * SiRF pcm dma data struct
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __SIRF_PCM_H__
+#define __SIRF_PCM_H__
+
+struct sirf_pcm_dma_data {
+	char	*name;		/* Stream name */
+	int	dma_req;	/* DMA request line */
+};
+
+#endif
-- 
1.8.2.3
