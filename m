From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:04 +0100
Subject: [PATCH 03/10] mx-ssi: flush fifos
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-ssi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 0e3fc8d..96e24a3 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -347,6 +347,11 @@ static int imx_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		/* rx/tx are always enabled to access ac97 registers */
 		writel(scr, ssi->base + SSI_SCR);
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		writel(SSI_SOR_TX_CLR, ssi->base + SSI_SOR);
+	else
+		writel(SSI_SOR_RX_CLR, ssi->base + SSI_SOR);
+
 	writel(sier, ssi->base + SSI_SIER);
 
 	return 0;
-- 
1.8.1.5
