From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 17:36:34 -0700
Subject: [PATCH 08/12] gpio/samsung: add GPC4 bank instance
In-Reply-To: <1334641595-25301-9-git-send-email-thomas.abraham@linaro.org>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-9-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F8F5E12.6030800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> From: Sangsu Park<sangsu4u.park@samsung.com>
> 
> Add GPC4 bank instance which is included in rev1 of Exynos5.
> 
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Signed-off-by: Sangsu Park<sangsu4u.park@samsung.com>

Where is your sign??? Your sign MUST be included here.

> ---
>   arch/arm/mach-exynos/include/mach/gpio.h |    9 ++++++---
>   drivers/gpio/gpio-samsung.c              |    8 ++++++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
> index d7498af..df5612b 100644
> --- a/arch/arm/mach-exynos/include/mach/gpio.h
> +++ b/arch/arm/mach-exynos/include/mach/gpio.h
> @@ -153,10 +153,11 @@ enum exynos4_gpio_number {
>   #define EXYNOS5_GPIO_B2_NR	(4)
>   #define EXYNOS5_GPIO_B3_NR	(4)
>   #define EXYNOS5_GPIO_C0_NR	(7)
> -#define EXYNOS5_GPIO_C1_NR	(7)
> +#define EXYNOS5_GPIO_C1_NR	(4)
>   #define EXYNOS5_GPIO_C2_NR	(7)
>   #define EXYNOS5_GPIO_C3_NR	(7)
> -#define EXYNOS5_GPIO_D0_NR	(8)
> +#define EXYNOS5_GPIO_C4_NR	(8)

Should be 7. See the manual again :-(

> +#define EXYNOS5_GPIO_D0_NR	(4)
>   #define EXYNOS5_GPIO_D1_NR	(8)
>   #define EXYNOS5_GPIO_Y0_NR	(6)
>   #define EXYNOS5_GPIO_Y1_NR	(4)
> @@ -199,7 +200,8 @@ enum exynos5_gpio_number {
>   	EXYNOS5_GPIO_C1_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C0),
>   	EXYNOS5_GPIO_C2_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C1),
>   	EXYNOS5_GPIO_C3_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C2),
> -	EXYNOS5_GPIO_D0_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C3),
> +	EXYNOS5_GPIO_C4_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C3),
> +	EXYNOS5_GPIO_D0_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C4),
>   	EXYNOS5_GPIO_D1_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_D0),
>   	EXYNOS5_GPIO_Y0_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_D1),
>   	EXYNOS5_GPIO_Y1_START		= EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_Y0),
> @@ -242,6 +244,7 @@ enum exynos5_gpio_number {
>   #define EXYNOS5_GPC1(_nr)	(EXYNOS5_GPIO_C1_START + (_nr))
>   #define EXYNOS5_GPC2(_nr)	(EXYNOS5_GPIO_C2_START + (_nr))
>   #define EXYNOS5_GPC3(_nr)	(EXYNOS5_GPIO_C3_START + (_nr))
> +#define EXYNOS5_GPC4(_nr)	(EXYNOS5_GPIO_C4_START + (_nr))
>   #define EXYNOS5_GPD0(_nr)	(EXYNOS5_GPIO_D0_START + (_nr))
>   #define EXYNOS5_GPD1(_nr)	(EXYNOS5_GPIO_D1_START + (_nr))
>   #define EXYNOS5_GPY0(_nr)	(EXYNOS5_GPIO_Y0_START + (_nr))
> diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
> index 4627787..0153bb9 100644
> --- a/drivers/gpio/gpio-samsung.c
> +++ b/drivers/gpio/gpio-samsung.c
> @@ -2452,6 +2452,12 @@ static struct samsung_gpio_chip exynos5_gpios_1[] = {
>   		},
>   	}, {
>   		.chip	= {
> +			.base	= EXYNOS5_GPC4(0),
> +			.ngpio	= EXYNOS5_GPIO_C4_NR,
> +			.label	= "GPC4",
> +		},
> +	}, {
> +		.chip	= {
>   			.base	= EXYNOS5_GPD0(0),
>   			.ngpio	= EXYNOS5_GPIO_D0_NR,
>   			.label	= "GPD0",
> @@ -2880,6 +2886,8 @@ static __init int samsung_gpiolib_init(void)
>   		for (i = 0; i<  4; i++, chip++, gpx_base += 0x20)
>   			chip->base = gpx_base;
> 
> +		exynos5_gpios_1[11].base = gpio_base1 + 0x2E0;
> +
>   		chip = exynos5_gpios_1;
>   		nr_chips = ARRAY_SIZE(exynos5_gpios_1);
> 

This is wrong. If you add GPC4 between GPC3 and GPD0, you need to
increase the gpx's counter like following and need to update
IRQ_GPIO1_NR_GROUPS as well.

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 19d6fc0..1af0fa5 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2875,7 +2875,7 @@ static __init int samsung_gpiolib_init(void)
                }

                /* need to set base address for gpx */
-               chip = &exynos5_gpios_1[20];
+               chip = &exynos5_gpios_1[21];
                gpx_base = gpio_base1 + 0xC00;
                for (i = 0; i < 4; i++, chip++, gpx_base += 0x20)
                        chip->base = gpx_base;

diff --git a/arch/arm/mach-exynos/include/mach/irqs.h
b/arch/arm/mach-exynos/inc
index 591e785..887788d 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -446,7 +446,7 @@

 #define EXYNOS5_MAX_COMBINER_NR                32

-#define EXYNOS5_IRQ_GPIO1_NR_GROUPS    13
+#define EXYNOS5_IRQ_GPIO1_NR_GROUPS    14
 #define EXYNOS5_IRQ_GPIO2_NR_GROUPS    9
 #define EXYNOS5_IRQ_GPIO3_NR_GROUPS    5
 #define EXYNOS5_IRQ_GPIO4_NR_GROUPS    1


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
