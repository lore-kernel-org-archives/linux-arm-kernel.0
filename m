From: broonie@kernel.org (Mark Brown)
Date: Sat, 24 Sep 2016 22:58:18 -0700
Subject: Applied "ASoC: exynos: organize the asoc audio into a menu" to the
 asoc tree
In-Reply-To: <1474311470-23175-1-git-send-email-ayaka@soulik.info>
Message-ID: <E1bo2SA-0002up-G3@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: exynos: organize the asoc audio into a menu

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 090d93488135c8422d7711a8cefa4ed1cff7744a Mon Sep 17 00:00:00 2001
From: Randy Li <ayaka@soulik.info>
Date: Tue, 20 Sep 2016 02:57:50 +0800
Subject: [PATCH] ASoC: exynos: organize the asoc audio into a menu

It is simple sound card time, we could assign different codec
to a interface without making a specific driver for it. The SPDIF
and I2S interface for Samsung would be possible used by
simple-sound-card, but not sure about the PCM.

Those S3C time entries are left alone as I don't think any new board
would need them.

Signed-off-by: Randy Li <ayaka@soulik.info>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/Kconfig | 57 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 7b722b0094d9..f6023b46c107 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,12 +1,14 @@
-config SND_SOC_SAMSUNG
+menuconfig SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
 	select SND_SOC_GENERIC_DMAENGINE_PCM
-	help
+	---help---
 	  Say Y or M if you want to add support for codecs attached to
 	  the Samsung SoCs' Audio interfaces. You will also need to
 	  select the audio interfaces to support below.
 
+if SND_SOC_SAMSUNG
+
 config SND_S3C24XX_I2S
 	tristate
 
@@ -18,22 +20,22 @@ config SND_S3C2412_SOC_I2S
 	select SND_S3C_I2SV2_SOC
 
 config SND_SAMSUNG_PCM
-	tristate
+	tristate "Samsung PCM interface support"
 
 config SND_SAMSUNG_AC97
 	tristate
 	select SND_SOC_AC97_BUS
 
 config SND_SAMSUNG_SPDIF
-	tristate
+	tristate "Samsung SPDIF transmitter support"
 	select SND_SOC_SPDIF
 
 config SND_SAMSUNG_I2S
-	tristate
+	tristate "Samsung I2S interface support"
 
 config SND_SOC_SAMSUNG_NEO1973_WM8753
 	tristate "Audio support for Openmoko Neo1973 Smartphones (GTA02)"
-	depends on SND_SOC_SAMSUNG && MACH_NEO1973_GTA02
+	depends on MACH_NEO1973_GTA02
 	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
 	select SND_SOC_BT_SCO
@@ -43,7 +45,7 @@ config SND_SOC_SAMSUNG_NEO1973_WM8753
 
 config SND_SOC_SAMSUNG_JIVE_WM8750
 	tristate "SoC I2S Audio support for Jive"
-	depends on SND_SOC_SAMSUNG && MACH_JIVE && I2C
+	depends on MACH_JIVE && I2C
 	select SND_SOC_WM8750
 	select SND_S3C2412_SOC_I2S
 	help
@@ -51,7 +53,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110
 	depends on I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
@@ -60,7 +62,6 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
 
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG
 	depends on I2C=y
 	select MFD_WM8994
 	select SND_SOC_WM8994
@@ -70,7 +71,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8994
 
 config SND_SOC_SAMSUNG_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
-	depends on SND_SOC_SAMSUNG && MACH_SMDK2443
+	depends on MACH_SMDK2443
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
 	select SND_SAMSUNG_AC97
@@ -80,7 +81,7 @@ config SND_SOC_SAMSUNG_SMDK2443_WM9710
 
 config SND_SOC_SAMSUNG_LN2440SBC_ALC650
 	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
+	depends on ARCH_S3C24XX
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
 	select SND_SAMSUNG_AC97
@@ -90,7 +91,7 @@ config SND_SOC_SAMSUNG_LN2440SBC_ALC650
 
 config SND_SOC_SAMSUNG_S3C24XX_UDA134X
 	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX
+	depends on ARCH_S3C24XX
 	select SND_S3C24XX_I2S
 	select SND_SOC_L3
 	select SND_SOC_UDA134X
@@ -102,21 +103,21 @@ config SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23
 	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX && I2C
+	depends on ARCH_S3C24XX && I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_SIMTEC_HERMES
 	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on SND_SOC_SAMSUNG && ARCH_S3C24XX && I2C
+	depends on ARCH_S3C24XX && I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_SAMSUNG_SIMTEC
 
 config SND_SOC_SAMSUNG_H1940_UDA1380
 	tristate "Audio support for the HP iPAQ H1940"
-	depends on SND_SOC_SAMSUNG && ARCH_H1940 && I2C
+	depends on ARCH_H1940 && I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_UDA1380
 	help
@@ -124,7 +125,7 @@ config SND_SOC_SAMSUNG_H1940_UDA1380
 
 config SND_SOC_SAMSUNG_RX1950_UDA1380
 	tristate "Audio support for the HP iPAQ RX1950"
-	depends on SND_SOC_SAMSUNG && MACH_RX1950 && I2C
+	depends on MACH_RX1950 && I2C
 	select SND_S3C24XX_I2S
 	select SND_SOC_UDA1380
 	help
@@ -132,7 +133,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 
 config SND_SOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
@@ -140,20 +141,19 @@ config SND_SOC_SAMSUNG_SMDK_WM9713
 
 config SND_SOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
-	depends on SND_SOC_SAMSUNG && MACH_SMARTQ && I2C
+	depends on MACH_SMARTQ && I2C
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on SND_SOC_SAMSUNG
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
 
 config SND_SOC_SMDK_WM8580_PCM
 	tristate "SoC PCM Audio support for WM8580 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKV210 || MACH_SMDKC110)
+	depends on MACH_SMDKV210 || MACH_SMDKC110
 	depends on I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_PCM
@@ -162,7 +162,6 @@ config SND_SOC_SMDK_WM8580_PCM
 
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG
 	depends on I2C=y
 	select MFD_WM8994
 	select SND_SOC_WM8994
@@ -172,7 +171,7 @@ config SND_SOC_SMDK_WM8994_PCM
 
 config SND_SOC_SPEYSIDE
 	tristate "Audio support for Wolfson Speyside"
-	depends on SND_SOC_SAMSUNG && I2C && SPI_MASTER
+	depends on I2C && SPI_MASTER
 	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8996
@@ -182,14 +181,14 @@ config SND_SOC_SPEYSIDE
 
 config SND_SOC_TOBERMORY
 	tristate "Audio support for Wolfson Tobermory"
-	depends on SND_SOC_SAMSUNG && INPUT && I2C
+	depends on INPUT && I2C
 	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8962
 
 config SND_SOC_BELLS
 	tristate "Audio support for Wolfson Bells"
-	depends on SND_SOC_SAMSUNG && MFD_ARIZONA && I2C && SPI_MASTER
+	depends on MFD_ARIZONA && I2C && SPI_MASTER
 	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5102
@@ -200,7 +199,7 @@ config SND_SOC_BELLS
 
 config SND_SOC_LOWLAND
 	tristate "Audio support for Wolfson Lowland"
-	depends on SND_SOC_SAMSUNG && I2C
+	depends on I2C
 	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5100
@@ -208,7 +207,7 @@ config SND_SOC_LOWLAND
 
 config SND_SOC_LITTLEMILL
 	tristate "Audio support for Wolfson Littlemill"
-	depends on SND_SOC_SAMSUNG && I2C
+	depends on I2C
 	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select MFD_WM8994
@@ -216,7 +215,7 @@ config SND_SOC_LITTLEMILL
 
 config SND_SOC_SNOW
 	tristate "Audio support for Google Snow boards"
-	depends on SND_SOC_SAMSUNG && I2C
+	depends on I2C
 	select SND_SOC_MAX98090
 	select SND_SOC_MAX98095
 	select SND_SAMSUNG_I2S
@@ -226,6 +225,8 @@ config SND_SOC_SNOW
 
 config SND_SOC_ARNDALE_RT5631_ALC5631
         tristate "Audio support for RT5631(ALC5631) on Arndale Board"
-        depends on SND_SOC_SAMSUNG && I2C
+        depends on I2C
         select SND_SAMSUNG_I2S
         select SND_SOC_RT5631
+
+endif #SND_SOC_SAMSUNG
-- 
2.9.3
