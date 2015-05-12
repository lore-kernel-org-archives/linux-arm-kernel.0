From: acgzxing@gmail.com (Xing Zheng)
Date: Tue, 12 May 2015 17:26:35 +0800
Subject: [PATCH 2/4] ASoC: rockchip: add rockchip machine driver for max98090
In-Reply-To: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhengxing <zhengxing@rock-chips.com>

The driver is used for rockchip board using a max98090.
Test on RK3288 with max98090.

Signed-off-by: zhengxing <zhengxing@rock-chips.com>
---

 sound/soc/rockchip/Kconfig                   |   10 ++
 sound/soc/rockchip/Makefile                  |    2 +
 sound/soc/rockchip/rockchip_machine_driver.c |    6 +
 sound/soc/rockchip/rockchip_machine_driver.h |    6 +
 sound/soc/rockchip/rockchip_max98090.c       |  185 ++++++++++++++++++++++++++
 5 files changed, 209 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index e3f51cf..057c457 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -21,3 +21,13 @@ config SND_SOC_ROCKCHIP_MACHINE
 	help
 	  Say Y or M if you want to add support for Machine driver
 	  for Rockchip I2S device.
+
+config SND_SOC_ROCKCHIP_MAX98090
+	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_MAX98090
+	select SND_SOC_TS3A227E
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  boards using the MAX98090 codec, such as Veyron.
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 47d7c84..23e9b64 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -5,5 +5,7 @@ obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
 
 # ROCKCHIP Machine Support
 snd-soc-rockchip-machine-objs := rockchip_machine_driver.o
+snd-soc-rockchip-max98090-objs := rockchip_max98090.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MACHINE) += snd-soc-rockchip-machine.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
diff --git a/sound/soc/rockchip/rockchip_machine_driver.c b/sound/soc/rockchip/rockchip_machine_driver.c
index 34cae3f..ee09c62 100644
--- a/sound/soc/rockchip/rockchip_machine_driver.c
+++ b/sound/soc/rockchip/rockchip_machine_driver.c
@@ -36,6 +36,12 @@
 
 /* the sound cards of rockchp supports. */
 static struct rk_snd_soc_cards rk_snd_cards[] = {
+#ifdef CONFIG_SND_SOC_ROCKCHIP_MAX98090
+	{
+		.name = RK_SND_CARD_MAX98090,
+		.preinit = rk_machine_preinit_max98090,
+	},
+#endif
 };
 
 static int snd_rk_mc_preinit(void)
diff --git a/sound/soc/rockchip/rockchip_machine_driver.h b/sound/soc/rockchip/rockchip_machine_driver.h
index 39a7a77..903ed94 100644
--- a/sound/soc/rockchip/rockchip_machine_driver.h
+++ b/sound/soc/rockchip/rockchip_machine_driver.h
@@ -27,4 +27,10 @@ struct rk_snd_soc_cards {
 	int (*preinit)(struct rk_snd_soc_cards *soc_card);
 };
 
+/* the sound cards of rockchp supports. */
+#ifdef CONFIG_SND_SOC_ROCKCHIP_MAX98090
+#define RK_SND_CARD_MAX98090				"rk_snd_max98090"
+int rk_machine_preinit_max98090(struct rk_snd_soc_cards *soc_card);
+#endif
+
 #endif /* __ROCKCHIP_MACHINE_DRIVER_H__ */
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
new file mode 100644
index 0000000..f56dc69c
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -0,0 +1,185 @@
+/*
+ * Rockchip machine ASoC driver for boards using a MAX90809 CODEC.
+ *
+ * Copyright (c) 2014, ROCKCHIP CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "rockchip_i2s.h"
+#include "../codecs/ts3a227e.h"
+#include "rockchip_machine_driver.h"
+
+static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route rk_audio_map[] = {
+	{"IN34", NULL, "Headset Mic"},
+	{"IN34", NULL, "MICBIAS"},
+	{"MICBIAS", NULL, "Headset Mic"},
+	{"DMICL", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPL"},
+	{"Headphone", NULL, "HPR"},
+	{"Speaker", NULL, "SPKL"},
+	{"Speaker", NULL, "SPKR"},
+};
+
+static const struct snd_kcontrol_new rk_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	int ret = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int mclk;
+
+	switch (params_rate(params)) {
+	case 48000:
+		mclk = 12288000;
+		break;
+	case 44100:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+				     SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int rk_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = runtime->card;
+	struct rk_mc_private *drv = snd_soc_card_get_drvdata(card);
+
+	card->dapm.idle_bias_off = true;
+
+	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_enable_pin(dapm, "Headphone");
+	snd_soc_dapm_enable_pin(dapm, "Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Int Mic");
+
+	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
+
+	snd_soc_dapm_sync(dapm);
+
+	/* Enable headphone jack detection */
+	return snd_soc_card_jack_new(card, "Headset Jack",
+			       SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+			       SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+			       SND_JACK_BTN_2 | SND_JACK_BTN_3,
+			       &drv->headphone_jack,
+			       NULL,
+			       0);
+}
+
+static int rk_98090_headset_init(struct snd_soc_component *component)
+{
+	struct snd_soc_card *card = component->card;
+	struct rk_mc_private *drv = snd_soc_card_get_drvdata(card);
+
+	return ts3a227e_enable_jack_detect(component, &drv->headphone_jack);
+}
+
+static struct snd_soc_ops rk_aif1_ops = {
+	.hw_params = rk_aif1_hw_params,
+};
+
+static struct snd_soc_aux_dev rk_98090_headset_dev = {
+	.name = "Headset Chip",
+	.init = rk_98090_headset_init,
+};
+
+static struct snd_soc_dai_link rk_dailink = {
+	.name = "max98090",
+	.stream_name = "Audio",
+	.codec_dai_name = "HiFi",
+	.init = rk_init,
+	.ops = &rk_aif1_ops,
+	/* set max98090 as slave */
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBS_CFS,
+};
+
+/* rockchip machine driver for max98090 */
+static struct snd_soc_card snd_soc_card_rk = {
+	.name = "ROCKCHIP-I2S",
+	.dai_link = &rk_dailink,
+	.num_links = 1,
+	.aux_dev = &rk_98090_headset_dev,
+	.num_aux_devs = 1,
+	.dapm_widgets = rk_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_dapm_widgets),
+	.dapm_routes = rk_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(rk_audio_map),
+	.controls = rk_mc_controls,
+	.num_controls = ARRAY_SIZE(rk_mc_controls),
+};
+
+int rk_machine_preinit_max98090(struct rk_snd_soc_cards *soc_card)
+{
+	if (soc_card && !strcmp(soc_card->name, RK_SND_CARD_MAX98090)) {
+		/* pre-init snd card info. */
+		soc_card->card = &snd_soc_card_rk;
+		strcpy(soc_card->compatible,
+		       "rockchip,rockchip-audio-max98090");
+
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+MODULE_AUTHOR("jianqun <jay.xu@rock-chips.com>");
+MODULE_AUTHOR("Xing Zheng <zhengxing@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip max98090 machine ASoC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
