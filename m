From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 Oct 2011 18:42:52 +0000
Subject: [PATCH 2/3 v3.1] ARM: SAMSUNG: Fix GPIO space reservation for S3C64xx
	platforms
In-Reply-To: <1320086573-21184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320086573-21184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1320086573-21184-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conversion to use SAMSUNG_GPIO_EXTRA rather than S3C24XX_GPIO_EXTRA
broke a number of S3C64xx boards which had been using the symbols provided
to reserve a range of GPIOs for board specific use. Fix this by adding
equivalent symbols for the new shared driver and updating the relevant
boards to use the new symbols.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/Kconfig |    6 +++---
 arch/arm/plat-samsung/Kconfig |    8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 5552e04..4d8c489 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -188,7 +188,7 @@ config SMDK6410_WM1190_EV1
 	depends on MACH_SMDK6410
 	select REGULATOR
 	select REGULATOR_WM8350
-	select S3C24XX_GPIO_EXTRA64
+	select SAMSUNG_GPIO_EXTRA64
 	select MFD_WM8350_I2C
 	select MFD_WM8350_CONFIG_MODE_0
 	select MFD_WM8350_CONFIG_MODE_3
@@ -206,7 +206,7 @@ config SMDK6410_WM1192_EV1
 	depends on MACH_SMDK6410
 	select REGULATOR
 	select REGULATOR_WM831X
-	select S3C24XX_GPIO_EXTRA64
+	select SAMSUNG_GPIO_EXTRA64
 	select MFD_WM831X
 	select MFD_WM831X_I2C
 	help
@@ -287,7 +287,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C_DEV_WDT
 	select S3C_DEV_RTC
 	select S3C64XX_DEV_SPI
-	select S3C24XX_GPIO_EXTRA128
+	select SAMSUNG_GPIO_EXTRA128
 	select I2C
 	help
 	  Machine support for the Wolfson Cragganmore S3C6410 variant.
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 313eb26..bb0af66 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -88,12 +88,20 @@ config S5P_GPIO_DRVSTR
 
 config SAMSUNG_GPIO_EXTRA
 	int "Number of additional GPIO pins"
+	default 128 if SAMSUNG_GPIO_EXTRA128
+	default 64 if SAMSUNG_GPIO_EXTRA64
 	default 0
 	help
 	  Use additional GPIO space in addition to the GPIO's the SOC
 	  provides. This allows expanding the GPIO space for use with
 	  GPIO expanders.
 
+config SAMSUNG_GPIO_EXTRA64
+	bool
+
+config SAMSUNG_GPIO_EXTRA128
+	bool
+
 config S3C_GPIO_SPACE
 	int "Space between gpio banks"
 	default 0
-- 
1.7.7.1
