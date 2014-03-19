From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:53 +0100
Subject: [PATCH 56/62] ARM: samsung: select I2C where needed for PMIC
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-57-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OSIRIS machine cannot build without I2C and
TPS65010 both enabled unconditionally.

The SMDK6410_WM1190_EV1 and SMDK6410_WM1192_EV1 add-on
cards already select MFD_WM*_I2C.

In each case, failing to enable CONFIG_I2C results in a
build or link error, so most consistent solution is to
ensure that it is impossible to disable those options.

It would be nice to leave CONFIG_I2C as user-selectable,
but doing that properly would require more work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c24xx/Kconfig | 1 +
 arch/arm/mach-s3c64xx/Kconfig | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index a6060d0..1272647 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -572,6 +572,7 @@ config MACH_OSIRIS_DVS
 	tristate "Simtec IM2440D20 (OSIRIS) Dynamic Voltage Scaling driver"
 	depends on MACH_OSIRIS
 	select TPS65010
+	select I2C
 	help
 	  Say Y/M here if you want to have dynamic voltage scaling support
 	  on the Simtec IM2440D20 (OSIRIS) module via the TPS65011.
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 92885d7..0148112 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -191,6 +191,7 @@ endchoice
 config SMDK6410_WM1190_EV1
 	bool "Support Wolfson Microelectronics 1190-EV1 PMIC card"
 	depends on MACH_SMDK6410
+	select I2C
 	select MFD_WM8350_I2C
 	select REGULATOR
 	select REGULATOR_WM8350
@@ -205,6 +206,7 @@ config SMDK6410_WM1190_EV1
 config SMDK6410_WM1192_EV1
 	bool "Support Wolfson Microelectronics 1192-EV1 PMIC card"
 	depends on MACH_SMDK6410
+	select I2C
 	select MFD_WM831X
 	select MFD_WM831X_I2C
 	select REGULATOR
-- 
1.8.3.2
