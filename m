From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 28 Oct 2016 11:19:05 +0200
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <20161027160136.GD24290@arm.com>
References: <1475747527-32387-1-git-send-email-rrichter@cavium.com>
 <CAKv+Gu-oYzSn_eeqaX3QVFeQjBGkaX-Wh7+oPcQFcXv7J6GOFQ@mail.gmail.com>
 <20161006161114.GH22012@rric.localdomain>
 <20161017185801.GT25086@rric.localdomain>
 <20161027160136.GD24290@arm.com>
Message-ID: <20161028091905.GM22012@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.10.16 17:01:36, Will Deacon wrote:
> Hi Robert,
> 
> On Mon, Oct 17, 2016 at 08:58:01PM +0200, Robert Richter wrote:
> > Mark, Will, any opinion here?
> 
> Having looking at this, I'm inclined to agree with you; pfn_valid() is
> all about whether the underlying mem_map (struct page *) entry exists,
> not about whether the page is mappable or not.
> 
> That said, setting the zone for pages representing NOMAP memory feels
> like a slippery slope to losing information about them being NOMAP in
> the first place and the whole problem getting out-of-hand. Whilst I'm
> happy for pfn_valid() to return true (in the sense that we're within
> bounds of mem_map etc), I'm less happy that we're also saying that the
> struct page contains useful information, such as the zone and the node
> information, which is then subsequently used by the NUMA code.

Let's see it in a different way, pfns and the struct page assigned to
each of it is about *physical* memory. The system knows all the
memory, some is free, some reserved and some marked NOMAP. Regardless
of the mapping of the page the mm code maintains and uses that
information.

There are assumptions on validity and checks in the code that now
cause problems due to partly or non-existing data about nomap pages.
This inconsistency is dangerous since a problem may occur any time
then the page area is accessed first, thus a system may crash randomly
depending on the memory access. Luckily, in my case it triggered
reproducible while loading initrd during boot.

I also think that this is not only NUMA related. E.g. the following
bug report is probably also related:

 https://bugzilla.redhat.com/show_bug.cgi?id=1387793

> On top of that, pfn_valid is used in other places as a coarse "is this
> memory?" check, and will cause things like ioremap to fail whereas it
> wouldn't at the moment.

IMO this is a misuse of pfn_valid() that needs to be fixed with
additional checks, e.g. traversing memblocks.

> It feels to me like NOMAP memory is a new type
> of memory where there *is* a struct page, but it shouldn't be used for
> anything.

IMO, a NOMAP page should just be handled like a reserved page except
that the page is marked reserved. See free_low_memory_core_early().
Thus, NOMAP pages are not in the free pages list or set to reserved.
It is simply not available for mapping at all. Isn't that exactly what
it should be?

I also did not yet understand the benefit of the differentiation
between NOMAP and reserved and the original motivation for its
implementation. I looked through the mail threads but could not find
any hint. The only difference I see now is that it is not listed as a
reserved page, but as long as it is not freed it should behave the
same. I remember the case to handle memory different (coherency,
etc.), but are not sure here. Ard, could you explain this?

> I don't think pfn_valid can describe that, given the way it's
> currently used, and flipping the logic is just likely to move the problem
> elsewhere.
> 
> What options do we have for fixing this in the NUMA code?

Out of my mind:

1) Treat NOMAP pages same as reserved pages (my patch).

2) Change mm code to allow arch specific early_pfn_valid().

3) Fix mm code to only access stuct page (of a zone) if pfn_valid() is
   true.

There can be more alternatives. IMO:

 * We shouldn't touch generic mm code.

 * We should maintain a valid struct page for all pages in a sections.

 * We should only traverse memblock where really necessary (arm64
   only).

 * I don't think this problem is numa specific.

-Robert
