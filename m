From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 21:35:08 +0100
Subject: [PATCH v2] ASoC: Samsung: add missing I2C/SPI dependencies
Message-ID: <8075847.dUio9f5hRh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few sound drivers for the samsung platforms are missing dependencies
on I2C or SPI, which can lead to build errors like

codecs/rt5631.c:1737:1: warning: data definition has no type or storage class
31_i2c_driver);

codecs/rt5631.c:1737:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
codecs/rt5631.c:1737:1: warning: parameter names (without types) in function declaration
codecs/rt5631.c:1726:26: warning: 'rt5631_i2c_driver' defined but not used [-Wunused-variable]

I have gone through all the ones that did not already have
an I2C dependency and added the ones that I found missing,
namely arndale, odroid-x2, littlemill, bells and speyside
and this patch adds all the dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 3cebf6ca03df..0632a36852c8 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -174,7 +174,7 @@ config SND_SOC_SMDK_WM8994_PCM
 
 config SND_SOC_SPEYSIDE
 	tristate "Audio support for Wolfson Speyside"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && I2C && SPI_MASTER
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8996
 	select SND_SOC_WM9081
@@ -189,7 +189,7 @@ config SND_SOC_TOBERMORY
 
 config SND_SOC_BELLS
 	tristate "Audio support for Wolfson Bells"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && MFD_ARIZONA
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && MFD_ARIZONA && I2C && SPI_MASTER
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5102
 	select SND_SOC_WM5110
@@ -206,7 +206,7 @@ config SND_SOC_LOWLAND
 
 config SND_SOC_LITTLEMILL
 	tristate "Audio support for Wolfson Littlemill"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && I2C
 	select SND_SAMSUNG_I2S
 	select MFD_WM8994
 	select SND_SOC_WM8994
@@ -223,7 +223,7 @@ config SND_SOC_SNOW
 
 config SND_SOC_ODROIDX2
 	tristate "Audio support for Odroid-X2 and Odroid-U3"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && I2C
 	select SND_SOC_MAX98090
 	select SND_SAMSUNG_I2S
 	help
@@ -231,6 +231,6 @@ config SND_SOC_ODROIDX2
 
 config SND_SOC_ARNDALE_RT5631_ALC5631
         tristate "Audio support for RT5631(ALC5631) on Arndale Board"
-        depends on SND_SOC_SAMSUNG
+        depends on SND_SOC_SAMSUNG && I2C
         select SND_SAMSUNG_I2S
         select SND_SOC_RT5631
