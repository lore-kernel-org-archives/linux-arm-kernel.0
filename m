From: andrea.bondavalli74@gmail.com (Andrea Bondavalli)
Date: Sun, 29 Oct 2017 02:41:01 -0700
Subject: [PATCH] ASoC: sun4i-codec: fixed 32bit audio capture support for
 H3/H2+
Message-ID: <20171029094048.GA5295@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed support for 32bit audio capture for Allwinner H3/H2+ SoC

Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index baa9007..f40fa34 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -346,11 +346,6 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 				   0x3 << 8,
 				   0x1 << 8);
 
-	/* Fill most significant bits with valid data MSB */
-	regmap_field_update_bits(scodec->reg_adc_fifoc,
-				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
-				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
-
 	return 0;
 }
 
@@ -490,6 +485,30 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
 					 0);
 
+	/* Set the number of sample bits to either 16 or 24 bits */
+	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min == 32) {
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS));
+
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
+				   0);
+
+		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
+				   0);
+
+		/* Fill most significant bits with valid data MSB */
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
+
+		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	}
+
 	return 0;
 }
 
-- 
2.5.0


---
Questa e-mail ? stata controllata per individuare virus con Avast antivirus.
https://www.avast.com/antivirus
