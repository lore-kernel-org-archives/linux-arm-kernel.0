From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue,  1 Oct 2013 14:36:10 +0200
Subject: [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
In-Reply-To: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx31 with mc13783 codec the FIQ is not necessary and not enabled
as DMA transfer is available.
Change the probe() function to fail only if both FIQ and DMA are not
available.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 sound/soc/fsl/imx-ssi.c |   23 ++++++++++++-----------
 sound/soc/fsl/imx-ssi.h |    2 ++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index f58bcd8..57d6941 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -600,19 +600,17 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	ssi->fiq_params.dma_params_rx = &ssi->dma_params_rx;
 	ssi->fiq_params.dma_params_tx = &ssi->dma_params_tx;
 
-	ret = imx_pcm_fiq_init(pdev, &ssi->fiq_params);
-	if (ret)
-		goto failed_pcm_fiq;
+	ssi->fiq_init = imx_pcm_fiq_init(pdev, &ssi->fiq_params);
+	ssi->dma_init = imx_pcm_dma_init(pdev);
 
-	ret = imx_pcm_dma_init(pdev);
-	if (ret)
-		goto failed_pcm_dma;
+	if (ssi->fiq_init && ssi->dma_init) {
+		ret = ssi->fiq_init;
+		goto failed_pcm;
+	}
 
 	return 0;
 
-failed_pcm_dma:
-	imx_pcm_fiq_exit(pdev);
-failed_pcm_fiq:
+failed_pcm:
 	snd_soc_unregister_component(&pdev->dev);
 failed_register:
 	release_mem_region(res->start, resource_size(res));
@@ -628,8 +626,11 @@ static int imx_ssi_remove(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 
-	imx_pcm_dma_exit(pdev);
-	imx_pcm_fiq_exit(pdev);
+	if (!ssi->dma_init)
+		imx_pcm_dma_exit(pdev);
+
+	if (!ssi->fiq_init)
+		imx_pcm_fiq_exit(pdev);
 
 	snd_soc_unregister_component(&pdev->dev);
 
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index fb1616b..560c40f 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -211,6 +211,8 @@ struct imx_ssi {
 	struct imx_dma_data filter_data_rx;
 	struct imx_pcm_fiq_params fiq_params;
 
+	int fiq_init;
+	int dma_init;
 	int enabled;
 };
 
-- 
1.7.9.5
