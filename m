From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 17:32:17 +0200
Subject: [PATCH] ASoC: davinci: vcif must be a module if SND_DAVINCI_SOC is
Message-ID: <2771900.ce8bYznKIN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible to configure a kernel with SND_DAVINCI_SOC=m and
SND_DM365_VOICE_CODEC=y, which results in a link error:

sound/built-in.o: In function `davinci_vcif_probe':
sound/soc/davinci/davinci-vcif.c:223: undefined reference to `davinci_soc_platform_register'

The best way to avoid this is to make SND_DM365_VOICE_CODEC
a tristate option that depends on SND_DAVINCI_SOC, so it
can only be a module or disabled when the base driver is
a loadable module

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index d69510c53239..8e948c63f3d9 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -63,7 +63,8 @@ config SND_DM365_AIC3X_CODEC
 	  Say Y if you want to add support for AIC3101 audio codec
 
 config SND_DM365_VOICE_CODEC
-	bool "Voice Codec - CQ93VC"
+	tristate "Voice Codec - CQ93VC"
+	depends on SND_DAVINCI_SOC
 	select MFD_DAVINCI_VOICECODEC
 	select SND_DAVINCI_SOC_VCIF
 	select SND_SOC_CQ0093VC
