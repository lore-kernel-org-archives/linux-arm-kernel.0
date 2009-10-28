From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Oct 2009 17:35:35 +0000
Subject: [RFC 09/11] ARM: Add I-cache invalidation for VIVT ASID tagged
	caches
In-Reply-To: <1256744941.27121.45.camel@pc1117.cambridge.arm.com>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<5dee6c2014c4724c1ff6923326e93084f337581a.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<1256744941.27121.45.camel@pc1117.cambridge.arm.com>
Message-ID: <20091028173535.GB20040@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 03:49:01PM +0000, Catalin Marinas wrote:
> On Sun, 2009-10-25 at 13:35 +0000, Russell King wrote:
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mm/flush.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > index dc66f86..9770e27 100644
> > --- a/arch/arm/mm/flush.c
> > +++ b/arch/arm/mm/flush.c
> > @@ -69,6 +69,9 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
> >  		    : "cc");
> >  		__flush_icache_all();
> >  	}
> > +
> > +	if (vma->vm_flags & VM_EXEC && icache_is_vivt_asid_tagged())
> > +		__flush_icache_all();
> >  }
> >  
> >  void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
> > @@ -82,6 +85,9 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
> >  		flush_pfn_alias(pfn, user_addr);
> >  		__flush_icache_all();
> >  	}
> > +
> > +	if (vma->vm_flags & VM_EXEC && icache_is_vivt_asid_tagged())
> > +		__flush_icache_all();
> >  }
> >  
> >  void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> 
> You may be right but why is this needed? Between mm's, we have the ASID.
> Within the same mm, do we expect to change the corresponding physical
> address of a virtual address without calling update_mmu_cache?

Stop thinking that update_mmu_cache() has something to do with cache
handling.  That is not its purpose.  update_mmu_cache() is there for
systems with software-TLBs to efficiently update the software-TLB for
the page fault which has happened.

flush_cache_page() on the other hand is called whenever we change a
page mapping - but it's not called when mm's change.

The ARM ARM specifies that when we change the page tables, and we
have a VIVT I-cache, it needs to be flushed.  The above is merely
complying with that statement.
