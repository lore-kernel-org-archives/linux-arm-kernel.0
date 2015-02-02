From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 2 Feb 2015 14:44:46 +0800
Subject: [PATCH] ASoC: atmel-pcm-dma: won't check direction when configure dma
Message-ID: <1422859486-11051-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As DMA framework request DMA using direction only in prep_slave
function, (The At91 xdma driver has adapted to this request).
So won't check direction when do DMA configuration.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 sound/soc/atmel/atmel-pcm-dma.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 33fb3bb..b8e7bad 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -105,13 +105,11 @@ static int atmel_pcm_configure_dma(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		slave_config->dst_addr = ssc->phybase + SSC_THR;
-		slave_config->dst_maxburst = 1;
-	} else {
-		slave_config->src_addr = ssc->phybase + SSC_RHR;
-		slave_config->src_maxburst = 1;
-	}
+	slave_config->dst_addr = ssc->phybase + SSC_THR;
+	slave_config->dst_maxburst = 1;
+
+	slave_config->src_addr = ssc->phybase + SSC_RHR;
+	slave_config->src_maxburst = 1;
 
 	prtd->dma_intr_handler = atmel_pcm_dma_irq;
 
-- 
2.3.0.rc0
