From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 31 Mar 2014 08:56:53 +0200
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
Message-ID: <76240593.SAyloCy7nR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 March 2014 12:51:07 Jungseok Lee wrote:
> Current ARM64 kernel cannot support 4KB pages for 40-bit physical address
> space described in [1] due to one major issue + one minor issue.
> 
> Firstly, kernel logical memory map (0xffffffc000000000-0xffffffffffffffff)
> cannot cover DRAM region from 544GB to 1024GB in [1]. Specifically, ARM64
> kernel fails to create mapping for this region in map_mem function
> (arch/arm64/mm/mmu.c) since __phys_to_virt for this region reaches to
> address overflow. I've used 3.14-rc8+Fast Models to validate the statement.

It took me a while to understand what is going on, but it essentially comes
down to the logical memory map (0xffffffc000000000-0xffffffffffffffff)
being able to represent only RAM in the first 256GB of address space.

More importantly, this means that any system following [1] will only be
able to use 32GB of RAM, which is a much more severe restriction than
what it sounds like at first.

> Secondly, vmemmap space is not enough to cover over about 585GB physical
> address space. Fortunately, this issue can be resolved as utilizing an extra
> vmemmap space (0xffffffbe00000000-0xffffffbffbbfffff) in [2]. However,
> it would not cover systems having a couple of terabytes DRAM.

This one can be trivially changed by taking more space out of the vmalloc
area, to go much higher if necessary. vmemmap space is always just a fraction
of the linear mapping size, so we can accommodate it by definition if we
find space to fit the physical memory.

> Therefore, it would be needed to implement 4 level page table translations
> for 4KB pages on 40-bit physical address space platforms. Someone might
> suggest use of 64KB pages in this case, but I'm not sure about how to
> deal with internal memory fragmentation.
> 
> I would like to contribute 4 level page table translations to upstream,
> the target of which is 3.16 kernel, if there is no movement on it. I saw
> some related RFC patches a couple of months ago, but they didn't seem to 
> be merged into maintainer's tree.

I think you are answering the wrong question here. Four level page tables
should not be required to support >32GB of RAM, that would be very silly.
There are good reasons to use a 50 bit virtual address space in user
land, e.g. for supporting data base applications that mmap huge files.

If this is not the goal however, we should not pay for the overhead
of the extra page table in user space. I can see two other possible
solutions for the problem:

a) always use a four-level page table in kernel space, regardless of
whether we do it in user space. We can move the kernel mappings down
in address space either by one 512GB entry to 0xffffff0000000000, or
to match the 64k-page location at 0xfffffc0000000000, or all the way
to to 0xfffc000000000000. In any case, we can have all the dynamic
mappings within one 512GB area and pretend we have a three-level
page table for them, while the rest of DRAM is mapped statically at
early boot time using 512GB large pages.

b) If there is a reasonable assumption that everybody is using the
memory map from [1], then we can change the __virt_to_phys
and __phys_to_virt functions to accomodate that and move everything
into a flat contiguous virtual address space of 256GB. This would
also enable the use of a more efficient mem_map array instead of the
vmemmap, but would break running on any system that doesn't follow
the same convention. I have no idea yet how common this memory map
is, so I can't tell if this would be a realistic solution for what
you are targeting. We clearly wouldn't do it if it implies distributions
to ship an extra kernel binary for systems based on different memory
maps.

	Arnd
 
> References
> ----------
> [1]: Principles of ARM Memory Maps, Whit Paper, Issue C
> 
> [2]: Documentation/arm64/memory.txt
> 
