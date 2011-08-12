From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 12 Aug 2011 18:19:06 +0900
Subject: [PATCH] ARM: S3C64XX: Hook up GPIO initiated DVS on Cragganmore
In-Reply-To: <1311627177-26388-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1311627177-26388-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <007201cc58d0$e3f9c2e0$abed48a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Allow us to ramp VDDARM quickly by using a GPIO to signal a voltage change
> instead of doing a register write.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index d59afa1..2005d5f 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -376,6 +376,12 @@ static struct pca953x_platform_data crag6410_pca_data
> = {
>  	.irq_base	= 0,
>  };
> 
> +/* VDDARM is controlled by DVS1 connected to GPK(0) */
> +static struct wm831x_buckv_pdata vddarm_pdata = {
> +	.dvs_control_src = 1,
> +	.dvs_gpio = S3C64XX_GPK(0),
> +};
> +
>  static struct regulator_consumer_supply vddarm_consumers[] __initdata = {
>  	REGULATOR_SUPPLY("vddarm", NULL),
>  };
> @@ -391,6 +397,7 @@ static struct regulator_init_data vddarm __initdata =
{
>  	.num_consumer_supplies = ARRAY_SIZE(vddarm_consumers),
>  	.consumer_supplies = vddarm_consumers,
>  	.supply_regulator = "WALLVDD",
> +	.driver_data = &vddarm_pdata,
>  };
> 
>  static struct regulator_init_data vddint __initdata = {
> @@ -526,6 +533,8 @@ static struct wm831x_pdata crag_pmic_pdata __initdata
=
> {
>  	.backup = &banff_backup_pdata,
> 
>  	.gpio_defaults = {
> +		/* GPIO5: DVS1_REQ - CMOS, DBVDD, active high */
> +		[4] = WM831X_GPN_DIR | WM831X_GPN_POL |
> WM831X_GPN_ENA | 0x8,
>  		/* GPIO11: Touchscreen data - CMOS, DBVDD, active high*/
>  		[10] = WM831X_GPN_POL | WM831X_GPN_ENA | 0x6,
>  		/* GPIO12: Touchscreen pen down - CMOS, DBVDD, active
> high*/
> --
> 1.7.5.4

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
