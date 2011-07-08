From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 07 Jul 2011 18:58:19 -0700
Subject: [RFC PATCH 06/17] ARM: kernel: save/restore generic infrastructure
In-Reply-To: <1310053830-23779-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-7-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4E16643B.5020305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> This patch provides the code infrastructure needed to maintain
> a generic per-cpu architecture implementation of idle code.
>
> sr_platform.c :
> 	- code manages patchset initialization and memory management
>
> sr_context.c:
> 	- code initializes run-time context save/restore generic
> 	  support
>
> sr_power.c:
> 	- provides the generic infrastructure to enter exit low
> 	  power modes and communicate with Power Control Unit (PCU)
>
> v7 support hinges on the basic infrastructure to provide per-cpu
> arch implementation basically through standard function pointers
> signatures.
>
> Preprocessor defines include size of data needed to save/restore
> L2 state. This define value should be moved to the respective
> subsystem (PL310) once the patchset IF to that subsystem is settled.
>
> Signed-off-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
> ---

[...]

> diff --git a/arch/arm/kernel/sr_helpers.h b/arch/arm/kernel/sr_helpers.h
> new file mode 100644
> index 0000000..1ae3a9a
> --- /dev/null
> +++ b/arch/arm/kernel/sr_helpers.h
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright (C) 2008-2011 ARM Limited
> + * Author(s): Jon Callan, Lorenzo Pieralisi
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +static inline int sr_platform_get_cpu_index(void)
> +{
> +	unsigned int cpu;
> +	__asm__ __volatile__(
> +			"mrc	p15, 0, %0, c0, c0, 5\n\t"
> +			: "=r" (cpu));
> +	return cpu&  0xf;
> +}
> +
> +/*
> + * Placeholder for further extensions
> + */
> +static inline int sr_platform_get_cluster_index(void)
> +{
> +	return 0;
> +}
> +
> +static inline void __iomem *sr_platform_cbar(void)
> +{
> +	void __iomem *base;
> +	__asm__ __volatile__(
> +			"mrc	p15, 4, %0, c15, c0, 0\n\t"
> +			: "=r" (base));
> +	return base;
> +}
> +
> +#ifdef CONFIG_SMP
> +static inline void exit_coherency(void)
> +{
> +	unsigned int v;
> +	asm volatile (
> +		"mrc	p15, 0, %0, c1, c0, 1\n"
> +		"bic	%0, %0, %1\n"
> +		"mcr	p15, 0, %0, c1, c0, 1\n"
You should have a isb here.

> +		 : "=&r" (v)
> +		 : "Ir" (0x40)
> +		 : );
> +}

To avoid aborts on platform which doesn't provide
access to SMP bit, NSACR bit 18 should be read.
Something like....

   mrc     p15, 0, r0, c1, c1, 2
   tst     r0, #(1 << 18)
   mrcne   p15, 0, r0, c1, c0, 1
   bicne   r0, r0, #(1 << 6)
   mcrne   p15, 0, r0, c1, c0, 1

Regards
Santosh
