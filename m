From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 20 Nov 2012 16:38:18 +0800
Subject: [PATCH 2/2] ASoC: atmel-pcm: add dma support
In-Reply-To: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
References: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change xfer_size name to apply to PDC and DMA aswell.
Specify overrun bit in interrupt mask.
Add dmaengine specific routines and replace PDC ones in
pcm_ops if appropriate.
Uses cyclic DMA API for queuing samples.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
[voice.shen at atmel.com: align with mainline kernel, address Vinod's comments]
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel-pcm.c     |  369 +++++++++++++++++++++++++++++++++++----
 sound/soc/atmel/atmel-pcm.h     |    4 +-
 sound/soc/atmel/atmel_ssc_dai.c |   30 ++--
 3 files changed, 358 insertions(+), 45 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 40e17d1..c9d1246 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -37,7 +37,9 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/atmel_pdc.h>
+#include <linux/dmaengine.h>
 #include <linux/atmel-ssc.h>
+#include <linux/platform_data/dma-atmel.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -53,7 +55,7 @@
 /* TODO: These values were taken from the AT91 platform driver, check
  *	 them against real values for AT32
  */
-static const struct snd_pcm_hardware atmel_pcm_hardware = {
+static const struct snd_pcm_hardware atmel_pcm_pdc_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
@@ -66,6 +68,22 @@ static const struct snd_pcm_hardware atmel_pcm_hardware = {
 	.buffer_bytes_max	= 32 * 1024,
 };
 
+static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_PAUSE,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.period_bytes_min	= 256,		/* lighting DMA overhead */
+	.period_bytes_max	= 2 * 0xffff,	/* if 2 bytes format */
+	.periods_min		= 8,
+	.periods_max		= 1024,		/* no limit */
+	.buffer_bytes_max	= 64 * 1024,	/* 64KiB */
+};
+
+static const struct snd_pcm_hardware *atmel_pcm_hardware;
+
 
 /*--------------------------------------------------------------------------*\
  * Data types
@@ -77,12 +95,19 @@ struct atmel_runtime_data {
 	size_t period_size;
 
 	dma_addr_t period_ptr;		/* physical address of next period */
+	int periods;			/* period index of period_ptr */
 
 	/* PDC register save */
 	u32 pdc_xpr_save;
 	u32 pdc_xcr_save;
 	u32 pdc_xnpr_save;
 	u32 pdc_xncr_save;
+
+	/* dmaengine data */
+	struct at_dma_slave atslave;
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	struct dma_chan *dma_chan;
 };
 
 
@@ -94,7 +119,7 @@ static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 {
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = atmel_pcm_hardware.buffer_bytes_max;
+	size_t size = atmel_pcm_hardware->buffer_bytes_max;
 
 	buf->dev.type = SNDRV_DMA_TYPE_DEV;
 	buf->dev.dev = pcm->card->dev;
@@ -116,7 +141,7 @@ static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 /*--------------------------------------------------------------------------*\
  * ISR
 \*--------------------------------------------------------------------------*/
-static void atmel_pcm_dma_irq(u32 ssc_sr,
+static void atmel_pcm_pdc_irq(u32 ssc_sr,
 	struct snd_pcm_substream *substream)
 {
 	struct atmel_runtime_data *prtd = substream->runtime->private_data;
@@ -142,7 +167,7 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 		ssc_writex(params->ssc->regs, params->pdc->xpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xcr,
-			   prtd->period_size / params->pdc_xfer_size);
+			   prtd->period_size / params->data_xfer_size);
 		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
 			   params->mask->pdc_enable);
 	}
@@ -156,12 +181,152 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 		ssc_writex(params->ssc->regs, params->pdc->xnpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xncr,
-			   prtd->period_size / params->pdc_xfer_size);
+			   prtd->period_size / params->data_xfer_size);
+	}
+
+	snd_pcm_period_elapsed(substream);
+}
+
+/**
+ * atmel_pcm_dma_irq: SSC interrupt handler for DMAENGINE enabled SSC
+ *
+ * We use DMAENGINE to send/receive data to/from SSC so this ISR is only to
+ * check if any overrun occured.
+ */
+static void atmel_pcm_dma_irq(u32 ssc_sr,
+	struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+
+	if (ssc_sr & params->mask->ssc_error) {
+		if (snd_pcm_running(substream))
+			pr_warn("atmel-pcm: buffer %s on %s (SSC_SR=%#x)\n",
+				substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+				? "underrun" : "overrun", params->name,
+				ssc_sr);
+
+		/* stop RX and capture: will be enabled again at restart */
+		ssc_writex(params->ssc->regs, SSC_CR,
+				params->mask->ssc_disable);
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+
+		/* now drain RHR and read status to remove xrun condition */
+		ssc_readx(params->ssc->regs, SSC_RHR);
+		ssc_readx(params->ssc->regs, SSC_SR);
 	}
+}
+
+/*--------------------------------------------------------------------------*\
+ * DMAENGINE operations
+\*--------------------------------------------------------------------------*/
+static void audio_dma_irq(void *data)
+{
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+
+	prtd->period_ptr += prtd->period_size;
+	if (prtd->period_ptr >= prtd->dma_buffer_end)
+		prtd->period_ptr = prtd->dma_buffer;
 
 	snd_pcm_period_elapsed(substream);
 }
 
+static bool filter(struct dma_chan *chan, void *slave)
+{
+	struct at_dma_slave *sl = slave;
+
+	if (sl->dma_dev == chan->device->dev) {
+		chan->private = sl;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static int atmel_pcm_configure_dma(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+	struct ssc_device *ssc = prtd->params->ssc;
+	struct dma_slave_config slave_config;
+	enum dma_slave_buswidth buswidth;
+	struct at_dma_slave *sdata = NULL;
+	int ret;
+
+	if (ssc->pdev)
+		sdata = ssc->pdev->dev.platform_data;
+
+	if (sdata && sdata->dma_dev) {
+		dma_cap_mask_t mask;
+
+		/* Try to grab a DMA channel */
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_CYCLIC, mask);
+		prtd->dma_chan = dma_request_channel(mask, filter, sdata);
+		if (!prtd->dma_chan) {
+			pr_err("atmel-pcm: DMA channel not available\n");
+			return -EBUSY;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	if (prtd->desc)
+		dmaengine_terminate_all(prtd->dma_chan);
+
+	switch (prtd->params->data_xfer_size) {
+	case 1:
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	case 2:
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 4:
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	default:
+		goto err;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		slave_config.direction = DMA_MEM_TO_DEV;
+		slave_config.dst_addr_width = buswidth;
+		slave_config.dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
+		slave_config.dst_maxburst = buswidth;
+	} else {
+		slave_config.direction = DMA_DEV_TO_MEM;
+		slave_config.src_addr_width = buswidth;
+		slave_config.src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;
+		slave_config.src_maxburst = buswidth;
+	}
+	slave_config.device_fc = false;
+
+	if (dmaengine_slave_config(prtd->dma_chan, &slave_config)) {
+		pr_err("atmel-pcm: failed to configure dma channel\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	prtd->desc = dmaengine_prep_dma_cyclic(prtd->dma_chan,
+		prtd->dma_buffer,
+		prtd->period_size * prtd->periods,
+		prtd->period_size,
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		DMA_TO_DEVICE : DMA_FROM_DEVICE,
+		0);
+
+	prtd->desc->callback = audio_dma_irq;
+	prtd->desc->callback_param = substream;
+
+	return 0;
+
+err:
+	dma_release_channel(prtd->dma_chan);
+	return ret;
+}
 
 /*--------------------------------------------------------------------------*\
  * PCM operations
@@ -172,6 +337,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct atmel_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int ret;
 
 	/* this may get called several times by oss emulation
 	 * with different params */
@@ -180,18 +346,33 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 	runtime->dma_bytes = params_buffer_bytes(params);
 
 	prtd->params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
 
 	prtd->dma_buffer = runtime->dma_addr;
 	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
 	prtd->period_size = params_period_bytes(params);
+	prtd->periods = params_periods(params);
+
+	if (prtd->params->ssc->pdata->use_dma) {
+		ret = atmel_pcm_configure_dma(substream, params);
+		if (ret) {
+			pr_err("atmel-pcm: failed to configure dma");
+			return ret;
+		}
+
+		prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
+	} else {
+		prtd->params->dma_intr_handler = atmel_pcm_pdc_irq;
+	}
 
 	pr_debug("atmel-pcm: "
-		"hw_params: DMA for %s initialized "
+		"hw_params: %s%s for %s initialized "
 		"(dma_bytes=%u, period_size=%u)\n",
+		prtd->dma_chan ? "DMA " : "PDC",
+		prtd->dma_chan ? dma_chan_name(prtd->dma_chan) : "",
 		prtd->params->name,
 		runtime->dma_bytes,
 		prtd->period_size);
+
 	return 0;
 }
 
@@ -201,15 +382,30 @@ static int atmel_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct atmel_pcm_dma_params *params = prtd->params;
 
 	if (params != NULL) {
-		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
-			   params->mask->pdc_disable);
+		if (params->ssc->pdata->use_dma) {
+			struct dma_chan *chan = prtd->dma_chan;
+
+			if (chan) {
+				dmaengine_terminate_all(chan);
+				prtd->cookie = 0;
+				prtd->desc = NULL;
+				dma_release_channel(chan);
+				prtd->dma_chan = NULL;
+			}
+		} else {
+			ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
+				   params->mask->pdc_disable);
+		}
 		prtd->params->dma_intr_handler = NULL;
 	}
 
 	return 0;
 }
 
-static int atmel_pcm_prepare(struct snd_pcm_substream *substream)
+/*--------------------------------------------------------------------------*\
+ * PCM callbacks using PDC
+\*--------------------------------------------------------------------------*/
+static int atmel_pcm_pdc_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_runtime_data *prtd = substream->runtime->private_data;
 	struct atmel_pcm_dma_params *params = prtd->params;
@@ -221,7 +417,7 @@ static int atmel_pcm_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
+static int atmel_pcm_pdc_trigger(struct snd_pcm_substream *substream,
 	int cmd)
 {
 	struct snd_pcm_runtime *rtd = substream->runtime;
@@ -240,13 +436,13 @@ static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
 		ssc_writex(params->ssc->regs, params->pdc->xpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xcr,
-			   prtd->period_size / params->pdc_xfer_size);
+			   prtd->period_size / params->data_xfer_size);
 
 		prtd->period_ptr += prtd->period_size;
 		ssc_writex(params->ssc->regs, params->pdc->xnpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xncr,
-			   prtd->period_size / params->pdc_xfer_size);
+			   prtd->period_size / params->data_xfer_size);
 
 		pr_debug("atmel-pcm: trigger: "
 			"period_ptr=%lx, xpr=%u, "
@@ -264,7 +460,7 @@ static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
 
 		pr_debug("sr=%u imr=%u\n",
 			ssc_readx(params->ssc->regs, SSC_SR),
-			ssc_readx(params->ssc->regs, SSC_IER));
+			ssc_readx(params->ssc->regs, SSC_IMR));
 		break;		/* SNDRV_PCM_TRIGGER_START */
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -287,7 +483,7 @@ static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static snd_pcm_uframes_t atmel_pcm_pointer(
+static snd_pcm_uframes_t atmel_pcm_pdc_pointer(
 	struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -305,13 +501,102 @@ static snd_pcm_uframes_t atmel_pcm_pointer(
 	return x;
 }
 
+/*--------------------------------------------------------------------------*\
+ * PCM callbacks using DMAENGINE
+\*--------------------------------------------------------------------------*/
+static int atmel_pcm_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+
+	ssc_writex(params->ssc->regs, SSC_IDR, params->mask->ssc_error);
+	return 0;
+}
+
+static int atmel_pcm_dma_trigger(struct snd_pcm_substream *substream,
+	int cmd)
+{
+	struct snd_pcm_runtime *rtd = substream->runtime;
+	struct atmel_runtime_data *prtd = rtd->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+	dma_cookie_t cookie;
+	int ret = 0;
+
+	pr_debug("atmel-pcm: trigger %d: buffer_size = %ld, "
+		"dma_area = %p, dma_bytes = %u\n",
+		cmd, rtd->buffer_size, rtd->dma_area, rtd->dma_bytes);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+
+		if (prtd->cookie < DMA_MIN_COOKIE) {
+			cookie = dmaengine_submit(prtd->desc);
+			prtd->cookie = cookie;
+			prtd->period_ptr = prtd->dma_buffer;
+		}
+
+		pr_debug("atmel-pcm: trigger: start sr=0x%08x imr=0x%08u\n",
+			ssc_readx(params->ssc->regs, SSC_SR),
+			ssc_readx(params->ssc->regs, SSC_IMR));
+
+		/* fallback */
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		dmaengine_resume(prtd->dma_chan);
+
+		/* It not already done or comming from xrun state */
+		ssc_readx(params->ssc->regs, SSC_SR);
+		ssc_writex(params->ssc->regs, SSC_IER, params->mask->ssc_error);
+		ssc_writex(params->ssc->regs, SSC_CR, params->mask->ssc_enable);
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		pr_debug("atmel-pcm: trigger: stop cmd = %d\n", cmd);
+
+		ssc_writex(params->ssc->regs, SSC_IDR, params->mask->ssc_error);
+
+		/* fallback */
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		dmaengine_pause(prtd->dma_chan);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t atmel_pcm_dma_pointer(
+	struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+	snd_pcm_uframes_t x;
+
+	dev_vdbg(substream->pcm->card->dev, "%s: 0x%08x %ld\n",
+		__func__, prtd->period_ptr,
+		bytes_to_frames(runtime, prtd->period_ptr - prtd->dma_buffer));
+
+	x = bytes_to_frames(runtime, prtd->period_ptr - prtd->dma_buffer);
+
+	if (x >= runtime->buffer_size)
+		x = 0;
+
+	return x;
+}
+
+
+/*--------------------------------------------------------------------------*\
+ * PCM open/close/mmap
+\*--------------------------------------------------------------------------*/
 static int atmel_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct atmel_runtime_data *prtd;
 	int ret = 0;
 
-	snd_soc_set_runtime_hwparams(substream, &atmel_pcm_hardware);
+	snd_soc_set_runtime_hwparams(substream, atmel_pcm_hardware);
 
 	/* ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -352,9 +637,9 @@ static struct snd_pcm_ops atmel_pcm_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_pcm_hw_params,
 	.hw_free	= atmel_pcm_hw_free,
-	.prepare	= atmel_pcm_prepare,
-	.trigger	= atmel_pcm_trigger,
-	.pointer	= atmel_pcm_pointer,
+	.prepare	= atmel_pcm_pdc_prepare,
+	.trigger	= atmel_pcm_pdc_trigger,
+	.pointer	= atmel_pcm_pdc_pointer,
 	.mmap		= atmel_pcm_mmap,
 };
 
@@ -420,21 +705,25 @@ static int atmel_pcm_suspend(struct snd_soc_dai *dai)
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct atmel_runtime_data *prtd;
 	struct atmel_pcm_dma_params *params;
+	struct ssc_device *ssc;
 
 	if (!runtime)
 		return 0;
 
 	prtd = runtime->private_data;
 	params = prtd->params;
+	ssc = params->ssc;
 
-	/* disable the PDC and save the PDC registers */
+	if (!ssc->pdata->use_dma) {
+		/* disable the PDC and save the PDC registers */
 
-	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
+		ssc_writel(ssc->regs, PDC_PTCR,	params->mask->pdc_disable);
 
-	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
-	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
-	prtd->pdc_xnpr_save = ssc_readx(params->ssc->regs, params->pdc->xnpr);
-	prtd->pdc_xncr_save = ssc_readx(params->ssc->regs, params->pdc->xncr);
+		prtd->pdc_xpr_save = ssc_readx(ssc->regs, params->pdc->xpr);
+		prtd->pdc_xcr_save = ssc_readx(ssc->regs, params->pdc->xcr);
+		prtd->pdc_xnpr_save = ssc_readx(ssc->regs, params->pdc->xnpr);
+		prtd->pdc_xncr_save = ssc_readx(ssc->regs, params->pdc->xncr);
+	}
 
 	return 0;
 }
@@ -444,20 +733,25 @@ static int atmel_pcm_resume(struct snd_soc_dai *dai)
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct atmel_runtime_data *prtd;
 	struct atmel_pcm_dma_params *params;
+	struct ssc_device *ssc;
 
 	if (!runtime)
 		return 0;
 
 	prtd = runtime->private_data;
 	params = prtd->params;
+	ssc = params->ssc;
 
-	/* restore the PDC registers and enable the PDC */
-	ssc_writex(params->ssc->regs, params->pdc->xpr, prtd->pdc_xpr_save);
-	ssc_writex(params->ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
-	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
-	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
+	if (!ssc->pdata->use_dma) {
+		/* restore the PDC registers and enable the PDC */
+		ssc_writex(ssc->regs, params->pdc->xpr, prtd->pdc_xpr_save);
+		ssc_writex(ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
+		ssc_writex(ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
+		ssc_writex(ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
+
+		ssc_writel(ssc->regs, PDC_PTCR, params->mask->pdc_enable);
+	}
 
-	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
 	return 0;
 }
 #else
@@ -475,6 +769,19 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 
 int atmel_pcm_platform_register(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ssc_device *ssc = platform_get_drvdata(pdev);
+
+	if (ssc->pdata->use_dma) {
+		atmel_pcm_ops.prepare = atmel_pcm_dma_prepare;
+		atmel_pcm_ops.trigger = atmel_pcm_dma_trigger;
+		atmel_pcm_ops.pointer = atmel_pcm_dma_pointer;
+
+		atmel_pcm_hardware = &atmel_pcm_dma_hardware;
+	} else {
+		atmel_pcm_hardware = &atmel_pcm_pdc_hardware;
+	}
+
 	return snd_soc_register_platform(dev, &atmel_soc_platform);
 }
 EXPORT_SYMBOL(atmel_pcm_platform_register);
diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index e6d67b3..261331d 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -50,6 +50,7 @@ struct atmel_pdc_regs {
 struct atmel_ssc_mask {
 	u32	ssc_enable;		/* SSC recv/trans enable */
 	u32	ssc_disable;		/* SSC recv/trans disable */
+	u32	ssc_error;		/* SSC error conditions */
 	u32	ssc_endx;		/* SSC ENDTX or ENDRX */
 	u32	ssc_endbuf;		/* SSC TXBUFE or RXBUFF */
 	u32	pdc_enable;		/* PDC recv/trans enable */
@@ -66,7 +67,8 @@ struct atmel_ssc_mask {
  */
 struct atmel_pcm_dma_params {
 	char *name;			/* stream identifier */
-	int pdc_xfer_size;		/* PDC counter increment in bytes */
+	int data_xfer_size;		/* PDC counter increment in bytes,
+					   DMA data transfer size in bytes */
 	struct ssc_device *ssc;		/* SSC device for stream */
 	struct atmel_pdc_regs *pdc;	/* PDC receive or transmit registers */
 	struct atmel_ssc_mask *mask;	/* SSC & PDC status bits */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 7932c05..a87d6d8 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -82,6 +82,7 @@ static struct atmel_ssc_mask ssc_tx_mask = {
 static struct atmel_ssc_mask ssc_rx_mask = {
 	.ssc_enable	= SSC_BIT(CR_RXEN),
 	.ssc_disable	= SSC_BIT(CR_RXDIS),
+	.ssc_error	= SSC_BIT(SR_OVRUN),
 	.ssc_endx	= SSC_BIT(SR_ENDRX),
 	.ssc_endbuf	= SSC_BIT(SR_RXBUFF),
 	.pdc_enable	= ATMEL_PDC_RXTEN,
@@ -175,7 +176,8 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
 		if ((dma_params != NULL) &&
 			(dma_params->dma_intr_handler != NULL)) {
 			ssc_substream_mask = (dma_params->mask->ssc_endx |
-					dma_params->mask->ssc_endbuf);
+					dma_params->mask->ssc_endbuf |
+					dma_params->mask->ssc_error);
 			if (ssc_sr & ssc_substream_mask) {
 				dma_params->dma_intr_handler(ssc_sr,
 						dma_params->
@@ -368,19 +370,19 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		bits = 8;
-		dma_params->pdc_xfer_size = 1;
+		dma_params->data_xfer_size = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		bits = 16;
-		dma_params->pdc_xfer_size = 2;
+		dma_params->data_xfer_size = 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		bits = 24;
-		dma_params->pdc_xfer_size = 4;
+		dma_params->data_xfer_size = 4;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		bits = 32;
-		dma_params->pdc_xfer_size = 4;
+		dma_params->data_xfer_size = 4;
 		break;
 	default:
 		printk(KERN_WARNING "atmel_ssc_dai: unsupported PCM format");
@@ -553,15 +555,17 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		/* Reset the SSC and its PDC registers */
 		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 
-		ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
+		if (!ssc_p->ssc->pdata->use_dma) {
+			ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
 
-		ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
-		ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
+			ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
+		}
 
 		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
 				ssc_p->name, ssc_p);
-- 
1.7.9.5
