From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 31 Oct 2016 14:42:09 +0800
Subject: [PATCH] ASoC: sun4i-codec: return error code instead of NULL when
 create_card fails
Message-ID: <20161031064209.12241-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When sun4i_codec_create_card fails, we do not assign a proper error
code to the return value. The return value would be 0 from the previous
function call, or we would have bailed out sooner. This would confuse
the driver core into thinking the device probe succeeded, when in fact
it didn't, leaving various devres based resources lingering.

Make the create_card function pass back a meaningful error code, and
assign it to the return value.

Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip codec on
		      early Allwinner SoCs")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

In practice this should be really hard to hit, as the only failures in
create_card are memory allocation failures.

Should we mark this for stable?

---
 sound/soc/sunxi/sun4i-codec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index e047ec06d538..a60707761abf 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -765,11 +765,11 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	card->dev		= dev;
 	card->name		= "sun4i-codec";
@@ -876,7 +876,8 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	}
 
 	card = sun4i_codec_create_card(&pdev->dev);
-	if (!card) {
+	if (IS_ERR(card)) {
+		ret = PTR_ERR(card);
 		dev_err(&pdev->dev, "Failed to create our card\n");
 		goto err_unregister_codec;
 	}
-- 
2.10.1
