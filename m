From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 16:15:49 +0000
Subject: [PATCH v3 09/12] ARM: EXYNOS: add support get_core_count() for
 EXYNOS5250
In-Reply-To: <1331652643-12626-10-git-send-email-kgene.kim@samsung.com>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
 <1331652643-12626-10-git-send-email-kgene.kim@samsung.com>
Message-ID: <201203131615.49846.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Kukjin Kim wrote:
> The EXYNOS5250 has two Cortex-A15 cores and there's no
> need to call scu_enable() in platform_smp_prepare_cpus().
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Can you explain this patch more? It only seems to make the
code less generic, but there is no indication if calling
the scu_get_core_count() function is actually wrong on
exynos5.

	Arnd

> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 0f2035a..36c3984 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -166,7 +166,10 @@ void __init smp_init_cpus(void)
>         void __iomem *scu_base = scu_base_addr();
>         unsigned int i, ncores;
>  
> -       ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> +       if (soc_is_exynos5250())
> +               ncores = 2;
> +       else
> +               ncores = scu_base ? scu_get_core_count(scu_base) : 1;
>  
>         /* sanity check */
>         if (ncores > nr_cpu_ids) {
> @@ -183,8 +186,8 @@ void __init smp_init_cpus(void)
>  
>  void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>  {
> -
> -       scu_enable(scu_base_addr());
> +       if (!soc_is_exynos5250())
> +               scu_enable(scu_base_addr());
>  
>         /*
>          * Write the address of secondary startup into the
