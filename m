From: broonie@kernel.org (Mark Brown)
Date: Thu, 02 Nov 2017 11:05:55 +0000
Subject: Applied "ASoC: stm32: sai: fix warning in stm32_sai_set_config()" to
 the asoc tree
In-Reply-To: <1509618009-30804-1-git-send-email-olivier.moysan@st.com>
Message-ID: <E1eADJr-0002Cr-9J@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: fix warning in stm32_sai_set_config()

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

>From 7e751e375ae7218f8b49f0b47e855cf9bbbdbcf9 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Thu, 2 Nov 2017 11:20:09 +0100
Subject: [PATCH] ASoC: stm32: sai: fix warning in stm32_sai_set_config()

Fix uninitialized warning introduced by
"Move static settings to DAI init" commit
in stm32_sai_set_config() function.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 150ad546d8b9..08583b958430 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -482,13 +482,13 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 	cr1_mask = SAI_XCR1_DS_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_8);
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_16);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_16);
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_32);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_32);
 		break;
 	default:
 		dev_err(cpu_dai->dev, "Data format not supported");
-- 
2.15.0
