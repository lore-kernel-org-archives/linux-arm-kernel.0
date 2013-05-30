From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 16:51:44 +0200
Subject: [PATCH v7 02/11] ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
In-Reply-To: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
References: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369925513-19329-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleaner parameter passing for imx-pcm-fiq. Create a seperated fiq-params
struct to pass all arguments.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v7:
     - Fix init function signature for !CONFIG_SND_SOC_IMX_PCM_FIQ
    
    Changes in v6:
     - After rebasing onto Shawn's imx-pcm cleanups, the imx_pcm_fiq_params are now
       passed as function arguments instead of platform driver data.
    
    Changes in v3:
     - Using snd_dmaengine_dai_dma_data for dma_params after rebasing onto
       dmaengine cleanups.

 sound/soc/fsl/imx-pcm-fiq.c | 18 ++++++++++--------
 sound/soc/fsl/imx-pcm.h     | 15 +++++++++++++--
 sound/soc/fsl/imx-ssi.c     |  7 ++++++-
 sound/soc/fsl/imx-ssi.h     |  1 +
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 310d902..3b2ba99 100644
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
@@ -366,9 +368,9 @@ static struct snd_soc_platform_driver imx_soc_platform_fiq = {
 	.pcm_free	= imx_pcm_fiq_free,
 };
 
-int imx_pcm_fiq_init(struct platform_device *pdev)
+int imx_pcm_fiq_init(struct platform_device *pdev,
+		struct imx_pcm_fiq_params *params)
 {
-	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 	int ret;
 
 	ret = claim_fiq(&fh);
@@ -377,15 +379,15 @@ int imx_pcm_fiq_init(struct platform_device *pdev)
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
index 67f656c..cd8a796 100644
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
 #ifdef CONFIG_SND_SOC_IMX_PCM_DMA
 int imx_pcm_dma_init(struct platform_device *pdev);
 void imx_pcm_dma_exit(struct platform_device *pdev);
@@ -47,10 +56,12 @@ static inline void imx_pcm_dma_exit(struct platform_device *pdev)
 #endif
 
 #ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
-int imx_pcm_fiq_init(struct platform_device *pdev);
+int imx_pcm_fiq_init(struct platform_device *pdev,
+		struct imx_pcm_fiq_params *params);
 void imx_pcm_fiq_exit(struct platform_device *pdev);
 #else
-static inline int imx_pcm_fiq_init(struct platform_device *pdev)
+static inline int imx_pcm_fiq_init(struct platform_device *pdev,
+		struct imx_pcm_fiq_params *params);
 {
 	return -ENODEV;
 }
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index a8362be..16ae16d 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -590,7 +590,12 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		goto failed_register;
 	}
 
-	ret = imx_pcm_fiq_init(pdev);
+	ssi->fiq_params.irq = ssi->irq;
+	ssi->fiq_params.base = ssi->base;
+	ssi->fiq_params.dma_params_rx = &ssi->dma_params_rx;
+	ssi->fiq_params.dma_params_tx = &ssi->dma_params_tx;
+
+	ret = imx_pcm_fiq_init(pdev, &ssi->fiq_params);
 	if (ret)
 		goto failed_pcm_fiq;
 
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index d5003ce..fb1616b 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -209,6 +209,7 @@ struct imx_ssi {
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct imx_dma_data filter_data_tx;
 	struct imx_dma_data filter_data_rx;
+	struct imx_pcm_fiq_params fiq_params;
 
 	int enabled;
 };
-- 
1.8.2.1
