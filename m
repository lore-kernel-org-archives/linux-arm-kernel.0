From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Jul 2014 17:47:41 +0200
Subject: [PATCH v2] ASoC: samsung/smartq: use dynamic registration
Message-ID: <5305965.e8NLE5ngVl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a prerequisite for moving s3c64xx into multiplatform configurations,
we need to change the smartq audio driver to stop using hardcoded
gpio numbers from the header file, and instead pass the gpio data
through platform_data.

In order to do that, we also move the code to use module_platform_driver
and register the platform device using platform_device_register_simple
and register the gpios through the gpiod API.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index b3d13537a7f0..deed4dd2d0e4 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/pwm_backlight.h>
@@ -379,6 +380,15 @@ void __init smartq_map_io(void)
 	smartq_lcd_mode_set();
 }
 
+static struct gpiod_lookup_table smartq_audio_gpios = {
+	.dev_id = "smartq-audio",
+	.table = {
+		GPIO_LOOKUP("GPL", 12, "headphone detect", 0),
+		GPIO_LOOKUP("GPK", 12, "amplifiers shutdown", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 void __init smartq_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -397,4 +407,7 @@ void __init smartq_machine_init(void)
 	WARN_ON(smartq_wifi_init());
 
 	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
+
+	gpiod_add_lookup_table(&smartq_audio_gpios);
+	platform_device_register_simple("smartq-audio", -1, NULL, 0);
 }
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 9b0ffacab790..b13f60e402ae 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -13,15 +13,12 @@
  *
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <mach/gpio-samsung.h>
-#include <asm/mach-types.h>
-
 #include "i2s.h"
 #include "../codecs/wm8750.h"
 
@@ -110,7 +107,7 @@ static struct snd_soc_jack_pin smartq_jack_pins[] = {
 
 static struct snd_soc_jack_gpio smartq_jack_gpios[] = {
 	{
-		.gpio		= S3C64XX_GPL(12),
+		.gpio		= -1,
 		.name		= "headphone detect",
 		.report		= SND_JACK_HEADPHONE,
 		.debounce_time	= 200,
@@ -127,7 +124,9 @@ static int smartq_speaker_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k,
 				int event)
 {
-	gpio_set_value(S3C64XX_GPK(12), SND_SOC_DAPM_EVENT_OFF(event));
+	struct gpio_desc *gpio = snd_soc_card_get_drvdata(&snd_soc_smartq);
+
+	gpiod_set_value(gpio, SND_SOC_DAPM_EVENT_OFF(event));
 
 	return 0;
 }
@@ -218,62 +217,39 @@ static struct snd_soc_card snd_soc_smartq = {
 	.num_controls = ARRAY_SIZE(wm8987_smartq_controls),
 };
 
-static struct platform_device *smartq_snd_device;
-
-static int __init smartq_init(void)
+static int smartq_probe(struct platform_device *pdev)
 {
+	struct gpio_desc *gpio;
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
-	if (ret) {
-		dev_err(&smartq_snd_device->dev, "Failed to register GPK12\n");
-		goto err_unregister_device;
+	gpio = devm_gpiod_get(&pdev->dev, "amplifiers shutdown");
+	if (IS_ERR(gpio)) {
+		dev_err(&pdev->dev, "Failed to register GPK12\n");
+		ret = PTR_ERR(gpio);
+		goto out;
 	}
+	snd_soc_card_set_drvdata(&snd_soc_smartq, gpio);
 
-	/* Disable amplifiers */
-	ret = gpio_direction_output(S3C64XX_GPK(12), 1);
-	if (ret) {
-		dev_err(&smartq_snd_device->dev, "Failed to configure GPK12\n");
-		goto err_free_gpio_amp_shut;
-	}
-
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
