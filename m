From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 6 Oct 2016 11:16:18 +0200
Subject: arm64: kernel BUG at mm/page_alloc.c:1844!
In-Reply-To: <20161005141313.GF22012@rric.localdomain>
References: <20161005141313.GF22012@rric.localdomain>
Message-ID: <20161006091618.GG22012@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.10.16 16:13:13, Robert Richter wrote:
> I tried various changes to fix that, but without success so far:
> 
> a) I modified reserve_regions() to use memblock_reserve() instead of
> memblock_mark_nomap(). This marked efi regions as reserved instead of
> unmap. pfn_valid() now worked as before the nomap change. I could boot
> the system but noticed the following malloc assertion which looks like
> there is some mem corruption:
> 
>   emacs: malloc.c:2395: sysmalloc: Assertion `(old_top == initial_top (av) && old_size == 0) || ((unsigned long) (old_size) >= MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
> 
> Other than that the system looked ok so far.
> 
> I checked pfn used by the process with kmem:mm_page_alloc_zone_locked,
> it looked correct with all pfn allocated from free memory, mem ranges
> reported by efi as reserved were not used.

I have updated the packages in my system and the problem went
away. Also I have run memtest for memory ranges close to efi
boundaries without any issues. So I assume this problem was userland
specific and unrelated to the original bug.

> 
> b) I found a quote that for sparsemem the entire memmap (all pages have a
> struct *page) for single section (include/linux/mmzone.h):
> 
>  "In SPARSEMEM, it is assumed that a valid section has a memmap for
>  the entire section."
> 
> So I implemented a arm64 private __early_pfn_valid() function that
> uses memblock_is_memory() to setup all pages of a zone. I got the same
> result as for a).
> 
> c) I modified (almost) all arch arm64 users of pfn_valid() to use
> memblock_mark_nomap() instead of pfn_valid() and changed pfn_valid()
> to use memblock_is_memory(). Same problem as a).

I am going to prepare a patch that implements c).

-Robert

> 
> d) Enabling HOLES_IN_ZONE config option does not looks correct for
> sparsemem, trying it anyway causes VM_BUG_ON_PAGE() in in line 1849
> since (uninitialized) struct *page is accessed. This did not work
> either.
