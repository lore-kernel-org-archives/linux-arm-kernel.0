From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:45 +0800
Subject: [PATCH 09/12] ASoC: dmaengine_pcm: support use of generic DMA helper
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With generic DMA device tree binding and helper function
dma_request_slave_channel() in place, dmaengine_pcm should support
that in requesting DMA channel for users that support generic DMA
device tree binding.

Instead of inventing a new API, it defines the parameters needed by
dma_request_slave_channel() into struct snd_dma_channel_params,
interprets filter_data into snd_dma_channel_params, and calls the
helper in case that dmaengine_pcm users pass in a NULL filter_fn.

Then, dmaengine_pcm users can call snd_dmaengine_pcm_open() with NULL
filter_fn and snd_dma_channel_params being filter_data to direct the
API to request DMA channel using generic DMA helper.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
 include/sound/dmaengine_pcm.h |    5 +++++
 sound/soc/soc-dmaengine-pcm.c |   19 +++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b877334..6c0f795 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -18,6 +18,11 @@
 #include <sound/pcm.h>
 #include <linux/dmaengine.h>
 
+struct snd_dma_channel_params {
+	struct device *dev;
+	char *name;
+};
+
 /**
  * snd_pcm_substream_to_dma_direction - Get dma_transfer_direction for a PCM
  *   substream
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 111b7d92..7ef8034 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -247,12 +247,19 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
 static int dmaengine_pcm_request_channel(struct dmaengine_pcm_runtime_data *prtd,
 	dma_filter_fn filter_fn, void *filter_data)
 {
-	dma_cap_mask_t mask;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_cap_set(DMA_CYCLIC, mask);
-	prtd->dma_chan = dma_request_channel(mask, filter_fn, filter_data);
+	if (filter_fn) {
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		dma_cap_set(DMA_CYCLIC, mask);
+		prtd->dma_chan = dma_request_channel(mask, filter_fn,
+						     filter_data);
+	} else {
+		struct snd_dma_channel_params *params = filter_data;
+		prtd->dma_chan = dma_request_slave_channel(params->dev,
+							   params->name);
+	}
 
 	if (!prtd->dma_chan)
 		return -ENXIO;
-- 
1.7.9.5
