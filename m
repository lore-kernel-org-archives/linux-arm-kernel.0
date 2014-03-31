From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 31 Mar 2014 13:45:51 +0100
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <20140331113113.GE29871@arm.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <76240593.SAyloCy7nR@wuerfel> <20140331113113.GE29871@arm.com>
Message-ID: <20140331124551.GF29871@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 12:31:14PM +0100, Catalin Marinas wrote:
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
[...]
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

Yet another approach would be to enable 4-levels of page tables (no
nopud.h) in the kernel with pgd_offset_k doing the right thing for 4
levels but user space configured to 3-levels only and pgd_offset
returning 0 while pud_offset does what pgd_offset currently implements
for 3 levels.

This solves the page table walk latency for user but not for kernel.
Anyway, if the hardware memory map is so sparse (a real SoC, not the
spec), I don't think we have other ways to support it with 3-levels of
page table for the kernel, unless we hack __virt_to_phys/__phys_to_virt.

-- 
Catalin
