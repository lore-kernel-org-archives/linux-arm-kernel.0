From: dennis.chen@arm.com (Dennis Chen)
Date: Wed, 20 Jul 2016 11:39:11 +0800
Subject: [PATCH v22 2/8] arm64: limit memory regions based on DT
 property, usable-memory-range
In-Reply-To: <20160719110120.GF20774@linaro.org>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-3-takahiro.akashi@linaro.org>
 <578D1A31.5080509@arm.com> <20160719083554.GD20774@linaro.org>
 <20160719100616.GA20990@arm.com>
 <20160719110120.GF20774@linaro.org>
Message-ID: <20160720033909.GA30575@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 08:01:21PM +0900, AKASHI Takahiro wrote:
> On Tue, Jul 19, 2016 at 06:06:18PM +0800, Dennis Chen wrote:
> > Hello AKASHI,
> > 
> > On Tue, Jul 19, 2016 at 05:35:55PM +0900, AKASHI Takahiro wrote:
> > > James,
> > >
> > > On Mon, Jul 18, 2016 at 07:04:33PM +0100, James Morse wrote:
> > > > Hi!
> > > >
> > > > (CC: Dennis Chen)
> > > >
> > > > On 12/07/16 06:05, AKASHI Takahiro wrote:
> > > > > Crash dump kernel will be run with a limited range of memory as System
> > > > > RAM.
> > > > >
> > > > > On arm64, we will use a device-tree property under /chosen,
> > > > >    linux,usable-memory-range = <BASE SIZE>
> > > > > in order for primary kernel either on uefi or non-uefi (device tree only)
> > > > > system to hand over the information about usable memory region to crash
> > > > > dump kernel. This property will supercede entries in uefi memory map table
> > > > > and "memory" nodes in a device tree.
> > > >
> > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > > index 51b1302..d8b296f 100644
> > > > > --- a/arch/arm64/mm/init.c
> > > > > +++ b/arch/arm64/mm/init.c
> > > > > @@ -300,10 +300,48 @@ static int __init early_mem(char *p)
> > > > >  }
> > > > >  early_param("mem", early_mem);
> > > > >
> > > > > +static int __init early_init_dt_scan_usablemem(unsigned long node,
> > > > > +         const char *uname, int depth, void *data)
> > > > > +{
> > > > > + struct memblock_region *usablemem = (struct memblock_region *)data;
> > > > > + const __be32 *reg;
> > > > > + int len;
> > > > > +
> > > > > + usablemem->size = 0;
> > > > > +
> > > > > + if (depth != 1 || strcmp(uname, "chosen") != 0)
> > > > > +         return 0;
> > > > > +
> > > > > + reg = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> > > > > + if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> > > > > +         return 1;
> > > > > +
> > > > > + usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> > > > > + usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
> > > > > +
> > > > > + return 1;
> > > > > +}
> > > > > +
> > > > > +static void __init fdt_enforce_memory_region(void)
> > > > > +{
> > > > > + struct memblock_region reg;
> > > > > +
> > > > > + of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
> > > > > +
> > > > > + if (reg.size) {
> > > > > +         memblock_remove(0, PAGE_ALIGN(reg.base));
> > > > > +         memblock_remove(round_down(reg.base + reg.size, PAGE_SIZE),
> > > > > +                         ULLONG_MAX);
> > > >
> > 
> > According to the panic message from James, I guess the ACPI regions are out of the range
> > [reg.base, reg.base + reg.size] and removed by your above codes. On ARM64, those ACPI
> > regions have been added into memblock and marked as NOMAP, so I think it should be
> > easy to adapt my fix to retain the NOMAP regions here
> 
> See below.
> 
> > Thanks,
> > Dennis
> > 
> > > > I think this is a new way to trip the problem Dennis Chen has been working on
> > > > [0]. If I kdump with --reuse-cmdline on a kernel booted with 'acpi=on', I get
> > > > the panic below [1]...
> > >
> > > Yeah, it can be.
> > >
> > > > It looks like Dennis's fix involves changes in mm/memblock.c, maybe they can be
> > > > extended to support a range instead of just a limit?
> > > >
> > > > (It looks like x86 explicitly adds the acpi regions to the crash-kernels memory
> > > > map in crash_setup_memmap_entries()).
> > > >
> > > >
> > > >
> > > > Is it possible for the kernel text to be outside this range? (a bug in
> > > > kexec-tools, or another user of the DT property) If we haven't already failed in
> > > > this case, it may be worth printing a warning, or refusing to
> > > > restrict-memory/expose-vmcore.
> > >
> > > In my implementation of kdump, the usable memory for crash dump
> > > kernel will be allocated within memblock.memory after ACPI-related
> > > regions have been mapped. "linux,usable-memory-range" indicates
> > > this exact memory range.
> > > On crash dump kernel, my fdt_enforce_memory_region() in arm64_memblock_init()
> > > will exclude all the other regions from memblock.memory.
> > > So the kernel (with acpi=on) won't recognize ACPI-regions as
> > > normal memory, and map them by ioremap().
> > >
> > > I thought that it was safe, but actually not due to unaligned accesses.
> > > As you suggested, we will probably be able to do the same thing of
> > > Chen's solution in fdt_enforce_memory_region().
> 
> memblock_isolate_range() and memblock_remove_range() are not exported.
> So we'd better implement an unified interface like:
>     memblock_cap_memory_range(phys_addr_t base, size_t size);
> 
> If base == NULL, it would behave in the exact same way as your
> memblock_mem_limit_remove_map().
>
Hello AKASHI, it's not reasonable to change the prototype of an existing memblock API
which will be used by other components as we did with memblock_enforce_memory_limit. 
Moreover the @size in you case is to specify a memory range of the memblock, which is
different from the @limit as an indicator of the total size of memblocks being limited. 
But I can be help to post an new memblock API patch to cater for your case.

Thanks,
Dennis
  
>
> Thanks,
> -Takahiro AKASHI
> 
> > >
> > >
> > > Thanks,
> > > -Takahiro AKASHI
> > >
