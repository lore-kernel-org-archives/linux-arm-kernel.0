From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  8 Dec 2017 15:18:53 +0100
Subject: [PATCH] ASoC: atmel-classd: select correct Kconfig symbol
Message-ID: <20171208141853.3879-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_ATMEL_SOC_CLASSD selects SND_ATMEL_SOC_DMA but the driver itself
handles its own DMA operations and doesn't need anything from
atmel-pcm-dma.c or atmel_ssc_dai.c.

Replace SND_ATMEL_SOC_DMA by SND_SOC_GENERIC_DMAENGINE_PCM which is the
only one actually required.

This may end up in a configuration leading to a link error:

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
atmel_ssc_dai.c:(.text+0x79c): undefined reference to `atmel_pcm_dma_platform_register'
atmel_ssc_dai.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_register'
sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_put_audio':
atmel_ssc_dai.c:(.text+0xf24): undefined reference to `atmel_pcm_dma_platform_unregister'
atmel_ssc_dai.c:(.text+0xf24): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_unregister'

Tested on sama5d2 xplained with the following configuration
where nothing selects SND_ATMEL_SOC_DMA:

CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_ATMEL_SOC_CLASSD=y

Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e0a25b6d1862 ("ASoC: atmel-classd: add the Audio Class D Amplifier")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/atmel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 4a56f3dfba51..dcee145dd179 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -64,7 +64,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
 config SND_ATMEL_SOC_CLASSD
 	tristate "Atmel ASoC driver for boards using CLASSD"
 	depends on ARCH_AT91 || COMPILE_TEST
-	select SND_ATMEL_SOC_DMA
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
 	  Say Y if you want to add support for Atmel ASoC driver for boards using
-- 
2.15.1
