From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  7 Aug 2017 12:40:44 +0200
Subject: [PATCH] ASoC: pxa: don't select SSP for COMPILE_TESTing
Message-ID: <20170807104101.3540159-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the audio driver selects CONFIG_PXA_SSP to be a loadable
module on a platform other than PXA, and the PXA SPI driver
is built-in, we get a link error in the SPI driver:

drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_remove':
spi-pxa2xx.c:(.text+0x5f0): undefined reference to `pxa_ssp_free'
drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_probe':
spi-pxa2xx.c:(.text+0xeac): undefined reference to `pxa_ssp_request'
spi-pxa2xx.c:(.text+0x1468): undefined reference to `pxa_ssp_free'
spi-pxa2xx.c:(.text+0x15bc): undefined reference to `pxa_ssp_free'

Fixes: 73d7ee2e831f ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 484ab3c2ad67..1d392582559d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -33,7 +33,7 @@ config SND_PXA2XX_SOC_I2S
 
 config SND_PXA_SOC_SSP
 	tristate
-	select PXA_SSP
+	select PXA_SSP if ARCH_PXA
 
 config SND_MMP_SOC_SSPA
 	tristate
@@ -141,7 +141,6 @@ config SND_PXA910_SOC
 config SND_SOC_TTC_DKB
 	tristate "SoC Audio support for TTC DKB"
 	depends on SND_PXA910_SOC && MACH_TTC_DKB && I2C=y
-	select PXA_SSP
 	select SND_PXA_SOC_SSP
 	select SND_MMP_SOC
 	select MFD_88PM860X
-- 
2.9.0
