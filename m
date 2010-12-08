From: subaparts@yandex.ru (Alexander)
Date: Wed, 08 Dec 2010 15:03:54 +0300
Subject: [PATCH 3/3] ASoC: EDB93xx machine sound driver
Message-ID: <1291809834.31916.5.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Added support for EDB93xx sound with CS4271 codec.
Features:
- Playback, Capture
- Sample rates from 8kHz to 96kHz tested
Limitations:
- Depends on ALSA auto sample format conversion
- No DAPM support
        
Depends on: CS4271 SoC codec support patch, EP93xx IS2 and PCM fixes patch
        
Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 arch/arm/mach-ep93xx/edb93xx.c |   54 +++++++++++++++
 sound/soc/ep93xx/Kconfig       |    9 +++
 sound/soc/ep93xx/Makefile      |    2 +
 sound/soc/ep93xx/edb93xx.c     |  142 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 4b04316..f453e5a 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -30,12 +30,21 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
+#include <mach/ep93xx_spi.h>
 
 #include <mach/hardware.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <sound/cs4271.h>
+
+#define edb93xx_has_audio() (machine_is_edb9301() ||	\
+			     machine_is_edb9302() ||	\
+			     machine_is_edb9302a() ||	\
+			     machine_is_edb9307a() ||	\
+			     machine_is_edb9315a())
 
 static void __init edb93xx_register_flash(void)
 {
@@ -93,6 +102,49 @@ static void __init edb93xx_register_i2c(void)
 
 
 /*************************************************************************
+ * EDB93xx SPI peripheral handling
+ *************************************************************************/
+static struct cs4271_platform_data cs4271_edb93xx_gpio = {
+	.gpio_nreset	= EP93XX_GPIO_LINE_EGPIO1,
+	.gpio_disable	= EP93XX_GPIO_LINE_EGPIO6,
+};
+
+static struct spi_board_info edb93xx_spi_board_info[] = {
+	{
+		.modalias	= "cs4271-codec",
+		.max_speed_hz	= 6000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_3,
+		.platform_data	= &cs4271_edb93xx_gpio,
+	},
+};
+
+static struct ep93xx_spi_info edb93xx_spi_info = {
+	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_board_info),
+};
+
+static void __init edb93xx_register_spi(void)
+{
+	if (edb93xx_has_audio()) {
+		ep93xx_register_spi(&edb93xx_spi_info,
+				    edb93xx_spi_board_info,
+				    ARRAY_SIZE(edb93xx_spi_board_info));
+	}
+}
+
+/*************************************************************************
+ * EDB93xx I2S
+ *************************************************************************/
+static void __init edb93xx_register_i2s(void)
+{
+	if (edb93xx_has_audio()) {
+		ep93xx_register_i2s();
+	}
+}
+
+
+/*************************************************************************
  * EDB93xx pwm
  *************************************************************************/
 static void __init edb93xx_register_pwm(void)
@@ -117,6 +169,8 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_flash();
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
+	edb93xx_register_spi();
+	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 }
 
diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
index 5742904..91a28de 100644
--- a/sound/soc/ep93xx/Kconfig
+++ b/sound/soc/ep93xx/Kconfig
@@ -30,3 +30,12 @@ config SND_EP93XX_SOC_SIMONE
 	help
 	  Say Y or M here if you want to add support for AC97 audio on the
 	  Simplemachines Sim.One board.
+
+config SND_EP93XX_SOC_EDB93XX
+	tristate "SoC Audio support for Cirrus Logic EDB93xx boards"
+	depends on SND_EP93XX_SOC && (MACH_EDB9301 || MACH_EDB9302 || MACH_EDB9302A || MACH_EDB9307A || MACH_EDB9315A)
+	select SND_EP93XX_SOC_I2S
+	select SND_SOC_CS4271
+	help
+	  Say Y or M here if you want to add support for I2S audio on the
+	  Cirrus Logic EDB93xx boards.
diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
index 8e7977f..5514146 100644
--- a/sound/soc/ep93xx/Makefile
+++ b/sound/soc/ep93xx/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_SND_EP93XX_SOC_AC97)		+= snd-soc-ep93xx-ac97.o
 # EP93XX Machine Support
 snd-soc-snappercl15-objs			:= snappercl15.o
 snd-soc-simone-objs				:= simone.o
+snd-soc-edb93xx-objs				:= edb93xx.o
 
 obj-$(CONFIG_SND_EP93XX_SOC_SNAPPERCL15)	+= snd-soc-snappercl15.o
 obj-$(CONFIG_SND_EP93XX_SOC_SIMONE)		+= snd-soc-simone.o
+obj-$(CONFIG_SND_EP93XX_SOC_EDB93XX)		+= snd-soc-edb93xx.o
diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
new file mode 100644
index 0000000..b270085
--- /dev/null
+++ b/sound/soc/ep93xx/edb93xx.c
@@ -0,0 +1,142 @@
+/*
+ * SoC audio for EDB93xx
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This driver support CS4271 codec being master or slave, working
+ * in control port mode, connected either via SPI or I2C.
+ * The data format accepted is I2S or left-justified.
+ * DAPM support not implemented.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include "ep93xx-pcm.h"
+
+#define edb93xx_has_audio() (machine_is_edb9301() ||	\
+			     machine_is_edb9302() ||	\
+			     machine_is_edb9302a() ||	\
+			     machine_is_edb9307a() ||	\
+			     machine_is_edb9315a())
+
+static int edb93xx_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int err;
+	unsigned int rate = params_rate(params);
+	/*
+	 * We set LRCLK equal to `rate' and SCLK = LRCLK * 64,
+	 * because our sample size is 32 bit * 2 channels.
+	 * I2S standard permits us to transmit more bits than
+	 * the codec uses.
+	 * MCLK = SCLK * 4 is the best recommended value,
+	 * but we have to fall back to ratio 2 for higher
+	 * sample rates.
+	 */
+	unsigned int mclk_rate = rate * 64 * ((rate <= 48000) ? 4 : 2);
+
+	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk_rate,
+				     SND_SOC_CLOCK_IN);
+	if (err)
+		return err;
+
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, mclk_rate,
+				      SND_SOC_CLOCK_OUT);
+}
+
+static struct snd_soc_ops edb93xx_ops = {
+	.hw_params	= edb93xx_hw_params,
+};
+
+static struct snd_soc_dai_link edb93xx_dai = {
+	.name		= "CS4271",
+	.stream_name	= "CS4271 HiFi",
+	.platform_name	= "ep93xx-pcm-audio",
+	.cpu_dai_name	= "ep93xx-i2s",
+	.codec_name	= "spi0.0",
+	.codec_dai_name	= "cs4271-hifi",
+	.ops		= &edb93xx_ops,
+};
+
+static struct snd_soc_card snd_soc_edb93xx = {
+	.name		= "EDB93XX",
+	.dai_link	= &edb93xx_dai,
+	.num_links	= 1,
+};
+
+static struct platform_device *edb93xx_snd_device;
+
+static int __init edb93xx_init(void)
+{
+	int ret;
+
+	if (!edb93xx_has_audio())
+		return -ENODEV;
+
+	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
+				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
+				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
+	if (ret)
+		return ret;
+
+	edb93xx_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!edb93xx_snd_device) {
+		ret = -ENOMEM;
+		goto free_i2s;
+	}
+
+	platform_set_drvdata(edb93xx_snd_device, &snd_soc_edb93xx);
+	ret = platform_device_add(edb93xx_snd_device);
+	if (ret)
+		goto device_put;
+
+	return 0;
+
+device_put:
+	platform_device_put(edb93xx_snd_device);
+free_i2s:
+	ep93xx_i2s_release();
+	return ret;
+}
+module_init(edb93xx_init);
+
+static void __exit edb93xx_exit(void)
+{
+	platform_device_unregister(edb93xx_snd_device);
+	ep93xx_i2s_release();
+}
+module_exit(edb93xx_exit);
+
+MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
+MODULE_DESCRIPTION("ALSA SoC EDB93xx");
+MODULE_LICENSE("GPL");
