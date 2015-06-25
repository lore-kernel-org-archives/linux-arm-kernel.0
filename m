From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Jun 2015 15:45:11 +0100
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <1435240970-30869-1-git-send-email-vitalya@ti.com>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
Message-ID: <20150625144511.GA6844@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 25, 2015 at 03:02:50PM +0100, Vitaly Andrianov wrote:
> This commit add cpu_die implementation using psci api

I don't understand. If you have a PSCI implementation, it should be
sufficient to have a PSCI node (and enable-method) in your DT, and the
generic code will be used. Nothing should be required in your board
code.

You should also use CPU_ON to bring secondaries online rather than
mixing up PSCI and platform-specific mechanisms.

> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> ---
>  arch/arm/mach-keystone/platsmp.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
> index 5f46a7c..2c40cc0 100644
> --- a/arch/arm/mach-keystone/platsmp.c
> +++ b/arch/arm/mach-keystone/platsmp.c
> @@ -20,6 +20,7 @@
>  #include <asm/prom.h>
>  #include <asm/tlbflush.h>
>  #include <asm/pgtable.h>
> +#include <asm/psci.h>
>  
>  #include "keystone.h"
>  
> @@ -51,7 +52,38 @@ static inline void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
>  {}
>  #endif
>  
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void keystone_cpu_die(unsigned int cpu)
> +{
> +#ifdef CONFIG_ARM_PSCI
> +	struct psci_power_state pwr_state = {0, 0, 0};
> +
> +	pr_info("keystone_cpu_die(%d) from %d using PSCI\n", cpu,
> +	       smp_processor_id());
> +
> +	if (psci_ops.cpu_off)
> +		psci_ops.cpu_off(pwr_state);
> +#else
> +	/*
> +	 * We may want to add here a direct smc call to monitor
> +	 * if the kernel doesn't support PSCI API
> +	 */
> +#endif

You should determine this from your DT. Your FW/bootloader can patch in
the relevant nodes and properties when support is present, so the
presence of such nodes should guarantee that PSCI is available.

> +
> +	/*
> +	 * we shouldn't come here. But in case something went
> +	 * wrong the code below prevents kernel from crush
> +	 */
> +	while (1)
> +		cpu_do_idle();

This will make kexec appear to work, yet it won't. 

Thanks,
Mark.

> +}
> +#endif
> +
>  struct smp_operations keystone_smp_ops __initdata = {
>  	.smp_boot_secondary	= keystone_smp_boot_secondary,
>  	.smp_secondary_init     = keystone_smp_secondary_initmem,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_die		= keystone_cpu_die,
> +#endif
>  };
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
