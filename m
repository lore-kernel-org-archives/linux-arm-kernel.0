From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 Jul 2015 15:16:58 +0100
Subject: [RFC PATCH 2/3] arm: psci: enable PSCI on UP systems
In-Reply-To: <1436014910-1201-3-git-send-email-jszhang@marvell.com>
References: <1436014910-1201-1-git-send-email-jszhang@marvell.com>
 <1436014910-1201-3-git-send-email-jszhang@marvell.com>
Message-ID: <20150707141658.GF4379@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 04, 2015 at 02:01:49PM +0100, Jisheng Zhang wrote:
> This is to make calls like eg cpu_suspend can be made functional on UP too.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm/kernel/Makefile | 5 +----
>  arch/arm/kernel/psci.c   | 2 ++
>  2 files changed, 3 insertions(+), 4 deletions(-)

You will have to rewrite the commit log (mostly because PSCI CPU suspend
will move to drivers/firmware so it will become stale, I know what you
mean but it might be unclear to others so please improve it).

Patch (and intent) seems fine though:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index c57b2c0..2b1a60c 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -88,9 +88,6 @@ obj-$(CONFIG_DEBUG_LL)	+= debug.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  
>  obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
> -ifeq ($(CONFIG_ARM_PSCI),y)
> -obj-y				+= psci-call.o
> -obj-$(CONFIG_SMP)		+= psci.o
> -endif
> +obj-$(CONFIG_ARM_PSCI)		+= psci-call.o psci.o
>  
>  extra-y := $(head-y) vmlinux.lds
> diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
> index 61c04b0..7f6ff02 100644
> --- a/arch/arm/kernel/psci.c
> +++ b/arch/arm/kernel/psci.c
> @@ -47,6 +47,7 @@
>   *
>   */
>  
> +#ifdef CONFIG_SMP
>  extern void secondary_startup(void);
>  
>  static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
> @@ -128,3 +129,4 @@ struct smp_operations __initdata psci_smp_ops = {
>  	.cpu_kill		= psci_cpu_kill,
>  #endif
>  };
> +#endif
> -- 
> 2.1.4
> 
