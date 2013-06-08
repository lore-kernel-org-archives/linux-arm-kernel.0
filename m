From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Jun 2013 12:57:41 +0200
Subject: [PATCH 01/13] ARM: Exynos: initialize l2x0 cache controller only
 for cortex-a9 based SoCs
In-Reply-To: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <5595095.zmTGjttZIk@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

On Thursday 06 of June 2013 16:31:15 Chander Kashyap wrote:
> Only cortex-a9 based Exynos SoCs have l2x0 cache controller. Hence
> instead of checking for every SoC with soc_is_xxx, just check for cpu
> part number and initialize the cache controller for cortex-a9 based
> SoCs.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/mach-exynos/common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c
> b/arch/arm/mach-exynos/common.c index 8ce2db4..bad000e 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -35,6 +35,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cputype.h>
> 
>  #include <mach/regs-irq.h>
>  #include <mach/regs-pmu.h>
> @@ -520,7 +521,7 @@ static int __init exynos4_l2x0_cache_init(void)

I wonder if it shouldn't be done the other way around, i.e. this function 
being called only when running on SoCs for which it's appropriate, instead 
of checking for supported SoC in this function.

Keep in mind that we are going towards multiplatform support, so you would 
end up running this code on any non-Exynos SoC with Cortex A9 as well. 
IMHO we should drop most (if not all) of the initcalls around mach-
exynos/.

CCing people that might have some opinion on this topic as well.

Best regards,
Tomasz

>  {
>  	int ret;
> 
> -	if (soc_is_exynos5250() || soc_is_exynos5440())
> +	if (read_cpuid_part_number() != ARM_CPU_PART_CORTEX_A9)
>  		return 0;
> 
>  	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
