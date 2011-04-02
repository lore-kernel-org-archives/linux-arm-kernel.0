From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  2 Apr 2011 03:43:15 +0200
Subject: [PATCH 1/3] sound/spitz: Properly handle MIC GPIO
Message-ID: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch firstly restructurizes the code a bit by getting rid of continuous
checking for machine type in spitz_mic_bias().

Then the patch properly requests the MIC GPIO in the spitz_init() and frees it
in spitz_exit().

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 sound/soc/pxa/spitz.c |   41 +++++++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 8e15713..b253d86 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -42,6 +42,7 @@
 
 static int spitz_jack_func;
 static int spitz_spk_func;
+static int spitz_mic_gpio;
 
 static void spitz_ext_control(struct snd_soc_codec *codec)
 {
@@ -217,14 +218,7 @@ static int spitz_set_spk(struct snd_kcontrol *kcontrol,
 static int spitz_mic_bias(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
-	if (machine_is_borzoi() || machine_is_spitz())
-		gpio_set_value(SPITZ_GPIO_MIC_BIAS,
-				SND_SOC_DAPM_EVENT_ON(event));
-
-	if (machine_is_akita())
-		gpio_set_value(AKITA_GPIO_MIC_BIAS,
-				SND_SOC_DAPM_EVENT_ON(event));
-
+	gpio_set_value_cansleep(spitz_mic_gpio, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
@@ -339,22 +333,45 @@ static int __init spitz_init(void)
 	if (!(machine_is_spitz() || machine_is_borzoi() || machine_is_akita()))
 		return -ENODEV;
 
+	if (machine_is_borzoi() || machine_is_spitz())
+		spitz_mic_gpio = SPITZ_GPIO_MIC_BIAS;
+	else
+		spitz_mic_gpio = AKITA_GPIO_MIC_BIAS;
+
+	ret = gpio_request(spitz_mic_gpio, "MIC GPIO");
+	if (ret)
+		goto err1;
+
+	ret = gpio_direction_output(spitz_mic_gpio, 0);
+	if (ret)
+		goto err2;
+
 	spitz_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!spitz_snd_device)
-		return -ENOMEM;
+	if (!spitz_snd_device) {
+		ret = -ENOMEM;
+		goto err2;
+	}
 
 	platform_set_drvdata(spitz_snd_device, &snd_soc_spitz);
-	ret = platform_device_add(spitz_snd_device);
 
+	ret = platform_device_add(spitz_snd_device);
 	if (ret)
-		platform_device_put(spitz_snd_device);
+		goto err3;
+
+	return 0;
 
+err3:
+	platform_device_put(spitz_snd_device);
+err2:
+	gpio_free(spitz_mic_gpio);
+err1:
 	return ret;
 }
 
 static void __exit spitz_exit(void)
 {
 	platform_device_unregister(spitz_snd_device);
+	gpio_free(spitz_mic_gpio);
 }
 
 module_init(spitz_init);
-- 
1.7.4.1
