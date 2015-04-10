From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 00:18:37 +0200
Subject: [PATCH] ASoC: rnsd: fix build regression without CONFIG_OF
Message-ID: <6164726.dCMByIoYOc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r-car sound driver only works when CONFIG_OF is set, and
after a recent change has a compile-time dependency as well:

sound/built-in.o: In function `rsnd_dma_request_channel':
:(.text+0x9fb84): undefined reference to `of_dma_request_slave_channel'

This could be fixed either by adding a static inline wrapper
for the function, or by adding a Kconfig dependency. This
implements the second approach, which seems appropriate
because the driver in fact has a hard dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 72adc61f4637aa3 ("ASoC: rsnd: 1st DMAC dma-names cares subnode")

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 2b3030415573..07114b0b0dc1 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_SH4_SIU
 
 config SND_SOC_RCAR
 	tristate "R-Car series SRU/SCU/SSIU/SSI support"
+	depends on DMA_OF
 	select SND_SIMPLE_CARD
 	select REGMAP_MMIO
 	help
