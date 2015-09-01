From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 01 Sep 2015 09:08:24 +0900
Subject: [PATCH] ARM: EXYNOS: reset KFC cores when cpu is up
In-Reply-To: <1441031111-6549-1-git-send-email-parkch98@gmail.com>
References: <1441031111-6549-1-git-send-email-parkch98@gmail.com>
Message-ID: <55E4EC78.8050507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.08.2015 23:25, Chanho Park wrote:
> The cpu booting of exynos5422 has been still broken since we discussed
s/cpu/CPU/ (here and in other places)

> it in last year[1]. This patch is inspired from odroid xu3

s/odroid xu3/Odroid XU3/

> code(Actually, it was from samsung exynos vendor kernel)[2]. This weird

Space before parenthesis.

> reset code was founded exynos5420 octa cores series SoCs and only
> required for the first boot core is the little core(kingfisher core).

Again space before parenthesis.

> Some of the exynos5420 boards and all of the exynos5422 boards will be
> required this code.

s/will be required/require/

> There is two ways to check the little core is the first cpu. One is
> checking GPG2CON[1] gpio value and the other is checking the cluster

s/gpio/GPIO/

> number of the first cpu. I selected the latter because it's more easier
> than the former.
> 
> Changes since RFC[3]:
> - drop checking soc_is_exynos5800 to extend this codes to
> exynos5420/5422 boards.
> - kfc cores will be reset only if the cpu0 is kfc core.
> - Rebase top of the kukjin's for-next branch

Changelog and its references ([3]) goes after '---'.

> 
> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350632.html
> [2]:https://patchwork.kernel.org/patch/6782891/
> [3]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356610.html


> 
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Heesub Shin <heesub.shin@samsung.com>
> Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> Cc: Przemyslaw Marczak <p.marczak@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanho Park <parkch98@gmail.com>

That's a huge CC-list. Everyone are important to CC? Definitely you can
remove me because I appear as a maintainer. :)
I think you can leave only people who participated in the recent
discussions.

> ---
>  arch/arm/mach-exynos/mcpm-exynos.c | 18 +++++++++++++++++-
>  arch/arm/mach-exynos/regs-pmu.h    |  6 ++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 9bdf547..5b69ed2 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -20,6 +20,7 @@
>  #include <asm/cputype.h>
>  #include <asm/cp15.h>
>  #include <asm/mcpm.h>
> +#include <asm/smp_plat.h>
>  
>  #include "regs-pmu.h"
>  #include "common.h"
> @@ -70,7 +71,22 @@ static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>  		cluster >= EXYNOS5420_NR_CLUSTERS)
>  		return -EINVAL;
>  
> -	exynos_cpu_power_up(cpunr);
> +	if (!exynos_cpu_power_state(cpunr)) {
> +		exynos_cpu_power_up(cpunr);
> +
> +		/* This assumes the cluster number of the eagle is 0 and the
> +		 * kfc is 1. When the system was booted from the kfc core,
> +		 * they should be reset */
> +		if (cluster &&
> +		    cluster == MPIDR_AFFINITY_LEVEL(cpu_logical_map(0), 1)) {

I already asked for that - please describe what happens here. Why we are
spinning on SPARE2? At least one or two lines. Grepping through commits
or mailing lists is less efficient than looking at comment at code.

Everything boils to firmware on Exynos5422 boards which uses SPARE2 as
synchronisation mechanism. After powering up a CPU, if SPARE2 is not set
to 1, then firmware (BL1 or code in IROM) spins over it and we can
safely execute software reset.

The patch is itself good, just please fix these minor nits.

Best regards,
Krzysztof


> +			while (!pmu_raw_readl(S5P_PMU_SPARE2))
> +				udelay(10);
> +
> +			pmu_raw_writel(EXYNOS5420_KFC_CORE_RESET(cpu),
> +					EXYNOS_SWRESET);
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
> index b761433..fba9068 100644
> --- a/arch/arm/mach-exynos/regs-pmu.h
> +++ b/arch/arm/mach-exynos/regs-pmu.h
> @@ -513,6 +513,12 @@ static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
>  #define SPREAD_ENABLE						0xF
>  #define SPREAD_USE_STANDWFI					0xF
>  
> +#define EXYNOS5420_KFC_CORE_RESET0				BIT(8)
> +#define EXYNOS5420_KFC_ETM_RESET0				BIT(20)
> +
> +#define EXYNOS5420_KFC_CORE_RESET(_nr)				\
> +	((EXYNOS5420_KFC_CORE_RESET0 | EXYNOS5420_KFC_ETM_RESET0) << (_nr))
> +
>  #define EXYNOS5420_BB_CON1					0x0784
>  #define EXYNOS5420_BB_SEL_EN					BIT(31)
>  #define EXYNOS5420_BB_PMOS_EN					BIT(7)
> 
