From: broonie@kernel.org (Mark Brown)
Date: Tue,  6 Nov 2018 18:07:05 +0000 (GMT)
Subject: Applied "ASoC: pxa: change ac97 dependencies" to the asoc tree
In-Reply-To: <20181102112055.659197-1-arnd@arndb.de>
Message-ID: <20181106180705.6580A112266B@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: pxa: change ac97 dependencies

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 25540f68c871d0ed3771b552eb640a1130880ab6 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Nov 2018 12:20:39 +0100
Subject: [PATCH] ASoC: pxa: change ac97 dependencies

Enabling both the old AC97_BUS code and the new AC97_BUS_COMPAT causes
problems because both modules provide an exported snd_ac97_reset()
function.

I had tried to fix the problem of having both coexist earlier, but
my patch only prevented them from being built-in. This is because
of a special Kconfig feature that lets a symbol have a dependency
on another one being disabled, but still allow both to be loadable
modules.

Changing the dependency to =n avoids that problem, now we can only
build the new driver if the old one is completely disabled.

If we could figure out a way to let rename one of the reset
functions and have each driver link to exactly the old or
the compat code, that would also work, but I could not find if
that's possible.

Fixes: bec5ecdf41d4 ("ASoC: pxa: avoid AC97_BUS build warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 943b44de1464..6075fc32e6b9 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -79,7 +79,7 @@ config SND_PXA2XX_SOC_TOSA
 	tristate "SoC AC97 Audio support for Tosa"
 	depends on SND_PXA2XX_SOC && MACH_TOSA
 	depends on MFD_TC6393XB
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -89,7 +89,7 @@ config SND_PXA2XX_SOC_TOSA
 config SND_PXA2XX_SOC_E740
 	tristate "SoC AC97 Audio support for e740"
 	depends on SND_PXA2XX_SOC && MACH_E740
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -99,7 +99,7 @@ config SND_PXA2XX_SOC_E740
 config SND_PXA2XX_SOC_E750
 	tristate "SoC AC97 Audio support for e750"
 	depends on SND_PXA2XX_SOC && MACH_E750
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -109,7 +109,7 @@ config SND_PXA2XX_SOC_E750
 config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
 	depends on SND_PXA2XX_SOC && MACH_E800
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9712
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -120,7 +120,7 @@ config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
 	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
 			MACH_CM_X300)
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -131,7 +131,7 @@ config SND_PXA2XX_SOC_PALM27X
 	bool "SoC Audio support for Palm T|X, T5, E2 and LifeDrive"
 	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
 			MACH_PALMT5 || MACH_PALMTE2)
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -161,7 +161,7 @@ config SND_SOC_TTC_DKB
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_PXA_SOC_SSP
 	select SND_SOC_WM9713
@@ -201,7 +201,7 @@ config SND_PXA2XX_SOC_MAGICIAN
 config SND_PXA2XX_SOC_MIOA701
         tristate "SoC Audio support for MIO A701"
         depends on SND_PXA2XX_SOC && MACH_MIOA701
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
         select SND_PXA2XX_SOC_AC97
         select SND_SOC_WM9713
         help
-- 
2.19.0.rc2
