From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 06 Mar 2015 12:07:08 +0100
Subject: [PATCH v4] Sound: PXA: Fix settings of PXAxxx DMA
In-Reply-To: <20150302181803.GC21293@sirena.org.uk>
References: <54CA125D.7010908@tul.cz> <54CA2B7E.5010003@tul.cz>
 <54F05FD6.6080702@tul.cz> <20150302181803.GC21293@sirena.org.uk>
Message-ID: <54F98A5C.5040507@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PXA DMA autoincrementation, so capture will not use playback settings
(incrementation in register space instead in target buffer).

Regression from:
  'commit d65a14587a9be853a887a1407db133df1fb68e29 ("ASoC: pxa: use snd_dmaengine_dai_dma_data")'

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Acked-by: Daniel Mack <daniel@zonque.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
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
-- 1.7.12.1 
