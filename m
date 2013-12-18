From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 12:57:41 +0100
Subject: [PATCH v3 5/9] ASoC: fsl-ssi: Add offline_config flag
In-Reply-To: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387367865-26391-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx50-ssi and later versions of this IP support online reconfiguration
of all registers. The reference manual does not list any registers that
can only be configured while the SSI unit is disabled. This patch
introduces the flag for later use.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c361730..7a87d06 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -156,6 +156,7 @@ struct fsl_ssi_private {
 	bool imx_ac97;
 	bool use_dma;
 	u8 i2s_mode;
+	bool offline_config;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -979,6 +980,24 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
+	/*
+	 * imx51 and later SoCs have a slightly different IP that allows the
+	 * SSI configuration while the SSI unit is running.
+	 *
+	 * More important, it is necessary on those SoCs to configure the
+	 * sperate TX/RX DMA bits just before starting the stream
+	 * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
+	 * sends any DMA requests to the SDMA unit, otherwise it is not defined
+	 * how the SDMA unit handles the DMA request.
+	 *
+	 * SDMA units are present on devices starting at imx35 but the imx35
+	 * reference manual states that the DMA bits should not be changed
+	 * while the SSI unit is running (SSIEN). So we support the necessary
+	 * online configuration of fsl-ssi starting at imx51.
+	 */
+	if (hw_type != FSL_SSI_MX51)
+		ssi_private->offline_config = true;
+
 	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX51) {
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
-- 
1.8.5.1
