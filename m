From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 17:13:46 +0100
Subject: [PATCH] ASoC: pxa: make TTC DKB tristate
Message-ID: <3973400.2YsPkej10R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a rare combination of Kconfig settings, the 88pm860x-codec
module may be selected as a loadable module, while it's also being
used by the ttb-dkb code that is built-in, resulting in a link
error:

sound/built-in.o: In function `ttc_pm860x_init':
:(.text+0x3e888): undefined reference to `pm860x_hs_jack_detect'
:(.text+0x3e898): undefined reference to `pm860x_mic_jack_detect'

Changing ttb-tkb to a tristate option tells Kconfig that 88pm86x
actually needs to be built-in if ttc-dkb is also built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 2434b6d61675..39cea80846c3 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -140,7 +140,7 @@ config SND_PXA910_SOC
 	  Marvell PXA910 reference platform.
 
 config SND_SOC_TTC_DKB
-	bool "SoC Audio support for TTC DKB"
+	tristate "SoC Audio support for TTC DKB"
 	depends on SND_PXA910_SOC && MACH_TTC_DKB && I2C=y
 	select PXA_SSP
 	select SND_PXA_SOC_SSP
