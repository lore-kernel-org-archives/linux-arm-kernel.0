From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:43 +0200
Subject: [PATCH 8/8] ASoC i.MX: switch to new DMA api
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281344743-2029-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Makefile          |    2 -
 sound/soc/imx/imx-pcm-dma-mx2.c |  177 +++++++++++++++------------------------
 sound/soc/imx/imx-ssi.c         |    8 +-
 3 files changed, 70 insertions(+), 117 deletions(-)

diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index 2d20363..87cf03c 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -1,9 +1,7 @@
 # i.MX Platform Support
 snd-soc-imx-objs := imx-ssi.o imx-pcm-fiq.o
 
-ifdef CONFIG_MACH_MX27
 snd-soc-imx-objs += imx-pcm-dma-mx2.o
-endif
 
 obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
 
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 05f19c9..c672724 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -27,117 +27,80 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <mach/dma-mx1-mx2.h>
+#include <mach/dma.h>
 
 #include "imx-ssi.h"
 
 struct imx_pcm_runtime_data {
 	int sg_count;
 	struct scatterlist *sg_list;
-	int period;
+	int period_bytes;
 	int periods;
-	unsigned long dma_addr;
 	int dma;
-	struct snd_pcm_substream *substream;
 	unsigned long offset;
 	unsigned long size;
-	unsigned long period_cnt;
 	void *buf;
 	int period_time;
 };
 
-/* Called by the DMA framework when a period has elapsed */
-static void imx_ssi_dma_progression(int channel, void *data,
-					struct scatterlist *sg)
+static void audio_dma_irq(int channel, void *data, int error)
 {
-	struct snd_pcm_substream *substream = data;
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
-	if (!sg)
-		return;
-
-	runtime = iprtd->substream->runtime;
-
-	iprtd->offset = sg->dma_address - runtime->dma_addr;
-
-	snd_pcm_period_elapsed(iprtd->substream);
-}
+	iprtd->offset += iprtd->period_bytes;
+	iprtd->offset %= iprtd->period_bytes * iprtd->periods;
 
-static void imx_ssi_dma_callback(int channel, void *data)
-{
-	pr_err("%s shouldn't be called\n", __func__);
+	snd_pcm_period_elapsed(substream);
 }
 
-static void snd_imx_dma_err_callback(int channel, void *data, int err)
-{
-	struct snd_pcm_substream *substream = data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params = 
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	int ret;
-
-	pr_err("DMA timeout on channel %d -%s%s%s%s\n",
-		 channel,
-		 err & IMX_DMA_ERR_BURST ?    " burst" : "",
-		 err & IMX_DMA_ERR_REQUEST ?  " request" : "",
-		 err & IMX_DMA_ERR_TRANSFER ? " transfer" : "",
-		 err & IMX_DMA_ERR_BUFFER ?   " buffer" : "");
-
-	imx_dma_disable(iprtd->dma);
-	ret = imx_dma_setup_sg(iprtd->dma, iprtd->sg_list, iprtd->sg_count,
-			IMX_DMA_LENGTH_LOOP, dma_params->dma_addr,
-			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			DMA_MODE_WRITE : DMA_MODE_READ);
-	if (!ret)
-		imx_dma_enable(iprtd->dma);
-}
-
-static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
+static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct imx_pcm_dma_params *dma_params;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
+	struct imx_dma_config p;
 	int ret;
 
 	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
-	iprtd->dma = imx_dma_request_by_prio(DRV_NAME, DMA_PRIO_HIGH);
+	iprtd->dma = imxdma_request(DMA_PRIO_HIGH);
 	if (iprtd->dma < 0) {
 		pr_err("Failed to claim the audio DMA\n");
-		return -ENODEV;
+		return iprtd->dma;
 	}
 
-	ret = imx_dma_setup_handlers(iprtd->dma,
-				imx_ssi_dma_callback,
-				snd_imx_dma_err_callback, substream);
-	if (ret)
-		goto out;
-
-	ret = imx_dma_setup_progression_handler(iprtd->dma,
-			imx_ssi_dma_progression);
-	if (ret) {
-		pr_err("Failed to setup the DMA handler\n");
-		goto out;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		p.word_size = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
+		p.word_size = 4;
+		break;
 	}
 
-	ret = imx_dma_config_channel(iprtd->dma,
-			IMX_DMA_MEMSIZE_16 | IMX_DMA_TYPE_FIFO,
-			IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR,
-			dma_params->dma, 1);
-	if (ret < 0) {
+	p.dma_request = dma_params->dma;
+	p.peripheral_type = IMX_DMATYPE_SSI;
+	p.burstlen = dma_params->burstsize;
+	p.dma_address = dma_params->dma_addr;
+	p.flags = IMX_DMA_SG_LOOP;
+	p.completion_handler = audio_dma_irq;
+	p.driver_data = substream;
+
+	ret = imxdma_config(iprtd->dma, &p);
+	if (ret) {
 		pr_err("Cannot configure DMA channel: %d\n", ret);
 		goto out;
 	}
 
-	imx_dma_config_burstlen(iprtd->dma, dma_params->burstsize * 2);
-
 	return 0;
 out:
-	imx_dma_free(iprtd->dma);
+	imxdma_free(iprtd->dma);
+
 	return ret;
 }
 
@@ -149,11 +112,11 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 	int i;
 	unsigned long dma_addr;
 
-	imx_ssi_dma_alloc(substream);
+	imx_ssi_dma_alloc(substream, params);
 
 	iprtd->size = params_buffer_bytes(params);
 	iprtd->periods = params_periods(params);
-	iprtd->period = params_period_bytes(params);
+	iprtd->period_bytes = params_period_bytes(params);
 	iprtd->offset = 0;
 	iprtd->period_time = HZ / (params_rate(params) /
 			params_period_size(params));
@@ -163,30 +126,33 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (iprtd->sg_count != iprtd->periods) {
 		kfree(iprtd->sg_list);
 
-		iprtd->sg_list = kcalloc(iprtd->periods + 1,
+		iprtd->sg_list = kcalloc(iprtd->periods,
 				sizeof(struct scatterlist), GFP_KERNEL);
 		if (!iprtd->sg_list)
 			return -ENOMEM;
-		iprtd->sg_count = iprtd->periods + 1;
+		iprtd->sg_count = iprtd->periods;
 	}
 
 	sg_init_table(iprtd->sg_list, iprtd->sg_count);
 	dma_addr = runtime->dma_addr;
 
+	pr_debug("%s: setting up %d sg entries with %d bytes each\n",
+		__func__, iprtd->periods, iprtd->period_bytes);
+
 	for (i = 0; i < iprtd->periods; i++) {
 		iprtd->sg_list[i].page_link = 0;
 		iprtd->sg_list[i].offset = 0;
 		iprtd->sg_list[i].dma_address = dma_addr;
-		iprtd->sg_list[i].length = iprtd->period;
-		dma_addr += iprtd->period;
+		iprtd->sg_list[i].length = iprtd->period_bytes;
+		dma_addr += iprtd->period_bytes;
 	}
 
-	/* close the loop */
-	iprtd->sg_list[iprtd->sg_count - 1].offset = 0;
-	iprtd->sg_list[iprtd->sg_count - 1].length = 0;
-	iprtd->sg_list[iprtd->sg_count - 1].page_link =
-			((unsigned long) iprtd->sg_list | 0x01) & ~0x02;
-	return 0;
+	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
+
+	return imxdma_setup_sg(iprtd->dma, iprtd->sg_list, iprtd->sg_count,
+			iprtd->period_bytes * iprtd->periods,
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			DMA_MODE_WRITE : DMA_MODE_READ);
 }
 
 static int snd_imx_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -195,7 +161,7 @@ static int snd_imx_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
 	if (iprtd->dma >= 0) {
-		imx_dma_free(iprtd->dma);
+		imxdma_free(iprtd->dma);
 		iprtd->dma = -EINVAL;
 	}
 
@@ -207,28 +173,6 @@ static int snd_imx_pcm_hw_free(struct snd_pcm_substream *substream)
 
 static int snd_imx_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	int err;
-
-	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-
-	iprtd->substream = substream;
-	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
-	iprtd->period_cnt = 0;
-
-	pr_debug("%s: buf: %p period: %d periods: %d\n",
-			__func__, iprtd->buf, iprtd->period, iprtd->periods);
-
-	err = imx_dma_setup_sg(iprtd->dma, iprtd->sg_list, iprtd->sg_count,
-			IMX_DMA_LENGTH_LOOP, dma_params->dma_addr,
-			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			DMA_MODE_WRITE : DMA_MODE_READ);
-	if (err)
-		return err;
-
 	return 0;
 }
 
@@ -241,14 +185,14 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		imx_dma_enable(iprtd->dma);
+		imxdma_enable(iprtd->dma);
 
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		imx_dma_disable(iprtd->dma);
+		imxdma_disable(iprtd->dma);
 
 		break;
 	default:
@@ -263,6 +207,9 @@ static snd_pcm_uframes_t snd_imx_pcm_pointer(struct snd_pcm_substream *substream
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
+	pr_debug("%s: %ld %ld\n", __func__, iprtd->offset,
+			bytes_to_frames(substream->runtime, iprtd->offset));
+
 	return bytes_to_frames(substream->runtime, iprtd->offset);
 }
 
@@ -279,7 +226,7 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 	.channels_max = 2,
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
-	.period_bytes_max = 16 * 1024,
+	.period_bytes_max = 65535, /* Limited by SDMA engine */
 	.periods_min = 2,
 	.periods_max = 255,
 	.fifo_size = 0,
@@ -303,8 +250,19 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int snd_imx_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
+
+	kfree(iprtd);
+
+	return 0;
+}
+
 static struct snd_pcm_ops imx_pcm_ops = {
 	.open		= snd_imx_open,
+	.close		= snd_imx_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_imx_pcm_hw_params,
 	.hw_free	= snd_imx_pcm_hw_free,
@@ -324,9 +282,8 @@ static struct snd_soc_platform imx_soc_platform_dma = {
 struct snd_soc_platform *imx_ssi_dma_mx2_init(struct platform_device *pdev,
 		struct imx_ssi *ssi)
 {
-	ssi->dma_params_tx.burstsize = DMA_TXFIFO_BURST;
-	ssi->dma_params_rx.burstsize = DMA_RXFIFO_BURST;
+	ssi->dma_params_tx.burstsize = 4;
+	ssi->dma_params_rx.burstsize = 6;
 
 	return &imx_soc_platform_dma;
 }
-
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 4fd13d0..c187fe4 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -655,12 +655,10 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	dai->name = kasprintf(GFP_KERNEL, "imx-ssi.%d", pdev->id);
 	dai->private_data = ssi;
 
-	if ((cpu_is_mx27() || cpu_is_mx21()) &&
-			!(ssi->flags & IMX_SSI_USE_AC97) &&
-			(ssi->flags & IMX_SSI_DMA)) {
-		ssi->flags |= IMX_SSI_DMA;
+	if (!(ssi->flags & IMX_SSI_USE_AC97) &&
+			(ssi->flags & IMX_SSI_DMA))
 		platform = imx_ssi_dma_mx2_init(pdev, ssi);
-	} else
+	else
 		platform = imx_ssi_fiq_init(pdev, ssi);
 
 	imx_soc_platform.pcm_ops = platform->pcm_ops;
-- 
1.7.1
