From: petr.cvek@tul.cz (Petr Cvek)
Date: Sun, 23 Nov 2014 23:31:59 +0100
Subject: [PATCH v2] Fix PXA2xx sound DMA autoincrementation flags
In-Reply-To: <54720ACA.2070506@cogentembedded.com>
References: <54718713.1050902@tul.cz> <54720ACA.2070506@cogentembedded.com>
Message-ID: <5472605F.4030702@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for SCCB devices into PXA27x I2C controller.

Fix generated START but no STOP for message without I2C_M_NOSTART flag. Add support for I2C_M_IGNORE_NAK flag.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz> 
---
 sound/arm/pxa2xx-pcm-lib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index a61d7a9..5d3a415 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -45,7 +45,13 @@ int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	size_t period = params_period_bytes(params);
 	pxa_dma_desc *dma_desc;
 	dma_addr_t dma_buff_phys, next_desc_phys;
-	u32 dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
+	u32 dcmd = 0;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
+	} else {
+		dcmd = DCMD_INCTRGADDR | DCMD_FLOWSRC;
+	}
 
 	/* temporary transition hack */
 	switch (rtd->params->addr_width) {
-- 
1.7.12.1
