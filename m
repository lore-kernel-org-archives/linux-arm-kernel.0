From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  9 Mar 2012 00:59:40 +0800
Subject: [PATCH v3 01/11] ASoC: core: missing set_fmt should not be complaint
In-Reply-To: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1331225990-27308-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not having a DAI link set_fmt operation is perfectly normal and
should not be complaint.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/soc-core.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7978f6c..98b2635 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1531,14 +1531,14 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		if (dai_link->dai_fmt) {
 			ret = snd_soc_dai_set_fmt(card->rtd[i].codec_dai,
 						  dai_link->dai_fmt);
-			if (ret != 0)
+			if (ret != 0 && ret != -ENOTSUPP)
 				dev_warn(card->rtd[i].codec_dai->dev,
 					 "Failed to set DAI format: %d\n",
 					 ret);
 
 			ret = snd_soc_dai_set_fmt(card->rtd[i].cpu_dai,
 						  dai_link->dai_fmt);
-			if (ret != 0)
+			if (ret != 0 && ret != -ENOTSUPP)
 				dev_warn(card->rtd[i].cpu_dai->dev,
 					 "Failed to set DAI format: %d\n",
 					 ret);
@@ -2971,10 +2971,11 @@ EXPORT_SYMBOL_GPL(snd_soc_codec_set_pll);
  */
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	if (dai->driver && dai->driver->ops->set_fmt)
-		return dai->driver->ops->set_fmt(dai, fmt);
-	else
+	if (dai->driver == NULL)
 		return -EINVAL;
+	if (dai->driver->ops->set_fmt == NULL)
+		return -ENOTSUPP;
+	return dai->driver->ops->set_fmt(dai, fmt);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 
-- 
1.7.5.4
