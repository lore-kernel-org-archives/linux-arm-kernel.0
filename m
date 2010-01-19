From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 18:04:24 +0000
Subject: [RFC 06/18] arm: msm: implement proper dmb() for 7x27
In-Reply-To: <20100119172835.GC1323@shareable.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
	<20100111233924.GL7925@n2100.arm.linux.org.uk>
	<1263253516.26505.42.camel@c-dwalke-linux.qualcomm.com>
	<20100112000142.GO7925@n2100.arm.linux.org.uk>
	<20100119172835.GC1323@shareable.org>
Message-ID: <20100119180424.GC1886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 05:28:35PM +0000, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > > 	zero_page_strongly_ordered =
> > > 		ioremap_strongly_ordered(page_to_pfn(empty_zero_page)
> > > 		<< PAGE_SHIFT, PAGE_SIZE);
> > 
> > This can't work.  You're not allowed to map the same memory with differing
> > memory types from ARMv7.  This ends up mapping 'empty_zero_page' as both
> > cacheable memory and strongly ordered.  That's illegal according to the
> > ARM ARM.
> 
> It's not an ARMv7, otherwise it wouldn't be using the mcr version of
> dmb().  Does that make the mapping ok, since it's been ok for years on
> < ARMv7?  Or are we trying to get away from doing that on all ARMs?

Technically, it also applies to ARMv6 as well.

> Actually it is only used on two very specific CPUs.  Perhaps it can be
> confirmed as Not A Problem(tm) on those, with a comment to say why
> it's ok in the mapping call?

The fact of the matter is that cache lines will be allocated for
empty_zero_page.  If this CPU is ARMv6 or ARMv7, with either an aliasing
or non-aliasing VIPT cache, you will get cache lines allocated for this
page which will overlap the strongly ordered mapping.

That in turn can turn the strongly ordered mapping into a cached mapping
which is definitely not what you want.

If your CPU speculatively prefetches, and it prefetches some data via a
cached mapping, the same thing can happen.

> > You need to find something else to map - allocating a page of system
> > memory for this won't work either (it'll have the same issue.)
> 
> Is strongly ordered RAM or even uncached RAM used at all for anything
> at the moment?  It looks quite tricky to allocate a little RAM that
> never becomes part of the kernel direct mapping.

'Memory, uncached' is used for DMA mappings on ARMv7 and soon to be on
ARMv6 as well to comply with the architecture requirements.  Strongly
ordered is used for a certain set of IOP3xx registers because that is
what is stipulated in the device documentation.

What is expressly not permitted for ARMv7 (and ARMv6) is having two or
more mappings of the same physical address with differing memory types
or sharability settings.

(Technically, that extends to cacheability modes as well - but if ARM Ltd
think that the kernel's going to comply with that, I think they're in
cloud cuckoo land.  Well, we could do _if_ (eg) ARM Ltd bring in hardware
DMA coherency as a mandatory architecture requirement.)
