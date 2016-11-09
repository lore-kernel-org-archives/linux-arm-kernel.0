From: broonie@kernel.org (Mark Brown)
Date: Wed, 09 Nov 2016 14:59:08 +0000
Subject: Applied "ASoC: sun4i-codec: Add support for optional reset control to
 quirks" to the asoc tree
In-Reply-To: <20161103075556.29018-6-wens@csie.org>
Message-ID: <E1c4ULE-0002cs-8n@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Add support for optional reset control to quirks

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9aead156c0665a362c8b007b51fe3396fea4d346 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 7 Nov 2016 18:06:58 +0800
Subject: [PATCH] ASoC: sun4i-codec: Add support for optional reset control to
 quirks

The later Allwinner SoCs have a dedicated reset controller, and
peripherals have dedicated reset controls which need to be deasserted
before the associated peripheral can be used.

Add support for this to the quirks structure and probe/remove functions.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 735115244b17..6379efd21f00 100644
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
@@ -1232,6 +1234,7 @@ struct sun4i_codec_quirks {
 	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
 	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
 	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
+	bool has_reset;
 };
 
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
@@ -1327,6 +1330,14 @@ static int sun4i_codec_probe(struct platform_device *pdev)
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
@@ -1353,6 +1364,16 @@ static int sun4i_codec_probe(struct platform_device *pdev)
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
@@ -1367,7 +1388,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
-		goto err_clk_disable;
+		goto err_assert_reset;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
@@ -1404,6 +1425,9 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 err_unregister_codec:
 	snd_soc_unregister_codec(&pdev->dev);
+err_assert_reset:
+	if (scodec->rst)
+		reset_control_assert(scodec->rst);
 err_clk_disable:
 	clk_disable_unprepare(scodec->clk_apb);
 	return ret;
@@ -1416,6 +1440,8 @@ static int sun4i_codec_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_card(card);
 	snd_soc_unregister_codec(&pdev->dev);
+	if (scodec->rst)
+		reset_control_assert(scodec->rst);
 	clk_disable_unprepare(scodec->clk_apb);
 
 	return 0;
-- 
2.10.2
