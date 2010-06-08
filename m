From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  8 Jun 2010 22:01:12 +1200
Subject: [PATCH 3/3] EP93xx: Add Snapper CL15 i2s audio support
In-Reply-To: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1275991272-30122-4-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for i2s audio on Bluewater Systems Snapper CL15 module

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-ep93xx/snappercl15.c |    1 +
 sound/soc/ep93xx/Kconfig           |    9 ++
 sound/soc/ep93xx/Makefile          |    3 +
 sound/soc/ep93xx/snappercl15.c     |  150 ++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ep93xx/snappercl15.c

diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 51134b0..fee53a4 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -157,6 +157,7 @@ static void __init snappercl15_init_machine(void)
 	ep93xx_register_i2c(&snappercl15_i2c_gpio_data, snappercl15_i2c_data,
 			    ARRAY_SIZE(snappercl15_i2c_data));
 	ep93xx_register_fb(&snappercl15_fb_info);
+	ep93xx_register_i2s();
 	platform_device_register(&snappercl15_nand_device);
 }
 
diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
index ba66ac8..f617f56 100644
--- a/sound/soc/ep93xx/Kconfig
+++ b/sound/soc/ep93xx/Kconfig
@@ -7,3 +7,12 @@ config SND_EP93XX_SOC
 
 config SND_EP93XX_SOC_I2S
 	tristate
+
+config SND_EP93XX_SOC_SNAPPERCL15
+        tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
+        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15
+        select SND_EP93XX_SOC_I2S
+        select SND_SOC_TLV320AIC23
+        help
+          Say Y or M here if you want to add support for I2S audio on the
+          Bluewater Systems Snapper CL15 module.
diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
index 0239da3..272e60f 100644
--- a/sound/soc/ep93xx/Makefile
+++ b/sound/soc/ep93xx/Makefile
@@ -6,3 +6,6 @@ obj-$(CONFIG_SND_EP93XX_SOC)			+= snd-soc-ep93xx.o
 obj-$(CONFIG_SND_EP93XX_SOC_I2S)		+= snd-soc-ep93xx-i2s.o
 
 # EP93XX Machine Support
+snd-soc-snappercl15-objs			:= snappercl15.o
+
+obj-$(CONFIG_SND_EP93XX_SOC_SNAPPERCL15)	+= snd-soc-snappercl15.o
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
new file mode 100644
index 0000000..6495534
--- /dev/null
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -0,0 +1,150 @@
+/*
+ * snappercl15.c -- SoC audio for Bluewater Systems Snapper CL15 module
+ *
+ * Copyright (C) 2008 Bluewater Systems Ltd
+ * Author: Ryan Mallon <ryan@bluewatersys.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+#include "../codecs/tlv320aic23.h"
+#include "ep93xx-pcm.h"
+#include "ep93xx-i2s.h"
+
+#define CODEC_CLOCK 5644800
+
+static int snappercl15_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int err;
+
+	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+
+	err = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S | 
+				  SND_SOC_DAIFMT_NB_IF |		  
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, 
+				     SND_SOC_CLOCK_IN);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_sysclk(cpu_dai, 0, CODEC_CLOCK, 
+				     SND_SOC_CLOCK_OUT);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static struct snd_soc_ops snappercl15_ops = {
+	.hw_params	= snappercl15_hw_params,
+};
+
+static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	{"LLINEIN", NULL, "Line In"},
+	{"RLINEIN", NULL, "Line In"},
+
+	{"MICIN", NULL, "Mic Jack"},
+};
+
+static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	return 0;
+}
+
+static struct snd_soc_dai_link snappercl15_dai = {
+	.name		= "tlv320aic23",
+	.stream_name	= "AIC23",
+	.cpu_dai	= &ep93xx_i2s_dai,
+	.codec_dai	= &tlv320aic23_dai,
+	.init		= snappercl15_tlv320aic23_init,
+	.ops		= &snappercl15_ops,
+};
+
+static struct snd_soc_card snd_soc_snappercl15 = {
+	.name		= "Snapper CL15",
+	.platform	= &ep93xx_soc_platform,
+	.dai_link	= &snappercl15_dai,
+	.num_links	= 1,
+};
+
+static struct snd_soc_device snappercl15_snd_devdata = {
+	.card		= &snd_soc_snappercl15,
+	.codec_dev	= &soc_codec_dev_tlv320aic23,
+};
+
+static struct platform_device *snappercl15_snd_device;
+
+static int __init snappercl15_init(void)
+{
+	int ret;
+
+	if (!machine_is_snapper_cl15())
+		return -ENODEV;
+
+	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
+				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
+				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
+	if (ret)
+		return ret;
+
+	snappercl15_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!snappercl15_snd_device)
+		return -ENOMEM;
+	
+	platform_set_drvdata(snappercl15_snd_device, &snappercl15_snd_devdata);
+	snappercl15_snd_devdata.dev = &snappercl15_snd_device->dev;
+	ret = platform_device_add(snappercl15_snd_device);
+	if (ret)
+		platform_device_put(snappercl15_snd_device);
+
+	return ret;
+}
+
+static void __exit snappercl15_exit(void)
+{
+	platform_device_unregister(snappercl15_snd_device);
+	ep93xx_i2s_release();
+}
+
+module_init(snappercl15_init);
+module_exit(snappercl15_exit);
+
+MODULE_AUTHOR("Ryan Mallon <ryan@bluewatersys.com>");
+MODULE_DESCRIPTION("ALSA SoC Snapper CL15");
+MODULE_LICENSE("GPL");
+
-- 
1.6.0.4
