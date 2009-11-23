From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 20:28:56 +0000
Subject: [RFC 10/11] ARM: arrange for flush_cache_range() to always
	flush the I-cache
In-Reply-To: <alpine.LFD.2.00.0911221517340.2059@xanadu.home>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<12475bd20f82c3a5e78d5b8e9d3cb266914c4727.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<1256745098.27121.48.camel@pc1117.cambridge.arm.com>
	<20091028173709.GC20040@n2100.arm.linux.org.uk>
	<1256838661.6874.67.camel@pc1117.cambridge.arm.com>
	<1258368415.6705.20.camel@pc1117.cambridge.arm.com>
	<20091116105854.GB27894@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911221517340.2059@xanadu.home>
Message-ID: <20091123202856.GG18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2009 at 03:28:30PM -0500, Nicolas Pitre wrote:
> On Mon, 16 Nov 2009, Russell King - ARM Linux wrote:
> 
> > On Mon, Nov 16, 2009 at 10:46:55AM +0000, Catalin Marinas wrote:
> > > > diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> > > > index 4127a7b..f19ed4e 100644
> > > > --- a/arch/arm/mm/copypage-v6.c
> > > > +++ b/arch/arm/mm/copypage-v6.c
> > > > @@ -41,6 +41,7 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
> > > >  	kfrom = kmap_atomic(from, KM_USER0);
> > > >  	kto = kmap_atomic(to, KM_USER1);
> > > >  	copy_page(kto, kfrom);
> > > > +	__cpuc_flush_dcache_page(kto);
> > > >  	kunmap_atomic(kto, KM_USER1);
> > > >  	kunmap_atomic(kfrom, KM_USER0);
> > > >  }
> > > 
> > > Any thoughts one getting this merged (maybe in 2.6.33)? It seems that
> > > no-one else has any views on this but the COW text pages problem is
> > > still present.
> > 
> > Well, it would be useful to get some comment from Nicolas since
> > kunmap_atomic() will call this function for highmem pages.  We might want
> > to avoid doing the dcache flush thing multiple times for these, but it
> > looks to me like testing PageHighMem(to) leaves us a hole.
> 
> Better test page_address(to) and skip the flush if it is NULL.  That's 
> what we do elsewhere already.  If page_addressto) is NULL then there is 
> no long lasting mapping for that page and the cache will be flushed upon 
> kunmap_atomic().  Hence:
> 
> #ifdef CONFIG_HIGHMEM
> 	/*
> 	 * kmap_atomic() doesn't set the page virtual address, and
> 	 * kunmap_atomic() takes care of cache flushing already.
> 	 */
> 	if (page_address(to) != NULL)
> #endif
> 		__cpuc_flush_dcache_page(kto);

Okay, can we get this combined with Catalin's patch and applied to all
applicable processors (which I assume would be just v6 and v7) ?

Catalin?
