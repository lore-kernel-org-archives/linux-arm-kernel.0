From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 8 Feb 2012 16:16:24 -0800 (PST)
Subject: [PATCH v6 13/15] ARM: hotplug: Introduce dummy_cpu_kill
In-Reply-To: <1328661059-24584-14-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.LFD.2.02.1202081608100.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Marc Zyngier wrote:

> Most platforms don't implement their cpu_kill method.
> Some because they simply don't offer the capability, some other
> because nobody cared enough to implement the necessary code.
> 
> Either way, this code is duplicated all over the place. Implement
> a global dummy_cpu_kill method and convert all SMP (but shmobile)
> to use it. Hopefully the "dummy" prefix will be an incentive
> for people to do the right thing.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Colin Cross <ccross@android.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

What avout this instead:

int __weak __cpuinit platform_cpu_kill(unsigned int cpu)
{
	if (!soc_smp_ops)
		return 0;
	if (!soc_smp_ops->cpu_kill)
		return 1;
	return soc_smp_ops->cpu_kill(cpu);
}

and get rid of the dummy handler entirely?




> ---
>  arch/arm/include/asm/smp_plat.h          |    3 +++
>  arch/arm/kernel/smp.c                    |    5 +++++
>  arch/arm/mach-exynos/common.h            |    1 -
>  arch/arm/mach-exynos/hotplug.c           |    5 -----
>  arch/arm/mach-exynos/platsmp.c           |    2 +-
>  arch/arm/mach-highbank/core.h            |    1 -
>  arch/arm/mach-highbank/hotplug.c         |    5 -----
>  arch/arm/mach-highbank/platsmp.c         |    3 ++-
>  arch/arm/mach-imx/hotplug.c              |    5 -----
>  arch/arm/mach-imx/platsmp.c              |    3 ++-
>  arch/arm/mach-msm/core.h                 |    1 -
>  arch/arm/mach-msm/hotplug.c              |    5 -----
>  arch/arm/mach-msm/platsmp.c              |    2 +-
>  arch/arm/mach-omap2/common.h             |    1 -
>  arch/arm/mach-omap2/omap-hotplug.c       |    5 -----
>  arch/arm/mach-omap2/omap-smp.c           |    3 ++-
>  arch/arm/mach-realview/core.h            |    1 -
>  arch/arm/mach-realview/hotplug.c         |    5 -----
>  arch/arm/mach-realview/platsmp.c         |    3 ++-
>  arch/arm/mach-tegra/common.h             |    1 -
>  arch/arm/mach-tegra/hotplug.c            |    5 -----
>  arch/arm/mach-tegra/platsmp.c            |    3 ++-
>  arch/arm/mach-ux500/hotplug.c            |    5 -----
>  arch/arm/mach-ux500/include/mach/setup.h |    1 -
>  arch/arm/mach-ux500/platsmp.c            |    2 +-
>  arch/arm/mach-vexpress/core.h            |    1 -
>  arch/arm/mach-vexpress/hotplug.c         |    5 -----
>  arch/arm/mach-vexpress/platsmp.c         |    3 ++-
>  arch/arm/plat-mxc/include/mach/common.h  |    1 -
>  29 files changed, 23 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 558d6c8..8b2ffe2 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -49,4 +49,7 @@ static inline int cache_ops_need_broadcast(void)
>  extern int __cpu_logical_map[];
>  #define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
>  
> +/* Only use this if your platform doesn't have any CPU PM */
> +extern int dummy_cpu_kill(unsigned int cpu);
> +
>  #endif
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 5321909..eabd6b8 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -179,6 +179,11 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  #ifdef CONFIG_HOTPLUG_CPU
>  static void percpu_timer_stop(void);
>  
> +int dummy_cpu_kill(unsigned int cpu)
> +{
> +	return 1;
> +}
> +
>  static int __cpuinit platform_cpu_kill(unsigned int cpu)
>  {
>  	if (soc_smp_ops && soc_smp_ops->cpu_kill)
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index cd37455..9046df8 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -31,7 +31,6 @@ extern struct arm_soc_smp_init_ops	exynos4_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		exynos4_soc_smp_ops;
>  extern struct arm_soc_desc		exynos4_soc_desc;
>  
> -extern int  exynos4_cpu_kill(unsigned int cpu);
>  extern void exynos4_cpu_die(unsigned int cpu);
>  extern int  exynos4_cpu_disable(unsigned int cpu);
>  
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 66e202d..1235df1 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -96,11 +96,6 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>  	}
>  }
>  
> -int exynos4_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 9c6e322..b263e63 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -207,7 +207,7 @@ struct arm_soc_smp_ops exynos4_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= exynos4_secondary_init,
>  	.smp_boot_secondary	= exynos4_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= exynos4_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= exynos4_cpu_die,
>  	.cpu_disable		= exynos4_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
> index d1fd356..115793e 100644
> --- a/arch/arm/mach-highbank/core.h
> +++ b/arch/arm/mach-highbank/core.h
> @@ -10,7 +10,6 @@ extern void highbank_lluart_map_io(void);
>  static inline void highbank_lluart_map_io(void) {}
>  #endif
>  
> -extern int highbank_cpu_kill(unsigned int cpu);
>  extern void highbank_cpu_die(unsigned int cpu);
>  extern int highbank_cpu_disable(unsigned int cpu);
>  
> diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
> index 7c25d49..6fda597 100644
> --- a/arch/arm/mach-highbank/hotplug.c
> +++ b/arch/arm/mach-highbank/hotplug.c
> @@ -24,11 +24,6 @@
>  
>  extern void secondary_startup(void);
>  
> -int highbank_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
> index 24162a7..b90ad83 100644
> --- a/arch/arm/mach-highbank/platsmp.c
> +++ b/arch/arm/mach-highbank/platsmp.c
> @@ -18,6 +18,7 @@
>  #include <linux/smp.h>
>  #include <linux/io.h>
>  
> +#include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <asm/hardware/gic.h>
>  
> @@ -86,7 +87,7 @@ struct arm_soc_smp_ops highbank_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= highbank_secondary_init,
>  	.smp_boot_secondary	= highbank_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= highbank_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= highbank_cpu_die,
>  	.cpu_disable		= highbank_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
> index 474b11d..7e75f8e 100644
> --- a/arch/arm/mach-imx/hotplug.c
> +++ b/arch/arm/mach-imx/hotplug.c
> @@ -14,11 +14,6 @@
>  #include <asm/cacheflush.h>
>  #include <mach/common.h>
>  
> -int imx_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index ae55931..64d9c9e 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/smp.h>
>  #include <asm/page.h>
> +#include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <asm/soc.h>
>  #include <asm/hardware/gic.h>
> @@ -94,7 +95,7 @@ struct arm_soc_smp_ops imx_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= imx_secondary_init,
>  	.smp_boot_secondary	= imx_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= imx_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= imx_cpu_die,
>  	.cpu_disable		= imx_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-msm/core.h b/arch/arm/mach-msm/core.h
> index e8394dd..533130d 100644
> --- a/arch/arm/mach-msm/core.h
> +++ b/arch/arm/mach-msm/core.h
> @@ -4,6 +4,5 @@ extern struct arm_soc_smp_init_ops	msm_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		msm_soc_smp_ops;
>  extern struct arm_soc_desc		msm_soc_desc;
>  
> -extern int  msm_cpu_kill(unsigned int cpu);
>  extern void msm_cpu_die(unsigned int cpu);
>  extern int  msm_cpu_disable(unsigned int cpu);
> diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
> index 6ba3602..5f09e5a1 100644
> --- a/arch/arm/mach-msm/hotplug.c
> +++ b/arch/arm/mach-msm/hotplug.c
> @@ -59,11 +59,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
>  	}
>  }
>  
> -int msm_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
> index 8b56ae1..0664a91 100644
> --- a/arch/arm/mach-msm/platsmp.c
> +++ b/arch/arm/mach-msm/platsmp.c
> @@ -183,7 +183,7 @@ struct arm_soc_smp_ops msm_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= msm_secondary_init,
>  	.smp_boot_secondary	= msm_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= msm_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= msm_cpu_die,
>  	.cpu_disable		= msm_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 961b79a..e0ae233 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -195,7 +195,6 @@ extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
>  extern void omap_auxcoreboot_addr(u32 cpu_addr);
>  extern u32 omap_read_auxcoreboot0(void);
>  
> -extern int  omap4_cpu_kill(unsigned int cpu);
>  extern void omap4_cpu_die(unsigned int cpu);
>  extern int  omap4_cpu_disable(unsigned int cpu);
>  
> diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
> index e794f4b..d3d01fe 100644
> --- a/arch/arm/mach-omap2/omap-hotplug.c
> +++ b/arch/arm/mach-omap2/omap-hotplug.c
> @@ -24,11 +24,6 @@
>  
>  #include "powerdomain.h"
>  
> -int omap4_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   * Called with IRQs disabled
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 4d39fd0..2c97b14 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -22,6 +22,7 @@
>  
>  #include <asm/cacheflush.h>
>  #include <asm/hardware/gic.h>
> +#include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <asm/soc.h>
>  #include <mach/hardware.h>
> @@ -191,7 +192,7 @@ struct arm_soc_smp_ops omap4_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= omap4_secondary_init,
>  	.smp_boot_secondary	= omap4_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= omap4_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= omap4_cpu_die,
>  	.cpu_disable		= omap4_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
> index a23caa3..6cdfdf9 100644
> --- a/arch/arm/mach-realview/core.h
> +++ b/arch/arm/mach-realview/core.h
> @@ -71,7 +71,6 @@ extern struct arm_soc_desc		realview_soc_desc;
>  extern struct arm_soc_smp_init_ops	realview_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		realview_soc_smp_ops;
>  
> -extern int  realview_cpu_kill(unsigned int cpu);
>  extern void realview_cpu_die(unsigned int cpu);
>  extern int  realview_cpu_disable(unsigned int cpu);
>  
> diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
> index ba4e2a86..7f28a56 100644
> --- a/arch/arm/mach-realview/hotplug.c
> +++ b/arch/arm/mach-realview/hotplug.c
> @@ -88,11 +88,6 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>  	}
>  }
>  
> -int realview_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
> index 8e4a865..ebe975e 100644
> --- a/arch/arm/mach-realview/platsmp.c
> +++ b/arch/arm/mach-realview/platsmp.c
> @@ -16,6 +16,7 @@
>  #include <mach/hardware.h>
>  #include <asm/hardware/gic.h>
>  #include <asm/mach-types.h>
> +#include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <asm/soc.h>
>  
> @@ -88,7 +89,7 @@ struct arm_soc_smp_ops realview_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= versatile_secondary_init,
>  	.smp_boot_secondary	= versatile_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= realview_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= realview_cpu_die,
>  	.cpu_disable		= realview_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
> index e4c214d..c135700 100644
> --- a/arch/arm/mach-tegra/common.h
> +++ b/arch/arm/mach-tegra/common.h
> @@ -6,6 +6,5 @@ struct arm_soc_smp_ops;
>  extern struct arm_soc_smp_init_ops	tegra_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		tegra_soc_smp_ops;
>  
> -extern int  tegra_cpu_kill(unsigned int cpu);
>  extern void tegra_cpu_die(unsigned int cpu);
>  extern int  tegra_cpu_disable(unsigned int cpu);
> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
> index 7319f5f..51e8690 100644
> --- a/arch/arm/mach-tegra/hotplug.c
> +++ b/arch/arm/mach-tegra/hotplug.c
> @@ -86,11 +86,6 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>  	}
>  }
>  
> -int tegra_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index 519b110..c31018e 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -22,6 +22,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/hardware/gic.h>
>  #include <asm/mach-types.h>
> +#include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <asm/soc.h>
>  
> @@ -144,7 +145,7 @@ struct arm_soc_smp_ops tegra_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= tegra_secondary_init,
>  	.smp_boot_secondary	= tegra_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= tegra_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= tegra_cpu_die,
>  	.cpu_disable		= tegra_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
> index ae1a8eb..1e86d5a 100644
> --- a/arch/arm/mach-ux500/hotplug.c
> +++ b/arch/arm/mach-ux500/hotplug.c
> @@ -36,11 +36,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
>  	}
>  }
>  
> -int ux500_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
> index e764530..72ba37d 100644
> --- a/arch/arm/mach-ux500/include/mach/setup.h
> +++ b/arch/arm/mach-ux500/include/mach/setup.h
> @@ -55,7 +55,6 @@ extern struct arm_soc_smp_init_ops ux500_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops ux500_soc_smp_ops;
>  extern struct arm_soc_desc ux500_soc_desc;
>  
> -extern int  ux500_cpu_kill(unsigned int cpu);
>  extern void ux500_cpu_die(unsigned int cpu);
>  extern int  ux500_cpu_disable(unsigned int cpu);
>  
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index fc72ce1..f105192 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -185,7 +185,7 @@ struct arm_soc_smp_ops ux500_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= ux500_secondary_init,
>  	.smp_boot_secondary	= ux500_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= ux500_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= ux500_cpu_die,
>  	.cpu_disable		= ux500_cpu_disable,
>  #endif
> diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
> index bd9065a..f072682 100644
> --- a/arch/arm/mach-vexpress/core.h
> +++ b/arch/arm/mach-vexpress/core.h
> @@ -24,6 +24,5 @@ struct arm_soc_smp_ops;
>  extern struct arm_soc_smp_init_ops	vexpress_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		vexpress_soc_smp_ops;
>  
> -extern int  vexpress_cpu_kill(unsigned int cpu);
>  extern void vexpress_cpu_die(unsigned int cpu);
>  extern int  vexpress_cpu_disable(unsigned int cpu);
> diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
> index ac6d034..11d2c77 100644
> --- a/arch/arm/mach-vexpress/hotplug.c
> +++ b/arch/arm/mach-vexpress/hotplug.c
> @@ -84,11 +84,6 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>  	}
>  }
>  
> -int vexpress_cpu_kill(unsigned int cpu)
> -{
> -	return 1;
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index aba765b..80ab030 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -13,6 +13,7 @@
>  #include <linux/smp.h>
>  #include <linux/io.h>
>  
> +#include <asm/smp_plat.h>
>  #include <asm/soc.h>
>  
>  #include <mach/motherboard.h>
> @@ -59,7 +60,7 @@ struct arm_soc_smp_ops vexpress_soc_smp_ops __initdata = {
>  	.smp_secondary_init	= versatile_secondary_init,
>  	.smp_boot_secondary	= versatile_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_kill		= vexpress_cpu_kill,
> +	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= vexpress_cpu_die,
>  	.cpu_disable		= vexpress_cpu_disable,
>  #endif
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 99c7978..08b241c 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -133,7 +133,6 @@ extern void imx53_smd_common_init(void);
>  extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
>  extern void imx6q_clock_map_io(void);
>  
> -extern int imx_cpu_kill(unsigned int cpu);
>  extern void imx_cpu_die(unsigned int cpu);
>  extern int imx_cpu_disable(unsigned int cpu);
>  
> -- 
> 1.7.3.4
> 
