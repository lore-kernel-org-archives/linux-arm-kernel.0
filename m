From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 02 Oct 2011 16:07:49 +0900
Subject: [PATCH v2] ARM: EXYNOS4: Configure MAX8997 PMIC for Origen
In-Reply-To: <1313995163-31737-1-git-send-email-inderpal.singh@linaro.org>
References: <1313034965-21286-1-git-send-email-inderpal.singh@linaro.org>
	<1313995163-31737-1-git-send-email-inderpal.singh@linaro.org>
Message-ID: <001501cc80d1$feef7d50$fcce77f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inderpal Singh wrote:
> 
> From: Inderpal Singh <inderpal.s@samsung.com>
> 
> Configure MAX8997 PMIC and provide platform specific data
> for origen.
> 
> Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
> ---
> Changes from v1:
> 	- Removed soc-audio
> 	- Used macro for GPIO pin
> 	- irq assigned statically
> 	- Rectified mismatches in constraints flags
> 	- Removed assigning of array index
> 
>  arch/arm/mach-exynos4/mach-origen.c |  390
+++++++++++++++++++++++++++++++++++
>  1 files changed, 390 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/mach-origen.c
b/arch/arm/mach-exynos4/mach-origen.c
> index ed59f86..ccd2a55 100644
> --- a/arch/arm/mach-exynos4/mach-origen.c
> +++ b/arch/arm/mach-exynos4/mach-origen.c
> @@ -14,6 +14,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/mfd/max8997.h>
> 
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
> @@ -24,6 +27,7 @@
>  #include <plat/devs.h>
>  #include <plat/sdhci.h>
>  #include <plat/iic.h>
> +#include <plat/gpio-cfg.h>
> 
>  #include <mach/map.h>
> 
> @@ -72,6 +76,378 @@ static struct s3c2410_uartcfg origen_uartcfgs[]
__initdata = {
>  	},
>  };
> 
> +static struct regulator_consumer_supply __initdata ldo3_consumer[] = {
> +	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"), /* MIPI */
> +};
> +static struct regulator_consumer_supply __initdata ldo6_consumer[] = {
> +	REGULATOR_SUPPLY("vdd18", "s5p-mipi-csis.0"), /* MIPI */
> +};
> +static struct regulator_consumer_supply __initdata ldo7_consumer[] = {
> +	REGULATOR_SUPPLY("avdd", "alc5625"), /* Realtek ALC5625 */
> +};
> +static struct regulator_consumer_supply __initdata ldo8_consumer[] = {
> +	REGULATOR_SUPPLY("vdd", "s5p-adc"), /* ADC */
> +};
> +static struct regulator_consumer_supply __initdata ldo9_consumer[] = {
> +	REGULATOR_SUPPLY("dvdd", "swb-a31"), /* AR6003 WLAN & CSR 8810 BT */
> +};
> +static struct regulator_consumer_supply __initdata ldo11_consumer[] = {
> +	REGULATOR_SUPPLY("dvdd", "alc5625"), /* Realtek ALC5625 */
> +};
> +static struct regulator_consumer_supply __initdata ldo14_consumer[] = {
> +	REGULATOR_SUPPLY("avdd18", "swb-a31"), /* AR6003 WLAN & CSR 8810 BT
*/
> +};
> +static struct regulator_consumer_supply __initdata ldo17_consumer[] = {
> +	REGULATOR_SUPPLY("vdd33", "swb-a31"), /* AR6003 WLAN & CSR 8810 BT
*/
> +};
> +static struct regulator_consumer_supply __initdata buck1_consumer[] = {
> +	REGULATOR_SUPPLY("vdd_arm", NULL), /* CPUFREQ */
> +};
> +static struct regulator_consumer_supply __initdata buck2_consumer[] = {
> +	REGULATOR_SUPPLY("vdd_int", NULL), /* CPUFREQ */
> +};
> +static struct regulator_consumer_supply __initdata buck3_consumer[] = {
> +	REGULATOR_SUPPLY("vdd_g3d", "mali_drm"), /* G3D */
> +};
> +static struct regulator_consumer_supply __initdata buck7_consumer[] = {
> +	REGULATOR_SUPPLY("vcc", "platform-lcd"), /* LCD */
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo1_data = {
> +	.constraints	= {
> +		.name		= "VDD_ABB_3.3V",
> +		.min_uV		= 3300000,
> +		.max_uV		= 3300000,
> +		.apply_uV	= 1,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo2_data	= {
> +	.constraints	= {
> +		.name		= "VDD_ALIVE_1.1V",
> +		.min_uV		= 1100000,
> +		.max_uV		= 1100000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.state_mem	= {
> +			.enabled	= 1,
> +		},
> +	},
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo3_data = {
> +	.constraints	= {
> +		.name		= "VMIPI_1.1V",
> +		.min_uV		= 1100000,
> +		.max_uV		= 1100000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo3_consumer),
> +	.consumer_supplies	= ldo3_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo4_data = {
> +	.constraints	= {
> +		.name		= "VDD_RTC_1.8V",
> +		.min_uV		= 1800000,
> +		.max_uV		= 1800000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo6_data = {
> +	.constraints	= {
> +		.name		= "VMIPI_1.8V",
> +		.min_uV		= 1800000,
> +		.max_uV		= 1800000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo6_consumer),
> +	.consumer_supplies	= ldo6_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo7_data = {
> +	.constraints	= {
> +		.name		= "VDD_AUD_1.8V",
> +		.min_uV		= 1800000,
> +		.max_uV		= 1800000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo7_consumer),
> +	.consumer_supplies	= ldo7_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo8_data = {
> +	.constraints	= {
> +		.name		= "VADC_3.3V",
> +		.min_uV		= 3300000,
> +		.max_uV		= 3300000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo8_consumer),
> +	.consumer_supplies	= ldo8_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo9_data = {
> +	.constraints	= {
> +		.name		= "DVDD_SWB_2.8V",
> +		.min_uV		= 2800000,
> +		.max_uV		= 2800000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo9_consumer),
> +	.consumer_supplies	= ldo9_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo10_data = {
> +	.constraints	= {
> +		.name		= "VDD_PLL_1.1V",
> +		.min_uV		= 1100000,
> +		.max_uV		= 1100000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo11_data = {
> +	.constraints	= {
> +		.name		= "VDD_AUD_3V",
> +		.min_uV		= 3000000,
> +		.max_uV		= 3000000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo11_consumer),
> +	.consumer_supplies	= ldo11_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo14_data = {
> +	.constraints	= {
> +		.name		= "AVDD18_SWB_1.8V",
> +		.min_uV		= 1800000,
> +		.max_uV		= 1800000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo14_consumer),
> +	.consumer_supplies	= ldo14_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo17_data = {
> +	.constraints	= {
> +		.name		= "VDD_SWB_3.3V",
> +		.min_uV		= 3300000,
> +		.max_uV		= 3300000,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(ldo17_consumer),
> +	.consumer_supplies	= ldo17_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_ldo21_data = {
> +	.constraints	= {
> +		.name		= "VDD_MIF_1.2V",
> +		.min_uV		= 1200000,
> +		.max_uV		= 1200000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +};
> +
> +static struct regulator_init_data __initdata max8997_buck1_data = {
> +	.constraints	= {
> +		.name		= "VDD_ARM_1.2V",
> +		.min_uV		= 950000,
> +		.max_uV		= 1350000,
> +		.always_on	= 1,
> +		.boot_on	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(buck1_consumer),
> +	.consumer_supplies	= buck1_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_buck2_data = {
> +	.constraints	= {
> +		.name		= "VDD_INT_1.1V",
> +		.min_uV		= 900000,
> +		.max_uV		= 1100000,
> +		.always_on	= 1,
> +		.boot_on	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(buck2_consumer),
> +	.consumer_supplies	= buck2_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_buck3_data = {
> +	.constraints	= {
> +		.name		= "VDD_G3D_1.1V",
> +		.min_uV		= 900000,
> +		.max_uV		= 1100000,
> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
> +					REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(buck3_consumer),
> +	.consumer_supplies	= buck3_consumer,
> +};
> +
> +static struct regulator_init_data __initdata max8997_buck5_data = {
> +	.constraints	= {
> +		.name		= "VDDQ_M1M2_1.2V",
> +		.min_uV		= 1200000,
> +		.max_uV		= 1200000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.state_mem	= {
> +			.disabled	= 1,
> +		},
> +	},
> +};
> +
> +static struct regulator_init_data __initdata max8997_buck7_data = {
> +	.constraints	= {
> +		.name		= "VDD_LCD_3.3V",
> +		.min_uV		= 3300000,
> +		.max_uV		= 3300000,
> +		.boot_on	= 1,
> +		.apply_uV	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +		.state_mem	= {
> +			.disabled	= 1
> +		},
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(buck7_consumer),
> +	.consumer_supplies	= buck7_consumer,
> +};
> +
> +static struct max8997_regulator_data __initdata
origen_max8997_regulators[] = {
> +	{ MAX8997_LDO1,		&max8997_ldo1_data },
> +	{ MAX8997_LDO2,		&max8997_ldo2_data },
> +	{ MAX8997_LDO3,		&max8997_ldo3_data },
> +	{ MAX8997_LDO4,		&max8997_ldo4_data },
> +	{ MAX8997_LDO6,		&max8997_ldo6_data },
> +	{ MAX8997_LDO7,		&max8997_ldo7_data },
> +	{ MAX8997_LDO8,		&max8997_ldo8_data },
> +	{ MAX8997_LDO9,		&max8997_ldo9_data },
> +	{ MAX8997_LDO10,	&max8997_ldo10_data },
> +	{ MAX8997_LDO11,	&max8997_ldo11_data },
> +	{ MAX8997_LDO14,	&max8997_ldo14_data },
> +	{ MAX8997_LDO17,	&max8997_ldo17_data },
> +	{ MAX8997_LDO21,	&max8997_ldo21_data },
> +	{ MAX8997_BUCK1,	&max8997_buck1_data },
> +	{ MAX8997_BUCK2,	&max8997_buck2_data },
> +	{ MAX8997_BUCK3,	&max8997_buck3_data },
> +	{ MAX8997_BUCK5,	&max8997_buck5_data },
> +	{ MAX8997_BUCK7,	&max8997_buck7_data },
> +};
> +
> +struct max8997_platform_data __initdata origen_max8997_pdata = {
> +	.num_regulators = ARRAY_SIZE(origen_max8997_regulators),
> +	.regulators	= origen_max8997_regulators,
> +
> +	.wakeup	= true,
> +	.buck1_gpiodvs	= false,
> +	.buck2_gpiodvs	= false,
> +	.buck5_gpiodvs	= false,
> +	.irq_base	= IRQ_GPIO_END + 1,
> +
> +	.ignore_gpiodvs_side_effect = true,
> +	.buck125_default_idx = 0x0,
> +
> +	.buck125_gpios[0]	= EXYNOS4_GPX0(0),
> +	.buck125_gpios[1]	= EXYNOS4_GPX0(1),
> +	.buck125_gpios[2]	= EXYNOS4_GPX0(2),
> +
> +	.buck1_voltage[0]	= 1350000,
> +	.buck1_voltage[1]	= 1300000,
> +	.buck1_voltage[2]	= 1250000,
> +	.buck1_voltage[3]	= 1200000,
> +	.buck1_voltage[4]	= 1150000,
> +	.buck1_voltage[5]	= 1100000,
> +	.buck1_voltage[6]	= 1000000,
> +	.buck1_voltage[7]	= 950000,
> +
> +	.buck2_voltage[0]	= 1100000,
> +	.buck2_voltage[1]	= 1100000,
> +	.buck2_voltage[2]	= 1100000,
> +	.buck2_voltage[3]	= 1100000,
> +	.buck2_voltage[4]	= 1000000,
> +	.buck2_voltage[5]	= 1000000,
> +	.buck2_voltage[6]	= 1000000,
> +	.buck2_voltage[7]	= 1000000,
> +
> +	.buck5_voltage[0]	= 1200000,
> +	.buck5_voltage[1]	= 1200000,
> +	.buck5_voltage[2]	= 1200000,
> +	.buck5_voltage[3]	= 1200000,
> +	.buck5_voltage[4]	= 1200000,
> +	.buck5_voltage[5]	= 1200000,
> +	.buck5_voltage[6]	= 1200000,
> +	.buck5_voltage[7]	= 1200000,
> +};
> +
> +/* I2C0 */
> +static struct i2c_board_info i2c0_devs[] __initdata = {
> +	{
> +		I2C_BOARD_INFO("max8997", (0xCC >> 1)),
> +		.platform_data	= &origen_max8997_pdata,
> +		.irq		= IRQ_EINT(4),
> +	},
> +};
> +
>  static struct s3c_sdhci_platdata origen_hsmmc2_pdata __initdata = {
>  	.cd_type		= S3C_SDHCI_CD_GPIO,
>  	.ext_cd_gpio		= EXYNOS4_GPK2(2),
> @@ -80,6 +456,7 @@ static struct s3c_sdhci_platdata origen_hsmmc2_pdata
__initdata = {
>  };
> 
>  static struct platform_device *origen_devices[] __initdata = {
> +	&s3c_device_i2c0,
>  	&s3c_device_hsmmc2,
>  	&s3c_device_rtc,
>  	&s3c_device_wdt,
> @@ -92,8 +469,21 @@ static void __init origen_map_io(void)
>  	s3c24xx_init_uarts(origen_uartcfgs, ARRAY_SIZE(origen_uartcfgs));
>  }
> 
> +#define	ORIGEN_PMIC_GPIO	EXYNOS4_GPX0(4)
> +static void __init origen_power_init(void)
> +{
> +	gpio_request(ORIGEN_PMIC_GPIO, "PMIC_IRQ");
> +	s3c_gpio_cfgpin(ORIGEN_PMIC_GPIO, S3C_GPIO_SFN(0xf));
> +	s3c_gpio_setpull(ORIGEN_PMIC_GPIO, S3C_GPIO_PULL_NONE);
> +}
> +
>  static void __init origen_machine_init(void)
>  {
> +	origen_power_init();
> +
> +	s3c_i2c0_set_platdata(NULL);
> +	i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
> +
>  	s3c_sdhci2_set_platdata(&origen_hsmmc2_pdata);
>  	platform_add_devices(origen_devices, ARRAY_SIZE(origen_devices));
>  }
> --
> 1.7.4.1

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
