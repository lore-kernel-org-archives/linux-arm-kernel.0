From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 10 Mar 2015 09:32:18 +0000
Subject: [PATCH v9 05/21] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <54FEA4CC.8090000@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-6-git-send-email-hanjun.guo@linaro.org>
 <20150305185117.GA17415@e102568-lin.cambridge.arm.com>
 <54FEA4CC.8090000@linaro.org>
Message-ID: <20150310093218.GA11931@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 08:01:16AM +0000, Hanjun Guo wrote:

[...]

> >> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> >> new file mode 100644
> >> index 0000000..8b837ab
> >> --- /dev/null
> >> +++ b/arch/arm64/include/asm/acpi.h
> >> @@ -0,0 +1,45 @@
> >> +/*
> >> + *  Copyright (C) 2013-2014, Linaro Ltd.
> >> + *	Author: Al Stone <al.stone@linaro.org>
> >> + *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> >> + *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> >> + *
> >> + *  This program is free software; you can redistribute it and/or modify
> >> + *  it under the terms of the GNU General Public License version 2 as
> >> + *  published by the Free Software Foundation;
> >> + */
> >> +
> >> +#ifndef _ASM_ACPI_H
> >> +#define _ASM_ACPI_H
> >> +
> >> +/* Basic configuration for ACPI */
> >> +#ifdef	CONFIG_ACPI
> >> +#define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
> >> +extern int acpi_disabled;
> >> +extern int acpi_noirq;
> >> +extern int acpi_pci_disabled;
> >> +
> >> +static inline void disable_acpi(void)
> >> +{
> >> +	acpi_disabled = 1;
> >> +	acpi_pci_disabled = 1;
> >> +	acpi_noirq = 1;
> >> +}
> >> +
> >> +/*
> >> + * It's used from ACPI core in kdump to boot UP system with SMP kernel,
> >> + * with this check the ACPI core will not override the CPU index
> >> + * obtained from GICC with 0 and not print some error message as well.
> >> + * Since MADT must provide at least one GICC structure for GIC
> >> + * initialization, CPU will be always available in MADT on ARM64.
> >> + */
> >> +static inline bool acpi_has_cpu_in_madt(void)
> >> +{
> >> +	return true;
> >> +}
> >
> > I am still trying to make sense of what's this is used for, to me
> > it looks like a legacy hack in acpi_processor.c. It is a shame that we need
> > to define functions to paper over legacy hacks that make no sense
> > whatsoever on arm64.
> 
> I'm sorry that I'm confused, why call this as a "hack"? If I remember
> correctly, this is a bugfix for x86 from Redhat folks to test kdump
> on UP system but without CPU entries in MADT table [1], and we make it
> arch independent to introduce acpi_has_cpu_in_madt().

I gathered that, do not tell me it is nice please. ACPI core code
is chock full of things like this that force you to define functions
in arch arm64 since they are called from "generic" code, and I do not
like that, at all.

It can be cleaned up later.

> [1]: commit c401eb8ee37, ACPI / processor: Check if LAPIC is present
> during initialization
> 
> >
> >> +static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> >
> > This is only used on ia64 to pass the _SUN value to arch code to fix up
> > the socket id. See above.
> >
> > You could define last two functions in generic code, and let the
> > arch code that needs them override them.
> >
> > Whether we do it in this series or later, this stuff needs cleaning up.
> >
> >> +
> >> +#endif /* CONFIG_ACPI */
> >> +
> >> +#endif /*_ASM_ACPI_H*/
> >> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> >> index bef04af..218eb7e 100644
> >> --- a/arch/arm64/kernel/Makefile
> >> +++ b/arch/arm64/kernel/Makefile
> >> @@ -34,6 +34,7 @@ arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
> >>   arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
> >>   arm64-obj-$(CONFIG_PCI)			+= pci.o
> >>   arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
> >> +arm64-obj-$(CONFIG_ACPI)		+= acpi.o
> >>
> >>   obj-y					+= $(arm64-obj-y) vdso/
> >>   obj-m					+= $(arm64-obj-m)
> >> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> >> new file mode 100644
> >> index 0000000..f052e7a
> >> --- /dev/null
> >> +++ b/arch/arm64/kernel/acpi.c
> >> @@ -0,0 +1,101 @@
> >> +/*
> >> + *  ARM64 Specific Low-Level ACPI Boot Support
> >> + *
> >> + *  Copyright (C) 2013-2014, Linaro Ltd.
> >> + *	Author: Al Stone <al.stone@linaro.org>
> >> + *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> >> + *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> >> + *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >> + *	Author: Naresh Bhat <naresh.bhat@linaro.org>
> >> + *
> >> + *  This program is free software; you can redistribute it and/or modify
> >> + *  it under the terms of the GNU General Public License version 2 as
> >> + *  published by the Free Software Foundation.
> >> + */
> >> +
> >> +#define pr_fmt(fmt) "ACPI: " fmt
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/bootmem.h>
> >> +#include <linux/cpumask.h>
> >> +#include <linux/init.h>
> >> +#include <linux/irq.h>
> >> +#include <linux/irqdomain.h>
> >> +#include <linux/memblock.h>
> >> +#include <linux/smp.h>
> >> +
> >> +int acpi_noirq;			/* skip ACPI IRQ initialization */
> >> +int acpi_disabled;
> >> +EXPORT_SYMBOL(acpi_disabled);
> >> +
> >> +int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
> >> +EXPORT_SYMBOL(acpi_pci_disabled);
> >> +
> >> +/*
> >> + * __acpi_map_table() will be called before page_init(), so early_ioremap()
> >> + * or early_memremap() should be called here to for ACPI table mapping.
> >> + */
> >> +char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> >> +{
> >> +	if (!phys || !size)
> >
> > Is there a reason to rule out physical address 0x0 ?
> 
> No particular reasons, unless some arch/firmware limits, I'm
> not sure if we need this check (x86 needs it), I'm CC Leif
> to confirm.

If there is no particular reason the check should not be there, "x86
needs it" is not a good reason, there is arch specific code for that
in x86 directories.

Ok, let's wait for Leif to confirm that.

Thanks,
Lorenzo
