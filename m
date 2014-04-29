From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 29 Apr 2014 10:45:01 +0100
Subject: [PATCH v3 part1 04/11] ARM64 / ACPI: Introduce arm-core.c and
 its related head file
In-Reply-To: <1398432017-8506-5-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140429094501.2CAECC4095B@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Apr 2014 21:20:10 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> ACPI core need lots extern variables and functions which should
> be provided by arch dependent code to make itself compilable. so
> introduce arm_core.c and its related header file here.
> 
> acpi_boot_table_init() will be called in setup_arch() before
> paging_init(), so we should use eary_ioremap() mechanism here
> to get the RSDP and all the table pointers, with this patch,
> we can get ACPI boot-time tables from firmware on ARM64.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Looks okay to me.

Reviewed-by: Grant Likely <grant.likely@linaro.org>

> ---
>  arch/arm64/include/asm/acpi.h |   53 +++++++++++++++++++
>  arch/arm64/kernel/setup.c     |    4 ++
>  drivers/acpi/Makefile         |    2 +
>  drivers/acpi/plat/Makefile    |    1 +
>  drivers/acpi/plat/arm-core.c  |  113 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 173 insertions(+)
>  create mode 100644 drivers/acpi/plat/Makefile
>  create mode 100644 drivers/acpi/plat/arm-core.c
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index e3e990e..3ac9dfb 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -19,6 +19,43 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>  
> +#include <asm/cacheflush.h>
> +
> +#include <linux/init.h>
> +
> +#define COMPILER_DEPENDENT_INT64	s64
> +#define COMPILER_DEPENDENT_UINT64	u64
> +
> +/*
> + * Calling conventions:
> + *
> + * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
> + * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
> + * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
> + * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
> + */
> +#define ACPI_SYSTEM_XFACE
> +#define ACPI_EXTERNAL_XFACE
> +#define ACPI_INTERNAL_XFACE
> +#define ACPI_INTERNAL_VAR_XFACE
> +
> +/* Asm macros */
> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
> +
> +/* Basic configuration for ACPI */
> +#ifdef	CONFIG_ACPI
> +extern int acpi_disabled;
> +extern int acpi_noirq;
> +extern int acpi_pci_disabled;
> +extern int acpi_strict;
> +
> +static inline void disable_acpi(void)
> +{
> +	acpi_disabled = 1;
> +	acpi_pci_disabled = 1;
> +	acpi_noirq = 1;
> +}
> +
>  static inline bool arch_has_acpi_pdc(void)
>  {
>  	/*
> @@ -34,4 +71,20 @@ static inline void arch_acpi_set_pdc_bits(u32 *buf)
>  	return;
>  }
>  
> +static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
> +static inline void acpi_disable_pci(void)
> +{
> +	acpi_pci_disabled = 1;
> +	acpi_noirq_set();
> +}
> +
> +/*
> + * The ACPI processor driver for ACPI core code needs this macro.
> + * Temporarily define it to -1 so that the ACPI core can compile,
> + * but update it when we get the hardware ID from the MADT table.
> + */ 
> +#define cpu_physical_id(cpu) -1
> +
> +#endif /* CONFIG_ACPI */
> +
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 720853f..70658e1 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -41,6 +41,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/fixmap.h>
>  #include <asm/cputype.h>
> @@ -368,6 +369,9 @@ void __init setup_arch(char **cmdline_p)
>  
>  	arm64_memblock_init();
>  
> +	/* Parse the ACPI tables for possible boot-time configuration */
> +	acpi_boot_table_init();
> +
>  	paging_init();
>  	request_standard_resources();
>  
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 0331f91..8521c97 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -83,3 +83,5 @@ obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
>  obj-$(CONFIG_ACPI_APEI)		+= apei/
>  
>  obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
> +
> +obj-y				+= plat/
> diff --git a/drivers/acpi/plat/Makefile b/drivers/acpi/plat/Makefile
> new file mode 100644
> index 0000000..46bc65e
> --- /dev/null
> +++ b/drivers/acpi/plat/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ARM64)	+= arm-core.o
> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
> new file mode 100644
> index 0000000..47b5d9b
> --- /dev/null
> +++ b/drivers/acpi/plat/arm-core.c
> @@ -0,0 +1,113 @@
> +/*
> + *  ARM/ARM64 Specific Low-Level ACPI Boot Support
> + *
> + *  Copyright (C) 2013~2014, Al Stone <al.stone@linaro.org>
> + *  Copyright (C) 2013~2014, Graeme Gregory <graeme.gregory@linaro.org>
> + *  Copyright (C) 2013~2014, Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/cpumask.h>
> +#include <linux/memblock.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/bootmem.h>
> +#include <linux/smp.h>
> +
> +#include <asm/pgtable.h>
> +
> +/*
> + * We never plan to use RSDT on arm/arm64 as its deprecated in spec but this
> + * variable is still required by the ACPI core
> + */
> +u32 acpi_rsdt_forced;
> +
> +int acpi_noirq;			/* skip ACPI IRQ initialization */
> +int acpi_strict;
> +int acpi_disabled;
> +EXPORT_SYMBOL(acpi_disabled);
> +
> +int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
> +EXPORT_SYMBOL(acpi_pci_disabled);
> +
> +enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
> +
> +/*
> + * __acpi_map_table() will be called before page_init(), so early_ioremap()
> + * or early_memremap() should be called here.
> + */
> +char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> +{
> +	if (!phys || !size)
> +		return NULL;
> +
> +	return early_ioremap(phys, size);
> +}
> +
> +void __init __acpi_unmap_table(char *map, unsigned long size)
> +{
> +	if (!map || !size)
> +		return;
> +
> +	early_iounmap(map, size);
> +}
> +
> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> +{
> +	*irq = -1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> +
> +/*
> + * success: return IRQ number (>0)
> + * failure: return =< 0
> + */
> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> +{
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> +
> +void acpi_unregister_gsi(u32 gsi)
> +{
> +}
> +EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> +
> +/*
> + * acpi_boot_table_init() called from setup_arch(), always.
> + *	1. find RSDP and get its address, and then find XSDT
> + *	2. extract all tables and checksums them all
> + *
> + * We can parse ACPI boot-time tables such as FADT, MADT after
> + * this function is called.
> + */
> +void __init acpi_boot_table_init(void)
> +{
> +	/* If acpi_disabled, bail out */
> +	if (acpi_disabled)
> +		return;
> +
> +	/* Initialize the ACPI boot-time table parser. */
> +	if (acpi_table_init()) {
> +		disable_acpi();
> +		return;
> +	}
> +}
> -- 
> 1.7.9.5
> 
