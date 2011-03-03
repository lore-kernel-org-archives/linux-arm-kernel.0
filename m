From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Mar 2011 11:21:00 +0900
Subject: [PATCH v2] ARM: S5PC210: add support for i2c PMICs on
	Universal_C210	board
In-Reply-To: <1297774241-16149-1-git-send-email-m.szyprowski@samsung.com>
References: <20110215113504.GF4152@n2100.arm.linux.org.uk>
	<1297774241-16149-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <018901cbd949$c86e8f80$594bae80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch adds basic definitions for MAX8952 & LP3974 (MAX8998
> compatible) PMICs for UniversalC210 board. Power consumers for the
> device drivers will be added later. These two PMICs occupy I2C5 bus.
> 

Hi Marek,

Could you please re-work this based on Exynos4?
And there are really small comments below :)

(snip)

> +static struct regulator_init_data lp3974_buck1_data = {
> +	.constraints	= {
> +		.name		= "VINT_1.1V",
> +		.min_uV		= 750000,
> +		.max_uV		= 1500000,
> +		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
> +			REGULATOR_CHANGE_STATUS,
> +		.boot_on	= 1,
> +		.state_mem	= {
> +			.enabled = 0,
                                ^
> +			.disabled = 1,
                                 ^

Do we need "disabled" with "enabled"?

(snip)

> +static struct max8998_platform_data universal_lp3974_pdata = {
> +	.num_regulators		= ARRAY_SIZE(lp3974_regulators),
> +	.regulators		= lp3974_regulators,
> +	.buck1_voltage1		= 1100000,	/* INT */
> +	.buck1_voltage2		= 1000000,
> +	.buck1_voltage3		= 1100000,
> +	.buck1_voltage4		= 1000000,
> +	.buck1_set1             = S5PV310_GPX0(5),
                   ^^^^^^^^^^^^^
tab?

> +	.buck1_set2             = S5PV310_GPX0(6),
                   ^^^^^^^^^^^^^
same.

> +	.buck2_voltage1		= 1200000,	/* G3D */
> +	.buck2_voltage2		= 1100000,
> +	.buck1_default_idx	= 0,
> +	.buck2_set3             = S5PV310_GPE2(0),
                   ^^^^^^^^^^^^^
same.

> +	.buck2_default_idx	= 0,
> +	.wakeup			= true,
> +};

(snip)

> @@ -223,6 +661,9 @@ static void __init universal_machine_init(void)
>  	i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
>  	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
> 
> +	s3c_i2c5_set_platdata(NULL);
> +	i2c_register_board_info(5, i2c_devs5, ARRAY_SIZE(i2c_devs5));

How about "i2c5_devs" like others?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
