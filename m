From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 23 Nov 2012 14:14:16 +0800
Subject: [PATCH 2/3] ASoC: atmel-pcm: prepare for adding dma support
In-Reply-To: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1353651257-2476-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change xfer_size name to apply to PDC and DMA aswell.
Specify overrun bit in interrupt mask.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
[voice.shen at atmel.com: split as one patch]
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel-pcm.c     |   36 ++++++++++++++++++++----------------
 sound/soc/atmel/atmel-pcm.h     |    4 +++-
 sound/soc/atmel/atmel_ssc_dai.c |   30 +++++++++++++++++-------------
 3 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 40e17d1..a3471e9 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -53,7 +53,7 @@
 /* TODO: These values were taken from the AT91 platform driver, check
  *	 them against real values for AT32
  */
-static const struct snd_pcm_hardware atmel_pcm_hardware = {
+static const struct snd_pcm_hardware atmel_pcm_pdc_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
@@ -66,6 +66,8 @@ static const struct snd_pcm_hardware atmel_pcm_hardware = {
 	.buffer_bytes_max	= 32 * 1024,
 };
 
+static const struct snd_pcm_hardware *atmel_pcm_hardware;
+
 
 /*--------------------------------------------------------------------------*\
  * Data types
@@ -94,7 +96,7 @@ static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 {
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = atmel_pcm_hardware.buffer_bytes_max;
+	size_t size = atmel_pcm_hardware->buffer_bytes_max;
 
 	buf->dev.type = SNDRV_DMA_TYPE_DEV;
 	buf->dev.dev = pcm->card->dev;
@@ -116,7 +118,7 @@ static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 /*--------------------------------------------------------------------------*\
  * ISR
 \*--------------------------------------------------------------------------*/
-static void atmel_pcm_dma_irq(u32 ssc_sr,
+static void atmel_pcm_pdc_irq(u32 ssc_sr,
 	struct snd_pcm_substream *substream)
 {
 	struct atmel_runtime_data *prtd = substream->runtime->private_data;
@@ -142,7 +144,7 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 		ssc_writex(params->ssc->regs, params->pdc->xpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xcr,
-			   prtd->period_size / params->pdc_xfer_size);
+			   prtd->period_size / params->data_xfer_size);
 		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
 			   params->mask->pdc_enable);
 	}
@@ -156,7 +158,7 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 		ssc_writex(params->ssc->regs, params->pdc->xnpr,
 			   prtd->period_ptr);
 		ssc_writex(params->ssc->regs, params->pdc->xncr,
-			   prtd->period_size / params->pdc_xfer_size);
+			   prtd->period_size / params->data_xfer_size);
 	}
 
 	snd_pcm_period_elapsed(substream);
@@ -180,7 +182,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 	runtime->dma_bytes = params_buffer_bytes(params);
 
 	prtd->params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
+	prtd->params->dma_intr_handler = atmel_pcm_pdc_irq;
 
 	prtd->dma_buffer = runtime->dma_addr;
 	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
@@ -209,7 +211,7 @@ static int atmel_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int atmel_pcm_prepare(struct snd_pcm_substream *substream)
+static int atmel_pcm_pdc_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_runtime_data *prtd = substream->runtime->private_data;
 	struct atmel_pcm_dma_params *params = prtd->params;
@@ -221,7 +223,7 @@ static int atmel_pcm_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
+static int atmel_pcm_pdc_trigger(struct snd_pcm_substream *substream,
 	int cmd)
 {
 	struct snd_pcm_runtime *rtd = substream->runtime;
@@ -240,13 +242,13 @@ static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
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
@@ -264,7 +266,7 @@ static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
 
 		pr_debug("sr=%u imr=%u\n",
 			ssc_readx(params->ssc->regs, SSC_SR),
-			ssc_readx(params->ssc->regs, SSC_IER));
+			ssc_readx(params->ssc->regs, SSC_IMR));
 		break;		/* SNDRV_PCM_TRIGGER_START */
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -287,7 +289,7 @@ static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static snd_pcm_uframes_t atmel_pcm_pointer(
+static snd_pcm_uframes_t atmel_pcm_pdc_pointer(
 	struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -311,7 +313,7 @@ static int atmel_pcm_open(struct snd_pcm_substream *substream)
 	struct atmel_runtime_data *prtd;
 	int ret = 0;
 
-	snd_soc_set_runtime_hwparams(substream, &atmel_pcm_hardware);
+	snd_soc_set_runtime_hwparams(substream, atmel_pcm_hardware);
 
 	/* ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -352,9 +354,9 @@ static struct snd_pcm_ops atmel_pcm_ops = {
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
 
@@ -475,6 +477,8 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 
 int atmel_pcm_platform_register(struct device *dev)
 {
+	atmel_pcm_hardware = &atmel_pcm_pdc_hardware;
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
