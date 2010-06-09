From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 Jun 2010 21:10:38 +0900
Subject: [PATCH] arm: s5pv210: add more banks to gpiolib
In-Reply-To: <1276072833-4862-1-git-send-email-m.szyprowski@samsung.com>
References: <1276072833-4862-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <010301cb07cc$c8affa50$5a0feef0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch adds support for MP04 and MP05 gpio banks. Pins from these
> banks will be used by Samsung Aquila board.
> 
Hi,

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> ---
>  arch/arm/mach-s5pv210/gpiolib.c           |   17 +++++++++++++++++
>  arch/arm/mach-s5pv210/include/mach/gpio.h |   10 ++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/gpiolib.c
b/arch/arm/mach-s5pv210/gpiolib.c
> index f4ac81f..6f74a98 100644
> --- a/arch/arm/mach-s5pv210/gpiolib.c
> +++ b/arch/arm/mach-s5pv210/gpiolib.c
> @@ -208,6 +208,22 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
>  			.label	= "MP03",
>  		},
>  	}, {
> +		.base	= (S5P_VA_GPIO + 0x340),

don't need .base
it can be calculated in s5pv210_gpiolib_init()

> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP04(0),
> +			.ngpio	= S5PV210_GPIO_MP04_NR,
> +			.label	= "MP04",
> +		},
> +	}, {
> +		.base	= (S5P_VA_GPIO + 0x360),

same

> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP05(0),
> +			.ngpio	= S5PV210_GPIO_MP05_NR,
> +			.label	= "MP05",
> +		},
> +	}, {
>  		.base	= (S5P_VA_GPIO + 0xC00),
>  		.config	= &gpio_cfg_noint,
>  		.chip	= {
> @@ -244,6 +260,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
>  			.to_irq = s5p_gpiolib_eint_to_irq,
>  		},
>  	},
> +

redundant empty line

>  };
> 
>  static __init int s5pv210_gpiolib_init(void)
> diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-
> s5pv210/include/mach/gpio.h
> index d6461ba..33a9867 100644
> --- a/arch/arm/mach-s5pv210/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
> @@ -52,6 +52,8 @@
>  #define S5PV210_GPIO_MP01_NR	(8)
>  #define S5PV210_GPIO_MP02_NR	(4)
>  #define S5PV210_GPIO_MP03_NR	(8)
> +#define S5PV210_GPIO_MP04_NR	(8)
> +#define S5PV210_GPIO_MP05_NR	(8)
> 
>  /* GPIO bank numbers */
> 
> @@ -94,6 +96,8 @@ enum s5p_gpio_number {
>  	S5PV210_GPIO_MP01_START	=
> S5PV210_GPIO_NEXT(S5PV210_GPIO_J4),
>  	S5PV210_GPIO_MP02_START	=
> S5PV210_GPIO_NEXT(S5PV210_GPIO_MP01),
>  	S5PV210_GPIO_MP03_START	=
> S5PV210_GPIO_NEXT(S5PV210_GPIO_MP02),
> +	S5PV210_GPIO_MP04_START	=
> S5PV210_GPIO_NEXT(S5PV210_GPIO_MP03),
> +	S5PV210_GPIO_MP05_START	=
> S5PV210_GPIO_NEXT(S5PV210_GPIO_MP04),
>  };
> 
>  /* S5PV210 GPIO number definitions */
> @@ -127,13 +131,15 @@ enum s5p_gpio_number {
>  #define S5PV210_MP01(_nr)	(S5PV210_GPIO_MP01_START + (_nr))
>  #define S5PV210_MP02(_nr)	(S5PV210_GPIO_MP02_START + (_nr))
>  #define S5PV210_MP03(_nr)	(S5PV210_GPIO_MP03_START + (_nr))
> +#define S5PV210_MP04(_nr)	(S5PV210_GPIO_MP04_START + (_nr))
> +#define S5PV210_MP05(_nr)	(S5PV210_GPIO_MP05_START + (_nr))
> 
>  /* the end of the S5PV210 specific gpios */
> -#define S5PV210_GPIO_END	(S5PV210_MP03(S5PV210_GPIO_MP03_NR) +
> 1)
> +#define S5PV210_GPIO_END	(S5PV210_MP05(S5PV210_GPIO_MP05_NR) +
> 1)
>  #define S3C_GPIO_END		S5PV210_GPIO_END
> 
>  /* define the number of gpios we need to the one after the MP03() range */

need to modify to MP05()

> -#define ARCH_NR_GPIOS
> 	(S5PV210_MP03(S5PV210_GPIO_MP03_NR) +	\
> +#define ARCH_NR_GPIOS
> 	(S5PV210_MP05(S5PV210_GPIO_MP05_NR) +	\
>  				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
> 
>  #include <asm-generic/gpio.h>
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
