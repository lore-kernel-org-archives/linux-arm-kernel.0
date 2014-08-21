From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 21 Aug 2014 14:19:51 +0200
Subject: [PATCH 1/9] ARM: zynq: PM: Enable A9 internal clock gating feature
In-Reply-To: <1408567315-28479-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <26994133-6c3c-45c0-af09-3cb55ad35b13@BY2FFO11FD028.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/mach-zynq/common.c  |  6 ++++++
>  arch/arm/mach-zynq/common.h  | 11 +++++++++++
>  arch/arm/mach-zynq/platsmp.c |  9 +++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 31a6fa40ba37..3cb7c198615a 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -98,6 +98,11 @@ static int __init zynq_get_revision(void)
>  	return revision;
>  }
>  
> +static void __init zynq_init_late(void)
> +{
> +	zynq_core_pm_init();
> +}
> +
>  /**
>   * zynq_init_machine - System specific initialization, intended to be
>   *		       called from board specific initialization.
> @@ -204,6 +209,7 @@ DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
>  	.map_io		= zynq_map_io,
>  	.init_irq	= zynq_irq_init,
>  	.init_machine	= zynq_init_machine,
> +	.init_late	= zynq_init_late,
>  	.init_time	= zynq_timer_init,
>  	.dt_compat	= zynq_dt_match,
>  	.reserve	= zynq_memory_init,
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index f652f0a884a6..596ef0b5067c 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -40,4 +40,15 @@ extern void __iomem *zynq_scu_base;
>  /* Hotplug */
>  extern void zynq_platform_cpu_die(unsigned int cpu);
>  
> +static inline void zynq_core_pm_init(void)
> +{
> +	/* A9 clock gating */
> +	asm volatile ("mrc  p15, 0, r12, c15, c0, 0\n"
> +		      "orr  r12, r12, #1\n"
> +		      "mcr  p15, 0, r12, c15, c0, 0\n"
> +		      : /* no outputs */
> +		      : /* no inputs */
> +		      : "r12");
> +}
> +
>  #endif
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> index abc82ef085c1..616b99e07c60 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -112,6 +112,14 @@ static void __init zynq_smp_prepare_cpus(unsigned int max_cpus)
>  	scu_enable(zynq_scu_base);
>  }
>  
> +/*
> + * This function is in the hotplug path. Don't move it into the init section!!
> + */

Worth to use kernel-doc format here.

Thanks,
Michal

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/a023c24d/attachment.sig>
