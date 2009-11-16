From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2009 10:58:54 +0000
Subject: [RFC 10/11] ARM: arrange for flush_cache_range() to always
	flush the I-cache
In-Reply-To: <1258368415.6705.20.camel@pc1117.cambridge.arm.com>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<12475bd20f82c3a5e78d5b8e9d3cb266914c4727.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<1256745098.27121.48.camel@pc1117.cambridge.arm.com>
	<20091028173709.GC20040@n2100.arm.linux.org.uk>
	<1256838661.6874.67.camel@pc1117.cambridge.arm.com>
	<1258368415.6705.20.camel@pc1117.cambridge.arm.com>
Message-ID: <20091116105854.GB27894@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 10:46:55AM +0000, Catalin Marinas wrote:
> > diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> > index 4127a7b..f19ed4e 100644
> > --- a/arch/arm/mm/copypage-v6.c
> > +++ b/arch/arm/mm/copypage-v6.c
> > @@ -41,6 +41,7 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
> >  	kfrom = kmap_atomic(from, KM_USER0);
> >  	kto = kmap_atomic(to, KM_USER1);
> >  	copy_page(kto, kfrom);
> > +	__cpuc_flush_dcache_page(kto);
> >  	kunmap_atomic(kto, KM_USER1);
> >  	kunmap_atomic(kfrom, KM_USER0);
> >  }
> 
> Any thoughts one getting this merged (maybe in 2.6.33)? It seems that
> no-one else has any views on this but the COW text pages problem is
> still present.

Well, it would be useful to get some comment from Nicolas since
kunmap_atomic() will call this function for highmem pages.  We might want
to avoid doing the dcache flush thing multiple times for these, but it
looks to me like testing PageHighMem(to) leaves us a hole.

Maybe we need something like kunmap_atomic_flush() ?
