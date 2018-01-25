From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jan 2018 12:15:22 +0000
Subject: Applied "ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink" to the
 asoc tree
In-Reply-To: <20171121082517.17233-1-jeffy.chen@rock-chips.com>
Message-ID: <E1eegR8-0006Sc-0T@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink

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

>From fde7f9dbc71365230eeb8c8ea97ce9b552c8e5bd Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Tue, 21 Nov 2017 16:25:17 +0800
Subject: [PATCH] ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink

The rt5514 dsp captures pcm data through spi directly, so we should not
use rockchip-i2s as it's cpu dai like other codecs.

Use dummy_dai for rt5514 dsp dailink to make voice wakeup work again.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Fixes: (72cfb0f20c75 ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index d64fbbd50544..aa8ffd035377 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -367,7 +367,8 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
 		.stream_name = "Wake on Voice",
-		.codec_dai_name = "rt5514-dsp-cpu-dai",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
 	},
 };
 
@@ -528,7 +529,18 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		if (index < 0)
 			continue;
 
-		np_cpu = (index == DAILINK_CDNDP) ? np_cpu1 : np_cpu0;
+		switch (index) {
+		case DAILINK_CDNDP:
+			np_cpu = np_cpu1;
+			break;
+		case DAILINK_RT5514_DSP:
+			np_cpu = np_codec;
+			break;
+		default:
+			np_cpu = np_cpu0;
+			break;
+		}
+
 		if (!np_cpu) {
 			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
 				rockchip_dais[index].name);
@@ -538,7 +550,8 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		dai = &card->dai_link[card->num_links++];
 		*dai = rockchip_dais[index];
 
-		dai->codec_of_node = np_codec;
+		if (!dai->codec_name)
+			dai->codec_of_node = np_codec;
 		dai->platform_of_node = np_cpu;
 		dai->cpu_of_node = np_cpu;
 
-- 
2.15.1
