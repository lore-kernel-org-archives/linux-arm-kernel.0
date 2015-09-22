From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 22 Sep 2015 21:20:22 +0200
Subject: [PATCH v2] ASoC: pxa: pxa2xx-ac97: fix dma requestor lines
Message-ID: <1442949622-29675-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCM receive and transmit DMA requestor lines were reverted, breaking the
PCM playback interface for PXA platforms using the sound/soc/ variant
instead of the sound/arm variant.

The commit below shows the inversion in the requestor lines.

Fixes: d65a14587a9b ("ASoC: pxa: use snd_dmaengine_dai_dma_data")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: rebase on Linus's master, not my dmaengine tip branch.
---
 sound/soc/pxa/pxa2xx-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 1f6054650991..9e4b04e0fbd1 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -49,7 +49,7 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_cold_reset,
 };
 
-static unsigned long pxa2xx_ac97_pcm_stereo_in_req = 12;
+static unsigned long pxa2xx_ac97_pcm_stereo_in_req = 11;
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
@@ -57,7 +57,7 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
 	.filter_data	= &pxa2xx_ac97_pcm_stereo_in_req,
 };
 
-static unsigned long pxa2xx_ac97_pcm_stereo_out_req = 11;
+static unsigned long pxa2xx_ac97_pcm_stereo_out_req = 12;
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
-- 
2.1.4
