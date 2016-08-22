From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 22 Aug 2016 10:23:11 +0900
Subject: [PATCH v24 5/9] arm64: kdump: add kdump support
In-Reply-To: <57B70966.2000105@arm.com>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
 <57AB586D.3080900@arm.com> <20160818071547.GC20080@linaro.org>
 <20160819012651.GE20080@linaro.org> <57B70966.2000105@arm.com>
Message-ID: <20160822012310.GH20080@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On Fri, Aug 19, 2016 at 02:28:06PM +0100, James Morse wrote:
> On 19/08/16 02:26, AKASHI Takahiro wrote:
> > Can you try the following change?
> > If it fixes your problem, I will post it as a patch.
> 
> Almost! This causes booting with acpi=on to fail for the familiar
> alignment-fault reasons[2],
> details and a suggested fix below.

Thank you for the fix.
I will merge your hunk to the patch.

-Takahiro AKASHI

> I think we should have this change as it matches x86's use of acpi, and means we
> don't rely on re-parsing the efi memory map to learn which areas of memory
> shouldn't be in the vmcore.
> 
> 
> > ===8<===
> > From 740563e4a437f0d6ecf6e421c91433f9b8f19041 Mon Sep 17 00:00:00 2001
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Date: Fri, 19 Aug 2016 09:57:52 +0900
> > Subject: [PATCH] arm64: mark reserved memblock regions explicitly
> > 
> > ---
> >  arch/arm64/kernel/setup.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 38eda13..38589b5 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -205,10 +205,15 @@ static void __init request_standard_resources(void)
> >  
> >  	for_each_memblock(memory, region) {
> >  		res = alloc_bootmem_low(sizeof(*res));
> > -		res->name  = "System RAM";
> > +		if (memblock_is_nomap(region)) {
> > +			res->name  = "reserved";
> 
> > +			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> 
> This causes acpica to choke.  arch/arm64/include/asm/acpi.h:acpi_os_ioremap()
> calls page_is_ram(), which expects IORESOURCE_SYSTEM_RAM. From kernel/resource.c:
> > /*
> >  * This generic page_is_ram() returns true if specified address is
> >  * registered as System RAM in iomem_resource list.
> >  */
> > int __weak page_is_ram(unsigned long pfn)
> 
> We are trying to infer information about the EFI memory map by looking through
> iomem_resource list generated from memblock.
> drivers/firmware/efi/arm-init.c:reserve_regions() adds memory with the WB
> attribute to memblock via early_init_dt_add_memory_arch(), so changing
> page_is_ram() for memblock_is_memory() is one step closer to checking the
> attributes in the efi memory map (which turns out to tricky).
> 
> With your v24 on v4.8-rc1 and 'mark reserved memblock regions explicitly', and
> this extra hack [0], I can boot, kdump, extract the vmcore (with read() and
> mmap()), and pull things out of it with crash.
> 
> 
> Thanks,
> 
> James
> 
> 
> > +		} else {
> > +			res->name  = "System RAM";
> > +			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +		}
> >  		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
> >  		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
> > -		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >  
> >  		request_resource(&iomem_resource, res);
> 
> [0] whitespace damaged hack for acpi_os_ioremap().
> ------------------------------------%<------------------------------------
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -12,6 +12,7 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
> 
> +#include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/psci.h>
> 
> @@ -32,7 +33,11 @@
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>                                             acpi_size size)
>  {
> -       if (!page_is_ram(phys >> PAGE_SHIFT))
> +       /*
> +        * EFI's reserve_regions() call adds memory with the WB attribute
> +        * to memblock via early_init_dt_add_memory_arch().
> +        */
> +       if (!memblock_is_memory(phys))
>                 return ioremap(phys, size);
> 
>         return ioremap_cache(phys, size);
> ------------------------------------%<------------------------------------
> 
> [1] cat /proc/iomem | tail -n 9
> 8000000000-8001e7ffff : reserved
> 8001e80000-83ff17ffff : System RAM
>   8002080000-8002b0ffff : Kernel code
>   8002d90000-8002f6ffff : Kernel data
>   80dfe00000-80ffdfffff : Crash kernel
> 83ff180000-83ff1cffff : reserved
> 83ff1d0000-83ff21ffff : System RAM
> 83ff220000-83ffe4ffff : reserved
> 83ffe50000-83ffffffff : System RAM
> 
> [2] Panic on boot without [0]
> [    0.037098] ACPI: Core revision 20160422
> [    0.041174] Unable to handle kernel paging request at virtual address
> fffffc0008f831e7
> [    0.049155] pgd = fffffc0008f50000
> [    0.052576] [fffffc0008f831e7] *pgd=00000083fffe0003, *pud=00000083fffe0003,
> *pmd=00000083fffe0003, *pte=00e80083ff1c0707
> [    0.063632] Internal error: Oops: 96000021 [#1] PREEMPT SMP
> [    0.069245] Modules linked in:
> [    0.072317] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc1+ #4892
> [    0.078891] Hardware name: AMD Seattle (Rev.B0) Development Board (Overdrive)
> (DT)
> [    0.086518] task: fffffc0008dc8a80 task.stack: fffffc0008d90000
> [    0.092486] PC is at acpi_ns_lookup+0x238/0x378
> [    0.097049] LR is at acpi_ds_load1_begin_op+0x88/0x260
> [    0.102290] pc : [<fffffc000840fed8>] lr : [<fffffc0008405dcc>] pstate: 60000045
> [    0.109740] sp : fffffc0008d93bb0
> [    0.113071] x29: fffffc0008d93bb0 x28: 0000000000000001
> [    0.118420] x27: 0000000000000000 x26: 000000000000001b
> [    0.123768] x25: fffffc0008a813b7 x24: 000000000000001b
> [    0.129119] x23: 000000000000001b x22: 0000000000000001
> [    0.134466] x21: fffffc0008d93cb8 x20: 0000000000000001
> [    0.139814] x19: fffffc0008f831e7 x18: 0000000000000023
> [    0.145163] x17: ffffffffffffffff x16: 0000000000000000
> [    0.150511] x15: 000000000000038e x14: 0000000000007fff
> [    0.155859] x13: ffffffffffffff00 x12: 0000000000000008
> [    0.161208] x11: 0000000000000028 x10: 00000000ffffff76
> [    0.166556] x9 : 0000000000000000 x8 : fffffe03c00b0140
> [    0.171907] x7 : 0000000000000003 x6 : fffffc0008d93cb8
> [    0.177255] x5 : fffffe03c0060800 x4 : fffffc0008ee7fe8
> [    0.182603] x3 : fffffc0008ee8000 x2 : fffffc0008ee7fe8
> [    0.187951] x1 : fffffc0008f831e7 x0 : 0000000000000000
> [    0.193296]
> [    0.194789] Process swapper/0 (pid: 0, stack limit = 0xfffffc0008d90020)
> [    0.483605] Call trace:
> [    0.486062] Exception stack(0xfffffc0008d939e0 to 0xfffffc0008d93b10)
> [    0.568522] [<fffffc000840fed8>] acpi_ns_lookup+0x238/0x378
> [    0.574134] [<fffffc0008405dcc>] acpi_ds_load1_begin_op+0x88/0x260
> [    0.580358] [<fffffc0008415e3c>] acpi_ps_build_named_op+0xa8/0x170
> [    0.586582] [<fffffc0008416034>] acpi_ps_create_op+0x130/0x230
> [    0.592455] [<fffffc0008415988>] acpi_ps_parse_loop+0x174/0x580
> [    0.598419] [<fffffc00084168b4>] acpi_ps_parse_aml+0xa8/0x278
> [    0.604208] [<fffffc0008411efc>] acpi_ns_one_complete_parse+0x130/0x158
> [    0.610871] [<fffffc0008411f48>] acpi_ns_parse_table+0x24/0x44
> [    0.616745] [<fffffc00084116fc>] acpi_ns_load_table+0x50/0xe0
> [    0.622535] [<fffffc000841ad80>] acpi_tb_load_namespace+0xdc/0x25c
> [    0.628764] [<fffffc0008b383f4>] acpi_load_tables+0x3c/0xa8
> [    0.634377] [<fffffc0008b37548>] acpi_early_init+0x88/0xbc
> [    0.639903] [<fffffc0008b10b30>] start_kernel+0x330/0x394
> [    0.645340] [<fffffc0008b10210>] __primary_switched+0x7c/0x8c
> [    0.651127] Code: 2a1a03f7 2a0002d6 36380054 321902d6 (b9400260)
> [    0.657270] ---[ end trace 0000000000000000 ]---
> [    0.661922] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.668673] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> 
