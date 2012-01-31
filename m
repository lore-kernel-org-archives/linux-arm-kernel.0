From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 31 Jan 2012 17:34:02 +0100
Subject: [PATCH 1/2] ARM: EXYNOS: add support GPIO for EXYNOS5250
In-Reply-To: <1328025040-4751-2-git-send-email-kgene.kim@samsung.com>
References: <1328025040-4751-1-git-send-email-kgene.kim@samsung.com>
 <1328025040-4751-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <4F2817FA.5020407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

I have few comments below...

On 01/31/2012 04:50 PM, Kukjin Kim wrote:
> From: Sangsu Park <sangsu4u.park@samsung.com>
> 
> This patch adds follwing.

s/follwing/following.

nit: AFAIK it's a good habit not to start a commit description
with "This patch.."

> - IO-map for EXYNOS5250 GPIO support
> - EXYNOS5250 GPIO bank size/number definitions
> - memory map definition for S5P GPIO4
> 
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/common.c                |   20 +++
>  arch/arm/mach-exynos/include/mach/gpio.h     |  221 ++++++++++++++++++++------
>  arch/arm/mach-exynos/include/mach/map.h      |    4 +
>  arch/arm/plat-samsung/include/plat/map-s5p.h |    1 +
>  4 files changed, 199 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 6ab3c5a..225acc7 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -271,6 +271,26 @@ static struct map_desc exynos5_iodesc[] __initdata = {
>  		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_DIST),
>  		.length		= SZ_64K,
>  		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_GPIO1,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_GPIO1),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_GPIO2,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_GPIO2),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_GPIO3,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_GPIO3),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_GPIO4,
> +		.pfn		= __phys_to_pfn(EXYNOS5_PA_GPIO4),
> +		.length		= SZ_256,
> +		.type		= MT_DEVICE,
>  	},
>  };
>  
> diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
> index 80523ca..a9c3944 100644
> --- a/arch/arm/mach-exynos/include/mach/gpio.h
> +++ b/arch/arm/mach-exynos/include/mach/gpio.h
> @@ -13,8 +13,11 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
>  
> -/* Practically, GPIO banks up to GPZ are the configurable gpio banks */
> +/* MACRO for EXYNOS GPIO numbering */
> +#define EXYNOS_GPIO_NEXT(__gpio) \
> +	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
>  
> +/* EXYNOS4 serise */
>  /* GPIO bank sizes */
>  #define EXYNOS4_GPIO_A0_NR	(8)
>  #define EXYNOS4_GPIO_A1_NR	(6)
> @@ -55,51 +58,47 @@
>  #define EXYNOS4_GPIO_Z_NR	(7)
>  
>  /* GPIO bank numbers */
> -
> -#define EXYNOS4_GPIO_NEXT(__gpio) \
> -	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
> -
> -enum s5p_gpio_number {
> +enum exynos4_gpio_number {
>  	EXYNOS4_GPIO_A0_START	= 0,
> -	EXYNOS4_GPIO_A1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_A0),
> -	EXYNOS4_GPIO_B_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_A1),
> -	EXYNOS4_GPIO_C0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_B),
> -	EXYNOS4_GPIO_C1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_C0),
> -	EXYNOS4_GPIO_D0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_C1),
> -	EXYNOS4_GPIO_D1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_D0),
> -	EXYNOS4_GPIO_E0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_D1),
> -	EXYNOS4_GPIO_E1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E0),
> -	EXYNOS4_GPIO_E2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E1),
> -	EXYNOS4_GPIO_E3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E2),
> -	EXYNOS4_GPIO_E4_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E3),
> -	EXYNOS4_GPIO_F0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E4),
> -	EXYNOS4_GPIO_F1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F0),
> -	EXYNOS4_GPIO_F2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F1),
> -	EXYNOS4_GPIO_F3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F2),
> -	EXYNOS4_GPIO_J0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F3),
> -	EXYNOS4_GPIO_J1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_J0),
> -	EXYNOS4_GPIO_K0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_J1),
> -	EXYNOS4_GPIO_K1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K0),
> -	EXYNOS4_GPIO_K2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K1),
> -	EXYNOS4_GPIO_K3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K2),
> -	EXYNOS4_GPIO_L0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K3),
> -	EXYNOS4_GPIO_L1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_L0),
> -	EXYNOS4_GPIO_L2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_L1),
> -	EXYNOS4_GPIO_X0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_L2),
> -	EXYNOS4_GPIO_X1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X0),
> -	EXYNOS4_GPIO_X2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X1),
> -	EXYNOS4_GPIO_X3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X2),
> -	EXYNOS4_GPIO_Y0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X3),
> -	EXYNOS4_GPIO_Y1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_Y0),
> -	EXYNOS4_GPIO_Y2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_Y1),
> -	EXYNOS4_GPIO_Y3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_Y2),
> -	EXYNOS4_GPIO_Y4_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_Y3),
> -	EXYNOS4_GPIO_Y5_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_Y4),
> -	EXYNOS4_GPIO_Y6_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_Y5),
> -	EXYNOS4_GPIO_Z_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_Y6),
> +	EXYNOS4_GPIO_A1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_A0),
> +	EXYNOS4_GPIO_B_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_A1),
> +	EXYNOS4_GPIO_C0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_B),
> +	EXYNOS4_GPIO_C1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_C0),
> +	EXYNOS4_GPIO_D0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_C1),
> +	EXYNOS4_GPIO_D1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D0),
> +	EXYNOS4_GPIO_E0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D1),
> +	EXYNOS4_GPIO_E1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E0),
> +	EXYNOS4_GPIO_E2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E1),
> +	EXYNOS4_GPIO_E3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E2),
> +	EXYNOS4_GPIO_E4_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E3),
> +	EXYNOS4_GPIO_F0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E4),
> +	EXYNOS4_GPIO_F1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F0),
> +	EXYNOS4_GPIO_F2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F1),
> +	EXYNOS4_GPIO_F3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F2),
> +	EXYNOS4_GPIO_J0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F3),
> +	EXYNOS4_GPIO_J1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_J0),
> +	EXYNOS4_GPIO_K0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_J1),
> +	EXYNOS4_GPIO_K1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_K0),
> +	EXYNOS4_GPIO_K2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_K1),
> +	EXYNOS4_GPIO_K3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_K2),
> +	EXYNOS4_GPIO_L0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_K3),
> +	EXYNOS4_GPIO_L1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_L0),
> +	EXYNOS4_GPIO_L2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_L1),
> +	EXYNOS4_GPIO_X0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_L2),
> +	EXYNOS4_GPIO_X1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_X0),
> +	EXYNOS4_GPIO_X2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_X1),
> +	EXYNOS4_GPIO_X3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_X2),
> +	EXYNOS4_GPIO_Y0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_X3),
> +	EXYNOS4_GPIO_Y1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_Y0),
> +	EXYNOS4_GPIO_Y2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_Y1),
> +	EXYNOS4_GPIO_Y3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_Y2),
> +	EXYNOS4_GPIO_Y4_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_Y3),
> +	EXYNOS4_GPIO_Y5_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_Y4),
> +	EXYNOS4_GPIO_Y6_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_Y5),
> +	EXYNOS4_GPIO_Z_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_Y6),
>  };

Are you planning to add support for exynos4212/exynos4412 as well
anytime soon ? I've done some work towards this and I'd like to
avoid duplicating efforts.

> -/* EXYNOS4 GPIO number definitions */
> +/* GPIO number definitions */
>  #define EXYNOS4_GPA0(_nr)	(EXYNOS4_GPIO_A0_START + (_nr))
>  #define EXYNOS4_GPA1(_nr)	(EXYNOS4_GPIO_A1_START + (_nr))
>  #define EXYNOS4_GPB(_nr)	(EXYNOS4_GPIO_B_START + (_nr))
> @@ -140,10 +139,138 @@ enum s5p_gpio_number {
>  
>  /* the end of the EXYNOS4 specific gpios */
>  #define EXYNOS4_GPIO_END	(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) + 1)
> -#define S3C_GPIO_END		EXYNOS4_GPIO_END
>  
> -/* define the number of gpios we need to the one after the GPZ() range */
> -#define ARCH_NR_GPIOS		(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) +	\
> -				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
> +/* EXYNOS5 serise */
> +/* GPIO bank sizes */
> +#define EXYNOS5_GPIO_A0_NR	(8)

nit: It's been always a mystery to me, what are the parentheses around the
numbers helpful for ? IMHO even if there is more things like this in
the file it might be better to skip extra parentheses here.

> +#define EXYNOS5_GPIO_A1_NR	(6)
> +#define EXYNOS5_GPIO_A2_NR	(8)
> +#define EXYNOS5_GPIO_B0_NR	(5)
> +#define EXYNOS5_GPIO_B1_NR	(5)
> +#define EXYNOS5_GPIO_B2_NR	(4)
> +#define EXYNOS5_GPIO_B3_NR	(4)
> +#define EXYNOS5_GPIO_C0_NR	(7)
> +#define EXYNOS5_GPIO_C1_NR	(7)
> +#define EXYNOS5_GPIO_C2_NR	(7)
> +#define EXYNOS5_GPIO_C3_NR	(7)
> +#define EXYNOS5_GPIO_D0_NR	(8)
> +#define EXYNOS5_GPIO_D1_NR	(8)
> +#define EXYNOS5_GPIO_Y0_NR	(6)
> +#define EXYNOS5_GPIO_Y1_NR	(4)
> +#define EXYNOS5_GPIO_Y2_NR	(6)
> +#define EXYNOS5_GPIO_Y3_NR	(8)
> +#define EXYNOS5_GPIO_Y4_NR	(8)
> +#define EXYNOS5_GPIO_Y5_NR	(8)
> +#define EXYNOS5_GPIO_Y6_NR	(8)
> +#define EXYNOS5_GPIO_X0_NR	(8)
> +#define EXYNOS5_GPIO_X1_NR	(8)
> +#define EXYNOS5_GPIO_X2_NR	(8)
> +#define EXYNOS5_GPIO_X3_NR	(8)
> +#define EXYNOS5_GPIO_E0_NR	(8)
> +#define EXYNOS5_GPIO_E1_NR	(2)
> +#define EXYNOS5_GPIO_F0_NR	(4)
> +#define EXYNOS5_GPIO_F1_NR	(4)
> +#define EXYNOS5_GPIO_G0_NR	(8)
> +#define EXYNOS5_GPIO_G1_NR	(8)
> +#define EXYNOS5_GPIO_G2_NR	(2)
> +#define EXYNOS5_GPIO_H0_NR	(4)
> +#define EXYNOS5_GPIO_H1_NR	(8)
> +#define EXYNOS5_GPIO_V0_NR	(8)
> +#define EXYNOS5_GPIO_V1_NR	(8)
> +#define EXYNOS5_GPIO_V2_NR	(8)
> +#define EXYNOS5_GPIO_V3_NR	(8)
> +#define EXYNOS5_GPIO_V4_NR	(2)
> +#define EXYNOS5_GPIO_Z_NR	(7)

Thanks,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
