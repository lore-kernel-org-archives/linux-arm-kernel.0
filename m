From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 05 Sep 2010 14:31:49 +0400
Subject: [PATCH] davinci: Add I2C0 devices to MityDSP-L138/MityARM-1808
	platform
In-Reply-To: <1283616701-6418-1-git-send-email-michael.williamson@criticallink.com>
References: <1283616701-6418-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4C837195.2040100@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-09-2010 20:11, Michael Williamson wrote:

> This patch adds the i2c0 bus and attached devices to the MityDSP-L138
> and MityARM-1808 davinci SoM.  Included is a TPS65023 voltage regulator
> needed for power management and a small 24c02 EPROM that contains
> factory configuration data.

> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
[...]
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 7146916..03820ce 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
[...]
> @@ -25,6 +27,141 @@
[...]
> +struct regulator_init_data tps65023_regulator_data[] = {
> +	/* dcdc1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1150000,
> +			.max_uV = 1350000,
> +			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> +				REGULATOR_CHANGE_STATUS),

    Would look better if you aligned it. And parens are useless here.

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
> +			.valid_ops_mask = (REGULATOR_CHANGE_STATUS),

    Useless parens.

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
> +			.valid_ops_mask = (REGULATOR_CHANGE_STATUS),

    Again...

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
> +			.valid_ops_mask = (REGULATOR_CHANGE_STATUS),

    And again...

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
> +			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> +				REGULATOR_CHANGE_STATUS),

    Would look better if you aligned it. And parens are useless here.

> @@ -172,6 +309,14 @@ static void __init mityomapl138_init(void)
>
>   	davinci_serial_init(&mityomapl138_uart_config);
>
> +	ret = da8xx_register_i2c(0,&mityomap_i2c_0_pdata);
> +	if (ret)
> +		pr_warning("i2c0 registration failed %d\n", ret);

    You probably forgot semicolon after "failed" here...

> +
> +	ret = pmic_tps65023_init();
> +	if (ret)
> +		pr_warning("TPS65023 PMIC init failed: %d\n", ret);
> +

WBR, Sergei
