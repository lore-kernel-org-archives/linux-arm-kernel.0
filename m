From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Feb 2017 23:00:46 +0100
Subject: [PATCH] ASoC: mediatek: add I2C dependency for CS42XX8
Message-ID: <20170221220108.200734-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not select drivers that depend on I2C when that is disabled,
as it results in a build error:

warning: (SND_SOC_MT2701_CS42448) selects SND_SOC_CS42XX8_I2C which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && I2C)
sound/soc/codecs/cs42xx8-i2c.c:60:1: warning: data definition has no type or storage class
 module_i2c_driver(cs42xx8_i2c_driver);
sound/soc/codecs/cs42xx8-i2c.c:60:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

Fixes: 1f458d53f76c ("ASoC: mediatek: Add mt2701-cs42448 driver and config option.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 05cf809cf9e1..d7013bde6f45 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -13,7 +13,7 @@ config SND_SOC_MT2701
 
 config SND_SOC_MT2701_CS42448
 	tristate "ASoc Audio driver for MT2701 with CS42448 codec"
-	depends on SND_SOC_MT2701
+	depends on SND_SOC_MT2701 && I2C
 	select SND_SOC_CS42XX8_I2C
 	select SND_SOC_BT_SCO
 	help
-- 
2.9.0
