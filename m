From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 20 Feb 2012 08:04:50 +0800
Subject: [PATCH] ASoC: Add __devinit annotation for pxa2xx_ac97_probe
Message-ID: <1329696290.16979.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes below build warning:
WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
The function pxa2xx_ac97_probe() references
the function __devinit pxa2xx_ac97_hw_probe().
This is often because pxa2xx_ac97_probe lacks a __devinit
annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.

Also rename pxa_ac97_dai to pxa_ac97_dai_driver to fix below build warning:

  LD      sound/soc/pxa/built-in.o
WARNING: sound/soc/pxa/built-in.o(.data+0x18c): Section mismatch in reference from the variable pxa_ac97_dai to the function .devinit.text:pxa2xx_ac97_probe()
The variable pxa_ac97_dai references
the function __devinit pxa2xx_ac97_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 837ff34..4800d5f 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -103,7 +103,7 @@ static int pxa2xx_ac97_resume(struct snd_soc_dai *dai)
 #define pxa2xx_ac97_resume	NULL
 #endif
 
-static int pxa2xx_ac97_probe(struct snd_soc_dai *dai)
+static int __devinit pxa2xx_ac97_probe(struct snd_soc_dai *dai)
 {
 	return pxa2xx_ac97_hw_probe(to_platform_device(dai->dev));
 }
@@ -179,7 +179,7 @@ static const struct snd_soc_dai_ops pxa_ac97_mic_dai_ops = {
  * There is only 1 physical AC97 interface for pxa2xx, but it
  * has extra fifo's that can be used for aux DACs and ADCs.
  */
-static struct snd_soc_dai_driver pxa_ac97_dai[] = {
+static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 {
 	.name = "pxa2xx-ac97",
 	.ac97_control = 1,
@@ -244,13 +244,13 @@ static __devinit int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 	 * driver to do interesting things with the clocking to get us up
 	 * and running.
 	 */
-	return snd_soc_register_dais(&pdev->dev, pxa_ac97_dai,
-			ARRAY_SIZE(pxa_ac97_dai));
+	return snd_soc_register_dais(&pdev->dev, pxa_ac97_dai_driver,
+			ARRAY_SIZE(pxa_ac97_dai_driver));
 }
 
 static int __devexit pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(pxa_ac97_dai));
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(pxa_ac97_dai_driver));
 	return 0;
 }
 
-- 
1.7.5.4
