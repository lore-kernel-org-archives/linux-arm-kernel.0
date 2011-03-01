From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue,  1 Mar 2011 15:02:06 +0100
Subject: [PATCH v2 2/4] ASoC: Fix burstsize and DSP_B format problems in
	imx-ssi.
In-Reply-To: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When choosing IMX_DMA flag, burtsizes are set to its default
value (0) which leads to driver malfunction. Change them to 4.

DSP_B interface needs additional flag to match DSP_B formats
as described in several codecs as wm8741 and aic3205.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/imx-ssi.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 390b6ff..971d3db 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -108,7 +108,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* data on rising edge of bclk, frame high with data */
-		strcr |= SSI_STCR_TFSL;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TXBIT0;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* data on rising edge of bclk, frame high 1clk before data */
@@ -656,6 +656,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	ssi->dma_params_rx.dma_addr = res->start + SSI_SRX0;
 	ssi->dma_params_tx.dma_addr = res->start + SSI_STX0;
 
+	ssi->dma_params_tx.burstsize = 4;
+	ssi->dma_params_rx.burstsize = 4;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
 	if (res)
 		ssi->dma_params_tx.dma = res->start;
-- 
1.7.0.4
