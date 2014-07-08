From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:28:09 +0200
Subject: [PATCH v6 2/4] ARM: EXYNOS: Refactored code for using PMU address
 via DT
In-Reply-To: <1404710376-16448-3-git-send-email-pankaj.dubey@samsung.com>
References: <1404710376-16448-1-git-send-email-pankaj.dubey@samsung.com>
 <1404710376-16448-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53BBFFF9.5020306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

Except one minor comment inline, looks good.

On 07.07.2014 07:19, Pankaj Dubey wrote:

[snip]

> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 9315ba9..8f6a111 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -55,7 +55,7 @@
>  	"dsb\n\t" \
>  	"ldmfd	sp!, {fp, ip}" \
>  	: \
> -	: "Ir" (S5P_INFORM0) \
> +	: "Ir" (pmu_base_addr + S5P_INFORM0) \
>  	: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
>  	  "r9", "r10", "lr", "memory")
>  
> @@ -337,7 +337,8 @@ static int __init exynos_mcpm_init(void)
>  	 * To increase the stability of KFC reset we need to program
>  	 * the PMU SPARE3 register
>  	 */
> -	__raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
> +	__raw_writel(EXYNOS5420_SWRESET_KFC_SEL,
> +			pmu_base_addr + S5P_PMU_SPARE3);

Here's yet another place where pmu_raw_writel() helper could be used.
Maybe move them to a header, even common.h and then use whenever PMU is
accessed in arch code.

With this minor thing fixed, feel free to add

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
