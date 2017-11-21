From: steve.capper@arm.com (Steve Capper)
Date: Tue, 21 Nov 2017 13:14:48 +0000
Subject: [PATCH 2/2] arm64: Extend early page table code to allow for
 larger kernels
In-Reply-To: <20171121111306.qbvth7pv4fcntbui@capper-debian.cambridge.arm.com>
References: <20171117114143.26577-1-steve.capper@arm.com>
 <20171117114143.26577-3-steve.capper@arm.com>
 <20171120170009.jgg6zokg5idorvpc@lakrids.cambridge.arm.com>
 <20171121111306.qbvth7pv4fcntbui@capper-debian.cambridge.arm.com>
Message-ID: <20171121131448.gokl6p2upszrgayn@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 11:13:06AM +0000, Steve Capper wrote:
> On Mon, Nov 20, 2017 at 05:00:10PM +0000, Mark Rutland wrote:
> > Hi,
> 
> Hi Mark,
> 
> > 
> > On Fri, Nov 17, 2017 at 11:41:43AM +0000, Steve Capper wrote:
> > > -#define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
> > > +#define EARLY_PGDS(vstart, vend) ((vend >> PGDIR_SHIFT) - (vstart >> PGDIR_SHIFT) + 1)
> > > +
> > > +#if SWAPPER_PGTABLE_LEVELS > 3
> > > +#define EARLY_PUDS(vstart, vend) ((vend >> PUD_SHIFT) - (vstart >> PUD_SHIFT) + 1)
> > > +#else
> > > +#define EARLY_PUDS(vstart, vend) (0)
> > > +#endif
> > > +
> > > +#if SWAPPER_PGTABLE_LEVELS > 2
> > > +#define EARLY_PMDS(vstart, vend) ((vend >> PMD_SHIFT) - (vstart >> PMD_SHIFT) + 1)
> > > +#else
> > > +#define EARLY_PMDS(vstart, vend) (0)
> > > +#endif
> > > +
> > > +#define EARLY_PAGES(vstart, vend) ( 1 			/* PGDIR page */				\
> > > +			+ EARLY_PGDS((vstart), (vend)) 	/* each PGDIR needs a next level page table */	\
> > > +			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
> > > +			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
> > > +#define SWAPPER_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR + TEXT_OFFSET, _end + SZ_2M))
> > >  #define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
> > 
> > I'm currently struggling to convince myself as to whether 2M is
> > necessary/sufficient slack space for all configurations.
> 
> Agreed, if the possible address range is changed outside these bounds
> then we need to extend them.
> 
> > 
> > At least w.r.t. Ard's comment, we'd need a bit more slack to allow KASLR
> > to cross PGD/PUD/PMD boundaries.
> > 
> > For example with 3 levels of 64K pages, and a huge kernel that takes up
> > SZ_512M - SZ_2M - TEXT_OFFSET. That perfectly fits into 1 PGDIR, 1 PGD,
> > and 1 PMD. IIUC, the above would allocate us 3 pages for this case. If
> > the kernel were to be relocated such that it straddled two PGDs, we'd
> > need 2 PGDs and 2 PMDs, needing 5 pages total.
> > 
> > I'm not sure that we have a problem if we don't relax KASLR.
> > 
> 
> The approach I've adopted is to compute which indices are required for
> PGDs, PUDs, PMDs to map the supplied address range, then count them.
> If we require two PGD entries then that means we need two pages
> containing PMD entries to be allocated.
> 
> If we consider just PGDs, for example, the only way I am aware of the
> kernel straddling more PGDs than previously computed is for the mapping
> to begin before vstart or end after vend (or both).
> 
> Should I refine the range specified in the SWAPPER_DIR_SIZE for the
> current KASLR? (I thought the random offset was < SZ_2M?)
> 

Ahh, I see KASLR offset has the bottom 21 bits masked out, not confined
to the 21 bottom bits :-).

It may be possible to do something with (vend - vstart) I will have a
think about this.

Cheers,
-- 
Steve
