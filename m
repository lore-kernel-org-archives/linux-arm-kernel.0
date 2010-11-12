From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 15:17:35 +0800
Subject: [PATCH 06/11] ARM: pxa: support saarb platform
In-Reply-To: <1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289546260-6208-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Saarb platform is a handheld platform that supports Marvell PXA955 silicon.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig  |    5 ++
 arch/arm/mach-pxa/Makefile |    1 +
 arch/arm/mach-pxa/pxa95x.c |    3 -
 arch/arm/mach-pxa/saarb.c  |  114 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-pxa/saarb.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index d9424ff..d972a2c 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -50,6 +50,11 @@ config MACH_SAAR
 	select CPU_PXA930
 	select CPU_PXA935
 
+config MACH_SAARB
+	bool "PXA955 Handheld Platform (aka SAARB)"
+	depends on !(CPU_XSCALE || CPU_XSC3)
+	select CPU_PXA955
+
 comment "Third Party Dev Platforms (sorted by vendor name)"
 
 config ARCH_PXA_IDP
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 1642f6c..ba83cfb 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_TAVOREVB3)	+= tavorevb3.o
 obj-$(CONFIG_MACH_SAAR)		+= saar.o
+obj-$(CONFIG_MACH_SAARB)	+= saarb.o
 
 # 3rd Party Dev Platforms
 obj-$(CONFIG_ARCH_PXA_IDP)	+= idp.o
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index b540280..af4e40f 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -45,9 +45,6 @@
 #define PECR_IE(n)	((1 << ((n) * 2)) << 28)
 #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
 
-/* crystal frequency to static memory controller multiplier (SMCFS) */
-static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
-
 /* crystal frequency to HSIO bus frequency multiplier (HSS) */
 static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
 
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
new file mode 100644
index 0000000..e497922
--- /dev/null
+++ b/arch/arm/mach-pxa/saarb.c
@@ -0,0 +1,114 @@
+/*
+ *  linux/arch/arm/mach-pxa/saarb.c
+ *
+ *  Support for the Marvell Handheld Platform (aka SAARB)
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
+#include <linux/i2c.h>
+#include <linux/mfd/88pm860x.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/irqs.h>
+#include <mach/hardware.h>
+#include <mach/mfp.h>
+#include <mach/mfp-pxa930.h>
+#include <mach/gpio.h>
+
+#include <plat/i2c.h>
+
+#include "generic.h"
+
+#define SAARB_NR_IRQS	(IRQ_BOARD_START + 40)
+
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
+	.touch		= &saarb_touch,
+	.backlight	= &saarb_backlight[0],
+	.led		= &saarb_led[0],
+	.companion_addr	= 0x10,
+	.irq_mode	= 0,
+	.irq_base	= IRQ_BOARD_START,
+
+	.i2c_port	= GI2C_PORT,
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
+static void __init saarb_init(void)
+{
+	pxa_set_ffuart_info(NULL);
+	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(saarb_i2c_info));
+}
+
+MACHINE_START(SAARB, "PXA955 Handheld Platform (aka SAARB)")
+	.boot_params    = 0xa0000100,
+	.map_io         = pxa_map_io,
+	.nr_irqs	= SAARB_NR_IRQS,
+	.init_irq       = pxa95x_init_irq,
+	.timer          = &pxa_timer,
+	.init_machine   = saarb_init,
+MACHINE_END
+
-- 
1.5.6.5
