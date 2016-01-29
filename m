From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:50:33 +0100
Subject: [PATCH 1/6] ARM: s3c24xx: don't select EEPROM_AT24
In-Reply-To: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
Message-ID: <1454079040-3567945-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EEPROM_AT24 depends on both I2C and SYSFS. We have in the past
added I2C 'select' statements to avoid build problems with the
first, but we still get a warning because of the second:

warning: (MACH_DAVINCI_EVM && MACH_SFFSDR && MACH_DAVINCI_DM6467_EVM && MACH_DAVINCI_DM365_EVM && MACH_DAVINCI_DA830_EVM && MACH_MITYOMAPL138 && MACH_MINI2440) selects EEPROM_AT24 which has unmet direct dependencies (I2C && SYSFS)

This removes the 'select' statements again, and forces users to
enable the driver in their configuration files, as we do for
most other drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/mini2440_defconfig | 1 +
 arch/arm/configs/s3c2410_defconfig  | 1 +
 arch/arm/mach-s3c24xx/Kconfig       | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 9c93f5655248..0b02e4f43c6a 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -158,6 +158,7 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_S3C2410=y
 CONFIG_I2C_SIMTEC=y
+CONFIG_EEPROM_AT24=y
 CONFIG_SPI=y
 CONFIG_SPI_S3C24XX=y
 CONFIG_SPI_SPIDEV=y
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index f3142369f594..b3ade552a2a5 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -290,6 +290,7 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_S3C2410=y
 CONFIG_I2C_SIMTEC=y
+CONFIG_EEPROM_AT24=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_S3C24XX=m
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index ef68ecb27396..c94ef77405ed 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -460,7 +460,6 @@ config MACH_AT2440EVB
 
 config MACH_MINI2440
 	bool "MINI2440 development board"
-	select EEPROM_AT24 if I2C
 	select LEDS_CLASS
 	select LEDS_TRIGGERS
 	select LEDS_TRIGGER_BACKLIGHT
-- 
2.7.0
