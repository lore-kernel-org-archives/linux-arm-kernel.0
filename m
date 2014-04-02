From: jays.lee@samsung.com (Jungseok Lee)
Date: Wed, 02 Apr 2014 12:58:39 +0900
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <20140401132316.GD20061@arm.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
 <7050133.LRSn2ENgQ4@wuerfel> <20140401132316.GD20061@arm.com>
Message-ID: <004b01cf4e27$d47da990$7d78fcb0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 01, 2014 10:23 PM, Catalin Marinas wrote:
> On Tue, Apr 01, 2014 at 12:11:34AM +0100, Arnd Bergmann wrote:
> > On Monday 31 March 2014 16:27:19 Catalin Marinas wrote:
> > > On Mon, Mar 31, 2014 at 01:53:20PM +0100, Arnd Bergmann wrote:
> > > > On Monday 31 March 2014 12:31:14 Catalin Marinas wrote:
> > > > > On Mon, Mar 31, 2014 at 07:56:53AM +0100, Arnd Bergmann wrote:
> > > > > > On Monday 31 March 2014 12:51:07 Jungseok Lee wrote:
> > > > > > > Current ARM64 kernel cannot support 4KB pages for 40-bit physical address
> > > > > > > space described in [1] due to one major issue + one minor issue.
> > > > > > >
> > > > > > > Firstly, kernel logical memory map (0xffffffc000000000-0xffffffffffffffff)
> > > > > > > cannot cover DRAM region from 544GB to 1024GB in [1]. Specifically, ARM64
> > > > > > > kernel fails to create mapping for this region in map_mem function
> > > > > > > (arch/arm64/mm/mmu.c) since __phys_to_virt for this region reaches to
> > > > > > > address overflow. I've used 3.14-rc8+Fast Models to validate the statement.
> > > > > >
> > > > > > It took me a while to understand what is going on, but it essentially comes
> > > > > > down to the logical memory map (0xffffffc000000000-0xffffffffffffffff)
> > > > > > being able to represent only RAM in the first 256GB of address space.
> > > > > >
> > > > > > More importantly, this means that any system following [1] will only be
> > > > > > able to use 32GB of RAM, which is a much more severe restriction than
> > > > > > what it sounds like at first.
> > > > >
> > > > > On a 64-bit platform, do we still need the alias at the bottom and the
> > > > > 512-544GB hole (even for 32-bit DMA, top address bits can be wired to
> > > > > 512GB)? Only the idmap would need 4 levels, but that's static, we don't
> > > > > need to switch Linux to 4-levels. Otherwise the memory is too sparse.
> > > >
> 
> 
> > > > I think we should keep a static virtual-to-physical mapping,
> > >
> > > Just so that I understand: with a PHYS_OFFSET of 0?
> >
> > I hadn't realized at first that it's variable, but I guess 0 would be the easiest,
> > otherwise we wouldn't be able to use 512GB pages to map the high memory range.
> >
> > > > and to keep
> > > > relocating the kernel at compile time without a hack like ARM_PATCH_PHYS_VIRT
> > > > if at all possible.
> > >
> > > and the kernel running at a virtual alias at a higher position than the
> > > end of the mapped RAM? IIUC x86_64 does something similar.
> >
> > That would work, yes.
> >
> > Another idea is to always run the kernel at PAGE_OFFSET, as today, but create
> > an alias there if there isn't already RAM at that location with the fixed
> > PHYS_OFFSET.
> 
> As long as we don't have some overlapping in VA space between start of
> RAM and end of the mapped kernel.
> 
> There maybe be other tricky bits with KVM and how EL2 code is mapped.
> 
> > > > > > There are good reasons to use a 50 bit virtual address space in user
> > > > > > land, e.g. for supporting data base applications that mmap huge files.
> > > >
> > > > You may actually need 4-level tables even if you have much less installed
> > > > memory, depending on how the application is written. Note that x86, powerpc
> > > > and s390 all chose to use 4-level tables for 64-bit kernels all the
> > > > time, even thought they can also use 3-level of 5-level in some cases.
> > >
> > > I don't mind 4-level tables by default but I would still keep a
> > > configuration option (or at least doing some benchmarks to assess the
> > > impact before switching permanently to 4-levels). There are mobile
> > > platforms that don't really need as much VA space (and people are even
> > > talking about ILP32).
> >
> > Yes, I wasn't suggesting we do it all the time. A related question
> > is whether we would also want to support 3-level 64k page tables, to
> > extend the addressable area from 42 bit (4TB) to 55 bit (large enough).
> > Is that actually a supported configuration?
> 
> It can go up to 48-bit maximum (with some extra reserved bits in the
> architecture, just in case more will be needed).
> 
> On some previous patches I've seen posted for 4-levels I asked that 64K
> and 4K page configurations are decoupled from the pgtable-?level.h
> macros so that if we ever need 3-levels with 64K it's easy to enable.

Is your request to decouple page size from the number of page tables?
In other words, would you like to prepare 4 options, 1)4KB+3Level, 2)
4KB+4Level, 3)64KB+2Level and 4)64KB+3Level, as combining page size
with page table levels in kernel configuration? 

Best Regards
Jungseok Lee
