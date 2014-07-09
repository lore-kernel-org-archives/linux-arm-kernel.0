From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  9 Jul 2014 11:27:23 +0200
Subject: [PATCH] ASoC: s3c64xx/smartq: use dynamic registration
Message-ID: <1404898043-1160870-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a prerequisite for moving s3c64xx into multiplatform configurations,
we need to change the smartq audio driver to stop using hardcoded
gpio numbers from the header file, and instead pass the gpio data
through platform_data.

In order to do that, we also move the code to use module_platform_driver
and register the platform device using platform_device_register_data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/mach-smartq.c | 10 +++++
 sound/soc/samsung/smartq_wm8987.c   | 73 ++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index b3d1353..4c111f6 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi_gpio.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/platform_data/s3c-hsotg.h>
+#include <linux/platform_data/asoc-s3c-smartq.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -379,6 +380,11 @@ void __init smartq_map_io(void)
 	smartq_lcd_mode_set();
 }
 
+static const __initconst struct smartq_audio_pdata smartq_audio_pdata = {
+	.gpio_jack = S3C64XX_GPL(12),
+	.gpio_amp = S3C64XX_GPK(12),
+};
+
 void __init smartq_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -397,4 +403,8 @@ void __init smartq_machine_init(void)
 	WARN_ON(smartq_wifi_init());
 
 	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
+
+	platform_device_register_data(NULL, "smartq-audio", -1,
+				      &smartq_audio_pdata,
+				      sizeof (smartq_audio_pdata));
 }
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 9b0ffac..8c4a0a2 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -19,8 +19,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <mach/gpio-samsung.h>
-#include <asm/mach-types.h>
+#include <linux/platform_data/asoc-s3c-smartq.h>
 
 #include "i2s.h"
 #include "../codecs/wm8750.h"
@@ -110,7 +109,7 @@ static struct snd_soc_jack_pin smartq_jack_pins[] = {
 
 static struct snd_soc_jack_gpio smartq_jack_gpios[] = {
 	{
-		.gpio		= S3C64XX_GPL(12),
+		.gpio		= -1,
 		.name		= "headphone detect",
 		.report		= SND_JACK_HEADPHONE,
 		.debounce_time	= 200,
@@ -127,7 +126,10 @@ static int smartq_speaker_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k,
 				int event)
 {
-	gpio_set_value(S3C64XX_GPK(12), SND_SOC_DAPM_EVENT_OFF(event));
+	struct smartq_audio_pdata *pdata;
+	pdata = snd_soc_smartq.dev->platform_data;
+
+	gpio_set_value(pdata->gpio_amp, SND_SOC_DAPM_EVENT_OFF(event));
 
 	return 0;
 }
@@ -218,62 +220,41 @@ static struct snd_soc_card snd_soc_smartq = {
 	.num_controls = ARRAY_SIZE(wm8987_smartq_controls),
 };
 
-static struct platform_device *smartq_snd_device;
-
-static int __init smartq_init(void)
+static int smartq_probe(struct platform_device *pdev)
 {
+	struct smartq_audio_pdata *pdata = pdev->dev.platform_data;
 	int ret;
 
-	if (!machine_is_smartq7() && !machine_is_smartq5()) {
-		pr_info("Only SmartQ is supported by this ASoC driver\n");
-		return -ENODEV;
-	}
-
-	smartq_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!smartq_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(smartq_snd_device, &snd_soc_smartq);
-
-	ret = platform_device_add(smartq_snd_device);
-	if (ret) {
-		platform_device_put(smartq_snd_device);
-		return ret;
-	}
+	platform_set_drvdata(pdev, &snd_soc_smartq);
 
 	/* Initialise GPIOs used by amplifiers */
-	ret = gpio_request(S3C64XX_GPK(12), "amplifiers shutdown");
+	ret = devm_gpio_request_one(&pdev->dev, pdata->gpio_amp,
+				    GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
+				    "amplifiers shutdown");
 	if (ret) {
-		dev_err(&smartq_snd_device->dev, "Failed to register GPK12\n");
-		goto err_unregister_device;
+		dev_err(&pdev->dev, "Failed to register GPK12\n");
+		goto out;
 	}
 
-	/* Disable amplifiers */
-	ret = gpio_direction_output(S3C64XX_GPK(12), 1);
-	if (ret) {
-		dev_err(&smartq_snd_device->dev, "Failed to configure GPK12\n");
-		goto err_free_gpio_amp_shut;
-	}
+	smartq_jack_gpios[0].gpio = pdata->gpio_jack;
 
-	return 0;
-
-err_free_gpio_amp_shut:
-	gpio_free(S3C64XX_GPK(12));
-err_unregister_device:
-	platform_device_unregister(smartq_snd_device);
+	ret = devm_snd_soc_register_card(&pdev->dev, &snd_soc_smartq);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register card\n");
 
+out:
 	return ret;
 }
 
-static void __exit smartq_exit(void)
-{
-	gpio_free(S3C64XX_GPK(12));
-
-	platform_device_unregister(smartq_snd_device);
-}
+static struct platform_driver smartq_driver = {
+	.driver = {
+		.name = "smartq-audio",
+		.owner = THIS_MODULE,
+	},
+	.probe = smartq_probe,
+};
 
-module_init(smartq_init);
-module_exit(smartq_exit);
+module_platform_driver(smartq_driver);
 
 /* Module information */
 MODULE_AUTHOR("Maurus Cuelenaere <mcuelenaere@gmail.com>");
-- 
1.8.3.2
