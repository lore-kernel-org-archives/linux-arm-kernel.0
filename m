From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 08 Apr 2013 10:10:11 +0100
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP
 operation if required
In-Reply-To: <alpine.LFD.2.03.1304060943370.1171@syhkavp.arg>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
 <20130405224819.GB14308@quad.lixom.net>
 <alpine.LFD.2.03.1304060943370.1171@syhkavp.arg>
Message-ID: <1365412211.3384.16.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-04-06 at 10:02 -0400, Nicolas Pitre wrote:
> I've amended this patch slightly so to:
> 
> 1) Keep the default .smp = &vexpress_smp_ops and only perform an 
>    override in vexpress_smp_init_ops() when appropriate.  This should
>    remove one potential issue with Xen support that was highlighted 
>    recently.
> 
> 2) Add a mcpm_smp_set_ops() instead of installing mcpm_smp_ops directly
>    for better abstraction.
>
> 3) Added a comment about and checked for the CCI node being enabled.
> 
> That results in the patch below.  Given those are minor changes, I kept 
> the existing review tags.
>
> From: Jon Medhurst <tixy@linaro.org>
> Date: Wed, 30 Jan 2013 09:12:55 +0000
> Subject: [PATCH] ARM: vexpress: Select multi-cluster SMP operation if required
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
>
> diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
> index 34f236af09..cc82040877 100644
> --- a/arch/arm/common/mcpm_platsmp.c
> +++ b/arch/arm/common/mcpm_platsmp.c
> @@ -85,3 +85,8 @@ struct smp_operations __initdata mcpm_smp_ops = {
>  	.cpu_die		= mcpm_cpu_die,
>  #endif
>  };
> +
> +void __init mcpm_smp_set_ops(void)
> +{
> +	smp_set_ops(&mcpm_smp_ops);
> +}
> diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
> index 814623e6a1..34dfb86ff5 100644
> --- a/arch/arm/include/asm/mcpm_entry.h
> +++ b/arch/arm/include/asm/mcpm_entry.h
> @@ -190,5 +190,7 @@ int __mcpm_cluster_state(unsigned int cluster);
>  int __init mcpm_sync_init(
>  	void (*power_up_setup)(unsigned int affinity_level));
>  
> +void __init mcpm_smp_set_ops(void);
> +
>  #endif /* ! __ASSEMBLY__ */
>  #endif


Do the changes to the above mcpm files want to be in a separate patch as
it's generic ARM code, not vexpress specific?

> diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
> index f134cd4a85..3a761fd76c 100644
> --- a/arch/arm/mach-vexpress/core.h
> +++ b/arch/arm/mach-vexpress/core.h
> @@ -6,6 +6,8 @@
>  
>  void vexpress_dt_smp_map_io(void);
>  
> +void vexpress_smp_init_ops(void);
> +
>  extern struct smp_operations	vexpress_smp_ops;
>  
>  extern void vexpress_cpu_die(unsigned int cpu);
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index dc1ace55d5..06317bc714 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -12,9 +12,11 @@
>  #include <linux/errno.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/vexpress.h>
>  
> +#include <asm/mcpm_entry.h>
>  #include <asm/smp_scu.h>
>  #include <asm/mach/map.h>
>  
> @@ -203,3 +205,18 @@ struct smp_operations __initdata vexpress_smp_ops = {
>  	.cpu_die		= vexpress_cpu_die,
>  #endif
>  };
> +
> +void __init vexpress_smp_init_ops(void)
> +{
> +#ifdef CONFIG_MCPM
> +	/*
> +	 * The best way to detect a multi-cluster configuration at the moment
> +	 * is to look for the presence of a CCI in the system.
> +	 * Override the default vexpress_smp_ops if so.
> +	 */
> +	struct device_node *node;
> +	node = of_find_compatible_node(NULL, NULL, "arm,cci");
> +	if (node && of_device_is_available(node))
> +		mcpm_smp_set_ops();
> +#endif
> +}

What now sets smp_ops if mcpm_smp_set_ops doesn't get called above? I
know there are umpteen versions of the patch "ARM: Enable selection of
SMP operations at boot time", but none of them seem to resolve that
issue.

> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 915683cb67..16b42c10e0 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -476,6 +476,7 @@ static const char * const v2m_dt_match[] __initconst = {
>  DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
>  	.dt_compat	= v2m_dt_match,
>  	.smp		= smp_ops(vexpress_smp_ops),
> +	.smp_init	= smp_init_ops(vexpress_smp_init_ops),
>  	.map_io		= v2m_dt_map_io,
>  	.init_early	= v2m_dt_init_early,
>  	.init_irq	= irqchip_init,

-- 
Tixy
