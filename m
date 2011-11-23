From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:23 -0700
Subject: [PATCH 15/17] ASoC: Tegra+WM903 machine: Use new auto_nc_codec_pins
 feature
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-16-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set card.auto_nc_codec_pins to true to enable the feature, and remove all
the open-coded snd_soc_dapm_nc_pin() calls.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_wm8903.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 33feee8..8791c69 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -331,27 +331,6 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 
 	snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
 
-	/* FIXME: Calculate automatically based on DAPM routes? */
-	if (!machine_is_harmony())
-		snd_soc_dapm_nc_pin(dapm, "IN1L");
-	if (!machine_is_seaboard() && !machine_is_aebl())
-		snd_soc_dapm_nc_pin(dapm, "IN1R");
-	snd_soc_dapm_nc_pin(dapm, "IN2L");
-	if (!machine_is_kaen())
-		snd_soc_dapm_nc_pin(dapm, "IN2R");
-	snd_soc_dapm_nc_pin(dapm, "IN3L");
-	snd_soc_dapm_nc_pin(dapm, "IN3R");
-
-	if (machine_is_aebl()) {
-		snd_soc_dapm_nc_pin(dapm, "LON");
-		snd_soc_dapm_nc_pin(dapm, "RON");
-		snd_soc_dapm_nc_pin(dapm, "ROP");
-		snd_soc_dapm_nc_pin(dapm, "LOP");
-	} else {
-		snd_soc_dapm_nc_pin(dapm, "LINEOUTR");
-		snd_soc_dapm_nc_pin(dapm, "LINEOUTL");
-	}
-
 	return 0;
 }
 
@@ -375,6 +354,7 @@ static struct snd_soc_card snd_soc_tegra_wm8903 = {
 	.num_controls = ARRAY_SIZE(tegra_wm8903_controls),
 	.dapm_widgets = tegra_wm8903_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(tegra_wm8903_dapm_widgets),
+	.auto_nc_codec_pins = true,
 };
 
 static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
-- 
1.7.0.4
