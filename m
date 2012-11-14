From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 15 Nov 2012 00:31:06 +0100
Subject: [PATCH v3 04/11] ARM: Exynos4: Migrate clock support to common
 clock framework
In-Reply-To: <1352930853-12268-5-git-send-email-thomas.abraham@linaro.org>
References: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
 <1352930853-12268-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1496911.LC6ynRgIgc@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 of November 2012 03:37:26 Thomas Abraham wrote:
> Remove Samsung specific clock support in Exynos4 and migrate to use
> common clock framework.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos/Kconfig               |    1 +
>  arch/arm/mach-exynos/Makefile              |    3 -
>  arch/arm/mach-exynos/clock-exynos4.c       | 1602
> ---------------------------- arch/arm/mach-exynos/clock-exynos4.h      
> |   35 -
>  arch/arm/mach-exynos/clock-exynos4210.c    |  188 ----
>  arch/arm/mach-exynos/clock-exynos4212.c    |  192 ----
>  arch/arm/mach-exynos/common.c              |   22 +-
>  arch/arm/mach-exynos/common.h              |    3 +
>  arch/arm/mach-exynos/mach-armlex4210.c     |    1 -
>  arch/arm/mach-exynos/mach-exynos4-dt.c     |    1 -
>  arch/arm/mach-exynos/mach-nuri.c           |    1 -
>  arch/arm/mach-exynos/mach-origen.c         |    1 -
>  arch/arm/mach-exynos/mach-smdk4x12.c       |    1 -
>  arch/arm/mach-exynos/mach-smdkv310.c       |    1 -
>  arch/arm/mach-exynos/mach-universal_c210.c |    1 -
>  arch/arm/mach-exynos/mct.c                 |   19 +
>  arch/arm/plat-samsung/Kconfig              |    4 +-
>  17 files changed, 27 insertions(+), 2049 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.c
>  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.h
>  delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
>  delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c
> 
[snip]
> diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
> index f7792b8..c2e806c 100644
> --- a/arch/arm/mach-exynos/mct.c
> +++ b/arch/arm/mach-exynos/mct.c
> @@ -31,6 +31,7 @@
>  #include <mach/map.h>
>  #include <mach/irqs.h>
>  #include <asm/mach/time.h>
> +#include "common.h"
> 
>  #define EXYNOS4_MCTREG(x)		(x)
>  #define EXYNOS4_MCT_G_CNT_L		EXYNOS4_MCTREG(0x100)
> @@ -517,6 +518,24 @@ static void __init exynos4_timer_init(void)
>  	struct device_node *np;
>  	u32 nr_irqs, i;
> 
> +#ifdef CONFIG_COMMON_CLK
> +	/*
> +	 * Clock lookup should be functional now since the MCT controller
> driver +	 * looks up clocks. So the clock initialization is initiated
> here. +	 */
> +	if (of_have_populated_dt()) {
> +		if (of_machine_is_compatible("samsung,exynos4210") ||
> +			 of_machine_is_compatible("samsung,exynos4212") ||
> +			 of_machine_is_compatible("samsung,exynos4412"))
> +			exynos4_clk_init();
> +	} else {
> +		if (soc_is_exynos4210() || soc_is_exynos4212() ||
> +				soc_is_exynos4412()) {
> +			exynos4_clk_init();
> +		}
> +	}
> +#endif
> +

I don't like the idea of initializing the clocks from timer 
initialization. What about some platforms where MCT isn't used? It is also 
far from being elegant.

Best regards,
Tomasz Figa
