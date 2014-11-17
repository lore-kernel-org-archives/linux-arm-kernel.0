From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Nov 2014 17:10:10 +0000
Subject: some question about TCR setting
In-Reply-To: <CAOVJa8EaX2khQ6C05WwERgGaMUwPctZFe8zU0RYdz6Q9nZqT1w@mail.gmail.com>
References: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
 <20141114104246.GA25828@leverpostej>
 <CAOVJa8Fx4yiSU0O7HTaYEKOrRdtWve4JGeN0cWRXDsBMyV_8Mg@mail.gmail.com>
 <20141114135531.GA27768@leverpostej>
 <CAOVJa8GB=pk4SFEArcEGWF8g12105F_9YUL0hH5k+WW6=WWOBg@mail.gmail.com>
 <20141116165211.GL4042@n2100.arm.linux.org.uk>
 <CAOVJa8EaX2khQ6C05WwERgGaMUwPctZFe8zU0RYdz6Q9nZqT1w@mail.gmail.com>
Message-ID: <20141117171010.GE25416@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 02:37:18AM +0000, vichy wrote:
> hi Russel:
> >> if those page tables are not mapped into the virtual address space,
> >> how OS create them?
> >> (AFAIK, once System.M is enabled, the processor cannot access where
> >> page table doesn't map to)
> >> except those page tables are created before System.M enabled.
> >
> > The OS temporarily maps the page tables into virtual space to update
> > them.  Once updated, the OS unmaps the page tables.
> >
> > However, forget this detail - the MMU page table walker knows nothing
> > about the virtual address space: MMU page table walks do not happen in
> > the virtual address space, they happen in the physical address space.
> > So, it makes no odds what so ever whether the table is mapped or not.
> 
> For some processors, if the type of L1 cache is VIPT, does that mean
> MMU page table will not be cached in this level of cache?

The page tables could be allocated into any level of cache while they
are mapped (consider speculation by the CPU). Depending on whether the
page table walks are coherent the tables may no be visible to the
walkers from L1.

On ARMv8 (or ARMv7 with multiprocessor extensions) the walks are
coherent, and will look in the L1 if necessary. 

> >> BTW, why we need to set page table walk attribute as sharable and
> >> inner/outer cacheable?
> >
> > The access type is included on the bus along with the address and other
> > attributes.  This includes whether it's sharable, and the cache attributes.
> > A MMU page walker may be implemented such that it is capable of accessing
> > L2 cache.
> >
> > In that case, we would want the MMU page walker to be able to read from
> > the L2 cache, which would need the access to be marked as "normal memory,
> > cacheable" so that the cache is searched for a matching line.  This in
> > turn means that software does not have to flush page table updates all
> > the way back to the physical memory - merely flushing them out of the L1
> > cache is sufficient.
> so Inner/outer attributes are use to determine whether it is cached in
> L1 or L2 cache, right?

Inner and Outer cacheability might not map to L1 and L2. If you are
lucky on ARMv8 CLIDR_EL1.ICB will tell you the boundary between inner
and outer caches, but current implementations are unlikely to.

> how about sharable?
> AFAIK, sharable means for a particular domain it requires hardware to
> ensure that
> the location is coherent for all agents in that domain.
> Since page table is unique to each processor, why we need to share it
> between other cores?

We share page tables between CPUs. On arm64 all CPUs share the same
swappper pgdir in TTBR1_EL1, and if executing threads within the same
task may share the same pgdir in TTBR0_EL1.

Additionally, to prevent issues with mismatched attributes, the TCR
should have the same attributes for walks as we have for mappings of the
memory containing the page tables. We map memory as Normal, Outer
Write-back non-transient, Inner Write-back non-transient, so we must
make page table walks with those same attributes.

Thanks,
Mark.
