From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 8 Feb 2012 16:19:26 -0800 (PST)
Subject: [PATCH v6 14/15] ARM: hotplug: Introduce dummy_cpu_disable
In-Reply-To: <1328661059-24584-15-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.LFD.2.02.1202081618300.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Marc Zyngier wrote:

> Most platforms don't implement their cpu_disable method.
> Some because they simply don't offer the capability, some other
> because nobody cared enough to implement the necessary code.
> 
> Either way, this code is duplicated all over the place. Implement
> a global dummy_cpu_disable method and convert all SMP (but shmobile)
> to use it. Hopefully the "dummy" prefix will be an incentive
> for people to do the right thing.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Colin Cross <ccross@android.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Couldn't the same strategy as I suggested for cpu_kill be used here too?


> ---
>  arch/arm/include/asm/smp_plat.h          |    1 +
>  arch/arm/kernel/smp.c                    |    9 +++++++++
>  arch/arm/mach-exynos/common.h            |    1 -
>  arch/arm/mach-exynos/hotplug.c           |    9 ---------
>  arch/arm/mach-exynos/platsmp.c           |    2 +-
>  arch/arm/mach-highbank/core.h            |    1 -
>  arch/arm/mach-highbank/hotplug.c         |    9 ---------
>  arch/arm/mach-highbank/platsmp.c         |    2 +-
>  arch/arm/mach-imx/hotplug.c              |    9 ---------
>  arch/arm/mach-imx/platsmp.c              |    2 +-
>  arch/arm/mach-msm/core.h                 |    1 -
>  arch/arm/mach-msm/hotplug.c              |    9 ---------
>  arch/arm/mach-msm/platsmp.c              |    2 +-
>  arch/arm/mach-omap2/common.h             |    1 -
>  arch/arm/mach-omap2/omap-hotplug.c       |    9 ---------
>  arch/arm/mach-omap2/omap-smp.c           |    2 +-
>  arch/arm/mach-realview/core.h            |    1 -
>  arch/arm/mach-realview/hotplug.c         |    9 ---------
>  arch/arm/mach-realview/platsmp.c         |    2 +-
>  arch/arm/mach-tegra/common.h             |    1 -
>  arch/arm/mach-tegra/hotplug.c            |    9 ---------
>  arch/arm/mach-tegra/platsmp.c            |    2 +-
>  arch/arm/mach-ux500/hotplug.c            |    9 ---------
>  arch/arm/mach-ux500/include/mach/setup.h |    1 -
>  arch/arm/mach-ux500/platsmp.c            |    2 +-
>  arch/arm/mach-vexpress/core.h            |    1 -
>  arch/arm/mach-vexpress/hotplug.c         |    9 ---------
>  arch/arm/mach-vexpress/platsmp.c         |    2 +-
>  arch/arm/plat-mxc/include/mach/common.h  |    1 -
>  29 files changed, 19 insertions(+), 99 deletions(-)
> 
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 8b2ffe2..f43d039 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -51,5 +51,6 @@ extern int __cpu_logical_map[];
>  
>  /* Only use this if your platform doesn't have any CPU PM */
>  extern int dummy_cpu_kill(unsigned int cpu);
> +extern int dummy_cpu_disable(unsigned int cpu);
>  
>  #endif
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index eabd6b8..e0d1622 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -184,6 +184,15 @@ int dummy_cpu_kill(unsigned int cpu)
>  	return 1;
>  }
>  
> +int dummy_cpu_disable(unsigned int cpu)
> +{
> +	/*
> +	 * we don't allow CPU 0 to be shutdown (it is still too special
> +	 * e.g. clock tick interrupts)
> +	 */
> +	return cpu == 0 ? -EPERM : 0;
> +}
> +
>  static int __cpuinit platform_cpu_kill(unsigned int cpu)
>  {
>  	if (soc_smp_ops && soc_smp_ops->cpu_kill)
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 9046df8..f13631a 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -32,7 +32,6 @@ extern struct arm_soc_smp_ops		exynos4_soc_smp_ops;
>  extern struct arm_soc_desc		exynos4_soc_desc;
>  
>  extern void exynos4_cpu_die(unsigned int cpu);
> -extern int  exynos4_cpu_disable(unsigned int cpu);
>  
>  #ifdef CONFIG_ARCH_EXYNOS
>  extern  int exynos_init(void);
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 1235df1..be7a96b 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -120,12 +120,3 @@ void exynos4_cpu_die(unsigned int cpu)
>  	if (spurious)
>  		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
>  }
> -
> -int exynos4_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index b263e63..4d22c2a 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -209,6 +209,6 @@ struct arm_soc_smp_ops exynos4_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= exynos4_cpu_die,
> -	.cpu_disable		= exynos4_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
> index 115793e..7f4aaca 100644
> --- a/arch/arm/mach-highbank/core.h
> +++ b/arch/arm/mach-highbank/core.h
> @@ -11,7 +11,6 @@ static inline void highbank_lluart_map_io(void) {}
>  #endif
>  
>  extern void highbank_cpu_die(unsigned int cpu);
> -extern int highbank_cpu_disable(unsigned int cpu);
>  
>  extern struct arm_soc_smp_init_ops	highbank_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		highbank_soc_smp_ops;
> diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
> index 6fda597..1277da3 100644
> --- a/arch/arm/mach-highbank/hotplug.c
> +++ b/arch/arm/mach-highbank/hotplug.c
> @@ -40,12 +40,3 @@ void highbank_cpu_die(unsigned int cpu)
>  	/* We should never return from idle */
>  	panic("highbank: cpu %d unexpectedly exit from shutdown\n", cpu);
>  }
> -
> -int highbank_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * CPU0 should not be shut down via hotplug.  cpu_idle can WFI
> -	 * or a proper shutdown or hibernate should be used.
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
> index b90ad83..789147d 100644
> --- a/arch/arm/mach-highbank/platsmp.c
> +++ b/arch/arm/mach-highbank/platsmp.c
> @@ -89,6 +89,6 @@ struct arm_soc_smp_ops highbank_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= highbank_cpu_die,
> -	.cpu_disable		= highbank_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
> index 7e75f8e..63d5144 100644
> --- a/arch/arm/mach-imx/hotplug.c
> +++ b/arch/arm/mach-imx/hotplug.c
> @@ -28,12 +28,3 @@ void imx_cpu_die(unsigned int cpu)
>  	/* We should never return from idle */
>  	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
>  }
> -
> -int imx_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index 64d9c9e..2fea1e3 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -97,6 +97,6 @@ struct arm_soc_smp_ops imx_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= imx_cpu_die,
> -	.cpu_disable		= imx_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-msm/core.h b/arch/arm/mach-msm/core.h
> index 533130d..623474a 100644
> --- a/arch/arm/mach-msm/core.h
> +++ b/arch/arm/mach-msm/core.h
> @@ -5,4 +5,3 @@ extern struct arm_soc_smp_ops		msm_soc_smp_ops;
>  extern struct arm_soc_desc		msm_soc_desc;
>  
>  extern void msm_cpu_die(unsigned int cpu);
> -extern int  msm_cpu_disable(unsigned int cpu);
> diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
> index 5f09e5a1..d0f79e8 100644
> --- a/arch/arm/mach-msm/hotplug.c
> +++ b/arch/arm/mach-msm/hotplug.c
> @@ -78,12 +78,3 @@ void msm_cpu_die(unsigned int cpu)
>  	 */
>  	cpu_leave_lowpower();
>  }
> -
> -int msm_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
> index 0664a91..f7e27d9 100644
> --- a/arch/arm/mach-msm/platsmp.c
> +++ b/arch/arm/mach-msm/platsmp.c
> @@ -185,6 +185,6 @@ struct arm_soc_smp_ops msm_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= msm_cpu_die,
> -	.cpu_disable		= msm_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index e0ae233..c8e3c3e 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -196,7 +196,6 @@ extern void omap_auxcoreboot_addr(u32 cpu_addr);
>  extern u32 omap_read_auxcoreboot0(void);
>  
>  extern void omap4_cpu_die(unsigned int cpu);
> -extern int  omap4_cpu_disable(unsigned int cpu);
>  
>  struct arm_soc_smp_init_ops;
>  struct arm_soc_smp_ops;
> diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
> index d3d01fe..1d95520 100644
> --- a/arch/arm/mach-omap2/omap-hotplug.c
> +++ b/arch/arm/mach-omap2/omap-hotplug.c
> @@ -56,12 +56,3 @@ void omap4_cpu_die(unsigned int cpu)
>  		pr_debug("CPU%u: spurious wakeup call\n", cpu);
>  	}
>  }
> -
> -int omap4_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 2c97b14..6b1d652 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -194,6 +194,6 @@ struct arm_soc_smp_ops omap4_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= omap4_cpu_die,
> -	.cpu_disable		= omap4_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
> index 6cdfdf9..dd4bcdb 100644
> --- a/arch/arm/mach-realview/core.h
> +++ b/arch/arm/mach-realview/core.h
> @@ -72,6 +72,5 @@ extern struct arm_soc_smp_init_ops	realview_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		realview_soc_smp_ops;
>  
>  extern void realview_cpu_die(unsigned int cpu);
> -extern int  realview_cpu_disable(unsigned int cpu);
>  
>  #endif
> diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
> index 7f28a56..12af634 100644
> --- a/arch/arm/mach-realview/hotplug.c
> +++ b/arch/arm/mach-realview/hotplug.c
> @@ -112,12 +112,3 @@ void realview_cpu_die(unsigned int cpu)
>  	if (spurious)
>  		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
>  }
> -
> -int realview_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
> index ebe975e..5b7535d 100644
> --- a/arch/arm/mach-realview/platsmp.c
> +++ b/arch/arm/mach-realview/platsmp.c
> @@ -91,6 +91,6 @@ struct arm_soc_smp_ops realview_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= realview_cpu_die,
> -	.cpu_disable		= realview_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
> index c135700..b02cc87 100644
> --- a/arch/arm/mach-tegra/common.h
> +++ b/arch/arm/mach-tegra/common.h
> @@ -7,4 +7,3 @@ extern struct arm_soc_smp_init_ops	tegra_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		tegra_soc_smp_ops;
>  
>  extern void tegra_cpu_die(unsigned int cpu);
> -extern int  tegra_cpu_disable(unsigned int cpu);
> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
> index 51e8690..15433b2 100644
> --- a/arch/arm/mach-tegra/hotplug.c
> +++ b/arch/arm/mach-tegra/hotplug.c
> @@ -110,12 +110,3 @@ void tegra_cpu_die(unsigned int cpu)
>  	if (spurious)
>  		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
>  }
> -
> -int tegra_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index c31018e..4edc8ab 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -147,6 +147,6 @@ struct arm_soc_smp_ops tegra_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= tegra_cpu_die,
> -	.cpu_disable		= tegra_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
> index 1e86d5a..ec1c77f 100644
> --- a/arch/arm/mach-ux500/hotplug.c
> +++ b/arch/arm/mach-ux500/hotplug.c
> @@ -46,12 +46,3 @@ void ux500_cpu_die(unsigned int cpu)
>  	/* directly enter low power state, skipping secure registers */
>  	platform_do_lowpower(cpu);
>  }
> -
> -int ux500_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
> index 72ba37d..2935f85 100644
> --- a/arch/arm/mach-ux500/include/mach/setup.h
> +++ b/arch/arm/mach-ux500/include/mach/setup.h
> @@ -56,6 +56,5 @@ extern struct arm_soc_smp_ops ux500_soc_smp_ops;
>  extern struct arm_soc_desc ux500_soc_desc;
>  
>  extern void ux500_cpu_die(unsigned int cpu);
> -extern int  ux500_cpu_disable(unsigned int cpu);
>  
>  #endif /*  __ASM_ARCH_SETUP_H */
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index f105192..bbd6480 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -187,6 +187,6 @@ struct arm_soc_smp_ops ux500_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= ux500_cpu_die,
> -	.cpu_disable		= ux500_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
> index f072682..d9b1ec0 100644
> --- a/arch/arm/mach-vexpress/core.h
> +++ b/arch/arm/mach-vexpress/core.h
> @@ -25,4 +25,3 @@ extern struct arm_soc_smp_init_ops	vexpress_soc_smp_init_ops;
>  extern struct arm_soc_smp_ops		vexpress_soc_smp_ops;
>  
>  extern void vexpress_cpu_die(unsigned int cpu);
> -extern int  vexpress_cpu_disable(unsigned int cpu);
> diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
> index 11d2c77..e1a7fef 100644
> --- a/arch/arm/mach-vexpress/hotplug.c
> +++ b/arch/arm/mach-vexpress/hotplug.c
> @@ -108,12 +108,3 @@ void vexpress_cpu_die(unsigned int cpu)
>  	if (spurious)
>  		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
>  }
> -
> -int vexpress_cpu_disable(unsigned int cpu)
> -{
> -	/*
> -	 * we don't allow CPU 0 to be shutdown (it is still too special
> -	 * e.g. clock tick interrupts)
> -	 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index 80ab030..a5196f87 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -62,6 +62,6 @@ struct arm_soc_smp_ops vexpress_soc_smp_ops __initdata = {
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= dummy_cpu_kill,
>  	.cpu_die		= vexpress_cpu_die,
> -	.cpu_disable		= vexpress_cpu_disable,
> +	.cpu_disable		= dummy_cpu_disable,
>  #endif
>  };
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 08b241c..c0d0a21 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -134,7 +134,6 @@ extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
>  extern void imx6q_clock_map_io(void);
>  
>  extern void imx_cpu_die(unsigned int cpu);
> -extern int imx_cpu_disable(unsigned int cpu);
>  
>  #ifdef CONFIG_PM
>  extern void imx6q_pm_init(void);
> -- 
> 1.7.3.4
> 
