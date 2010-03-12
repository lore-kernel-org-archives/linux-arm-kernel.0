From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Mar 2010 12:30:58 -0500
Subject: [PATCH] [ARM] pxa: support saarb platform
Message-ID: <mailman.345.1272529286.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support saarb handheld platform. PXA950 is installed on saarb.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/Kconfig  |    6 ++
 arch/arm/mach-pxa/Makefile |    1 +
 arch/arm/mach-pxa/saarb.c  |  139 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/saarb.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index ce9cfa4..3bd7e80 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -57,6 +57,12 @@ config MACH_SAAR
 	select PXA3xx
 	select CPU_PXA930

+config MACH_SAARB
+	bool "PXA950 Handheld Platform (aka SAARB)"
+	select CPU_PXA950
+	select PXA_SSP
+	select PXA_HAVE_BOARD_IRQS
+
 comment "Third Party Dev Platforms (sorted by vendor name)"

 config ARCH_PXA_IDP
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index df26606..9eefb8e 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_TAVOREVB3)	+= tavorevb3.o
 obj-$(CONFIG_MACH_SAAR)		+= saar.o
+obj-$(CONFIG_MACH_SAARB)	+= saarb.o

 # 3rd Party Dev Platforms
 obj-$(CONFIG_ARCH_PXA_IDP)	+= idp.o
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
new file mode 100644
index 0000000..7630cb2
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
+#include <mach/pxa9xx.h>
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
+	.backlight			= &saarb_backlight,
+	.led				= &saarb_led,
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
