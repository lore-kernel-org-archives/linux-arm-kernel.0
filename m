From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:30:01 +0100
Subject: [PATCH] ASoC: davinci: fix DM365_EVM codec selection
Message-ID: <12284641.mhX5PHEsR2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An earlier bug fix of mine made the SND_DM365_VOICE_CODEC symbol
tristate to avoid creating an undefined reference from the
davinci-vcif.c driver to the davinci_soc_platform_register
function that may be in a module.

However, this may now lead to a different error on randconfig
kernels:

"warning: SND_DM365_VOICE_CODEC creates inconsistent choice state"

This happens because we now have a choice statement with
one bool and one tristate option, and the latter might not
support being set to 'y' because of dependencies.

This new change turns the other option into 'tristate' as well,
which avoids the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 19926c6de0c3 ("ASoC: davinci: vcif must be a module if SND_DAVINCI_SOC is")

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 8e948c63f3d9..2b81ca418d2a 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -58,13 +58,12 @@ choice
 	depends on MACH_DAVINCI_DM365_EVM
 
 config SND_DM365_AIC3X_CODEC
-	bool "Audio Codec - AIC3101"
+	tristate "Audio Codec - AIC3101"
 	help
 	  Say Y if you want to add support for AIC3101 audio codec
 
 config SND_DM365_VOICE_CODEC
 	tristate "Voice Codec - CQ93VC"
-	depends on SND_DAVINCI_SOC
 	select MFD_DAVINCI_VOICECODEC
 	select SND_DAVINCI_SOC_VCIF
 	select SND_SOC_CQ0093VC
