From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 17 Oct 2013 14:01:36 +0400
Subject: [PATCH 2/3] ALSA: ASoC: pxa: fix pxa2xx-ac97 DAI initialization order
In-Reply-To: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1382004097-6350-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After recent changes to codec/DAI initialization order changes, codec
driver (wm9712 in my case) tries to access codec prior to
pxa2xx_ac97_hw_probe() being called (because DAIs are probed after all
codecs are probed). Move hw-related probe/remove/suspend/resume
functions to pxa2xx-ac97 driver level, instead of DAI level.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/pxa2xx-ac97.c | 56 ++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index f1059d9..ae956e3 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -89,33 +89,6 @@ static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_mic_mono_in = {
 	.filter_data	= &pxa2xx_ac97_pcm_aux_mic_mono_req,
 };
 
-#ifdef CONFIG_PM
-static int pxa2xx_ac97_suspend(struct snd_soc_dai *dai)
-{
-	return pxa2xx_ac97_hw_suspend();
-}
-
-static int pxa2xx_ac97_resume(struct snd_soc_dai *dai)
-{
-	return pxa2xx_ac97_hw_resume();
-}
-
-#else
-#define pxa2xx_ac97_suspend	NULL
-#define pxa2xx_ac97_resume	NULL
-#endif
-
-static int pxa2xx_ac97_probe(struct snd_soc_dai *dai)
-{
-	return pxa2xx_ac97_hw_probe(to_platform_device(dai->dev));
-}
-
-static int pxa2xx_ac97_remove(struct snd_soc_dai *dai)
-{
-	pxa2xx_ac97_hw_remove(to_platform_device(dai->dev));
-	return 0;
-}
-
 static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *cpu_dai)
@@ -185,10 +158,6 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 {
 	.name = "pxa2xx-ac97",
 	.ac97_control = 1,
-	.probe = pxa2xx_ac97_probe,
-	.remove = pxa2xx_ac97_remove,
-	.suspend = pxa2xx_ac97_suspend,
-	.resume = pxa2xx_ac97_resume,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
@@ -246,6 +215,12 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	ret = pxa2xx_ac97_hw_probe(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "PXA2xx AC97 hw probe error (%d)\n", ret);
+		return ret;
+	}
+
 	ret = snd_soc_set_ac97_ops(&pxa2xx_ac97_ops);
 	if (ret != 0)
 		return ret;
@@ -262,15 +237,34 @@ static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_set_ac97_ops(NULL);
+	pxa2xx_ac97_hw_remove(pdev);
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pxa2xx_ac97_dev_suspend(struct device *dev)
+{
+	return pxa2xx_ac97_hw_suspend();
+}
+
+static int pxa2xx_ac97_dev_resume(struct device *dev)
+{
+	return pxa2xx_ac97_hw_resume();
+}
+
+static SIMPLE_DEV_PM_OPS(pxa2xx_ac97_pm_ops,
+		pxa2xx_ac97_dev_suspend, pxa2xx_ac97_dev_resume);
+#endif
+
 static struct platform_driver pxa2xx_ac97_driver = {
 	.probe		= pxa2xx_ac97_dev_probe,
 	.remove		= pxa2xx_ac97_dev_remove,
 	.driver		= {
 		.name	= "pxa2xx-ac97",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM_SLEEP
+		.pm	= &pxa2xx_ac97_pm_ops,
+#endif
 	},
 };
 
-- 
1.8.4.rc3
