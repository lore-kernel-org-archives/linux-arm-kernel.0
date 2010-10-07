From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 07 Oct 2010 13:50:26 +1300
Subject: [PATCH 2/2] ASoC: EDB93xx machine sound driver
In-Reply-To: <4CAD16A5.1090501@bluewatersys.com>
References: <4CAD16A5.1090501@bluewatersys.com>
Message-ID: <4CAD1952.9030702@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Added support for EDB93xx sound with CS4271 codec.
Features:
   Playback, Capture
  Sample rates from 8kHz to 96kHz tested
Limitations:
  Depends on ALSA auto sample format conversion
  No DAPM support

Applies on: 2.6.36-rc6

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

---

 arch/arm/mach-ep93xx/edb93xx.c |   46 +++++++++
 sound/soc/ep93xx/Kconfig       |    9 ++
 sound/soc/ep93xx/Makefile      |    5 +
 sound/soc/ep93xx/edb93xx.c     |  205 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 265 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index c2ce903..1b24203 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -30,12 +30,19 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
+#include <mach/ep93xx_spi.h>
 
 #include <mach/hardware.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#define edb93xx_has_audio() (machine_is_edb9301() ||	\
+			     machine_is_edb9302() ||	\
+			     machine_is_edb9302a() ||	\
+			     machine_is_edb9307a() ||	\
+			     machine_is_edb9315a())
 
 static void __init edb93xx_register_flash(void)
 {
@@ -93,6 +100,43 @@ static void __init edb93xx_register_i2c(void)
 
 
 /*************************************************************************
+ * EDB93xx SPI peripheral handling
+ *************************************************************************/
+static struct spi_board_info edb93xx_spi_board_info[] = {
+	{
+		.modalias		= "cs4271",
+		.max_speed_hz		= 6000000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+		.mode			= SPI_MODE_3,
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
@@ -117,6 +161,8 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_flash();
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
+	edb93xx_register_spi();
+	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 }
 
diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
index f617f56..22cb673 100644
--- a/sound/soc/ep93xx/Kconfig
+++ b/sound/soc/ep93xx/Kconfig
@@ -16,3 +16,12 @@ config SND_EP93XX_SOC_SNAPPERCL15
         help
           Say Y or M here if you want to add support for I2S audio on the
           Bluewater Systems Snapper CL15 module.
+
+config SND_EP93XX_SOC_EDB93XX
+        tristate "SoC Audio support for Cirrus Logic EDB93xx boards"
+        depends on SND_EP93XX_SOC && (MACH_EDB9301 || MACH_EDB9302 || MACH_EDB9302A || MACH_EDB9307A || MACH_EDB9315A)
+        select SND_EP93XX_SOC_I2S
+        select SND_SOC_CS4271
+        help
+          Say Y or M here if you want to add support for I2S audio on the
+          Cirrus Logic EDB93xx boards.
diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
index 272e60f..4f62ad8 100644
--- a/sound/soc/ep93xx/Makefile
+++ b/sound/soc/ep93xx/Makefile
@@ -9,3 +9,8 @@ obj-$(CONFIG_SND_EP93XX_SOC_I2S)		+= snd-soc-ep93xx-i2s.o
 snd-soc-snappercl15-objs			:= snappercl15.o
 
 obj-$(CONFIG_SND_EP93XX_SOC_SNAPPERCL15)	+= snd-soc-snappercl15.o
+
+# EDB93XX Machine Support
+snd-soc-edb93xx-objs				:= edb93xx.o
+
+obj-$(CONFIG_SND_EP93XX_SOC_EDB93XX)		+= snd-soc-edb93xx.o
diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
new file mode 100644
index 0000000..dfb78d2
--- /dev/null
+++ b/sound/soc/ep93xx/edb93xx.c
@@ -0,0 +1,205 @@
+/*
+ * edb93xx.c -- SoC audio for EDB93xx
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+#include "../codecs/cs4271.h"
+#include "ep93xx-pcm.h"
+#include "ep93xx-i2s.h"
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
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
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
+/*
+ * This function enables all possible sample rates before and
+ * after actual playback, cause we use variable MCLK.
+ */
+static int edb93xx_startup_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	return snd_soc_dai_set_sysclk(codec_dai, 0, 0, SND_SOC_CLOCK_IN);
+}
+
+void edb93xx_shutdown(struct snd_pcm_substream *substream)
+{
+	edb93xx_startup_shutdown(substream);
+}
+
+static struct snd_soc_ops edb93xx_ops = {
+	.hw_params	= edb93xx_hw_params,
+	.startup	= edb93xx_startup_shutdown,
+	.shutdown	= edb93xx_shutdown,
+};
+
+static struct snd_soc_dai_link edb93xx_dai = {
+	.name		= "CS4271",
+	.stream_name	= "CS4271",
+	.cpu_dai	= &ep93xx_i2s_dai,
+	.codec_dai	= &cs4271_dai,
+	.ops		= &edb93xx_ops,
+};
+
+static struct snd_soc_card snd_soc_edb93xx = {
+	.name		= "EDB93XX",
+	.platform	= &ep93xx_soc_platform,
+	.dai_link	= &edb93xx_dai,
+	.num_links	= 1,
+};
+
+static struct snd_soc_device edb93xx_snd_devdata = {
+	.card		= &snd_soc_edb93xx,
+	.codec_dev	= &soc_codec_device_cs4271,
+};
+
+static struct platform_device *edb93xx_snd_device;
+
+static int __init edb93xx_enable_cs4271(void)
+{
+	int ret;
+	if (!edb93xx_has_audio()) 
+		return -ENODEV;
+
+	ret = gpio_request(EP93XX_GPIO_LINE_EGPIO6, "CS4271 SFRM1 Disable");
+	if (ret)
+		return ret;
+	ret = gpio_direction_output(EP93XX_GPIO_LINE_EGPIO6, 0);
+	if (ret)
+		goto free_EGPIO6;
+
+	ret = gpio_request(EP93XX_GPIO_LINE_EGPIO1, "CS4271 Reset");
+	if (ret)
+		goto free_EGPIO6;
+	ret = gpio_direction_output(EP93XX_GPIO_LINE_EGPIO1, 1);
+	if (ret)
+		goto free_EGPIO1;
+	
+	/* Give the codec time to wake up */
+	udelay(1);
+	return 0;
+
+free_EGPIO1:
+	gpio_free(EP93XX_GPIO_LINE_EGPIO1);
+free_EGPIO6:
+	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
+	return ret;
+}
+
+static void __exit edb93xx_disable_cs4271(void)
+{
+	/* Set codec to the reset state */
+	gpio_set_value(EP93XX_GPIO_LINE_EGPIO1, 0);
+	gpio_free(EP93XX_GPIO_LINE_EGPIO1);
+	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
+}
+
+static int __init edb93xx_init(void)
+{
+	int ret;
+
+	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
+				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
+				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
+	if (ret)
+		return ret;
+
+	ret = edb93xx_enable_cs4271();
+	if (ret)
+		goto free_i2s;
+
+	ret = -ENOMEM;
+	edb93xx_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!edb93xx_snd_device)
+		goto free_i2s;
+
+	platform_set_drvdata(edb93xx_snd_device, &edb93xx_snd_devdata);
+	edb93xx_snd_devdata.dev = &edb93xx_snd_device->dev;
+	ret = platform_device_add(edb93xx_snd_device);
+	if (ret)
+		goto device_put;
+
+	pr_info("EDB93xx Machine ALSA Driver\n");
+	return 0;
+
+device_put:
+	platform_device_put(edb93xx_snd_device);
+free_i2s:
+	ep93xx_i2s_release();
+	return ret;
+}
+
+static void __exit edb93xx_exit(void)
+{
+	platform_device_unregister(edb93xx_snd_device);
+	edb93xx_disable_cs4271();
+	ep93xx_i2s_release();
+}
+
+module_init(edb93xx_init);
+module_exit(edb93xx_exit);
+
+MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
+MODULE_DESCRIPTION("ALSA SoC EDB93xx");
+MODULE_LICENSE("GPL");
