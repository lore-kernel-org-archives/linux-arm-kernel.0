From: broonie@kernel.org (Mark Brown)
Date: Wed, 08 Nov 2017 16:08:07 +0000
Subject: Applied "ASoC: stm32: spdifrx: fix 16 bits capture" to the asoc tree
In-Reply-To: <1509981533-28622-2-git-send-email-olivier.moysan@st.com>
Message-ID: <E1eCStb-0002F5-Ck@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: spdifrx: fix 16 bits capture

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9036e4acc81700a51e5f42820ba4570bea9b6f48 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Mon, 6 Nov 2017 16:18:52 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: fix 16 bits capture

Change DMA bus width to manage properly 16 bits packed format.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 84cc5678beba..d7dbe84d5eeb 100644
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
2.15.0
