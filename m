From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Oct 2017 12:27:52 +0100
Subject: Applied "ASoC: cygnus: Remove set_fmt from SPDIF dai ops" to the asoc
 tree
In-Reply-To: <1506637775-18293-3-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <E1dzhqC-0004EQ-7A@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: cygnus: Remove set_fmt from SPDIF dai ops

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

>From fcf30f3b4377d2475aa709ce28964461990c3caa Mon Sep 17 00:00:00 2001
From: Lori Hikichi <lori.hikichi@broadcom.com>
Date: Thu, 28 Sep 2017 15:29:34 -0700
Subject: [PATCH] ASoC: cygnus: Remove set_fmt from SPDIF dai ops

The SPDIF port cannot modify its format so a set_fmt function is not
needed. Previously, we used a generic set_fmt for all ports and returned
an error code for the SPDIF port. It is cleaner to not populate the
set_fmt field.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-ssp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index e9c73a451cf6..da14facb8a6f 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1137,6 +1137,13 @@ static const struct snd_soc_dai_ops cygnus_ssp_dai_ops = {
 	.set_tdm_slot	= cygnus_set_dai_tdm_slot,
 };
 
+static const struct snd_soc_dai_ops cygnus_spdif_dai_ops = {
+	.startup	= cygnus_ssp_startup,
+	.shutdown	= cygnus_ssp_shutdown,
+	.trigger	= cygnus_ssp_trigger,
+	.hw_params	= cygnus_ssp_hw_params,
+	.set_sysclk	= cygnus_ssp_set_sysclk,
+};
 
 #define INIT_CPU_DAI(num) { \
 	.name = "cygnus-ssp" #num, \
@@ -1175,7 +1182,7 @@ static const struct snd_soc_dai_driver cygnus_spdif_dai_info = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			SNDRV_PCM_FMTBIT_S32_LE,
 	},
-	.ops = &cygnus_ssp_dai_ops,
+	.ops = &cygnus_spdif_dai_ops,
 	.suspend = cygnus_ssp_suspend,
 	.resume = cygnus_ssp_resume,
 };
-- 
2.14.1
