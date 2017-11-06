From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 6 Nov 2017 16:18:52 +0100
Subject: [PATCH 1/2] ASoC: stm32: spdifrx: fix 16 bits capture
In-Reply-To: <1509981533-28622-1-git-send-email-olivier.moysan@st.com>
References: <1509981533-28622-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1509981533-28622-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change DMA bus width to manage properly 16 bits packed format.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 84cc567..d7dbe84 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -750,17 +750,21 @@ static int stm32_spdifrx_hw_params(struct snd_pcm_substream *substream,
 	switch (data_size) {
 	case 16:
 		fmt = SPDIFRX_DRFMT_PACKED;
-		spdifrx->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case 32:
 		fmt = SPDIFRX_DRFMT_LEFT;
-		spdifrx->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	default:
 		dev_err(&spdifrx->pdev->dev, "Unexpected data format\n");
 		return -EINVAL;
 	}
 
+	/*
+	 * Set buswidth to 4 bytes for all data formats.
+	 * Packed format: transfer 2 x 2 bytes samples
+	 * Left format: transfer 1 x 3 bytes samples + 1 dummy byte
+	 */
+	spdifrx->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	snd_soc_dai_init_dma_data(cpu_dai, NULL, &spdifrx->dma_params);
 
 	return regmap_update_bits(spdifrx->regmap, STM32_SPDIFRX_CR,
-- 
1.9.1
