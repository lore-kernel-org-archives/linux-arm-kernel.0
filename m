From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 19 Nov 2017 13:43:26 +0100
Subject: [PATCH 1/2] ASoC: rockchip: Use common error handling code in
 rk_aif1_hw_params()
In-Reply-To: <255fa488-a5f1-2ea3-dd48-b10ad8b2c18c@users.sourceforge.net>
References: <255fa488-a5f1-2ea3-dd48-b10ad8b2c18c@users.sourceforge.net>
Message-ID: <72605b8c-a5dc-3cc6-8e9f-940c8e72581d@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 13:23:35 +0100

Add a jump target so that a bit of exception handling can be better reused
in an if branch of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/rockchip/rockchip_max98090.c | 11 ++++-------
 sound/soc/rockchip/rockchip_rt5645.c   | 11 ++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 789d6f1e2b5f..419fa6ef14bb 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -104,17 +104,14 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
 				     SND_SOC_CLOCK_OUT);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto report_failure;
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
+	if (ret < 0)
+report_failure:
 		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
-		return ret;
-	}
 
 	return ret;
 }
diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 9e0c17805807..7f763d0963d3 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -98,17 +98,14 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
 				     SND_SOC_CLOCK_OUT);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto report_failure;
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
+	if (ret < 0)
+report_failure:
 		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
-		return ret;
-	}
 
 	return ret;
 }
-- 
2.15.0
