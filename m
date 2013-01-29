From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 29 Jan 2013 10:46:42 +0000
Subject: [PATCH v3 14/15] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <1359445870-18925-15-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-15-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130129104642.GK30563@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 07:51:09AM +0000, Nicolas Pitre wrote:

[...]

> +		/*
> +		 * Flush the local CPU cache.
> +		 *
> +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> +		 * a preliminary flush here for those CPUs.  At least, that's
> +		 * the theory -- without the extra flush, Linux explodes on
> +		 * RTSM (maybe not needed anymore, to be investigated).
> +		 */
> +		flush_cache_louis();

This is not needed. If it is, that is a model bug and should be flagged
up as such.

> +		cpu_proc_fin(); /* disable allocation into internal caches*/

This code disables the I-cache causing following instruction fetches from
DRAM; that is extremely slow and should be avoided, there is no point in
disabling the I-cache here, that is not required.

On fast-models that's a non-issue, but I really want to prevent copy'n'paste
of this sequence as it stands.

> +		flush_cache_louis();
> +
> +		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> +		set_auxcr(get_auxcr() & ~(1 << 6));
>  	}
>  
> -	/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> -	set_auxcr(get_auxcr() & ~(1 << 6));
> +	__mcpm_cpu_down(cpu, cluster);
>  
>  	/* Now we are prepared for power-down, do it: */
>  	if (!skip_wfi) {
> @@ -179,6 +211,8 @@ static void __init dcscb_usage_count_init(void)
>  	dcscb_use_count[cpu][cluster] = 1;
>  }
>  
> +extern void dcscb_power_up_setup(unsigned int affinity_level);
> +
>  static int __init dcscb_init(void)
>  {
>  	unsigned int cfg;
> @@ -193,6 +227,8 @@ static int __init dcscb_init(void)
>  	dcscb_usage_count_init();
>  
>  	ret = mcpm_platform_register(&dcscb_power_ops);
> +	if (!ret)
> +		ret = mcpm_sync_init(dcscb_power_up_setup);
>  	if (ret) {
>  		iounmap(dcscb_base);
>  		return ret;
> diff --git a/arch/arm/mach-vexpress/dcscb_setup.S b/arch/arm/mach-vexpress/dcscb_setup.S
> new file mode 100644
> index 0000000000..cac033b982
> --- /dev/null
> +++ b/arch/arm/mach-vexpress/dcscb_setup.S
> @@ -0,0 +1,80 @@
> +/*
> + * arch/arm/include/asm/dcscb_setup.S
> + *
> + * Created by:  Dave Martin, 2012-06-22
> + * Copyright:   (C) 2012-2013  Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +
> +#include <linux/linkage.h>
> +#include <asm/mcpm_entry.h>
> +
> +
> +#define SLAVE_SNOOPCTL_OFFSET	0
> +#define SNOOPCTL_SNOOP_ENABLE	(1 << 0)
> +#define SNOOPCTL_DVM_ENABLE	(1 << 1)
> +
> +#define CCI_STATUS_OFFSET	0xc
> +#define STATUS_CHANGE_PENDING	(1 << 0)
> +
> +#define CCI_SLAVE_OFFSET(n)	(0x1000 + 0x1000 * (n))
> +
> +#define RTSM_CCI_PHYS_BASE	0x2c090000
> +#define RTSM_CCI_SLAVE_A15	3
> +#define RTSM_CCI_SLAVE_A7	4

We need to remove these hardcoded values in due course as you know, I am
working on new code that allows us to match the CCI port address to
MPIDR on resume.

Lorenzo
