From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 13:43:41 +0200
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
Message-ID: <1950588.ErdGoiHh8p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wm8962 driver uses the input subsystem, but is selected by
SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
resulting in this link error:

ERROR: "input_event" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!
ERROR: "input_register_device" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!
ERROR: "devm_input_allocate_device" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!

This adds an explicit Kconfig dependency to prevent this configuration
from being used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 708b4351f08 ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6164e78b466a..99e9386f7956 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -282,7 +282,7 @@ config SND_SOC_IMX_MC13783
 
 config SND_SOC_FSL_ASOC_CARD
 	tristate "Generic ASoC Sound Card with ASRC support"
-	depends on OF && I2C
+	depends on OF && I2C && INPUT
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_ESAI
