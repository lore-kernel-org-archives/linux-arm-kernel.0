From: broonie@kernel.org (Mark Brown)
Date: Wed, 08 Nov 2017 18:26:19 +0000
Subject: Applied "ASoC: sun8i-codec: Invert Master / Slave condition" to the
 asoc tree
In-Reply-To: <20171108154710.16407-2-maxime.ripard@free-electrons.com>
Message-ID: <E1eCV3L-0006hn-9S@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Invert Master / Slave condition

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 560bfe774f058e97596f30ff71cffdac52b72914 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 8 Nov 2017 16:47:08 +0100
Subject: [PATCH] ASoC: sun8i-codec: Invert Master / Slave condition

The current code had the condition backward when checking if the codec
should be running in slave or master mode.

Fix it, and make the comment a bit more readable.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index abfb710df7cb..038107baf414 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -170,11 +170,11 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	/* clock masters */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS: /* DAI Slave */
-		value = 0x0; /* Codec Master */
+	case SND_SOC_DAIFMT_CBS_CFS: /* Codec slave, DAI master */
+		value = 0x1;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFM: /* DAI Master */
-		value = 0x1; /* Codec Slave */
+	case SND_SOC_DAIFMT_CBM_CFM: /* Codec Master, DAI slave */
+		value = 0x0;
 		break;
 	default:
 		return -EINVAL;
-- 
2.15.0
