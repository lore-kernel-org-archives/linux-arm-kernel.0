From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 12:40:04 +0200
Subject: [PATCH] ASoC: MMP audio needs sram support
Message-ID: <4367111.vzeoBg4u5h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From e7a94bb7fb871c73cc85712d89c1f48d0271c1be Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Jun 2014 12:31:28 +0200
Subject: [PATCH] ASoC: MMP audio needs sram support

Building the pxa/mmp audio driver without support for the mmp
sram driver enabled results in this link error:

sound/built-in.o: In function `mmp_pcm_free_dma_buffers':
:(.text+0x3e734): undefined reference to `sram_get_gpool'
sound/built-in.o: In function `mmp_pcm_new':
:(.text+0x3e7c0): undefined reference to `sram_get_gpool'

The sram driver is cannot be manually enabled and needs to
be turned on by selecting MMP_SRAM from each module that
needs it, which is what this patch does.

Ideally, MMP should move over to the generic SRAM support, but
for the moment, we can avoid the build error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Qiao Zhou <zhouqiao@marvell.com>

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 42b305e..12a6da8 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -11,6 +11,7 @@ config SND_PXA2XX_SOC
 config SND_MMP_SOC
 	bool "Soc Audio for Marvell MMP chips"
 	depends on ARCH_MMP
+	select MMP_SRAM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_ARM
 	help
