From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 5 Mar 2015 18:51:17 +0000
Subject: [PATCH v9 05/21] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <1424853601-6675-6-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150305185117.GA17415@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 08:39:45AM +0000, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> As we want to get ACPI tables to parse and then use the information
> for system initialization, we should get the RSDP (Root System
> Description Pointer) first, it then locates Extended Root Description
> Table (XSDT) which contains all the 64-bit physical address that
> pointer to other boot-time tables.
> 
> Introduce acpi.c and its related head file in this patch to provide
> fundamental needs of extern variables and functions for ACPI core,
> and then get boot-time tables as needed.
>   - asm/acenv.h for arch specific ACPICA environments and
>     implementation, It is needed unconditionally by ACPI core;

I am not sure we will ever need it since the global lock is not
needed on HW reduced ACPI (ie ACPI on arm64), and instructions to
flush the caches are not needed either on arm64.

Anyway, I will have a look if it is worth writing optimized div/shift,
to give it a purpose to exist.

[...]

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> new file mode 100644
> index 0000000..8b837ab
> --- /dev/null
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -0,0 +1,45 @@
> +/*
> + *  Copyright (C) 2013-2014, Linaro Ltd.
> + *	Author: Al Stone <al.stone@linaro.org>
> + *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> + *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation;
> + */
> +
> +#ifndef _ASM_ACPI_H
> +#define _ASM_ACPI_H
> +
> +/* Basic configuration for ACPI */
> +#ifdef	CONFIG_ACPI
> +#define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
> +extern int acpi_disabled;
> +extern int acpi_noirq;
> +extern int acpi_pci_disabled;
> +
> +static inline void disable_acpi(void)
> +{
> +	acpi_disabled = 1;
> +	acpi_pci_disabled = 1;
> +	acpi_noirq = 1;
> +}
> +
> +/*
> + * It's used from ACPI core in kdump to boot UP system with SMP kernel,
> + * with this check the ACPI core will not override the CPU index
> + * obtained from GICC with 0 and not print some error message as well.
> + * Since MADT must provide at least one GICC structure for GIC
> + * initialization, CPU will be always available in MADT on ARM64.
> + */
> +static inline bool acpi_has_cpu_in_madt(void)
> +{
> +	return true;
> +}

I am still trying to make sense of what's this is used for, to me
it looks like a legacy hack in acpi_processor.c. It is a shame that we need
to define functions to paper over legacy hacks that make no sense
whatsoever on arm64.

> +static inline void arch_fix_phys_package_id(int num, u32 slot) { }

This is only used on ia64 to pass the _SUN value to arch code to fix up
the socket id. See above.

You could define last two functions in generic code, and let the
arch code that needs them override them.

Whether we do it in this series or later, this stuff needs cleaning up.

> +
> +#endif /* CONFIG_ACPI */
> +
> +#endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index bef04af..218eb7e 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -34,6 +34,7 @@ arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>  arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
>  arm64-obj-$(CONFIG_PCI)			+= pci.o
>  arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
> +arm64-obj-$(CONFIG_ACPI)		+= acpi.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> new file mode 100644
> index 0000000..f052e7a
> --- /dev/null
> +++ b/arch/arm64/kernel/acpi.c
> @@ -0,0 +1,101 @@
> +/*
> + *  ARM64 Specific Low-Level ACPI Boot Support
> + *
> + *  Copyright (C) 2013-2014, Linaro Ltd.
> + *	Author: Al Stone <al.stone@linaro.org>
> + *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> + *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> + *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> + *	Author: Naresh Bhat <naresh.bhat@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "ACPI: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bootmem.h>
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/memblock.h>
> +#include <linux/smp.h>
> +
> +int acpi_noirq;			/* skip ACPI IRQ initialization */
> +int acpi_disabled;
> +EXPORT_SYMBOL(acpi_disabled);
> +
> +int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
> +EXPORT_SYMBOL(acpi_pci_disabled);
> +
> +/*
> + * __acpi_map_table() will be called before page_init(), so early_ioremap()
> + * or early_memremap() should be called here to for ACPI table mapping.
> + */
> +char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> +{
> +	if (!phys || !size)

Is there a reason to rule out physical address 0x0 ?

Thanks,
Lorenzo

> +		return NULL;
> +
> +	return early_memremap(phys, size);
> +}
> +
> +void __init __acpi_unmap_table(char *map, unsigned long size)
> +{
> +	if (!map || !size)
> +		return;
> +
> +	early_memunmap(map, size);
> +}
> +
> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
> +{
> +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> +
> +	/*
> +	 * Revision in table header is the FADT Major revision, and there
> +	 * is a minor revision of FADT which was introduced by ACPI 5.1,
> +	 * we only deal with ACPI 5.1 or newer revision to get GIC and SMP
> +	 * boot protocol configuration data, or we will disable ACPI.
> +	 */
> +	if (table->revision > 5 ||
> +	    (table->revision == 5 && fadt->minor_revision >= 1))
> +		return 0;
> +
> +	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
> +		table->revision, fadt->minor_revision);
> +	disable_acpi();
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * acpi_boot_table_init() called from setup_arch(), always.
> + *	1. find RSDP and get its address, and then find XSDT
> + *	2. extract all tables and checksums them all
> + *	3. check ACPI FADT revision
> + *
> + * We can parse ACPI boot-time tables such as MADT after
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
> +
> +	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt)) {
> +		/* disable ACPI if no FADT is found */
> +		disable_acpi();
> +		pr_err("Can't find FADT\n");
> +	}
> +}
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index e8420f6..4f1a014 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -17,6 +17,7 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/stddef.h>
> @@ -46,6 +47,7 @@
>  #include <linux/efi.h>
>  #include <linux/personality.h>
>  
> +#include <asm/acpi.h>
>  #include <asm/fixmap.h>
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
> @@ -380,6 +382,9 @@ void __init setup_arch(char **cmdline_p)
>  	efi_init();
>  	arm64_memblock_init();
>  
> +	/* Parse the ACPI tables for possible boot-time configuration */
> +	acpi_boot_table_init();
> +
>  	paging_init();
>  	request_standard_resources();
>  
> -- 
> 1.9.1
> 
> 
