From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Jul 2014 15:45:04 +0200
Subject: [PATCH 1/4] ASoC: samsung: add explicit i2c/spi dependencies
In-Reply-To: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
Message-ID: <1405086308-1461192-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got another build error from SND_SOC_SMARTQ selecting
SND_SOC_WM8750 without ensuring that I2C is enabled,
in this example, i2c is a loadable module:

sound/built-in.o: In function `wm8750_i2c_probe':
:(.text+0x3e6c0): undefined reference to `devm_regmap_init_i2c'
sound/built-in.o: In function `wm8750_exit':
:(.exit.text+0x3f4): undefined reference to `i2c_del_driver'
sound/built-in.o: In function `wm8750_modinit':
:(.init.text+0x13d0): undefined reference to `i2c_register_driver'

This changes the samsund ASoC Kconfig to have explicit
I2C dependencies for each driver that uses an i2c bus and
SPI dependencies for the ones using those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/samsung/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 2c4786c6fe91..7622af82ac4f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -49,7 +49,7 @@ config SND_SOC_SAMSUNG_NEO1973_WM8753
 
 config SND_SOC_SAMSUNG_JIVE_WM8750
 	tristate "SoC I2S Audio support for Jive"
-	depends on SND_SOC_SAMSUNG && MACH_JIVE
+	depends on SND_SOC_SAMSUNG && MACH_JIVE && I2C
 	select SND_SOC_WM8750
 	select SND_S3C2412_SOC_I2S
 	help
@@ -148,7 +148,7 @@ config SND_SOC_SAMSUNG_SMDK_WM9713
 
 config SND_SOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
-	depends on SND_SOC_SAMSUNG && MACH_SMARTQ
+	depends on SND_SOC_SAMSUNG && MACH_SMARTQ && I2C
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8750
 
@@ -200,7 +200,7 @@ config SND_SOC_SPEYSIDE
 
 config SND_SOC_TOBERMORY
 	tristate "Audio support for Wolfson Tobermory"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && INPUT
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && INPUT && I2C
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8962
 
@@ -216,7 +216,7 @@ config SND_SOC_BELLS
 
 config SND_SOC_LOWLAND
 	tristate "Audio support for Wolfson Lowland"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && I2C
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5100
 	select SND_SOC_WM9081
-- 
1.8.3.2
