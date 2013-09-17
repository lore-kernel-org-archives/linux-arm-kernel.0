From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 17 Sep 2013 12:45:21 +0200
Subject: [PATCH] ARM: EXYNOS: remove CONFIG_MACH_EXYNOS[4,5]_DT config
 options
In-Reply-To: <3809234.0NkWBIjRC9@amdc1032>
References: <3809234.0NkWBIjRC9@amdc1032>
Message-ID: <2298139.uMOnikAvfC@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bart,

On Friday 13 of September 2013 11:28:31 Bartlomiej Zolnierkiewicz wrote:
> EXYNOS is now Device Tree (DT) only platform so it makes no sense to have
> config options responsible for enabling platform specific DT support.
> 
> Moreover the kernel image won't even link if neither
> CONFIG_MACH_EXYNOS4_DT nor CONFIG_MACH_EXYNOS5_DT config option is
> enabled (linker fails with "no machine record defined" error).
> 
> Remove CONFIG_MACH_EXYNOS[4,5]_DT config options and just use the
> standard CONFIG_ARCH_EXYNOS[4,5] ones instead.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig |  1 -
>  arch/arm/mach-exynos/Kconfig      | 38
> +++++++++----------------------------- arch/arm/mach-exynos/Makefile    
> |  4 ++--
>  3 files changed, 11 insertions(+), 32 deletions(-)

Generally I see this as a nice cleanup, but I'd go even further than this. 
See below.

> diff --git a/arch/arm/configs/exynos_defconfig
> b/arch/arm/configs/exynos_defconfig index ad7dfbb..5181d0d 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -11,7 +11,6 @@ CONFIG_ARCH_EXYNOS=y
>  CONFIG_S3C_LOWLEVEL_UART_PORT=3
>  CONFIG_S3C24XX_PWM=y
>  CONFIG_ARCH_EXYNOS5=y
> -CONFIG_MACH_EXYNOS4_DT=y
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=2
>  CONFIG_PREEMPT=y
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index cb36807..b810f2f 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -14,19 +14,28 @@ menu "SAMSUNG EXYNOS SoCs Support"
>  config ARCH_EXYNOS4
>  	bool "SAMSUNG EXYNOS4"
>  	default y
> +	select ARM_AMBA
> +	select CLKSRC_OF
> +	select CLKSRC_SAMSUNG_PWM if CPU_EXYNOS4210
> +	select CPU_EXYNOS4210

The line above shows the brokenness of current layout of Exynos Kconfig 
options. You need to select some SoC in SAMSUNG EXYNOS4, because otherwise 
the build will fail if user doesn't select at least one of Exynos4 SoCs.

Instead, I would hide the ARCH_EXYNOS4 and ARCH_EXYNOS4 options and select 
them from entries of particular SoCs, i.e. ARCH_EXYNOS4 would be selected 
by CPU_EXYNOS4210, SOC_EXYNOS4212 and SOC_EXYNOS4412, ARCH_EXYNOS5 by 
SOC_EXYNOS5250 and SOC_EXYNOS5420 and so on.

Best regards,
Tomasz
