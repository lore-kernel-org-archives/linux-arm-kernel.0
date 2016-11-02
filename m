From: broonie@kernel.org (Mark Brown)
Date: Wed, 02 Nov 2016 10:46:30 -0600
Subject: Applied "ASoC: dapm: Introduce DAPM_DOUBLE_R dual channel dual
 register control type" to the asoc tree
In-Reply-To: <20161003110804.28235-5-wens@csie.org>
Message-ID: <E1c1ygI-00067x-TN@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: dapm: Introduce DAPM_DOUBLE_R dual channel dual register control type

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

>From 02866eab0f0d88c4b6a68de72022c2b26f0359b5 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 Nov 2016 15:36:01 +0800
Subject: [PATCH] ASoC: dapm: Introduce DAPM_DOUBLE_R dual channel dual
 register control type

A DAPM_DOUBLE_R control type can be used for dual channel mixer input
selectors / mute controls across 2 registers, possibly toggling both
channels together.

The control is meant to be shared by 2 widgets, 1 for each channel,
such that the mixer control exposed to userspace remains a combined
stereo control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index f74ec19687f8..a466f4bdc835 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -277,6 +277,11 @@ struct device;
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
 	.private_value = SOC_DOUBLE_VALUE(reg, lshift, rshift, max, invert, 0) }
+#define SOC_DAPM_DOUBLE_R(xname, lreg, rreg, shift, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value = SOC_DOUBLE_R_VALUE(lreg, rreg, shift, max, invert) }
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
-- 
2.10.1
