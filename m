From: broonie@kernel.org (Mark Brown)
Date: Tue,  5 Dec 2017 12:48:03 +0000 (GMT)
Subject: Applied "ASoC: atmel-classd: select correct Kconfig symbol" to the
 asoc tree
In-Reply-To: <20171205101000.968887-1-arnd@arndb.de>
Message-ID: <20171205124803.D380E44006B@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel-classd: select correct Kconfig symbol

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7e3dba272e5ef5b38fba8710f98b4b3da7232ea5 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Dec 2017 11:09:38 +0100
Subject: [PATCH] ASoC: atmel-classd: select correct Kconfig symbol

Commit 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
changed the way that the dependencies are handled, but then the
Class D amplifier support got merged, which used the old method.

This seems to have triggered a very rare randconfig condition for me
now, leading to a link error:

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
atmel_ssc_dai.c:(.text+0x79c): undefined reference to `atmel_pcm_dma_platform_register'
atmel_ssc_dai.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_register'
sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_put_audio':
atmel_ssc_dai.c:(.text+0xf24): undefined reference to `atmel_pcm_dma_platform_unregister'
atmel_ssc_dai.c:(.text+0xf24): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_unregister'

Changing it to select SND_ATMEL_SOC_SSC_DMA as intended rather than
SND_ATMEL_SOC_DMA directly makes it work again.

Fixes: e0a25b6d1862 ("ASoC: atmel-classd: add the Audio Class D Amplifier")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 4a56f3dfba51..2d998e5c4fb5 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -64,7 +64,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
 config SND_ATMEL_SOC_CLASSD
 	tristate "Atmel ASoC driver for boards using CLASSD"
 	depends on ARCH_AT91 || COMPILE_TEST
-	select SND_ATMEL_SOC_DMA
+	select SND_ATMEL_SOC_SSC_DMA
 	select REGMAP_MMIO
 	help
 	  Say Y if you want to add support for Atmel ASoC driver for boards using
-- 
2.15.0
