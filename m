From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 May 2012 10:27:46 -0600
Subject: [PATCH 06/20] ARM: EXYNOS: add GPC4 bank instance
In-Reply-To: <1335813270-13083-7-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120515162747.070303E07AF@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Apr 2012 12:14:16 -0700, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> From: Sangsu Park <sangsu4u.park@samsung.com>
> 
> Add GPC4 bank instance which is included in rev1 of EXYNOS5.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> [kgene.kim at samsung.com: re-worked on top of v3.4-rc3]
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Should be merged with the rest of the series I think.

g.

> ---
>  arch/arm/mach-exynos/include/mach/gpio.h |    9 ++++++---
>  arch/arm/mach-exynos/include/mach/irqs.h |    2 +-
>  drivers/gpio/gpio-samsung.c              |   11 ++++++++++-
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
> index d7498af..eb24f1e 100644
> --- a/arch/arm/mach-exynos/include/mach/gpio.h
> +++ b/arch/arm/mach-exynos/include/mach/gpio.h
> @@ -153,10 +153,11 @@ enum exynos4_gpio_number {
>  #define EXYNOS5_GPIO_B2_NR	(4)
>  #define EXYNOS5_GPIO_B3_NR	(4)
>  #define EXYNOS5_GPIO_C0_NR	(7)
> -#define EXYNOS5_GPIO_C1_NR	(7)
> +#define EXYNOS5_GPIO_C1_NR	(4)
>  #define EXYNOS5_GPIO_C2_NR	(7)
>  #define EXYNOS5_GPIO_C3_NR	(7)
> -#define EXYNOS5_GPIO_D0_NR	(8)
> +#define EXYNOS5_GPIO_C4_NR	(7)
> +#define EXYNOS5_GPIO_D0_NR	(4)
>  #define EXYNOS5_GPIO_D1_NR	(8)
>  #define EXYNOS5_GPIO_Y0_NR	(6)
>  #define EXYNOS5_GPIO_Y1_NR	(4)
> @@ -199,7 +200,8 @@ enum exynos5_gpio_number {
>  	EXYNOS5_GPIO_C1_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C0),
>  	EXYNOS5_GPIO_C2_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C1),
>  	EXYNOS5_GPIO_C3_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C2),
> -	EXYNOS5_GPIO_D0_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C3),
> +	EXYNOS5_GPIO_C4_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C3),
> +	EXYNOS5_GPIO_D0_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C4),
>  	EXYNOS5_GPIO_D1_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_D0),
>  	EXYNOS5_GPIO_Y0_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_D1),
>  	EXYNOS5_GPIO_Y1_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_Y0),
> @@ -242,6 +244,7 @@ enum exynos5_gpio_number {
>  #define EXYNOS5_GPC1(_nr)	(EXYNOS5_GPIO_C1_START + (_nr))
>  #define EXYNOS5_GPC2(_nr)	(EXYNOS5_GPIO_C2_START + (_nr))
>  #define EXYNOS5_GPC3(_nr)	(EXYNOS5_GPIO_C3_START + (_nr))
> +#define EXYNOS5_GPC4(_nr)	(EXYNOS5_GPIO_C4_START + (_nr))
>  #define EXYNOS5_GPD0(_nr)	(EXYNOS5_GPIO_D0_START + (_nr))
>  #define EXYNOS5_GPD1(_nr)	(EXYNOS5_GPIO_D1_START + (_nr))
>  #define EXYNOS5_GPY0(_nr)	(EXYNOS5_GPIO_Y0_START + (_nr))
> diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
> index ef52f61..ece5624 100644
> --- a/arch/arm/mach-exynos/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos/include/mach/irqs.h
> @@ -446,7 +446,7 @@
>  
>  #define EXYNOS5_MAX_COMBINER_NR		32
>  
> -#define EXYNOS5_IRQ_GPIO1_NR_GROUPS	13
> +#define EXYNOS5_IRQ_GPIO1_NR_GROUPS	14
>  #define EXYNOS5_IRQ_GPIO2_NR_GROUPS	9
>  #define EXYNOS5_IRQ_GPIO3_NR_GROUPS	5
>  #define EXYNOS5_IRQ_GPIO4_NR_GROUPS	1
> diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
> index 19d6fc0..0a2087b 100644
> --- a/drivers/gpio/gpio-samsung.c
> +++ b/drivers/gpio/gpio-samsung.c
> @@ -2452,6 +2452,12 @@ static struct samsung_gpio_chip exynos5_gpios_1[] = {
>  		},
>  	}, {
>  		.chip	= {
> +			.base	= EXYNOS5_GPC4(0),
> +			.ngpio	= EXYNOS5_GPIO_C4_NR,
> +			.label	= "GPC4",
> +		},
> +	}, {
> +		.chip	= {
>  			.base	= EXYNOS5_GPD0(0),
>  			.ngpio	= EXYNOS5_GPIO_D0_NR,
>  			.label	= "GPD0",
> @@ -2874,8 +2880,11 @@ static __init int samsung_gpiolib_init(void)
>  			goto err_ioremap1;
>  		}
>  
> +		/* need to set base address for gpc4 */
> +		exynos5_gpios_1[11].base = gpio_base1 + 0x2E0;
> +
>  		/* need to set base address for gpx */
> -		chip = &exynos5_gpios_1[20];
> +		chip = &exynos5_gpios_1[21];
>  		gpx_base = gpio_base1 + 0xC00;
>  		for (i = 0; i < 4; i++, chip++, gpx_base += 0x20)
>  			chip->base = gpx_base;
> -- 
> 1.7.5.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
