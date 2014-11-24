From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 24 Nov 2014 22:19:57 +0100
Subject: [PATCH v3] Fix PXA2xx sound DMA autoincrementation flags
In-Reply-To: <54731B7C.4030306@cogentembedded.com>
References: <54718713.1050902@tul.cz> <54720ACA.2070506@cogentembedded.com>
 <5472605F.4030702@tul.cz> <54731B7C.4030306@cogentembedded.com>
Message-ID: <5473A0FD.9030304@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix for address auto-incrementation flags for DMA transmissions for PXA2xx sound.

Old version used playback settings for recording, so it wrongly read from whole register space (instead of one FIFO register) and wrote into single word in memory.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 sound/arm/pxa2xx-pcm-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index a61d7a9..755f947 100644
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
