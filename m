From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Jul 2014 14:15:24 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <53C28B74.6010401@metafoo.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <20140712194903.GB6800@sirena.org.uk> <53C28B74.6010401@metafoo.de>
Message-ID: <4755712.cJmZ5fnaQH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 July 2014 15:36:52 Lars-Peter Clausen wrote:
> On 07/12/2014 09:49 PM, Mark Brown wrote:
> > On Sat, Jul 12, 2014 at 05:27:59PM +0200, Lars-Peter Clausen wrote:
> >> On 07/11/2014 03:45 PM, Arnd Bergmann wrote:
> >
> >>> As a prerequisite for moving s3c64xx into multiplatform configurations,
> >>> we need to change the smartq audio driver to stop using hardcoded
> >>> gpio numbers from the header file, and instead pass the gpio data
> >>> through platform_data.
> >
> >> This should be using the gpiod API. The gpiod API allows you to pass the
> >> GPIOs without having to add a platform_data struct.
> >
> > OTOH that's a more invasive change that's harder to do mechanically -
> > I'm not sure it's sensible to insist on someone doing it for generic
> > cleanups (rather than actively working with the particular platform).
> 
> I don't think it is more invasive than using platform data. I did the same 
> recently for jz4740 qi-lb60[1] and the changes in the patch are fairly trivial. 
> The non-descriptor API is deprecated, so this even if this patch is applied as 
> is sooner or later somebody will mechanically convert it to the descriptor API.

I've given it a try now. Can you confirm that this is a valid transformation?

If it's ok, I'll fold it into the original patch and re-send.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 ./arch/arm/mach-s3c64xx/mach-smartq.c           |   15 ++++++++-------
 ./sound/soc/samsung/smartq_wm8987.c             |   19 +++++++------------
 ./include/linux/platform_data/asoc-s3c-smartq.h |   10 ----------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 4c111f60dbf2..dce449c0e855 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -20,7 +20,6 @@
 #include <linux/spi/spi_gpio.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/platform_data/s3c-hsotg.h>
-#include <linux/platform_data/asoc-s3c-smartq.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -380,9 +379,12 @@ void __init smartq_map_io(void)
 	smartq_lcd_mode_set();
 }
 
-static const __initconst struct smartq_audio_pdata smartq_audio_pdata = {
-	.gpio_jack = S3C64XX_GPL(12),
-	.gpio_amp = S3C64XX_GPK(12),
+static struct gpiod_lookup_table smartq_audio_gpios = {
+	.dev_id = "smartq-audio",
+	.table = {
+		GPIO_LOOKUP("GPL", 12, "headphone detect", 0),
+		GPIO_LOOKUP("GPK", 12, "amplifiers shutdown", GPIO_ACTIVE_HIGH),
+	},
 };
 
 void __init smartq_machine_init(void)
@@ -404,7 +406,6 @@ void __init smartq_machine_init(void)
 
 	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
 
-	platform_device_register_data(NULL, "smartq-audio", -1,
-				      &smartq_audio_pdata,
-				      sizeof (smartq_audio_pdata));
+	platform_device_register_simple("smartq-audio", -1, NULL, 0);
+	gpiod_add_lookup_table(&smartq_audio_gpios);
 }
diff --git a/include/linux/platform_data/asoc-s3c-smartq.h b/include/linux/platform_data/asoc-s3c-smartq.h
deleted file mode 100644
index 5bddc3586802..000000000000
--- a/include/linux/platform_data/asoc-s3c-smartq.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __PLATFORM_DATA_ASOC_S3C_SMARTQ
-#define __PLATFORM_DATA_ASOC_S3C_SMARTQ
-
-struct smartq_audio_pdata {
-	int gpio_jack;
-	int gpio_amp;
-};
-
-#endif
-
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 8c4a0a285ce7..8da7c67903c6 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -19,8 +19,6 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <linux/platform_data/asoc-s3c-smartq.h>
-
 #include "i2s.h"
 #include "../codecs/wm8750.h"
 
@@ -126,10 +124,9 @@ static int smartq_speaker_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k,
 				int event)
 {
-	struct smartq_audio_pdata *pdata;
-	pdata = snd_soc_smartq.dev->platform_data;
+	struct gpio_desc *gpio = dev_get_drvdata(snd_soc_smartq.dev);
 
-	gpio_set_value(pdata->gpio_amp, SND_SOC_DAPM_EVENT_OFF(event));
+	gpiod_set_value(gpio, SND_SOC_DAPM_EVENT_OFF(event));
 
 	return 0;
 }
@@ -222,21 +219,19 @@ static struct snd_soc_card snd_soc_smartq = {
 
 static int smartq_probe(struct platform_device *pdev)
 {
-	struct smartq_audio_pdata *pdata = pdev->dev.platform_data;
+	struct gpio_desc *gpio;
 	int ret;
 
 	platform_set_drvdata(pdev, &snd_soc_smartq);
 
 	/* Initialise GPIOs used by amplifiers */
-	ret = devm_gpio_request_one(&pdev->dev, pdata->gpio_amp,
-				    GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
-				    "amplifiers shutdown");
-	if (ret) {
+	gpio = devm_gpiod_get(&pdev->dev, "amplifiers shutdown");
+	if (IS_ERR(gpio)) {
 		dev_err(&pdev->dev, "Failed to register GPK12\n");
+		ret = PTR_ERR(gpio);
 		goto out;
 	}
-
-	smartq_jack_gpios[0].gpio = pdata->gpio_jack;
+	platform_set_drvdata(pdev, gpio);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &snd_soc_smartq);
 	if (ret)
