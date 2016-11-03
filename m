From: broonie@kernel.org (Mark Brown)
Date: Thu, 03 Nov 2016 14:33:40 -0600
Subject: Applied "ASoC: sun4i-codec: Add support for A31 playback through
 headphone output" to the asoc tree
In-Reply-To: <20161103075556.29018-7-wens@csie.org>
Message-ID: <E1c2Ohg-0004Nu-8J@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Add support for A31 playback through headphone output

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

>From 8d9e4c9e993f34e7f74bf36f417920a01a42c4b0 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Nov 2016 15:55:48 +0800
Subject: [PATCH] ASoC: sun4i-codec: Add support for A31 playback through
 headphone output

The A31 has a similar codec to the A10/A20. The PCM parts are very
similar, with different register offsets. The analog paths are very
different. There are more inputs and outputs. The ADC mux has been
replaced with a proper mixer.

This patch adds support for the basic playback path of the A31 codec,
from the DAC to the headphones. Headphone detection, microphone,
signaling, other inputs/outputs and capture will be added later.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      |  22 +-
 sound/soc/sunxi/sun4i-codec.c                      | 271 ++++++++++++++++++++-
 2 files changed, 287 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 0dce690f78f5..bf480e9683a3 100644
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
@@ -17,6 +19,10 @@ Required properties:
 Optional properties:
 - allwinner,pa-gpios: gpio to enable external amplifier
 
+Required properties for the following compatibles:
+		- "allwinner,sun6i-a31-codec"
+- resets: phandle to the reset control for this device
+
 Example:
 codec: codec at 01c22c00 {
 	#sound-dai-cells = <0>;
@@ -28,3 +34,15 @@ codec: codec at 01c22c00 {
 	dmas = <&dma 0 19>, <&dma 0 19>;
 	dma-names = "rx", "tx";
 };
+
+codec: codec at 01c22c00 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun6i-a31-codec";
+	reg = <0x01c22c00 0x98>;
+	interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_APB1_CODEC>, <&ccu CLK_CODEC>;
+	clock-names = "apb", "codec";
+	resets = <&ccu RST_APB1_CODEC>;
+	dmas = <&dma 15>, <&dma 15>;
+	dma-names = "rx", "tx";
+};
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index d867b96d367b..d4b2186b5d84 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -109,6 +109,109 @@
 /* Microphone controls (sun7i only) */
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
+/*
+ * sun6i specific registers
+ *
+ * sun6i shares the same digital control and FIFO registers as sun4i,
+ * but only the DAC digital controls are at the same offset. The others
+ * have been moved around to accommodate extra analog controls.
+ */
+
+/* Codec DAC digital controls and FIFO registers */
+#define SUN6I_CODEC_ADC_FIFOC			(0x10)
+#define SUN6I_CODEC_ADC_FIFOC_EN_AD			(28)
+#define SUN6I_CODEC_ADC_FIFOS			(0x14)
+#define SUN6I_CODEC_ADC_RXDATA			(0x18)
+
+/* Output mixer and gain controls */
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
+#define SUN6I_CODEC_OM_PA_CTRL_HPCOM_CTL		(29)
+#define SUN6I_CODEC_OM_PA_CTRL_COMPTEN			(28)
+#define SUN6I_CODEC_OM_PA_CTRL_MIC1G			(15)
+#define SUN6I_CODEC_OM_PA_CTRL_MIC2G			(12)
+#define SUN6I_CODEC_OM_PA_CTRL_LINEING			(9)
+#define SUN6I_CODEC_OM_PA_CTRL_PHONEG			(6)
+#define SUN6I_CODEC_OM_PA_CTRL_PHONEPG			(3)
+#define SUN6I_CODEC_OM_PA_CTRL_PHONENG			(0)
+
+/* Microphone, line out and phone out controls */
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
+
+/* ADC mixer controls */
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
+
+/* Analog performance tuning controls */
+#define SUN6I_CODEC_ADDA_TUNE			(0x30)
+
+/* Calibration controls */
+#define SUN6I_CODEC_CALIBRATION			(0x34)
+
+/* FIFO counters */
+#define SUN6I_CODEC_DAC_TXCNT			(0x40)
+#define SUN6I_CODEC_ADC_RXCNT			(0x44)
+
+/* headset jack detection and button support registers */
+#define SUN6I_CODEC_HMIC_CTL			(0x50)
+#define SUN6I_CODEC_HMIC_DATA			(0x54)
+
+/* TODO sun6i DAP (Digital Audio Processing) bits */
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -214,9 +317,14 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 	 *        Allwinner's code mentions that it is related
 	 *        related to microphone gain
 	 */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_ACTL,
-			   0x3 << 25,
-			   0x1 << 25);
+	if (of_device_is_compatible(scodec->dev->of_node,
+				    "allwinner,sun4i-a10-codec") ||
+	    of_device_is_compatible(scodec->dev->of_node,
+				    "allwinner,sun7i-a20-codec")) {
+		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_ACTL,
+				   0x3 << 25,
+				   0x1 << 25);
+	}
 
 	if (of_device_is_compatible(scodec->dev->of_node,
 				    "allwinner,sun7i-a20-codec"))
@@ -516,7 +624,7 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 	},
 };
 
-/*** Codec ***/
+/*** sun4i Codec ***/
 static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 	SOC_DAPM_SINGLE("Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
@@ -652,6 +760,122 @@ static struct snd_soc_codec_driver sun4i_codec_codec = {
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
+	SOC_DAPM_ENUM("Headphone Source Playback Route",
+		      sun6i_codec_hp_src_enum),
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
+	SND_SOC_DAPM_DAC("Left DAC", "Codec Playback",
+			 SUN6I_CODEC_OM_DACA_CTRL,
+			 SUN6I_CODEC_OM_DACA_CTRL_DACALEN, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Codec Playback",
+			 SUN6I_CODEC_OM_DACA_CTRL,
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
+	SND_SOC_DAPM_SUPPLY("HPCOM Protection", SUN6I_CODEC_OM_PA_CTRL,
+			    SUN6I_CODEC_OM_PA_CTRL_COMPTEN, 0, NULL, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPCOM", SUN6I_CODEC_OM_PA_CTRL,
+			 SUN6I_CODEC_OM_PA_CTRL_HPCOM_CTL, 0x3, 0x3, 0),
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
+	{ "HPCOM", NULL, "HPCOM Protection" },
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
@@ -756,6 +980,24 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	return card;
 };
 
+static struct snd_soc_card *sun6i_codec_create_card(struct device *dev)
+{
+	struct snd_soc_card *card;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return ERR_PTR(-ENOMEM);
+
+	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
+	if (!card->dai_link)
+		return ERR_PTR(-ENOMEM);
+
+	card->dev	= dev;
+	card->name	= "A31 Audio Codec";
+
+	return card;
+};
+
 static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -763,6 +1005,13 @@ static const struct regmap_config sun4i_codec_regmap_config = {
 	.max_register	= SUN4I_CODEC_ADC_RXCNT,
 };
 
+static const struct regmap_config sun6i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN6I_CODEC_HMIC_DATA,
+};
+
 static const struct regmap_config sun7i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -788,6 +1037,16 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
 };
 
+static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
+	.regmap_config	= &sun6i_codec_regmap_config,
+	.codec		= &sun6i_codec_codec,
+	.create_card	= sun6i_codec_create_card,
+	.reg_adc_fifoc	= REG_FIELD(SUN6I_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
+	.has_reset	= true,
+};
+
 static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.regmap_config	= &sun7i_codec_regmap_config,
 	.codec		= &sun4i_codec_codec,
@@ -803,6 +1062,10 @@ static const struct of_device_id sun4i_codec_of_match[] = {
 		.data = &sun4i_codec_quirks,
 	},
 	{
+		.compatible = "allwinner,sun6i-a31-codec",
+		.data = &sun6i_a31_codec_quirks,
+	},
+	{
 		.compatible = "allwinner,sun7i-a20-codec",
 		.data = &sun7i_codec_quirks,
 	},
-- 
2.10.1
