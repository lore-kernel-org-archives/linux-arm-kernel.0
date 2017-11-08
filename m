From: broonie@kernel.org (Mark Brown)
Date: Wed, 08 Nov 2017 16:08:04 +0000
Subject: Applied "ASoC: stm32: spdifrx: fix control DMA error management" to
 the asoc tree
In-Reply-To: <1509981533-28622-3-git-send-email-olivier.moysan@st.com>
Message-ID: <E1eCStY-0002Do-DQ@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: spdifrx: fix control DMA error management

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

>From 98c8dc2fd59fdad77d26d7b0d7007776c5fbec16 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Mon, 6 Nov 2017 16:18:53 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: fix control DMA error management

Fix DMA channel request error handling.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index d7dbe84d5eeb..b9bdefcd3e10 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -392,6 +392,12 @@ static int stm32_spdifrx_dma_ctrl_register(struct device *dev,
 {
 	int ret;
 
+	spdifrx->ctrl_chan = dma_request_chan(dev, "rx-ctrl");
+	if (IS_ERR(spdifrx->ctrl_chan)) {
+		dev_err(dev, "dma_request_slave_channel failed\n");
+		return PTR_ERR(spdifrx->ctrl_chan);
+	}
+
 	spdifrx->dmab = devm_kzalloc(dev, sizeof(struct snd_dma_buffer),
 				     GFP_KERNEL);
 	if (!spdifrx->dmab)
@@ -406,12 +412,6 @@ static int stm32_spdifrx_dma_ctrl_register(struct device *dev,
 		return ret;
 	}
 
-	spdifrx->ctrl_chan = dma_request_chan(dev, "rx-ctrl");
-	if (!spdifrx->ctrl_chan) {
-		dev_err(dev, "dma_request_slave_channel failed\n");
-		return -EINVAL;
-	}
-
 	spdifrx->slave_config.direction = DMA_DEV_TO_MEM;
 	spdifrx->slave_config.src_addr = (dma_addr_t)(spdifrx->phys_addr +
 					 STM32_SPDIFRX_CSR);
@@ -423,7 +423,6 @@ static int stm32_spdifrx_dma_ctrl_register(struct device *dev,
 				     &spdifrx->slave_config);
 	if (ret < 0) {
 		dev_err(dev, "dmaengine_slave_config returned error %d\n", ret);
-		dma_release_channel(spdifrx->ctrl_chan);
 		spdifrx->ctrl_chan = NULL;
 	}
 
@@ -962,7 +961,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	return 0;
 
 error:
-	if (spdifrx->ctrl_chan)
+	if (!IS_ERR(spdifrx->ctrl_chan))
 		dma_release_channel(spdifrx->ctrl_chan);
 	if (spdifrx->dmab)
 		snd_dma_free_pages(spdifrx->dmab);
-- 
2.15.0
