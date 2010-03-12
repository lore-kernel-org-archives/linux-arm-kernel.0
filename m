From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Mar 2010 12:27:36 -0500
Subject: [PATCH] [ARM] pxa: enable pmic on tavorevb3
Message-ID: <mailman.344.1272529253.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable 88pm860x PMIC on tavorevb3.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/Kconfig     |    1 +
 arch/arm/mach-pxa/tavorevb3.c |   86 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 909edd2..ce9cfa4 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -50,6 +50,7 @@ config MACH_TAVOREVB3
 	bool "PXA95x Development Platform (aka TavorEVB III)"
 	select CPU_PXA950
 	select PXA_SSP
+	select PXA_HAVE_BOARD_IRQS

 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
index 878bc0b..d7c8a86 100644
--- a/arch/arm/mach-pxa/tavorevb3.c
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -13,13 +13,18 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
 #include <linux/gpio.h>
+#include <linux/mfd/88pm860x.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>

 #include <mach/pxa9xx.h>

+#include <plat/i2c.h>
+
 #include "devices.h"
 #include "generic.h"

@@ -27,14 +32,95 @@ static mfp_cfg_t evb3_mfp_cfg[] __initdata = {
 	/* UART */
 	GPIO53_UART1_TXD,
 	GPIO54_UART1_RXD,
+
+	/* PMIC */
+	PMIC_INT_GPIO83,
 };

+#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
+static struct pm860x_touch_pdata evb3_touch = {
+	.gpadc_prebias	= 1,
+	.slot_cycle	= 1,
+	.tsi_prebias	= 6,
+	.pen_prebias	= 16,
+	.pen_prechg	= 2,
+	.res_x		= 300,
+};
+
+static struct pm860x_backlight_pdata evb3_backlight[] = {
+	{
+		.id	= PM8606_ID_BACKLIGHT,
+		.iset	= PM8606_WLED_CURRENT(24),
+		.flags	= PM8606_BACKLIGHT1,
+	},
+	{},
+};
+
+static struct pm860x_led_pdata evb3_led[] = {
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
+static struct pm860x_platform_data evb3_pm8607_info = {
+	.touch				= &evb3_touch,
+	.backlight			= &evb3_backlight,
+	.led				= &evb3_led,
+	.companion_addr			= 0x10,
+	.irq_mode			= 0,
+	.irq_base			= IRQ_BOARD_START,
+
+	.i2c_port			= GI2C_PORT,
+};
+
+static struct i2c_board_info evb3_i2c_info[] = {
+	{
+		.type		= "88PM860x",
+		.addr		= 0x34,
+		.platform_data	= &evb3_pm8607_info,
+		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+	},
+};
+
+static void __init evb3_init_i2c(void)
+{
+	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(evb3_i2c_info));
+}
+#else
+static inline void evb3_init_i2c(void) {}
+#endif
+
 static void __init evb3_init(void)
 {
 	/* initialize MFP configurations */
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(evb3_mfp_cfg));

 	pxa_set_ffuart_info(NULL);
+
+	evb3_init_i2c();
 }

 MACHINE_START(TAVOREVB3, "PXA950 Evaluation Board (aka TavorEVB3)")
-- 
1.5.6.5
