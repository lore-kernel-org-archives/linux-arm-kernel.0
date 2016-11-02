From: broonie@kernel.org (Mark Brown)
Date: Wed, 02 Nov 2016 10:47:03 -0600
Subject: Applied "ASoC: dapm: Introduce DAPM_DOUBLE dual channel control type"
 to the asoc tree
In-Reply-To: <20161003110804.28235-4-wens@csie.org>
Message-ID: <E1c1ygp-00069E-3q@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: dapm: Introduce DAPM_DOUBLE dual channel control type

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

>From 9ee7ef31b5a07cdca88cae023c613e045af935b9 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 Nov 2016 15:36:00 +0800
Subject: [PATCH] ASoC: dapm: Introduce DAPM_DOUBLE dual channel control type

A DAPM_DOUBLE control type can be used for dual channel mixer input
selectors / mute controls in one register, possibly toggling both
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
index d5f4677776ce..f74ec19687f8 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -272,6 +272,11 @@ struct device;
 
 
 /* dapm kcontrol types */
+#define SOC_DAPM_DOUBLE(xname, reg, lshift, rshift, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value = SOC_DOUBLE_VALUE(reg, lshift, rshift, max, invert, 0) }
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
-- 
2.10.1
