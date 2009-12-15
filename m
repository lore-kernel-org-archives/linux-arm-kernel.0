From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Dec 2009 14:13:25 -0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <000001ca7d90$c4a15330$4de3f990$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

It's getting there! Minor stylistic suggestions inline.

* Jamie Iles wrote:

> To add support for perf events and to allow the hardware
> counters to be shared with oprofile, we need a way to reserve
> access to the pmu (performance monitor unit).
> 
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> new file mode 100644
> index 0000000..e7cc264
> --- /dev/null
> +++ b/arch/arm/include/asm/pmu.h
> @@ -0,0 +1,74 @@
> +/*
> + *  linux/arch/arm/include/asm/pmu.h
> + *
> + *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __ARM_PMU_H__
> +#define __ARM_PMU_H__
> +
> +#ifdef CONFIG_CPU_HAS_PMU
> +
> +struct pmu_irqs {
> +	const int   *irqs;
> +	unsigned    num_irqs;
> +};
> +
> +/**
> + * reserve_pmu() - reserve the hardware performance counters
> + *
> + * Reserve the hardware performance counters in the system for exclusive use.
> + * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
> + * encoded error on failure.
> + */
> +extern const struct pmu_irqs *
> +reserve_pmu(void);

I think it's standard Kernel coding style to put the declaration of a function
all on one line if it fits. The same goes elsewhere in the patch.

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index dd4698c..5cd0ec4 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -536,6 +536,11 @@ config CPU_COPY_FA
>  config CPU_COPY_V6
>  	bool
> 
> +config CPU_HAS_PMU
> +	depends on CPU_V6 || CPU_V7 || CPU_XSCALE
> +	default y
> +	bool

I think you should use XSCALE_PMU instead of CPU_XSCALE. Also, this should
probably be in the top-level ARM Kconfig instead of the mm/ one.

Cheers,

Will
