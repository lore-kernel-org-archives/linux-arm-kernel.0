From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 27 May 2016 22:26:56 +0200
Subject: [RFC PATCH v2 4/7] ASoC: wm9713: add ac97 new bus support
In-Reply-To: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
References: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1464380819-19075-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new ac97 bus model, where devices are automatically
discovered on AC-Links.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/Kconfig  |  1 +
 sound/soc/codecs/wm9713.c | 62 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 649e92a252ae..2566962c990e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -977,6 +977,7 @@ config SND_SOC_WM9712
 config SND_SOC_WM9713
 	tristate
 	select REGMAP_AC97
+	select AC97_BUS_COMPAT
 
 # Amp
 config SND_SOC_LM4857
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 9849643ef809..6cbbf4eda5fc 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -22,7 +22,8 @@
 #include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-#include <sound/ac97_codec.h>
+#include <sound/ac97/codec.h>
+#include <sound/ac97/compat.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
@@ -1207,14 +1208,13 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	struct regmap *regmap;
 
-	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
-		WM9713_VENDOR_ID_MASK);
+	wm9713->ac97 = compat_alloc_snd_ac97_codec(codec);
 	if (IS_ERR(wm9713->ac97))
 		return PTR_ERR(wm9713->ac97);
 
 	regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
 	if (IS_ERR(regmap)) {
-		snd_soc_free_ac97_codec(wm9713->ac97);
+		compat_release_snd_ac97_codec(wm9713->ac97);
 		return PTR_ERR(regmap);
 	}
 
@@ -1231,7 +1231,7 @@ static int wm9713_soc_remove(struct snd_soc_codec *codec)
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 
 	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(wm9713->ac97);
+	compat_release_snd_ac97_codec(wm9713->ac97);
 	return 0;
 }
 
@@ -1281,7 +1281,57 @@ static struct platform_driver wm9713_codec_driver = {
 	.remove = wm9713_remove,
 };
 
-module_platform_driver(wm9713_codec_driver);
+static int wm9713_ac97_probe(struct ac97_codec_device *adev)
+{
+	struct wm9713_priv *wm9713;
+
+	wm9713 = devm_kzalloc(ac97_codec_dev2dev(adev),
+			      sizeof(*wm9713), GFP_KERNEL);
+	if (wm9713 == NULL)
+		return -ENOMEM;
+
+	mutex_init(&wm9713->lock);
+
+	ac97_set_drvdata(adev, wm9713);
+
+	return snd_soc_register_codec(ac97_codec_dev2dev(adev),
+				      &soc_codec_dev_wm9713, wm9713_dai,
+				      ARRAY_SIZE(wm9713_dai));
+}
+
+static int wm9713_ac97_remove(struct ac97_codec_device *adev)
+{
+	snd_soc_unregister_codec(ac97_codec_dev2dev(adev));
+	return 0;
+}
+
+static struct ac97_id wm9713_ac97_ids[] = {
+	{ .id = WM9713_VENDOR_ID, .mask = WM9713_VENDOR_ID_MASK },
+	{ }
+};
+
+static struct ac97_codec_driver wm9713_ac97_driver = {
+	.driver = {
+			.name = "wm9713-codec",
+	},
+	.probe		= wm9713_ac97_probe,
+	.remove		= wm9713_ac97_remove,
+	.id_table	= wm9713_ac97_ids,
+};
+
+static int __init wm9713_init(void)
+{
+	snd_ac97_codec_driver_register(&wm9713_ac97_driver);
+	return platform_driver_register(&wm9713_codec_driver);
+}
+module_init(wm9713_init);
+
+static void __exit wm9713_exit(void)
+{
+	snd_ac97_codec_driver_unregister(&wm9713_ac97_driver);
+	return platform_driver_unregister(&wm9713_codec_driver);
+}
+module_exit(wm9713_exit);
 
 MODULE_DESCRIPTION("ASoC WM9713/WM9714 driver");
 MODULE_AUTHOR("Liam Girdwood");
-- 
2.1.4
