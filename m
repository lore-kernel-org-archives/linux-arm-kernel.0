From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  2 Nov 2018 16:33:40 +0100
Subject: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
Message-ID: <20181102153406.1528053-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
into link errors for some configurations:

sound/soc/sunxi/sun50i-codec-analog.o: In function `sun50i_codec_analog_probe':
sun50i-codec-analog.c:(.text+0x62): undefined reference to `sun8i_adda_pr_regmap_init'

The new name appears to be more sensible, and as the symbol is hidden,
there are no downsides in the rename, so use that consistently now.

Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sunxi/Kconfig  | 4 ++--
 sound/soc/sunxi/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 66aad0d3f9c7..0f992bdf1a10 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -23,7 +23,7 @@ config SND_SUN8I_CODEC
 config SND_SUN8I_CODEC_ANALOG
 	tristate "Allwinner sun8i Codec Analog Controls Support"
 	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
-	select SND_SUN8I_ADDA_PR_REGMAP
+	select SND_SUNXI_ADDA_PR_REGMAP
 	help
 	  Say Y or M if you want to add support for the analog controls for
 	  the codec embedded in newer Allwinner SoCs.
@@ -54,7 +54,7 @@ config SND_SUN4I_SPDIF
 	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
 	  A10 and affiliated SoCs.
 
-config SND_SUN8I_ADDA_PR_REGMAP
+config SND_SUNXI_ADDA_PR_REGMAP
 	tristate
 	select REGMAP
 
diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
index a86be340a076..c4dd2803a011 100644
--- a/sound/soc/sunxi/Makefile
+++ b/sound/soc/sunxi/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_SND_SUN4I_SPDIF) += sun4i-spdif.o
 obj-$(CONFIG_SND_SUN8I_CODEC_ANALOG) += sun8i-codec-analog.o
 obj-$(CONFIG_SND_SUN50I_CODEC_ANALOG) += sun50i-codec-analog.o
 obj-$(CONFIG_SND_SUN8I_CODEC) += sun8i-codec.o
-obj-$(CONFIG_SND_SUN8I_ADDA_PR_REGMAP) += sun8i-adda-pr-regmap.o
+obj-$(CONFIG_SND_SUNXI_ADDA_PR_REGMAP) += sun8i-adda-pr-regmap.o
-- 
2.18.0
