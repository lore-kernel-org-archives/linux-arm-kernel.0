From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 11:01:23 +0100
Subject: [RFC PATCH 06/17] ARM: kernel: save/restore generic infrastructure
In-Reply-To: <1310053830-23779-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-7-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110709100123.GG4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The idea of splitting a large patch up into smaller patches is to do
it in a logical way so that:

1. Each patch is self-contained, adding a single new - and where possible
   complete - feature or bug fix.
2. Ease of review.

Carving your big patch up by file does not do either of this, because
all patches interact with each other.  There's people within ARM Ltd who
have been dealing with patch sets for some time who you could ask advice
from - or who you could ask to review your patches before you send them
out on the mailing list.

On Thu, Jul 07, 2011 at 04:50:19PM +0100, Lorenzo Pieralisi wrote:
> diff --git a/arch/arm/kernel/sr.h b/arch/arm/kernel/sr.h
> new file mode 100644
> index 0000000..6b24e53
> --- /dev/null
> +++ b/arch/arm/kernel/sr.h
> @@ -0,0 +1,162 @@
> +#define SR_NR_CLUSTERS 1
> +
> +#define STACK_SIZE 512
> +
> +#define CPU_A5			0x4100c050

Not used in this patch - should it be in some other patch?

> +#define CPU_A8			0x4100c080

Not used in this patch - should it be in some other patch?

> +#define CPU_A9			0x410fc090

Not used in this patch - and if this is generic code then it should not
be specific to any CPU.  Please get rid of all these definitions, and
if they're used you need to rework these patches to have proper separation
of generic code from CPU specific code.

> +#define L2_DATA_SIZE		16

Not used in this patch.

> +#define CONTEXT_SPACE_UNCACHED	(2 * PAGE_SIZE)
> +#define PA(f) ((typeof(f) *)virt_to_phys((void *)f))

This is just messed up.  Physical addresses aren't pointers, they're
numeric.  PA() is not used in this patch either, so it appears it can
be deleted.

> +extern int lookup_arch(void);

This doesn't exist in this patch, should it be in another patch or
deleted?

> +/*
> + * Global variables
> + */
> +extern struct sr_main_table main_table;
> +extern unsigned long idle_save_context;
> +extern unsigned long idle_restore_context;
> +extern unsigned long idle_mt;
> +extern void *context_memory_uncached;

Why does this need to be a global?

> +
> +/*
> + * Context save/restore
> + */
> +typedef u32 (sr_save_context_t)
> +	(struct sr_cluster *,
> +	struct sr_cpu*, u32);

Fits on one line so should be on one line.

> +typedef u32 (sr_restore_context_t)
> +	(struct sr_cluster *,
> +	struct sr_cpu*);

Fits on one line so should be on one line.

> +
> +extern sr_save_context_t sr_save_context;

This doesn't exist in this patch, should it be in another patch?

> +extern sr_restore_context_t sr_restore_context;

Ditto.

> +
> +
> +extern struct sr_arch *get_arch(void);

Ditto.

> +
> +
> +/*
> + * 1:1 mappings
> + */
> +
> +extern int linux_sr_setup_translation_tables(void);

Ditto.

> +
> +/*
> + * dumb memory allocator
> + */
> +
> +extern void *get_memory(unsigned int size);
> +
> +/*
> + * Entering/Leaving C-states function entries
> + */
> +
> +extern int sr_platform_enter_cstate(unsigned cpu_index, struct sr_cpu *cpu,
> +		struct sr_cluster *cluster);
> +extern int sr_platform_leave_cstate(unsigned cpu_index, struct sr_cpu *cpu,
> +		struct sr_cluster *cluster);

See comment at the bottom - would inline functions here be better
or maybe even place them at the callsite to make the code easier to
understand if they're only used at one location.

> +
> +/* save/restore main table */
> +extern struct sr_main_table main_table;

Why do we have two 'main_table' declarations in this same header file?

> +
> +/*
> + * Init functions
> + */
> +
> +extern int sr_platform_runtime_init(void);

Not defined in this patch.

> +extern int sr_platform_init(void);
> +extern int sr_context_init(void);
> +
> +
> +/*
> + * v7 specific
> + */
> +
> +extern char *cpu_v7_suspend_size;

No - stop going underneath the covers of existing APIs to get what you
want.  Use cpu_suspend() and cpu_resume() directly.  Note that they've
changed to be more flexible and those patches have been on this mailing
list, and will be going in for 3.1.

If they still don't do what you need, I'm going to be *pissed* because
you've obviously known that they don't yet you haven't taken the time
to get involved on this mailing list with the discussions over it.

> +extern void scu_cpu_mode(void __iomem *base, int state);

Not defined in this patch - should it be in another patch or deleted?

> +
> +/*
> + * These arrays keep suitable stack pointers for CPUs.
> + *
> + * The memory must be 8-byte aligned.
> + */
> +
> +extern unsigned long platform_cpu_stacks[CONFIG_NR_CPUS];

Ditto.

> +extern unsigned long platform_cpu_nc_stacks[CONFIG_NR_CPUS];

Ditto.

And should these be per-cpu variables?  In any case, CONFIG_NR_CPUS
doesn't look right here, NR_CPUS is probably what you want.

> +#endif
> diff --git a/arch/arm/kernel/sr_context.c b/arch/arm/kernel/sr_context.c
> new file mode 100644
> index 0000000..25eaa43
> --- /dev/null
> +++ b/arch/arm/kernel/sr_context.c
> @@ -0,0 +1,23 @@
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
> +#include <linux/cache.h>
> +#include <asm/cacheflush.h>
> +#include "sr.h"
> +
> +int  sr_context_init(void)
> +{
> +	idle_save_context = (unsigned long) arch->save_context;

This looks wrong.  idle_save_context probably has the wrong type.

> +	idle_restore_context = __pa(arch->restore_context);
> +	__cpuc_flush_dcache_area(&idle_restore_context, sizeof(unsigned long));
> +	outer_clean_range(__pa(&idle_restore_context),
> +			__pa(&idle_restore_context + 1));

This kind of thing needs rethinking - calling these internal functions
directly just isn't on.

> +	return 0;
> +}

And why have a single .c file for just one function?  With all the
copyright headers on each file this just results in extra LOC bloat,
which given the situation we find ourselves in with mainline is
*definitely* a bad idea.

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
> +	return cpu & 0xf;
> +}

Use smp_processor_id() for indexes into kernel based structures, which
has to be a unique CPU number for any CPU in the system.  You only need
the physical CPU ID when talking to the hardware.

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

This I imagine is another CPU specific register.  On ARM926 its a register
which controls the cache mode (writeback vs writethrough).

> +
> +#ifdef CONFIG_SMP
> +static inline void exit_coherency(void)
> +{
> +	unsigned int v;
> +	asm volatile (
> +		"mrc	p15, 0, %0, c1, c0, 1\n"
> +		"bic	%0, %0, %1\n"
> +		"mcr	p15, 0, %0, c1, c0, 1\n"
> +		 : "=&r" (v)
> +		 : "Ir" (0x40)
> +		 : );
> +}

Firstly, this is specific to ARM CPUs.  Secondly, the bit you require
is very CPU specific even then.  Some it's 0x40, others its 0x20.  So
this just does not deserve to be in generic code.

> +#else
> +static inline void exit_coherency(void) { }
> +#endif
> +
> +extern void default_sleep(void);
> +extern void sr_suspend(void *);
> +extern void sr_resume(void *, int);
> +extern void disable_clean_inv_dcache_v7_all(void);
> diff --git a/arch/arm/kernel/sr_platform.c b/arch/arm/kernel/sr_platform.c
> new file mode 100644
> index 0000000..530aa1b
> --- /dev/null
> +++ b/arch/arm/kernel/sr_platform.c
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright (C) 2008-2011 ARM Limited
> + *
> + * Author(s): Jon Callan, Lorenzo Pieralisi
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <asm/memory.h>
> +#include <asm/page.h>
> +#include <asm/sr_platform_api.h>
> +#include "sr.h"
> +
> +void *context_memory_uncached;
> +
> +/*
> + * Simple memory allocator function.
> + * Returns start address of allocated region
> + * Memory is zero-initialized.
> + */
> +
> +static unsigned int watermark;
> +
> +void *get_memory(unsigned int size)
> +{
> +	unsigned ret;
> +	void *vmem = NULL;
> +
> +	ret = watermark;
> +	watermark += size;
> +	BUG_ON(watermark >= CONTEXT_SPACE_UNCACHED);
> +	vmem = (context_memory_uncached + ret);
> +	watermark = ALIGN(watermark, sizeof(long long));
> +
> +	return vmem;
> +}
> +
> +int  sr_platform_init(void)
> +{
> +	memset(context_memory_uncached, 0, CONTEXT_SPACE_UNCACHED);
> +	return arch->init();
> +}

sr_platform_init() looks like its a pointless additional function just
here to obfuscate the code.  This code could very well be at the
sr_platform_init() callsite, which would help make the code more
understandable.

And why the initialization of your simple memory allocator is part of
the platform code I've no idea.

> diff --git a/arch/arm/kernel/sr_power.c b/arch/arm/kernel/sr_power.c
> new file mode 100644
> index 0000000..2585559
> --- /dev/null
> +++ b/arch/arm/kernel/sr_power.c
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (C) 2008-2011 ARM Limited
> + *
> + * Author(s): Jon Callan, Lorenzo Pieralisi
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include "sr.h"
> +
> +int sr_platform_enter_cstate(unsigned cpu_index,
> +			       struct sr_cpu *cpu,
> +			       struct sr_cluster *cluster)
> +{
> +	return arch->enter_cstate(cpu_index, cpu, cluster);
> +}
> +
> +int sr_platform_leave_cstate(unsigned cpu_index,
> +			       struct sr_cpu *cpu,
> +			       struct sr_cluster *cluster)
> +{
> +	return arch->leave_cstate(cpu_index, cpu, cluster);
> +}

Is this really worth being a new separate .c file when all it does is
call other functions via pointers.  What about an inline function
doing this in a header file.
