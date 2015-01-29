From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 29 Jan 2015 11:58:37 +0100
Subject: [PATCH v4] Sound: PXA: Fix settings of PXAxxx DMA
Message-ID: <54CA125D.7010908@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PXA DMA autoincrementation, so capture will not use playback settings
(incrementation in register space instead in target buffer).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 sound/arm/pxa2xx-pcm-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 01f8fdc..f8ca3ca 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -45,7 +45,12 @@ int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	size_t period = params_period_bytes(params);
 	pxa_dma_desc *dma_desc;
 	dma_addr_t dma_buff_phys, next_desc_phys;
-	u32 dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
+	u32 dcmd = 0;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
+	else
+		dcmd = DCMD_INCTRGADDR | DCMD_FLOWSRC;
 
 	/* temporary transition hack */
 	switch (rtd->params->addr_width) {
-- 
1.7.12.1
