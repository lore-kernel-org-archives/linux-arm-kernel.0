From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Nov 2016 14:31:55 +0800
Subject: [PATCH] ASoC: sun4i-codec: Enable bus clock after getting GPIO
Message-ID: <20161101063155.15826-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current probe function the GPIO is acquired after the codec's
bus clock is enabled. However if it fails to acquire the GPIO due to
a deferred probe, it does not disable the bus clock before bailing out.
This would result in the clock being enabled multiple times.

Move the code that enables the bus clock after the part that gets the
GPIO, maintaining a separation between resource acquisition and device
enablement in the probe function.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index a60707761abf..56ed9472e89f 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -829,12 +829,6 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(scodec->clk_module);
 	}
 
-	/* Enable the bus clock */
-	if (clk_prepare_enable(scodec->clk_apb)) {
-		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
-		return -EINVAL;
-	}
-
 	scodec->gpio_pa = devm_gpiod_get_optional(&pdev->dev, "allwinner,pa",
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(scodec->gpio_pa)) {
@@ -844,6 +838,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Enable the bus clock */
+	if (clk_prepare_enable(scodec->clk_apb)) {
+		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
+		return -EINVAL;
+	}
+
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + SUN4I_CODEC_DAC_TXDATA;
 	scodec->playback_dma_data.maxburst = 4;
-- 
2.10.1
