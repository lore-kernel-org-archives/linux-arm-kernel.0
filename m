From: acgzxing@gmail.com (Xing Zheng)
Date: Tue, 12 May 2015 17:26:36 +0800
Subject: [PATCH 3/4] ASoC: rockchip: add rockchip machine driver for
 rt5650/rt5645
In-Reply-To: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1431422797-31903-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhengxing <zhengxing@rock-chips.com>

The driver is used for rockchip board using a rt5650/rt5645.
Test on RK3288 with rt5650.

Signed-off-by: zhengxing <zhengxing@rock-chips.com>
---

 sound/soc/rockchip/Kconfig                   |    9 ++
 sound/soc/rockchip/Makefile                  |    2 +
 sound/soc/rockchip/rockchip_machine_driver.c |    6 +
 sound/soc/rockchip/rockchip_machine_driver.h |    5 +
 sound/soc/rockchip/rockchip_rt5645.c         |  220 ++++++++++++++++++++++++++
 5 files changed, 242 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_rt5645.c

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 057c457..bdf5ded 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -31,3 +31,12 @@ config SND_SOC_ROCKCHIP_MAX98090
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  boards using the MAX98090 codec, such as Veyron.
+
+config SND_SOC_ROCKCHIP_RT5645
+	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_RT5645
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  boards using the RT5645/RT5650 codec, such as Veyron.
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 23e9b64..099732d 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -6,6 +6,8 @@ obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
 # ROCKCHIP Machine Support
 snd-soc-rockchip-machine-objs := rockchip_machine_driver.o
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
+snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MACHINE) += snd-soc-rockchip-machine.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
diff --git a/sound/soc/rockchip/rockchip_machine_driver.c b/sound/soc/rockchip/rockchip_machine_driver.c
index ee09c62..7807d4e 100644
--- a/sound/soc/rockchip/rockchip_machine_driver.c
+++ b/sound/soc/rockchip/rockchip_machine_driver.c
@@ -36,6 +36,12 @@
 
 /* the sound cards of rockchp supports. */
 static struct rk_snd_soc_cards rk_snd_cards[] = {
+#ifdef CONFIG_SND_SOC_ROCKCHIP_RT5645
+	{
+		.name = RK_SND_CARD_RT5645,
+		.preinit = rk_machine_preinit_rt5645,
+	},
+#endif
 #ifdef CONFIG_SND_SOC_ROCKCHIP_MAX98090
 	{
 		.name = RK_SND_CARD_MAX98090,
diff --git a/sound/soc/rockchip/rockchip_machine_driver.h b/sound/soc/rockchip/rockchip_machine_driver.h
index 903ed94..f4fd74e 100644
--- a/sound/soc/rockchip/rockchip_machine_driver.h
+++ b/sound/soc/rockchip/rockchip_machine_driver.h
@@ -28,6 +28,11 @@ struct rk_snd_soc_cards {
 };
 
 /* the sound cards of rockchp supports. */
+#ifdef CONFIG_SND_SOC_ROCKCHIP_RT5645
+#define RK_SND_CARD_RT5645				"rk_snd_rt5645"
+int rk_machine_preinit_rt5645(struct rk_snd_soc_cards *soc_card);
+#endif
+
 #ifdef CONFIG_SND_SOC_ROCKCHIP_MAX98090
 #define RK_SND_CARD_MAX98090				"rk_snd_max98090"
 int rk_machine_preinit_max98090(struct rk_snd_soc_cards *soc_card);
diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
new file mode 100644
index 0000000..e2b8774
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -0,0 +1,220 @@
+/*
+ * Rockchip machine ASoC driver for boards using a RT5645/RT5650 CODEC.
+ *
+ * Copyright (c) 2015, ROCKCHIP CORPORATION.  All rights reserved.
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
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "rockchip_i2s.h"
+#include "rockchip_machine_driver.h"
+
+/* Jack detect via rt5645 driver. */
+extern int rt5645_set_jack_detect(struct snd_soc_codec *codec,
+				  struct snd_soc_jack *hp_jack,
+				  struct snd_soc_jack *mic_jack,
+				  struct snd_soc_jack *btn_jack);
+
+/* For compatible. */
+int __weak rt5645_set_jack_detect(struct snd_soc_codec *codec,
+				  struct snd_soc_jack *hp_jack,
+				  struct snd_soc_jack *mic_jack,
+				  struct snd_soc_jack *btn_jack)
+{
+	dev_warn(codec->dev, "Jack detect dummy, have no implement it?\n");
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route rk_audio_map[] = {
+	/* Input Lines */
+	{"DMIC L2", NULL, "Int Mic"},
+	{"DMIC R2", NULL, "Int Mic"},
+	{"RECMIXL", NULL, "Headset Mic"},
+	{"RECMIXR", NULL, "Headset Mic"},
+
+	/* Output Lines */
+	{"Headphones", NULL, "HPOR"},
+	{"Headphones", NULL, "HPOL"},
+	{"Speakers", NULL, "SPOL"},
+	{"Speakers", NULL, "SPOR"},
+};
+
+static const struct snd_kcontrol_new rk_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphones"),
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
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
+	int ret = 0;
+	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = runtime->card;
+	struct rk_mc_private *drv = snd_soc_card_get_drvdata(card);
+
+	card->dapm.idle_bias_off = true;
+
+	snd_soc_dapm_enable_pin(dapm, "Headphones");
+	snd_soc_dapm_enable_pin(dapm, "Speakers");
+	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_enable_pin(dapm, "Int Mic");
+
+	snd_soc_dapm_sync(dapm);
+
+	/* Enable Headset and 4 Buttons Jack detection */
+	ret = snd_soc_card_jack_new(card, "Headphone Jack",
+				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
+				    &drv->headphone_jack,
+				    NULL,
+				    0);
+	if (ret < 0) {
+		dev_err(codec->dev, "Can't new Headphone Jack: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new(card, "Mic Jack",
+				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
+				    &drv->mic_jack,
+				    NULL,
+				    0);
+	if (ret < 0) {
+		dev_err(codec->dev, "Can't new Mic Jack: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new(card, "Button Jack",
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &drv->btn_jack,
+				    NULL,
+				    0);
+	if (ret < 0) {
+		dev_err(codec->dev, "Can't new Button Jack: %d\n", ret);
+		return ret;
+	}
+
+	ret = rt5645_set_jack_detect(codec, &drv->headphone_jack,
+				     &drv->mic_jack, &drv->btn_jack);
+	if (ret < 0) {
+		dev_err(codec->dev, "Set jack detect failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops rk_aif1_ops = {
+	.hw_params = rk_aif1_hw_params,
+};
+
+static struct snd_soc_dai_link rk_dailink = {
+	.name = "rt5645",
+	.stream_name = "rt5645 PCM",
+	.codec_dai_name = "rt5645-aif1",
+	.init = rk_init,
+	.ops = &rk_aif1_ops,
+	/* set rt5645 as slave */
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBS_CFS,
+};
+
+/* rockchip machine driver for rt5650/rt5645 */
+static struct snd_soc_card snd_soc_card_rk = {
+	.name = "I2S-RT5650",
+	.dai_link = &rk_dailink,
+	.num_links = 1,
+	.dapm_widgets = rk_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_dapm_widgets),
+	.dapm_routes = rk_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(rk_audio_map),
+	.controls = rk_mc_controls,
+	.num_controls = ARRAY_SIZE(rk_mc_controls),
+};
+
+int rk_machine_preinit_rt5645(struct rk_snd_soc_cards *soc_card)
+{
+	if (soc_card && !strcmp(soc_card->name, RK_SND_CARD_RT5645)) {
+		/* pre-init snd card info. */
+		soc_card->card = &snd_soc_card_rk;
+		strcpy(soc_card->compatible,
+		       "rockchip,rockchip-audio-rt5645");
+
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+MODULE_AUTHOR("Xing Zheng <zhengxing@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip rt5645 machine ASoC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
