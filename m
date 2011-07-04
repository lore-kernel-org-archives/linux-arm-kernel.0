From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  4 Jul 2011 21:18:35 +0900
Subject: [PATCH 7/7] ASoC: Samsung: Update DMA interface
In-Reply-To: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309781915-31549-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds to support the DMA PL330 driver that uses
DMA generic API. Samsung sound driver uses DMA generic API
if architecture supports it. Otherwise, use samsung specific
S3C-PL330 API driver to transfer PCM data.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/dma.h       |    2 +-
 arch/arm/mach-s3c64xx/include/mach/dma.h       |    2 +-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    2 +-
 sound/soc/samsung/ac97.c                       |    4 +
 sound/soc/samsung/dma.c                        |  204 +++++++++++++++++++++++-
 sound/soc/samsung/dma.h                        |    4 +
 6 files changed, 211 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
index b2b2a5b..e2db38b 100644
--- a/arch/arm/mach-s3c2410/include/mach/dma.h
+++ b/arch/arm/mach-s3c2410/include/mach/dma.h
@@ -196,7 +196,7 @@ struct s3c2410_dma_chan {
 
 typedef unsigned long dma_device_t;
 
-static inline bool s3c_dma_has_circular(void)
+static inline bool dma_has_circular(void)
 {
 	return false;
 }
diff --git a/arch/arm/mach-s3c64xx/include/mach/dma.h b/arch/arm/mach-s3c64xx/include/mach/dma.h
index 0a5d926..d752e27 100644
--- a/arch/arm/mach-s3c64xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c64xx/include/mach/dma.h
@@ -58,7 +58,7 @@ enum dma_ch {
 	DMACH_MAX		/* the end */
 };
 
-static __inline__ bool s3c_dma_has_circular(void)
+static inline bool dma_has_circular(void)
 {
 	return true;
 }
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index 1122c8b..4f19eb3 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -98,7 +98,7 @@ enum dma_ch {
 	DMACH_MAX,
 };
 
-static inline bool s3c_dma_has_circular(void)
+static inline bool dma_has_circular(void)
 {
 	return true;
 }
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index f97110e..ec6b3dd 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -271,7 +271,9 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
+#if !defined(CONFIG_DMADEV_PL330)
 	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+#endif
 
 	return 0;
 }
@@ -317,7 +319,9 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
+#if !defined(CONFIG_DMADEV_PL330)
 	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+#endif
 
 	return 0;
 }
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 5cb3b88..6ba0632 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -17,6 +17,11 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 
+#if defined(CONFIG_DMADEV_PL330)
+#include <linux/dmaengine.h>
+#include <linux/amba/pl330.h>
+#endif
+
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
@@ -62,6 +67,103 @@ struct runtime_data {
 	struct s3c_dma_params *params;
 };
 
+#if defined(CONFIG_DMADEV_PL330)
+static bool filter(struct dma_chan *chan, void *param)
+{
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)param;
+	struct runtime_data *prtd = substream->runtime->private_data;
+
+	struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
+
+	if (peri->peri_id != prtd->params->channel)
+		return false;
+
+	/* dma client should fill fifo_addr */
+	peri->fifo_addr = prtd->params->dma_addr;
+
+	return true;
+}
+
+static void audio_buffdone(void *data)
+{
+	struct snd_pcm_substream *substream = data;
+	struct runtime_data *prtd;
+	struct dma_chan *chan;
+
+	prtd = substream->runtime->private_data;
+
+	chan = prtd->params->chan;
+	prtd->params->desc =
+		chan->device->device_prep_dma_cyclic(
+		chan, prtd->dma_pos, prtd->dma_period, prtd->dma_period,
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (!prtd->params->desc)
+		dev_err(&chan->dev->device, "cannot prepare cyclic dma\n");
+
+	prtd->params->desc->callback = audio_buffdone;
+	prtd->params->desc->callback_param = substream;
+	dmaengine_submit(prtd->params->desc);
+
+	prtd->dma_pos += prtd->dma_period;
+	if (prtd->dma_pos >= prtd->dma_end)
+		prtd->dma_pos = prtd->dma_start;
+
+	if (substream)
+		snd_pcm_period_elapsed(substream);
+}
+
+/* dma_enqueue
+ *
+ * place a dma buffer onto the queue for the dma system
+ * to handle.
+ */
+static void dma_enqueue(struct snd_pcm_substream *substream)
+{
+	struct runtime_data *prtd = substream->runtime->private_data;
+	dma_addr_t pos = prtd->dma_pos;
+	unsigned int limit;
+	struct dma_chan *chan = prtd->params->chan;
+
+	pr_debug("Entered %s\n", __func__);
+
+	limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
+
+	chan = prtd->params->chan;
+
+	while (prtd->dma_loaded < limit) {
+		unsigned long len = prtd->dma_period;
+
+		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
+
+		if ((pos + len) > prtd->dma_end) {
+			len  = prtd->dma_end - pos;
+			pr_debug("%s: corrected dma len %ld\n",
+					__func__, len);
+		}
+
+		prtd->params->desc =
+			chan->device->device_prep_dma_cyclic(
+			chan, pos, prtd->dma_period, prtd->dma_period,
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		if (!prtd->params->desc)
+			dev_err(&chan->dev->device, "cannot prepare cyclic dma\n");
+
+		prtd->params->desc->callback = audio_buffdone;
+		prtd->params->desc->callback_param = substream;
+		dmaengine_submit(prtd->params->desc);
+
+		prtd->dma_loaded++;
+		pos += prtd->dma_period;
+		if (pos >= prtd->dma_end)
+			pos = prtd->dma_start;
+	}
+
+	prtd->dma_pos = pos;
+}
+
+#else
 /* dma_enqueue
  *
  * place a dma buffer onto the queue for the dma system
@@ -76,7 +178,7 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
 
 	pr_debug("Entered %s\n", __func__);
 
-	if (s3c_dma_has_circular())
+	if (dma_has_circular())
 		limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
 	else
 		limit = prtd->dma_limit;
@@ -127,13 +229,14 @@ static void audio_buffdone(struct s3c2410_dma_chan *channel,
 		snd_pcm_period_elapsed(substream);
 
 	spin_lock(&prtd->lock);
-	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
+	if (prtd->state & ST_RUNNING && !dma_has_circular()) {
 		prtd->dma_loaded--;
 		dma_enqueue(substream);
 	}
 
 	spin_unlock(&prtd->lock);
 }
+#endif /* CONFIG_DMADEV_PL330 */
 
 static int dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
@@ -146,6 +249,8 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	int ret = 0;
 
+#if defined(CONFIG_DMADEV_PL330)
+	dma_cap_mask_t mask;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -154,6 +259,28 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 	if (!dma)
 		return 0;
 
+	if (prtd->params == NULL) {
+		/* prepare DMA */
+		prtd->params = dma;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		dma_cap_set(DMA_CYCLIC, mask);
+		prtd->params->chan =
+			dma_request_channel(mask, filter, substream);
+		if (!prtd->params->chan) {
+			printk(KERN_ERR "failed to get dma channel\n");
+			return ret;
+		}
+	}
+#else
+	pr_debug("Entered %s\n", __func__);
+
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	if (!dma)
+		return 0;
+
 	/* this may get called several times by oss emulation
 	 * with different params -HW */
 	if (prtd->params == NULL) {
@@ -172,14 +299,14 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		/* use the circular buffering if we have it available. */
-		if (s3c_dma_has_circular())
+		if (dma_has_circular())
 			s3c2410_dma_setflags(prtd->params->channel,
 					     S3C2410_DMAF_CIRCULAR);
 	}
 
 	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
 				    audio_buffdone);
-
+#endif /* CONFIG_DMADEV_PL330 */
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
 	runtime->dma_bytes = totbytes;
@@ -206,7 +333,11 @@ static int dma_hw_free(struct snd_pcm_substream *substream)
 	snd_pcm_set_runtime_buffer(substream, NULL);
 
 	if (prtd->params) {
+#if defined(CONFIG_DMADEV_PL330)
+		dma_release_channel(prtd->params->chan);
+#else
 		s3c2410_dma_free(prtd->params->channel, prtd->params->client);
+#endif
 		prtd->params = NULL;
 	}
 
@@ -218,6 +349,33 @@ static int dma_prepare(struct snd_pcm_substream *substream)
 	struct runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
 
+#if defined(CONFIG_DMADEV_PL330)
+	struct dma_chan *chan = prtd->params->chan;
+	struct dma_slave_config slave_config;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	if (!prtd->params)
+		return 0;
+
+	ret = dmaengine_terminate_all(chan);
+	if (ret)
+		dev_err(&chan->dev->device, "cannot flush dma channel\n");
+
+	memset(&slave_config, 0, sizeof(struct dma_slave_config));
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		slave_config.direction = DMA_TO_DEVICE;
+		slave_config.dst_addr_width = prtd->params->dma_size;
+	} else {
+		slave_config.direction = DMA_FROM_DEVICE;
+		slave_config.src_addr_width = prtd->params->dma_size;
+	}
+	ret = dmaengine_slave_config(chan, &slave_config);
+	if (ret)
+		dev_err(&chan->dev->device, "cannot config dma channel\n");
+#else
 	pr_debug("Entered %s\n", __func__);
 
 	/* return if this is a bufferless transfer e.g.
@@ -242,6 +400,7 @@ static int dma_prepare(struct snd_pcm_substream *substream)
 
 	/* flush the DMA channel */
 	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_FLUSH);
+#endif	/* CONFIG_DMADEV_PL330 */
 	prtd->dma_loaded = 0;
 	prtd->dma_pos = prtd->dma_start;
 
@@ -256,6 +415,33 @@ static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
 
+#if defined(CONFIG_DMADEV_PL330)
+	struct dma_chan *chan = prtd->params->chan;
+
+	pr_debug("Entered %s\n", __func__);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		prtd->state |= ST_RUNNING;
+		dma_async_issue_pending(prtd->params->chan);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		prtd->state &= ~ST_RUNNING;
+		ret = dmaengine_terminate_all(chan);
+		if (ret)
+			dev_err(&chan->dev->device, "cannot flush dma channel\n");
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+#else
 	pr_debug("Entered %s\n", __func__);
 
 	spin_lock(&prtd->lock);
@@ -281,6 +467,7 @@ static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 
 	spin_unlock(&prtd->lock);
+#endif /* CONFIG_DMADEV_PL330 */
 
 	return ret;
 }
@@ -291,6 +478,14 @@ dma_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct runtime_data *prtd = runtime->private_data;
 	unsigned long res;
+
+#if defined(CONFIG_DMADEV_PL330)
+	pr_debug("Entered %s\n", __func__);
+
+	res = prtd->dma_pos - prtd->dma_start;
+
+	pr_debug("Pointer offset: %lu\n", res);
+#else
 	dma_addr_t src, dst;
 
 	pr_debug("Entered %s\n", __func__);
@@ -306,6 +501,7 @@ dma_pointer(struct snd_pcm_substream *substream)
 	spin_unlock(&prtd->lock);
 
 	pr_debug("Pointer %x %x\n", src, dst);
+#endif /* CONFIG_DMADEV_PL330 */
 
 	/* we seem to be getting the odd error from the pcm library due
 	 * to out-of-bounds pointers. this is maybe due to the dma engine
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index c506592..b6fae7e 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -17,6 +17,10 @@ struct s3c_dma_params {
 	int channel;				/* Channel ID */
 	dma_addr_t dma_addr;
 	int dma_size;			/* Size of the DMA transfer */
+#ifdef CONFIG_DMADEV_PL330
+	struct dma_chan *chan;
+	struct dma_async_tx_descriptor *desc;
+#endif
 };
 
 #endif
-- 
1.7.1
