From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Wed, 16 May 2012 12:49:19 +0200
Subject: [PATCH] ASoC: mc13783 codec cleanups
In-Reply-To: <20120515182737.GF19592@opensource.wolfsonmicro.com>
References: <20120515182737.GF19592@opensource.wolfsonmicro.com>
Message-ID: <1337165359-22733-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 sound/soc/codecs/mc13783.c |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 50fa38b..6276e35 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -580,7 +580,6 @@ static struct snd_kcontrol_new mc13783_control_list[] = {
 static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	mc13xxx_lock(priv->mc13xxx);
 
@@ -592,14 +591,6 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_CODEC, 0x180027);
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_DAC, 0x0e0004);
 
-	snd_soc_add_codec_controls(codec, mc13783_control_list,
-					ARRAY_SIZE(mc13783_control_list));
-
-	snd_soc_dapm_new_controls(dapm, mc13783_dapm_widgets,
-					ARRAY_SIZE(mc13783_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, mc13783_routes,
-					ARRAY_SIZE(mc13783_routes));
-
 	if (priv->adc_ssi_port == MC13783_SSI1_PORT)
 		mc13xxx_reg_rmw(priv->mc13xxx, MC13783_AUDIO_CODEC,
 				AUDIO_SSI_SEL, 0);
@@ -721,6 +712,12 @@ static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 	.remove		= mc13783_remove,
 	.read		= mc13783_read,
 	.write		= mc13783_write,
+	.controls	= mc13783_control_list,
+	.num_controls	= ARRAY_SIZE(mc13783_control_list),
+	.dapm_widgets	= mc13783_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mc13783_dapm_widgets),
+	.dapm_routes	= mc13783_routes,
+	.num_dapm_routes = ARRAY_SIZE(mc13783_routes),
 };
 
 static int mc13783_codec_probe(struct platform_device *pdev)
@@ -781,18 +778,7 @@ static struct platform_driver mc13783_codec_driver = {
 	.remove = __devexit_p(mc13783_codec_remove),
 };
 
-static __init int mc13783_init(void)
-{
-	return platform_driver_register(&mc13783_codec_driver);
-}
-
-static __exit void mc13783_exit(void)
-{
-	platform_driver_unregister(&mc13783_codec_driver);
-}
-
-module_init(mc13783_init);
-module_exit(mc13783_exit);
+module_platform_driver(mc13783_codec_driver);
 
 MODULE_DESCRIPTION("ASoC MC13783 driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>");
-- 
1.7.0.4
