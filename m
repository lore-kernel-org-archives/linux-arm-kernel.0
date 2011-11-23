From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:24 -0700
Subject: [PATCH 16/17] ASoC: TrimSlice machine: Use new auto_nc_codec_pins
 feature
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-17-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set card.auto_nc_codec_pins to true to enable the feature, and remove all
the open-coded snd_soc_dapm_nc_pin() calls.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/trimslice.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index d564b40..7b07cb2 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -119,7 +119,6 @@ static int trimslice_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = codec->card;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	ret = tegra_das_connect_dap_to_dac(TEGRA_DAS_DAP_ID_1,
@@ -135,10 +134,6 @@ static int trimslice_asoc_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	snd_soc_dapm_nc_pin(dapm, "LHPOUT");
-	snd_soc_dapm_nc_pin(dapm, "RHPOUT");
-	snd_soc_dapm_nc_pin(dapm, "MICIN");
-
 	return 0;
 }
 
@@ -162,6 +157,7 @@ static struct snd_soc_card snd_soc_trimslice = {
 	.num_dapm_widgets = ARRAY_SIZE(trimslice_dapm_widgets),
 	.dapm_routes = trimslice_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(trimslice_audio_map),
+	.auto_nc_codec_pins = true,
 };
 
 static __devinit int tegra_snd_trimslice_probe(struct platform_device *pdev)
-- 
1.7.0.4
