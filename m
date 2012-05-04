From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 15:55:11 -0700
Subject: [PATCH 08/13] ARM: OMAP5: Add the WakeupGen IP updates.
In-Reply-To: <1336029982-31898-9-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-9-git-send-email-r.sricharan@ti.com>
Message-ID: <20120504225511.GA5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* R Sricharan <r.sricharan@ti.com> [120503 00:30]:
> --- a/arch/arm/mach-omap2/omap-hotplug.c
> +++ b/arch/arm/mach-omap2/omap-hotplug.c
> @@ -17,8 +17,10 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/smp.h>
> +#include <linux/io.h>
>  
>  #include <asm/cacheflush.h>
> +#include <mach/omap-wakeupgen.h>
>  
>  #include "common.h"
>  
> @@ -35,7 +37,8 @@ int platform_cpu_kill(unsigned int cpu)
>   */
>  void __ref platform_cpu_die(unsigned int cpu)
>  {
> -	unsigned int this_cpu;
> +	unsigned int boot_cpu = 0;
> +	void __iomem *base = omap_get_wakeupgen_base();
>  
>  	flush_cache_all();
>  	dsb();
> @@ -43,16 +46,27 @@ void __ref platform_cpu_die(unsigned int cpu)
>  	/*
>  	 * we're ready for shutdown now, so do it
>  	 */
> -	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
> -		pr_err("Secure clear status failed\n");
> +	if (cpu_is_omap44xx()) {
> +		if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
> +			pr_err("Secure clear status failed\n");
> +	} else {
> +		__raw_writel(0, base + OMAP_AUX_CORE_BOOT_0);
> +	}
> +
>  
>  	for (;;) {
>  		/*
>  		 * Enter into low power state
>  		 */
>  		omap4_hotplug_cpu(cpu, PWRDM_POWER_OFF);
> -		this_cpu = smp_processor_id();
> -		if (omap_read_auxcoreboot0() == this_cpu) {
> +
> +		if (cpu_is_omap44xx())
> +			boot_cpu = omap_read_auxcoreboot0();
> +		else
> +			boot_cpu =
> +				__raw_readl(base + OMAP_AUX_CORE_BOOT_0) >> 5;
> +
> +		if (boot_cpu == smp_processor_id()) {
>  			/*
>  			 * OK, proper wakeup, we're done
>  			 */

These should use variables set up during init instead of cpu_is_omapxxx
checks.

> @@ -85,7 +89,11 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	 * the AuxCoreBoot1 register is updated with cpu state
>  	 * A barrier is added to ensure that write buffer is drained
>  	 */
> -	omap_modify_auxcoreboot0(0x200, 0xfffffdff);
> +	if (cpu_is_omap44xx())
> +		omap_modify_auxcoreboot0(0x200, 0xfffffdff);
> +	else
> +		__raw_writel(0x20, base + OMAP_AUX_CORE_BOOT_0);
> +
>  	flush_cache_all();
>  	smp_wmb();
>  
> @@ -124,13 +132,20 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  static void __init wakeup_secondary(void)
>  {
> +	void __iomem *base = omap_get_wakeupgen_base();
> +
>  	/*
>  	 * Write the address of secondary startup routine into the
>  	 * AuxCoreBoot1 where ROM code will jump and start executing
>  	 * on secondary core once out of WFE
>  	 * A barrier is added to ensure that write buffer is drained
>  	 */
> -	omap_auxcoreboot_addr(virt_to_phys(omap_secondary_startup));
> +	if (cpu_is_omap44xx())
> +		omap_auxcoreboot_addr(virt_to_phys(omap_secondary_startup));
> +	else
> +		__raw_writel(virt_to_phys(omap5_secondary_startup),
> +						base + OMAP_AUX_CORE_BOOT_1);
> +
>  	smp_wmb();
>  
>  	/*

Probably these too could be set up during init while at it.

Regards,

Tony
