From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 19 Sep 2017 20:57:59 +0800
Subject: [PATCH v3 4/5] ASoC: rockchip: Use bus_type to distinguish rt5514 dsp
 from rt5514 codec
In-Reply-To: <20170919125800.336-1-jeffy.chen@rock-chips.com>
References: <20170919125800.336-1-jeffy.chen@rock-chips.com>
Message-ID: <20170919125800.336-5-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
Use bus_type to distinguish rt5514 dsp from rt5514 codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v3: None
Changes in v2: None

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
2.11.0
