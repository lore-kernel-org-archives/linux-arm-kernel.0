From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jul 2010 17:43:39 +0100
Subject: [PATCH 2/2] ARM: flush_ptrace_access: invalidate all I-caches
In-Reply-To: <20100715163216.GI29322@n2100.arm.linux.org.uk>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<1279209238-16234-2-git-send-email-will.deacon@arm.com>
	<1279209238-16234-3-git-send-email-will.deacon@arm.com>
	<20100715163216.GI29322@n2100.arm.linux.org.uk>
Message-ID: <002801cb243c$e0a70130$a1f50390$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > index c6844cb..45896a9 100644
> > --- a/arch/arm/mm/flush.c
> > +++ b/arch/arm/mm/flush.c
> > @@ -120,8 +120,8 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> >
> >  	/* VIPT non-aliasing cache */
> >  	if (vma->vm_flags & VM_EXEC) {
> > -		unsigned long addr = (unsigned long)kaddr;
> > -		__cpuc_coherent_kern_range(addr, addr + len);
> > +		__cpuc_flush_dcache_area(kaddr, len);
> > +		__flush_icache_all();
> 
> NAK.
>
> If we have aliases in the I-cache, there's probably more places that
> need to be fixed - and in any case I think the VIPT aliasing case
> should be used in that instance.
> 
> This code is for non-aliasing D and I caches, and works as follows.
> 
> 1. We flush the data out of the D cache, line by line, on at least the
>    local CPU (and optionally the other CPUs.)  Since we disable
>    preemption, we will own the cache lines.
> 
> 2. We invalidate the I cache, line by line, on at least local CPU
>    (and optionally the other CPUs.)

(1) and (2) are done in __cpuc_coherent_kern_range. The problem is
that the (2) part doesn't deal with aliases and only invalidates for
the given MVA.
 
> 3. If the I-cache invalidate wasn't broadcast, we flush the entire
>    I-cache on the other CPUs.

Yep.

> So, what CPUs report themselves as having VIPT non-aliasing caches but
> actually have an aliasing I-cache?

As far as I understand, all ARM cores have aliasing I-caches if it's a
VIPT cache with way size greater than the page size. The D-cache has
additional logic for handling aliasing which is what the VIPT non-aliasing
characteristics refer to.

Will
