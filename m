From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2012 14:26:42 +0000
Subject: [PATCH 1/6] ARM: ux500: don't select LEDS_GPIO for snowball
In-Reply-To: <1345648390-4234-2-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
 <1345648390-4234-2-git-send-email-arnd@arndb.de>
Message-ID: <201208231426.43105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 August 2012, Arnd Bergmann wrote:
> The gpio leds driver can only be built if the generic LED code is
> also enabled. Snowball selects LEDS_GPIO for an unknown reason
> but it does not select LEDS_CLASS and also does not really require
> the LED support at all, so we can just drop this dependency.
> 
> Without this patch, building without LEDS_CLASS esults in:
> 
> drivers/built-in.o: In function `create_gpio_led.part.2':
> governor_userspace.c:(.devinit.text+0x5a58): undefined reference to `led_classdev_register'
> drivers/built-in.o: In function `gpio_led_remove':
> governor_userspace.c:(.devexit.text+0x6b8): undefined reference to `led_classdev_unregister'
> 
> This reverts 8733f53c6 "ARM: ux500: Kconfig: Compile in leds-gpio
> support for Snowball", which was not completely thought through.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>

I discussed this with Lee on IRC, he really wants to keep the LED enabled for snowball
for his own convenience. How is this version instead?

	Arnd

>From 53c4e002b7ebd70ad9dcfa7a97c0ae58e874e643 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Aug 2012 20:34:48 +0000
Subject: [PATCH] ARM: ux500: don't select LEDS_GPIO for snowball

The gpio leds driver can only be built if the generic LED code is
also enabled. Snowball selects LEDS_GPIO for an unknown reason
but it does not select LEDS_CLASS and also does not really require
the LED support at all, so we can just drop this dependency.

Without this patch, building without LEDS_CLASS esults in:

drivers/built-in.o: In function `create_gpio_led.part.2':
governor_userspace.c:(.devinit.text+0x5a58): undefined reference to `led_classdev_register'
drivers/built-in.o: In function `gpio_led_remove':
governor_userspace.c:(.devexit.text+0x6b8): undefined reference to `led_classdev_unregister'

This reverts 8733f53c6 "ARM: ux500: Kconfig: Compile in leds-gpio
support for Snowball", which was not completely thought through.

In order to leave the GPIO LED code still present in normal
builds, this also enables the symbol in u8500_defconfig, in addition
to the other LED drivers that are already selected there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 2d4f661..da68454 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -86,6 +86,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_LM3530=y
 CONFIG_LEDS_LP5521=y
+CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AB8500=y
 CONFIG_RTC_DRV_PL031=y
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c013bbf..53d3d46 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -41,7 +41,6 @@ config MACH_HREFV60
 config MACH_SNOWBALL
 	bool "U8500 Snowball platform"
 	select MACH_MOP500
-	select LEDS_GPIO
 	help
 	  Include support for the snowball development platform.
 
