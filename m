From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  8 Jun 2011 14:55:14 +0100
Subject: [PATCH] ARM: S3C64XX: Refresh Cragganmore support
Message-ID: <1307541314-11066-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original Cragganmore code was submitted while new code was being
refused for mainline.  This patch was unexpectedly merged upstream but
development had continued in the expectation that the code would be
resubmitted later so no split patches were maintained.  This patch
synchronises that work with the recently merged driver.

The main changes are fleshing out of the PMIC and audio integration for
the system, including addition of the Dallas Dhu and Tobermory audio
modules, plus some minor updates to account for revision 2 hardware.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |  270 +++++++++++++++++++++++++++------
 1 files changed, 226 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 35088ce..f01e440 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/dm9000.h>
 #include <linux/gpio_keys.h>
@@ -33,6 +34,7 @@
 
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/pdata.h>
+#include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
 
 #include <asm/mach/arch.h>
@@ -47,7 +49,6 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-modem.h>
 
-#include <mach/gpio-bank-o.h>
 #include <mach/regs-gpio-memport.h>
 
 #include <plat/regs-serial.h>
@@ -64,10 +65,16 @@
 #include <plat/iic.h>
 #include <plat/pm.h>
 
-#define BANFF_PMIC_IRQ_BASE IRQ_BOARD_START
+#include <sound/wm8915.h>
+#include <sound/wm8962.h>
+#include <sound/wm9081.h>
 
-#define PCA935X_GPIO_BASE GPIO_BOARD_START
-#define CODEC_GPIO_BASE (GPIO_BOARD_START + 8)
+#define BANFF_PMIC_IRQ_BASE       IRQ_BOARD_START
+#define GLENFARCLAS_PMIC_IRQ_BASE (IRQ_BOARD_START + 64)
+
+#define PCA935X_GPIO_BASE          GPIO_BOARD_START
+#define CODEC_GPIO_BASE            (GPIO_BOARD_START + 8)
+#define GLENFARCLAS_PMIC_GPIO_BASE (GPIO_BOARD_START + 16)
 
 /* serial port setup */
 
@@ -77,32 +84,32 @@
 
 static struct s3c2410_uartcfg crag6410_uartcfgs[] __initdata = {
 	[0] = {
-		.hwport	= 0,
-		.flags	= 0,
-		.ucon	= UCON,
-		.ulcon	= ULCON,
-		.ufcon	= UFCON,
+		.hwport	     = 0,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
 	},
 	[1] = {
-		.hwport	= 1,
-		.flags	= 0,
-		.ucon	= UCON,
-		.ulcon	= ULCON,
-		.ufcon	= UFCON,
+		.hwport	     = 1,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
 	},
 	[2] = {
-		.hwport	= 2,
-		.flags	= 0,
-		.ucon	= UCON,
-		.ulcon	= ULCON,
-		.ufcon	= UFCON,
+		.hwport	     = 2,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
 	},
 	[3] = {
-		.hwport	= 3,
-		.flags	= 0,
-		.ucon	= UCON,
-		.ulcon	= ULCON,
-		.ufcon	= UFCON,
+		.hwport	     = 3,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
 	},
 };
 
@@ -205,10 +212,15 @@ static struct gpio_keys_button crag6410_gpio_keys[] = {
 	[0] = {
 		.code	= KEY_SUSPEND,
 		.gpio	= S3C64XX_GPL(10),	/* EINT 18 */
-		.type	= EV_SW,
+		.type	= EV_KEY,
 		.wakeup	= 1,
 		.active_low = 1,
 	},
+	[1] = {
+		.code	= SW_FRONT_PROXIMITY,
+		.gpio	= S3C64XX_GPN(11),	/* EINT 11 */
+		.type	= EV_SW,
+	},
 };
 
 static struct gpio_keys_platform_data crag6410_gpio_keydata = {
@@ -270,6 +282,44 @@ static struct platform_device crag6410_mmgpio = {
 	},
 };
 
+static struct platform_device speyside_device = {
+	.name		= "speyside",
+	.id		= -1,
+};
+
+static struct platform_device speyside_wm8962_device = {
+	.name		= "speyside-wm8962",
+	.id		= -1,
+};
+
+static struct regulator_consumer_supply wallvdd_consumers[] = {
+	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
+	REGULATOR_SUPPLY("SPKVDD2", "1-001a"),
+};
+
+static struct regulator_init_data wallvdd_data = {
+	.constraints = {
+		.always_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(wallvdd_consumers),
+	.consumer_supplies = wallvdd_consumers,
+};
+
+static struct fixed_voltage_config wallvdd_pdata = {
+	.supply_name = "WALLVDD",
+	.microvolts = 5000000,
+	.init_data = &wallvdd_data,
+	.gpio = -EINVAL,
+};
+
+static struct platform_device wallvdd_device = {
+	.name          = "reg-fixed-voltage",
+	.id            = -1,
+	.dev = {
+		.platform_data = &wallvdd_pdata,
+	},
+};
+
 static struct platform_device *crag6410_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
@@ -293,6 +343,9 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&crag6410_mmgpio,
 	&crag6410_lcd_powerdev,
 	&crag6410_backlight_device,
+	&speyside_device,
+	&speyside_wm8962_device,
+	&wallvdd_device,
 };
 
 static struct pca953x_platform_data crag6410_pca_data = {
@@ -423,27 +476,21 @@ static struct wm831x_status_pdata banff_green_led __initdata = {
 
 static struct wm831x_touch_pdata touch_pdata __initdata = {
 	.data_irq = S3C_EINT(26),
+	.pd_irq = S3C_EINT(27),
 };
 
-static __init int crag_pmic_pre_init(struct wm831x *wm831x)
-{
-	/* Touchscreen data IRQ - CMOS, DBVDD, active high*/
-	wm831x_reg_write(wm831x, WM831X_GPIO11_CONTROL,
-			 WM831X_GPN_POL | WM831X_GPN_ENA | 0x6);
-
-	/* Touchscreen pen down IRQ - CMOS, DBVDD, active high*/
-	wm831x_reg_write(wm831x, WM831X_GPIO12_CONTROL,
-			 WM831X_GPN_POL | WM831X_GPN_ENA | 0x7);
-
-	return 0;
-}
-
 static struct wm831x_pdata crag_pmic_pdata __initdata = {
-	.pre_init = crag_pmic_pre_init,
-
+	.wm831x_num = 1,
 	.irq_base = BANFF_PMIC_IRQ_BASE,
 	.gpio_base = GPIO_BOARD_START + 8,
 
+	.gpio_defaults = {
+		/* GPIO11: Touchscreen data - CMOS, DBVDD, active high*/
+		[10] = WM831X_GPN_POL | WM831X_GPN_ENA | 0x6,
+		/* GPIO12: Touchscreen pen down - CMOS, DBVDD, active high*/
+		[11] = WM831X_GPN_POL | WM831X_GPN_ENA | 0x7,
+	},
+
 	.dcdc = {
 		&vddarm,  /* DCDC1 */
 		&vddint,  /* DCDC2 */
@@ -451,7 +498,7 @@ static struct wm831x_pdata crag_pmic_pdata __initdata = {
 	},
 
 	.ldo = {
-		&vddsys,   /* LDO1 */
+	 	&vddsys,   /* LDO1 */
 		&vddmmc,   /* LDO2 */
 		NULL,      /* LDO3 */
 		&vddotgi,  /* LDO4 */
@@ -462,12 +509,12 @@ static struct wm831x_pdata crag_pmic_pdata __initdata = {
 		&vddpll,   /* LDO9 */
 		&vddlcd,   /* LDO10 */
 		&vddalive, /* LDO11 */
-	},
+	 },
 
 	.status = {
 		&banff_green_led,
 		&banff_red_led,
-	},
+	 },
 
 	.touch = &touch_pdata,
 };
@@ -487,9 +534,142 @@ static struct s3c2410_platform_i2c i2c0_pdata = {
 	.frequency = 400000,
 };
 
+static struct regulator_init_data pvdd_1v2 __initdata = {
+	.constraints = {
+		.name = "PVDD_1V2",
+		.always_on = 1,
+	},
+};
+
+static struct regulator_consumer_supply pvdd_1v8_consumers[] __initdata = {
+	REGULATOR_SUPPLY("PLLVDD", "1-001a"),
+	REGULATOR_SUPPLY("DBVDD", "1-001a"),
+	REGULATOR_SUPPLY("CPVDD", "1-001a"),
+	REGULATOR_SUPPLY("AVDD2", "1-001a"),
+	REGULATOR_SUPPLY("DCVDD", "1-001a"),
+	REGULATOR_SUPPLY("AVDD", "1-001a"),
+};
+
+static struct regulator_init_data pvdd_1v8 __initdata = {
+	.constraints = {
+		.name = "PVDD_1V8",
+		.always_on = 1,
+	},
+
+	.consumer_supplies = pvdd_1v8_consumers,
+	.num_consumer_supplies = ARRAY_SIZE(pvdd_1v8_consumers),
+};
+
+static struct regulator_consumer_supply pvdd_3v3_consumers[] __initdata = {
+	REGULATOR_SUPPLY("MICVDD", "1-001a"),
+	REGULATOR_SUPPLY("AVDD1", "1-001a"),
+};
+
+static struct regulator_init_data pvdd_3v3 __initdata = {
+	.constraints = {
+		.name = "PVDD_3V3",
+		.always_on = 1,
+	},
+
+	.consumer_supplies = pvdd_3v3_consumers,
+	.num_consumer_supplies = ARRAY_SIZE(pvdd_3v3_consumers),
+};
+
+static struct wm831x_pdata glenfarclas_pmic_pdata __initdata = {
+	.wm831x_num = 2,
+	.irq_base = GLENFARCLAS_PMIC_IRQ_BASE,
+	.gpio_base = GLENFARCLAS_PMIC_GPIO_BASE,
+
+	.gpio_defaults = {
+		/* GPIO1-3: IRQ inputs, rising edge triggered, CMOS */
+		[0] = WM831X_GPN_DIR | WM831X_GPN_POL | WM831X_GPN_ENA,
+		[1] = WM831X_GPN_DIR | WM831X_GPN_POL | WM831X_GPN_ENA,
+		[2] = WM831X_GPN_DIR | WM831X_GPN_POL | WM831X_GPN_ENA,
+	},
+
+	.dcdc = {
+		&pvdd_1v2,  /* DCDC1 */
+		&pvdd_1v8,  /* DCDC2 */
+		&pvdd_3v3,  /* DCDC3 */
+	},
+
+	.disable_touch = true,
+};
+
+static struct wm8915_retune_mobile_config wm8915_retune[] = {
+	{
+		.name = "Sub LPF",
+		.rate = 48000,
+		.regs = {
+			0x6318, 0x6300, 0x1000, 0x0000, 0x0004, 0x2000, 0xF000,
+			0x0000, 0x0004, 0x2000, 0xF000, 0x0000, 0x0004, 0x2000,
+			0xF000, 0x0000, 0x0004, 0x1000, 0x0800, 0x4000
+		},
+	},
+	{
+		.name = "Sub HPF",
+		.rate = 48000,
+		.regs = {
+			0x000A, 0x6300, 0x1000, 0x0000, 0x0004, 0x2000, 0xF000,
+			0x0000, 0x0004, 0x2000, 0xF000, 0x0000, 0x0004, 0x2000,
+			0xF000, 0x0000, 0x0004, 0x1000, 0x0800, 0x4000
+		},
+	},
+};
+
+static struct wm8915_pdata wm8915_pdata __initdata = {
+	.ldo_ena = S3C64XX_GPN(7),
+	.gpio_base = CODEC_GPIO_BASE,
+	.micdet_def = 1,
+	.inl_mode = WM8915_DIFFERRENTIAL_1,
+	.inr_mode = WM8915_DIFFERRENTIAL_1,
+
+	.irq_flags = IRQF_TRIGGER_FALLING,
+
+	.gpio_default = {
+		0x8001, /* GPIO1 == ADCLRCLK1 */
+		0x8001, /* GPIO2 == ADCLRCLK2, input due to CPU */
+		0x0141, /* GPIO3 == HP_SEL */
+		0x0002, /* GPIO4 == IRQ */
+		0x020e, /* GPIO5 == CLKOUT */
+	},
+
+	.retune_mobile_cfgs = wm8915_retune,
+	.num_retune_mobile_cfgs = ARRAY_SIZE(wm8915_retune),
+};
+
+static struct wm8962_pdata wm8962_pdata __initdata = {
+	.gpio_init = {
+		0,
+		WM8962_GPIO_FN_OPCLK,
+		WM8962_GPIO_FN_DMICCLK,
+		0,
+		0x8000 | WM8962_GPIO_FN_DMICDAT,
+		WM8962_GPIO_FN_IRQ,    /* Open drain mode */
+	},
+	.irq_active_low = true,
+};
+
+static struct wm9081_pdata wm9081_pdata __initdata = {
+	.irq_high = false,
+	.irq_cmos = false,
+};
+
 static struct i2c_board_info i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("wm8311", 0x34),
-	  .platform_data = &glenfarclas_pmic_pdata,
+	  .irq = S3C_EINT(0),
+	  .platform_data = &glenfarclas_pmic_pdata },
+
+	{ I2C_BOARD_INFO("wm1250-ev1", 0x27) },
+	{ I2C_BOARD_INFO("wm8915", 0x1a),
+	  .platform_data = &wm8915_pdata,
+	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
+	},
+	{ I2C_BOARD_INFO("wm9081", 0x6c),
+	  .platform_data = &wm9081_pdata, },
+	{ I2C_BOARD_INFO("wm8962", 0x1a),
+	  .platform_data = &wm8962_pdata,
+	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
 	},
 };
 
@@ -561,6 +741,8 @@ static void __init crag6410_machine_init(void)
 
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
 
+	regulator_has_full_constraints();
+
 	s3c_pm_init();
 }
 
-- 
1.7.5.3
