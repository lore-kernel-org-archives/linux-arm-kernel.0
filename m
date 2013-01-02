From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:50 -0800
Subject: [PATCH 13/26] ARM: S3C24XX: make h1940.h and h1940-latch.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-14-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers can be local in mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/h1940-bluetooth.c            |    6 ++--
 .../{include/mach/h1940-latch.h => h1940.h}        |   22 ++++++++----
 arch/arm/mach-s3c24xx/include/mach/h1940.h         |   24 --------------
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   35 +++++++++-----------
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   32 +++++++++---------
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   16 ++++-----
 arch/arm/mach-s3c24xx/pm-s3c2410.c                 |    6 ++--
 sound/soc/samsung/h1940_uda1380.c                  |   13 ++++----
 8 files changed, 68 insertions(+), 86 deletions(-)
 rename arch/arm/mach-s3c24xx/{include/mach/h1940-latch.h => h1940.h} (70%)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/h1940.h

diff --git a/arch/arm/mach-s3c24xx/h1940-bluetooth.c b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
index 57aee91..93bdb92 100644
--- a/arch/arm/mach-s3c24xx/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
@@ -19,10 +19,10 @@
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
 
-#include <mach/regs-gpio.h>
 #include <mach/hardware.h>
-#include <mach/h1940-latch.h>
-#include <mach/h1940.h>
+#include <mach/regs-gpio.h>
+
+#include "h1940.h"
 
 #define DRV_NAME "h1940-bt"
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/h1940-latch.h b/arch/arm/mach-s3c24xx/h1940.h
similarity index 70%
rename from arch/arm/mach-s3c24xx/include/mach/h1940-latch.h
rename to arch/arm/mach-s3c24xx/h1940.h
index fc897d3..2950cc4 100644
--- a/arch/arm/mach-s3c24xx/include/mach/h1940-latch.h
+++ b/arch/arm/mach-s3c24xx/h1940.h
@@ -1,20 +1,30 @@
-/* arch/arm/mach-s3c2410/include/mach/h1940-latch.h
+/*
+ * Copyright 2006 Ben Dooks <ben-linux@fluff.org>
  *
  * Copyright (c) 2005 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
- *  iPAQ H1940 series - latch definitions
+ * iPAQ H1940 series definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARCH_H1940_LATCH_H
-#define __ASM_ARCH_H1940_LATCH_H
+#ifndef __MACH_S3C24XX_H1940_H
+#define __MACH_S3C24XX_H1940_H __FILE__
 
-#include <asm/gpio.h>
+#define H1940_SUSPEND_CHECKSUM		(0x30003ff8)
+#define H1940_SUSPEND_RESUMEAT		(0x30081000)
+#define H1940_SUSPEND_CHECK		(0x30080000)
+
+extern void h1940_pm_return(void);
+extern int h1940_led_blink_set(unsigned gpio, int state,
+			       unsigned long *delay_on,
+			       unsigned long *delay_off);
+
+#include <linux/gpio.h>
 
 #define H1940_LATCH_GPIO(x)		(S3C_GPIO_END + (x))
 
@@ -40,4 +50,4 @@
 #define H1940_LATCH_LED_GREEN		H1940_LATCH_GPIO(14)
 #define H1940_LATCH_LED_FLASH		H1940_LATCH_GPIO(15)
 
-#endif /* __ASM_ARCH_H1940_LATCH_H */
+#endif /* __MACH_S3C24XX_H1940_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/h1940.h b/arch/arm/mach-s3c24xx/include/mach/h1940.h
deleted file mode 100644
index 2aa683c..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/h1940.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/h1940.h
- *
- * Copyright 2006 Ben Dooks <ben-linux@fluff.org>
- *
- * H1940 definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_H1940_H
-#define __ASM_ARCH_H1940_H
-
-#define H1940_SUSPEND_CHECKSUM		(0x30003ff8)
-#define H1940_SUSPEND_RESUMEAT		(0x30081000)
-#define H1940_SUSPEND_CHECK		(0x30080000)
-
-extern void h1940_pm_return(void);
-extern int h1940_led_blink_set(unsigned gpio, int state,
-	unsigned long *delay_on, unsigned long *delay_off);
-
-
-#endif /* __ASM_ARCH_H1940_H */
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index e208dda..afc05a7 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2410/mach-h1940.c
- *
+/*
  * Copyright (c) 2003-2005 Simtec Electronics
  *   Ben Dooks <ben@simtec.co.uk>
  *
@@ -37,38 +36,36 @@
 #include <linux/mmc/host.h>
 #include <linux/export.h>
 
+#include <asm/irq.h>
+#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/mach-types.h>
-
-#include <plat/regs-serial.h>
-#include <mach/regs-lcd.h>
-#include <mach/regs-clock.h>
+#include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/mmc-s3cmci.h>
+#include <linux/platform_data/touchscreen-s3c2410.h>
+#include <linux/platform_data/usb-s3c2410_udc.h>
 
-#include <mach/regs-gpio.h>
+#include <sound/uda1380.h>
 
-#include <mach/h1940.h>
-#include <mach/h1940-latch.h>
 #include <mach/fb.h>
-#include <linux/platform_data/usb-s3c2410_udc.h>
-#include <linux/platform_data/i2c-s3c2410.h>
+#include <mach/hardware.h>
+#include <mach/regs-clock.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-lcd.h>
 
-#include <plat/gpio-cfg.h>
 #include <plat/clock.h>
-#include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/gpio-cfg.h>
 #include <plat/pll.h>
 #include <plat/pm.h>
-#include <linux/platform_data/mmc-s3cmci.h>
-#include <linux/platform_data/touchscreen-s3c2410.h>
+#include <plat/regs-serial.h>
 
-#include <sound/uda1380.h>
 
 #include "common.h"
+#include "h1940.h"
 
 #define H1940_LATCH		((void __force __iomem *)0xF8000000)
 
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 0606f2f..bdcfb8b 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2440/mach-rx1950.c
- *
+/*
  * Copyright (c) 2006-2009 Victor Chukhantsev, Denis Grigoriev,
  * Copyright (c) 2007-2010 Vasily Khoruzhick
  *
@@ -37,31 +36,32 @@
 
 #include <linux/mmc/host.h>
 
+#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach-types.h>
 
+#include <linux/platform_data/i2c-s3c2410.h>
+#include <linux/platform_data/mmc-s3cmci.h>
+#include <linux/platform_data/mtd-nand-s3c2410.h>
+#include <linux/platform_data/touchscreen-s3c2410.h>
+#include <linux/platform_data/usb-s3c2410_udc.h>
+
+#include <sound/uda1380.h>
+
+#include <mach/fb.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
-#include <mach/h1940.h>
-#include <mach/fb.h>
 
 #include <plat/clock.h>
-#include <plat/regs-serial.h>
-#include <plat/regs-iic.h>
-#include <linux/platform_data/mmc-s3cmci.h>
-#include <linux/platform_data/usb-s3c2410_udc.h>
-#include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/pm.h>
+#include <plat/devs.h>
 #include <plat/irq.h>
-#include <linux/platform_data/touchscreen-s3c2410.h>
-
-#include <sound/uda1380.h>
+#include <plat/pm.h>
+#include <plat/regs-iic.h>
+#include <plat/regs-serial.h>
 
 #include "common.h"
+#include "h1940.h"
 
 #define LCD_PWM_PERIOD 192960
 #define LCD_PWM_DUTY 127353
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index dacbb9a..b261dd3 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -31,27 +31,27 @@
 #include <linux/mtd/partitions.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/irq.h>
+#include <asm/mach/map.h>
+
+#include <linux/platform_data/mtd-nand-s3c2410.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <plat/regs-serial.h>
+#include <mach/fb.h>
+#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 
-#include <mach/h1940.h>
-#include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <mach/fb.h>
-
 #include <plat/clock.h>
-#include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
 #include <plat/pm.h>
+#include <plat/regs-serial.h>
 
 #include "common.h"
+#include "h1940.h"
 
 static struct map_desc rx3715_iodesc[] __initdata = {
 	/* dump ISA space somewhere unused */
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2410.c b/arch/arm/mach-s3c24xx/pm-s3c2410.c
index 949ae05..2d82c4f 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2410.c
@@ -29,16 +29,16 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-
 #include <asm/mach-types.h>
 
+#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
-#include <mach/h1940.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
+#include "h1940.h"
+
 static void s3c2410_pm_prepare(void)
 {
 	/* ensure at least GSTATUS3 has the resume address */
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 3870e96..15a3817 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -21,7 +21,6 @@
 #include <sound/jack.h>
 
 #include <plat/regs-iis.h>
-#include <mach/h1940-latch.h>
 #include <asm/mach-types.h>
 
 #include "s3c24xx-i2s.h"
@@ -147,9 +146,9 @@ static int h1940_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpio_set_value(H1940_LATCH_AUDIO_POWER, 1);
+		gpio_set_value(S3C_GPIO_END + 9, 1);
 	else
-		gpio_set_value(H1940_LATCH_AUDIO_POWER, 0);
+		gpio_set_value(S3C_GPIO_END + 9, 0);
 
 	return 0;
 }
@@ -233,11 +232,11 @@ static int __init h1940_init(void)
 		return -ENODEV;
 
 	/* configure some gpios */
-	ret = gpio_request(H1940_LATCH_AUDIO_POWER, "speaker-power");
+	ret = gpio_request(S3C_GPIO_END + 9, "speaker-power");
 	if (ret)
 		goto err_out;
 
-	ret = gpio_direction_output(H1940_LATCH_AUDIO_POWER, 0);
+	ret = gpio_direction_output(S3C_GPIO_END + 9, 0);
 	if (ret)
 		goto err_gpio;
 
@@ -258,7 +257,7 @@ static int __init h1940_init(void)
 err_plat:
 	platform_device_put(s3c24xx_snd_device);
 err_gpio:
-	gpio_free(H1940_LATCH_AUDIO_POWER);
+	gpio_free(S3C_GPIO_END + 9);
 
 err_out:
 	return ret;
@@ -269,7 +268,7 @@ static void __exit h1940_exit(void)
 	platform_device_unregister(s3c24xx_snd_device);
 	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
 		hp_jack_gpios);
-	gpio_free(H1940_LATCH_AUDIO_POWER);
+	gpio_free(S3C_GPIO_END + 9);
 }
 
 module_init(h1940_init);
-- 
1.7.10.4
