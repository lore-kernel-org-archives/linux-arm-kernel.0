From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Nov 2016 21:05:14 +0000
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <20161028091905.GM22012@rric.localdomain>
References: <1475747527-32387-1-git-send-email-rrichter@cavium.com>
 <CAKv+Gu-oYzSn_eeqaX3QVFeQjBGkaX-Wh7+oPcQFcXv7J6GOFQ@mail.gmail.com>
 <20161006161114.GH22012@rric.localdomain>
 <20161017185801.GT25086@rric.localdomain>
 <20161027160136.GD24290@arm.com>
 <20161028091905.GM22012@rric.localdomain>
Message-ID: <20161107210514.GP20591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 11:19:05AM +0200, Robert Richter wrote:
> On 27.10.16 17:01:36, Will Deacon wrote:
> > It feels to me like NOMAP memory is a new type
> > of memory where there *is* a struct page, but it shouldn't be used for
> > anything.
> 
> IMO, a NOMAP page should just be handled like a reserved page except
> that the page is marked reserved. See free_low_memory_core_early().
> Thus, NOMAP pages are not in the free pages list or set to reserved.
> It is simply not available for mapping at all. Isn't that exactly what
> it should be?
> 
> I also did not yet understand the benefit of the differentiation
> between NOMAP and reserved and the original motivation for its
> implementation. I looked through the mail threads but could not find
> any hint. The only difference I see now is that it is not listed as a
> reserved page, but as long as it is not freed it should behave the
> same. I remember the case to handle memory different (coherency,
> etc.), but are not sure here. Ard, could you explain this?
> 
> > I don't think pfn_valid can describe that, given the way it's
> > currently used, and flipping the logic is just likely to move the problem
> > elsewhere.
> > 
> > What options do we have for fixing this in the NUMA code?
> 
> Out of my mind:
> 
> 1) Treat NOMAP pages same as reserved pages (my patch).

Just to reiterate here, but your patch as it stands will break other parts
of the kernel. For example, acpi_os_ioremap relies on being able to ioremap
these regions afaict.

I think any solution involving pfn_valid is just going to move the crash
around.

Will
