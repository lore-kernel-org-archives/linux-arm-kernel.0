From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 30 Sep 2015 22:51:52 +0200
Subject: [PATCH] ASoC: pxa: pxa-pcm-lib: switch over to snd-soc-dmaengine-pcm
Message-ID: <1443646312-20099-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Mack <zonque@gmail.com>

This patch removes the old PXA DMA API usage and switches over to
generic functions provided by snd-soc-dmaengine-pcm.

More cleanups may be done on top of this, and some function stubs can
now be removed completetly. However, the intention here was to keep
the transition as small as possible.

This was tested on the mioa701 pxa27x board.

Signed-off-by: Daniel Mack <zonque@gmail.com>
[trivial change from mmp-dma to pxa-dma]
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 include/sound/pxa2xx-lib.h  |   1 -
 sound/arm/pxa2xx-ac97.c     |  13 ++-
 sound/arm/pxa2xx-pcm-lib.c  | 201 ++++++++------------------------------------
 sound/arm/pxa2xx-pcm.c      |  12 +--
 sound/arm/pxa2xx-pcm.h      |   2 -
 sound/soc/pxa/pxa2xx-ac97.c |  49 +++++++----
 sound/soc/pxa/pxa2xx-i2s.c  |   3 +
 sound/soc/pxa/pxa2xx-pcm.c  |  32 -------
 8 files changed, 85 insertions(+), 228 deletions(-)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index 56e818e4a1cb..6ef629bde164 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -12,7 +12,6 @@ extern int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream);
 extern int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
 extern snd_pcm_uframes_t pxa2xx_pcm_pointer(struct snd_pcm_substream *substream);
 extern int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream);
-extern void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id);
 extern int __pxa2xx_pcm_open(struct snd_pcm_substream *substream);
 extern int __pxa2xx_pcm_close(struct snd_pcm_substream *substream);
 extern int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 38590b322c54..fbd5dad0c484 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/pxa-dma.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -43,7 +44,11 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_reset,
 };
 
-static unsigned long pxa2xx_ac97_pcm_out_req = 12;
+static struct pxad_param pxa2xx_ac97_pcm_out_req = {
+	.prio = PXAD_PRIO_LOWEST,
+	.drcmr = 12,
+};
+
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_out = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
@@ -51,7 +56,11 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_out = {
 	.filter_data	= &pxa2xx_ac97_pcm_out_req,
 };
 
-static unsigned long pxa2xx_ac97_pcm_in_req = 11;
+static struct pxad_param pxa2xx_ac97_pcm_in_req = {
+	.prio = PXAD_PRIO_LOWEST,
+	.drcmr = 11,
+};
+
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_in = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 01f8fdc42b1b..e9b98af6b52c 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/pxa-dma.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -15,8 +16,6 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-#include <mach/dma.h>
-
 #include "pxa2xx-pcm.h"
 
 static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
@@ -31,7 +30,7 @@ static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192 - 32,
 	.periods_min		= 1,
-	.periods_max		= PAGE_SIZE/sizeof(pxa_dma_desc),
+	.periods_max		= 256,
 	.buffer_bytes_max	= 128 * 1024,
 	.fifo_size		= 32,
 };
@@ -39,65 +38,29 @@ static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
 int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *rtd = runtime->private_data;
-	size_t totsize = params_buffer_bytes(params);
-	size_t period = params_period_bytes(params);
-	pxa_dma_desc *dma_desc;
-	dma_addr_t dma_buff_phys, next_desc_phys;
-	u32 dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
+	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_dmaengine_dai_dma_data *dma_params;
+	struct dma_slave_config config;
+	int ret;
 
-	/* temporary transition hack */
-	switch (rtd->params->addr_width) {
-	case DMA_SLAVE_BUSWIDTH_1_BYTE:
-		dcmd |= DCMD_WIDTH1;
-		break;
-	case DMA_SLAVE_BUSWIDTH_2_BYTES:
-		dcmd |= DCMD_WIDTH2;
-		break;
-	case DMA_SLAVE_BUSWIDTH_4_BYTES:
-		dcmd |= DCMD_WIDTH4;
-		break;
-	default:
-		/* can't happen */
-		break;
-	}
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	if (!dma_params)
+		return 0;
 
-	switch (rtd->params->maxburst) {
-	case 8:
-		dcmd |= DCMD_BURST8;
-		break;
-	case 16:
-		dcmd |= DCMD_BURST16;
-		break;
-	case 32:
-		dcmd |= DCMD_BURST32;
-		break;
-	}
+	ret = snd_hwparams_to_dma_slave_config(substream, params, &config);
+	if (ret)
+		return ret;
 
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = totsize;
+	snd_dmaengine_pcm_set_config_from_dai_data(substream,
+			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
+			&config);
 
-	dma_desc = rtd->dma_desc_array;
-	next_desc_phys = rtd->dma_desc_array_phys;
-	dma_buff_phys = runtime->dma_addr;
-	do {
-		next_desc_phys += sizeof(pxa_dma_desc);
-		dma_desc->ddadr = next_desc_phys;
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			dma_desc->dsadr = dma_buff_phys;
-			dma_desc->dtadr = rtd->params->addr;
-		} else {
-			dma_desc->dsadr = rtd->params->addr;
-			dma_desc->dtadr = dma_buff_phys;
-		}
-		if (period > totsize)
-			period = totsize;
-		dma_desc->dcmd = dcmd | period | DCMD_ENDIRQEN;
-		dma_desc++;
-		dma_buff_phys += period;
-	} while (totsize -= period);
-	dma_desc[-1].ddadr = rtd->dma_desc_array_phys;
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret)
+		return ret;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
 	return 0;
 }
@@ -105,13 +68,6 @@ EXPORT_SYMBOL(__pxa2xx_pcm_hw_params);
 
 int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
-
-	if (rtd && rtd->params && rtd->params->filter_data) {
-		unsigned long req = *(unsigned long *) rtd->params->filter_data;
-		DRCMR(req) = 0;
-	}
-
 	snd_pcm_set_runtime_buffer(substream, NULL);
 	return 0;
 }
@@ -119,100 +75,36 @@ EXPORT_SYMBOL(__pxa2xx_pcm_hw_free);
 
 int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-	int ret = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		DDADR(prtd->dma_ch) = prtd->dma_desc_array_phys;
-		DCSR(prtd->dma_ch) = DCSR_RUN;
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		DCSR(prtd->dma_ch) &= ~DCSR_RUN;
-		break;
-
-	case SNDRV_PCM_TRIGGER_RESUME:
-		DCSR(prtd->dma_ch) |= DCSR_RUN;
-		break;
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		DDADR(prtd->dma_ch) = prtd->dma_desc_array_phys;
-		DCSR(prtd->dma_ch) |= DCSR_RUN;
-		break;
-
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
+	return snd_dmaengine_pcm_trigger(substream, cmd);
 }
 EXPORT_SYMBOL(pxa2xx_pcm_trigger);
 
 snd_pcm_uframes_t
 pxa2xx_pcm_pointer(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd = runtime->private_data;
-
-	dma_addr_t ptr = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-			 DSADR(prtd->dma_ch) : DTADR(prtd->dma_ch);
-	snd_pcm_uframes_t x = bytes_to_frames(runtime, ptr - runtime->dma_addr);
-
-	if (x == runtime->buffer_size)
-		x = 0;
-	return x;
+	return snd_dmaengine_pcm_pointer(substream);
 }
 EXPORT_SYMBOL(pxa2xx_pcm_pointer);
 
 int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-	unsigned long req;
-
-	if (!prtd || !prtd->params)
-		return 0;
-
-	if (prtd->dma_ch == -1)
-		return -EINVAL;
-
-	DCSR(prtd->dma_ch) &= ~DCSR_RUN;
-	DCSR(prtd->dma_ch) = 0;
-	DCMD(prtd->dma_ch) = 0;
-	req = *(unsigned long *) prtd->params->filter_data;
-	DRCMR(req) = prtd->dma_ch | DRCMR_MAPVLD;
-
 	return 0;
 }
 EXPORT_SYMBOL(__pxa2xx_pcm_prepare);
 
-void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
-{
-	struct snd_pcm_substream *substream = dev_id;
-	int dcsr;
-
-	dcsr = DCSR(dma_ch);
-	DCSR(dma_ch) = dcsr & ~DCSR_STOPIRQEN;
-
-	if (dcsr & DCSR_ENDINTR) {
-		snd_pcm_period_elapsed(substream);
-	} else {
-		printk(KERN_ERR "DMA error on channel %d (DCSR=%#x)\n",
-			dma_ch, dcsr);
-		snd_pcm_stop_xrun(substream);
-	}
-}
-EXPORT_SYMBOL(pxa2xx_pcm_dma_irq);
-
 int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *rtd;
+	struct snd_dmaengine_dai_dma_data *dma_params;
 	int ret;
 
 	runtime->hw = pxa2xx_pcm_hardware;
 
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	if (!dma_params)
+		return 0;
+
 	/*
 	 * For mysterious reasons (and despite what the manual says)
 	 * playback samples are lost if the DMA count is not a multiple
@@ -221,48 +113,27 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
 		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
 		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
-		goto out;
-
-	ret = -ENOMEM;
-	rtd = kzalloc(sizeof(*rtd), GFP_KERNEL);
-	if (!rtd)
-		goto out;
-	rtd->dma_desc_array =
-		dma_alloc_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-				       &rtd->dma_desc_array_phys, GFP_KERNEL);
-	if (!rtd->dma_desc_array)
-		goto err1;
+		return ret;
 
-	rtd->dma_ch = -1;
-	runtime->private_data = rtd;
-	return 0;
-
- err1:
-	kfree(rtd);
- out:
-	return ret;
+	return snd_dmaengine_pcm_open_request_chan(substream,
+					pxad_filter_fn,
+					dma_params->filter_data);
 }
 EXPORT_SYMBOL(__pxa2xx_pcm_open);
 
 int __pxa2xx_pcm_close(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *rtd = runtime->private_data;
-
-	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-			      rtd->dma_desc_array, rtd->dma_desc_array_phys);
-	kfree(rtd);
-	return 0;
+	return snd_dmaengine_pcm_close_release_chan(substream);
 }
 EXPORT_SYMBOL(__pxa2xx_pcm_close);
 
diff --git a/sound/arm/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm.c
index 83be8e3f095e..83fcfac97739 100644
--- a/sound/arm/pxa2xx-pcm.c
+++ b/sound/arm/pxa2xx-pcm.c
@@ -46,17 +46,13 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 
 	rtd->params = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		      client->playback_params : client->capture_params;
-	ret = pxa_request_dma("dma", DMA_PRIO_LOW,
-			      pxa2xx_pcm_dma_irq, substream);
-	if (ret < 0)
-		goto err2;
-	rtd->dma_ch = ret;
 
 	ret = client->startup(substream);
 	if (!ret)
-		goto out;
+		goto err2;
+
+	return 0;
 
-	pxa_free_dma(rtd->dma_ch);
  err2:
 	__pxa2xx_pcm_close(substream);
  out:
@@ -66,9 +62,7 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct pxa2xx_pcm_client *client = substream->private_data;
-	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
 
-	pxa_free_dma(rtd->dma_ch);
 	client->shutdown(substream);
 
 	return __pxa2xx_pcm_close(substream);
diff --git a/sound/arm/pxa2xx-pcm.h b/sound/arm/pxa2xx-pcm.h
index 00330985beec..8fa2b7c9e6b8 100644
--- a/sound/arm/pxa2xx-pcm.h
+++ b/sound/arm/pxa2xx-pcm.h
@@ -13,8 +13,6 @@
 struct pxa2xx_runtime_data {
 	int dma_ch;
 	struct snd_dmaengine_dai_dma_data *params;
-	struct pxa_dma_desc *dma_desc_array;
-	dma_addr_t dma_desc_array_phys;
 };
 
 struct pxa2xx_pcm_client {
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 9e4b04e0fbd1..f3de615aacd7 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/pxa-dma.h>
 
 #include <sound/core.h>
 #include <sound/ac97_codec.h>
@@ -49,7 +50,11 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_cold_reset,
 };
 
-static unsigned long pxa2xx_ac97_pcm_stereo_in_req = 11;
+static struct pxad_param pxa2xx_ac97_pcm_stereo_in_req = {
+	.prio = PXAD_PRIO_LOWEST,
+	.drcmr = 11,
+};
+
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
@@ -57,7 +62,11 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
 	.filter_data	= &pxa2xx_ac97_pcm_stereo_in_req,
 };
 
-static unsigned long pxa2xx_ac97_pcm_stereo_out_req = 12;
+static struct pxad_param pxa2xx_ac97_pcm_stereo_out_req = {
+	.prio = PXAD_PRIO_LOWEST,
+	.drcmr = 12,
+};
+
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
@@ -65,7 +74,10 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
 	.filter_data	= &pxa2xx_ac97_pcm_stereo_out_req,
 };
 
-static unsigned long pxa2xx_ac97_pcm_aux_mono_out_req = 10;
+static struct pxad_param pxa2xx_ac97_pcm_aux_mono_out_req = {
+	.prio = PXAD_PRIO_LOWEST,
+	.drcmr = 10,
+};
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_out = {
 	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
@@ -73,7 +85,10 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_out = {
 	.filter_data	= &pxa2xx_ac97_pcm_aux_mono_out_req,
 };
 
-static unsigned long pxa2xx_ac97_pcm_aux_mono_in_req = 9;
+static struct pxad_param pxa2xx_ac97_pcm_aux_mono_in_req = {
+	.prio = PXAD_PRIO_LOWEST,
+	.drcmr = 9,
+};
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_in = {
 	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
@@ -81,7 +96,10 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_in = {
 	.filter_data	= &pxa2xx_ac97_pcm_aux_mono_in_req,
 };
 
-static unsigned long pxa2xx_ac97_pcm_aux_mic_mono_req = 8;
+static struct pxad_param pxa2xx_ac97_pcm_aux_mic_mono_req = {
+	.prio = PXAD_PRIO_LOWEST,
+	.drcmr = 8,
+};
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_mic_mono_in = {
 	.addr		= __PREG(MCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
@@ -89,9 +107,8 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_mic_mono_in = {
 	.filter_data	= &pxa2xx_ac97_pcm_aux_mic_mono_req,
 };
 
-static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *cpu_dai)
+static int pxa2xx_ac97_hifi_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *cpu_dai)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
 
@@ -105,9 +122,8 @@ static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int pxa2xx_ac97_hw_aux_params(struct snd_pcm_substream *substream,
-				     struct snd_pcm_hw_params *params,
-				     struct snd_soc_dai *cpu_dai)
+static int pxa2xx_ac97_aux_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *cpu_dai)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
 
@@ -121,9 +137,8 @@ static int pxa2xx_ac97_hw_aux_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int pxa2xx_ac97_hw_mic_params(struct snd_pcm_substream *substream,
-				     struct snd_pcm_hw_params *params,
-				     struct snd_soc_dai *cpu_dai)
+static int pxa2xx_ac97_mic_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *cpu_dai)
 {
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
@@ -139,15 +154,15 @@ static int pxa2xx_ac97_hw_mic_params(struct snd_pcm_substream *substream,
 		SNDRV_PCM_RATE_48000)
 
 static const struct snd_soc_dai_ops pxa_ac97_hifi_dai_ops = {
-	.hw_params	= pxa2xx_ac97_hw_params,
+	.startup	= pxa2xx_ac97_hifi_startup,
 };
 
 static const struct snd_soc_dai_ops pxa_ac97_aux_dai_ops = {
-	.hw_params	= pxa2xx_ac97_hw_aux_params,
+	.startup	= pxa2xx_ac97_aux_startup,
 };
 
 static const struct snd_soc_dai_ops pxa_ac97_mic_dai_ops = {
-	.hw_params	= pxa2xx_ac97_hw_mic_params,
+	.startup	= pxa2xx_ac97_mic_startup,
 };
 
 /*
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 6b4e40036910..0389cf7b4b1e 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -319,6 +319,9 @@ static int pxa2xx_i2s_probe(struct snd_soc_dai *dai)
 	/* Along with FIFO servicing */
 	SAIMR &= ~(SAIMR_RFS | SAIMR_TFS);
 
+	snd_soc_dai_init_dma_data(dai, &pxa2xx_i2s_pcm_stereo_out,
+		&pxa2xx_i2s_pcm_stereo_in);
+
 	return 0;
 }
 
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 831ee37d2e3e..76ba0e55870d 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -15,8 +15,6 @@
 #include <linux/dmaengine.h>
 #include <linux/of.h>
 
-#include <mach/dma.h>
-
 #include <sound/core.h>
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>
@@ -27,11 +25,8 @@
 static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_dmaengine_dai_dma_data *dma;
-	int ret;
 
 	dma = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
@@ -40,40 +35,13 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (!dma)
 		return 0;
 
-	/* this may get called several times by oss emulation
-	 * with different params */
-	if (prtd->params == NULL) {
-		prtd->params = dma;
-		ret = pxa_request_dma("name", DMA_PRIO_LOW,
-			      pxa2xx_pcm_dma_irq, substream);
-		if (ret < 0)
-			return ret;
-		prtd->dma_ch = ret;
-	} else if (prtd->params != dma) {
-		pxa_free_dma(prtd->dma_ch);
-		prtd->params = dma;
-		ret = pxa_request_dma("name", DMA_PRIO_LOW,
-			      pxa2xx_pcm_dma_irq, substream);
-		if (ret < 0)
-			return ret;
-		prtd->dma_ch = ret;
-	}
-
 	return __pxa2xx_pcm_hw_params(substream, params);
 }
 
 static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-
 	__pxa2xx_pcm_hw_free(substream);
 
-	if (prtd->dma_ch >= 0) {
-		pxa_free_dma(prtd->dma_ch);
-		prtd->dma_ch = -1;
-		prtd->params = NULL;
-	}
-
 	return 0;
 }
 
-- 
2.1.4
