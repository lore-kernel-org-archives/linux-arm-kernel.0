From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Aug 2012 09:21:40 -0700
Subject: [PATCH] ARM: EXYNOS: Add support for secondary CPU bring-up on
 Exynos4412
In-Reply-To: <1422318.SfZfh0XoVo@amdc1227>
References: <1422318.SfZfh0XoVo@amdc1227>
Message-ID: <503CF014.8010503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/28/2012 4:13 AM, Tomasz Figa wrote:
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 36c3984..1114ced 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -34,8 +34,19 @@
>  
>  extern void exynos4_secondary_startup(void);
>  
> -#define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1 ? \
> -				S5P_INFORM5 : S5P_VA_SYSRAM)
> +static inline volatile void *cpu_boot_reg_base(void)

__iomem?

> +{
> +	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
> +		return S5P_INFORM5;
> +	return S5P_VA_SYSRAM;
> +}
> +
> +static inline volatile void *cpu_boot_reg(int cpu)

__iomem? And why volatile?

> +{
> +	if (soc_is_exynos4412())
> +		return cpu_boot_reg_base() + 4*cpu;
> +	return cpu_boot_reg_base();
> +}
>  
>  /*
>   * control for which core is the next to come out of the secondary
> @@ -195,6 +208,8 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>  	 * until it receives a soft interrupt, and then the
>  	 * secondary CPU branches to this address.
>  	 */
> -	__raw_writel(virt_to_phys(exynos4_secondary_startup),
> -			CPU1_BOOT_REG);
> +	for (i = 1; i < max_cpus; ++i) {
> +		__raw_writel(virt_to_phys(exynos4_secondary_startup),
> +							cpu_boot_reg(i));

Do you need to use cpu_logical_map()?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
