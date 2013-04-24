From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 24 Apr 2013 16:36:32 +0200
Subject: [PATCH v5 03/10] ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
In-Reply-To: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
References: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1366814199-14827-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleaner parameter passing for imx-pcm-fiq. Create a seperated fiq-params
struct to pass all arguments.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v3:
     - Using snd_dmaengine_dai_dma_data for dma_params after rebasing onto
       dmaengine cleanups.

 sound/soc/fsl/imx-pcm-fiq.c | 16 +++++++++-------
 sound/soc/fsl/imx-pcm.h     |  9 +++++++++
 sound/soc/fsl/imx-ssi.c     |  7 ++++++-
 sound/soc/fsl/imx-ssi.h     |  1 +
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 670b96b..c3fdb2f 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 
 #include <sound/core.h>
+#include <sound/dmaengine_pcm.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -32,6 +33,7 @@
 #include <linux/platform_data/asoc-imx-ssi.h>
 
 #include "imx-ssi.h"
+#include "imx-pcm.h"
 
 struct imx_pcm_runtime_data {
 	unsigned int period;
@@ -283,7 +285,7 @@ static struct snd_soc_platform_driver imx_soc_platform_fiq = {
 
 int imx_pcm_fiq_init(struct platform_device *pdev)
 {
-	struct imx_ssi *ssi = platform_get_drvdata(pdev);
+	struct imx_pcm_fiq_params *params = platform_get_drvdata(pdev);
 	int ret;
 
 	ret = claim_fiq(&fh);
@@ -292,15 +294,15 @@ int imx_pcm_fiq_init(struct platform_device *pdev)
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
 
-	ssi->dma_params_tx.maxburst = 4;
-	ssi->dma_params_rx.maxburst = 6;
+	params->dma_params_tx->maxburst = 4;
+	params->dma_params_rx->maxburst = 6;
 
 	ret = snd_soc_register_platform(&pdev->dev, &imx_soc_platform_fiq);
 	if (ret)
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index b7fa0d7..f592f23 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -32,6 +32,15 @@ imx_pcm_dma_params_init_data(struct imx_dma_data *dma_data,
 		dma_data->peripheral_type = IMX_DMATYPE_SSI;
 }
 
+struct imx_pcm_fiq_params {
+	int irq;
+	void __iomem *base;
+
+	/* Pointer to original ssi driver to setup tx rx sizes */
+	struct snd_dmaengine_dai_dma_data *dma_params_rx;
+	struct snd_dmaengine_dai_dma_data *dma_params_tx;
+};
+
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 		     struct vm_area_struct *vma);
 int imx_pcm_new(struct snd_soc_pcm_runtime *rtd);
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 902fab0..f80f4c7 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -601,7 +601,12 @@ static int imx_ssi_probe(struct platform_device *pdev)
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
index bb6b3db..20ce7ca 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -209,6 +209,7 @@ struct imx_ssi {
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct imx_dma_data filter_data_tx;
 	struct imx_dma_data filter_data_rx;
+	struct imx_pcm_fiq_params fiq_params;
 
 	int enabled;
 
-- 
1.8.1.5
