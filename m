From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 05 Jul 2010 11:16:56 +0200
Subject: [PATCH 3/3] arm: s5pv210: GONI: add support for MAX8998 PMIC
In-Reply-To: <1278321416-32524-1-git-send-email-m.szyprowski@samsung.com>
References: <1278321416-32524-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1278321416-32524-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds required platform definitions for MAX8998 PMIC driver. Power
regulators for LDO and BUCK outputs has been defined as well as a simple
gpio-keys button for power key (to enable wakeup functionality with
external interrupt).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |  323 +++++++++++++++++++++++++++++++++++++
 1 files changed, 323 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 05b4a1a..f0eaf86 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -13,8 +13,13 @@
 #include <linux/init.h>
 #include <linux/serial_core.h>
 #include <linux/fb.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/mfd/max8998.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -107,9 +112,323 @@ static struct s3c_fb_platdata goni_lcd_pdata __initdata = {
 	.setup_gpio		= s5pv210_fb_gpio_setup_24bpp,
 };
 
+/* MAX8998 regulators */
+#if defined(CONFIG_REGULATOR_MAX8998) || \
+				defined(CONFIG_REGULATOR_MAX8998_MODULE)
+
+static struct regulator_init_data goni_ldo2_data = {
+	.constraints	= {
+		.name		= "VALIVE_1.1V",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled = 1,
+		},
+	},
+};
+
+static struct regulator_init_data goni_ldo3_data = {
+	.constraints	= {
+		.name		= "VUSB/MIPI_1.1V",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo4_data = {
+	.constraints	= {
+		.name		= "VDAC_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo5_data = {
+	.constraints	= {
+		.name		= "VTF_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo6_data = {
+	.constraints	= {
+		.name		= "VCC_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo7_data = {
+	.constraints	= {
+		.name		= "VLCD_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo8_data = {
+	.constraints	= {
+		.name		= "VUSB/VADC_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo9_data = {
+	.constraints	= {
+		.name		= "VCC/VCAM_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo10_data = {
+	.constraints	= {
+		.name		= "VPLL_1.1V",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.boot_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo11_data = {
+	.constraints	= {
+		.name		= "CAM_IO_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo12_data = {
+	.constraints	= {
+		.name		= "CAM_ISP_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo13_data = {
+	.constraints	= {
+		.name		= "CAM_A_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo14_data = {
+	.constraints	= {
+		.name		= "CAM_CIF_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo15_data = {
+	.constraints	= {
+		.name		= "CAM_AF_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo16_data = {
+	.constraints	= {
+		.name		= "VMIPI_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data goni_ldo17_data = {
+	.constraints	= {
+		.name		= "VCC_3.0V_LCD",
+		.min_uV		= 3000000,
+		.max_uV		= 3000000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+/* BUCK */
+static struct regulator_consumer_supply buck1_consumer[] = {
+	{	.supply	= "vddarm", },
+};
+
+static struct regulator_consumer_supply buck2_consumer[] = {
+	{	.supply	= "vddint", },
+};
+
+static struct regulator_init_data goni_buck1_data = {
+	.constraints	= {
+		.name		= "VARM_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(buck1_consumer),
+	.consumer_supplies	= buck1_consumer,
+};
+
+static struct regulator_init_data goni_buck2_data = {
+	.constraints	= {
+		.name		= "VINT_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(buck2_consumer),
+	.consumer_supplies	= buck2_consumer,
+};
+
+static struct regulator_init_data goni_buck3_data = {
+	.constraints	= {
+		.name		= "VCC_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled = 1,
+		},
+	},
+};
+
+static struct regulator_init_data goni_buck4_data = {
+	.constraints	= {
+		.name		= "CAM_CORE_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct max8998_regulator_data goni_regulators[] = {
+	{ MAX8998_LDO2,  &goni_ldo2_data },
+	{ MAX8998_LDO3,  &goni_ldo3_data },
+	{ MAX8998_LDO4,  &goni_ldo4_data },
+	{ MAX8998_LDO5,  &goni_ldo5_data },
+	{ MAX8998_LDO6,  &goni_ldo6_data },
+	{ MAX8998_LDO7,  &goni_ldo7_data },
+	{ MAX8998_LDO8,  &goni_ldo8_data },
+	{ MAX8998_LDO9,  &goni_ldo9_data },
+	{ MAX8998_LDO10, &goni_ldo10_data },
+	{ MAX8998_LDO11, &goni_ldo11_data },
+	{ MAX8998_LDO12, &goni_ldo12_data },
+	{ MAX8998_LDO13, &goni_ldo13_data },
+	{ MAX8998_LDO14, &goni_ldo14_data },
+	{ MAX8998_LDO15, &goni_ldo15_data },
+	{ MAX8998_LDO16, &goni_ldo16_data },
+	{ MAX8998_LDO17, &goni_ldo17_data },
+	{ MAX8998_BUCK1, &goni_buck1_data },
+	{ MAX8998_BUCK2, &goni_buck2_data },
+	{ MAX8998_BUCK3, &goni_buck3_data },
+	{ MAX8998_BUCK4, &goni_buck4_data },
+};
+
+static struct max8998_platform_data max8998_platform_data = {
+	.num_regulators		= ARRAY_SIZE(goni_regulators),
+	.regulators		= goni_regulators,
+};
+#endif
+
+/* GPIO I2C PMIC */
+#define AP_I2C_GPIO_PMIC_BUS_4	4
+static struct i2c_gpio_platform_data goni_i2c_gpio_pmic_data = {
+	.sda_pin	= S5PV210_GPJ4(0),	/* XMSMCSN */
+	.scl_pin	= S5PV210_GPJ4(3),	/* XMSMIRQN */
+};
+
+static struct platform_device goni_i2c_gpio_pmic = {
+	.name		= "i2c-gpio",
+	.id		= AP_I2C_GPIO_PMIC_BUS_4,
+	.dev		= {
+		.platform_data	= &goni_i2c_gpio_pmic_data,
+	},
+};
+
+static struct i2c_board_info i2c_gpio_pmic_devs[] __initdata = {
+#if defined(CONFIG_REGULATOR_MAX8998) || defined(CONFIG_REGULATOR_MAX8998_MODULE)
+	{
+		/* 0xCC when SRAD = 0 */
+		I2C_BOARD_INFO("max8998", 0xCC >> 1),
+		.platform_data		= &max8998_platform_data,
+	},
+#endif
+};
+
+/* PMIC Power button */
+static struct gpio_keys_button goni_gpio_keys_table[] = {
+	{
+		.code 		= KEY_POWER,
+		.gpio		= S5PV210_GPH2(6),
+		.desc		= "gpio-keys: KEY_POWER",
+		.type		= EV_KEY,
+		.active_low	= 1,
+		.wakeup		= 1,
+		.debounce_interval = 1,
+	},
+};
+
+static struct gpio_keys_platform_data goni_gpio_keys_data = {
+	.buttons        = goni_gpio_keys_table,
+	.nbuttons       = ARRAY_SIZE(goni_gpio_keys_table),
+};
+
+static struct platform_device goni_device_gpiokeys = {
+	.name      = "gpio-keys",
+	.dev = {
+		.platform_data = &goni_gpio_keys_data,
+	},
+};
+
+static void __init goni_pmic_init(void)
+{
+	/* AP_PMIC_IRQ: EINT7 */
+	s3c_gpio_cfgpin(S5PV210_GPH0(7), S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(S5PV210_GPH0(7), S3C_GPIO_PULL_UP);
+
+	/* nPower: EINT22 */
+	s3c_gpio_cfgpin(S5PV210_GPH2(6), S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(S5PV210_GPH2(6), S3C_GPIO_PULL_UP);
+}
+
+
 static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
+	&goni_i2c_gpio_pmic,
+	&goni_device_gpiokeys,
 };
 
 static void __init goni_map_io(void)
@@ -121,6 +440,10 @@ static void __init goni_map_io(void)
 
 static void __init goni_machine_init(void)
 {
+	/* PMIC */
+	goni_pmic_init();
+	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
+			ARRAY_SIZE(i2c_gpio_pmic_devs));
 
 	/* FB */
 	s3c_fb_set_platdata(&goni_lcd_pdata);
-- 
1.7.1.569.g6f426
