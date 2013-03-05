From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:28 +0100
Subject: [PATCH 18/23] ASoC: samsung: convert to dmaengine API
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-19-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to build the exynos kernel with CONFIG_ARCH_MULTIPLATFORM,
we must convert all users of the Samsung private DMA interface to
the generic dmaengine API. This converts the sound/soc drivers,
breaking the older s3c platforms in the process, since they do not
support the dmaengine interface yet.

This patch must not get mainlined until mach-s3c* is also converted,
but can be used for testing in the meantime.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/samsung/ac97.c        |  15 ------
 sound/soc/samsung/dma.c         | 104 +++++++++++++++++++++-------------------
 sound/soc/samsung/dma.h         |   4 +-
 sound/soc/samsung/i2s.c         |   9 +---
 sound/soc/samsung/pcm.c         |  13 -----
 sound/soc/samsung/s3c2412-i2s.c |  10 ----
 sound/soc/samsung/s3c24xx-i2s.c |  10 ----
 sound/soc/samsung/spdif.c       |   6 ---
 8 files changed, 57 insertions(+), 114 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index c76abdf..214f454 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -39,30 +39,15 @@ struct s3c_ac97_info {
 };
 static struct s3c_ac97_info s3c_ac97;
 
-static struct s3c2410_dma_client s3c_dma_client_out = {
-	.name = "AC97 PCMOut"
-};
-
-static struct s3c2410_dma_client s3c_dma_client_in = {
-	.name = "AC97 PCMIn"
-};
-
-static struct s3c2410_dma_client s3c_dma_client_micin = {
-	.name = "AC97 MicIn"
-};
-
 static struct s3c_dma_params s3c_ac97_pcm_out = {
-	.client		= &s3c_dma_client_out,
 	.dma_size	= 4,
 };
 
 static struct s3c_dma_params s3c_ac97_pcm_in = {
-	.client		= &s3c_dma_client_in,
 	.dma_size	= 4,
 };
 
 static struct s3c_dma_params s3c_ac97_mic_in = {
-	.client		= &s3c_dma_client_micin,
 	.dma_size	= 4,
 };
 
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 21b7926..67b8dcc 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -16,14 +16,14 @@
 
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/amba/pl330.h>
 
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
 #include <asm/dma.h>
-#include <mach/hardware.h>
-#include <mach/dma.h>
 
 #include "dma.h"
 
@@ -67,12 +67,16 @@ static void audio_buffdone(void *data);
  * place a dma buffer onto the queue for the dma system
  * to handle.
  */
+
 static void dma_enqueue(struct snd_pcm_substream *substream)
 {
 	struct runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
+	unsigned long period = prtd->dma_period;
 	unsigned int limit;
-	struct samsung_dma_prep dma_info;
+	enum dma_transfer_direction direction;
+	struct dma_chan *chan = prtd->params->ch;
+	struct dma_async_tx_descriptor *desc;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -81,29 +85,30 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
 	pr_debug("%s: loaded %d, limit %d\n",
 				__func__, prtd->dma_loaded, limit);
 
-	dma_info.cap = (samsung_dma_has_circular() ? DMA_CYCLIC : DMA_SLAVE);
-	dma_info.direction =
-		(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
-		? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
-	dma_info.fp = audio_buffdone;
-	dma_info.fp_param = substream;
-	dma_info.period = prtd->dma_period;
-	dma_info.len = prtd->dma_period*limit;
+	direction = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+		     ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
 
 	while (prtd->dma_loaded < limit) {
 		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
 
-		if ((pos + dma_info.period) > prtd->dma_end) {
-			dma_info.period  = prtd->dma_end - pos;
+		if ((pos + period) > prtd->dma_end) {
+			period  = prtd->dma_end - pos;
 			pr_debug("%s: corrected dma len %ld\n",
-					__func__, dma_info.period);
+					__func__, period);
 		}
 
-		dma_info.buf = pos;
-		prtd->params->ops->prepare(prtd->params->ch, &dma_info);
+		desc = dmaengine_prep_dma_cyclic(chan, pos,
+			 prtd->dma_period*limit, period, direction,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+		if (desc) {
+			desc->callback = audio_buffdone;
+			desc->callback_param = substream;
+			dmaengine_submit(desc);
+		}
 
 		prtd->dma_loaded++;
-		pos += prtd->dma_period;
+		pos += period;
 		if (pos >= prtd->dma_end)
 			pos = prtd->dma_start;
 	}
@@ -125,13 +130,6 @@ static void audio_buffdone(void *data)
 
 		if (substream)
 			snd_pcm_period_elapsed(substream);
-
-		spin_lock(&prtd->lock);
-		if (!samsung_dma_has_circular()) {
-			prtd->dma_loaded--;
-			dma_enqueue(substream);
-		}
-		spin_unlock(&prtd->lock);
 	}
 }
 
@@ -144,8 +142,6 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 	unsigned long totbytes = params_buffer_bytes(params);
 	struct s3c_dma_params *dma =
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	struct samsung_dma_req req;
-	struct samsung_dma_config config;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -157,26 +153,37 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 	/* this may get called several times by oss emulation
 	 * with different params -HW */
 	if (prtd->params == NULL) {
+		struct dma_slave_config config;
+		dma_cap_mask_t mask;
+
 		/* prepare DMA */
 		prtd->params = dma;
 
-		pr_debug("params %p, client %p, channel %d\n", prtd->params,
-			prtd->params->client, prtd->params->channel);
-
-		prtd->params->ops = samsung_dma_get_ops();
-
-		req.cap = (samsung_dma_has_circular() ?
-			DMA_CYCLIC : DMA_SLAVE);
-		req.client = prtd->params->client;
-		config.direction =
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
-			? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
-		config.width = prtd->params->dma_size;
-		config.fifo = prtd->params->dma_addr;
-		prtd->params->ch = prtd->params->ops->request(
-				prtd->params->channel, &req, rtd->cpu_dai->dev,
-				prtd->params->ch_name);
-		prtd->params->ops->config(prtd->params->ch, &config);
+		pr_debug("params %p, channel %d\n", prtd->params,
+			 prtd->params->channel);
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_CYCLIC, mask);
+
+		prtd->params->ch = dma_request_slave_channel_compat(mask,
+			pl330_filter, (void *)prtd->params->channel,
+			rtd->cpu_dai->dev, prtd->params->ch_name);
+
+		memset(&config, 0, sizeof(struct dma_slave_config));
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			config.direction = DMA_MEM_TO_DEV;
+			config.dst_addr = prtd->params->dma_size;
+			config.dst_addr_width = prtd->params->dma_addr;
+			config.dst_maxburst = 1;
+			dmaengine_slave_config(prtd->params->ch, &config);
+		} else {
+			config.direction = DMA_DEV_TO_MEM;
+			config.src_addr = prtd->params->dma_addr;
+			config.src_addr_width = prtd->params->dma_size;
+			config.src_maxburst = 1;
+			dmaengine_slave_config(prtd->params->ch, &config);
+		}
 	}
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
@@ -203,9 +210,8 @@ static int dma_hw_free(struct snd_pcm_substream *substream)
 	snd_pcm_set_runtime_buffer(substream, NULL);
 
 	if (prtd->params) {
-		prtd->params->ops->flush(prtd->params->ch);
-		prtd->params->ops->release(prtd->params->ch,
-					prtd->params->client);
+		dmaengine_terminate_all(prtd->params->ch);
+		dma_release_channel(prtd->params->ch);
 		prtd->params = NULL;
 	}
 
@@ -225,7 +231,7 @@ static int dma_prepare(struct snd_pcm_substream *substream)
 		return 0;
 
 	/* flush the DMA channel */
-	prtd->params->ops->flush(prtd->params->ch);
+	dmaengine_terminate_all(prtd->params->ch);
 
 	prtd->dma_loaded = 0;
 	prtd->dma_pos = prtd->dma_start;
@@ -248,12 +254,12 @@ static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		prtd->state |= ST_RUNNING;
-		prtd->params->ops->trigger(prtd->params->ch);
+		dma_async_issue_pending(prtd->params->ch);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		prtd->state &= ~ST_RUNNING;
-		prtd->params->ops->stop(prtd->params->ch);
+		dmaengine_terminate_all(prtd->params->ch);
 		break;
 
 	default:
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 189a7a6..f7381be 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -13,12 +13,10 @@
 #define _S3C_AUDIO_H
 
 struct s3c_dma_params {
-	struct s3c2410_dma_client *client;	/* stream identifier */
 	int channel;				/* Channel ID */
 	dma_addr_t dma_addr;
 	int dma_size;			/* Size of the DMA transfer */
-	unsigned ch;
-	struct samsung_dma_ops *ops;
+	struct dma_chan *ch;
 	char *ch_name;
 };
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d7231e3..2eed7a3 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -18,12 +18,11 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
+#include <linux/dmaengine.h>
 
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/dma.h>
-
 #include <linux/platform_data/asoc-s3c.h>
 
 #include "dma.h"
@@ -1183,11 +1182,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
 	pri_dai->dma_capture.dma_addr = regs_base + I2SRXD;
-	pri_dai->dma_playback.client =
-		(struct s3c2410_dma_client *)&pri_dai->dma_playback;
 	pri_dai->dma_playback.ch_name = "tx";
-	pri_dai->dma_capture.client =
-		(struct s3c2410_dma_client *)&pri_dai->dma_capture;
 	pri_dai->dma_capture.ch_name = "rx";
 	pri_dai->dma_playback.dma_size = 4;
 	pri_dai->dma_capture.dma_size = 4;
@@ -1205,8 +1200,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			goto err;
 		}
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
-		sec_dai->dma_playback.client =
-			(struct s3c2410_dma_client *)&sec_dai->dma_playback;
 		sec_dai->dma_playback.ch_name = "tx-sec";
 
 		if (!np) {
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 13bab79..525b2d2 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -20,7 +20,6 @@
 #include <sound/pcm_params.h>
 
 #include <linux/platform_data/asoc-s3c.h>
-#include <mach/dma.h>
 
 #include "dma.h"
 #include "pcm.h"
@@ -132,32 +131,20 @@ struct s3c_pcm_info {
 	struct s3c_dma_params	*dma_capture;
 };
 
-static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
-	.name		= "PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c_pcm_dma_client_in = {
-	.name		= "PCM Stereo in"
-};
-
 static struct s3c_dma_params s3c_pcm_stereo_out[] = {
 	[0] = {
-		.client		= &s3c_pcm_dma_client_out,
 		.dma_size	= 4,
 	},
 	[1] = {
-		.client		= &s3c_pcm_dma_client_out,
 		.dma_size	= 4,
 	},
 };
 
 static struct s3c_dma_params s3c_pcm_stereo_in[] = {
 	[0] = {
-		.client		= &s3c_pcm_dma_client_in,
 		.dma_size	= 4,
 	},
 	[1] = {
-		.client		= &s3c_pcm_dma_client_in,
 		.dma_size	= 4,
 	},
 };
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 2213377..d43f00e 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -31,23 +31,13 @@
 #include "regs-i2s-v2.h"
 #include "s3c2412-i2s.h"
 
-static struct s3c2410_dma_client s3c2412_dma_client_out = {
-	.name		= "I2S PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c2412_dma_client_in = {
-	.name		= "I2S PCM Stereo in"
-};
-
 static struct s3c_dma_params s3c2412_i2s_pcm_stereo_out = {
-	.client		= &s3c2412_dma_client_out,
 	.channel	= DMACH_I2S_OUT,
 	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISTXD,
 	.dma_size	= 4,
 };
 
 static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
-	.client		= &s3c2412_dma_client_in,
 	.channel	= DMACH_I2S_IN,
 	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISRXD,
 	.dma_size	= 4,
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index a7b17c1..d68c23d 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -29,23 +29,13 @@
 #include "dma.h"
 #include "s3c24xx-i2s.h"
 
-static struct s3c2410_dma_client s3c24xx_dma_client_out = {
-	.name = "I2S PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c24xx_dma_client_in = {
-	.name = "I2S PCM Stereo in"
-};
-
 static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_out = {
-	.client		= &s3c24xx_dma_client_out,
 	.channel	= DMACH_I2S_OUT,
 	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	.dma_size	= 2,
 };
 
 static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_in = {
-	.client		= &s3c24xx_dma_client_in,
 	.channel	= DMACH_I2S_IN,
 	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	.dma_size	= 2,
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 5008e5b..5c78c78 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -18,7 +18,6 @@
 #include <sound/pcm_params.h>
 
 #include <linux/platform_data/asoc-s3c.h>
-#include <mach/dma.h>
 
 #include "dma.h"
 #include "spdif.h"
@@ -94,10 +93,6 @@ struct samsung_spdif_info {
 	struct s3c_dma_params	*dma_playback;
 };
 
-static struct s3c2410_dma_client spdif_dma_client_out = {
-	.name		= "S/PDIF Stereo out",
-};
-
 static struct s3c_dma_params spdif_stereo_out;
 static struct samsung_spdif_info spdif_info;
 
@@ -431,7 +426,6 @@ static int spdif_probe(struct platform_device *pdev)
 	}
 
 	spdif_stereo_out.dma_size = 2;
-	spdif_stereo_out.client = &spdif_dma_client_out;
 	spdif_stereo_out.dma_addr = mem_res->start + DATA_OUTBUF;
 	spdif_stereo_out.channel = dma_res->start;
 
-- 
1.8.1.2
