From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Jun 2014 11:31:43 +0800
Subject: [PATCH v2 1/5] ASoC: atmel_wm8904: switch to CCF
In-Reply-To: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
References: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1402284707-23354-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - None

 sound/soc/atmel/atmel_wm8904.c | 50 ------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index b4e3690..4052268 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -18,10 +18,6 @@
 #include "../codecs/wm8904.h"
 #include "atmel_ssc_dai.h"
 
-#define MCLK_RATE 32768
-
-static struct clk *mclk;
-
 static const struct snd_soc_dapm_widget atmel_asoc_wm8904_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Mic", NULL),
@@ -61,26 +57,6 @@ static struct snd_soc_ops atmel_asoc_wm8904_ops = {
 	.hw_params = atmel_asoc_wm8904_hw_params,
 };
 
-static int atmel_set_bias_level(struct snd_soc_card *card,
-		struct snd_soc_dapm_context *dapm,
-		enum snd_soc_bias_level level)
-{
-	if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
-		switch (level) {
-		case SND_SOC_BIAS_PREPARE:
-			clk_prepare_enable(mclk);
-			break;
-		case SND_SOC_BIAS_OFF:
-			clk_disable_unprepare(mclk);
-			break;
-		default:
-			break;
-		}
-	}
-
-	return 0;
-};
-
 static struct snd_soc_dai_link atmel_asoc_wm8904_dailink = {
 	.name = "WM8904",
 	.stream_name = "WM8904 PCM",
@@ -94,7 +70,6 @@ static struct snd_soc_dai_link atmel_asoc_wm8904_dailink = {
 static struct snd_soc_card atmel_asoc_wm8904_card = {
 	.name = "atmel_asoc_wm8904",
 	.owner = THIS_MODULE,
-	.set_bias_level = atmel_set_bias_level,
 	.dai_link = &atmel_asoc_wm8904_dailink,
 	.num_links = 1,
 	.dapm_widgets = atmel_asoc_wm8904_dapm_widgets,
@@ -153,7 +128,6 @@ static int atmel_asoc_wm8904_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
 	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
-	struct clk *clk_src;
 	int id, ret;
 
 	card->dev = &pdev->dev;
@@ -170,30 +144,6 @@ static int atmel_asoc_wm8904_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	mclk = clk_get(NULL, "pck0");
-	if (IS_ERR(mclk)) {
-		dev_err(&pdev->dev, "failed to get pck0\n");
-		ret = PTR_ERR(mclk);
-		goto err_set_audio;
-	}
-
-	clk_src = clk_get(NULL, "clk32k");
-	if (IS_ERR(clk_src)) {
-		dev_err(&pdev->dev, "failed to get clk32k\n");
-		ret = PTR_ERR(clk_src);
-		goto err_set_audio;
-	}
-
-	ret = clk_set_parent(mclk, clk_src);
-	clk_put(clk_src);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "failed to set MCLK parent\n");
-		goto err_set_audio;
-	}
-
-	dev_info(&pdev->dev, "setting pck0 to %dHz\n", MCLK_RATE);
-	clk_set_rate(mclk, MCLK_RATE);
-
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed\n");
-- 
1.8.5.2
