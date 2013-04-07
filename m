From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:13 +0200
Subject: [PATCH v2 03/11] ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
In-Reply-To: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365362721-3731-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleaner parameter passing for imx-pcm-fiq. Create a seperated fiq-params
struct to pass all arguments.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-pcm-fiq.c | 14 +++++++-------
 sound/soc/fsl/imx-pcm.h     |  9 +++++++++
 sound/soc/fsl/imx-ssi.c     |  7 ++++++-
 sound/soc/fsl/imx-ssi.h     |  1 +
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 920f945..995ed35 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -283,7 +283,7 @@ static struct snd_soc_platform_driver imx_soc_platform_fiq = {
 
 int imx_pcm_fiq_init(struct platform_device *pdev)
 {
-	struct imx_ssi *ssi = platform_get_drvdata(pdev);
+	struct imx_pcm_fiq_params *params = platform_get_drvdata(pdev);
 	int ret;
 
 	ret = claim_fiq(&fh);
@@ -292,15 +292,15 @@ int imx_pcm_fiq_init(struct platform_device *pdev)
 		return ret;
 	}
 
-	mxc_set_irq_fiq(ssi->irq, 1);
-	ssi_irq = ssi->irq;
+	mxc_set_irq_fiq(params->irq, 1);
+	ssi_irq = params->irq;
 
-	imx_pcm_fiq = ssi->irq;
+	imx_pcm_fiq = params->irq;
 
-	imx_ssi_fiq_base = (unsigned long)ssi->base;
+	imx_ssi_fiq_base = (unsigned long)params->base;
 
-	ssi->dma_params_tx.burstsize = 4;
-	ssi->dma_params_rx.burstsize = 6;
+	params->dma_params_tx->burstsize = 4;
+	params->dma_params_rx->burstsize = 6;
 
 	ret = snd_soc_register_platform(&pdev->dev, &imx_soc_platform_fiq);
 	if (ret)
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index ff0cfdf..f568a0e 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -31,6 +31,15 @@ struct imx_pcm_dma_params {
 	const char *dma_req_name; /* DMA Request name from devicetree */
 };
 
+struct imx_pcm_fiq_params {
+	int irq;
+	void __iomem *base;
+
+	/* Pointer to original ssi driver to setup tx rx sizes */
+	struct imx_pcm_dma_params *dma_params_tx;
+	struct imx_pcm_dma_params *dma_params_rx;
+};
+
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 		     struct vm_area_struct *vma);
 int imx_pcm_new(struct snd_soc_pcm_runtime *rtd);
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 96e24a3..93f7562 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -608,7 +608,12 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		goto failed_pdev_fiq_alloc;
 	}
 
-	platform_set_drvdata(ssi->soc_platform_pdev_fiq, ssi);
+	ssi->fiq_params.irq = ssi->irq;
+	ssi->fiq_params.base = ssi->base;
+	ssi->fiq_params.dma_params_rx = &ssi->dma_params_rx;
+	ssi->fiq_params.dma_params_tx = &ssi->dma_params_tx;
+
+	platform_set_drvdata(ssi->soc_platform_pdev_fiq, &ssi->fiq_params);
 	ret = platform_device_add(ssi->soc_platform_pdev_fiq);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform device\n");
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index dc114bd..90a45ef 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -206,6 +206,7 @@ struct imx_ssi {
 
 	struct imx_pcm_dma_params	dma_params_rx;
 	struct imx_pcm_dma_params	dma_params_tx;
+	struct imx_pcm_fiq_params	fiq_params;
 
 	int enabled;
 
-- 
1.8.1.5
