From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 May 2013 22:13:47 +0100
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130508193130.GA31678@schnuecks.de>
References: <20130430210403.GA18076@schnuecks.de>
 <20130501142206.GB17387@arm.com>
 <20130501190441.GA22227@schnuecks.de>
 <20130502095431.GA20730@arm.com>
 <20130502193835.GA29144@schnuecks.de>
 <20130503100242.GB29962@arm.com>
 <CACVXFVPOuabwAa1VDmSnfDG=M-1Df02_kpbm0UVAVctCAB-U4Q@mail.gmail.com>
 <20130508150800.GI2703@arm.com>
 <20130508184354.GQ18614@n2100.arm.linux.org.uk>
 <20130508193130.GA31678@schnuecks.de>
Message-ID: <20130508211346.GA54480@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 08:31:30PM +0100, Simon Baatz wrote:
> On Wed, May 08, 2013 at 07:43:54PM +0100, Russell King - ARM Linux wrote:
> > On Wed, May 08, 2013 at 04:08:00PM +0100, Catalin Marinas wrote:
> > > On Sat, May 04, 2013 at 09:21:27AM +0100, Ming Lei wrote:
> > > > On Fri, May 3, 2013 at 6:02 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > >>
> > > > >> I assume that you inhibited the call to flush_dcache_page() in
> > > > >> __get_user_pages() for anon pages.  Otherwise, you will be flooded
> > > > >> with warnings.
> > > > >
> > > > > I haven't done any stress testing so I don't think I hit this code path,
> > > > > so no warning. But yes, it should have triggered. Anyway, in this case
> > > > > flush_dcache_page() should have just ignored (clearing PG_arch_1 is
> > > > > harmless anyway if we also ignore this bit in __sync_icache_dcache for
> > > > > non-aliasing caches).
> > > > 
> > > > Yes, maybe we can do a little optimization for O_DIRECT since no
> > > > dcache alias and I/D coherency problem in this case on ARMv7, how
> > > > about below change?
> > > > 
> > > > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > > > index 1c8f7f5..962a657 100644
> > > > --- a/arch/arm/mm/flush.c
> > > > +++ b/arch/arm/mm/flush.c
> > > > @@ -287,6 +287,8 @@ void flush_dcache_page(struct page *page)
> > > >  	    mapping && !mapping_mapped(mapping))
> > > >  		clear_bit(PG_dcache_clean, &page->flags);
> > > >  	else {
> > > > +		if (!mapping && cache_is_vipt_nonaliasing())
> > > > +			return;
> > > >  		__flush_dcache_page(mapping, page);
> > > >  		if (mapping && cache_is_vivt())
> > > >  			__flush_dcache_aliases(mapping, page);
> > > 
> > > I wonder whether we could move the:
> > > 
> > > 	if (!mapping)
> > > 		return
> > > 
> > > at the top of this function, IOW don't touch any anonymous pages. Would
> > > anything be broken (apart from wrong API use)?
> > 
> > I suspect you may be missing something - and I suggest reading the Sparc
> > version, which is where this PG_arch_1 stuff was first dreamed up (by
> > DaveM).
> > 
> > Are you positive that this path can be eliminated?  Totally sure?  Have
> > you checked the arg/env pages that fs/exec.c and the binfmt's insert into
> > the new process?
> > 
> > The comments against the Sparc version suggest that the "else" clause
> > is necessary ensure that case is adequately covered.
> 
> At least the fs/exec.c and the binfmt stuff use
> flush_kernel_dcache_page() for 5 years or so now (see commit b6a2fe). 
> Which makes sense, since flush_dcache_page() is not supposed to
> handle anon pages anyway.

Indeed, the sparc comment on arg pages no longer applies. It was also
more of an optimisation which I'm not convinced it would have saved
anything on ARM.

-- 
Catalin
