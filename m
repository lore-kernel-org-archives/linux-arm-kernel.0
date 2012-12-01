From: padma.v@samsung.com (Padmavathi Venna)
Date: Sat, 01 Dec 2012 15:37:26 +0530
Subject: [PATCH 1/2] ASoC: Samsung: WM8994: Add basic device tree support for
 machine file
In-Reply-To: <1354356447-16784-1-git-send-email-padma.v@samsung.com>
References: <1354356447-16784-1-git-send-email-padma.v@samsung.com>
Message-ID: <1354356447-16784-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the basic device tree based lookup.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/smdk_wm8994.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 48dd4dd..f9ba2b9 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -10,6 +10,7 @@
 #include "../codecs/wm8994.h"
 #include <sound/pcm_params.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
  /*
   * Default CFG switch settings to use this driver:
@@ -153,9 +154,22 @@ static struct snd_soc_card smdk = {
 static int __devinit smdk_audio_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct device_node *np = pdev->dev.of_node;
 	struct snd_soc_card *card = &smdk;
 
 	card->dev = &pdev->dev;
+
+	if (np) {
+		smdk_dai[0].cpu_dai_name = NULL;
+		smdk_dai[0].cpu_of_node = of_parse_phandle(np,
+				"samsung,i2s-controller", 0);
+		if (!smdk_dai[0].cpu_of_node) {
+			dev_err(&pdev->dev,
+			   "Property 'samsung,i2s-controller' missing or invalid\n");
+			ret = -EINVAL;
+		}
+	}
+
 	ret = snd_soc_register_card(card);
 
 	if (ret)
@@ -173,10 +187,19 @@ static int __devexit smdk_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id samsung_wm8994_of_match[] = {
+	{ .compatible = "samsung,smdk-wm8994", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, samsung_wm8994_of_match);
+#endif /* CONFIG_OF */
+
 static struct platform_driver smdk_audio_driver = {
 	.driver		= {
 		.name	= "smdk-audio",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(samsung_wm8994_of_match),
 	},
 	.probe		= smdk_audio_probe,
 	.remove		= __devexit_p(smdk_audio_remove),
-- 
1.7.4.4
