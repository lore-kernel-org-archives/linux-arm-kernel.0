From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 6 Nov 2017 16:18:53 +0100
Subject: [PATCH 2/2] ASoC: stm32: spdifrx: fix control DMA error management
In-Reply-To: <1509981533-28622-1-git-send-email-olivier.moysan@st.com>
References: <1509981533-28622-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1509981533-28622-3-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix DMA channel request error handling.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index d7dbe84..b9bdefc 100644
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
1.9.1
