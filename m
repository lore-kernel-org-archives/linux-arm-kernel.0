From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 28 Jan 2011 18:32:47 +0900
Subject: [PATCH 2/3] ARM: S5PV210: Add supplies for CIF camera on GONI
	board
In-Reply-To: <1294419468-13700-3-git-send-email-s.nawrocki@samsung.com>
References: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
	<1294419468-13700-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <02e101cbbece$55a77790$00f666b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Add regulator supplies required for NOON010PC30 CIF sensor.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-goni.c |   24 +++++++++++++++++++++---
>  1 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index fc34575..2051cee 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -273,6 +273,18 @@ static struct regulator_consumer_supply
> goni_ldo5_consumers[] = {
>  	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
>  };
> 
> +static struct regulator_consumer_supply goni_ldo11_consumers[] = {
> +	REGULATOR_SUPPLY("vddio", "0-0030"), /* "CAM_IO_2.8V" */
> +};

Need array in goni_ldo11_consumers?

+static struct regulator_consumer_supply goni_ldo11_consumers =
+	REGULATOR_SUPPLY("vddio", "0-0030"); /* "CAM_IO_2.8V" */

> +
> +static struct regulator_consumer_supply goni_ldo13_consumers[] = {
> +	REGULATOR_SUPPLY("vdda", "0-0030"), /* "CAM_A_2.8V" */
> +};

Same above.

> +
> +static struct regulator_consumer_supply goni_ldo14_consumers[] = {
> +	REGULATOR_SUPPLY("vdd_core", "0-0030"), /* "CAM_CIF_1.8V" */
> +};

Same above.

> +
>  static struct regulator_init_data goni_ldo2_data = {
>  	.constraints	= {
>  		.name		= "VALIVE_1.1V",
> @@ -371,8 +383,10 @@ static struct regulator_init_data goni_ldo11_data = {
>  		.min_uV		= 2800000,
>  		.max_uV		= 2800000,
>  		.apply_uV	= 1,
> -		.always_on	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
>  	},
> +	.num_consumer_supplies	= ARRAY_SIZE(goni_ldo11_consumers),
> +	.consumer_supplies	= goni_ldo11_consumers,

If you modify as per my suggestion, then need to change this like following.

+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &goni_ldo11_consumers,

>  };
> 
>  static struct regulator_init_data goni_ldo12_data = {
> @@ -391,8 +405,10 @@ static struct regulator_init_data goni_ldo13_data = {
>  		.min_uV		= 2800000,
>  		.max_uV		= 2800000,
>  		.apply_uV	= 1,
> -		.always_on	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
>  	},
> +	.num_consumer_supplies	= ARRAY_SIZE(goni_ldo13_consumers),
> +	.consumer_supplies	= goni_ldo13_consumers,

Same above.

>  };
> 
>  static struct regulator_init_data goni_ldo14_data = {
> @@ -401,8 +417,10 @@ static struct regulator_init_data goni_ldo14_data = {
>  		.min_uV		= 1800000,
>  		.max_uV		= 1800000,
>  		.apply_uV	= 1,
> -		.always_on	= 1,
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
>  	},
> +	.num_consumer_supplies	= ARRAY_SIZE(goni_ldo14_consumers),
> +	.consumer_supplies	= goni_ldo14_consumers,

Same above.

>  };
> 
>  static struct regulator_init_data goni_ldo15_data = {
> --
> 1.7.3.5

If required array in there, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
