From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  7 Oct 2015 11:59:58 +0100
Subject: [PATCH] ASoC: sun4i-codec: Remove the routing property
Message-ID: <1444215598-13543-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the boards have their headphone jack directly connected to the
matching pins of the SoCs. Since most of the time we will have the same
routing path, it makes no sense to put that in the DTS, since it will only
be some useless duplication there.

It also fixes the following warning messages that were seen so far, on
boards where we were using the bindings in the documentation example.

sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

Reported-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/sound/sun4i-codec.txt | 6 ------
 sound/soc/sunxi/sun4i-codec.c                           | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 680144b74ae9..c92966bd5488 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -13,10 +13,6 @@ Required properties:
 - clock-names: should contain followings:
    - "apb": the parent APB clock for this controller
    - "codec": the parent module clock
-- routing : A list of the connections between audio components.  Each
-  entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source.
-
 
 Example:
 codec: codec at 01c22c00 {
@@ -28,6 +24,4 @@ codec: codec at 01c22c00 {
 	clock-names = "apb", "codec";
 	dmas = <&dma 0 19>, <&dma 0 19>;
 	dma-names = "rx", "tx";
-	routing = "Headphone Jack", "HP Right",
-		  "Headphone Jack", "HP Left";
 };
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 47780552dcd0..bcbf4da168b6 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -571,7 +571,6 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 {
 	struct snd_soc_card *card;
-	int ret;
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
@@ -584,12 +583,6 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	card->dev		= dev;
 	card->name		= "sun4i-codec";
 
-	ret = snd_soc_of_parse_audio_routing(card, "routing");
-	if (ret) {
-		dev_err(dev, "Failed to create our audio routing\n");
-		return NULL;
-	}
-
 	return card;
 };
 
-- 
2.5.3
