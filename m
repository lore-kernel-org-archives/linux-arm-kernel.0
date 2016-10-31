From: broonie@kernel.org (Mark Brown)
Date: Mon, 31 Oct 2016 09:49:25 -0600
Subject: Applied "ASoC: sun4i-codec: return error code instead of NULL when
 create_card fails" to the asoc tree
In-Reply-To: <20161031064209.12241-1-wens@csie.org>
Message-ID: <E1c1Epx-0000n0-CM@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: return error code instead of NULL when create_card fails

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

>From 85915b63ad8b796848f431b66c9ba5e356e722e5 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 31 Oct 2016 14:42:09 +0800
Subject: [PATCH] ASoC: sun4i-codec: return error code instead of NULL when
 create_card fails

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
