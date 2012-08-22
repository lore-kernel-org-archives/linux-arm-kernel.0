From: dromede@gmail.com (dromede at gmail.com)
Date: Wed, 22 Aug 2012 19:27:04 +0200
Subject: [RFC][PATCH] Disintegrate sharpsl_param.c
Message-ID: <1345656424-31234-1-git-send-email-dromede@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede.gmail.com>


I recently tried running 3.6-rc2 kernel on my Sharp Zaurus C-1000. It 
hanged almost immediately after uncompressing the kernel. I tracked the
problem down to a single line in arch/arm/common/sharpsl_param.c:

memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct sharpsl_param_info));

Commenting out the line makes the kernel boot just fine. This left me
wondering whether sharpsl_param.c is actually needed. Here's a comment
from sharpsl_param.c that describes what sharpsl_param.c actually does:

/*
 * Certain hardware parameters determined at the time of device manufacture,
 * typically including LCD parameters are loaded by the bootloader at the
 * address PARAM_BASE. As the kernel will overwrite them, we need to store
 * them early in the boot process, then pass them to the appropriate drivers.
 * Not all devices use all parameters but the format is common to all.
 */
 
 So sharpsl_save_param() is supposed to fill the sharpsl_param_info struct
 with various parameters or fill some of the struct fields with -1. 
 I found only four drivers that use some of these
 parameters (only two parameters are used by these drivers, comadj and phadadj). 
 These drivers are:
 
 drivers/video/backlight/corgi_lcd.c
 drivers/video/backlight/locomolcd.c
 drivers/video/backlight/tosa_bl.c
 drivers/video/backlight/tosa_lcd.c
 
 These drivers also have default values when comadj or phadadj == -1.
 I checked what values are actually contained in this struct in
 earlier kernels. 3.2.24 kernel is the latest one i know of where
 sharpsl_save_param() works properly. And it also has these fields initialised
 to -1.
 
 So it seems to me that sharpsl_param.c is redundant as it currently only  
 serves to assign -1 to a few variables. And drivers that use these variables
 then handle -1 with assigning default values.
 
 I propose a patch that completely removes the usage of sharpsl_param.c.
 I confirm that this patch works fine on a C-1000 and therefore i assume that
 it should work fine on all machines that use the corgi_lcd.c driver.
 
 This patch should be tested on collie and tosa machines.

---
 arch/arm/common/Kconfig                   |    3 -
 arch/arm/common/Makefile                  |    1 -
 arch/arm/common/sharpsl_param.c           |   62 -----------------------------
 arch/arm/include/asm/mach/sharpsl_param.h |   37 -----------------
 arch/arm/mach-pxa/Kconfig                 |    1 -
 arch/arm/mach-pxa/corgi.c                 |    2 -
 arch/arm/mach-pxa/poodle.c                |    2 -
 arch/arm/mach-pxa/spitz.c                 |    2 -
 arch/arm/mach-pxa/tosa.c                  |    2 -
 arch/arm/mach-sa1100/Kconfig              |    1 -
 arch/arm/mach-sa1100/collie.c             |    2 -
 drivers/power/collie_battery.c            |    1 -
 drivers/video/backlight/corgi_lcd.c       |    9 +---
 drivers/video/backlight/locomolcd.c       |    8 +--
 drivers/video/backlight/tosa_bl.c         |    4 +-
 drivers/video/backlight/tosa_lcd.c        |    2 -
 16 files changed, 6 insertions(+), 133 deletions(-)
 delete mode 100644 arch/arm/common/sharpsl_param.c
 delete mode 100644 arch/arm/include/asm/mach/sharpsl_param.h

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 283fa1d..8a2688a 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -35,8 +35,5 @@ config DMABOUNCE
 config SHARP_LOCOMO
 	bool
 
-config SHARP_PARAM
-	bool
-
 config SHARP_SCOOP
 	bool
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e8a4e58..c8634c8 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
 obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
-obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
diff --git a/arch/arm/common/sharpsl_param.c b/arch/arm/common/sharpsl_param.c
deleted file mode 100644
index d56c932..0000000
--- a/arch/arm/common/sharpsl_param.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Hardware parameter area specific to Sharp SL series devices
- *
- * Copyright (c) 2005 Richard Purdie
- *
- * Based on Sharp's 2.4 kernel patches
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <asm/mach/sharpsl_param.h>
-
-/*
- * Certain hardware parameters determined at the time of device manufacture,
- * typically including LCD parameters are loaded by the bootloader at the
- * address PARAM_BASE. As the kernel will overwrite them, we need to store
- * them early in the boot process, then pass them to the appropriate drivers.
- * Not all devices use all parameters but the format is common to all.
- */
-#ifdef CONFIG_ARCH_SA1100
-#define PARAM_BASE	0xe8ffc000
-#else
-#define PARAM_BASE	0xa0000a00
-#endif
-#define MAGIC_CHG(a,b,c,d) ( ( d << 24 ) | ( c << 16 )  | ( b << 8 ) | a )
-
-#define COMADJ_MAGIC	MAGIC_CHG('C','M','A','D')
-#define UUID_MAGIC	MAGIC_CHG('U','U','I','D')
-#define TOUCH_MAGIC	MAGIC_CHG('T','U','C','H')
-#define AD_MAGIC	MAGIC_CHG('B','V','A','D')
-#define PHAD_MAGIC	MAGIC_CHG('P','H','A','D')
-
-struct sharpsl_param_info sharpsl_param;
-EXPORT_SYMBOL(sharpsl_param);
-
-void sharpsl_save_param(void)
-{
-	memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct sharpsl_param_info));
-
-	if (sharpsl_param.comadj_keyword != COMADJ_MAGIC)
-		sharpsl_param.comadj=-1;
-
-	if (sharpsl_param.phad_keyword != PHAD_MAGIC)
-		sharpsl_param.phadadj=-1;
-
-	if (sharpsl_param.uuid_keyword != UUID_MAGIC)
-		sharpsl_param.uuid[0]=-1;
-
-	if (sharpsl_param.touch_keyword != TOUCH_MAGIC)
-		sharpsl_param.touch_xp=-1;
-
-	if (sharpsl_param.adadj_keyword != AD_MAGIC)
-		sharpsl_param.adadj=-1;
-}
-
-
diff --git a/arch/arm/include/asm/mach/sharpsl_param.h b/arch/arm/include/asm/mach/sharpsl_param.h
deleted file mode 100644
index 7a24ecf..0000000
--- a/arch/arm/include/asm/mach/sharpsl_param.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Hardware parameter area specific to Sharp SL series devices
- *
- * Copyright (c) 2005 Richard Purdie
- *
- * Based on Sharp's 2.4 kernel patches
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-struct sharpsl_param_info {
-  unsigned int comadj_keyword;
-  unsigned int comadj;
-
-  unsigned int uuid_keyword;
-  unsigned char uuid[16];
-
-  unsigned int touch_keyword;
-  unsigned int touch_xp;
-  unsigned int touch_yp;
-  unsigned int touch_xd;
-  unsigned int touch_yd;
-
-  unsigned int adadj_keyword;
-  unsigned int adadj;
-
-  unsigned int phad_keyword;
-  unsigned int phadadj;
-} __attribute__((packed));
-
-
-extern struct sharpsl_param_info sharpsl_param;
-extern void sharpsl_save_param(void);
-
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index fe2d1f8..71e9429 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -471,7 +471,6 @@ config MACH_RAUMFELD_SPEAKER
 config PXA_SHARPSL
 	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
 	select SHARP_SCOOP
-	select SHARP_PARAM
 	help
 	  Say Y here if you intend to run this kernel on a
 	  Sharp Zaurus SL-5600 (Poodle), SL-C700 (Corgi),
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index c1fe32d..1ddf87f 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -52,7 +52,6 @@
 #include <mach/corgi.h>
 #include <mach/sharpsl_pm.h>
 
-#include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/scoop.h>
 
 #include "generic.h"
@@ -716,7 +715,6 @@ static void __init corgi_init(void)
 static void __init fixup_corgi(struct tag *tags, char **cmdline,
 			       struct meminfo *mi)
 {
-	sharpsl_save_param();
 	mi->nr_banks=1;
 	mi->bank[0].start = 0xa0000000;
 	if (machine_is_corgi())
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 89d98c8..0c4c083 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -48,7 +48,6 @@
 
 #include <asm/hardware/scoop.h>
 #include <asm/hardware/locomo.h>
-#include <asm/mach/sharpsl_param.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -457,7 +456,6 @@ static void __init poodle_init(void)
 static void __init fixup_poodle(struct tag *tags, char **cmdline,
 				struct meminfo *mi)
 {
-	sharpsl_save_param();
 	mi->nr_banks=1;
 	mi->bank[0].start = 0xa0000000;
 	mi->bank[0].size = (32*1024*1024);
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 363d91b..9a0d583 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -35,7 +35,6 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/scoop.h>
 
 #include <mach/pxa27x.h>
@@ -971,7 +970,6 @@ static void __init spitz_init(void)
 static void __init spitz_fixup(struct tag *tags, char **cmdline,
 			       struct meminfo *mi)
 {
-	sharpsl_save_param();
 	mi->nr_banks = 1;
 	mi->bank[0].start = 0xa0000000;
 	mi->bank[0].size = (64*1024*1024);
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 4d4eb60..3f8fe17 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -53,7 +53,6 @@
 #include <mach/tosa.h>
 
 #include <asm/hardware/scoop.h>
-#include <asm/mach/sharpsl_param.h>
 
 #include "generic.h"
 #include "clock.h"
@@ -968,7 +967,6 @@ static void __init tosa_init(void)
 static void __init fixup_tosa(struct tag *tags, char **cmdline,
 			      struct meminfo *mi)
 {
-	sharpsl_save_param();
 	mi->nr_banks=1;
 	mi->bank[0].start = 0xa0000000;
 	mi->bank[0].size = (64*1024*1024);
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 42625e4..87b8604 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -50,7 +50,6 @@ config SA1100_COLLIE
 	# FIXME: select CPU_FREQ_SA11x0
 	select SHARP_LOCOMO
 	select SHARP_SCOOP
-	select SHARP_PARAM
 	help
 	  Say Y here to support the Sharp Zaurus SL5500 PDAs.
 
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index ea5cff3..98287a4 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -43,7 +43,6 @@
 #include <asm/mach/serial_sa1100.h>
 
 #include <asm/hardware/scoop.h>
-#include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/locomo.h>
 #include <mach/mcp.h>
 #include <mach/irqs.h>
@@ -366,7 +365,6 @@ static void __init collie_init(void)
 			    ARRAY_SIZE(collie_flash_resources));
 	sa11x0_register_mcp(&collie_mcp_data);
 
-	sharpsl_save_param();
 }
 
 static struct map_desc collie_io_desc[] __initdata = {
diff --git a/drivers/power/collie_battery.c b/drivers/power/collie_battery.c
index 74c6b23..e83b963 100644
--- a/drivers/power/collie_battery.c
+++ b/drivers/power/collie_battery.c
@@ -19,7 +19,6 @@
 #include <linux/gpio.h>
 #include <linux/mfd/ucb1x00.h>
 
-#include <asm/mach/sharpsl_param.h>
 #include <asm/mach-types.h>
 #include <mach/collie.h>
 
diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index c781768..c28838a 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -25,7 +25,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/corgi_lcd.h>
 #include <linux/slab.h>
-#include <asm/mach/sharpsl_param.h>
 
 #define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
 
@@ -195,9 +194,7 @@ static void lcdtg_set_phadadj(struct corgi_lcd *lcd, int mode)
 	switch(mode) {
 	case CORGI_LCD_MODE_VGA:
 		/* Setting for VGA */
-		adj = sharpsl_param.phadadj;
-		adj = (adj < 0) ? PHACTRL_PHASE_MANUAL :
-				  PHACTRL_PHASE_MANUAL | ((adj & 0xf) << 1);
+		adj = PHACTRL_PHASE_MANUAL;
 		break;
 	case CORGI_LCD_MODE_QVGA:
 	default:
@@ -242,9 +239,7 @@ static void corgi_lcd_power_on(struct corgi_lcd *lcd)
 			PICTRL_INIT_STATE | PICTRL_COM_SIGNAL_OFF);
 
 	/* Set Common Voltage */
-	comadj = sharpsl_param.comadj;
-	if (comadj < 0)
-		comadj = DEFAULT_COMADJ;
+	comadj = DEFAULT_COMADJ;
 
 	lcdtg_set_common_voltage(lcd, POWER0_DAC_ON | POWER0_COM_OFF |
 				 POWER0_VCC5_OFF, comadj);
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index 3a6d541..62c4cb9 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -21,7 +21,6 @@
 
 #include <asm/hardware/locomo.h>
 #include <asm/irq.h>
-#include <asm/mach/sharpsl_param.h>
 #include <asm/mach-types.h>
 
 #include "../../../arch/arm/mach-sa1100/generic.h"
@@ -82,7 +81,7 @@ static void locomolcd_off(int comadj)
 
 void locomolcd_power(int on)
 {
-	int comadj = sharpsl_param.comadj;
+	int comadj;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -92,10 +91,9 @@ void locomolcd_power(int on)
 		return;
 	}
 
-	/* read comadj */
-	if (comadj == -1 && machine_is_collie())
+	if (machine_is_collie())
 		comadj = 128;
-	if (comadj == -1 && machine_is_poodle())
+	if (machine_is_poodle())
 		comadj = 118;
 
 	if (on)
diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
index 49342e1..2918075 100644
--- a/drivers/video/backlight/tosa_bl.c
+++ b/drivers/video/backlight/tosa_bl.c
@@ -20,8 +20,6 @@
 #include <linux/backlight.h>
 #include <linux/slab.h>
 
-#include <asm/mach/sharpsl_param.h>
-
 #include <mach/tosa.h>
 
 #define COMADJ_DEFAULT	97
@@ -90,7 +88,7 @@ static int __devinit tosa_bl_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	data->comadj = sharpsl_param.comadj == -1 ? COMADJ_DEFAULT : sharpsl_param.comadj;
+	data->comadj = COMADJ_DEFAULT;
 
 	ret = devm_gpio_request(&client->dev, TOSA_GPIO_BL_C20MA, "backlight");
 	if (ret) {
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index 33047a66..6fc575f 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -21,8 +21,6 @@
 #include <linux/lcd.h>
 #include <linux/fb.h>
 
-#include <asm/mach/sharpsl_param.h>
-
 #include <mach/tosa.h>
 
 #define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
-- 
1.7.4.1
