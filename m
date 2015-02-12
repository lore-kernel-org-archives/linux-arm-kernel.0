From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:35:38 +0100
Subject: [PATCH 1/9] ARM: s3c64xx: add I2C dependencies where needed
In-Reply-To: <1423769746-582629-1-git-send-email-arnd@arndb.de>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
Message-ID: <1423769746-582629-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMDK6410_WM1190_EV1 and SMDK6410_WM1192_EV1 add-on
cards select MFD_WM*_I2C, but they ignore the fact that I2C
may be compiled as a loadable module.

This patch adds a dependency on I2C, which means we avoid
the build errors, but can end up in a case where the options
are hidden from the user when I2C is turned off.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 26ca2427e53d..eff95e950d81 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -189,6 +189,7 @@ endchoice
 config SMDK6410_WM1190_EV1
 	bool "Support Wolfson Microelectronics 1190-EV1 PMIC card"
 	depends on MACH_SMDK6410
+	depends on I2C=y
 	select MFD_WM8350_I2C
 	select REGULATOR
 	select REGULATOR_WM8350
@@ -203,6 +204,7 @@ config SMDK6410_WM1190_EV1
 config SMDK6410_WM1192_EV1
 	bool "Support Wolfson Microelectronics 1192-EV1 PMIC card"
 	depends on MACH_SMDK6410
+	depends on I2C=y
 	select MFD_WM831X
 	select MFD_WM831X_I2C
 	select REGULATOR
@@ -269,8 +271,8 @@ config MACH_SMARTQ7
 
 config MACH_WLF_CRAGG_6410
 	bool "Wolfson Cragganmore 6410"
+	depends on I2C=y
 	select CPU_S3C6410
-	select I2C
 	select LEDS_GPIO_REGISTER
 	select S3C64XX_DEV_SPI0
 	select S3C64XX_SETUP_FB_24BPP
-- 
2.1.0.rc2
