From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 25 Jun 2015 07:54:28 -0700
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <1435240970-30869-1-git-send-email-vitalya@ti.com>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
Message-ID: <558C1624.4050100@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/25/2015 7:02 AM, Vitaly Andrianov wrote:
> This commit add cpu_die implementation using psci api
>
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> ---
>   arch/arm/mach-keystone/platsmp.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
> index 5f46a7c..2c40cc0 100644
> --- a/arch/arm/mach-keystone/platsmp.c
> +++ b/arch/arm/mach-keystone/platsmp.c
> @@ -20,6 +20,7 @@
>   #include <asm/prom.h>
>   #include <asm/tlbflush.h>
>   #include <asm/pgtable.h>
> +#include <asm/psci.h>
>
>   #include "keystone.h"
>
> @@ -51,7 +52,38 @@ static inline void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
>   {}
>   #endif
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
I don't see much value adding the SMC. I mean CPU_HOTPLUG works with
PSCI o.w doesn't is good enough. If you still like to add it, just 
abstract above into two functions, one with PSCI and other with
SMC. That way you can avoid that ugly #defines in the middle of the
code.

Regards,
Santosh
