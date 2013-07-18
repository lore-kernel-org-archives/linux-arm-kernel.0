From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 18 Jul 2013 15:28:03 +0800
Subject: [PATCH] ASoC: atmel: add wm8904 based audio machine driver
Message-ID: <1374132483-25375-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add wm8904 based audio machine driver

the following ek board based on it
  - at91sam9n12ek
  - sama5d3xek (d31, d33, d34, d35)

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
This patch is only for Atmel SoC with wm8904 codec machine driver only,
temp no change for dts file, as there are many changes to dts file in
mailing list for atmel SoC now, so hold on for dts change, after that
will send the dts file patches
---
 .../devicetree/bindings/sound/atmel-wm8904.txt     |   30 +++
 sound/soc/atmel/Kconfig                            |   10 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel_wm8904.c                     |  263 ++++++++++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-wm8904.txt
 create mode 100644 sound/soc/atmel/atmel_wm8904.c

diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
new file mode 100644
index 0000000..5990271
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
@@ -0,0 +1,30 @@
+Atmel ASoC driver with wm8904 audio codec complex
+
+Required properties:
+  - compatible: "atmel,asoc-wm8904"
+  - atmel,model: The user-visible name of this sound complex.
+  - atmel,audio-routing: A list of the connections between audio components.
+  - atmel,ssc-controller: The phandle of the SSC controller
+  - atmel,audio-codec: The phandle of the WM8904 audio codec
+Optional properties:
+  - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
+
+Example:
+sound {
+	compatible = "atmel,asoc-wm8904";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pck0_as_mck>;
+
+	atmel,model = "wm8904 @ AT91SAM9N12EK";
+
+	atmel,audio-routing =
+		"Headphone Jack", "HPOUTL",
+		"Headphone Jack", "HPOUTR",
+		"IN2L", "Line In Jack",
+		"IN2R", "Line In Jack",
+		"Mic", "MICBIAS",
+		"IN1L", "Mic";
+
+	atmel,ssc-controller = <&ssc0>;
+	atmel,audio-codec = <&wm8904>;
+};
diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 1c0b185..986323b 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -33,6 +33,16 @@ config SND_AT91_SOC_SAM9G20_WM8731
 	  Say Y if you want to add support for SoC audio on WM8731-based
 	  AT91sam9g20 evaluation board.
 
+config SND_ATMEL_SOC_WM8904
+	tristate "Atmel ASoC driver for boards using WM8904 codec"
+	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_ATMEL_SOC_DMA
+	select SND_SOC_WM8904
+	help
+	  Say Y if you want to add support for Atmel ASoC driver for boards using
+	  WM8904 codec.
+
 config SND_AT91_SOC_AFEB9260
 	tristate "SoC Audio support for AFEB9260 board"
 	depends on ARCH_AT91 && ATMEL_SSC && ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index 41967cc..922d4da 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
 
 # AT91 Machine Support
 snd-soc-sam9g20-wm8731-objs := sam9g20_wm8731.o
+snd-atmel-soc-wm8904-objs := atmel_wm8904.o
 
 obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
+obj-$(CONFIG_SND_ATMEL_SOC_WM8904) += snd-atmel-soc-wm8904.o
 obj-$(CONFIG_SND_AT91_SOC_AFEB9260) += snd-soc-afeb9260.o
diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
new file mode 100644
index 0000000..e309607
--- /dev/null
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -0,0 +1,263 @@
+/*
+ * atmel_wm8904 - Atmel ASoC driver for boards with WM8904 codec.
+ *
+ * Copyright (C) 2012 Atmel
+ *
+ * Author: Bo Shen <voice.shen@atmel.com>
+ *
+ * GPLv2 or later
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+
+#include <sound/soc.h>
+
+#include "../codecs/wm8904.h"
+#include "atmel_ssc_dai.h"
+
+#define MCLK_RATE 32768
+
+static struct clk *mclk;
+
+static const struct snd_soc_dapm_widget atmel_asoc_wm8904_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_LINE("Line In Jack", NULL),
+};
+
+static int atmel_asoc_wm8904_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8904_CLK_FLL,
+			12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		pr_err("%s -failed to set wm8904 SYSCLK\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int atmel_asoc_wm8904_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_pll(codec_dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
+		32768, params_rate(params) * 256);
+	if (ret < 0) {
+		pr_err("%s - failed to set wm8904 codec PLL.", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops atmel_asoc_wm8904_ops = {
+	.hw_params = atmel_asoc_wm8904_params,
+};
+
+static int atmel_set_bias_level(struct snd_soc_card *card,
+		struct snd_soc_dapm_context *dapm,
+		enum snd_soc_bias_level level)
+{
+	static int mclk_on;
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		if (!mclk_on) {
+			ret = clk_prepare_enable(mclk);
+			if (ret == 0)
+				mclk_on = 1;
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_OFF:
+		if (mclk_on)
+			clk_disable_unprepare(mclk);
+		mclk_on = 0;
+		break;
+	}
+
+	return ret;
+};
+
+static struct snd_soc_dai_link atmel_asoc_wm8904_dailink = {
+	.name = "WM8904",
+	.stream_name = "WM8904 PCM",
+	.codec_dai_name = "wm8904-hifi",
+	.dai_fmt = SND_SOC_DAIFMT_I2S
+		| SND_SOC_DAIFMT_NB_NF
+		| SND_SOC_DAIFMT_CBM_CFM,
+	.init = atmel_asoc_wm8904_init,
+	.ops = &atmel_asoc_wm8904_ops,
+};
+
+static struct snd_soc_card atmel_asoc_wm8904_card = {
+	.name = "atmel_asoc_wm8904",
+	.owner = THIS_MODULE,
+	.set_bias_level = atmel_set_bias_level,
+	.dai_link = &atmel_asoc_wm8904_dailink,
+	.num_links = 1,
+	.dapm_widgets = atmel_asoc_wm8904_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(atmel_asoc_wm8904_dapm_widgets),
+	.fully_routed = true,
+};
+
+static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *codec_np, *cpu_np;
+	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
+	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
+	int ret;
+
+	if (!np)
+		return -1;
+
+	ret = snd_soc_of_parse_card_name(card, "atmel,model");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to parse card name\n");
+		return ret;
+	}
+
+	ret = snd_soc_of_parse_audio_routing(card, "atmel,audio-routing");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to parse audio routing\n");
+		return ret;
+	}
+
+	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
+	if (!cpu_np) {
+		dev_err(&pdev->dev, "failed to get dai and pcm info\n");
+		ret = -EINVAL;
+		return ret;
+	}
+	dailink->cpu_of_node = cpu_np;
+	dailink->platform_of_node = cpu_np;
+	of_node_put(cpu_np);
+
+	codec_np = of_parse_phandle(np, "atmel,audio-codec", 0);
+	if (!codec_np) {
+		dev_err(&pdev->dev, "failed to get codec info\n");
+		ret = -EINVAL;
+		return ret;
+	}
+	dailink->codec_of_node = codec_np;
+	of_node_put(codec_np);
+
+	return 0;
+}
+
+static int atmel_asoc_wm8904_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
+	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
+	struct clk *clk_src;
+	struct pinctrl *pinctrl;
+	int id, ret;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(&pdev->dev, "failed to request pinctrl\n");
+		return PTR_ERR(pinctrl);
+	}
+
+	card->dev = &pdev->dev;
+	ret = atmel_asoc_wm8904_dt_init(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init dt info\n");
+		goto err_set_audio;
+	}
+
+	id = of_alias_get_id((struct device_node *)dailink->cpu_of_node, "ssc");
+	ret = atmel_ssc_set_audio(id);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "failed to set SSC 0 for audio\n");
+		return ret;
+	}
+
+	mclk = clk_get(NULL, "pck0");
+	if (IS_ERR(mclk)) {
+		dev_err(&pdev->dev, "failed to get pck0\n");
+		ret = PTR_ERR(mclk);
+		goto err_set_audio;
+	}
+
+	clk_src = clk_get(NULL, "clk32k");
+	if (IS_ERR(clk_src)) {
+		dev_err(&pdev->dev, "failed to get clk32k\n");
+		ret = PTR_ERR(clk_src);
+		goto err_set_audio;
+	}
+
+	ret = clk_set_parent(mclk, clk_src);
+	clk_put(clk_src);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "failed to set MCLK parent\n");
+		goto err_set_audio;
+	}
+
+	dev_info(&pdev->dev, "setting pck0 to %dHz\n", MCLK_RATE);
+	clk_set_rate(mclk, MCLK_RATE);
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed\n");
+		goto err_set_audio;
+	}
+
+	return 0;
+
+err_set_audio:
+	atmel_ssc_put_audio(0);
+	return ret;
+}
+
+static int atmel_asoc_wm8904_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
+	int id;
+
+	id = of_alias_get_id((struct device_node *)dailink->cpu_of_node, "ssc");
+
+	snd_soc_unregister_card(card);
+	atmel_ssc_put_audio(id);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_asoc_wm8904_dt_ids[] = {
+	{ .compatible = "atmel,asoc-wm8904", },
+	{ }
+};
+#endif
+
+static struct platform_driver atmel_asoc_wm8904_driver = {
+	.driver = {
+		.name = "atmel-wm8904-audio",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(atmel_asoc_wm8904_dt_ids),
+	},
+	.probe = atmel_asoc_wm8904_probe,
+	.remove = atmel_asoc_wm8904_remove,
+};
+
+module_platform_driver(atmel_asoc_wm8904_driver);
+
+/* Module information */
+MODULE_AUTHOR("Bo Shen <voice.shen@atmel.com>");
+MODULE_DESCRIPTION("ALSA SoC machine driver for Atmel EK with WM8904 codec");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
