From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 11 Jun 2015 11:06:09 +0200
Subject: [PATCH 2/2] ASoC: atmel: properly select dma driver state
In-Reply-To: <1434013569-24745-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1434013569-24745-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1434013569-24745-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is currently possible to have CONFIG_SND_ATMEL_SOC_SSC=y with either
CONFIG_SND_ATMEL_SOC_PDC=m or CONFIG_SND_ATMEL_SOC_DMA=m. This results in a
driver that compiles but does not link with this kind of error:

sound/built-in.o: In function `atmel_ssc_set_audio':
(.text+0x87d90): undefined reference to `atmel_pcm_pdc_platform_register'
sound/built-in.o: In function `atmel_ssc_put_audio':
(.text+0x8879a): undefined reference to `atmel_pcm_pdc_platform_unregister'

Introduce new config options SND_ATMEL_SOC_SSC_PDC and
SND_ATMEL_SOC_SSC_DMA which should be used by the board drivers and the
correct logic to properly select the SND_ATMEL_SOC_PDC and
SND_ATMEL_SOC_DMA states.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/atmel/Kconfig | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 93abe4e6d596..1489cd461aec 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -10,20 +10,31 @@ if SND_ATMEL_SOC
 
 config SND_ATMEL_SOC_PDC
 	tristate
+	default m if SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=m
+	default y if SND_ATMEL_SOC_SSC_PDC=y || (SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=y)
+
+config SND_ATMEL_SOC_SSC_PDC
+	tristate
 
 config SND_ATMEL_SOC_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	default m if SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=m
+	default y if SND_ATMEL_SOC_SSC_DMA=y || (SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=y)
+
+config SND_ATMEL_SOC_SSC_DMA
+	tristate
 
 config SND_ATMEL_SOC_SSC
 	tristate
+	default y if SND_ATMEL_SOC_SSC_DMA=y || SND_ATMEL_SOC_SSC_PDC=y
+	default m if SND_ATMEL_SOC_SSC_DMA=m || SND_ATMEL_SOC_SSC_PDC=m
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
-	select SND_ATMEL_SOC_PDC
-	select SND_ATMEL_SOC_SSC
+	select SND_ATMEL_SOC_SSC_PDC
 	select SND_SOC_WM8731
 	help
 	  Say Y if you want to add support for SoC audio on WM8731-based
@@ -33,8 +44,7 @@ config SND_ATMEL_SOC_WM8904
 	tristate "Atmel ASoC driver for boards using WM8904 codec"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && I2C
-	select SND_ATMEL_SOC_SSC
-	select SND_ATMEL_SOC_DMA
+	select SND_ATMEL_SOC_SSC_DMA
 	select SND_SOC_WM8904
 	help
 	  Say Y if you want to add support for Atmel ASoC driver for boards using
@@ -44,8 +54,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
 	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
-	select SND_ATMEL_SOC_SSC
-	select SND_ATMEL_SOC_DMA
+	select SND_ATMEL_SOC_SSC_DMA
 	select SND_SOC_WM8731
 	help
 	  Say Y if you want to add support for audio SoC on an
-- 
2.1.4
