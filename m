From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 13:54:01 +0900
Subject: [PATCH V2 1/2] ARM: SAMSUNG: Add SAMSUNG_PM config option to
 select pm
In-Reply-To: <1371036526-16589-2-git-send-email-amit.daniel@samsung.com>
References: <1371036526-16589-1-git-send-email-amit.daniel@samsung.com>
 <1371036526-16589-2-git-send-email-amit.daniel@samsung.com>
Message-ID: <0e2201ce8829$d178e1c0$746aa540$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Daniel Kachhap wrote:
> 
> This patch enables the selection of samsung pm related stuffs
> when SAMSUNG_PM config is enabled and not just when generic PM
> config is enabled. Power management for s3c64XX and s3c24XX
> is enabled by default and for other platform depends on S5P_PM.
> This patch also fixes the following compilation error's when compiling
> a platform like exynos5440 which does not select pm stuffs.
> 
> arch/arm/mach-exynos/built-in.o: In function `__virt_to_phys':
> linux/arch/arm/include/asm/memory.h:175: undefined reference to
> `s3c_cpu_resume'
> linux/arch/arm/include/asm/memory.h:175: undefined reference to
> `s3c_cpu_resume'
> linux/arch/arm/include/asm/memory.h:175: undefined reference to
> `s3c_cpu_resume'
> linux/arch/arm/include/asm/memory.h:175: undefined reference to
> `s3c_cpu_resume'
> arch/arm/mach-exynos/built-in.o: In function `exynos5_init_irq':
> linux/arch/arm/mach-exynos/common.c:492: undefined reference to
> `s3c_irq_wake'
> linux/arch/arm/mach-exynos/common.c:492: undefined reference to
> `s3c_irq_wake'
> arch/arm/mach-exynos/built-in.o: In function `exynos4_init_irq':
> linux/arch/arm/mach-exynos/common.c:476: undefined reference to
> `s3c_irq_wake'
> linux/arch/arm/mach-exynos/common.c:476: undefined reference to
> `s3c_irq_wake'
> arch/arm/plat-samsung/built-in.o: In function `s3c_irqext_wake':
> linux/arch/arm/plat-samsung/pm.c:144: undefined reference to
> `s3c_irqwake_eintallow'
> linux/arch/arm/plat-samsung/pm.c:144: undefined reference to
> `s3c_irqwake_eintallow'
> arch/arm/plat-samsung/built-in.o: In function `s3c_pm_enter':
> linux/arch/arm/plat-samsung/pm.c:263: undefined reference to
> `s3c_irqwake_intallow'
> linux/arch/arm/plat-samsung/pm.c:263: undefined reference to
> `s3c_irqwake_intallow'
> linux/arch/arm/plat-samsung/pm.c:264: undefined reference to
> `s3c_irqwake_eintallow'
> linux/arch/arm/plat-samsung/pm.c:264: undefined reference to
> `s3c_irqwake_eintallow'
> linux/arch/arm/plat-samsung/pm.c:275: undefined reference to
> `s3c_pm_save_core'
> linux/arch/arm/plat-samsung/pm.c:279: undefined reference to
> `s3c_pm_configure_extint'
> linux/arch/arm/plat-samsung/pm.c:310: undefined reference to
> `s3c_pm_restore_core'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile           |    2 +-
>  arch/arm/mach-exynos/common.c           |    2 +-
>  arch/arm/mach-exynos/common.h           |    1 -
>  arch/arm/mach-exynos/cpuidle.c          |    1 +
>  arch/arm/plat-samsung/Kconfig           |    7 +++++++
>  arch/arm/plat-samsung/Makefile          |    3 +--
>  arch/arm/plat-samsung/include/plat/pm.h |    8 ++++----
>  7 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 9811f87..3fa277a 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -14,7 +14,7 @@ obj-				:=
> 
>  obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
> 
> -obj-$(CONFIG_PM)		+= pm.o
> +obj-$(CONFIG_S5P_PM)		+= pm.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
>  obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 9834357..d2b4f54 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -799,7 +799,7 @@ static struct irq_chip exynos_irq_eint = {
>  	.irq_mask_ack	= exynos_irq_eint_maskack,
>  	.irq_ack	= exynos_irq_eint_ack,
>  	.irq_set_type	= exynos_irq_eint_set_type,
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_S5P_PM
>  	.irq_set_wake	= s3c_irqext_wake,
>  #endif
>  };
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 11fc1e2..f2b2e23 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -98,6 +98,5 @@ struct exynos_pmu_conf {
>  };
> 
>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
> -extern void s3c_cpu_resume(void);
> 
>  #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
> exynos/cpuidle.c
> index 4667907..2d071c6 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -25,6 +25,7 @@
>  #include <mach/regs-pmu.h>
> 
>  #include <plat/cpu.h>
> +#include <plat/pm.h>
> 
>  #include "common.h"
> 
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index f8ed2de..6c25aa6 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -31,6 +31,13 @@ config PLAT_S5P
>  	help
>  	  Base platform code for Samsung's S5P series SoC.
> 
> +config SAMSUNG_PM
> +	bool
> +	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || S5P_PM)

As we discussed before, this should be:

+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5P64X0 ||
S5P_PM)

If not, build error happens with s5p64x0_defconfig. So I fixed.

> +	default y
> +	help
> +	  Base platform power management code for samsung code
> +
>  if PLAT_SAMSUNG
> 
>  # boot configurations
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-
> samsung/Makefile
> index a23c460..1c406b3 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -51,8 +51,7 @@ obj-$(CONFIG_SAMSUNG_DMADEV)	+= dma-ops.o
> 
>  # PM support
> 
> -obj-$(CONFIG_PM)		+= pm.o
> -obj-$(CONFIG_PM)		+= pm-gpio.o
> +obj-$(CONFIG_SAMSUNG_PM)	+= pm.o pm-gpio.o
>  obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
> 
>  obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
> diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-
> samsung/include/plat/pm.h
> index f6fcade..46e2c82 100644
> --- a/arch/arm/plat-samsung/include/plat/pm.h
> +++ b/arch/arm/plat-samsung/include/plat/pm.h
> @@ -19,7 +19,7 @@
> 
>  struct device;
> 
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_SAMSUNG_PM
> 
>  extern __init int s3c_pm_init(void);
>  extern __init int s3c64xx_pm_init(void);
> @@ -58,8 +58,6 @@ extern unsigned char pm_uart_udivslot;  /* true to save
> UART UDIVSLOT */
> 
>  /* from sleep.S */
> 
> -extern void s3c_cpu_resume(void);
> -
>  extern int s3c2410_cpu_suspend(unsigned long);
> 
>  /* sleep save info */
> @@ -106,12 +104,14 @@ extern void s3c_pm_do_save(struct sleep_save *ptr,
> int count);
>  extern void s3c_pm_do_restore(struct sleep_save *ptr, int count);
>  extern void s3c_pm_do_restore_core(struct sleep_save *ptr, int count);
> 
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_SAMSUNG_PM
>  extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
>  extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
> +extern void s3c_cpu_resume(void);
>  #else
>  #define s3c_irq_wake NULL
>  #define s3c_irqext_wake NULL
> +#define s3c_cpu_resume NULL
>  #endif
> 
>  /* PM debug functions */
> --
> 1.7.1

Applied into -fixes, thanks.

- Kukjin
