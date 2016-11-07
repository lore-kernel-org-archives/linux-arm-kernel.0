From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  7 Nov 2016 18:06:58 +0800
Subject: [PATCH v3 1/6] ASoC: sun4i-codec: Add support for optional reset
 control to quirks
In-Reply-To: <20161107100703.5586-1-wens@csie.org>
References: <20161107100703.5586-1-wens@csie.org>
Message-ID: <20161107100703.5586-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The later Allwinner SoCs have a dedicated reset controller, and
peripherals have dedicated reset controls which need to be deasserted
before the associated peripheral can be used.

Add support for this to the quirks structure and probe/remove functions.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun4i-codec.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 1934db29b2b5..b28b82a5ec62 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
@@ -217,6 +218,7 @@ struct sun4i_codec {
 	struct regmap	*regmap;
 	struct clk	*clk_apb;
 	struct clk	*clk_module;
+	struct reset_control *rst;
 	struct gpio_desc *gpio_pa;
 
 	/* ADC_FIFOC register is at different offset on different SoCs */
@@ -1167,6 +1169,7 @@ struct sun4i_codec_quirks {
 	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
 	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
 	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
+	bool has_reset;
 };
 
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
@@ -1262,6 +1265,14 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(scodec->clk_module);
 	}
 
+	if (quirks->has_reset) {
+		scodec->rst = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(scodec->rst)) {
+			dev_err(&pdev->dev, "Failed to get reset control\n");
+			return PTR_ERR(scodec->rst);
+		}
+	};
+
 	scodec->gpio_pa = devm_gpiod_get_optional(&pdev->dev, "allwinner,pa",
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(scodec->gpio_pa)) {
@@ -1288,6 +1299,16 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* Deassert the reset control */
+	if (scodec->rst) {
+		ret = reset_control_deassert(scodec->rst);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to deassert the reset control\n");
+			goto err_clk_disable;
+		}
+	}
+
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
 	scodec->playback_dma_data.maxburst = 8;
@@ -1302,7 +1323,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
-		goto err_clk_disable;
+		goto err_assert_reset;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
@@ -1339,6 +1360,9 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 err_unregister_codec:
 	snd_soc_unregister_codec(&pdev->dev);
+err_assert_reset:
+	if (scodec->rst)
+		reset_control_assert(scodec->rst);
 err_clk_disable:
 	clk_disable_unprepare(scodec->clk_apb);
 	return ret;
@@ -1351,6 +1375,8 @@ static int sun4i_codec_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_card(card);
 	snd_soc_unregister_codec(&pdev->dev);
+	if (scodec->rst)
+		reset_control_assert(scodec->rst);
 	clk_disable_unprepare(scodec->clk_apb);
 
 	return 0;
-- 
2.10.2
