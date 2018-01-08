From: broonie@kernel.org (Mark Brown)
Date: Mon, 08 Jan 2018 12:35:31 +0000
Subject: Applied "ASoC: rockchip: i2s: Support mono capture" to the asoc tree
In-Reply-To: <20180105221242.22083-1-mka@chromium.org>
Message-ID: <E1eYWeJ-0003HQ-NH@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: i2s: Support mono capture

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

>From db51707b9c9aeedd310ebce60f15d5bb006567e0 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Fri, 5 Jan 2018 14:12:42 -0800
Subject: [PATCH] ASoC: rockchip: i2s: Support mono capture

The Rockchip I2S controller only allows to configure even numbers of
capture channels. It is still possible to capture monophonic audio by
using dual-channel mode and ignoring the 'data' from the second
channel.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 908211e1d6fc..cc22ab3d10dd 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -328,6 +328,7 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 		val |= I2S_CHN_4;
 		break;
 	case 2:
+	case 1:
 		val |= I2S_CHN_2;
 		break;
 	default:
@@ -460,7 +461,7 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 	},
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = (SNDRV_PCM_FMTBIT_S8 |
@@ -654,7 +655,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
-		if (val >= 2 && val <= 8)
+		if (val >= 1 && val <= 8)
 			soc_dai->capture.channels_max = val;
 	}
 
-- 
2.15.1
