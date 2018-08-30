From: mpatocka@redhat.com (Mikulas Patocka)
Date: Thu, 30 Aug 2018 11:58:19 -0400 (EDT)
Subject: A crash on ARM64 in move_freepages_block due to uninitialized
 pages in reserved memory
In-Reply-To: <541193a6-2bce-f042-5bb2-88913d5f1047@arm.com>
References: <alpine.LRH.2.02.1808171527220.2385@file01.intranet.prod.int.rdu2.redhat.com>
 <20180821104418.GA16611@dhcp22.suse.cz>
 <e35b7c14-c7ea-412d-2763-c961b74576f3@arm.com>
 <alpine.LRH.2.02.1808220808050.17906@file01.intranet.prod.int.rdu2.redhat.com>
 <c823eace-8710-9bf5-6e76-d01b139c0859@arm.com>
 <20180824114158.GJ29735@dhcp22.suse.cz>
 <541193a6-2bce-f042-5bb2-88913d5f1047@arm.com>
Message-ID: <alpine.LRH.2.02.1808301148260.18300@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 29 Aug 2018, James Morse wrote:

> Hi Michal,
> 
> (CC: +Ard)
> 
> On 24/08/18 12:41, Michal Hocko wrote:
> > On Thu 23-08-18 15:06:08, James Morse wrote:
> > [...]
> >> My best-guess is that pfn_valid_within() shouldn't be optimised out if
> > ARCH_HAS_HOLES_MEMORYMODEL, even if HOLES_IN_ZONE isn't set.
> >>
> >> Does something like this solve the problem?:
> >> ============================%<============================
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index 32699b2dc52a..5e27095a15f4 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -1295,7 +1295,7 @@ void memory_present(int nid, unsigned long start, unsigned
> >> long end);
> >>   * pfn_valid_within() should be used in this case; we optimise this away
> >>   * when we have no holes within a MAX_ORDER_NR_PAGES block.
> >>   */
> >> -#ifdef CONFIG_HOLES_IN_ZONE
> >> +#if defined(CONFIG_HOLES_IN_ZONE) || defined(CONFIG_ARCH_HAS_HOLES_MEMORYMODEL)
> >>  #define pfn_valid_within(pfn) pfn_valid(pfn)
> >>  #else
> >>  #define pfn_valid_within(pfn) (1)
> >> ============================%<============================
> 
> After plenty of greping, git-archaeology and help from others, I think I've a
> clearer picture of what these options do.
> 
> 
> Please correct me if I've explained something wrong here:
> 
> > This is the first time I hear about CONFIG_ARCH_HAS_HOLES_MEMORYMODEL.
> 
> The comment in include/linux/mmzone.h describes this as relevant when parts the
> memmap have been free()d. This would happen on systems where memory is smaller
> than a sparsemem-section, and the extra struct pages are expensive.
> pfn_valid() on these systems returns true for the whole sparsemem-section, so an
> extra memmap_valid_within() check is needed.
> 
> This is independent of nomap, and isn't relevant on arm64 as our pfn_valid()
> always tests the page in memblock due to nomap pages, which can occur anywhere.
> (I will propose a patch removing ARCH_HAS_HOLES_MEMORYMODEL for arm64.)
> 
> 
> HOLES_IN_ZONE is similar, if some memory is smaller than MAX_ORDER_NR_PAGES,
> possibly due to nomap holes.
> 
> 6d526ee26ccd only enabled it for NUMA systems on arm64, because the NUMA code
> was first to fall foul of this, but there is nothing NUMA specific about nomap
> holes within a MAX_ORDER_NR_PAGES region.
> 
> I'm convinced arm64 should always enable HOLES_IN_ZONE because nomap pages can
> occur anywhere. I'll post a fix.

But x86 had the same bug -
https://bugzilla.redhat.com/show_bug.cgi?id=1598462

And x86 fixed it without enabling HOLES_IN_ZONE. On x86, the BIOS can also 
reserve any memory range - so you can have arbitrary holes there that are 
not predictable when the kernel is compiled.

Currently HOLES_IN_ZONE is selected only for ia64, mips/octeon - so does 
it mean that all the other architectures don't have holes in the memory 
map?

What should be architecture-independent way how to handle the holes?

Mikulas
