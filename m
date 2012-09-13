From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 13 Sep 2012 16:37:57 +0300
Subject: [PATCH v2 07/15] ASoC: omap-pcm: Select sDMA synchronization based on
 packet_size
In-Reply-To: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347543485-339-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we only have element or packet synchronization we can use the
dma_data->packet_size to select the desired mode:
if packet_size is 0 we use ELEMENT mode
if packet_size is not 0 we use PACKET mode for sDMA synchronization.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index f0feb06..02eeb2e 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -165,7 +165,12 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	memset(&dma_params, 0, sizeof(dma_params));
 	dma_params.data_type			= dma_data->data_type;
 	dma_params.trigger			= dma_data->dma_req;
-	dma_params.sync_mode			= dma_data->sync_mode;
+
+	if (dma_data->packet_size)
+		dma_params.sync_mode = OMAP_DMA_SYNC_PACKET;
+	else
+		dma_params.sync_mode = OMAP_DMA_SYNC_ELEMENT;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dma_params.src_amode		= OMAP_DMA_AMODE_POST_INC;
 		dma_params.dst_amode		= OMAP_DMA_AMODE_CONSTANT;
-- 
1.7.12
