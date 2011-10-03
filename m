From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 18:19:48 +0200
Subject: [alsa-devel] [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <20111003152002.GP3731@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1343003.MpQlxoEPa6@wuerfel>
	<20111003152002.GP3731@opensource.wolfsonmicro.com>
Message-ID: <9353092.2X2OeIUYGE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 16:20:02 Mark Brown wrote:
> On Mon, Oct 03, 2011 at 04:47:07PM +0200, Arnd Bergmann wrote:
> 
> > sound/soc/codecs/wm1250-ev1.c:32:14: error: array type has incomplete element type
> 
> OK, that's the gpio_request_ stuff not being implemented thing that I
> have seen some reports of.  Looks like that's not been stubbed out, but
> for Prima2 the best fix is just to turn on gpiolib since there's no
> excuse for a new platform to not use it.

With the latest changes that Russell did in this direction, we can probably
set ARCH_WANT_OPTIONAL_GPIOLIB on ARM for all platforms that don't
provide their own gpio implementation or already require gpiolib.

However, I see no reason to force-enable gpiolib on platforms that
don't actually have any GPIO. On those, you would still get the same
problem with this code in the wm1250-ev1 driver:

        for (i = 0; i < ARRAY_SIZE(wm1250->gpios); i++) {
                wm1250->gpios[i].gpio = pdata->gpios[i];
                wm1250->gpios[i].label = wm1250_gpio_names[i];
                wm1250->gpios[i].flags = GPIOF_OUT_INIT_LOW;
        }

When the GPIO API is stubbed out, the definition of struct gpio
is empty, so you cannot access the members, which seems to be
intentional behavior.

In order to make that work, I think we need one of the two patches
below.

	Arnd

--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -24,7 +24,11 @@
 #include <linux/errno.h>
 
 struct device;
-struct gpio;
+struct gpio {
+       unsigned        gpio;
+       unsigned long   flags;
+       const char      *label;
+};
 struct gpio_chip;
 
 /*


--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -58,7 +58,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
-	select SND_SOC_WM1250_EV1 if I2C
+	select SND_SOC_WM1250_EV1 if I2C && GENERIC_GPIO
 	select SND_SOC_WM2000 if I2C
 	select SND_SOC_WM5100 if I2C
 	select SND_SOC_WM8350 if MFD_WM8350
