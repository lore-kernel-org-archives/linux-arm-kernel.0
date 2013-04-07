From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:12 +0200
Subject: [PATCH v2 02/11] ASoC: imx-pcm-dma: Add support for DMA init by
 device node
In-Reply-To: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365362721-3731-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for DMA initialization using devicetree node.

This patch adds two fields to imx_pcm_dma_params to pass device node
information from other imx drivers to this one. If the dma_node is set,
this driver tries to initialize a PCM DMA substream based on the
dma_node and name.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v2:
     - Use snd_dmaengine_generic_pcm_open instead of of_snd_dmaengine_pcm_open.
     - Pass the device in imx_pcm_dma_params.

 sound/soc/fsl/imx-pcm-dma.c | 31 ++++++++++++++++++++-----------
 sound/soc/fsl/imx-pcm.h     |  6 ++++++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 500f8ce..2d15ca5 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -101,26 +101,35 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct imx_pcm_dma_params *dma_params;
-	struct imx_dma_data *dma_data;
+	struct imx_dma_data *dma_data = NULL;
 	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
 
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	dma_data = kzalloc(sizeof(*dma_data), GFP_KERNEL);
-	if (!dma_data)
-		return -ENOMEM;
+	if (dma_params->dma_client_dev) {
+		ret = snd_dmaengine_generic_pcm_open(substream,
+				dma_params->dma_client_dev,
+				dma_params->dma_req_name);
+		if (ret)
+			return ret;
+	} else {
+		dma_data = kzalloc(sizeof(*dma_data), GFP_KERNEL);
+		if (!dma_data)
+			return -ENOMEM;
 
-	dma_data->peripheral_type = dma_params->shared_peripheral ?
+		dma_data->peripheral_type = dma_params->shared_peripheral ?
 					IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI;
-	dma_data->priority = DMA_PRIO_HIGH;
-	dma_data->dma_request = dma_params->dma;
+		dma_data->priority = DMA_PRIO_HIGH;
+		dma_data->dma_request = dma_params->dma;
 
-	ret = snd_dmaengine_pcm_open(substream, filter, dma_data);
-	if (ret) {
-		kfree(dma_data);
-		return ret;
+		ret = snd_dmaengine_pcm_open(substream, filter, dma_data);
+
+		if (ret) {
+			kfree(dma_data);
+			return ret;
+		}
 	}
 
 	snd_dmaengine_pcm_set_data(substream, dma_data);
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 5ae13a1..ff0cfdf 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -23,6 +23,12 @@ struct imx_pcm_dma_params {
 	unsigned long dma_addr;
 	int burstsize;
 	bool shared_peripheral;	/* The peripheral is on SPBA bus */
+
+	/* If set, the DMA channel is requested using the generic handler while
+	 * ignoring fields 'dma' and 'shared_peripheral'. They have to be set
+	 * in devicetree according to the DMA Controller devicetree bindings. */
+	struct device *dma_client_dev;
+	const char *dma_req_name; /* DMA Request name from devicetree */
 };
 
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
-- 
1.8.1.5
