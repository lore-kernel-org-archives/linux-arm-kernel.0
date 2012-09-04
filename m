From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue,  4 Sep 2012 15:08:02 +0300
Subject: [RFC update 2/2] ASoC: omap-pcm: Do not check DMA sync_mode
In-Reply-To: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346760482-12794-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP dmaengine now supports element mode also in cyclic DMA so we do not
need to block non PACKET modes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 50ae048..0f88db3 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -32,7 +32,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/dma.h> /* needed just for OMAP_DMA_SYNC_PACKET */
 #include "omap-pcm.h"
 
 static const struct snd_pcm_hardware omap_pcm_hardware = {
@@ -83,15 +82,6 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	prtd->dma_data = dma_data;
 
-	/*
-	 * This is the only parameter we don't handle with DMA
-	 * engine - so we insist on OMAP_DMA_SYNC_PACKET here.
-	 */
-	if (dma_data->sync_mode != OMAP_DMA_SYNC_PACKET) {
-		pr_warn("ALSA: omap-dma: DMA using non-packet mode?\n");
-		return -EINVAL;
-	}
-
 	req = dma_data->dma_req;
 	err = snd_dmaengine_pcm_open(substream, omap_dma_filter_fn, &req);
 	if (err)
-- 
1.7.12
