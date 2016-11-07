From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 7 Nov 2016 19:53:49 +0200
Subject: [PATCH 3/4] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <1478230764-13748-4-git-send-email-pankaj.dubey@samsung.com>
References: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
 <1478230764-13748-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161107175349.GD4865@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 09:09:23AM +0530, Pankaj Dubey wrote:
> Lets remove static mapping of SCU SFR mainly used in CORTEX-A9 SoC based boards.
> Instead use mapping from device tree node of SCU.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c                | 22 ----------------------
>  arch/arm/mach-exynos/include/mach/map.h      |  2 --
>  arch/arm/mach-exynos/platsmp.c               | 18 +++++++++++-------
>  arch/arm/mach-exynos/pm.c                    | 14 +++++++++++---
>  arch/arm/mach-exynos/suspend.c               | 15 +++++++++++----
>  arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ----
>  6 files changed, 33 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 757fc11..fa08ef9 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -28,15 +28,6 @@
>  
>  #include "common.h"
>  
> -static struct map_desc exynos4_iodesc[] __initdata = {
> -	{
> -		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
> -		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
> -		.length		= SZ_8K,
> -		.type		= MT_DEVICE,
> -	},
> -};
> -
>  static struct platform_device exynos_cpuidle = {
>  	.name              = "exynos_cpuidle",
>  #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> @@ -99,17 +90,6 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
>  	return 1;
>  }
>  
> -/*
> - * exynos_map_io
> - *
> - * register the standard cpu IO areas
> - */
> -static void __init exynos_map_io(void)
> -{
> -	if (soc_is_exynos4())
> -		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
> -}
> -
>  static void __init exynos_init_io(void)
>  {
>  	debug_ll_io_init();
> @@ -118,8 +98,6 @@ static void __init exynos_init_io(void)
>  
>  	/* detect cpu id and rev. */
>  	s5p_init_cpu(S5P_VA_CHIPID);
> -
> -	exynos_map_io();
>  }
>  
>  /*
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 5fb0040..0eef407 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -18,6 +18,4 @@
>  
>  #define EXYNOS_PA_CHIPID		0x10000000
>  
> -#define EXYNOS4_PA_COREPERI		0x10500000
> -
>  #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index a5d6841..553d0d9 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -224,11 +224,6 @@ static void write_pen_release(int val)
>  	sync_cache_w(&pen_release);
>  }
>  
> -static void __iomem *scu_base_addr(void)
> -{
> -	return (void __iomem *)(S5P_VA_SCU);
> -}
> -
>  static DEFINE_SPINLOCK(boot_lock);
>  
>  static void exynos_secondary_init(unsigned int cpu)
> @@ -387,14 +382,23 @@ fail:
>  
>  static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>  {
> +	struct device_node *np;
> +	void __iomem *scu_base;
>  	int i;
>  
>  	exynos_sysram_init();
>  
>  	exynos_set_delayed_reset_assertion(true);
>  
> -	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
> -		scu_enable(scu_base_addr());
> +	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
> +		np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
> +		scu_base = of_iomap(np, 0);
> +		if (scu_base) {
> +			scu_enable(scu_base);
> +			iounmap(scu_base);
> +		}
> +		of_node_put(np);

I do not like the duplication - this code appears in three places and
they are the same. Could you split it into separate function?

As you mentioned to Alim, in case of lack of node, it would be nice to notify the
user (pr_err() etc).

Best regards,
Krzysztof
