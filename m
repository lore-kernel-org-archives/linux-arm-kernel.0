From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 19 Feb 2015 20:18:41 +0100
Subject: [PATCH] ASoC: max98088: Add master clock handling
In-Reply-To: <1424283959-16289-3-git-send-email-afaerber@suse.de>
References: <1424283959-16289-3-git-send-email-afaerber@suse.de>
Message-ID: <1424373526-4135-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If master clock is provided through device tree, then update
the master clock frequency during set_sysclk.

Cc: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 sound/soc/codecs/max98088.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 69a21d1946e3..1aa81321afba 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
+#include <linux/clk.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -42,6 +43,7 @@ struct max98088_priv {
 	struct regmap *regmap;
 	enum max98088_type devtype;
 	struct max98088_pdata *pdata;
+	struct clk *mclk;
 	unsigned int sysclk;
 	struct max98088_cdata dai[2];
 	int eq_textcnt;
@@ -1361,6 +1363,11 @@ static int max98088_dai_set_sysclk(struct snd_soc_dai *dai,
        if (freq == max98088->sysclk)
                return 0;
 
+       if (!IS_ERR(max98088->mclk)) {
+               freq = clk_round_rate(max98088->mclk, freq);
+               clk_set_rate(max98088->mclk, freq);
+       }
+
        /* Setup clocks for slave mode, and using the PLL
         * PSCLK = 0x01 (when master clk is 10MHz to 20MHz)
         *         0x02 (when master clk is 20MHz to 30MHz)..
@@ -1568,6 +1575,19 @@ static int max98088_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
+		/*
+		 * SND_SOC_BIAS_PREPARE is called while preparing for a
+		 * transition to ON or away from ON. If current bias_level
+		 * is SND_SOC_BIAS_ON, then it is preparing for a transition
+		 * away from ON. Disable the clock in that case, otherwise
+		 * enable it.
+		 */
+		if (!IS_ERR(max98088->mclk)) {
+			if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
+				clk_disable_unprepare(max98088->mclk);
+			else
+				clk_prepare_enable(max98088->mclk);
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -1900,6 +1920,10 @@ static int max98088_probe(struct snd_soc_codec *codec)
        max98088->sysclk = (unsigned)-1;
        max98088->eq_textcnt = 0;
 
+       max98088->mclk = devm_clk_get(codec->dev, "mclk");
+       if (PTR_ERR(max98088->mclk) == -EPROBE_DEFER)
+               return -EPROBE_DEFER;
+
        cdata = &max98088->dai[0];
        cdata->rate = (unsigned)-1;
        cdata->fmt  = (unsigned)-1;
-- 
2.1.4
