From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:28:55 +0100
Subject: [PATCH] ASoC: Samsung: add missing I2C/SPI dependencies
Message-ID: <1815674.ObkQWLfgIW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SND_SOC_ARNDALE_RT5631_ALC5631 selects the rt5631 codec
that requires I2C to work, so we get a build error if I2C
is disabled:

codecs/rt5631.c:1737:1: warning: data definition has no type or storage class
31_i2c_driver);

codecs/rt5631.c:1737:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
codecs/rt5631.c:1737:1: warning: parameter names (without types) in function declaration
codecs/rt5631.c:1726:26: warning: 'rt5631_i2c_driver' defined but not used [-Wunused-variable]

The same thing can happen on odroid-x2, littlemill, bells
and speyside, so this patch adds all the dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index e817a2f43ea8..dd781d9a1c66 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -185,7 +185,7 @@ config SND_SOC_SMDK_WM8994_PCM
 
 config SND_SOC_SPEYSIDE
 	tristate "Audio support for Wolfson Speyside"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && SPI_MASTER
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8996
 	select SND_SOC_WM9081
@@ -200,7 +200,7 @@ config SND_SOC_TOBERMORY
 
 config SND_SOC_BELLS
 	tristate "Audio support for Wolfson Bells"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && MFD_ARIZONA
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && MFD_ARIZONA && I2C && SPI_MASTER
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5102
 	select SND_SOC_WM5110
@@ -217,7 +217,7 @@ config SND_SOC_LOWLAND
 
 config SND_SOC_LITTLEMILL
 	tristate "Audio support for Wolfson Littlemill"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && I2C
 	select SND_SAMSUNG_I2S
 	select MFD_WM8994
 	select SND_SOC_WM8994
@@ -234,7 +234,7 @@ config SND_SOC_SNOW
 
 config SND_SOC_ODROIDX2
 	tristate "Audio support for Odroid-X2 and Odroid-U3"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && I2C
 	select SND_SOC_MAX98090
 	select SND_SAMSUNG_I2S
 	help
@@ -242,6 +242,6 @@ config SND_SOC_ODROIDX2
 
 config SND_SOC_ARNDALE_RT5631_ALC5631
         tristate "Audio support for RT5631(ALC5631) on Arndale Board"
-        depends on SND_SOC_SAMSUNG
+        depends on SND_SOC_SAMSUNG && I2C
         select SND_SAMSUNG_I2S
         select SND_SOC_RT5631
