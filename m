From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Jul 2016 17:43:40 +0100
Subject: Applied "ASoC: rockchip: correct the spdif clk" to the asoc tree
In-Reply-To: <1468852474-15735-1-git-send-email-zyw@rock-chips.com>
Message-ID: <E1bPuay-0002iL-Ap@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: correct the spdif clk

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

>From 46dd2e28a90e48fbf1b7e253933fa3b7242e9b1b Mon Sep 17 00:00:00 2001
From: Chris Zhong <zyw@rock-chips.com>
Date: Mon, 18 Jul 2016 22:34:34 +0800
Subject: [PATCH] ASoC: rockchip: correct the spdif clk

The spdif mclk should be 128 times of sample rate, and there is a
internal divider, the real rate of spdif mclk is mclk / (div + 1).
Hence, the original driver always get the good frequency for
48000/96000/44100/192000. But for 32000, the mclk is incorrect,
it should be 32000*128, but get 48000*128. Do not use the internal
divider here, just set all mclk to 128 * sample rate directly.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 100781e37848..4ca265737eda 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -101,21 +101,7 @@ static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	srate = params_rate(params);
-	switch (srate) {
-	case 32000:
-	case 48000:
-	case 96000:
-		mclk = 96000 * 128; /* 12288000 hz */
-		break;
-	case 44100:
-		mclk = 44100 * 256; /* 11289600 hz */
-		break;
-	case 192000:
-		mclk = 192000 * 128; /* 24576000 hz */
-		break;
-	default:
-		return -EINVAL;
-	}
+	mclk = srate * 128;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -139,7 +125,6 @@ static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	val |= SPDIF_CFGR_CLK_DIV(mclk/(srate * 256));
 	ret = regmap_update_bits(spdif->regmap, SPDIF_CFGR,
 		SPDIF_CFGR_CLK_DIV_MASK | SPDIF_CFGR_HALFWORD_ENABLE |
 		SDPIF_CFGR_VDW_MASK,
-- 
2.8.1
