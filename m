From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 05 Jun 2012 16:20:10 +0900
Subject: [PATCH 3/3] ASoC: follow the updated samsung DMA common operations
Message-ID: <011701cd42eb$a4209940$ec61cbc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses config() function to configure DMA transmit options.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 sound/soc/samsung/dma.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index ddc6cde..f3ebc38 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -74,7 +74,7 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
 	struct runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
 	unsigned int limit;
-	struct samsung_dma_prep_info dma_info;
+	struct samsung_dma_prep dma_info;

 	pr_debug("Entered %s\n", __func__);

@@ -146,7 +146,8 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 	unsigned long totbytes = params_buffer_bytes(params);
 	struct s3c_dma_params *dma =
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	struct samsung_dma_info dma_info;
+	struct samsung_dma_req req;
+	struct samsung_dma_config config;

 	pr_debug("Entered %s\n", __func__);

@@ -166,16 +167,17 @@ static int dma_hw_params(struct snd_pcm_substream *substream,

 		prtd->params->ops = samsung_dma_get_ops();

-		dma_info.cap = (samsung_dma_has_circular() ?
+		req.cap = (samsung_dma_has_circular() ?
 			DMA_CYCLIC : DMA_SLAVE);
-		dma_info.client = prtd->params->client;
-		dma_info.direction =
+		req.client = prtd->params->client;
+		config.direction =
 			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
 			? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
-		dma_info.width = prtd->params->dma_size;
-		dma_info.fifo = prtd->params->dma_addr;
+		config.width = prtd->params->dma_size;
+		config.fifo = prtd->params->dma_addr;
 		prtd->params->ch = prtd->params->ops->request(
-				prtd->params->channel, &dma_info);
+				prtd->params->channel, &req);
+		prtd->params->ops->config(prtd->params->ch, &config);
 	}

 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
--
1.7.1
