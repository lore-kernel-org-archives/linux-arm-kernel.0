From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 23 Aug 2017 17:19:51 +0200
Subject: [PATCH] ARM: at91: don't select CONFIG_ARM_CPU_SUSPEND for old
 platforms
In-Reply-To: <20170823144636.2333097-1-arnd@arndb.de>
References: <20170823144636.2333097-1-arnd@arndb.de>
Message-ID: <20170823151951.bfkxypspcrdnc7v4@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/2017 at 16:46:15 +0200, Arnd Bergmann wrote:
> My previous patch fixed a link error for all at91 platforms when
> CONFIG_ARM_CPU_SUSPEND was not set, however this caused another
> problem on a configuration that enabled CONFIG_ARCH_AT91 but none
> of the individual SoCs, and that also enabled CPU_ARM720 as
> the only CPU:
> 
> warning: (ARCH_AT91 && SOC_IMX23 && SOC_IMX28 && ARCH_PXA && MACH_MVEBU_V7 && SOC_IMX6 && ARCH_OMAP3 && ARCH_OMAP4 && SOC_OMAP5 && SOC_AM33XX && SOC_DRA7XX && ARCH_EXYNOS3 && ARCH_EXYNOS4 && EXYNOS5420_MCPM && EXYNOS_CPU_SUSPEND && ARCH_VEXPRESS_TC2_PM && ARM_BIG_LITTLE_CPUIDLE && ARM_HIGHBANK_CPUIDLE && QCOM_PM) selects ARM_CPU_SUSPEND which has unmet direct dependencies (ARCH_SUSPEND_POSSIBLE)
> arch/arm/kernel/sleep.o: In function `cpu_resume':
> (.text+0xf0): undefined reference to `cpu_arm720_suspend_size'
> arch/arm/kernel/suspend.o: In function `__cpu_suspend_save':
> suspend.c:(.text+0x134): undefined reference to `cpu_arm720_do_suspend'
> 
> This improves the hack some more by only selecting ARM_CPU_SUSPEND
> for the part that requires it, and changing pm.c to drop the
> contents of unused init functions so we no longer refer to
> cpu_resume on at91 platforms that don't need it.
> 
> Fixes: cc7a938f5f30 ("ARM: at91: select CONFIG_ARM_CPU_SUSPEND")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I think you can take it directly through arm-soc, I probably won't send
more for 4.13.

> ---
>  arch/arm/mach-at91/Kconfig |  2 +-
>  arch/arm/mach-at91/pm.c    | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index d735e5fc4772..195da38cb9a2 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -1,7 +1,7 @@
>  menuconfig ARCH_AT91
>  	bool "Atmel SoCs"
>  	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
> -	select ARM_CPU_SUSPEND if PM
> +	select ARM_CPU_SUSPEND if PM && ARCH_MULTI_V7
>  	select COMMON_CLK_AT91
>  	select GPIOLIB
>  	select PINCTRL
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 667fddac3856..5036f996e694 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -608,6 +608,9 @@ static void __init at91_pm_init(void (*pm_idle)(void))
>  
>  void __init at91rm9200_pm_init(void)
>  {
> +	if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
> +		return;
> +
>  	at91_dt_ramc();
>  
>  	/*
> @@ -620,18 +623,27 @@ void __init at91rm9200_pm_init(void)
>  
>  void __init at91sam9_pm_init(void)
>  {
> +	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
> +		return;
> +
>  	at91_dt_ramc();
>  	at91_pm_init(at91sam9_idle);
>  }
>  
>  void __init sama5_pm_init(void)
>  {
> +	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
> +		return;
> +
>  	at91_dt_ramc();
>  	at91_pm_init(NULL);
>  }
>  
>  void __init sama5d2_pm_init(void)
>  {
> +	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
> +		return;
> +
>  	at91_pm_backup_init();
>  	sama5_pm_init();
>  }
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
