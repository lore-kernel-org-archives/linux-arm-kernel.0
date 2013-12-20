From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 14:11:28 +0100
Subject: [PATCH v4 1/9] ASoC: fsl-ssi: Fix probe error handling
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387545096-2334-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the error handling in the fsl-ssi probe function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b2ebaf8..878a3b2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -141,6 +141,7 @@ struct fsl_ssi_private {
 	bool imx_ac97;
 	bool use_dma;
 	bool baudclk_locked;
+	bool irq_stats;
 	u8 i2s_mode;
 	spinlock_t baudclk_lock;
 	struct clk *baudclk;
@@ -1223,6 +1224,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
 					ssi_private);
+		ssi_private->irq_stats = true;
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
 					ssi_private->irq);
@@ -1273,11 +1275,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
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
 
@@ -1319,6 +1321,10 @@ done:
 	return 0;
 
 error_dai:
+	if (ssi_private->ssi_on_imx && !ssi_private->use_dma)
+		imx_pcm_fiq_exit(pdev);
+
+error_pcm:
 	snd_soc_unregister_component(&pdev->dev);
 
 error_dev:
@@ -1332,7 +1338,8 @@ error_clk:
 	}
 
 error_irqmap:
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->irq_stats)
+		irq_dispose_mapping(ssi_private->irq);
 
 	return ret;
 }
@@ -1350,7 +1357,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 			clk_disable_unprepare(ssi_private->baudclk);
 		clk_disable_unprepare(ssi_private->clk);
 	}
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->irq_stats)
+		irq_dispose_mapping(ssi_private->irq);
 
 	return 0;
 }
-- 
1.8.5.1
