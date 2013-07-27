From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 13:31:54 +0200
Subject: [PATCH v10 5/7] ASoC: fsl-ssi: Use generic DMA bindings if possible
In-Reply-To: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1374924716-23475-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There may be some platforms using fsl-ssi that do not have a DMA driver
with generic DMA bindings. So this patch adds support for the generic
DMA bindings, while still accepting the old "fsl,dma-events" property if
"dmas" is not found.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/sound/fsl,ssi.txt |  4 ++++
 sound/soc/fsl/fsl_ssi.c                             | 20 ++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index e45cbce..088a2c0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -51,6 +51,10 @@ Optional properties:
 		    filter the codec stream. This is necessary for some boards
 		    where an incompatible codec is connected to this SSI, e.g.
 		    on pca100 and pcm043.
+- dmas:		    Generic dma devicetree binding as described in
+		    Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names:	    Two dmas have to be defined, "tx" and "rx", if fsl,imx-fiq
+		    is not defined.
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8b075ef..0c072ff 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -794,15 +794,19 @@ static int fsl_ssi_probe(struct platform_device *pdev)
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
+			 * FIXME: This is a temporary solution until all
+			 * necessary dma drivers support the generic dma
+			 * bindings.
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
-- 
1.8.3.2
