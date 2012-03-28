From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Mar 2012 15:34:56 +0800
Subject: [PATCH] ASoC: fsl: assign dma peripheral type according to bus
 topology
Message-ID: <1332920096-9701-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma peripheral_type for SSI should be IMX_DMATYPE_SSI_SP if the SSI
is on SPBA bus.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c     |    6 ++++++
 sound/soc/fsl/imx-pcm-dma.c |    3 ++-
 sound/soc/fsl/imx-pcm.h     |    1 +
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 30ff605..4f76b5d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -746,6 +746,12 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 		}
 		ssi_private->dma_params_tx.dma = dma_events[0];
 		ssi_private->dma_params_rx.dma = dma_events[1];
+
+		ssi_private->dma_params_tx.shared_peripheral =
+				of_device_is_compatible(of_get_parent(np),
+							"fsl,spba-bus");
+		ssi_private->dma_params_rx.shared_peripheral =
+				ssi_private->dma_params_tx.shared_peripheral;
 	}
 
 	/* Initialize the the device_attribute structure */
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index e43c8fa..8c43262 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -106,7 +106,8 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	dma_data = kzalloc(sizeof(*dma_data), GFP_KERNEL);
-	dma_data->peripheral_type = IMX_DMATYPE_SSI;
+	dma_data->peripheral_type = dma_params->shared_peripheral ?
+					IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI;
 	dma_data->priority = DMA_PRIO_HIGH;
 	dma_data->dma_request = dma_params->dma;
 
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index b5f5c3a..83c0ed7 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -22,6 +22,7 @@ struct imx_pcm_dma_params {
 	int dma;
 	unsigned long dma_addr;
 	int burstsize;
+	bool shared_peripheral;	/* The peripheral is on SPBA bus */
 };
 
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
-- 
1.7.4.1
