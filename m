From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 28 May 2015 11:36:14 +0200
Subject: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
In-Reply-To: <1432718749.27695.254.camel@x220>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
 <1432713024.27695.235.camel@x220> <20150527091902.GN3199@piout.net>
 <1432718749.27695.254.camel@x220>
Message-ID: <20150528093614.GL2185@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/05/2015 at 11:25:49 +0200, Paul Bolle wrote :
> On Wed, 2015-05-27 at 11:19 +0200, Alexandre Belloni wrote:
> > However, the Kconfig maintainer found a way to do the right thing so we
> > may as well drop that patch and keep those as modules.
> 
> Perhaps I missed a message: do you have a link?
> 

It was part of a private discussion. This would give that (replaces my
other patch) if you want to test:

>From b93ca1a4d9fa63c37e3d2b0aecbd1ec691a40922 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 25 May 2015 23:42:17 +0200
Subject: [PATCH] ASoC: atmel: properly select dma driver state

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
