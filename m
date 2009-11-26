From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 26 Nov 2009 18:59:00 +0100
Subject: [PATCH 2/3] ALSA: ARM: add Raumfeld audio support
In-Reply-To: <1259258341-31114-2-git-send-email-daniel@caiaq.de>
References: <1259258341-31114-1-git-send-email-daniel@caiaq.de>
	<1259258341-31114-2-git-send-email-daniel@caiaq.de>
Message-ID: <1259258341-31114-3-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/pxa/Kconfig    |    9 +
 sound/soc/pxa/Makefile   |    2 +
 sound/soc/pxa/raumfeld.c |  416 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 427 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/raumfeld.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index dcb3181..9c3bfd9 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -117,6 +117,15 @@ config SND_SOC_ZYLONITE
 	  Say Y if you want to add support for SoC audio on the
 	  Marvell Zylonite reference platform.
 
+config SND_SOC_RAUMFELD
+	tristate "SoC Audio support Raumfeld audio adapter"
+	depends on SND_PXA2XX_SOC && (MACH_RAUMFELD_SPEAKER || MACH_RAUMFELD_CONNECTOR)
+	select SND_PXA_SOC_SSP
+	select SND_SOC_CS4270
+	select SND_SOC_AK4104
+	help
+	  Say Y if you want to add support for SoC audio on Raumfeld devices
+
 config SND_PXA2XX_SOC_MAGICIAN
 	tristate "SoC Audio support for HTC Magician"
 	depends on SND_PXA2XX_SOC && MACH_MAGICIAN
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 6e096b4..f3e08fd 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -23,6 +23,7 @@ snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
 snd-soc-imote2-objs := imote2.o
+snd-soc-raumfeld-objs := raumfeld.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
@@ -37,3 +38,4 @@ obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
+obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
new file mode 100644
index 0000000..45e3f1c
--- /dev/null
+++ b/sound/soc/pxa/raumfeld.c
@@ -0,0 +1,416 @@
+/*
+ * raumfeld_audio.c  --  SoC audio for Raumfeld audio devices
+ *
+ * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ * based on code from:
+ *
+ *    Wolfson Microelectronics PLC.
+ *    Openedhand Ltd.
+ *    Liam Girdwood <lrg@slimlogic.co.uk>
+ *    Richard Purdie <richard@openedhand.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/mfp-pxa3xx.h>
+#include <mach/mfp-pxa300.h>
+#include <asm/mach-types.h>
+
+#include "../codecs/cs4270.h"
+#include "../codecs/ak4104.h"
+#include "pxa2xx-pcm.h"
+#include "pxa-ssp.h"
+
+#define GPIO_SPDIF_RESET	MFP_PIN_GPIO38
+#define GPIO_MCLK_RESET		MFP_PIN_GPIO111
+#define GPIO_CODEC_RESET	MFP_PIN_GPIO120
+#define GPIO_AUDIO_VA_ENABLE	MFP_PIN_GPIO124
+
+static struct i2c_client *max9486_client;
+static struct i2c_board_info max9486_hwmon_info = {
+	I2C_BOARD_INFO("max9485", 0x63),
+};
+
+#define MAX9485_MCLK_FREQ_112896 0x22
+#define	MAX9485_MCLK_FREQ_122880 0x23
+
+static void set_max9485_clk(char clk)
+{
+	i2c_master_send(max9486_client, &clk, 1);
+}
+
+/* Fixed regulator for AUDIO_VA */
+
+static struct regulator_consumer_supply audio_va_consumer_supply =
+	REGULATOR_SUPPLY("va", "soc-audio.0");
+
+struct regulator_init_data audio_va_initdata = {
+	.consumer_supplies = &audio_va_consumer_supply,
+	.num_consumer_supplies = 1,
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config audio_va_config = {
+	.supply_name		= "audio_va",
+	.microvolts		= 5000000,
+	.gpio			= mfp_to_gpio(GPIO_AUDIO_VA_ENABLE),
+	.enable_high		= 1,
+	.enabled_at_boot	= 0,
+	.init_data		= &audio_va_initdata,
+};
+
+static struct platform_device audio_va_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &audio_va_config,
+	},
+};
+
+/* Dummy supplies for Codec's VD/VLC */
+
+static struct regulator_consumer_supply audio_dummy_supplies[] = {
+	REGULATOR_SUPPLY("vd", "soc-audio.0"),
+	REGULATOR_SUPPLY("vlc", "soc-audio.0"),
+};
+
+struct regulator_init_data audio_dummy_initdata = {
+	.consumer_supplies = audio_dummy_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(audio_dummy_supplies),
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config audio_dummy_config = {
+	.supply_name		= "audio_vd",
+	.microvolts		= 3300000,
+	.gpio			= -1,
+	.init_data		= &audio_dummy_initdata,
+};
+
+static struct platform_device audio_supply_dummy_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 1,
+	.dev	= {
+		.platform_data = &audio_dummy_config,
+	},
+};
+
+static struct platform_device *regulator_devices[] = {
+	&audio_va_device,
+	&audio_supply_dummy_device,
+};
+
+static void raumfeld_enable_audio(bool en)
+{
+	if (en) {
+		gpio_set_value(mfp_to_gpio(GPIO_MCLK_RESET), 1);
+
+		/* wait some time to let the clocks become stable */
+		msleep(100);
+
+		gpio_set_value(mfp_to_gpio(GPIO_SPDIF_RESET), 1);
+		gpio_set_value(mfp_to_gpio(GPIO_CODEC_RESET), 1);
+	} else {
+		gpio_set_value(mfp_to_gpio(GPIO_MCLK_RESET), 0);
+		gpio_set_value(mfp_to_gpio(GPIO_SPDIF_RESET), 0);
+		gpio_set_value(mfp_to_gpio(GPIO_CODEC_RESET), 0);
+	}
+}
+
+/* CS4270 */
+static int raumfeld_cs4270_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	set_max9485_clk(MAX9485_MCLK_FREQ_112896);
+
+	return snd_soc_dai_set_sysclk(codec_dai, 0, 11289600, 0);
+}
+
+static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int fmt, clk = 0;
+	int ret = 0;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		set_max9485_clk(MAX9485_MCLK_FREQ_122880);
+		clk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		set_max9485_clk(MAX9485_MCLK_FREQ_112896);
+		clk = 11289600;
+		break;
+	}
+
+	fmt = SND_SOC_DAIFMT_I2S |
+	      SND_SOC_DAIFMT_NB_NF |
+	      SND_SOC_DAIFMT_CBS_CFS;
+
+	/* setup the CODEC DAI */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk, 0);
+	if (ret < 0)
+		return ret;
+
+	/* setup the CPU DAI */
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, 0, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops raumfeld_cs4270_ops = {
+	.startup = raumfeld_cs4270_startup,
+	.hw_params = raumfeld_cs4270_hw_params,
+};
+
+static int raumfeld_line_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	raumfeld_enable_audio(false);
+	return 0;
+}
+
+static int raumfeld_line_resume(struct platform_device *pdev)
+{
+	raumfeld_enable_audio(true);
+	return 0;
+}
+
+static struct snd_soc_dai_link raumfeld_line_dai = {
+	.name		= "CS4270",
+	.stream_name	= "CS4270",
+	.cpu_dai	= &pxa_ssp_dai[PXA_DAI_SSP1],
+	.codec_dai	= &cs4270_dai,
+	.ops		= &raumfeld_cs4270_ops,
+};
+
+static struct snd_soc_card snd_soc_line_raumfeld = {
+	.name		= "Raumfeld analog",
+	.platform	= &pxa2xx_soc_platform,
+	.dai_link	= &raumfeld_line_dai,
+	.suspend_post	= raumfeld_line_suspend,
+	.resume_pre	= raumfeld_line_resume,
+	.num_links	= 1,
+};
+
+
+/* AK4104 */
+
+static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int fmt, ret = 0, clk = 0;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		set_max9485_clk(MAX9485_MCLK_FREQ_122880);
+		clk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		set_max9485_clk(MAX9485_MCLK_FREQ_112896);
+		clk = 11289600;
+		break;
+	}
+
+	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF;
+
+	/* setup the CODEC DAI */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* setup the CPU DAI */
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, 0, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops raumfeld_ak4104_ops = {
+	.hw_params = raumfeld_ak4104_hw_params,
+};
+
+static int raumfeld_ak4104_init(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static struct snd_soc_dai_link raumfeld_spdif_dai = {
+	.name		= "ak4104",
+	.stream_name	= "Playback",
+	.cpu_dai	= &pxa_ssp_dai[PXA_DAI_SSP2],
+	.codec_dai	= &ak4104_dai,
+	.init		= raumfeld_ak4104_init,
+	.ops		= &raumfeld_ak4104_ops,
+};
+
+static struct snd_soc_card snd_soc_spdif_raumfeld = {
+	.name		= "Raumfeld S/PDIF",
+	.platform	= &pxa2xx_soc_platform,
+	.dai_link	= &raumfeld_spdif_dai,
+	.num_links	= 1
+};
+
+/* raumfeld_audio audio subsystem */
+static struct snd_soc_device raumfeld_line_devdata = {
+	.card = &snd_soc_line_raumfeld,
+	.codec_dev = &soc_codec_device_cs4270,
+};
+
+static struct snd_soc_device raumfeld_spdif_devdata = {
+	.card = &snd_soc_spdif_raumfeld,
+	.codec_dev = &soc_codec_device_ak4104,
+};
+
+static struct platform_device *raumfeld_audio_line_device;
+static struct platform_device *raumfeld_audio_spdif_device;
+
+static int __init raumfeld_audio_init(void)
+{
+	int ret;
+
+	if (!machine_is_raumfeld_speaker() &&
+	    !machine_is_raumfeld_connector())
+		return 0;
+
+	max9486_client = i2c_new_device(i2c_get_adapter(0),
+					&max9486_hwmon_info);
+
+	if (!max9486_client)
+		return -ENOMEM;
+
+	set_max9485_clk(MAX9485_MCLK_FREQ_122880);
+
+	platform_add_devices(regulator_devices, ARRAY_SIZE(regulator_devices));
+
+	/* LINE */
+	raumfeld_audio_line_device = platform_device_alloc("soc-audio", 0);
+	if (!raumfeld_audio_line_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(raumfeld_audio_line_device,
+			     &raumfeld_line_devdata);
+	raumfeld_line_devdata.dev = &raumfeld_audio_line_device->dev;
+	ret = platform_device_add(raumfeld_audio_line_device);
+	if (ret)
+		platform_device_put(raumfeld_audio_line_device);
+
+	/* no S/PDIF on Speakers */
+	if (machine_is_raumfeld_speaker())
+		return ret;
+
+	/* S/PDIF */
+	raumfeld_audio_spdif_device = platform_device_alloc("soc-audio", 1);
+	if (!raumfeld_audio_spdif_device) {
+		platform_device_put(raumfeld_audio_line_device);
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(raumfeld_audio_spdif_device,
+			     &raumfeld_spdif_devdata);
+	raumfeld_spdif_devdata.dev = &raumfeld_audio_spdif_device->dev;
+	ret = platform_device_add(raumfeld_audio_spdif_device);
+	if (ret) {
+		platform_device_put(raumfeld_audio_line_device);
+		platform_device_put(raumfeld_audio_spdif_device);
+	}
+
+	raumfeld_enable_audio(true);
+
+	return ret;
+}
+
+static void __exit raumfeld_audio_exit(void)
+{
+	raumfeld_enable_audio(false);
+
+	platform_device_unregister(raumfeld_audio_line_device);
+
+	if (machine_is_raumfeld_connector())
+		platform_device_unregister(raumfeld_audio_spdif_device);
+
+	i2c_unregister_device(max9486_client);
+
+	platform_device_put(&audio_va_device);
+	platform_device_put(&audio_supply_dummy_device);
+
+	gpio_free(mfp_to_gpio(GPIO_MCLK_RESET));
+	gpio_free(mfp_to_gpio(GPIO_CODEC_RESET));
+	gpio_free(mfp_to_gpio(GPIO_SPDIF_RESET));
+}
+
+module_init(raumfeld_audio_init);
+module_exit(raumfeld_audio_exit);
+
+/* Module information */
+MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
+MODULE_DESCRIPTION("Raumfeld audio SoC");
+MODULE_LICENSE("GPL");
-- 
1.6.5.2
