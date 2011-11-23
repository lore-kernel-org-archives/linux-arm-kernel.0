From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:13 -0700
Subject: [PATCH 05/17] ASoC: Tegra: Move DAS configuration into machine drivers
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-6-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes potentially machine-specific routing knowledge from the
I2S driverinto the machine drivers, which is better equipped to know
what the appropriate routing configuration is.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_i2s.c    |   18 ------------------
 sound/soc/tegra/tegra_wm8903.c |   13 +++++++++++++
 sound/soc/tegra/trimslice.c    |   15 +++++++++++++++
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra_i2s.c
index 6728fab..33e62fc 100644
--- a/sound/soc/tegra/tegra_i2s.c
+++ b/sound/soc/tegra/tegra_i2s.c
@@ -42,7 +42,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include "tegra_das.h"
 #include "tegra_i2s.h"
 
 #define DRV_NAME "tegra-i2s"
@@ -363,23 +362,6 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/*
-	 * FIXME: Until a codec driver exists for the tegra DAS, hard-code a
-	 * 1:1 mapping between audio controllers and audio ports.
-	 */
-	ret = tegra_das_connect_dap_to_dac(TEGRA_DAS_DAP_ID_1 + pdev->id,
-					TEGRA_DAS_DAP_SEL_DAC1 + pdev->id);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't set up DAP connection\n");
-		return ret;
-	}
-	ret = tegra_das_connect_dac_to_dap(TEGRA_DAS_DAC_ID_1 + pdev->id,
-					TEGRA_DAS_DAC_SEL_DAP1 + pdev->id);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't set up DAC connection\n");
-		return ret;
-	}
-
 	i2s = kzalloc(sizeof(struct tegra_i2s), GFP_KERNEL);
 	if (!i2s) {
 		dev_err(&pdev->dev, "Can't allocate tegra_i2s\n");
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index a81cf39..9b0ee15 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -249,6 +249,19 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 	struct tegra_wm8903_platform_data *pdata = machine->pdata;
 	int ret;
 
+	ret = tegra_das_connect_dap_to_dac(TEGRA_DAS_DAP_ID_1,
+					   TEGRA_DAS_DAP_SEL_DAC1);
+	if (ret) {
+		dev_err(card->dev, "Can't set up DAS DAP connection\n");
+		return ret;
+	}
+	ret = tegra_das_connect_dac_to_dap(TEGRA_DAS_DAC_ID_1,
+					   TEGRA_DAS_DAC_SEL_DAP1);
+	if (ret) {
+		dev_err(card->dev, "Can't set up DAS DAC connection\n");
+		return ret;
+	}
+
 	if (gpio_is_valid(pdata->gpio_spkr_en)) {
 		ret = gpio_request(pdata->gpio_spkr_en, "spkr_en");
 		if (ret) {
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index b3a7efa..2699a6f 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -118,7 +118,22 @@ static const struct snd_soc_dapm_route trimslice_audio_map[] = {
 static int trimslice_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
+
+	ret = tegra_das_connect_dap_to_dac(TEGRA_DAS_DAP_ID_1,
+					   TEGRA_DAS_DAP_SEL_DAC1);
+	if (ret) {
+		dev_err(card->dev, "Can't set up DAS DAP connection\n");
+		return ret;
+	}
+	ret = tegra_das_connect_dac_to_dap(TEGRA_DAS_DAC_ID_1,
+					   TEGRA_DAS_DAC_SEL_DAP1);
+	if (ret) {
+		dev_err(card->dev, "Can't set up DAS DAC connection\n");
+		return ret;
+	}
 
 	snd_soc_dapm_nc_pin(dapm, "LHPOUT");
 	snd_soc_dapm_nc_pin(dapm, "RHPOUT");
-- 
1.7.0.4
