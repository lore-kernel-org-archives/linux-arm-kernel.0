From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 08 Apr 2013 12:27:34 +0200
Subject: [PATCH] ARM: Samsung: Select ARM_CPU_SUSPEND when required
In-Reply-To: <2cd601ce343f$7d6aac50$784004f0$%kim@samsung.com>
References: <1365366442-16025-1-git-send-email-s.nawrocki@samsung.com>
 <2cd601ce343f$7d6aac50$784004f0$%kim@samsung.com>
Message-ID: <51629B96.9050504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 11:57 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
[...]
> Yes, right. The pm.c in plat-samsung should be built with
> arch/arm/kernel/sleep.S and suspend.c.
> 
> BTW it should be shown in alphabetical order and we don't need more
> following in mach-exynos.
> 
> --------8<----------------8<--------
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 2f45906..bc0a8b2 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -31,7 +31,6 @@ config CPU_EXYNOS4210
>  	bool "SAMSUNG EXYNOS4210"
>  	default y
>  	depends on ARCH_EXYNOS4
> -	select ARM_CPU_SUSPEND if PM
>  	select PM_GENERIC_DOMAINS
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index b708b3e..30a976d 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -8,6 +8,7 @@ config PLAT_SAMSUNG
>  	Bool
>  	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P
> 	default y
> +	select ARM_CPU_SUSPEND if PM
>  	select GENERIC_IRQ_CHIP
>  	select NO_IOPORT
>  	help
> --------8<----------------8<--------
> 
> If you have any objections, let me know.

Yes, this looks better. However after posting this patch I noticed linker
errors in some builds due to undefined cpu_arm920_do_suspend,
cpu_arm920_do_resume routines.

It seems it is because various cpu_*_do_suspend routines are selected by
CONFIG_PM_SLEEP.  And the PM code in arch/arm/mach-s3c24xx, arch/arm/mach-
s3c64xx is selected by CONFIG_PM.

$ git grep -1 "ENTRY(cpu_.*_do_suspend"
arch/arm/mm/proc-arm920.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-arm920.S:ENTRY(cpu_arm920_do_suspend)
arch/arm/mm/proc-arm920.S-      stmfd   sp!, {r4 - r6, lr}
--
arch/arm/mm/proc-arm926.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-arm926.S:ENTRY(cpu_arm926_do_suspend)
arch/arm/mm/proc-arm926.S-      stmfd   sp!, {r4 - r6, lr}
--
arch/arm/mm/proc-mohawk.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-mohawk.S:ENTRY(cpu_mohawk_do_suspend)
arch/arm/mm/proc-mohawk.S-      stmfd   sp!, {r4 - r9, lr}
--
arch/arm/mm/proc-sa1100.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-sa1100.S:ENTRY(cpu_sa1100_do_suspend)
arch/arm/mm/proc-sa1100.S-      stmfd   sp!, {r4 - r6, lr}
--
arch/arm/mm/proc-v6.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-v6.S:ENTRY(cpu_v6_do_suspend)
arch/arm/mm/proc-v6.S-  stmfd   sp!, {r4 - r9, lr}
--
arch/arm/mm/proc-v7.S-#ifdef CONFIG_ARM_CPU_SUSPEND
arch/arm/mm/proc-v7.S:ENTRY(cpu_v7_do_suspend)
arch/arm/mm/proc-v7.S-  stmfd   sp!, {r4 - r10, lr}
--
arch/arm/mm/proc-xsc3.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-xsc3.S:ENTRY(cpu_xsc3_do_suspend)
arch/arm/mm/proc-xsc3.S-        stmfd   sp!, {r4 - r9, lr}
--
arch/arm/mm/proc-xscale.S-#ifdef CONFIG_PM_SLEEP
arch/arm/mm/proc-xscale.S:ENTRY(cpu_xscale_do_suspend)
arch/arm/mm/proc-xscale.S-      stmfd   sp!, {r4 - r9, lr}

However I can't reproduce it now :-/ Anyway the $subject patch fixes
the main issue, which I can easily reproduce here as well. So I'll
prepare another patch if needed when I get back to this later.

Thanks,
Sylwester
