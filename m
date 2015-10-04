From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Oct 2015 15:38:16 +0200
Subject: [PATCH] ASoC: sun4i-codec: Rework and fix headphone routing
Message-ID: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the boards have their headphone jack directly connected to the
matching pins of the SoCs. Since most of the time we will have the same
routing path, it makes sense to put that in the driver, and only have a
property describing whether that route is enabled or not.

It also fixes the following warning messages that were seen so far:
sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

Reported-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      |  9 ++++----
 sound/soc/sunxi/sun4i-codec.c                      | 25 +++++++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 680144b74ae9..470823845698 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -13,10 +13,10 @@ Required properties:
 - clock-names: should contain followings:
    - "apb": the parent APB clock for this controller
    - "codec": the parent module clock
-- routing : A list of the connections between audio components.  Each
-  entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source.
 
+Optional Properties:
+- allwinner,hp-jack-attached: Indicates that the headphone jack on the
+                              board is directly routed to the SoC pins
 
 Example:
 codec: codec at 01c22c00 {
@@ -28,6 +28,5 @@ codec: codec at 01c22c00 {
 	clock-names = "apb", "codec";
 	dmas = <&dma 0 19>, <&dma 0 19>;
 	dma-names = "rx", "tx";
-	routing = "Headphone Jack", "HP Right",
-		  "Headphone Jack", "HP Left";
+	allwinner,hp-jack-attached;
 };
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 47780552dcd0..e86b8fcede5a 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -568,10 +568,18 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 	return link;
 };
 
+static const struct snd_soc_dapm_widget sun4i_codec_sink_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route sun4i_codec_sink_routes[] = {
+	{ "Headphone Jack", NULL, "HP Right" },
+	{ "Headphone Jack", NULL, "HP Left" },
+};
+
 static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 {
 	struct snd_soc_card *card;
-	int ret;
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
@@ -584,10 +592,17 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	card->dev		= dev;
 	card->name		= "sun4i-codec";
 
-	ret = snd_soc_of_parse_audio_routing(card, "routing");
-	if (ret) {
-		dev_err(dev, "Failed to create our audio routing\n");
-		return NULL;
+	/*
+	 * FIXME: This will probably require more logic once we will
+	 *        support other sinks (for capture for example), or
+	 *        encounter more complicated setups where the
+	 *        headphone jack is not directly connected to the SoC.
+	 */
+	if (of_property_read_bool(dev->of_node, "allwinner,hp-jack-attached")) {
+		card->dapm_widgets	= sun4i_codec_sink_widgets;
+		card->num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_sink_widgets);
+		card->dapm_routes	= sun4i_codec_sink_routes;
+		card->num_dapm_routes	= ARRAY_SIZE(sun4i_codec_sink_routes);
 	}
 
 	return card;
-- 
2.5.3
