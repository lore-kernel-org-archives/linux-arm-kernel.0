From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:16 +0200
Subject: [PATCH v2 06/11] ASoC: fsl-ssi: Setup generic imx dma params
In-Reply-To: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365362721-3731-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use device pointer as parameter for imx-pcm-dma. This allows usage of
the generic DMA DT bindings.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index afb5a23..bb9a1e0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -742,7 +742,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ssi_private->fifo_depth = 8;
 
 	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
-		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
 
 		ssi_private->clk = clk_get(&pdev->dev, NULL);
@@ -765,18 +764,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
 		ssi_private->dma_params_rx.dma_addr =
 			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
-		/*
-		 * TODO: This is a temporary solution and should be changed
-		 * to use generic DMA binding later when the helplers get in.
-		 */
-		ret = of_property_read_u32_array(pdev->dev.of_node,
-					"fsl,ssi-dma-events", dma_events, 2);
-		if (ret) {
-			dev_err(&pdev->dev, "could not get dma events\n");
-			goto error_clk;
-		}
-		ssi_private->dma_params_tx.dma = dma_events[0];
-		ssi_private->dma_params_rx.dma = dma_events[1];
+
+		ssi_private->dma_params_rx.dma_client_dev = &pdev->dev;
+		ssi_private->dma_params_rx.dma_req_name = "rx";
+		ssi_private->dma_params_tx.dma_client_dev = &pdev->dev;
+		ssi_private->dma_params_tx.dma_req_name = "tx";
 
 		ssi_private->dma_params_tx.shared_peripheral =
 				of_device_is_compatible(of_get_parent(np),
@@ -887,7 +879,6 @@ error_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
 	device_remove_file(&pdev->dev, dev_attr);
 
-error_clk:
 	if (ssi_private->ssi_on_imx) {
 		clk_disable_unprepare(ssi_private->clk);
 		clk_put(ssi_private->clk);
-- 
1.8.1.5
