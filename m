From: m.bielski@virtualopensystems.com (Maciej Bielski)
Date: Mon, 24 Apr 2017 18:44:39 +0200
Subject: [PATCH 3/5] Memory hotplug support for arm64 platform (v2)
In-Reply-To: <20170411155843.GC32267@leverpostej>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
 <50119579bdbb23a4d888d13b0a46cb2e027839ed.1491920513.git.ar@linux.vnet.ibm.com>
 <20170411155843.GC32267@leverpostej>
Message-ID: <20170424164439.GA7477@tpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thank you for having a look on the code and providing comments. Same to others
that replied to the whole patchset. To the large extent, first purpose of this code
was to just to implement the functionality and I am totally aware that it may
be suboptimal at some places and therefore your feedback is very much
appreciated.

More answers below.

On Tue, Apr 11, 2017 at 04:58:43PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Tue, Apr 11, 2017 at 03:55:22PM +0100, Andrea Reale wrote:
> > From: Maciej Bielski <m.bielski@virtualopensystems.com>
> > 
> > This is a second and improved version of the patch previously released
> > in [3].
> > 
> > It builds on the work by Scott Branden [2] and, henceforth,
> > it needs to be applied on top of Scott's patches [2].
> > Comments are very welcome.
> > 
> > Changes from the original patchset and known issues:
> > 
> > - Compared to Scott's original patchset, this work adds the mapping of
> >   the new hotplugged pages into the kernel page tables. This is done by
> >   copying the old swapper_pg_dir over a new page, adding the new mappings,
> >   and then switching to the newly built pg_dir (see `hotplug_paging` in
> >   arch/arm64/mmu.c). There might be better ways to to this: suggestions
> >   are more than welcome.
> 
> For this reply, I'm just going to focus on the PGD replacement.
> 
> It's not clear to me if we need to swap the PGD, since everything we do
> here is strictly additive and non-conflicting, and it should be safe to
> add things to the swapper_pg_dir live.
> 
> However, assuming there's something I've missed, I have some comments
> below.
> 
> [...]

For one CPU it should work, I have quickly checked on QEMU. More concerns
regarding multiple CPUs below(*).

> 
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +
> > +/*
> > + * hotplug_paging() is used by memory hotplug to build new page tables
> > + * for hot added memory.
> > + */
> > +void hotplug_paging(phys_addr_t start, phys_addr_t size)
> > +{
> > +
> > +	struct page *pg;
> > +	phys_addr_t pgd_phys = pgd_pgtable_alloc();
> > +	pgd_t *pgd = pgd_set_fixmap(pgd_phys);
> > +
> > +	memcpy(pgd, swapper_pg_dir, PAGE_SIZE);
> 
> s/PAGE_SIZE/PGD_SIZE/ (and below, too).
> 
> See commit 12f043ff2b28fa64 ("arm64: fix warning about swapper_pg_dir
> overflow").
> 

Noted, thanks.

> > +
> > +	__create_pgd_mapping(pgd, start, __phys_to_virt(start), size,
> > +		PAGE_KERNEL, pgd_pgtable_alloc, false);
> > +
> > +	cpu_replace_ttbr1(__va(pgd_phys));
> 
> Other CPUs may be online at this point, and cpu_replace_ttbr1() was only
> intended for UP operation. Other CPUs will still have swapper_pg_dir in
> their TTBR1_EL1 at this point in time...
> 
> > +	memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
> 
> ... which this will alter, in an unsafe fashion.
> 
> The other CPUs are live, and might be altering swapper. e.g. one might
> be using the fixmap to alter code. We will need some stop_machine()-like
> machinery here to synchronise with other CPUs, ensuring that they don't
> have swapper_pg_dir live.

(*)
I am familiar with stop_machine(), for example it is done at later stage, when
pages are onlined (inside build_all_zonelists). But do you think that we should
check if swapper_pg_dir is under modification before stopping (and optionally
wait until this modification is finished)? Is there a mechanism to serialize
the write access to swapper_pg_dir?

> 
> Unfortunately, we can't change other to the temporary pgdir in a cross
> call, then fix things up, then do another cross call. If any exception
> is taken when we're in the temporary pgdir, __uaccess_ttbr0_disable will
> install junk into TTBR0, and we risk the usual set of pain junk TLBs
> entail.
> 
> We appear to have a latent bug at boot time along those lines, when
> setting up the page tables and initialising KASAN. I'll see about
> cleaning that up.

Great, thank you for any hints.

> 
> Thanks,
> Mark.

Best regards,

-- 
Maciej Bielski
