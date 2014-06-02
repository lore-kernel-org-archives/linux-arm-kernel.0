From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 02 Jun 2014 15:05:40 +0200
Subject: [PATCH v2 4/7] ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_*
 macros by static inlines
In-Reply-To: <1401712543-14281-5-git-send-email-b.zolnierkie@samsung.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
 <1401712543-14281-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <538C76A4.8050508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> Replace EXYNOS_BOOT_VECTOR_ADDR and EXYNOS_BOOT_VECTOR_FLAG macros
> by exynos_boot_vector_addr() and exynos_boot_vector_flag() static
> inlines.
> 
> This patch shouldn't cause any functionality changes.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 87c0d34..cf09383 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -166,12 +166,23 @@ int exynos_cluster_power_state(int cluster)
>  			S5P_CORE_LOCAL_PWR_EN);
>  }
>  
> -#define EXYNOS_BOOT_VECTOR_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
> -			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
> -			(sysram_base_addr + 0x24) : S5P_INFORM0))
> -#define EXYNOS_BOOT_VECTOR_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
> -			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
> -			(sysram_base_addr + 0x20) : S5P_INFORM1))
> +static inline void __iomem *exynos_boot_vector_addr(void)
> +{
> +	if (samsung_rev() == EXYNOS4210_REV_1_1)
> +		return S5P_INFORM7;
> +	else if (samsung_rev() == EXYNOS4210_REV_1_0)
> +		return sysram_base_addr + 0x24;
> +	return S5P_INFORM0;

I know this is not strictly related to this patch, but isn't a check
whether the SoC is Exynos4210 also needed, before comparing the revision
with Exynos4210-specific values?

Otherwise looks good.

Best regards,
Tomasz
