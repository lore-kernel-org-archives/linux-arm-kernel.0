From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri,  5 Jan 2018 14:12:42 -0800
Subject: [PATCH] ASoC: rockchip: i2s: Support mono capture
Message-ID: <20180105221242.22083-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rockchip I2S controller only allows to configure even numbers of
capture channels. It is still possible to capture monophonic audio by
using dual-channel mode and ignoring the 'data' from the second
channel.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
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
2.16.0.rc0.223.g4a4ac83678-goog
