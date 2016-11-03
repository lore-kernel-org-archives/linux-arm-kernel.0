From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Nov 2016 15:55:53 +0800
Subject: [PATCH v2 11/14] ASoC: sun4i-codec: Add support for A31 board level
 audio routing
In-Reply-To: <20161103075556.29018-1-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
Message-ID: <20161103075556.29018-12-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC's codec has various inputs, outputs and microphone bias
supplies. These can be routed on the board in different ways, such as:

  - HPCOM may be connected to have the headphone DC coupled.

  - Microphones all use the MBIAS main microphone supply or one mic may
    use the HBIAS supply, which supports headset detection and buttons.

  - Line Out may be routed to an audio jack, or an onboard speaker amp
    with power controls.

Add support for specifying the audio routes in the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      | 33 ++++++++++++++++++++++
 sound/soc/sunxi/sun4i-codec.c                      | 21 ++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index bf480e9683a3..d91a95377f49 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -22,6 +22,31 @@ Optional properties:
 Required properties for the following compatibles:
 		- "allwinner,sun6i-a31-codec"
 - resets: phandle to the reset control for this device
+- allwinner,audio-routing: A list of the connections between audio components.
+			   Each entry is a pair of strings, the first being the
+			   connection's sink, the second being the connection's
+			   source. Valid names include:
+
+			   Audio pins on the SoC:
+			   "HP"
+			   "HPCOM"
+			   "LINEIN"
+			   "LINEOUT"
+			   "MIC1"
+			   "MIC2"
+			   "MIC3"
+
+			   Microphone biases from the SoC:
+			   "HBIAS"
+			   "MBIAS"
+
+			   Board connectors:
+			   "Headphone"
+			   "Headset Mic"
+			   "Line In"
+			   "Line Out"
+			   "Mic"
+			   "Speaker"
 
 Example:
 codec: codec at 01c22c00 {
@@ -45,4 +70,12 @@ codec: codec at 01c22c00 {
 	resets = <&ccu RST_APB1_CODEC>;
 	dmas = <&dma 15>, <&dma 15>;
 	dma-names = "rx", "tx";
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Speaker", "LINEOUT",
+		"LINEIN", "Line In",
+		"MIC1",	"MBIAS",
+		"MIC1", "Mic",
+		"MIC2", "HBIAS",
+		"MIC2", "Headset Mic";
 };
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 0cb728964ff0..6379efd21f00 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1171,9 +1171,19 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct snd_soc_dapm_widget sun6i_codec_card_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
+};
+
 static struct snd_soc_card *sun6i_codec_create_card(struct device *dev)
 {
 	struct snd_soc_card *card;
+	int ret;
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
@@ -1183,8 +1193,15 @@ static struct snd_soc_card *sun6i_codec_create_card(struct device *dev)
 	if (!card->dai_link)
 		return ERR_PTR(-ENOMEM);
 
-	card->dev	= dev;
-	card->name	= "A31 Audio Codec";
+	card->dev		= dev;
+	card->name		= "A31 Audio Codec";
+	card->dapm_widgets	= sun6i_codec_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(sun6i_codec_card_dapm_widgets);
+	card->fully_routed	= true;
+
+	ret = snd_soc_of_parse_audio_routing(card, "allwinner,audio-routing");
+	if (ret)
+		dev_warn(dev, "failed to parse audio-routing: %d\n", ret);
 
 	return card;
 };
-- 
2.10.2
