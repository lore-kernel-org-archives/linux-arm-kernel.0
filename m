From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:54 +0200
Subject: [PATCH v3 10/15] ASoC: fsl-ssi: Use generic DMA bindings if possible
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-11-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutrnoix.de>

There may be some platforms using fsl-ssi that do not have a DMA driver
with generic DMA bindings. So this patch adds support for the generic
DMA bindings, while still using the old "fsl,dma-events" property if
"dmas" is not found.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6a9be9c..1ab66f8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -776,15 +776,19 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			&ssi_private->filter_data_tx;
 		ssi_private->dma_params_rx.filter_data =
 			&ssi_private->filter_data_rx;
-		/*
-		 * TODO: This is a temporary solution and should be changed
-		 * to use generic DMA binding later when the helplers get in.
-		 */
-		ret = of_property_read_u32_array(pdev->dev.of_node,
+		if (!of_property_read_bool(pdev->dev.of_node, "dmas") &&
+				ssi_private->use_dma) {
+			/*
+			 * TODO: This is a temporary solution and should be
+			 * changed to use generic DMA binding later when the
+			 * helplers get in.
+			 */
+			ret = of_property_read_u32_array(pdev->dev.of_node,
 					"fsl,ssi-dma-events", dma_events, 2);
-		if (ret && !ssi_private->use_dma) {
-			dev_err(&pdev->dev, "could not get dma events\n");
-			goto error_clk;
+			if (ret && ssi_private->use_dma) {
+				dev_err(&pdev->dev, "could not get dma events but fsl-ssi is configured to use DMA\n");
+				goto error_clk;
+			}
 		}
 
 		shared = of_device_is_compatible(of_get_parent(np),
@@ -847,8 +851,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			}
 		} else {
 			ssi_private->imx_pcm_pdev =
-				platform_device_register_simple("imx-pcm-audio",
-							-1, NULL, 0);
+				platform_device_register_data(&pdev->dev,
+						"imx-pcm-audio", -1,
+						pdev->dev.of_node,
+						sizeof(*pdev->dev.of_node));
 			if (IS_ERR(ssi_private->imx_pcm_pdev)) {
 				ret = PTR_ERR(ssi_private->imx_pcm_pdev);
 				goto error_dev;
-- 
1.8.1.5
