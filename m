From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 12:57:37 +0100
Subject: [PATCH v3 1/9] ASoC: fsl-ssi: Fix probe error handling
In-Reply-To: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387367865-26391-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the error handling in the fsl-ssi probe function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f9f4569..cd9ad8c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1007,11 +1007,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 			ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
 			if (ret)
-				goto error_dev;
+				goto error_pcm;
 		} else {
 			ret = imx_pcm_dma_init(pdev);
 			if (ret)
-				goto error_dev;
+				goto error_pcm;
 		}
 	}
 
@@ -1053,6 +1053,10 @@ done:
 	return 0;
 
 error_dai:
+	if (ssi_private->ssi_on_imx && !ssi_private->use_dma)
+		imx_pcm_fiq_exit(pdev);
+
+error_pcm:
 	snd_soc_unregister_component(&pdev->dev);
 
 error_dev:
@@ -1063,7 +1067,9 @@ error_clk:
 		clk_disable_unprepare(ssi_private->clk);
 
 error_irqmap:
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->use_dma && !of_device_is_compatible(pdev->dev.of_node,
+				"fsl,imx21-ssi"))
+		irq_dispose_mapping(ssi_private->irq);
 
 	return ret;
 }
-- 
1.8.5.1
