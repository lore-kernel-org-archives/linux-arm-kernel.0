From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 17:13:05 +0200
Subject: [PATCH 1/6] ARM: ux500: don't select LEDS_GPIO for snowball
In-Reply-To: <1345648390-4234-1-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
Message-ID: <1345648390-4234-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 -
 1 file changed, 1 deletion(-)

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
 
-- 
1.7.10
