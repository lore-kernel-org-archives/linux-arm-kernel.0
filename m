From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 11 Sep 2011 12:28:52 +0300
Subject: [PATCH 4/7] ASoC: snappercl15: convert to use snd_soc_register_card()
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Message-ID: <997e3419c3b6f7a2dbcf3f3b54ce08100beff260.1315732452.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current method for machine driver to register with the ASoC core is to use
snd_soc_register_card() instead of creating a "soc-audio" platform device.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/ep93xx/snappercl15.c |   53 +++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index c8aa8a5..f74ac54 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -104,37 +104,56 @@ static struct snd_soc_card snd_soc_snappercl15 = {
 	.num_links	= 1,
 };
 
-static struct platform_device *snappercl15_snd_device;
-
-static int __init snappercl15_init(void)
+static int __devinit snappercl15_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &snd_soc_snappercl15;
 	int ret;
 
-	if (!machine_is_snapper_cl15())
-		return -ENODEV;
-
 	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
 				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
 				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
 	if (ret)
 		return ret;
 
-	snappercl15_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!snappercl15_snd_device)
-		return -ENOMEM;
-	
-	platform_set_drvdata(snappercl15_snd_device, &snd_soc_snappercl15);
-	ret = platform_device_add(snappercl15_snd_device);
-	if (ret)
-		platform_device_put(snappercl15_snd_device);
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		ep93xx_i2s_release();
+	}
 
 	return ret;
 }
 
-static void __exit snappercl15_exit(void)
+static int __devexit snappercl15_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(snappercl15_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
 	ep93xx_i2s_release();
+
+	return 0;
+}
+
+static struct platform_driver snappercl15_driver = {
+	.driver		= {
+		.name	= "snappercl15-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= snappercl15_probe,
+	.remove		= __devexit_p(snappercl15_remove),
+};
+
+static int __init snappercl15_init(void)
+{
+	return platform_driver_register(&snappercl15_driver);
+}
+
+static void __exit snappercl15_exit(void)
+{
+	platform_driver_unregister(&snappercl15_driver);
 }
 
 module_init(snappercl15_init);
@@ -143,4 +162,4 @@ module_exit(snappercl15_exit);
 MODULE_AUTHOR("Ryan Mallon");
 MODULE_DESCRIPTION("ALSA SoC Snapper CL15");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("platform:snappercl15-audio");
-- 
1.7.5.4
