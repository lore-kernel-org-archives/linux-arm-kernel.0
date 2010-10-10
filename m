From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 10 Oct 2010 20:10:43 +0300
Subject: [PATCHv2 4/4] ASoC: ep93xx: add Simplemachines Sim.One AC97 audio
	support
In-Reply-To: <cover.1286729843.git.mika.westerberg@iki.fi>
References: <cover.1286729843.git.mika.westerberg@iki.fi>
Message-ID: <40ef3fcc1c040d4432c0d2fec26d210ce888737d.1286729843.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AC97 audio support for Simplemachines Sim.One board.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/simone.c |    1 +
 sound/soc/ep93xx/Kconfig      |    9 +++++
 sound/soc/ep93xx/Makefile     |    2 +
 sound/soc/ep93xx/simone.c     |   80 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ep93xx/simone.c

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 5dded58..f5f81f9 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -61,6 +61,7 @@ static void __init simone_init_machine(void)
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
+	ep93xx_register_ac97();
 }
 
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
index 4a9d236..4aa6087 100644
--- a/sound/soc/ep93xx/Kconfig
+++ b/sound/soc/ep93xx/Kconfig
@@ -22,3 +22,12 @@ config SND_EP93XX_SOC_SNAPPERCL15
         help
           Say Y or M here if you want to add support for I2S audio on the
           Bluewater Systems Snapper CL15 module.
+
+config SND_EP93XX_SOC_SIMONE
+	tristate "SoC Audio support for Simplemachines Sim.One board"
+	depends on SND_EP93XX_SOC && MACH_SIM_ONE
+	select SND_EP93XX_SOC_AC97
+	select SND_SOC_AC97_CODEC
+	help
+	  Say Y or M here if you want to add support for AC97 audio on the
+	  Simplemachines Sim.One board.
diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
index ac06e00..8e7977f 100644
--- a/sound/soc/ep93xx/Makefile
+++ b/sound/soc/ep93xx/Makefile
@@ -9,5 +9,7 @@ obj-$(CONFIG_SND_EP93XX_SOC_AC97)		+= snd-soc-ep93xx-ac97.o
 
 # EP93XX Machine Support
 snd-soc-snappercl15-objs			:= snappercl15.o
+snd-soc-simone-objs				:= simone.o
 
 obj-$(CONFIG_SND_EP93XX_SOC_SNAPPERCL15)	+= snd-soc-snappercl15.o
+obj-$(CONFIG_SND_EP93XX_SOC_SIMONE)		+= snd-soc-simone.o
diff --git a/sound/soc/ep93xx/simone.c b/sound/soc/ep93xx/simone.c
new file mode 100644
index 0000000..ed189c1
--- /dev/null
+++ b/sound/soc/ep93xx/simone.c
@@ -0,0 +1,80 @@
+/*
+ * simone.c -- ASoC audio for Simplemachines Sim.One board
+ *
+ * Copyright (c) 2010 Mika Westerberg
+ *
+ * Based on snappercl15 machine driver by Ryan Mallon.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+#include "../codecs/ac97.h"
+#include "ep93xx-pcm.h"
+#include "ep93xx-ac97.h"
+
+static struct snd_soc_dai_link simone_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.cpu_dai	= &ep93xx_ac97_dai,
+	.codec_dai	= &ac97_dai,
+};
+
+static struct snd_soc_card snd_soc_simone = {
+	.name		= "Sim.One",
+	.platform	= &ep93xx_soc_platform,
+	.dai_link	= &simone_dai,
+	.num_links	= 1,
+};
+
+static struct snd_soc_device simone_snd_devdata = {
+	.card = &snd_soc_simone,
+	.codec_dev = &soc_codec_dev_ac97,
+};
+
+static struct platform_device *simone_snd_device;
+
+static int __init simone_init(void)
+{
+	int ret;
+
+	if (!machine_is_sim_one())
+		return -ENODEV;
+
+	simone_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!simone_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(simone_snd_device, &simone_snd_devdata);
+	simone_snd_devdata.dev = &simone_snd_device->dev;
+
+	ret = platform_device_add(simone_snd_device);
+	if (ret)
+		platform_device_put(simone_snd_device);
+
+	return ret;
+}
+
+static void __exit simone_exit(void)
+{
+	platform_device_unregister(simone_snd_device);
+}
+
+module_init(simone_init);
+module_exit(simone_exit);
+
+MODULE_DESCRIPTION("ALSA SoC Simplemachines Sim.One");
+MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
