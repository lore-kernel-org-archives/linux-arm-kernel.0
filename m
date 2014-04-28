From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 28 Apr 2014 15:58:19 +0100
Subject: [Linaro-acpi] [PATCH v3 part1 04/11] ARM64 / ACPI: Introduce
 arm-core.c and its related head file
In-Reply-To: <20140425183848.GE28819@e106331-lin.cambridge.arm.com>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-5-git-send-email-hanjun.guo@linaro.org>
 <20140425155147.GA28819@e106331-lin.cambridge.arm.com>
 <20140425165320.GD1186@xora-haswell>
 <20140425183848.GE28819@e106331-lin.cambridge.arm.com>
Message-ID: <20140428145819.GA31782@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 07:38:48PM +0100, Mark Rutland wrote:

[...]

> > > > +/* Asm macros */
> > > > +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
> > > 
> > > This almost certainly does not do what you think it does.
> > > 
> > > flush_cache_all walks the architected levels of cache visible to the
> > > current CPU (i.e. those in CLIDR_EL1), and walks over each cache line at
> > > that level, cleaning and evicting it. It also flushes the I-cache (which
> > > I don't think you care about here).
> > > 
> > > This is NOT safe if the cache is enabled. Lines can migrate between
> > > levels in the middle of the sequence.
> > > 
> > > In an SMP system this does NOT guarantee that data is evicted to memory,
> > > even if the cache is disabled. Other CPUs with caches enabled can
> > > acquire a cacheline (even if dirty) and it can sit in their cache.
> > > 
> > > In a UP system or an SMP system where all other architected caches are
> > > disabled (and flushed) this does NOT guarantee that data hits memory. In
> > > the presence of a system-level cache this will simply flush the data out
> > > to said system-level rather than memory.
> > > 
> > > I believe the intent here is to have something analogous to WBINVD for
> > > use in idle. Unfortunately there simply isn't anything analogous.
> > > Luckily in the presence of PSCI, the PSCI implementation should do all
> > > of the cache maintenance required to prevent any data loss and/or
> > > corruption, and anything we need to have visible to noncacheable
> > > accesses (i.e. flushed out to memory) we should be able to flush by VA.
> > > 
> > > This maintenance is unsafe, and shouldn't be necessary on any sane
> > > system. Please get rid of it. I would very much like to get rid of
> > > flush_cache_all() before its misuse spreads further.
> > > 
> > Thanks for explanation Mark, you are correct on x86 it is defined as
> > wbinvd().
> > 
> > I think looking at where it is actually used we can make this an empty
> > macro on arm64 for now. Where it used are areas we don't currently
> > execute and need arm64 replacements or refactorising to remove x86isms.
> 
> That sounds good. Is it worth putting a warn or similar there just in
> case?

I think that we are not even at a stage where code using that macro can
be exercised on ARM. S-states and C-states are not set in stone for ARM yet,
so all you can do by defining that macro is making code compile.

It does not make any sense whatsoever to try to execute it.

And I think that instead of shoehorning ARM ACPI code into the pseudo
generic ACPI kernel implementation, we'd better rework the ACPI core code
to make it a bit multi-arch friendly, which isn't at the moment, at least
for S-state and C-states code, because S-states and C-states for ARM have to
be defined and approved before doing anything else.

Lorenzo

> 
> > 
> > > > +/* Basic configuration for ACPI */
> > > > +#ifdef	CONFIG_ACPI
> > > > +extern int acpi_disabled;
> > > > +extern int acpi_noirq;
> > > > +extern int acpi_pci_disabled;
> > > > +extern int acpi_strict;
> > > 
> > > This looks very odd. Why are these prototypes not coming from a header?
> > > If they're defined in the same place, why not move the disable_acpi
> > > function there?
> > > 
> > 
> > This is a header :-)
> 
> True; I must get my eyes tested. :)
> 
> Are these variables expected to be used by needed by other code, or are
> they just for the benefit of the static inlines in this header?
> 
> > I think this is a peculiarity of how acpica is incorporated into linux
> > but will check.
> 
> Ok.
> 
> > 
> > > > +static inline void disable_acpi(void)
> > > > +{
> > > > +	acpi_disabled = 1;
> > > > +	acpi_pci_disabled = 1;
> > > > +	acpi_noirq = 1;
> > > > +}
> > > 
> > > [...]
> > > 
> > > > +/*
> > > > + * __acpi_map_table() will be called before page_init(), so early_ioremap()
> > > > + * or early_memremap() should be called here.
> > > > + */
> > > > +char *__init __acpi_map_table(unsigned long phys, unsigned long size)
> > > > +{
> > > > +	if (!phys || !size)
> > > > +		return NULL;
> > > 
> > > Is there any reason that tables can't exist at physical address 0? It's
> > > entirely valid to have memory there.
> > > 
> > > [...]
> > > 
> > On ARM64 there is not, we can fix this.
> > 
> > > > +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> > > > +{
> > > > +	*irq = -1;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> > > 
> > > This appears to be missing a giant warning that it does nothing useful.
> > > 
> > > I was under the impression that we were meant to use 0 to represent the
> > > lack of an interrupt these days, too...
> > > 
> > We can fix this.
> 
> Sounds good!
> 
> Cheers,
> Mark.
> 
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-acpi
> 
