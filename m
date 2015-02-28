From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Feb 2015 20:48:27 +0100
Subject: [PATCH] rtc: abx805 depends on i2c
Message-ID: <2307717.ct4mYzhCLm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added X805 rtc driver uses the i2c subsystem,
but has no Kconfig dependency, so it can result in a build
error when i2c is disabled:

drivers/rtc/rtc-abx805.c: In function 'abx805_read_multiple_regs':
drivers/rtc/rtc-abx805.c:55:2: error: implicit declaration of function 'i2c_transfer' [-Werror=implicit-function-declaration]

This adds the obvious dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9033ab8ddd29 ("rtc: add rtc-abx805, a driver for the Abracon AB 1805 i2c rtc")

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 61ea2e3b4071..80ae27ffe8ea 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1083,6 +1083,7 @@ config RTC_DRV_AB8500
 
 config RTC_DRV_ABX805
 	tristate "Abracon AB X805 RTC"
+	depends on I2C
 	help
 	  Select this to enable support for the Abracon AB X805 RTC.
 	  AB X805 is the i2c flavour of the AB 18X5 family of ultra-low-power
