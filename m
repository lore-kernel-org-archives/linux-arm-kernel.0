From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 23 Nov 2012 14:14:17 +0800
Subject: [PATCH 3/3] ASoC: atmel-pcm: add dma support
In-Reply-To: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dmaengine specific routines and replace PDC ones in
pcm_ops if appropriate.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
[voice.shen at atmel.com: adapt to soc dmaengine framework]
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel-pcm.c |  215 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 201 insertions(+), 14 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index a3471e9..d18a241 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -37,15 +37,19 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/atmel_pdc.h>
+#include <linux/dmaengine.h>
 #include <linux/atmel-ssc.h>
+#include <linux/platform_data/dma-atmel.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include "atmel-pcm.h"
 
+static int use_dma;
 
 /*--------------------------------------------------------------------------*\
  * Hardware definition
@@ -66,6 +70,20 @@ static const struct snd_pcm_hardware atmel_pcm_pdc_hardware = {
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
 static const struct snd_pcm_hardware *atmel_pcm_hardware;
 
 
@@ -85,6 +103,9 @@ struct atmel_runtime_data {
 	u32 pdc_xcr_save;
 	u32 pdc_xnpr_save;
 	u32 pdc_xncr_save;
+
+	/* dmaengine data */
+	struct at_dma_slave atslave;
 };
 
 
@@ -164,6 +185,101 @@ static void atmel_pcm_pdc_irq(u32 ssc_sr,
 	snd_pcm_period_elapsed(substream);
 }
 
+/**
+ * atmel_pcm_dma_irq: SSC interrupt handler for DMAENGINE enabled SSC
+ *
+ * We use DMAENGINE to send/receive data to/from SSC so this ISR is only to
+ * check if any overrun occured.
+ */
+static void atmel_pcm_dma_irq(u32 ssc_sr,
+	struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = snd_dmaengine_pcm_get_data(substream);
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
+	}
+}
+
+/*--------------------------------------------------------------------------*\
+ * DMAENGINE operations
+\*--------------------------------------------------------------------------*/
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
+	struct dma_chan *dma_chan;
+	struct dma_slave_config slave_config;
+	struct at_dma_slave *sdata = NULL;
+	int ret;
+
+	if (ssc->pdev)
+		sdata = ssc->pdev->dev.platform_data;
+
+	ret = snd_dmaengine_pcm_open(substream, filter, sdata);
+	if (ret) {
+		pr_err("atmel-pcm: dmaengine pcm open failed\n");
+		return -EINVAL;
+	}
+	snd_dmaengine_pcm_set_data(substream, prtd);
+
+	ret = snd_hwparams_to_dma_slave_config(substream, params,
+			&slave_config);
+	if (ret) {
+		pr_err("atmel-pcm: hwparams to dma slave configure failed\n");
+		goto err;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		slave_config.dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
+		slave_config.dst_maxburst = 1;
+	} else {
+		slave_config.src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;
+		slave_config.src_maxburst = 1;
+	}
+	slave_config.device_fc = false;
+
+	dma_chan = snd_dmaengine_pcm_get_chan(substream);
+	if (dmaengine_slave_config(dma_chan, &slave_config)) {
+		pr_err("atmel-pcm: failed to configure dma channel\n");
+		ret = -EBUSY;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	snd_dmaengine_pcm_close(substream);
+	return ret;
+}
 
 /*--------------------------------------------------------------------------*\
  * PCM operations
@@ -174,43 +290,74 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct atmel_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct dma_chan *dma_chan = NULL;
+	int ret;
 
 	/* this may get called several times by oss emulation
 	 * with different params */
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = params_buffer_bytes(params);
 
 	prtd->params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	prtd->params->dma_intr_handler = atmel_pcm_pdc_irq;
 
 	prtd->dma_buffer = runtime->dma_addr;
 	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
 	prtd->period_size = params_period_bytes(params);
 
+	if (use_dma) {
+		ret = atmel_pcm_configure_dma(substream, params);
+		if (ret) {
+			pr_err("atmel-pcm: failed to configure dma");
+			return ret;
+		}
+
+		dma_chan = snd_dmaengine_pcm_get_chan(substream);
+
+		prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
+	} else {
+		prtd->params->dma_intr_handler = atmel_pcm_pdc_irq;
+	}
+
 	pr_debug("atmel-pcm: "
-		"hw_params: DMA for %s initialized "
+		"hw_params: %s%s for %s initialized "
 		"(dma_bytes=%u, period_size=%u)\n",
+		dma_chan ? "DMA " : "PDC",
+		dma_chan ? dma_chan_name(dma_chan) : "",
 		prtd->params->name,
 		runtime->dma_bytes,
 		prtd->period_size);
+
 	return 0;
 }
 
 static int atmel_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	struct atmel_runtime_data *prtd = substream->runtime->private_data;
-	struct atmel_pcm_dma_params *params = prtd->params;
+	struct atmel_runtime_data *prtd;
+	struct atmel_pcm_dma_params *params;
 
-	if (params != NULL) {
-		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
-			   params->mask->pdc_disable);
-		prtd->params->dma_intr_handler = NULL;
+	if (use_dma) {
+		prtd = snd_dmaengine_pcm_get_data(substream);
+		params = prtd->params;
+
+		if (params != NULL)
+			prtd->params->dma_intr_handler = NULL;
+	} else {
+		prtd = substream->runtime->private_data;
+		params = prtd->params;
+
+		if (params != NULL) {
+			ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
+				   params->mask->pdc_disable);
+			prtd->params->dma_intr_handler = NULL;
+		}
 	}
 
 	return 0;
 }
 
+/*--------------------------------------------------------------------------*\
+ * PCM callbacks using PDC
+\*--------------------------------------------------------------------------*/
 static int atmel_pcm_pdc_prepare(struct snd_pcm_substream *substream)
 {
 	struct atmel_runtime_data *prtd = substream->runtime->private_data;
@@ -307,6 +454,22 @@ static snd_pcm_uframes_t atmel_pcm_pdc_pointer(
 	return x;
 }
 
+/*--------------------------------------------------------------------------*\
+ * PCM callbacks using DMAENGINE
+\*--------------------------------------------------------------------------*/
+static int atmel_pcm_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = snd_dmaengine_pcm_get_data(substream);
+	struct atmel_pcm_dma_params *params = prtd->params;
+
+	ssc_writex(params->ssc->regs, SSC_IER, params->mask->ssc_error);
+	ssc_writex(params->ssc->regs, SSC_CR, params->mask->ssc_enable);
+	return 0;
+}
+
+/*--------------------------------------------------------------------------*\
+ * PCM open/close/mmap
+\*--------------------------------------------------------------------------*/
 static int atmel_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -334,7 +497,14 @@ static int atmel_pcm_open(struct snd_pcm_substream *substream)
 
 static int atmel_pcm_close(struct snd_pcm_substream *substream)
 {
-	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_runtime_data *prtd;
+
+	if (use_dma) {
+		prtd = snd_dmaengine_pcm_get_data(substream);
+		snd_dmaengine_pcm_close(substream);
+	} else {
+		prtd = substream->runtime->private_data;
+	}
 
 	kfree(prtd);
 	return 0;
@@ -426,12 +596,14 @@ static int atmel_pcm_suspend(struct snd_soc_dai *dai)
 	if (!runtime)
 		return 0;
 
+	if (!use_dma)
+		return 0;
+
 	prtd = runtime->private_data;
 	params = prtd->params;
 
 	/* disable the PDC and save the PDC registers */
-
-	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
+	ssc_writel(params->ssc->regs, PDC_PTCR,	params->mask->pdc_disable);
 
 	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
 	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
@@ -450,6 +622,9 @@ static int atmel_pcm_resume(struct snd_soc_dai *dai)
 	if (!runtime)
 		return 0;
 
+	if (use_dma)
+		return 0;
+
 	prtd = runtime->private_data;
 	params = prtd->params;
 
@@ -458,8 +633,8 @@ static int atmel_pcm_resume(struct snd_soc_dai *dai)
 	ssc_writex(params->ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
 	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
 	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
-
 	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
+
 	return 0;
 }
 #else
@@ -477,7 +652,19 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 
 int atmel_pcm_platform_register(struct device *dev)
 {
-	atmel_pcm_hardware = &atmel_pcm_pdc_hardware;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ssc_device *ssc = platform_get_drvdata(pdev);
+
+	if (ssc->pdata->use_dma) {
+		use_dma = 1;
+		atmel_pcm_ops.prepare = atmel_pcm_dma_prepare;
+		atmel_pcm_ops.trigger = snd_dmaengine_pcm_trigger;
+		atmel_pcm_ops.pointer = snd_dmaengine_pcm_pointer_no_residue;
+
+		atmel_pcm_hardware = &atmel_pcm_dma_hardware;
+	} else {
+		atmel_pcm_hardware = &atmel_pcm_pdc_hardware;
+	}
 
 	return snd_soc_register_platform(dev, &atmel_soc_platform);
 }
-- 
1.7.9.5
