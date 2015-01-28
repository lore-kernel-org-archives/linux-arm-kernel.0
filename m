From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:31:30 +0100
Subject: [RFC] ASoC: rt5677: fix SPI dependency
Message-ID: <19778554.1IDiTWklUc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rt5677 codec has gained code that requires SPI to work correctly,
but there is no provision in Kconfig to prevent the driver from
being used when SPI is disabled or a loadable module, resulting
in this build error:

sound/built-in.o: In function `rt5677_spi_write':
:(.text+0xa7ba0): undefined reference to `spi_sync'
sound/built-in.o: In function `rt5677_spi_driver_init':
:(.init.text+0x253c): undefined reference to `spi_register_driver'

ERROR: "spi_sync" [sound/soc/codecs/snd-soc-rt5677-spi.ko] undefined!
ERROR: "spi_register_driver" [sound/soc/codecs/snd-soc-rt5677-spi.ko] undefined!

This makes the SPI portion of the driver depend on the SPI subsystem,
and disables the function that uses SPI for firmware download if SPI
is disabled. The latter may not be the correct solution, but I could
not come up with a better one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: af48f1d08a54741 ("ASoC: rt5677: Support DSP function for VAD application")

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8349f982a586..ef2c70e77d91 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -525,7 +525,7 @@ config SND_SOC_RT5677
 
 config SND_SOC_RT5677_SPI
 	tristate
-	default SND_SOC_RT5677
+	default SND_SOC_RT5677 && SPI
 
 #Freescale sgtl5000 codec
 config SND_SOC_SGTL5000
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 26fc538f03b1..5d0bb8748dd1 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -702,6 +702,9 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 	static bool activity;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_SND_SOC_RT5677_SPI))
+		return -ENXIO;
+
 	if (on && !activity) {
 		activity = true;
 
