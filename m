From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Apr 2017 10:15:20 +0200
Subject: [PATCH] ASoC: mediatek: add I2C dependency for CS42XX8
Message-ID: <20170420081541.658178-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not select drivers that depend on I2C when that is disabled,
as it results in a build error:

warning: (SND_SOC_MT2701_WM8960) selects SND_SOC_WM8960 which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && I2C)
sound/soc/codecs/wm8960.c:1469:1: error: data definition has no type or storage class [-Werror]
sound/soc/codecs/wm8960.c:1469:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

Fixes: 8625c1dbd876 ("ASoC: mediatek: Add mt2701-wm8960 machine driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index c6f39040f71f..5c68797f36c4 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -24,7 +24,7 @@ config SND_SOC_MT2701_CS42448
 
 config SND_SOC_MT2701_WM8960
 	tristate "ASoc Audio driver for MT2701 with WM8960 codec"
-	depends on SND_SOC_MT2701
+	depends on SND_SOC_MT2701 && I2C
 	select SND_SOC_WM8960
 	help
 	  This adds ASoC driver for Mediatek MT2701 boards
-- 
2.9.0
