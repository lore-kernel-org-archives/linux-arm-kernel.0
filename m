From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 14:54:51 +0200
Subject: [PATCH 4/6] ARM: s3c24xx: use new PWM driver
In-Reply-To: <1344430493-5304-1-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
Message-ID: <1344430493-5304-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung PWM driver has moved to the new PWM subsystem, which
changed the Kconfig symbol for that driver, but the rx1950 and
gta02 boards still uses the old one.

Without this patch, building s3c2410_defconfig results in:

arch/arm/mach-s3c24xx/built-in.o: In function `rx1950_lcd_power':
arch/arm/mach-s3c24xx/mach-rx1950.c:430: undefined reference to `pwm_config'
arch/arm/mach-s3c24xx/mach-rx1950.c:431: undefined reference to `pwm_disable'
arch/arm/mach-s3c24xx/mach-rx1950.c:437: undefined reference to `pwm_config'
arch/arm/mach-s3c24xx/mach-rx1950.c:438: undefined reference to `pwm_enable'
arch/arm/mach-s3c24xx/built-in.o: In function `rx1950_backlight_exit':
arch/arm/mach-s3c24xx/mach-rx1950.c:504: undefined reference to `pwm_free'
arch/arm/mach-s3c24xx/built-in.o: In function `rx1950_backlight_init':
arch/arm/mach-s3c24xx/mach-rx1950.c:487: undefined reference to `pwm_request'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Kconfig |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index e249611..422133a 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -483,7 +483,8 @@ config MACH_NEO1973_GTA02
 	select I2C
 	select POWER_SUPPLY
 	select MACH_NEO1973
-	select S3C2410_PWM
+	select PWM
+	select PWM_SAMSUNG
 	select S3C_DEV_USB_HOST
 	help
 	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
@@ -493,7 +494,8 @@ config MACH_RX1950
 	select S3C24XX_DCLK
 	select PM_H1940 if PM
 	select I2C
-	select S3C2410_PWM
+	select PWM
+	select PWM_SAMSUNG
 	select S3C_DEV_NAND
 	select S3C2410_IOTIMING if S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
-- 
1.7.10
