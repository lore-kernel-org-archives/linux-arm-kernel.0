From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:27:47 -0600
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
Message-ID: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
This will reduce the number of configurations that need to be supported
by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.

Stop selecting I2S/AC97/SPDIF controller drivers from the machine driver
config options; this doesn't really work if we don't know which specific
SoC(s) we're building for. However, set their default values based on
SND_SOC_TEGRA, since most people will probably want to enable support for
all SoCs. This also avoids the need to change any defconfig files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/Kconfig | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index 68fd6d0..321a6c9 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -7,8 +7,9 @@ config SND_SOC_TEGRA
 	  Say Y or M here if you want support for SoC audio on Tegra.
 
 config SND_SOC_TEGRA20_AC97
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
+	tristate "Tegra20 AC97 controller"
+	depends on SND_SOC_TEGRA
+	default SND_SOC_TEGRA
 	select SND_SOC_AC97_BUS
 	select SND_SOC_TEGRA20_DAS
 	help
@@ -18,15 +19,16 @@ config SND_SOC_TEGRA20_AC97
 
 config SND_SOC_TEGRA20_DAS
 	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
+	depends on SND_SOC_TEGRA
 	help
 	  Say Y or M if you want to add support for the Tegra20 DAS module.
 	  You will also need to select the individual machine drivers to
 	  support below.
 
 config SND_SOC_TEGRA20_I2S
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
+	tristate "Tegra20 I2C controller"
+	depends on SND_SOC_TEGRA
+	default SND_SOC_TEGRA
 	select SND_SOC_TEGRA20_DAS
 	help
 	  Say Y or M if you want to add support for codecs attached to the
@@ -34,9 +36,9 @@ config SND_SOC_TEGRA20_I2S
 	  machine drivers to support below.
 
 config SND_SOC_TEGRA20_SPDIF
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC
-	default m
+	tristate "Tegra20 SPDIF controller"
+	default SND_SOC_TEGRA
+	depends on SND_SOC_TEGRA
 	help
 	  Say Y or M if you want to add support for the Tegra20 SPDIF interface.
 	  You will also need to select the individual machine drivers to support
@@ -44,15 +46,16 @@ config SND_SOC_TEGRA20_SPDIF
 
 config SND_SOC_TEGRA30_AHUB
 	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_3x_SOC
+	depends on SND_SOC_TEGRA
 	help
 	  Say Y or M if you want to add support for the Tegra20 AHUB module.
 	  You will also need to select the individual machine drivers to
 	  support below.
 
 config SND_SOC_TEGRA30_I2S
-	tristate
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_3x_SOC
+	tristate "Tegra30 I2S controller"
+	depends on SND_SOC_TEGRA
+	default SND_SOC_TEGRA
 	select SND_SOC_TEGRA30_AHUB
 	help
 	  Say Y or M if you want to add support for codecs attached to the
@@ -62,8 +65,6 @@ config SND_SOC_TEGRA30_I2S
 config SND_SOC_TEGRA_RT5640
 	tristate "SoC Audio support for Tegra boards using an RT5640 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_RT5640
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -72,8 +73,6 @@ config SND_SOC_TEGRA_RT5640
 config SND_SOC_TEGRA_WM8753
 	tristate "SoC Audio support for Tegra boards using a WM8753 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_WM8753
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -82,8 +81,6 @@ config SND_SOC_TEGRA_WM8753
 config SND_SOC_TEGRA_WM8903
 	tristate "SoC Audio support for Tegra boards using a WM8903 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
 	select SND_SOC_WM8903
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -92,8 +89,7 @@ config SND_SOC_TEGRA_WM8903
 
 config SND_SOC_TEGRA_WM9712
 	tristate "SoC Audio support for Tegra boards using a WM9712 codec"
-	depends on SND_SOC_TEGRA && ARCH_TEGRA_2x_SOC && GPIOLIB
-	select SND_SOC_TEGRA20_AC97
+	depends on SND_SOC_TEGRA && GPIOLIB
 	select SND_SOC_WM9712
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
@@ -102,7 +98,6 @@ config SND_SOC_TEGRA_WM9712
 config SND_SOC_TEGRA_TRIMSLICE
 	tristate "SoC Audio support for TrimSlice board"
 	depends on SND_SOC_TEGRA && I2C
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y or M here if you want to add support for SoC audio on the
@@ -111,7 +106,6 @@ config SND_SOC_TEGRA_TRIMSLICE
 config SND_SOC_TEGRA_ALC5632
 	tristate "SoC Audio support for Tegra boards using an ALC5632 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
 	select SND_SOC_ALC5632
 	help
 	  Say Y or M here if you want to add support for SoC audio on the
-- 
1.8.1.5
