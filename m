From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu,  3 Jan 2013 06:40:39 -0800
Subject: [PATCH v2] ASoC: pxa2xx-ac97: fix oops when codec_driver probe runs
Message-ID: <1357224039-9133-1-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change log:
v2: pxa2xx_ac97_hw_probe() is called *before* snd_soc_register_dais(), and
    likewise pxa2xx_ac97_hw_remove() is called after snd_soc_unregister_dais().
    Thanks much Mark.

This patch fixes a kernel oops that occurs when the snd_soc_codec_driver probe
function runs.  The exception occurs when the codec calls soc_ac97_ops.reset().
The pxa2xx-ac97's clocks have not been initialized at this point, but the cpu's
reset function (pxa_ac97_cold_pxa27x()) expects them to be, resulting in a NULL
pointer dereference in the pxa's clk_enable().

The pxa2xx-ac97's clocks are initialized in pxa2xx_ac97_hw_probe().  To ensure
that the clocks are initialized when the codec_driver probe runs, the calls to
pxa2xx_ac97_hw_{probe,remove}() are moved from the cpu's dai_driver probe/remove
functions to those of its platform_driver.  This is necessary because
snd_soc_instantiate_card() always calls the codec_driver probe before any of the
dai_drivers' probes.

This change leaves nothing in the cpu's dai_driver probe/remove functions, so
those functions are eliminated.

Tested on the pxa27x; palmtreo680 machine using the wm9712 codec.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 4b0a009..ba04f49 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -104,17 +104,6 @@ static int pxa2xx_ac97_resume(struct snd_soc_dai *dai)
 #define pxa2xx_ac97_resume	NULL
 #endif
 
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
@@ -184,8 +173,6 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 {
 	.name = "pxa2xx-ac97",
 	.ac97_control = 1,
-	.probe = pxa2xx_ac97_probe,
-	.remove = pxa2xx_ac97_remove,
 	.suspend = pxa2xx_ac97_suspend,
 	.resume = pxa2xx_ac97_resume,
 	.playback = {
@@ -236,15 +223,20 @@ EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
 		return -ENXIO;
 	}
 
-	/* Punt most of the init to the SoC probe; we may need the machine
-	 * driver to do interesting things with the clocking to get us up
-	 * and running.
-	 */
+	ret = pxa2xx_ac97_hw_probe(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pxa2xx_ac97_hw_probe failed with %d\n",
+			ret);
+		return ret;
+	}
+
 	return snd_soc_register_dais(&pdev->dev, pxa_ac97_dai_driver,
 			ARRAY_SIZE(pxa_ac97_dai_driver));
 }
@@ -252,6 +244,7 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(pxa_ac97_dai_driver));
+	pxa2xx_ac97_hw_remove(pdev);
 	return 0;
 }
 
-- 
1.7.8.6
