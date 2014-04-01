From: sungjinn.chung@samsung.com (=?utf-8?B?7KCV7ISx7KeE?=)
Date: Tue, 01 Apr 2014 09:44:36 +0900
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <20140331152719.GH29871@arm.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <76240593.SAyloCy7nR@wuerfel> <20140331113113.GE29871@arm.com>
 <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
Message-ID: <000501cf4d43$90e618a0$b2b249e0$%chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 01, 2014 12:27 AM Catalin Marinas wrote:
> On Mon, Mar 31, 2014 at 01:53:20PM +0100, Arnd Bergmann wrote:
> > On Monday 31 March 2014 12:31:14 Catalin Marinas wrote:
> > > On Mon, Mar 31, 2014 at 07:56:53AM +0100, Arnd Bergmann wrote:
> > > > On Monday 31 March 2014 12:51:07 Jungseok Lee wrote:
> > > > > Current ARM64 kernel cannot support 4KB pages for 40-bit physical address
> > > > > space described in [1] due to one major issue + one minor issue.
> > > > >
> > > > > Firstly, kernel logical memory map (0xffffffc000000000-0xffffffffffffffff)
> > > > > cannot cover DRAM region from 544GB to 1024GB in [1]. Specifically, ARM64
> > > > > kernel fails to create mapping for this region in map_mem function
> > > > > (arch/arm64/mm/mmu.c) since __phys_to_virt for this region reaches to
> > > > > address overflow. I've used 3.14-rc8+Fast Models to validate the statement.
> > > >
> > > > It took me a while to understand what is going on, but it essentially comes
> > > > down to the logical memory map (0xffffffc000000000-0xffffffffffffffff)
> > > > being able to represent only RAM in the first 256GB of address space.
> > > >
> > > > More importantly, this means that any system following [1] will only be
> > > > able to use 32GB of RAM, which is a much more severe restriction than
> > > > what it sounds like at first.
> > >
> > > On a 64-bit platform, do we still need the alias at the bottom and the
> > > 512-544GB hole (even for 32-bit DMA, top address bits can be wired to
> > > 512GB)? Only the idmap would need 4 levels, but that's static, we don't
> > > need to switch Linux to 4-levels. Otherwise the memory is too sparse.
> >
> > I think we should keep a static virtual-to-physical mapping,
> 
> Just so that I understand: with a PHYS_OFFSET of 0?
> 
> > and to keep
> > relocating the kernel at compile time without a hack like ARM_PATCH_PHYS_VIRT
> > if at all possible.
> 
> and the kernel running at a virtual alias at a higher position than the
> end of the mapped RAM? IIUC x86_64 does something similar.
> 
> > > > > Secondly, vmemmap space is not enough to cover over about 585GB physical
> > > > > address space. Fortunately, this issue can be resolved as utilizing an extra
> > > > > vmemmap space (0xffffffbe00000000-0xffffffbffbbfffff) in [2]. However,
> > > > > it would not cover systems having a couple of terabytes DRAM.
> > > >
> > > > This one can be trivially changed by taking more space out of the vmalloc
> > > > area, to go much higher if necessary. vmemmap space is always just a fraction
> > > > of the linear mapping size, so we can accommodate it by definition if we
> > > > find space to fit the physical memory.
> > >
> > > vmemmap is the total range / page size * sizeof(struct page). So for 1TB
> > > range and 4K pages we would need 8GB (the current value, unless I
> > > miscalculated the above). Anyway, you can't cover 1TB range with
> > > 3-levels.
> >
> > The size of 'struct page' depends on a couple of configuration variables.
> > If they are all enabled, you might need a bit more, even for configurations
> > that don't have that much address space.
> 
> Yes. We could make vmemmap configurable at run-time or just go for a
> maximum value.
> 
> > > > > Therefore, it would be needed to implement 4 level page table translations
> > > > > for 4KB pages on 40-bit physical address space platforms. Someone might
> > > > > suggest use of 64KB pages in this case, but I'm not sure about how to
> > > > > deal with internal memory fragmentation.
> > > > >
> > > > > I would like to contribute 4 level page table translations to upstream,
> > > > > the target of which is 3.16 kernel, if there is no movement on it. I saw
> > > > > some related RFC patches a couple of months ago, but they didn't seem to
> > > > > be merged into maintainer's tree.
> > > >
> > > > I think you are answering the wrong question here. Four level page tables
> > > > should not be required to support >32GB of RAM, that would be very silly.
> > >
> > > I agree, we should only enable 4-levels of page table if we have close
> > > to 512GB of RAM or the range is too sparse but I would actually push
> > > back on the hardware guys to keep it tighter.
> >
> > But remember this part:
> >
> > > > There are good reasons to use a 50 bit virtual address space in user
> > > > land, e.g. for supporting data base applications that mmap huge files.
> >
> > You may actually need 4-level tables even if you have much less installed
> > memory, depending on how the application is written. Note that x86, powerpc
> > and s390 all chose to use 4-level tables for 64-bit kernels all the
> > time, even thought they can also use 3-level of 5-level in some cases.
> 
> I don't mind 4-level tables by default but I would still keep a
> configuration option (or at least doing some benchmarks to assess the
> impact before switching permanently to 4-levels). There are mobile
> platforms that don't really need as much VA space (and people are even
> talking about ILP32).

Hi,
How about keep 3-level table by default and enable 4-level table with 
config option?
Asymmetry level for kernel and user land would make code complicated.
And usually more memory means that user application tends to use more memory.
So I suggest same virtual space for both.

> 
> > > > If this is not the goal however, we should not pay for the overhead
> > > > of the extra page table in user space. I can see two other possible
> > > > solutions for the problem:
> > > >
> > > > a) always use a four-level page table in kernel space, regardless of
> > > > whether we do it in user space. We can move the kernel mappings down
> > > > in address space either by one 512GB entry to 0xffffff0000000000, or
> > > > to match the 64k-page location at 0xfffffc0000000000, or all the way
> > > > to to 0xfffc000000000000. In any case, we can have all the dynamic
> > > > mappings within one 512GB area and pretend we have a three-level
> > > > page table for them, while the rest of DRAM is mapped statically at
> > > > early boot time using 512GB large pages.
> > >
> > > That's a workaround but we end up with two (or more) kernel pgds - one
> > > for vmalloc, ioremap etc. and another (static) one for the kernel linear
> > > mapping. So far there isn't any memory mapping carved out but we have to
> > > be careful in the future.
> > >
> > > However, kernel page table walking would be a bit slower with 4-levels.
> >
> > Do we actually walk the kernel page tables that often? With what I suggested,
> > we can still pretend that it's 3-level for all practical purposes, since
> > you wouldn't walk the page tables for the linear mapping.
> 
> I was referring to hardware page table walk (TLB miss). Again, we need
> some benchmarks (it gets worse in a guest as it needs to walk the stage
> 2 for each stage 1 level miss; if you are really unlucky you can have up
> to 24 memory accesses for a TLB miss with two translation stages and 4
> levels each).
> 
> --
> Catalin
