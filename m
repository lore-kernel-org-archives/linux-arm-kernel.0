From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Oct 2016 19:07:57 +0800
Subject: [PATCH 05/12] ASoC: sun4i-codec: Add support for A31 playback through
 headphone output
In-Reply-To: <20161003110804.28235-1-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Message-ID: <20161003110804.28235-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has a similar codec to the A10/A20. The PCM parts are very
similar, with just different register offsets. The analog paths are
very different. There are more inputs and outputs.

The quirks structure is expanded to include different register offsets
and separate callbacks for creating the ASoC card. Also the DMA burst
length is increased to 8. While the A10 DMA engine supports bursts of
1, 4 and 8, the A31 engine only supports 1 and 8.

This patch adds support for the basic playback path of the A31 codec,
from the DAC to the headphones. Headphone detection, microphone,
signaling, other inputs/outputs and capture will be added later.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      |   6 +-
 sound/soc/sunxi/sun4i-codec.c                      | 396 +++++++++++++++++----
 2 files changed, 334 insertions(+), 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 0dce690f78f5..1d2411cea98d 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -1,8 +1,10 @@
 * Allwinner A10 Codec
 
 Required properties:
-- compatible: must be either "allwinner,sun4i-a10-codec" or
-  "allwinner,sun7i-a20-codec"
+- compatible: must be one of the following compatibles:
+		- "allwinner,sun4i-a10-codec"
+		- "allwinner,sun6i-a31-codec"
+		- "allwinner,sun7i-a20-codec"
 - reg: must contain the registers location and length
 - interrupts: must contain the codec interrupt
 - dmas: DMA channels for tx and rx dma. See the DMA client binding,
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index e047ec06d538..9916714ecb71 100644
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
@@ -55,6 +57,8 @@
 #define SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH		(0)
 #define SUN4I_CODEC_DAC_FIFOS			(0x08)
 #define SUN4I_CODEC_DAC_TXDATA			(0x0c)
+
+/* Codec DAC side analog signal controls */
 #define SUN4I_CODEC_DAC_ACTL			(0x10)
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
@@ -81,6 +85,8 @@
 #define SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH		(0)
 #define SUN4I_CODEC_ADC_FIFOS			(0x20)
 #define SUN4I_CODEC_ADC_RXDATA			(0x24)
+
+/* Codec ADC side analog signal controls */
 #define SUN4I_CODEC_ADC_ACTL			(0x28)
 #define SUN4I_CODEC_ADC_ACTL_ADC_R_EN			(31)
 #define SUN4I_CODEC_ADC_ACTL_ADC_L_EN			(30)
@@ -93,18 +99,106 @@
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
 
-/* Other various ADC registers */
+/* FIFO counters */
 #define SUN4I_CODEC_DAC_TXCNT			(0x30)
 #define SUN4I_CODEC_ADC_RXCNT			(0x34)
+
+/* Other various ADC registers */
 #define SUN7I_CODEC_AC_DAC_CAL			(0x38)
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
+/*** sun6i specific register offsets ***/
+#define SUN6I_CODEC_ADC_FIFOC			(0x10)
+#define SUN6I_CODEC_ADC_FIFOC_EN_AD			(28)
+#define SUN6I_CODEC_ADC_FIFOS			(0x14)
+#define SUN6I_CODEC_ADC_RXDATA			(0x18)
+#define SUN6I_CODEC_OM_DACA_CTRL		(0x20)
+#define SUN6I_CODEC_OM_DACA_CTRL_DACAREN		(31)
+#define SUN6I_CODEC_OM_DACA_CTRL_DACALEN		(30)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIXEN			(29)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIXEN			(28)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIX_MIC1		(23)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIX_MIC2		(22)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIX_PHONE		(21)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIX_PHONEP		(20)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIX_LINEINR		(19)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIX_DACR		(18)
+#define SUN6I_CODEC_OM_DACA_CTRL_RMIX_DACL		(17)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIX_MIC1		(16)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIX_MIC2		(15)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIX_PHONE		(14)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIX_PHONEN		(13)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIX_LINEINL		(12)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIX_DACL		(11)
+#define SUN6I_CODEC_OM_DACA_CTRL_LMIX_DACR		(10)
+#define SUN6I_CODEC_OM_DACA_CTRL_RHPIS			(9)
+#define SUN6I_CODEC_OM_DACA_CTRL_LHPIS			(8)
+#define SUN6I_CODEC_OM_DACA_CTRL_RHPPAMUTE		(7)
+#define SUN6I_CODEC_OM_DACA_CTRL_LHPPAMUTE		(6)
+#define SUN6I_CODEC_OM_DACA_CTRL_HPVOL			(0)
+#define SUN6I_CODEC_OM_PA_CTRL			(0x24)
+#define SUN6I_CODEC_OM_PA_CTRL_HPPAEN			(31)
+#define SUN6I_CODEC_OM_PA_CTRL_MIC1G			(15)
+#define SUN6I_CODEC_OM_PA_CTRL_MIC2G			(12)
+#define SUN6I_CODEC_OM_PA_CTRL_LINEING			(9)
+#define SUN6I_CODEC_OM_PA_CTRL_PHONEG			(6)
+#define SUN6I_CODEC_OM_PA_CTRL_PHONEPG			(3)
+#define SUN6I_CODEC_OM_PA_CTRL_PHONENG			(0)
+#define SUN6I_CODEC_MIC_CTRL			(0x28)
+#define SUN6I_CODEC_MIC_CTRL_HBIASEN			(31)
+#define SUN6I_CODEC_MIC_CTRL_MBIASEN			(30)
+#define SUN6I_CODEC_MIC_CTRL_MIC1AMPEN			(28)
+#define SUN6I_CODEC_MIC_CTRL_MIC1BOOST			(25)
+#define SUN6I_CODEC_MIC_CTRL_MIC2AMPEN			(24)
+#define SUN6I_CODEC_MIC_CTRL_MIC2BOOST			(21)
+#define SUN6I_CODEC_MIC_CTRL_MIC2SLT			(20)
+#define SUN6I_CODEC_MIC_CTRL_LINEOUTLEN			(19)
+#define SUN6I_CODEC_MIC_CTRL_LINEOUTREN			(18)
+#define SUN6I_CODEC_MIC_CTRL_LINEOUTLSRC		(17)
+#define SUN6I_CODEC_MIC_CTRL_LINEOUTRSRC		(16)
+#define SUN6I_CODEC_MIC_CTRL_LINEOUTVC			(11)
+#define SUN6I_CODEC_MIC_CTRL_PHONEPREG			(8)
+#define SUN6I_CODEC_ADC_ACTL			(0x2c)
+#define SUN6I_CODEC_ADC_ACTL_ADCREN			(31)
+#define SUN6I_CODEC_ADC_ACTL_ADCLEN			(30)
+#define SUN6I_CODEC_ADC_ACTL_ADCRG			(27)
+#define SUN6I_CODEC_ADC_ACTL_ADCLG			(24)
+#define SUN6I_CODEC_ADC_ACTL_RADCMIX_MIC1		(13)
+#define SUN6I_CODEC_ADC_ACTL_RADCMIX_MIC2		(12)
+#define SUN6I_CODEC_ADC_ACTL_RADCMIX_PHONE		(11)
+#define SUN6I_CODEC_ADC_ACTL_RADCMIX_PHONEP		(10)
+#define SUN6I_CODEC_ADC_ACTL_RADCMIX_LINEINR		(9)
+#define SUN6I_CODEC_ADC_ACTL_RADCMIX_OMIXR		(8)
+#define SUN6I_CODEC_ADC_ACTL_RADCMIX_OMIXL		(7)
+#define SUN6I_CODEC_ADC_ACTL_LADCMIX_MIC1		(6)
+#define SUN6I_CODEC_ADC_ACTL_LADCMIX_MIC2		(5)
+#define SUN6I_CODEC_ADC_ACTL_LADCMIX_PHONE		(4)
+#define SUN6I_CODEC_ADC_ACTL_LADCMIX_PHONEN		(3)
+#define SUN6I_CODEC_ADC_ACTL_LADCMIX_LINEINL		(2)
+#define SUN6I_CODEC_ADC_ACTL_LADCMIX_OMIXL		(1)
+#define SUN6I_CODEC_ADC_ACTL_LADCMIX_OMIXR		(0)
+#define SUN6I_CODEC_ADDA_TUNE			(0x30)
+#define SUN6I_CODEC_CALIBRATION			(0x34)
+#define SUN6I_CODEC_DAC_TXCNT			(0x40)
+#define SUN6I_CODEC_ADC_RXCNT			(0x44)
+#define SUN6I_CODEC_HMIC_CTL			(0x50)
+#define SUN6I_CODEC_HMIC_DATA			(0x54)
+
+/* TODO sun6i DAP (Digital Audio Processing) bits */
+
+struct sun4i_codec_regs {
+	u32	adc_fifoc;
+	u32	adc_fifos;
+	u32	adc_rxdata;
+};
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
 	struct clk	*clk_apb;
 	struct clk	*clk_module;
 	struct gpio_desc *gpio_pa;
+	const struct sun4i_codec_regs *regs;
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
@@ -134,7 +228,7 @@ static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 {
 	/* Enable ADC DRQ */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+	regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN),
 			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
 }
@@ -142,7 +236,7 @@ static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 static void sun4i_codec_stop_capture(struct sun4i_codec *scodec)
 {
 	/* Disable ADC DRQ */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+	regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN), 0);
 }
 
@@ -186,13 +280,13 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 
 
 	/* Flush RX FIFO */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+	regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH),
 			   BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH));
 
 
 	/* Set RX FIFO trigger level */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+	regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 			   0xf << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
 			   0x7 << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL);
 
@@ -201,9 +295,12 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 	 *        Allwinner's code mentions that it is related
 	 *        related to microphone gain
 	 */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_ACTL,
-			   0x3 << 25,
-			   0x1 << 25);
+	if (!of_device_is_compatible(scodec->dev->of_node,
+				     "allwinner,sun6i-a31-codec")) {
+		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_ACTL,
+				   0x3 << 25,
+				   0x1 << 25);
+	}
 
 	if (of_device_is_compatible(scodec->dev->of_node,
 				    "allwinner,sun7i-a20-codec"))
@@ -213,7 +310,7 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 				   0x1 << 8);
 
 	/* Fill most significant bits with valid data MSB */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+	regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
 			   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
 
@@ -342,17 +439,17 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 					 unsigned int hwrate)
 {
 	/* Set ADC sample rate */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+	regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 			   7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
 			   hwrate << SUN4I_CODEC_ADC_FIFOC_ADC_FS);
 
 	/* Set the number of channels we want to use */
 	if (params_channels(params) == 1)
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+		regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
 				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
 	else
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+		regmap_update_bits(scodec->regmap, scodec->regs->adc_fifoc,
 				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN), 0);
 
 	return 0;
@@ -385,7 +482,7 @@ static int sun4i_codec_hw_params_playback(struct sun4i_codec *scodec,
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS),
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS));
 
-		/* Set TX FIFO mode to padding the LSBs with 0 */
+		/* Use higher 24 bits of TX FIFO */
 		regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE),
 				   0);
@@ -396,7 +493,7 @@ static int sun4i_codec_hw_params_playback(struct sun4i_codec *scodec,
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS),
 				   0);
 
-		/* Set TX FIFO mode to repeat the MSB */
+		/* Use lower 16 bits of TX FIFO */
 		regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE),
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE));
@@ -502,7 +599,7 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 	},
 };
 
-/*** Codec ***/
+/*** sun4i Codec ***/
 static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 	SOC_DAPM_SINGLE("Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
@@ -638,6 +735,114 @@ static struct snd_soc_codec_driver sun4i_codec_codec = {
 	},
 };
 
+/*** sun6i Codec ***/
+
+/* mixer controls */
+static const struct snd_kcontrol_new sun6i_codec_mixer_controls[] = {
+	SOC_DAPM_DOUBLE("DAC Playback Switch",
+			SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_LMIX_DACL,
+			SUN6I_CODEC_OM_DACA_CTRL_RMIX_DACR, 1, 0),
+	SOC_DAPM_DOUBLE("DAC Reversed Playback Switch",
+			SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_LMIX_DACR,
+			SUN6I_CODEC_OM_DACA_CTRL_RMIX_DACL, 1, 0),
+};
+
+/* headphone controls */
+static const char * const sun6i_codec_hp_src_enum_text[] = {
+	"DAC", "Mixer",
+};
+
+static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
+			    SUN6I_CODEC_OM_DACA_CTRL,
+			    SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
+			    SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
+			    sun6i_codec_hp_src_enum_text);
+
+static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
+	SOC_DAPM_ENUM("Headphone Source Playback Route", sun6i_codec_hp_src_enum),
+};
+
+/* volume / mute controls */
+static const DECLARE_TLV_DB_SCALE(sun6i_codec_dvol_scale, -7308, 116, 0);
+static const DECLARE_TLV_DB_SCALE(sun6i_codec_hp_vol_scale, -6300, 100, 1);
+
+static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
+	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
+		       SUN4I_CODEC_DAC_DPC_DVOL, 0x3f, 1,
+		       sun6i_codec_dvol_scale),
+	SOC_SINGLE_TLV("Headphone Playback Volume",
+		       SUN6I_CODEC_OM_DACA_CTRL,
+		       SUN6I_CODEC_OM_DACA_CTRL_HPVOL, 0x3f, 0,
+		       sun6i_codec_hp_vol_scale),
+	SOC_DOUBLE("Headphone Playback Switch",
+		   SUN6I_CODEC_OM_DACA_CTRL,
+		   SUN6I_CODEC_OM_DACA_CTRL_LHPPAMUTE,
+		   SUN6I_CODEC_OM_DACA_CTRL_RHPPAMUTE, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
+	/* Digital parts of the DACs */
+	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
+			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
+			    NULL, 0),
+
+	/* Analog parts of the DACs */
+	SND_SOC_DAPM_DAC("Left DAC", "Codec Playback", SUN6I_CODEC_OM_DACA_CTRL,
+			 SUN6I_CODEC_OM_DACA_CTRL_DACALEN, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Codec Playback", SUN6I_CODEC_OM_DACA_CTRL,
+			 SUN6I_CODEC_OM_DACA_CTRL_DACAREN, 0),
+
+	/* Mixers */
+	SOC_MIXER_ARRAY("Left Mixer", SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_LMIXEN, 0,
+			sun6i_codec_mixer_controls),
+	SOC_MIXER_ARRAY("Right Mixer", SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_RMIXEN, 0,
+			sun6i_codec_mixer_controls),
+
+	/* Headphone output path */
+	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
+			 SND_SOC_NOPM, 0, 0, sun6i_codec_hp_src),
+	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN6I_CODEC_OM_PA_CTRL,
+			     SUN6I_CODEC_OM_PA_CTRL_HPPAEN, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("HP"),
+};
+
+static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+
+	/* Left Mixer Routes */
+	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "DAC Reversed Playback Switch", "Right DAC" },
+
+	/* Right Mixer Routes */
+	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "DAC Reversed Playback Switch", "Left DAC" },
+
+	/* Headphone Routes */
+	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
+	{ "Headphone Source Playback Route", "DAC", "Right DAC" },
+	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
+	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
+	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
+	{ "HP", NULL, "Headphone Amp" },
+};
+
+static struct snd_soc_codec_driver sun6i_codec_codec = {
+	.component_driver = {
+		.controls		= sun6i_codec_codec_widgets,
+		.num_controls		= ARRAY_SIZE(sun6i_codec_codec_widgets),
+		.dapm_widgets		= sun6i_codec_codec_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(sun6i_codec_codec_dapm_widgets),
+		.dapm_routes		= sun6i_codec_codec_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(sun6i_codec_codec_dapm_routes),
+	},
+};
+
 static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name = "sun4i-codec",
 };
@@ -678,45 +883,6 @@ static struct snd_soc_dai_driver dummy_cpu_dai = {
 	 },
 };
 
-static const struct regmap_config sun4i_codec_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= SUN4I_CODEC_ADC_RXCNT,
-};
-
-static const struct regmap_config sun7i_codec_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
-};
-
-struct sun4i_codec_quirks {
-	const struct regmap_config *regmap_config;
-};
-
-static const struct sun4i_codec_quirks sun4i_codec_quirks = {
-	.regmap_config = &sun4i_codec_regmap_config,
-};
-
-static const struct sun4i_codec_quirks sun7i_codec_quirks = {
-	.regmap_config = &sun7i_codec_regmap_config,
-};
-
-static const struct of_device_id sun4i_codec_of_match[] = {
-	{
-		.compatible = "allwinner,sun4i-a10-codec",
-		.data = &sun4i_codec_quirks,
-	},
-	{
-		.compatible = "allwinner,sun7i-a20-codec",
-		.data = &sun7i_codec_quirks,
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
-
 static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 							int *num_links)
 {
@@ -781,6 +947,102 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	return card;
 };
 
+static struct snd_soc_card *sun6i_codec_create_card(struct device *dev)
+{
+	struct snd_soc_card *card;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return NULL;
+
+	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
+	if (!card->dai_link)
+		return NULL;
+
+	card->dev	= dev;
+	card->name	= "sun4i-codec";
+
+	return card;
+};
+
+static const struct regmap_config sun4i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN4I_CODEC_ADC_RXCNT,
+};
+
+static const struct regmap_config sun6i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN6I_CODEC_HMIC_DATA,
+};
+
+static const struct regmap_config sun7i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
+};
+
+static const struct sun4i_codec_regs sun4i_codec_regs = {
+	.adc_fifoc	= SUN4I_CODEC_ADC_FIFOC,
+	.adc_fifos	= SUN4I_CODEC_ADC_FIFOS,
+	.adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+};
+
+static const struct sun4i_codec_regs sun6i_codec_regs = {
+	.adc_fifoc	= SUN6I_CODEC_ADC_FIFOC,
+	.adc_fifos	= SUN6I_CODEC_ADC_FIFOS,
+	.adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
+};
+
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+	const struct snd_soc_codec_driver *codec;
+	const struct sun4i_codec_regs *regs;
+	struct snd_soc_card * (*create_card)(struct device *dev);
+};
+
+static const struct sun4i_codec_quirks sun4i_codec_quirks = {
+	.regmap_config	= &sun4i_codec_regmap_config,
+	.regs		= &sun4i_codec_regs,
+	.codec		= &sun4i_codec_codec,
+	.create_card	= sun4i_codec_create_card,
+};
+
+static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
+	.regmap_config	= &sun6i_codec_regmap_config,
+	.regs		= &sun6i_codec_regs,
+	.codec		= &sun6i_codec_codec,
+	.create_card	= sun6i_codec_create_card,
+};
+
+static const struct sun4i_codec_quirks sun7i_codec_quirks = {
+	.regmap_config	= &sun7i_codec_regmap_config,
+	.regs		= &sun4i_codec_regs,
+	.codec		= &sun4i_codec_codec,
+	.create_card	= sun4i_codec_create_card,
+};
+
+static const struct of_device_id sun4i_codec_of_match[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-codec",
+		.data = &sun4i_codec_quirks,
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-codec",
+		.data = &sun6i_a31_codec_quirks,
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-codec",
+		.data = &sun7i_codec_quirks,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
+
 static int sun4i_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
@@ -790,11 +1052,18 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (quirks == NULL) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	scodec = devm_kzalloc(&pdev->dev, sizeof(*scodec), GFP_KERNEL);
 	if (!scodec)
 		return -ENOMEM;
 
 	scodec->dev = &pdev->dev;
+	scodec->regs = quirks->regs;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -803,12 +1072,6 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
-	quirks = of_device_get_match_data(&pdev->dev);
-	if (quirks == NULL) {
-		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
-		return -ENODEV;
-	}
-
 	scodec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					       quirks->regmap_config);
 	if (IS_ERR(scodec->regmap)) {
@@ -846,15 +1109,15 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + SUN4I_CODEC_DAC_TXDATA;
-	scodec->playback_dma_data.maxburst = 4;
+	scodec->playback_dma_data.maxburst = 8;
 	scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	/* DMA configuration for RX FIFO */
-	scodec->capture_dma_data.addr = res->start + SUN4I_CODEC_ADC_RXDATA;
-	scodec->capture_dma_data.maxburst = 4;
+	scodec->capture_dma_data.addr = res->start + quirks->regs->adc_rxdata;
+	scodec->capture_dma_data.maxburst = 8;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
-	ret = snd_soc_register_codec(&pdev->dev, &sun4i_codec_codec,
+	ret = snd_soc_register_codec(&pdev->dev, quirks->codec,
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
@@ -875,7 +1138,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		goto err_unregister_codec;
 	}
 
-	card = sun4i_codec_create_card(&pdev->dev);
+	card = quirks->create_card(&pdev->dev);
 	if (!card) {
 		dev_err(&pdev->dev, "Failed to create our card\n");
 		goto err_unregister_codec;
@@ -925,4 +1188,5 @@ MODULE_DESCRIPTION("Allwinner A10 codec driver");
 MODULE_AUTHOR("Emilio L?pez <emilio@elopez.com.ar>");
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
 MODULE_LICENSE("GPL");
-- 
2.9.3
