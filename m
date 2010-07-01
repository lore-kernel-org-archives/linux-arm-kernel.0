From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 01 Jul 2010 08:07:45 +0200
Subject: [PATCH 2/3] arm: s5pv210: Aquila: add support for MAX8998 PMIC
In-Reply-To: <1277964466-23891-1-git-send-email-m.szyprowski@samsung.com>
References: <1277964466-23891-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1277964466-23891-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds required platform definitions for MAX8998 PMIC driver. Power
regulators for LDO and BUCK outputs has been defined as well as a simple
gpio-keys button for power key (to enable wakeup functionality with
external interrupt).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-aquila.c |  388 +++++++++++++++++++++++++++++++++++
 1 files changed, 388 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 44db0fc..46e0a23 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -13,6 +13,11 @@
 #include <linux/init.h>
 #include <linux/serial_core.h>
 #include <linux/fb.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/mfd/max8998.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -22,7 +27,9 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-fb.h>
+#include <mach/gpio.h>
 
+#include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
@@ -122,7 +129,383 @@ static struct s3c_fb_platdata aquila_lcd_pdata __initdata = {
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
 };
 
+/* MAX8998 regulators */
+#if defined(CONFIG_REGULATOR_MAX8998) || \
+				defined(CONFIG_REGULATOR_MAX8998_MODULE)
+
+static struct regulator_consumer_supply aquila_ldo3_consumers[] = {
+	{	.supply	= "VMIPI_1.1V",	},
+};
+
+static struct regulator_consumer_supply aquila_ldo8_consumers[] = {
+	{	.supply	= "VADC_3.3V", },
+};
+
+static struct regulator_consumer_supply aquila_ldo11_consumers[] = {
+	{	.supply	= "CAM_IO_2.8V", },
+};
+
+static struct regulator_consumer_supply aquila_ldo12_consumers[] = {
+	{	.supply	= "CAM_ISP_1.2V", },
+};
+
+static struct regulator_consumer_supply aquila_ldo13_consumers[] = {
+	{	.supply	= "CAM_A_2.8V", },
+};
+
+static struct regulator_consumer_supply aquila_ldo14_consumers[] = {
+	{	.supply	= "CAM_CIF_1.8V", },
+};
+
+static struct regulator_consumer_supply aquila_ldo15_consumers[] = {
+	{	.supply	= "CAM_AF_3.3V", },
+};
+
+static struct regulator_consumer_supply aquila_ldo16_consumers[] = {
+	{	.supply	= "VMIPI_1.8V", },
+};
+
+static struct regulator_consumer_supply aquila_ldo17_consumers[] = {
+	{	.supply	= "CAM_8M_1.8V", },
+};
+
+static struct regulator_init_data aquila_ldo2_data = {
+	.constraints	= {
+		.name		= "VALIVE_1.1V",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.boot_on	= 0,
+		.state_mem	= {
+			.enabled = 1,
+		},
+	},
+};
+
+static struct regulator_init_data aquila_ldo3_data = {
+	.constraints	= {
+		.name		= "VUSB/MIPI_1.1V",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo3_consumers),
+	.consumer_supplies	= aquila_ldo3_consumers,
+};
+
+static struct regulator_init_data aquila_ldo4_data = {
+	.constraints	= {
+		.name		= "VDAC_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data aquila_ldo5_data = {
+	.constraints	= {
+		.name		= "VTF_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data aquila_ldo6_data = {
+	.constraints	= {
+		.name		= "VCC_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data aquila_ldo7_data = {
+	.constraints	= {
+		.name		= "VCC_3.0V",
+		.min_uV		= 3000000,
+		.max_uV		= 3000000,
+		.apply_uV	= 1,
+		.boot_on	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data aquila_ldo8_data = {
+	.constraints	= {
+		.name		= "VUSB/VADC_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo8_consumers),
+	.consumer_supplies	= aquila_ldo8_consumers,
+};
+
+static struct regulator_init_data aquila_ldo9_data = {
+	.constraints	= {
+		.name		= "VCC/VCAM_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+};
+
+static struct regulator_init_data aquila_ldo10_data = {
+	.constraints	= {
+		.name		= "VPLL_1.1V",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.boot_on	= 1,
+	},
+};
+
+static struct regulator_init_data aquila_ldo11_data = {
+	.constraints	= {
+		.name		= "CAM_IO_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo11_consumers),
+	.consumer_supplies	= aquila_ldo11_consumers,
+};
+
+static struct regulator_init_data aquila_ldo12_data = {
+	.constraints	= {
+		.name		= "CAM_ISP_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo12_consumers),
+	.consumer_supplies	= aquila_ldo12_consumers,
+};
+
+static struct regulator_init_data aquila_ldo13_data = {
+	.constraints	= {
+		.name		= "CAM_A_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo13_consumers),
+	.consumer_supplies	= aquila_ldo13_consumers,
+};
+
+static struct regulator_init_data aquila_ldo14_data = {
+	.constraints	= {
+		.name		= "CAM_CIF_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo14_consumers),
+	.consumer_supplies	= aquila_ldo14_consumers,
+};
+
+static struct regulator_init_data aquila_ldo15_data = {
+	.constraints	= {
+		.name		= "CAM_AF_3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.apply_uV	= 1,
+		.boot_on	= 0,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo15_consumers),
+	.consumer_supplies	= aquila_ldo15_consumers,
+};
+
+static struct regulator_init_data aquila_ldo16_data = {
+	.constraints	= {
+		.name		= "VMIPI_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo16_consumers),
+	.consumer_supplies	= aquila_ldo16_consumers,
+};
+
+static struct regulator_init_data aquila_ldo17_data = {
+	.constraints	= {
+		.name		= "CAM_8M_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_ldo17_consumers),
+	.consumer_supplies	= aquila_ldo17_consumers,
+};
+
+/* BUCK */
+static struct regulator_consumer_supply buck1_consumer[] = {
+	{	.supply	= "vddarm", },
+};
+
+static struct regulator_consumer_supply aquila_buck4_consumers[] = {
+	{	.supply	= "CAM_CORE_1.2V", },
+};
+
+static struct regulator_init_data aquila_buck1_data = {
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
+static struct regulator_consumer_supply buck2_consumer[] = {
+	{	.supply	= "vddint", },
+};
+
+static struct regulator_init_data aquila_buck2_data = {
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
+static struct regulator_init_data aquila_buck3_data = {
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
+static struct regulator_init_data aquila_buck4_data = {
+	.constraints	= {
+		.name		= "CAM_CORE_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(aquila_buck4_consumers),
+	.consumer_supplies	= aquila_buck4_consumers,
+};
+
+static struct max8998_regulator_data aquila_regulators[] = {
+	{ MAX8998_LDO2,  &aquila_ldo2_data },
+	{ MAX8998_LDO3,  &aquila_ldo3_data },
+	{ MAX8998_LDO4,  &aquila_ldo4_data },
+	{ MAX8998_LDO5,  &aquila_ldo5_data },
+	{ MAX8998_LDO6,  &aquila_ldo6_data },
+	{ MAX8998_LDO7,  &aquila_ldo7_data },
+	{ MAX8998_LDO8,  &aquila_ldo8_data },
+	{ MAX8998_LDO9,  &aquila_ldo9_data },
+	{ MAX8998_LDO10, &aquila_ldo10_data },
+	{ MAX8998_LDO11, &aquila_ldo11_data },
+	{ MAX8998_LDO12, &aquila_ldo12_data },
+	{ MAX8998_LDO13, &aquila_ldo13_data },
+	{ MAX8998_LDO14, &aquila_ldo14_data },
+	{ MAX8998_LDO15, &aquila_ldo15_data },
+	{ MAX8998_LDO16, &aquila_ldo16_data },
+	{ MAX8998_LDO17, &aquila_ldo17_data },
+	{ MAX8998_BUCK1, &aquila_buck1_data },
+	{ MAX8998_BUCK2, &aquila_buck2_data },
+	{ MAX8998_BUCK3, &aquila_buck3_data },
+	{ MAX8998_BUCK4, &aquila_buck4_data },
+};
+
+static struct max8998_platform_data max8998_platform_data = {
+	.num_regulators		= ARRAY_SIZE(aquila_regulators),
+	.regulators		= aquila_regulators,
+};
+#endif
+
+/* GPIO I2C PMIC */
+#define AP_I2C_GPIO_PMIC_BUS_4	4
+static struct i2c_gpio_platform_data aquila_i2c_gpio_pmic_data = {
+	.sda_pin	= S5PV210_GPJ4(0),	/* XMSMCSN */
+	.scl_pin	= S5PV210_GPJ4(3),	/* XMSMIRQN */
+};
+
+static struct platform_device aquila_i2c_gpio_pmic = {
+	.name		= "i2c-gpio",
+	.id		= AP_I2C_GPIO_PMIC_BUS_4,
+	.dev		= {
+		.platform_data	= &aquila_i2c_gpio_pmic_data,
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
+static struct gpio_keys_button aquila_gpio_keys_table[] = {
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
+static struct gpio_keys_platform_data aquila_gpio_keys_data = {
+	.buttons        = aquila_gpio_keys_table,
+	.nbuttons       = ARRAY_SIZE(aquila_gpio_keys_table),
+};
+
+static struct platform_device aquila_device_gpiokeys = {
+	.name      = "gpio-keys",
+	.dev = {
+		.platform_data = &aquila_gpio_keys_data,
+	},
+};
+
+static void __init aquila_pmic_init(void)
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
 static struct platform_device *aquila_devices[] __initdata = {
+	&aquila_i2c_gpio_pmic,
+	&aquila_device_gpiokeys,
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
 };
@@ -136,6 +519,11 @@ static void __init aquila_map_io(void)
 
 static void __init aquila_machine_init(void)
 {
+	/* PMIC */
+	aquila_pmic_init();
+	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
+			ARRAY_SIZE(i2c_gpio_pmic_devs));
+
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
-- 
1.7.1.569.g6f426
