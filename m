From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:49 -0800
Subject: [PATCH 12/26] ARM: S3C24XX: make gta02.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-13-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header can be local in mach-s3c24xx/ and sort out inclusions.
Accordingly, the GTA02_ macro in driver can be replaced.

Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/{include/mach => }/gta02.h |   14 +++--
 arch/arm/mach-s3c24xx/mach-gta02.c               |   59 ++++++++++------------
 sound/soc/samsung/neo1973_wm8753.c               |    8 +--
 3 files changed, 42 insertions(+), 39 deletions(-)
 rename arch/arm/mach-s3c24xx/{include/mach => }/gta02.h (53%)

diff --git a/arch/arm/mach-s3c24xx/include/mach/gta02.h b/arch/arm/mach-s3c24xx/gta02.h
similarity index 53%
rename from arch/arm/mach-s3c24xx/include/mach/gta02.h
rename to arch/arm/mach-s3c24xx/gta02.h
index 2173934..9430a71 100644
--- a/arch/arm/mach-s3c24xx/include/mach/gta02.h
+++ b/arch/arm/mach-s3c24xx/gta02.h
@@ -1,5 +1,13 @@
-#ifndef _GTA02_H
-#define _GTA02_H
+/*
+ * GTA02 header
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __MACH_S3C24XX_GTA02_H
+#define __MACH_S3C24XX_GTA02_H __FILE__
 
 #include <mach/regs-gpio.h>
 
@@ -12,4 +20,4 @@
 
 #define GTA02_IRQ_PCF50633	IRQ_EINT9
 
-#endif /* _GTA02_H */
+#endif /* __MACH_S3C24XX_GTA02_H */
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 973b87c..1053706 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-s3c2442/mach-gta02.c
- *
  * S3C2442 Machine Support for Openmoko GTA02 / FreeRunner.
  *
  * Copyright (C) 2006-2009 by Openmoko, Inc.
@@ -23,7 +21,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  * MA 02111-1307 USA
- *
  */
 
 #include <linux/kernel.h>
@@ -34,62 +31,60 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/s3c24xx.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
 
 #include <linux/mmc/host.h>
 
+#include <linux/mfd/pcf50633/adc.h>
+#include <linux/mfd/pcf50633/backlight.h>
+#include <linux/mfd/pcf50633/core.h>
+#include <linux/mfd/pcf50633/gpio.h>
+#include <linux/mfd/pcf50633/mbc.h>
+#include <linux/mfd/pcf50633/pmic.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/io.h>
 
-#include <linux/i2c.h>
 #include <linux/regulator/machine.h>
 
-#include <linux/mfd/pcf50633/core.h>
-#include <linux/mfd/pcf50633/mbc.h>
-#include <linux/mfd/pcf50633/adc.h>
-#include <linux/mfd/pcf50633/gpio.h>
-#include <linux/mfd/pcf50633/pmic.h>
-#include <linux/mfd/pcf50633/backlight.h>
-
-#include <linux/input.h>
-#include <linux/gpio_keys.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/s3c24xx.h>
 
+#include <asm/irq.h>
+#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <asm/irq.h>
-#include <asm/mach-types.h>
+#include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/mtd-nand-s3c2410.h>
+#include <linux/platform_data/touchscreen-s3c2410.h>
+#include <linux/platform_data/usb-ohci-s3c2410.h>
+#include <linux/platform_data/usb-s3c2410_udc.h>
 
-#include <mach/regs-irq.h>
-#include <mach/regs-gpio.h>
 #include <mach/fb.h>
-
-#include <linux/platform_data/usb-ohci-s3c2410.h>
-#include <mach/regs-mem.h>
 #include <mach/hardware.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-irq.h>
+#include <mach/regs-mem.h>
 
-#include <mach/gta02.h>
-
-#include <plat/regs-serial.h>
-#include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/pm.h>
-#include <linux/platform_data/usb-s3c2410_udc.h>
+#include <plat/devs.h>
 #include <plat/gpio-cfg.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/touchscreen-s3c2410.h>
+#include <plat/pm.h>
+#include <plat/regs-serial.h>
 
 #include "common.h"
+#include "gta02.h"
 
 static struct pcf50633 *gta02_pcf;
 
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index c7e965f..a301d8c 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -237,7 +237,7 @@ static int lm4853_set_spk(struct snd_kcontrol *kcontrol,
 {
 	gta02_speaker_enabled = ucontrol->value.integer.value[0];
 
-	gpio_set_value(GTA02_GPIO_HP_IN, !gta02_speaker_enabled);
+	gpio_set_value(S3C2410_GPJ(2), !gta02_speaker_enabled);
 
 	return 0;
 }
@@ -252,7 +252,7 @@ static int lm4853_get_spk(struct snd_kcontrol *kcontrol,
 static int lm4853_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(GTA02_GPIO_AMP_SHUT, SND_SOC_DAPM_EVENT_OFF(event));
+	gpio_set_value(S3C2410_GPJ(1), SND_SOC_DAPM_EVENT_OFF(event));
 
 	return 0;
 }
@@ -396,8 +396,8 @@ static struct snd_soc_codec_conf neo1973_codec_conf[] = {
 };
 
 static const struct gpio neo1973_gta02_gpios[] = {
-	{ GTA02_GPIO_HP_IN, GPIOF_OUT_INIT_HIGH, "GTA02_HP_IN" },
-	{ GTA02_GPIO_AMP_SHUT, GPIOF_OUT_INIT_HIGH, "GTA02_AMP_SHUT" },
+	{ S3C2410_GPJ(2), GPIOF_OUT_INIT_HIGH, "GTA02_HP_IN" },
+	{ S3C2410_GPJ(1), GPIOF_OUT_INIT_HIGH, "GTA02_AMP_SHUT" },
 };
 
 static struct snd_soc_card neo1973 = {
-- 
1.7.10.4
