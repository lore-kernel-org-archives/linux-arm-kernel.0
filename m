From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 07 Sep 2010 08:39:43 -0700
Subject: [PATCH v1] davinci: Add I2C0 devices to MityDSP-L138/MityARM-1808
	platform
In-Reply-To: <1283707779-23204-1-git-send-email-michael.williamson@criticallink.com>
	(Michael Williamson's message of "Sun, 5 Sep 2010 13:29:39 -0400")
References: <1283707779-23204-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <87r5h5imv4.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

> This patch adds the i2c0 bus and attached devices to the MityDSP-L138
> and MityARM-1808 davinci SoM.  Included is a TPS65023 voltage regulator
> needed for power management and a small 24c02 EPROM that contains
> factory configuration data.
>
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>

Applying and queing for 2.6.37 in davinci-next.

Kevin

> ---
> This is based on 08f143b7cdbe9705f6856c2a63b6d3b14b5a8eee of davinci-linux
> tree.
>
> Changes since v0:
>    1. Misc formatting
>
>  arch/arm/mach-davinci/board-mityomapl138.c |  145 ++++++++++++++++++++++++++++
>  1 files changed, 145 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 7146916..84d5aff 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -13,6 +13,8 @@
>  #include <linux/console.h>
>  #include <linux/platform_device.h>
>  #include <linux/mtd/partitions.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/i2c.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -25,6 +27,141 @@
>  #define MITYOMAPL138_PHY_MASK		0x08 /* hardcoded for now */
>  #define MITYOMAPL138_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
>  
> +static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
> +	.bus_freq	= 100,	/* kHz */
> +	.bus_delay	= 0,	/* usec */
> +};
> +
> +/* TPS65023 voltage regulator support */
> +/* 1.2V Core */
> +struct regulator_consumer_supply tps65023_dcdc1_consumers[] = {
> +	{
> +		.supply = "cvdd",
> +	},
> +};
> +
> +/* 1.8V */
> +struct regulator_consumer_supply tps65023_dcdc2_consumers[] = {
> +	{
> +		.supply = "usb0_vdda18",
> +	},
> +	{
> +		.supply = "usb1_vdda18",
> +	},
> +	{
> +		.supply = "ddr_dvdd18",
> +	},
> +	{
> +		.supply = "sata_vddr",
> +	},
> +};
> +
> +/* 1.2V */
> +struct regulator_consumer_supply tps65023_dcdc3_consumers[] = {
> +	{
> +		.supply = "sata_vdd",
> +	},
> +	{
> +		.supply = "usb_cvdd",
> +	},
> +	{
> +		.supply = "pll0_vdda",
> +	},
> +	{
> +		.supply = "pll1_vdda",
> +	},
> +};
> +
> +/* 1.8V Aux LDO, not used */
> +struct regulator_consumer_supply tps65023_ldo1_consumers[] = {
> +	{
> +		.supply = "1.8v_aux",
> +	},
> +};
> +
> +/* FPGA VCC Aux (2.5 or 3.3) LDO */
> +struct regulator_consumer_supply tps65023_ldo2_consumers[] = {
> +	{
> +		.supply = "vccaux",
> +	},
> +};
> +
> +struct regulator_init_data tps65023_regulator_data[] = {
> +	/* dcdc1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1150000,
> +			.max_uV = 1350000,
> +			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
> +					  REGULATOR_CHANGE_STATUS,
> +			.boot_on = 1,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(tps65023_dcdc1_consumers),
> +		.consumer_supplies = tps65023_dcdc1_consumers,
> +	},
> +	/* dcdc2 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.boot_on = 1,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(tps65023_dcdc2_consumers),
> +		.consumer_supplies = tps65023_dcdc2_consumers,
> +	},
> +	/* dcdc3 */
> +	{
> +		.constraints = {
> +			.min_uV = 1200000,
> +			.max_uV = 1200000,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.boot_on = 1,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(tps65023_dcdc3_consumers),
> +		.consumer_supplies = tps65023_dcdc3_consumers,
> +	},
> +	/* ldo1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.boot_on = 1,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(tps65023_ldo1_consumers),
> +		.consumer_supplies = tps65023_ldo1_consumers,
> +	},
> +	/* ldo2 */
> +	{
> +		.constraints = {
> +			.min_uV = 2500000,
> +			.max_uV = 3300000,
> +			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
> +					  REGULATOR_CHANGE_STATUS,
> +			.boot_on = 1,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(tps65023_ldo2_consumers),
> +		.consumer_supplies = tps65023_ldo2_consumers,
> +	},
> +};
> +
> +static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
> +	{
> +		I2C_BOARD_INFO("tps65023", 0x48),
> +		.platform_data = &tps65023_regulator_data[0],
> +	},
> +	{
> +		I2C_BOARD_INFO("24c02", 0x50),
> +	},
> +};
> +
> +static int __init pmic_tps65023_init(void)
> +{
> +	return i2c_register_board_info(1, mityomap_tps65023_info,
> +					ARRAY_SIZE(mityomap_tps65023_info));
> +}
> +
>  /*
>   * MityDSP-L138 includes a 256 MByte large-page NAND flash
>   * (128K blocks).
> @@ -172,6 +309,14 @@ static void __init mityomapl138_init(void)
>  
>  	davinci_serial_init(&mityomapl138_uart_config);
>  
> +	ret = da8xx_register_i2c(0, &mityomap_i2c_0_pdata);
> +	if (ret)
> +		pr_warning("i2c0 registration failed: %d\n", ret);
> +
> +	ret = pmic_tps65023_init();
> +	if (ret)
> +		pr_warning("TPS65023 PMIC init failed: %d\n", ret);
> +
>  	mityomapl138_setup_nand();
>  
>  	mityomapl138_config_emac();
