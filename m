From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Jun 2017 17:23:43 +0100
Subject: Applied "ASoC: zx-i2s: flip I2S master/slave mode" to the asoc tree
In-Reply-To: <1497709528-23036-1-git-send-email-shawnguo@kernel.org>
Message-ID: <E1dMzSp-0002Ki-8H@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: zx-i2s: flip I2S master/slave mode

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

>From a205c159f9e2db586a5ea475f4d22fa22e78fed8 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Sat, 17 Jun 2017 22:25:28 +0800
Subject: [PATCH] ASoC: zx-i2s: flip I2S master/slave mode

The SND_SOC_DAIFMT_MASTER bits are defined to specify the master/slave
mode for Codec, not I2S.  So the I2S master/slave mode should be flipped
according to SND_SOC_DAIFMT_MASTER bits.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 sound/soc/zte/zx-i2s.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index a7f7a56e0a2d..8bbad1d72bc5 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -203,13 +203,15 @@ static int zx_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		i2s->master = 1;
-		val |= ZX_I2S_TIMING_MAST;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Codec is master, and I2S is slave. */
 		i2s->master = 0;
 		val |= ZX_I2S_TIMING_SLAVE;
 		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Codec is slave, and I2S is master. */
+		i2s->master = 1;
+		val |= ZX_I2S_TIMING_MAST;
+		break;
 	default:
 		dev_err(cpu_dai->dev, "Unknown master/slave format\n");
 		return -EINVAL;
-- 
2.11.0
