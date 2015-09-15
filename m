From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 15 Sep 2015 20:51:31 +0200
Subject: [PATCH] ASoC: fix broken pxa SoC support
Message-ID: <1442343091-2295-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous fix of pxa library support, which was introduced to fix the
library dependency, broke the previous SoC behavior, where a machine
code binding pxa2xx-ac97 with a coded relied on :
 - sound/soc/pxa/pxa2xx-ac97.c
 - sound/soc/codecs/XXX.c

For example, the mioa701_wm9713.c machine code is currently broken. The
"select ARM" statement wrongly selects the soc/arm/pxa2xx-ac97 for
compilation, as per an unfortunate fate SND_PXA2XX_AC97 is both declared
in sound/arm/Kconfig and sound/soc/pxa/Kconfig.

Fix this by ensuring that SND_PXA2XX_SOC correctly triggers the correct
pxa2xx-ac97 compilation.

Fixes: 846172dfe33c ("ASoC: fix SND_PXA2XX_LIB Kconfig warning")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/arm/Kconfig     | 15 ++++++++-------
 sound/soc/pxa/Kconfig |  2 --
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 885683a3b0bd..e0406211716b 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -9,6 +9,14 @@ menuconfig SND_ARM
 	  Drivers that are implemented on ASoC can be found in
 	  "ALSA for SoC audio support" section.
 
+config SND_PXA2XX_LIB
+	tristate
+	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
+	select SND_DMAENGINE_PCM
+
+config SND_PXA2XX_LIB_AC97
+	bool
+
 if SND_ARM
 
 config SND_ARMAACI
@@ -21,13 +29,6 @@ config SND_PXA2XX_PCM
 	tristate
 	select SND_PCM
 
-config SND_PXA2XX_LIB
-	tristate
-	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
-
-config SND_PXA2XX_LIB_AC97
-	bool
-
 config SND_PXA2XX_AC97
 	tristate "AC97 driver for the Intel PXA2xx chip"
 	depends on ARCH_PXA
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 39cea80846c3..f2bf8661dd21 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,7 +1,6 @@
 config SND_PXA2XX_SOC
 	tristate "SoC Audio for the Intel PXA2xx chip"
 	depends on ARCH_PXA
-	select SND_ARM
 	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to add support for codecs attached to
@@ -25,7 +24,6 @@ config SND_PXA2XX_AC97
 config SND_PXA2XX_SOC_AC97
 	tristate
 	select AC97_BUS
-	select SND_ARM
 	select SND_PXA2XX_LIB_AC97
 	select SND_SOC_AC97_BUS
 
-- 
2.1.4
