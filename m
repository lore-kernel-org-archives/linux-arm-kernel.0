From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 19 Jan 2010 17:28:35 +0000
Subject: [RFC 06/18] arm: msm: implement proper dmb() for 7x27
In-Reply-To: <20100112000142.GO7925@n2100.arm.linux.org.uk>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
	<20100111233924.GL7925@n2100.arm.linux.org.uk>
	<1263253516.26505.42.camel@c-dwalke-linux.qualcomm.com>
	<20100112000142.GO7925@n2100.arm.linux.org.uk>
Message-ID: <20100119172835.GC1323@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> > 	zero_page_strongly_ordered =
> > 		ioremap_strongly_ordered(page_to_pfn(empty_zero_page)
> > 		<< PAGE_SHIFT, PAGE_SIZE);
> 
> This can't work.  You're not allowed to map the same memory with differing
> memory types from ARMv7.  This ends up mapping 'empty_zero_page' as both
> cacheable memory and strongly ordered.  That's illegal according to the
> ARM ARM.

It's not an ARMv7, otherwise it wouldn't be using the mcr version of
dmb().  Does that make the mapping ok, since it's been ok for years on
< ARMv7?  Or are we trying to get away from doing that on all ARMs?

Actually it is only used on two very specific CPUs.  Perhaps it can be
confirmed as Not A Problem(tm) on those, with a comment to say why
it's ok in the mapping call?

> You need to find something else to map - allocating a page of system
> memory for this won't work either (it'll have the same issue.)

Is strongly ordered RAM or even uncached RAM used at all for anything
at the moment?  It looks quite tricky to allocate a little RAM that
never becomes part of the kernel direct mapping.

> > [alloc_bootmem_aligned]
>
> Erm, there is __alloc_bootmem(size, align, 0) - the bootmem allocator
> already does alignment.

I agree.
Best use the provided API.

If there _was_ a need for a new function, then the right place for it
would have been a patch to mm/bootmem.c, where everyone can see what
it does and avoid breaking it if they change how bootmem works.

-- Jamie
