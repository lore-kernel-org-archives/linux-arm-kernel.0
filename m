From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Mar 2010 12:30:58 -0500
Subject: [PATCH] [ARM] pxa: support saarb platform
Message-ID: <mailman.454.1274095224.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support saarb handheld platform. PXA950 is installed on saarb.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/configs/pxa3xx_defconfig |   12 +++-
 arch/arm/mach-pxa/Kconfig         |    5 ++
 arch/arm/mach-pxa/Makefile        |    1 +
 arch/arm/mach-pxa/saarb.c         |  139 +++++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-pxa/saarb.c

diff --git a/arch/arm/configs/pxa3xx_defconfig
b/arch/arm/configs/pxa3xx_defconfig
index 82ca6c8..9234469 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -221,7 +221,9 @@ CONFIG_CPU_PXA935=y
 CONFIG_MACH_ZYLONITE=y
 CONFIG_MACH_LITTLETON=y
 CONFIG_MACH_TAVOREVB=y
+CONFIG_MACH_TAVOREVB3=y
 CONFIG_MACH_SAAR=y
+CONFIG_MACH_SAARB=y
 # CONFIG_MACH_ARMCORE is not set
 # CONFIG_MACH_CM_X300 is not set
 # CONFIG_MACH_H4700 is not set
@@ -646,6 +648,7 @@ CONFIG_MOUSE_PXA930_TRKBALL=y
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_88PM860X=y
 # CONFIG_TOUCHSCREEN_ADS7846 is not set
 # CONFIG_TOUCHSCREEN_AD7877 is not set
 # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
@@ -819,7 +822,8 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Multifunction device drivers
 #
-# CONFIG_MFD_CORE is not set
+CONFIG_MFD_CORE=y
+CONFIG_MFD_88PM860X=y
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
@@ -887,6 +891,7 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_DA903X=y
+CONFIG_BACKLIGHT_88PM860X=y

 #
 # Display device support
@@ -981,6 +986,7 @@ CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 # CONFIG_REGULATOR_MAX1586 is not set
 CONFIG_REGULATOR_DA903X=y
 # CONFIG_REGULATOR_LP3971 is not set
+CONFIG_REGULATOR_88PM8607=y
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set

@@ -999,8 +1005,8 @@ CONFIG_FS_POSIX_ACL=y
 # CONFIG_BTRFS_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
-CONFIG_DNOTIFY=y
-# CONFIG_INOTIFY is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index e12ada9..2a0e344 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -54,6 +54,11 @@ config MACH_SAAR
 	select PXA3xx
 	select CPU_PXA930

+config MACH_SAARB
+	bool "PXA950 Handheld Platform (aka SAARB)"
+	select CPU_PXA950
+	select PXA_HAVE_BOARD_IRQS
+
 comment "Third Party Dev Platforms (sorted by vendor name)"

 config ARCH_PXA_IDP
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 55d3368..3b869ad 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_TAVOREVB3)	+= tavorevb3.o
 obj-$(CONFIG_MACH_SAAR)		+= saar.o
+obj-$(CONFIG_MACH_SAARB)	+= saarb.o

 # 3rd Party Dev Platforms
 obj-$(CONFIG_ARCH_PXA_IDP)	+= idp.o
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
new file mode 100644
index 0000000..20438a7
--- /dev/null
+++ b/arch/arm/mach-pxa/saarb.c
@@ -0,0 +1,139 @@
+/*
+ *  linux/arch/arm/mach-pxa/saarb.c
+ *
+ *  Support for the Marvell PXA950 Handheld Platform (aka SAARB)
+ *
+ *  Copyright (C) 2007-2010 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/mfd/88pm860x.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/pxa930.h>
+
+#include <plat/i2c.h>
+
+#include "devices.h"
+#include "generic.h"
+
+/* SAARB MFP configurations */
+static mfp_cfg_t saarb_mfp_cfg[] __initdata = {
+	/* UART */
+	GPIO53_UART1_RXD,
+	GPIO54_UART1_TXD,
+
+	/* I2C */
+	GPIO73_CI2C_SCL,
+	GPIO74_CI2C_SDA,
+
+	/* PMIC */
+	PMIC_INT_GPIO83,
+};
+
+#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
+static struct pm860x_touch_pdata saarb_touch = {
+	.gpadc_prebias	= 1,
+	.slot_cycle	= 1,
+	.tsi_prebias	= 6,
+	.pen_prebias	= 16,
+	.pen_prechg	= 2,
+	.res_x		= 300,
+};
+
+static struct pm860x_backlight_pdata saarb_backlight[] = {
+	{
+		.id	= PM8606_ID_BACKLIGHT,
+		.iset	= PM8606_WLED_CURRENT(24),
+		.flags	= PM8606_BACKLIGHT1,
+	},
+	{},
+};
+
+static struct pm860x_led_pdata saarb_led[] = {
+	{
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED1_RED,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED1_GREEN,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED1_BLUE,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED2_RED,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED2_GREEN,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED2_BLUE,
+	},
+};
+
+static struct pm860x_platform_data saarb_pm8607_info = {
+	.touch				= &saarb_touch,
+	.backlight			= &saarb_backlight[0],
+	.led				= &saarb_led[0],
+	.companion_addr			= 0x10,
+	.irq_mode			= 0,
+	.irq_base			= IRQ_BOARD_START,
+
+	.i2c_port			= GI2C_PORT,
+};
+
+static struct i2c_board_info saarb_i2c_info[] = {
+	{
+		.type		= "88PM860x",
+		.addr		= 0x34,
+		.platform_data	= &saarb_pm8607_info,
+		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+	},
+};
+
+static void __init saarb_init_i2c(void)
+{
+	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(saarb_i2c_info));
+}
+#else
+static inline void saarb_init_i2c(void) {}
+#endif
+
+static void __init saarb_init(void)
+{
+	/* initialize MFP configurations */
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(saarb_mfp_cfg));
+
+	pxa_set_ffuart_info(NULL);
+
+	saarb_init_i2c();
+}
+
+MACHINE_START(SAARB, "PXA950 Handheld Platform (aka SAARB)")
+	.phys_io        = 0x40000000,
+	.boot_params    = 0xa0000100,
+	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.map_io         = pxa_map_io,
+	.init_irq       = pxa3xx_init_irq,
+	.timer          = &pxa_timer,
+	.init_machine   = saarb_init,
+MACHINE_END
-- 
1.5.6.5
