From: james.morse@arm.com (James Morse)
Date: Fri, 27 Jan 2017 13:59:05 +0000
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170124085004.3892-4-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org>
Message-ID: <588B5229.60509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 24/01/17 08:49, AKASHI Takahiro wrote:
> To protect the memory reserved for crash dump kernel once after loaded,
> arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
> permissions of the corresponding kernel mappings.
> 
> We also have to
> - put the region in an isolated mapping, and

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9c7adcce8e4e..2d4a0b68a852 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -22,6 +22,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> +#include <linux/kexec.h>
>  #include <linux/libfdt.h>
>  #include <linux/mman.h>
>  #include <linux/nodemask.h>
> @@ -367,6 +368,39 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
>  	unsigned long kernel_start = __pa(_text);
>  	unsigned long kernel_end = __pa(__init_begin);
>  
> +#ifdef CONFIG_KEXEC_CORE
> +	/*
> +	 * While crash dump kernel memory is contained in a single memblock
> +	 * for now, it should appear in an isolated mapping so that we can
> +	 * independently unmap the region later.
> +	 */
> +	if (crashk_res.end && crashk_res.start >= start &&
> +	    crashk_res.end <= end) {
> +		if (crashk_res.start != start)
> +			__create_pgd_mapping(pgd, start, __phys_to_virt(start),
> +					     crashk_res.start - start,
> +					     PAGE_KERNEL,
> +					     early_pgtable_alloc,
> +					     debug_pagealloc_enabled());
> +
> +		/* before kexec_load(), the region can be read-writable. */
> +		__create_pgd_mapping(pgd, crashk_res.start,
> +				     __phys_to_virt(crashk_res.start),
> +				     crashk_res.end - crashk_res.start + 1,
> +				     PAGE_KERNEL, early_pgtable_alloc,
> +				     debug_pagealloc_enabled());
> +
> +		if (crashk_res.end != end)
> +			__create_pgd_mapping(pgd, crashk_res.end + 1,
> +					     __phys_to_virt(crashk_res.end + 1),
> +					     end - crashk_res.end - 1,
> +					     PAGE_KERNEL,
> +					     early_pgtable_alloc,
> +					     debug_pagealloc_enabled());

> +		return;

Doesn't this mean we skip all the 'does this overlap with the kernel text' tests
that happen further down in this file?

(I think this can be fixed by replacing page_mappings_only with something
 like needs_per_page_mapping(addr, size) called when we try to place a block
 mapping. needs_per_page_mapping() can then take kdump and debug_pagealloc into
 account.)


I see boot failures on v4.10-rc5, with this series (and your fixup diff for
patch 4). I'm using defconfig with 64K pages and 42bit VA on Juno. I pass
'crashkernel=1G':
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.50 by ARM Juno EFI Nov 24 2015 12:36:35
[    0.000000] efi:  ACPI=0xf95b0000  ACPI 2.0=0xf95b0014  PROP=0xfe8db4d8
[    0.000000] Reserving 1024MB of memory at 2560MB for crashkernel
[    0.000000] cma: Failed to reserve 512 MiB
[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at ../arch/arm64/mm/mmu.c:118!
[    0.000000] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.0-rc5-00012-gdd6fe39
0c85d #6873
[    0.000000] Hardware name: ARM Juno development board (r1) (DT)
[    0.000000] task: fffffc0008e2c900 task.stack: fffffc0008df0000
[    0.000000] PC is at __create_pgd_mapping+0x2c8/0x2e8
[    0.000000] LR is at paging_init+0x2b0/0x6fc
[    0.000000] pc : [<fffffc0008096b20>] lr : [<fffffc0008ce5a60>] pstate: 60000
0c5
[    0.000000] sp : fffffc0008df3e20
[    0.000000] x29: fffffc0008df3e20 x28: 00e8000000000713
[    0.000000] x27: 0000000000000001 x26: 00000000e00f0000
[    0.000000] x25: fffffe00794a0000 x24: fffffe00794a0000
[    0.000000] x23: fffffe00600f0000 x22: 00e80000e0000711
[    0.000000] x21: 0000000000000000 x20: fffffdff7e5e8018
[    0.000000] x19: 000000000000e00f x18: 0000000000000000
[    0.000000] x17: fffffc0008f61cd0 x16: 0000000000000005
[    0.000000] x15: 0000000880000000 x14: 00000000001fffff
[    0.000000] x13: 00f8000000000713 x12: fffffc0008e3d000
[    0.000000] x11: 0000000000000801 x10: 00e8000000000713
[    0.000000] x9 : 0000000000000000 x8 : 0000000000001003
[    0.000000] x7 : 0000000000000000 x6 : 0000000000000000
[    0.000000] x5 : fffffc0008ce5744 x4 : 00e8000000000713
[    0.000000] x3 : fffffe007949ffff x2 : fffffe00e00f0000
[    0.000000] x1 : 00e8000000000713 x0 : 0000000000000001
[    0.000000]
[    0.000000] Process swapper (pid: 0, stack limit = 0xfffffc0008df0000)
[    0.000000] Stack: (0xfffffc0008df3e20 to 0xfffffc0008df4000)

[    0.000000] Call trace:

[    0.000000] [<fffffc0008096b20>] __create_pgd_mapping+0x2c8/0x2e8
[    0.000000] [<fffffc0008ce5a60>] paging_init+0x2b0/0x6fc
[    0.000000] [<fffffc0008ce27d0>] setup_arch+0x1c0/0x5ac
[    0.000000] [<fffffc0008ce0838>] start_kernel+0x70/0x394
[    0.000000] [<fffffc0008ce01e8>] __primary_switched+0x64/0x6c
[    0.000000] Code: f29fefe1 ea01001f 54ffff00 d4210000 (d4210000)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!


Adding some debug shows the crash region was allocated as 0xa0000000:0xdfffffff,
and the first memblock to hit __map_memblock() was 0x80000000:0xe0000000.

This causes the end of the crash region to be padded, as 0xdfffffff!=0xe0000000,
but your 'crashk_res.end + 1' actually mapped 0xe0000000 to 0xe0000000 with 0
size. This causes __create_pgd_mapping() to choke when it next uses 0xe0000000
as a start address, as it evidently mapped something when given a 0 size.

You need to round-up crashk_res.end to a a page boundary if it isn't already
aligned.


> +	}
> +#endif
> +
>  	/*
>  	 * Take care not to create a writable alias for the
>  	 * read-only text and rodata sections of the kernel image.
> 

Thanks,

James
