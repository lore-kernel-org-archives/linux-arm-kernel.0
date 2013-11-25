From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Nov 2013 12:13:38 +0100
Subject: [PATCH v2 2/9] ASoC: fsl-ssi: Fix interrupt mapping and release
In-Reply-To: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
References: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1385378025-1262-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irqs should only be requested and released with DMA.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 66ffc58..57e331f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1064,7 +1064,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
 			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
-	} else if (ssi_private->use_dma) {
+	}
+
+	if (ssi_private->use_dma) {
 		/* The 'name' should not have any slashes in it. */
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
@@ -1172,7 +1174,8 @@ error_clk:
 		clk_disable_unprepare(ssi_private->clk);
 
 error_irqmap:
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->use_dma)
+		irq_dispose_mapping(ssi_private->irq);
 
 	return ret;
 }
@@ -1190,7 +1193,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	snd_soc_unregister_component(&pdev->dev);
 	if (ssi_private->ssi_on_imx)
 		clk_disable_unprepare(ssi_private->clk);
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->use_dma)
+		irq_dispose_mapping(ssi_private->irq);
 
 	return 0;
 }
-- 
1.8.4.2
