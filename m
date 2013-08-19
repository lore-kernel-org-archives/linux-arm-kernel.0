From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:06:01 +0200
Subject: [PATCH v11 8/8] ASoC: fsl: disable ssi irq for imx
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376924761-4054-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

We have to disable the ssi irq, as it is not safe for all platforms to
write back into the status register. It also runs into non-linefetch
aborts.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8407d59..653ad6b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -941,18 +941,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (ssi_private->use_dma) {
-		/* The 'name' should not have any slashes in it. */
-		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
-					fsl_ssi_isr, 0, ssi_private->name,
-					ssi_private);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "could not claim irq %u\n",
-					ssi_private->irq);
-			goto error_irqmap;
-		}
-	}
-
 	/* Are the RX and the TX clocks locked? */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
 		ssi_private->cpu_dai_drv.symmetric_rates = 1;
@@ -1020,6 +1008,16 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
 			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
+	} else if (ssi_private->use_dma) {
+		/* The 'name' should not have any slashes in it. */
+		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
+					fsl_ssi_isr, 0, ssi_private->name,
+					ssi_private);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "could not claim irq %u\n",
+					ssi_private->irq);
+			goto error_irqmap;
+		}
 	}
 
 	/* Initialize the the device_attribute structure */
-- 
1.8.4.rc3
