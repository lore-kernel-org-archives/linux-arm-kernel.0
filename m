From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 06 Nov 2015 11:57:01 -0800
Subject: [PATCH RESEND v2 3/4] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <1446839371-22601-4-git-send-email-kapilh@broadcom.com>
References: <1446839371-22601-1-git-send-email-kapilh@broadcom.com>
 <1446839371-22601-4-git-send-email-kapilh@broadcom.com>
Message-ID: <563D060D.6070606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/15 11:49, Kapil Hali wrote:
> Add SMP support for Broadcom's Northstar Plus SoC
> cpu enable method. This changes also consolidates
> iProc family's - BCM NSP and BCM Kona, platform
> SMP handling in a common file.
> 
> Northstar Plus SoC is based on ARM Cortex-A9
> revision r3p0 which requires configuration for ARM
> Errata 764369 for SMP. This change adds the needed
> configuration option.
> 
> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
> ---

Technically, this is not quite a RESEND, using the same git format-patch
--subject command as before maybe?

[snip]

> +#ifndef __BCM_NSP_H
> +#define __BCM_NSP_H
> +
> +extern void nsp_secondary_startup(void);

This does not appear to be needed anymore since you use the standard
secondary_boot entry point now.

> +
> +#endif /* __BCM_NSP_H */
> diff --git a/arch/arm/mach-bcm/kona_smp.c b/arch/arm/mach-bcm/platsmp.c
> similarity index 75%
> rename from arch/arm/mach-bcm/kona_smp.c
> rename to arch/arm/mach-bcm/platsmp.c
> index 66a0465..925402f 100644
> --- a/arch/arm/mach-bcm/kona_smp.c
> +++ b/arch/arm/mach-bcm/platsmp.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2014 Broadcom Corporation
> + * Copyright (C) 2014-2015 Broadcom Corporation
>   * Copyright 2014 Linaro Limited
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -12,16 +12,23 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/init.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
> +#include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/jiffies.h>
>  #include <linux/of.h>
>  #include <linux/sched.h>
> +#include <linux/smp.h>
>  
> +#include <asm/cacheflush.h>
>  #include <asm/smp.h>
>  #include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  
> +#include "bcm_nsp.h"

Likewise.

> +
>  /* Size of mapped Cortex A9 SCU address space */
>  #define CORTEX_A9_SCU_SIZE	0x58
>  
> @@ -75,6 +82,37 @@ static int __init scu_a9_enable(void)
>  	return 0;
>  }
>  
> +static int nsp_write_lut(void)
> +{
> +	void __iomem *sku_rom_lut;
> +	phys_addr_t secondary_startup_phy;
> +
> +	if (!secondary_boot) {
> +		pr_warn("required secondary boot register not specified\n");
> +		return -EINVAL;
> +	}
> +
> +	sku_rom_lut = ioremap_nocache((phys_addr_t)secondary_boot,
> +						sizeof(secondary_boot));

That looks weird to me, are not you intending to get a virtual mapping
of the SKU ROM LUT base register address here? What would
sizeof(function) return here?

> +	if (!sku_rom_lut) {
> +		pr_warn("unable to ioremap SKU-ROM LUT register\n");
> +		return -ENOMEM;
> +	}
> +
> +	secondary_startup_phy = virt_to_phys(secondary_startup);
> +	BUG_ON(secondary_startup_phy > (phys_addr_t)U32_MAX);
> +
> +	writel_relaxed(secondary_startup_phy, sku_rom_lut);
> +	/*
> +	 * Ensure the write is visible to the secondary core.
> +	 */
> +	smp_wmb();
> +
> +	iounmap(sku_rom_lut);
> +
> +	return 0;
> +}
> +
>  static void __init bcm_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	static cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
> @@ -95,11 +133,11 @@ static void __init bcm_smp_prepare_cpus(unsigned int max_cpus)
>  	/*
>  	 * Our secondary enable method requires a "secondary-boot-reg"
>  	 * property to specify a register address used to request the
> -	 * ROM code boot a secondary code.  If we have any trouble
> +	 * ROM code boot a secondary core.  If we have any trouble
>  	 * getting this we fall back to uniprocessor mode.
>  	 */
>  	if (of_property_read_u32(node, OF_SECONDARY_BOOT, &secondary_boot)) {
> -		pr_err("%s: missing/invalid " OF_SECONDARY_BOOT " property\n",
> +		pr_warn("%s: missing/invalid " OF_SECONDARY_BOOT " property\n",
>  			node->name);
>  		ret = -ENOENT;		/* Arrange to disable SMP */
>  		goto out;
> @@ -115,7 +153,6 @@ out:
>  	of_node_put(node);
>  	if (ret) {
>  		/* Update the CPU present map to reflect uniprocessor mode */
> -		BUG_ON(ret != -ENOENT);
>  		pr_warn("disabling SMP\n");
>  		init_cpu_present(&only_cpu_0);
>  	}
> @@ -139,7 +176,7 @@ out:
>   * - Wait for the secondary boot register to be re-written, which
>   *   indicates the secondary core has started.
>   */
> -static int bcm_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +static int kona_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	void __iomem *boot_reg;
>  	phys_addr_t boot_func;
> @@ -162,7 +199,7 @@ static int bcm_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	boot_reg = ioremap_nocache((phys_addr_t)secondary_boot, sizeof(u32));
>  	if (!boot_reg) {
>  		pr_err("unable to map boot register for cpu %u\n", cpu_id);
> -		return -ENOSYS;
> +		return -ENOMEM;
>  	}
>  
>  	/*
> @@ -191,12 +228,42 @@ static int bcm_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  	pr_err("timeout waiting for cpu %u to start\n", cpu_id);
>  
> -	return -ENOSYS;
> +	return -ENXIO;
> +}
> +
> +static int nsp_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	unsigned long timeout;

This parameter is now unused.

> +	int ret;
> +
> +	/*
> +	 * After wake up, secondary core branches to the startup
> +	 * address programmed at SKU ROM LUT location.
> +	 */
> +	ret = nsp_write_lut();
> +	if (ret) {
> +		pr_err("unable to write startup addr to SKU ROM LUT\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Send a CPU wakeup interrupt to the secondary core.
> +	 */
> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +out:
> +	return ret;
>  }
>  
>  static struct smp_operations bcm_smp_ops __initdata = {
>  	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
> -	.smp_boot_secondary	= bcm_boot_secondary,
> +	.smp_boot_secondary	= kona_boot_secondary,
>  };
>  CPU_METHOD_OF_DECLARE(bcm_smp_bcm281xx, "brcm,bcm11351-cpu-method",
>  			&bcm_smp_ops);
> +
> +struct smp_operations nsp_smp_ops __initdata = {
> +	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
> +	.smp_boot_secondary	= nsp_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(bcm_smp_nsp, "brcm,bcm-nsp-smp", &nsp_smp_ops);
> 


-- 
Florian
