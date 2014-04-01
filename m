From: jays.lee@samsung.com (Jungseok Lee)
Date: Tue, 01 Apr 2014 09:42:44 +0900
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <20140331113113.GE29871@arm.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <76240593.SAyloCy7nR@wuerfel> <20140331113113.GE29871@arm.com>
Message-ID: <010d01cf4d43$4b9f6a80$e2de3f80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 31, 2014 8:31 PM, Catalin Marinas wrote:
> On Mon, Mar 31, 2014 at 07:56:53AM +0100, Arnd Bergmann wrote:
> > On Monday 31 March 2014 12:51:07 Jungseok Lee wrote:
> > > Current ARM64 kernel cannot support 4KB pages for 40-bit physical address
> > > space described in [1] due to one major issue + one minor issue.
> > >
> > > Firstly, kernel logical memory map (0xffffffc000000000-0xffffffffffffffff)
> > > cannot cover DRAM region from 544GB to 1024GB in [1]. Specifically, ARM64
> > > kernel fails to create mapping for this region in map_mem function
> > > (arch/arm64/mm/mmu.c) since __phys_to_virt for this region reaches to
> > > address overflow. I've used 3.14-rc8+Fast Models to validate the statement.
> >
> > It took me a while to understand what is going on, but it essentially comes
> > down to the logical memory map (0xffffffc000000000-0xffffffffffffffff)
> > being able to represent only RAM in the first 256GB of address space.
> >
> > More importantly, this means that any system following [1] will only be
> > able to use 32GB of RAM, which is a much more severe restriction than
> > what it sounds like at first.
> 
> On a 64-bit platform, do we still need the alias at the bottom and the
> 512-544GB hole (even for 32-bit DMA, top address bits can be wired to
> 512GB)? Only the idmap would need 4 levels, but that's static, we don't
> need to switch Linux to 4-levels. Otherwise the memory is too sparse.
> 
> Of course, if you have 512GB of RAM and you want 4K pages, 3 levels are
> no longer enough (with 64K pages you get to 42-bit VA space).
> 
> > > Secondly, vmemmap space is not enough to cover over about 585GB physical
> > > address space. Fortunately, this issue can be resolved as utilizing an extra
> > > vmemmap space (0xffffffbe00000000-0xffffffbffbbfffff) in [2]. However,
> > > it would not cover systems having a couple of terabytes DRAM.
> >
> > This one can be trivially changed by taking more space out of the vmalloc
> > area, to go much higher if necessary. vmemmap space is always just a fraction
> > of the linear mapping size, so we can accommodate it by definition if we
> > find space to fit the physical memory.
> 
> vmemmap is the total range / page size * sizeof(struct page). So for 1TB
> range and 4K pages we would need 8GB (the current value, unless I
> miscalculated the above). Anyway, you can't cover 1TB range with
> 3-levels.
> 
> > > Therefore, it would be needed to implement 4 level page table translations
> > > for 4KB pages on 40-bit physical address space platforms. Someone might
> > > suggest use of 64KB pages in this case, but I'm not sure about how to
> > > deal with internal memory fragmentation.
> > >
> > > I would like to contribute 4 level page table translations to upstream,
> > > the target of which is 3.16 kernel, if there is no movement on it. I saw
> > > some related RFC patches a couple of months ago, but they didn't seem to
> > > be merged into maintainer's tree.
> >
> > I think you are answering the wrong question here. Four level page tables
> > should not be required to support >32GB of RAM, that would be very silly.
> 
> I agree, we should only enable 4-levels of page table if we have close
> to 512GB of RAM or the range is too sparse but I would actually push
> back on the hardware guys to keep it tighter.

This is my point. If SoC design follows the document, [1], over 32GB RAM
region should be placed from 544GB. Under this severe restriction,
even 64GB system is supposed to use the region from 544GB to 576GB for
only 32GB. As you said, memory map is too sparse. Naturally, it would reach
to enable 4-levels page tables unless __virt_to_phys and pyhs_to_virt
functions are hacked.

I agree that we should enable 4-levels page table when one of the above
conditions are met.

> > There are good reasons to use a 50 bit virtual address space in user
> > land, e.g. for supporting data base applications that mmap huge files.
> >
> > If this is not the goal however, we should not pay for the overhead
> > of the extra page table in user space. I can see two other possible
> > solutions for the problem:
> >
> > a) always use a four-level page table in kernel space, regardless of
> > whether we do it in user space. We can move the kernel mappings down
> > in address space either by one 512GB entry to 0xffffff0000000000, or
> > to match the 64k-page location at 0xfffffc0000000000, or all the way
> > to to 0xfffc000000000000. In any case, we can have all the dynamic
> > mappings within one 512GB area and pretend we have a three-level
> > page table for them, while the rest of DRAM is mapped statically at
> > early boot time using 512GB large pages.
> 
> That's a workaround but we end up with two (or more) kernel pgds - one
> for vmalloc, ioremap etc. and another (static) one for the kernel linear
> mapping. So far there isn't any memory mapping carved out but we have to
> be careful in the future.
>
> However, kernel page table walking would be a bit slower with 4-levels.
> 
> > b) If there is a reasonable assumption that everybody is using the
> > memory map from [1], then we can change the __virt_to_phys
> > and __phys_to_virt functions to accomodate that and move everything
> > into a flat contiguous virtual address space of 256GB. This would
> > also enable the use of a more efficient mem_map array instead of the
> > vmemmap, but would break running on any system that doesn't follow
> > the same convention. I have no idea yet how common this memory map
> > is, so I can't tell if this would be a realistic solution for what
> > you are targeting. We clearly wouldn't do it if it implies distributions
> > to ship an extra kernel binary for systems based on different memory
> > maps.
> 
> We end up with hacks like the Realview phys/virt conversion. I don't
> think we can guarantee that all ARMv8 platforms would follow the above
> guidance.
> 
> --
> Catalin
