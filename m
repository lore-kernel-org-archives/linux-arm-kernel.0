From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 25 Aug 2011 11:13:44 +0900
Subject: [PATCH v7 14/15] ASoC: Samsung: Update DMA interface
In-Reply-To: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314238425-6480-15-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to support the DMA PL330 driver that uses
DMA generic API. Samsung sound driver uses DMA generic API
if architecture supports it. Otherwise, use samsung specific
S3C-PL330 API driver to transfer PCM data.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
[kgene.kim at samsung.com: removed useless variable]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/dma.h       |   10 +-
 arch/arm/mach-s3c64xx/include/mach/dma.h       |    2 +-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |    2 +-
 sound/soc/samsung/ac97.c                       |   10 ++-
 sound/soc/samsung/dma.c                        |  146 ++++++++++--------------
 sound/soc/samsung/dma.h                        |    4 +-
 6 files changed, 78 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
index e61a91f..4e485ba 100644
--- a/arch/arm/mach-s3c2410/include/mach/dma.h
+++ b/arch/arm/mach-s3c2410/include/mach/dma.h
@@ -50,6 +50,11 @@ enum dma_ch {
 	DMACH_MAX,		/* the end entry */
 };
 
+static inline bool samsung_dma_has_circular(void)
+{
+	return false;
+}
+
 static inline bool samsung_dma_is_dmadev(void)
 {
 	return false;
@@ -202,9 +207,4 @@ struct s3c2410_dma_chan {
 
 typedef unsigned long dma_device_t;
 
-static inline bool s3c_dma_has_circular(void)
-{
-	return false;
-}
-
 #endif /* __ASM_ARCH_DMA_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/dma.h b/arch/arm/mach-s3c64xx/include/mach/dma.h
index 49c3a53..74fdf25 100644
--- a/arch/arm/mach-s3c64xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c64xx/include/mach/dma.h
@@ -58,7 +58,7 @@ enum dma_ch {
 	DMACH_MAX		/* the end */
 };
 
-static __inline__ bool s3c_dma_has_circular(void)
+static inline bool samsung_dma_has_circular(void)
 {
 	return true;
 }
diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
index 9a1dadb..2e55e59 100644
--- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -89,7 +89,7 @@ struct s3c2410_dma_client {
 	char	*name;
 };
 
-static inline bool s3c_dma_has_circular(void)
+static inline bool samsung_dma_has_circular(void)
 {
 	return true;
 }
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index f97110e..b4f9b00 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -271,7 +271,10 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+	if (!dma_data->ops)
+		dma_data->ops = samsung_dma_get_ops();
+
+	dma_data->ops->started(dma_data->channel);
 
 	return 0;
 }
@@ -317,7 +320,10 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+	if (!dma_data->ops)
+		dma_data->ops = samsung_dma_get_ops();
+
+	dma_data->ops->started(dma_data->channel);
 
 	return 0;
 }
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 9465588..851346f 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -54,7 +54,6 @@ struct runtime_data {
 	spinlock_t lock;
 	int state;
 	unsigned int dma_loaded;
-	unsigned int dma_limit;
 	unsigned int dma_period;
 	dma_addr_t dma_start;
 	dma_addr_t dma_pos;
@@ -62,77 +61,79 @@ struct runtime_data {
 	struct s3c_dma_params *params;
 };
 
+static void audio_buffdone(void *data);
+
 /* dma_enqueue
  *
  * place a dma buffer onto the queue for the dma system
  * to handle.
-*/
+ */
 static void dma_enqueue(struct snd_pcm_substream *substream)
 {
 	struct runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
 	unsigned int limit;
-	int ret;
+	struct samsung_dma_prep_info dma_info;
 
 	pr_debug("Entered %s\n", __func__);
 
-	if (s3c_dma_has_circular())
-		limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
-	else
-		limit = prtd->dma_limit;
+	limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
 
 	pr_debug("%s: loaded %d, limit %d\n",
 				__func__, prtd->dma_loaded, limit);
 
-	while (prtd->dma_loaded < limit) {
-		unsigned long len = prtd->dma_period;
+	dma_info.cap = (samsung_dma_has_circular() ? DMA_CYCLIC : DMA_SLAVE);
+	dma_info.direction =
+		(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+		? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	dma_info.fp = audio_buffdone;
+	dma_info.fp_param = substream;
+	dma_info.period = prtd->dma_period;
+	dma_info.len = prtd->dma_period*limit;
 
+	while (prtd->dma_loaded < limit) {
 		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
 
-		if ((pos + len) > prtd->dma_end) {
-			len  = prtd->dma_end - pos;
-			pr_debug("%s: corrected dma len %ld\n", __func__, len);
+		if ((pos + dma_info.period) > prtd->dma_end) {
+			dma_info.period  = prtd->dma_end - pos;
+			pr_debug("%s: corrected dma len %ld\n",
+					__func__, dma_info.period);
 		}
 
-		ret = s3c2410_dma_enqueue(prtd->params->channel,
-			substream, pos, len);
+		dma_info.buf = pos;
+		prtd->params->ops->prepare(prtd->params->ch, &dma_info);
 
-		if (ret == 0) {
-			prtd->dma_loaded++;
-			pos += prtd->dma_period;
-			if (pos >= prtd->dma_end)
-				pos = prtd->dma_start;
-		} else
-			break;
+		prtd->dma_loaded++;
+		pos += prtd->dma_period;
+		if (pos >= prtd->dma_end)
+			pos = prtd->dma_start;
 	}
 
 	prtd->dma_pos = pos;
 }
 
-static void audio_buffdone(struct s3c2410_dma_chan *channel,
-				void *dev_id, int size,
-				enum s3c2410_dma_buffresult result)
+static void audio_buffdone(void *data)
 {
-	struct snd_pcm_substream *substream = dev_id;
-	struct runtime_data *prtd;
+	struct snd_pcm_substream *substream = data;
+	struct runtime_data *prtd = substream->runtime->private_data;
 
 	pr_debug("Entered %s\n", __func__);
 
-	if (result == S3C2410_RES_ABORT || result == S3C2410_RES_ERR)
-		return;
-
-	prtd = substream->runtime->private_data;
+	if (prtd->state & ST_RUNNING) {
+		prtd->dma_pos += prtd->dma_period;
+		if (prtd->dma_pos >= prtd->dma_end)
+			prtd->dma_pos = prtd->dma_start;
 
-	if (substream)
-		snd_pcm_period_elapsed(substream);
+		if (substream)
+			snd_pcm_period_elapsed(substream);
 
-	spin_lock(&prtd->lock);
-	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
-		prtd->dma_loaded--;
-		dma_enqueue(substream);
+		spin_lock(&prtd->lock);
+		if (!samsung_dma_has_circular()) {
+			prtd->dma_loaded--;
+			dma_enqueue(substream);
+		}
+		spin_unlock(&prtd->lock);
 	}
-
-	spin_unlock(&prtd->lock);
 }
 
 static int dma_hw_params(struct snd_pcm_substream *substream,
@@ -144,8 +145,7 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 	unsigned long totbytes = params_buffer_bytes(params);
 	struct s3c_dma_params *dma =
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	int ret = 0;
-
+	struct samsung_dma_info dma_info;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -163,30 +163,26 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 		pr_debug("params %p, client %p, channel %d\n", prtd->params,
 			prtd->params->client, prtd->params->channel);
 
-		ret = s3c2410_dma_request(prtd->params->channel,
-					  prtd->params->client, NULL);
-
-		if (ret < 0) {
-			printk(KERN_ERR "failed to get dma channel\n");
-			return ret;
-		}
-
-		/* use the circular buffering if we have it available. */
-		if (s3c_dma_has_circular())
-			s3c2410_dma_setflags(prtd->params->channel,
-					     S3C2410_DMAF_CIRCULAR);
+		prtd->params->ops = samsung_dma_get_ops();
+
+		dma_info.cap = (samsung_dma_has_circular() ?
+			DMA_CYCLIC : DMA_SLAVE);
+		dma_info.client = prtd->params->client;
+		dma_info.direction =
+			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+			? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		dma_info.width = prtd->params->dma_size;
+		dma_info.fifo = prtd->params->dma_addr;
+		prtd->params->ch = prtd->params->ops->request(
+				prtd->params->channel, &dma_info);
 	}
 
-	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
-				    audio_buffdone);
-
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
 	runtime->dma_bytes = totbytes;
 
 	spin_lock_irq(&prtd->lock);
 	prtd->dma_loaded = 0;
-	prtd->dma_limit = runtime->hw.periods_min;
 	prtd->dma_period = params_period_bytes(params);
 	prtd->dma_start = runtime->dma_addr;
 	prtd->dma_pos = prtd->dma_start;
@@ -206,7 +202,8 @@ static int dma_hw_free(struct snd_pcm_substream *substream)
 	snd_pcm_set_runtime_buffer(substream, NULL);
 
 	if (prtd->params) {
-		s3c2410_dma_free(prtd->params->channel, prtd->params->client);
+		prtd->params->ops->release(prtd->params->ch,
+					prtd->params->client);
 		prtd->params = NULL;
 	}
 
@@ -225,23 +222,9 @@ static int dma_prepare(struct snd_pcm_substream *substream)
 	if (!prtd->params)
 		return 0;
 
-	/* channel needs configuring for mem=>device, increment memory addr,
-	 * sync to pclk, half-word transfers to the IIS-FIFO. */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		s3c2410_dma_devconfig(prtd->params->channel,
-				      S3C2410_DMASRC_MEM,
-				      prtd->params->dma_addr);
-	} else {
-		s3c2410_dma_devconfig(prtd->params->channel,
-				      S3C2410_DMASRC_HW,
-				      prtd->params->dma_addr);
-	}
-
-	s3c2410_dma_config(prtd->params->channel,
-			   prtd->params->dma_size);
-
 	/* flush the DMA channel */
-	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_FLUSH);
+	prtd->params->ops->flush(prtd->params->ch);
+
 	prtd->dma_loaded = 0;
 	prtd->dma_pos = prtd->dma_start;
 
@@ -265,14 +248,14 @@ static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		prtd->state |= ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
+		prtd->params->ops->trigger(prtd->params->ch);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		prtd->state &= ~ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STOP);
+		prtd->params->ops->stop(prtd->params->ch);
 		break;
 
 	default:
@@ -291,21 +274,12 @@ dma_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct runtime_data *prtd = runtime->private_data;
 	unsigned long res;
-	dma_addr_t src, dst;
 
 	pr_debug("Entered %s\n", __func__);
 
-	spin_lock(&prtd->lock);
-	s3c2410_dma_getposition(prtd->params->channel, &src, &dst);
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		res = dst - prtd->dma_start;
-	else
-		res = src - prtd->dma_start;
-
-	spin_unlock(&prtd->lock);
+	res = prtd->dma_pos - prtd->dma_start;
 
-	pr_debug("Pointer %x %x\n", src, dst);
+	pr_debug("Pointer offset: %lu\n", res);
 
 	/* we seem to be getting the odd error from the pcm library due
 	 * to out-of-bounds pointers. this is maybe due to the dma engine
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index c506592..7d1ead7 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -6,7 +6,7 @@
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
  *
- *  ALSA PCM interface for the Samsung S3C24xx CPU
+ *  ALSA PCM interface for the Samsung SoC
  */
 
 #ifndef _S3C_AUDIO_H
@@ -17,6 +17,8 @@ struct s3c_dma_params {
 	int channel;				/* Channel ID */
 	dma_addr_t dma_addr;
 	int dma_size;			/* Size of the DMA transfer */
+	unsigned ch;
+	struct samsung_dma_ops *ops;
 };
 
 #endif
-- 
1.7.1
