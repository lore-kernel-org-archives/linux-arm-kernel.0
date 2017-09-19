From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 14:46:17 +0100
Subject: Applied "ASoC: rockchip: Use bus_type to distinguish rt5514 dsp from
 rt5514 codec" to the asoc tree
In-Reply-To: <20170919125800.336-5-jeffy.chen@rock-chips.com>
Message-ID: <E1duIqv-0008CA-M5@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Use bus_type to distinguish rt5514 dsp from rt5514 codec

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

>From 7e0dc9aeaea3ed130e090e20e9be0fc4877ddc37 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Tue, 19 Sep 2017 20:57:59 +0800
Subject: [PATCH] ASoC: rockchip: Use bus_type to distinguish rt5514 dsp from
 rt5514 codec

Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
Use bus_type to distinguish rt5514 dsp from rt5514 codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 61 ++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index fab868850d3a..30eed83e8a13 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -23,6 +23,7 @@
 #include <linux/of_gpio.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/i2c.h>
 #include <linux/input.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -317,15 +318,6 @@ enum {
 	DAILINK_RT5514_DSP,
 };
 
-static const char * const dailink_compat[] = {
-	[DAILINK_CDNDP] = "rockchip,rk3399-cdn-dp",
-	[DAILINK_DA7219] = "dlg,da7219",
-	[DAILINK_DMIC] = "dmic-codec",
-	[DAILINK_MAX98357A] = "maxim,max98357a",
-	[DAILINK_RT5514] = "realtek,rt5514-i2c",
-	[DAILINK_RT5514_DSP] = "realtek,rt5514-spi",
-};
-
 static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_CDNDP] = {
 		.name = "DP",
@@ -438,13 +430,58 @@ static const struct rockchip_sound_route rockchip_routes[] = {
 	[DAILINK_RT5514_DSP] = {},
 };
 
+struct dailink_match_data {
+	const char *compatible;
+	struct bus_type *bus_type;
+};
+
+static const struct dailink_match_data dailink_match[] = {
+	[DAILINK_CDNDP] = {
+		.compatible = "rockchip,rk3399-cdn-dp",
+	},
+	[DAILINK_DA7219] = {
+		.compatible = "dlg,da7219",
+	},
+	[DAILINK_DMIC] = {
+		.compatible = "dmic-codec",
+	},
+	[DAILINK_MAX98357A] = {
+		.compatible = "maxim,max98357a",
+	},
+	[DAILINK_RT5514] = {
+		.compatible = "realtek,rt5514",
+		.bus_type = &i2c_bus_type,
+	},
+	[DAILINK_RT5514_DSP] = {
+		.compatible = "realtek,rt5514",
+		.bus_type = &spi_bus_type,
+	},
+};
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
 static int rockchip_sound_codec_node_match(struct device_node *np_codec)
 {
+	struct device *dev;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dailink_compat); i++) {
-		if (of_device_is_compatible(np_codec, dailink_compat[i]))
-			return i;
+	for (i = 0; i < ARRAY_SIZE(dailink_match); i++) {
+		if (!of_device_is_compatible(np_codec,
+					     dailink_match[i].compatible))
+			continue;
+
+		if (dailink_match[i].bus_type) {
+			dev = bus_find_device(dailink_match[i].bus_type, NULL,
+					      np_codec, of_dev_node_match);
+			if (!dev)
+				continue;
+			put_device(dev);
+		}
+
+		return i;
 	}
 	return -1;
 }
-- 
2.14.1
