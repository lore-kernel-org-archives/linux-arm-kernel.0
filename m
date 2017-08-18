From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Aug 2017 12:48:53 +0100
Subject: Applied "ASoC: tegra: Remove SoC-specific Kconfig depends and
 selects" to the asoc tree
In-Reply-To: <20170730112220.15525-1-contact@paulk.fr>
Message-ID: <E1difll-0000uY-4a@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: tegra: Remove SoC-specific Kconfig depends and selects

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

>From 3bcfe80f1c471b6bbade9f1a725778ea0471bb49 Mon Sep 17 00:00:00 2001
From: Paul Kocialkowski <contact@paulk.fr>
Date: Thu, 17 Aug 2017 21:05:52 +0200
Subject: [PATCH] ASoC: tegra: Remove SoC-specific Kconfig depends and selects

This removes the SoC-specific dependencies on the platform drivers,
as well as SoC-specific selections of platform drivers for the
machine drivers. The rationale behind this change is that the
dependencies are not actual build dependencies but run-time ones.

The previously listed SoCs were also incomplete: for instance, tegra124
uses the tegra30 platform drivers, which could not be built without
ARCH_TEGRA_3x_SOC set.

Descriptions of the tristates are also added to allow these options
to be set via defconfig/menuconfig.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/Kconfig | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index efbe8d4c019e..6875fc39a575 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -9,8 +9,8 @@ config SND_SOC_TEGRA
 	  Say Y or M here if you want support for SoC audio on Tegra.
 
 config SND_SOC_TEGRA20_AC97
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
+	tristate "Tegra20 AC97 interface"
+	depends on SND_SOC_TEGRA
 	select SND_SOC_AC97_BUS
 	select SND_SOC_TEGRA20_DAS
 	help
@@ -19,16 +19,16 @@ config SND_SOC_TEGRA20_AC97
 	  machine drivers to support below.
 
 config SND_SOC_TEGRA20_DAS
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
+	tristate "Tegra20 DAS module"
+	depends on SND_SOC_TEGRA
 	help
 	  Say Y or M if you want to add support for the Tegra20 DAS module.
 	  You will also need to select the individual machine drivers to
 	  support below.
 
 config SND_SOC_TEGRA20_I2S
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
+	tristate "Tegra20 I2S interface"
+	depends on SND_SOC_TEGRA
 	select SND_SOC_TEGRA20_DAS
 	help
 	  Say Y or M if you want to add support for codecs attached to the
@@ -36,8 +36,8 @@ config SND_SOC_TEGRA20_I2S
 	  machine drivers to support below.
 
 config SND_SOC_TEGRA20_SPDIF
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
+	tristate "Tegra20 SPDIF interface"
+	depends on SND_SOC_TEGRA
 	default m
 	help
 	  Say Y or M if you want to add support for the Tegra20 SPDIF interface.
@@ -45,16 +45,16 @@ config SND_SOC_TEGRA20_SPDIF
 	  below.
 
 config SND_SOC_TEGRA30_AHUB
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_3x_SOC
+	tristate "Tegra30 AHUB module"
+	depends on SND_SOC_TEGRA
 	help
-	  Say Y or M if you want to add support for the Tegra20 AHUB module.
+	  Say Y or M if you want to add support for the Tegra30 AHUB module.
 	  You will also need to select the individual machine drivers to
 	  support below.
 
 config SND_SOC_TEGRA30_I2S
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_3x_SOC
+	tristate "Tegra30 I2S interface"
+	depends on SND_SOC_TEGRA
 	select SND_SOC_TEGRA30_AHUB
 	help
 	  Say Y or M if you want to add support for codecs attached to the
@@ -64,8 +64,6 @@ config SND_SOC_TEGRA30_I2S
 config SND_SOC_TEGRA_RT5640
 	tristate "SoC Audio support for Tegra boards using an RT5640 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_RT5640
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -74,8 +72,6 @@ config SND_SOC_TEGRA_RT5640
 config SND_SOC_TEGRA_WM8753
 	tristate "SoC Audio support for Tegra boards using a WM8753 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_WM8753
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -84,8 +80,6 @@ config SND_SOC_TEGRA_WM8753
 config SND_SOC_TEGRA_WM8903
 	tristate "SoC Audio support for Tegra boards using a WM8903 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_WM8903
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -94,7 +88,7 @@ config SND_SOC_TEGRA_WM8903
 
 config SND_SOC_TEGRA_WM9712
 	tristate "SoC Audio support for Tegra boards using a WM9712 codec"
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC && GPIOLIB
+	depends on SND_SOC_TEGRA && GPIOLIB
 	select SND_SOC_TEGRA20_AC97
 	select SND_SOC_WM9712
 	help
@@ -104,7 +98,6 @@ config SND_SOC_TEGRA_WM9712
 config SND_SOC_TEGRA_TRIMSLICE
 	tristate "SoC Audio support for TrimSlice board"
 	depends on SND_SOC_TEGRA && I2C
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_TLV320AIC23_I2C
 	help
 	  Say Y or M here if you want to add support for SoC audio on the
@@ -113,7 +106,6 @@ config SND_SOC_TEGRA_TRIMSLICE
 config SND_SOC_TEGRA_ALC5632
 	tristate "SoC Audio support for Tegra boards using an ALC5632 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_ALC5632
 	help
 	  Say Y or M here if you want to add support for SoC audio on the
@@ -122,8 +114,6 @@ config SND_SOC_TEGRA_ALC5632
 config SND_SOC_TEGRA_MAX98090
 	tristate "SoC Audio support for Tegra boards using a MAX98090 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_MAX98090
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -132,8 +122,6 @@ config SND_SOC_TEGRA_MAX98090
 config SND_SOC_TEGRA_RT5677
 	tristate "SoC Audio support for Tegra boards using a RT5677 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_RT5677
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -142,8 +130,6 @@ config SND_SOC_TEGRA_RT5677
 config SND_SOC_TEGRA_SGTL5000
 	tristate "SoC Audio support for Tegra boards using a SGTL5000 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_SGTL5000
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
-- 
2.13.2
