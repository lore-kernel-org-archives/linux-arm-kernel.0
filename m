From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 11:40:40 +0200
Subject: [PATCH] ASoC: samsung: Add I2C dependency for snow
Message-ID: <7290614.Z7JFMYFomx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both codecs used by snow, max98090 and max98095 require the use
of I2C, so we can only select this driver if I2C is there, otherwise
we get a build error like:

codecs/max98090.c:2494:1: warning: data definition has no type or storage class [enabled by default]
 module_i2c_driver(max98090_i2c_driver);
 ^
codecs/max98095.c:2443:1: warning: data definition has no type or storage class [enabled by default]
 module_i2c_driver(max98095_i2c_driver);
 ^

This adds one more I2C dependency to the hundreds we already
have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tushar Behera <tushar.behera@linaro.org>
---
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a7cb8f6..cb7be4f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -232,7 +232,7 @@ config SND_SOC_LITTLEMILL
 
 config SND_SOC_SNOW
 	tristate "Audio support for Google Snow boards"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && I2C
 	select SND_SOC_MAX98090
 	select SND_SOC_MAX98095
 	select SND_SAMSUNG_I2S
