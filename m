From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 3 Mar 2015 16:45:20 +0200
Subject: [PATCH 4/5] ASoC: davinci-mcasp: Deprecate the use of davinci-pcm in
 favor of edma-pcm
In-Reply-To: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
References: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1425393921-14219-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edma-pcm performs as good as the old davinci-pcm and it's use does not
require the 'ping-pong' mode of davinci-pcm, which was introduced to
overcome under/over flow issues when using davinci-pcm.

Keep the SND_DAVINCI_SOC config option to select the SND_EDMA_SOC to avoid
regression in audio support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig         | 15 +++----
 sound/soc/davinci/davinci-mcasp.c | 87 +++++++++------------------------------
 2 files changed, 27 insertions(+), 75 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 7acce887b073..ca2f4f5ad6b2 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,15 +1,16 @@
 config SND_DAVINCI_SOC
-	tristate "SoC Audio for TI DAVINCI"
+	tristate
 	depends on ARCH_DAVINCI
 	select SND_EDMA_SOC
 
 config SND_EDMA_SOC
-	tristate "SoC Audio for Texas Instruments chips using eDMA (AM33XX/43XX)"
+	tristate "SoC Audio for Texas Instruments chips using eDMA"
 	depends on SOC_AM33XX || SOC_AM43XX || ARCH_DAVINCI
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
 	  The following line of SoCs are supported by this platform driver:
+	  - daVinci devices
 	  - AM335x
 	  - AM437x/AM438x
 
@@ -18,7 +19,7 @@ config SND_DAVINCI_SOC_I2S
 
 config SND_DAVINCI_SOC_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
-	depends on SND_DAVINCI_SOC || SND_OMAP_SOC || SND_EDMA_SOC
+	depends on SND_OMAP_SOC || SND_EDMA_SOC
 	help
 	  Say Y or M here if you want to have support for McASP IP found in
 	  various Texas Instruments SoCs like:
@@ -47,7 +48,7 @@ config SND_AM33XX_SOC_EVM
 
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
-	depends on SND_DAVINCI_SOC && I2C
+	depends on SND_EDMA_SOC && I2C
 	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM || MACH_DAVINCI_DM365_EVM
 	select SND_DAVINCI_SOC_GENERIC_EVM
 	help
@@ -75,7 +76,7 @@ endchoice
 
 config  SND_DM6467_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6467 EVM"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM6467_EVM && I2C
+	depends on SND_EDMA_SOC && MACH_DAVINCI_DM6467_EVM && I2C
 	select SND_DAVINCI_SOC_GENERIC_EVM
 	select SND_SOC_SPDIF
 
@@ -84,7 +85,7 @@ config  SND_DM6467_SOC_EVM
 
 config  SND_DA830_SOC_EVM
 	tristate "SoC Audio support for DA830/OMAP-L137 EVM"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA830_EVM && I2C
+	depends on SND_EDMA_SOC && MACH_DAVINCI_DA830_EVM && I2C
 	select SND_DAVINCI_SOC_GENERIC_EVM
 
 	help
@@ -93,7 +94,7 @@ config  SND_DA830_SOC_EVM
 
 config  SND_DA850_SOC_EVM
 	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM && I2C
+	depends on SND_EDMA_SOC && MACH_DAVINCI_DA850_EVM && I2C
 	select SND_DAVINCI_SOC_GENERIC_EVM
 	help
 	  Say Y if you want to add support for SoC audio on TI
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a51197ac0b92..c0e485cba9eb 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/platform_data/davinci_asp.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -36,7 +37,6 @@
 #include <sound/dmaengine_pcm.h>
 #include <sound/omap-pcm.h>
 
-#include "davinci-pcm.h"
 #include "edma-pcm.h"
 #include "davinci-mcasp.h"
 
@@ -65,7 +65,6 @@ struct davinci_mcasp_context {
 };
 
 struct davinci_mcasp {
-	struct davinci_pcm_dma_params dma_params[2];
 	struct snd_dmaengine_dai_dma_data dma_data[2];
 	void __iomem *base;
 	u32 fifo_base;
@@ -82,6 +81,7 @@ struct davinci_mcasp {
 	u16	bclk_lrclk_ratio;
 	int	streams;
 	u32	irq_request[2];
+	int	dma_request[2];
 
 	int	sysclk_freq;
 	bool	bclk_master;
@@ -647,7 +647,6 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 				 int period_words, int channels)
 {
-	struct davinci_pcm_dma_params *dma_params = &mcasp->dma_params[stream];
 	struct snd_dmaengine_dai_dma_data *dma_data = &mcasp->dma_data[stream];
 	int i;
 	u8 tx_ser = 0;
@@ -715,10 +714,8 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 			 * For example if three serializers are enabled the DMA
 			 * need to transfer three words per DMA request.
 			 */
-			dma_params->fifo_level = active_serializers;
 			dma_data->maxburst = active_serializers;
 		} else {
-			dma_params->fifo_level = 0;
 			dma_data->maxburst = 0;
 		}
 		return 0;
@@ -750,7 +747,6 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	/* Configure the burst size for platform drivers */
 	if (numevt == 1)
 		numevt = 0;
-	dma_params->fifo_level = numevt;
 	dma_data->maxburst = numevt;
 
 	return 0;
@@ -876,8 +872,6 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *cpu_dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct davinci_pcm_dma_params *dma_params =
-					&mcasp->dma_params[substream->stream];
 	int word_length;
 	int channels = params_channels(params);
 	int period_size = params_period_size(params);
@@ -918,31 +912,26 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U8:
 	case SNDRV_PCM_FORMAT_S8:
-		dma_params->data_type = 1;
 		word_length = 8;
 		break;
 
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_S16_LE:
-		dma_params->data_type = 2;
 		word_length = 16;
 		break;
 
 	case SNDRV_PCM_FORMAT_U24_3LE:
 	case SNDRV_PCM_FORMAT_S24_3LE:
-		dma_params->data_type = 3;
 		word_length = 24;
 		break;
 
 	case SNDRV_PCM_FORMAT_U24_LE:
 	case SNDRV_PCM_FORMAT_S24_LE:
-		dma_params->data_type = 4;
 		word_length = 24;
 		break;
 
 	case SNDRV_PCM_FORMAT_U32_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
-		dma_params->data_type = 4;
 		word_length = 32;
 		break;
 
@@ -951,11 +940,6 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (mcasp->version == MCASP_VERSION_2 && !dma_params->fifo_level)
-		dma_params->acnt = 4;
-	else
-		dma_params->acnt = dma_params->data_type;
-
 	davinci_config_channel_size(mcasp, word_length);
 
 	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE)
@@ -1059,17 +1043,8 @@ static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
-	if (mcasp->version >= MCASP_VERSION_3) {
-		/* Using dmaengine PCM */
-		dai->playback_dma_data =
-				&mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-		dai->capture_dma_data =
-				&mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
-	} else {
-		/* Using davinci-pcm */
-		dai->playback_dma_data = mcasp->dma_params;
-		dai->capture_dma_data = mcasp->dma_params;
-	}
+	dai->playback_dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	dai->capture_dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
 
 	return 0;
 }
@@ -1198,28 +1173,24 @@ static const struct snd_soc_component_driver davinci_mcasp_component = {
 static struct davinci_mcasp_pdata dm646x_mcasp_pdata = {
 	.tx_dma_offset = 0x400,
 	.rx_dma_offset = 0x400,
-	.asp_chan_q = EVENTQ_0,
 	.version = MCASP_VERSION_1,
 };
 
 static struct davinci_mcasp_pdata da830_mcasp_pdata = {
 	.tx_dma_offset = 0x2000,
 	.rx_dma_offset = 0x2000,
-	.asp_chan_q = EVENTQ_0,
 	.version = MCASP_VERSION_2,
 };
 
 static struct davinci_mcasp_pdata am33xx_mcasp_pdata = {
 	.tx_dma_offset = 0,
 	.rx_dma_offset = 0,
-	.asp_chan_q = EVENTQ_0,
 	.version = MCASP_VERSION_3,
 };
 
 static struct davinci_mcasp_pdata dra7_mcasp_pdata = {
 	.tx_dma_offset = 0x200,
 	.rx_dma_offset = 0x284,
-	.asp_chan_q = EVENTQ_0,
 	.version = MCASP_VERSION_4,
 };
 
@@ -1396,12 +1367,12 @@ nodata:
 
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
-	struct davinci_pcm_dma_params *dma_params;
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct resource *mem, *ioarea, *res, *dat;
 	struct davinci_mcasp_pdata *pdata;
 	struct davinci_mcasp *mcasp;
 	char *irq_name;
+	int *dma;
 	int irq;
 	int ret;
 
@@ -1528,59 +1499,45 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (dat)
 		mcasp->dat_port = true;
 
-	dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-	dma_params->asp_chan_q = pdata->asp_chan_q;
-	dma_params->ram_chan_q = pdata->ram_chan_q;
-	dma_params->sram_pool = pdata->sram_pool;
-	dma_params->sram_size = pdata->sram_size_playback;
 	if (dat)
-		dma_params->dma_addr = dat->start;
+		dma_data->addr = dat->start;
 	else
-		dma_params->dma_addr = mem->start + pdata->tx_dma_offset;
-
-	/* Unconditional dmaengine stuff */
-	dma_data->addr = dma_params->dma_addr;
+		dma_data->addr = mem->start + pdata->tx_dma_offset;
 
+	dma = &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (res)
-		dma_params->channel = res->start;
+		*dma = res->start;
 	else
-		dma_params->channel = pdata->tx_dma_channel;
+		*dma = pdata->tx_dma_channel;
 
 	/* dmaengine filter data for DT and non-DT boot */
 	if (pdev->dev.of_node)
 		dma_data->filter_data = "tx";
 	else
-		dma_data->filter_data = &dma_params->channel;
+		dma_data->filter_data = dma;
 
 	/* RX is not valid in DIT mode */
 	if (mcasp->op_mode != DAVINCI_MCASP_DIT_MODE) {
-		dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_CAPTURE];
 		dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
-		dma_params->asp_chan_q = pdata->asp_chan_q;
-		dma_params->ram_chan_q = pdata->ram_chan_q;
-		dma_params->sram_pool = pdata->sram_pool;
-		dma_params->sram_size = pdata->sram_size_capture;
 		if (dat)
-			dma_params->dma_addr = dat->start;
+			dma_data->addr = dat->start;
 		else
-			dma_params->dma_addr = mem->start + pdata->rx_dma_offset;
-
-		/* Unconditional dmaengine stuff */
-		dma_data->addr = dma_params->dma_addr;
+			dma_data->addr = mem->start + pdata->rx_dma_offset;
 
+		dma = &mcasp->dma_request[SNDRV_PCM_STREAM_CAPTURE];
 		res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 		if (res)
-			dma_params->channel = res->start;
+			*dma = res->start;
 		else
-			dma_params->channel = pdata->rx_dma_channel;
+			*dma = pdata->rx_dma_channel;
 
 		/* dmaengine filter data for DT and non-DT boot */
 		if (pdev->dev.of_node)
 			dma_data->filter_data = "rx";
 		else
-			dma_data->filter_data = &dma_params->channel;
+			dma_data->filter_data = dma;
 	}
 
 	if (mcasp->version < MCASP_VERSION_3) {
@@ -1603,17 +1560,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 
 	switch (mcasp->version) {
-#if IS_BUILTIN(CONFIG_SND_DAVINCI_SOC) || \
-	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
-	 IS_MODULE(CONFIG_SND_DAVINCI_SOC))
-	case MCASP_VERSION_1:
-	case MCASP_VERSION_2:
-		ret = davinci_soc_platform_register(&pdev->dev);
-		break;
-#endif
 #if IS_BUILTIN(CONFIG_SND_EDMA_SOC) || \
 	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
 	 IS_MODULE(CONFIG_SND_EDMA_SOC))
+	case MCASP_VERSION_1:
+	case MCASP_VERSION_2:
 	case MCASP_VERSION_3:
 		ret = edma_pcm_platform_register(&pdev->dev);
 		break;
-- 
2.3.0
