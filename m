From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Oct 2016 19:03:33 +0100
Subject: Applied "ASoC: PXA: Brownstone needs I2C" to the asoc tree
In-Reply-To: <20161018151912.2742738-1-arnd@arndb.de>
Message-ID: <E1byjav-000114-DL@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: PXA: Brownstone needs I2C

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5229f1f4a4585f503a0683575bf38d9a1d2c1982 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Oct 2016 17:18:58 +0200
Subject: [PATCH] ASoC: PXA: Brownstone needs I2C

I rand into a new build error with SND_MMP_SOC_BROWNSTONE:

warning: (SND_MMP_SOC_BROWNSTONE && SND_SOC_SAMSUNG_SMDK_WM8994 && SND_SOC_SMDK_WM8994_PCM && SND_SOC_LITTLEMILL) selects MFD_WM8994 which has unmet direct dependencies (HAS_IOMEM && I2C)
drivers/mfd/wm8994-core.c:688:1: error: data definition has no type or storage class [-Werror]
drivers/mfd/wm8994-core.c:688:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

I don't see why this never showed up before, as the dependency seems to
have been missing since the symbol was first introduced several years
ago. This adds a dependency like the other drivers have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f2bf8661dd21..823b5a236d8d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -208,7 +208,7 @@ config SND_PXA2XX_SOC_IMOTE2
 
 config SND_MMP_SOC_BROWNSTONE
 	tristate "SoC Audio support for Marvell Brownstone"
-	depends on SND_MMP_SOC && MACH_BROWNSTONE
+	depends on SND_MMP_SOC && MACH_BROWNSTONE && I2C
 	select SND_MMP_SOC_SSPA
 	select MFD_WM8994
 	select SND_SOC_WM8994
-- 
2.8.1
