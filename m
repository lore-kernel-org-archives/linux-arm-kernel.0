From: broonie@kernel.org (Mark Brown)
Date: Thu, 03 Nov 2016 14:34:00 -0600
Subject: Applied "ASoC: sun4i-codec: Expand quirks to handle register offsets
 and card creation" to the asoc tree
In-Reply-To: <20161103075556.29018-3-wens@csie.org>
Message-ID: <E1c2Oi0-0004QD-NE@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Expand quirks to handle register offsets and card creation

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

>From bc03f0d576000739694ed95e89c71cda78964224 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Nov 2016 15:55:44 +0800
Subject: [PATCH] ASoC: sun4i-codec: Expand quirks to handle register offsets
 and card creation

The A31 has a similar codec to the A10/A20. The PCM parts are very
similar, with just different register offsets. The analog paths are
very different. There are more inputs and outputs.

The A31s, A23, and H3 have a similar PCM interface, again with register
offsets slightly rearranged. The analog path controls, while very
similar between them and the A31, have been moved a separate bus which
is accessed through a message box like interface in the PRCM address
range. This would be handled by a separate auxiliary device tied in
through the device tree in its supporting create_card function.

The quirks structure is expanded to include different register offsets
and separate callbacks for creating the ASoC card. The regmap_config,
quirks, and of_device_match tables have been moved to facilitate this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 87 +++++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 5ff071fd4996..61ae502a5061 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -3,6 +3,7 @@
  * Copyright 2014 Jon Smirl <jonsmirl@gmail.com>
  * Copyright 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
  * Copyright 2015 Adam Sampson <ats@offog.org>
+ * Copyright 2016 Chen-Yu Tsai <wens@csie.org>
  *
  * Based on the Allwinner SDK driver, released under the GPL.
  *
@@ -24,8 +25,9 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/gpio/consumer.h>
@@ -114,6 +116,9 @@ struct sun4i_codec {
 	struct clk	*clk_module;
 	struct gpio_desc *gpio_pa;
 
+	/* ADC_FIFOC register is at different offset on different SoCs */
+	struct regmap_field *reg_adc_fifoc;
+
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 };
@@ -142,16 +147,16 @@ static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 {
 	/* Enable ADC DRQ */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN),
-			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
+	regmap_field_update_bits(scodec->reg_adc_fifoc,
+				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN),
+				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
 }
 
 static void sun4i_codec_stop_capture(struct sun4i_codec *scodec)
 {
 	/* Disable ADC DRQ */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN), 0);
+	regmap_field_update_bits(scodec->reg_adc_fifoc,
+				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN), 0);
 }
 
 static int sun4i_codec_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -194,15 +199,15 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 
 
 	/* Flush RX FIFO */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-			   BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH),
-			   BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH));
+	regmap_field_update_bits(scodec->reg_adc_fifoc,
+				 BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH),
+				 BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH));
 
 
 	/* Set RX FIFO trigger level */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-			   0xf << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
-			   0x7 << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL);
+	regmap_field_update_bits(scodec->reg_adc_fifoc,
+				 0xf << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
+				 0x7 << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL);
 
 	/*
 	 * FIXME: Undocumented in the datasheet, but
@@ -221,9 +226,9 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 				   0x1 << 8);
 
 	/* Fill most significant bits with valid data MSB */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-			   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
-			   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
+	regmap_field_update_bits(scodec->reg_adc_fifoc,
+				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
+				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
 
 	return 0;
 }
@@ -350,18 +355,19 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 					 unsigned int hwrate)
 {
 	/* Set ADC sample rate */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-			   7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
-			   hwrate << SUN4I_CODEC_ADC_FIFOC_ADC_FS);
+	regmap_field_update_bits(scodec->reg_adc_fifoc,
+				 7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
+				 hwrate << SUN4I_CODEC_ADC_FIFOC_ADC_FS);
 
 	/* Set the number of channels we want to use */
 	if (params_channels(params) == 1)
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
-				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
+					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
 	else
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN), 0);
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
+					 0);
 
 	return 0;
 }
@@ -766,14 +772,29 @@ static const struct regmap_config sun7i_codec_regmap_config = {
 
 struct sun4i_codec_quirks {
 	const struct regmap_config *regmap_config;
+	const struct snd_soc_codec_driver *codec;
+	struct snd_soc_card * (*create_card)(struct device *dev);
+	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
 };
 
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.regmap_config	= &sun4i_codec_regmap_config,
+	.codec		= &sun4i_codec_codec,
+	.create_card	= sun4i_codec_create_card,
+	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
 };
 
 static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.regmap_config	= &sun7i_codec_regmap_config,
+	.codec		= &sun4i_codec_codec,
+	.create_card	= sun4i_codec_create_card,
+	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
@@ -846,6 +867,17 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* reg_field setup */
+	scodec->reg_adc_fifoc = devm_regmap_field_alloc(&pdev->dev,
+							scodec->regmap,
+							quirks->reg_adc_fifoc);
+	if (IS_ERR(scodec->reg_adc_fifoc)) {
+		ret = PTR_ERR(scodec->reg_adc_fifoc);
+		dev_err(&pdev->dev, "Failed to create regmap fields: %d\n",
+			ret);
+		return ret;
+	}
+
 	/* Enable the bus clock */
 	if (clk_prepare_enable(scodec->clk_apb)) {
 		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
@@ -853,16 +885,16 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	}
 
 	/* DMA configuration for TX FIFO */
-	scodec->playback_dma_data.addr = res->start + SUN4I_CODEC_DAC_TXDATA;
+	scodec->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
 	scodec->playback_dma_data.maxburst = 4;
 	scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	/* DMA configuration for RX FIFO */
-	scodec->capture_dma_data.addr = res->start + SUN4I_CODEC_ADC_RXDATA;
+	scodec->capture_dma_data.addr = res->start + quirks->reg_adc_rxdata;
 	scodec->capture_dma_data.maxburst = 4;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
-	ret = snd_soc_register_codec(&pdev->dev, &sun4i_codec_codec,
+	ret = snd_soc_register_codec(&pdev->dev, quirks->codec,
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
@@ -883,7 +915,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		goto err_unregister_codec;
 	}
 
-	card = sun4i_codec_create_card(&pdev->dev);
+	card = quirks->create_card(&pdev->dev);
 	if (IS_ERR(card)) {
 		ret = PTR_ERR(card);
 		dev_err(&pdev->dev, "Failed to create our card\n");
@@ -934,4 +966,5 @@ MODULE_DESCRIPTION("Allwinner A10 codec driver");
 MODULE_AUTHOR("Emilio L??pez <emilio@elopez.com.ar>");
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
 MODULE_LICENSE("GPL");
-- 
2.10.1
