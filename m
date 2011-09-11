From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 11 Sep 2011 12:28:50 +0300
Subject: [PATCH 2/7] ASoC: simone: convert to use snd_soc_register_card()
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Message-ID: <07a38037d85a237817acf1269a90c610f4dd5c8c.1315732452.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current method for machine driver to register with the ASoC core is to
use snd_soc_register_card() instead of creating a "soc-audio" platform device.

In addition we use platform_device_register_simple() to create a platform
device for the codec. This function will handle putting and deleting the
device automatically which simplifies the error handling in the machine
driver.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/ep93xx/simone.c |   64 +++++++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/sound/soc/ep93xx/simone.c b/sound/soc/ep93xx/simone.c
index 2868179..968cb31 100644
--- a/sound/soc/ep93xx/simone.c
+++ b/sound/soc/ep93xx/simone.c
@@ -39,53 +39,61 @@ static struct snd_soc_card snd_soc_simone = {
 };
 
 static struct platform_device *simone_snd_ac97_device;
-static struct platform_device *simone_snd_device;
 
-static int __init simone_init(void)
+static int __devinit simone_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &snd_soc_simone;
 	int ret;
 
-	if (!machine_is_sim_one())
-		return -ENODEV;
-
-	simone_snd_ac97_device = platform_device_alloc("ac97-codec", -1);
-	if (!simone_snd_ac97_device)
-		return -ENOMEM;
+	simone_snd_ac97_device = platform_device_register_simple("ac97-codec",
+								 -1, NULL, 0);
+	if (IS_ERR(simone_snd_ac97_device))
+		return PTR_ERR(simone_snd_ac97_device);
 
-	ret = platform_device_add(simone_snd_ac97_device);
-	if (ret)
-		goto fail1;
+	card->dev = &pdev->dev;
 
-	simone_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!simone_snd_device) {
-		ret = -ENOMEM;
-		goto fail2;
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		platform_device_unregister(simone_snd_ac97_device);
 	}
 
-	platform_set_drvdata(simone_snd_device, &snd_soc_simone);
-	ret = platform_device_add(simone_snd_device);
-	if (ret)
-		goto fail3;
+	return ret;
+}
+
+static int __devexit simone_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	platform_device_unregister(simone_snd_ac97_device);
 
 	return 0;
+}
 
-fail3:
-	platform_device_put(simone_snd_device);
-fail2:
-	platform_device_del(simone_snd_ac97_device);
-fail1:
-	platform_device_put(simone_snd_ac97_device);
-	return ret;
+static struct platform_driver simone_driver = {
+	.driver		= {
+		.name	= "simone-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= simone_probe,
+	.remove		= __devexit_p(simone_remove),
+};
+
+static int __init simone_init(void)
+{
+	return platform_driver_register(&simone_driver);
 }
 module_init(simone_init);
 
 static void __exit simone_exit(void)
 {
-	platform_device_unregister(simone_snd_device);
-	platform_device_unregister(simone_snd_ac97_device);
+	platform_driver_unregister(&simone_driver);
 }
 module_exit(simone_exit);
 
 MODULE_DESCRIPTION("ALSA SoC Simplemachines Sim.One");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:simone-audio");
-- 
1.7.5.4
