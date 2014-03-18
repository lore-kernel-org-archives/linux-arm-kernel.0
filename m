From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Mar 2014 17:18:02 +0100
Subject: [RFC] ASoC: samsung: don't build pcm and spdif on exynos
Message-ID: <201403181718.02780.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit d37bdf736d9b "ASoC: samsung: Use ASoC dmaengine code where
possible", Mark Brown changed the EXYNOS ASoC code to no longer
use the private dma interfaces that are standing in the way of
multiplatform enablement.

However, in 313367e7bfa "ASoC: Samsung: Update Kconfig for I2S,SPDIF
and PCM audio", two new users of that interface appeared, since it
is now possible to enable SND_SOC_SAMSUNG_SMDK_SPDIF and
SND_SOC_SMDK_WM8994_PCM on all Samsung SoCs including EXYNOS.

This patch does a partial revert of 313367e7bfa by allowing these
drivers on all samsung platforms except EXYNOS, so we can proceed
with the multiplatform patches.

If support for these drivers is actually needed on EXYNOS machines,
the drivers should probably first be moved over to use the dmaengine
code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sangsu Park <sangsu4u.park@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Padmavathi Venna <padma.v@samsung.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Padma, could you comment on this? When you did the patch that introduced
the usage of these drivers on EXYNOS, did you actually need that for
a particular machine that would get broken by this revert?

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 7b610a8..efc01e0 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -167,7 +167,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && !ARCH_EXYNOS
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
@@ -183,7 +183,7 @@ config SND_SOC_SMDK_WM8580_PCM
 
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && !ARCH_EXYNOS
 	depends on I2C=y
 	select MFD_WM8994
 	select SND_SOC_WM8994
