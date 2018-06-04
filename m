From: broonie@kernel.org (Mark Brown)
Date: Mon, 04 Jun 2018 14:56:44 +0100
Subject: Applied "ASoC: dapm: delete dapm_kcontrol_data paths list before
 freeing it" to the asoc tree
In-Reply-To: <20180604111326.15708-1-srinivas.kandagatla@linaro.org>
Message-ID: <E1fPpyW-0004Ko-In@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it

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

>From ff2faf1289c1f81b5b26b9451dd1c2006aac8db8 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 4 Jun 2018 12:13:26 +0100
Subject: [PATCH] ASoC: dapm: delete dapm_kcontrol_data paths list before
 freeing it

dapm_kcontrol_data is freed as part of dapm_kcontrol_free(), leaving the
paths pointer dangling in the list.

This leads to system crash when we try to unload and reload sound card.
I hit this bug during ADSP crash/reboot test case on Dragon board DB410c.

Without this patch, on SLAB Poisoning enabled build, kernel crashes with
"BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten"

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1e9a36389667..36a39ba30226 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -433,6 +433,8 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+
+	list_del(&data->paths);
 	kfree(data->wlist);
 	kfree(data);
 }
-- 
2.17.0
