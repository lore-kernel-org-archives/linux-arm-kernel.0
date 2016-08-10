From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Wed, 10 Aug 2016 12:14:22 +0200
Subject: [PATCH] sound: soc: atmel: Don't unconditionally reset SSC on stream
 startup
Message-ID: <20160810101422.2086-1-pmeerw@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoph Huber <c.huber@bct-electronic.com>

commit cbaadf0f90d6 (ASoC: atmel_ssc_dai: refactor the startup and shutdown)
refactored code such that the SSC is reset on every startup;
this breaks duplex audio (e.g. first start audio playback, then start record,
causing the playback to stop/hang)

Signed-off-by: Christoph Huber <c.huber@bct-electronic.com>
Signed-off-by: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>
Cc: Songjun Wu <songjun.wu@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 841d059..b3e9f0c 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -298,8 +298,9 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	clk_enable(ssc_p->ssc->clk);
 	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
 
-	/* Reset the SSC to keep it at a clean status */
-	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+	/* Reset the SSC if it is not initialized to keep it at a clean status */
+	if(!ssc_p->initialized)
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dir = 0;
-- 
2.1.4
