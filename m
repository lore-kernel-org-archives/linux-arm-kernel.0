From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Jun 2014 18:13:42 +0200
Subject: [PATCH v2 4/7] ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_*
 macros by static inlines
In-Reply-To: <1401712543-14281-5-git-send-email-b.zolnierkie@samsung.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
 <1401712543-14281-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <538CA2B6.4080805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 02:35 PM, Bartlomiej Zolnierkiewicz wrote:
> Replace EXYNOS_BOOT_VECTOR_ADDR and EXYNOS_BOOT_VECTOR_FLAG macros
> by exynos_boot_vector_addr() and exynos_boot_vector_flag() static
> inlines.
>
> This patch shouldn't cause any functionality changes.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-exynos/pm.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 87c0d34..cf09383 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -166,12 +166,23 @@ int exynos_cluster_power_state(int cluster)
>   			S5P_CORE_LOCAL_PWR_EN);
>   }
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
> +}
> +
> +static inline void __iomem *exynos_boot_vector_flag(void)
> +{
> +	if (samsung_rev() == EXYNOS4210_REV_1_1)
> +		return S5P_INFORM6;
> +	else if (samsung_rev() == EXYNOS4210_REV_1_0)
> +		return sysram_base_addr + 0x20;
> +	return S5P_INFORM1;
> +}
>
>   #define S5P_CHECK_AFTR  0xFCBA0D10
>   #define S5P_CHECK_SLEEP 0x00000BAD
> @@ -184,8 +195,9 @@ static void exynos_set_wakeupmask(long mask)
>
>   static void exynos_cpu_set_boot_vector(long flags)
>   {
> -	__raw_writel(virt_to_phys(exynos_cpu_resume), EXYNOS_BOOT_VECTOR_ADDR);
> -	__raw_writel(flags, EXYNOS_BOOT_VECTOR_FLAG);
> +	__raw_writel(virt_to_phys(exynos_cpu_resume),
> +		     exynos_boot_vector_addr());
> +	__raw_writel(flags, exynos_boot_vector_flag());
>   }
>
>   void exynos_enter_aftr(void)
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
