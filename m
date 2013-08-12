From: zonque@gmail.com (Daniel Mack)
Date: Mon, 12 Aug 2013 10:42:40 +0200
Subject: [PATCH 4/5] ASoC: pxa: pxa-ssp: set dma filter data from startup hook
In-Reply-To: <1376296961-20564-1-git-send-email-zonque@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
Message-ID: <1376296961-20564-5-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new dmaengine implementation, the filter_data parameter has
to be set earlier, from pxa_ssp_startup().

Signed-off-by: Daniel Mack <zonque@gmail.com>
Acked-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/pxa/pxa-ssp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c0dcc35..a3119a0 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -84,7 +84,6 @@ static void pxa_ssp_disable(struct ssp_device *ssp)
 static void pxa_ssp_set_dma_params(struct ssp_device *ssp, int width4,
 			int out, struct snd_dmaengine_dai_dma_data *dma)
 {
-	dma->filter_data = out ? &ssp->drcmr_tx : &ssp->drcmr_rx;
 	dma->addr_width = width4 ? DMA_SLAVE_BUSWIDTH_4_BYTES :
 				   DMA_SLAVE_BUSWIDTH_2_BYTES;
 	dma->maxburst = 16;
@@ -107,6 +106,10 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 	dma = kzalloc(sizeof(struct snd_dmaengine_dai_dma_data), GFP_KERNEL);
 	if (!dma)
 		return -ENOMEM;
+
+	dma->filter_data = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+				&ssp->drcmr_tx : &ssp->drcmr_rx;
+
 	snd_soc_dai_set_dma_data(cpu_dai, substream, dma);
 
 	return ret;
-- 
1.8.3.1
