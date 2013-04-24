From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 24 Apr 2013 16:36:31 +0200
Subject: [PATCH v5 02/10] ASoC: imx-pcm-dma: DT support
In-Reply-To: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
References: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1366814199-14827-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the possibility to pass a of_node as platform_data which
is used by generic-pcm-dma to request a DMA slave channel.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v5:
     - Use dev.parent pointer to get the of_node.

 sound/soc/fsl/imx-pcm-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index c246fb5..f9577e1 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -62,9 +62,11 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
 
 int imx_pcm_dma_init(struct platform_device *pdev)
 {
+	if (pdev->dev.parent)
+		pdev->dev.of_node = pdev->dev.parent->of_node;
+
 	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
-		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
-- 
1.8.1.5
