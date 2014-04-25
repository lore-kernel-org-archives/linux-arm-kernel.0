From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 Apr 2014 16:51:47 +0100
Subject: [PATCH v3 part1 04/11] ARM64 / ACPI: Introduce arm-core.c and
 its related head file
In-Reply-To: <1398432017-8506-5-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140425155147.GA28819@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On Fri, Apr 25, 2014 at 02:20:10PM +0100, Hanjun Guo wrote:
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

Is there any reason this can't be in a common ACPI header shared be ia64
and x86 too? Given we already have generic types for this it seems
pointless to define this in each architecture.

It looks like include/acpi/actypes.h tries to do that already...

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

This almost certainly does not do what you think it does.

flush_cache_all walks the architected levels of cache visible to the
current CPU (i.e. those in CLIDR_EL1), and walks over each cache line at
that level, cleaning and evicting it. It also flushes the I-cache (which
I don't think you care about here).

This is NOT safe if the cache is enabled. Lines can migrate between
levels in the middle of the sequence.

In an SMP system this does NOT guarantee that data is evicted to memory,
even if the cache is disabled. Other CPUs with caches enabled can
acquire a cacheline (even if dirty) and it can sit in their cache.

In a UP system or an SMP system where all other architected caches are
disabled (and flushed) this does NOT guarantee that data hits memory. In
the presence of a system-level cache this will simply flush the data out
to said system-level rather than memory.

I believe the intent here is to have something analogous to WBINVD for
use in idle. Unfortunately there simply isn't anything analogous.
Luckily in the presence of PSCI, the PSCI implementation should do all
of the cache maintenance required to prevent any data loss and/or
corruption, and anything we need to have visible to noncacheable
accesses (i.e. flushed out to memory) we should be able to flush by VA.

This maintenance is unsafe, and shouldn't be necessary on any sane
system. Please get rid of it. I would very much like to get rid of
flush_cache_all() before its misuse spreads further.

> +/* Basic configuration for ACPI */
> +#ifdef	CONFIG_ACPI
> +extern int acpi_disabled;
> +extern int acpi_noirq;
> +extern int acpi_pci_disabled;
> +extern int acpi_strict;

This looks very odd. Why are these prototypes not coming from a header?
If they're defined in the same place, why not move the disable_acpi
function there?

> +static inline void disable_acpi(void)
> +{
> +	acpi_disabled = 1;
> +	acpi_pci_disabled = 1;
> +	acpi_noirq = 1;
> +}

[...]

> +/*
> + * __acpi_map_table() will be called before page_init(), so early_ioremap()
> + * or early_memremap() should be called here.
> + */
> +char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> +{
> +	if (!phys || !size)
> +		return NULL;

Is there any reason that tables can't exist at physical address 0? It's
entirely valid to have memory there.

[...]

> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> +{
> +	*irq = -1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);

This appears to be missing a giant warning that it does nothing useful.

I was under the impression that we were meant to use 0 to represent the
lack of an interrupt these days, too...

Cheers,
Mark.
