From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 22 May 2017 18:41:26 +0100
Subject: [PATCH v2] arm64: kernel: restrict /dev/mem read() calls to
 linear region
In-Reply-To: <20170519154200.14158-1-ard.biesheuvel@linaro.org>
References: <20170519154200.14158-1-ard.biesheuvel@linaro.org>
Message-ID: <20170522174126.GJ1657@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 04:42:00PM +0100, Ard Biesheuvel wrote:
> When running lscpu on an AArch64 system that has SMBIOS version 2.0
> tables, it will segfault in the following way:
> 
>   Unable to handle kernel paging request at virtual address ffff8000bfff0000
>   pgd = ffff8000f9615000
>   [ffff8000bfff0000] *pgd=0000000000000000
>   Internal error: Oops: 96000007 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 0 PID: 1284 Comm: lscpu Not tainted 4.11.0-rc3+ #103
>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>   task: ffff8000fa78e800 task.stack: ffff8000f9780000
>   PC is at __arch_copy_to_user+0x90/0x220
>   LR is at read_mem+0xcc/0x140
> 
> This is caused by the fact that lspci issues a read() on /dev/mem at the
> offset where it expects to find the SMBIOS structure array. However, this
> region is classified as EFI_RUNTIME_SERVICE_DATA (as per the UEFI spec),
> and so it is omitted from the linear mapping.
> 
> So let's restrict /dev/mem read/write access to those areas that are
> covered by the linear region.

So, I'm still of the opinion that /dev/mem simply should not be made
available on systems where people care about accidentally hard-locking
their systems from userland.

To that extent, this workaround takes the pressure off people to
configure their kernels properly.

On the other hand, it probably removes 90% of the risk cases.

I guess the solution depends on whether people think the remaining 10%
matter.

/
    Leif

> Reported-by: Alexander Graf <agraf@suse.de>
> Fixes: 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: check whether the entire region is covered by the same memblock that has
>     the MEMBLOCK_NOMAP attribute cleared
> 
>  arch/arm64/mm/mmap.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 7b0d55756eb1..adc208c2ae9c 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -18,6 +18,7 @@
>  
>  #include <linux/elf.h>
>  #include <linux/fs.h>
> +#include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
>  #include <linux/export.h>
> @@ -103,12 +104,18 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
>   */
>  int valid_phys_addr_range(phys_addr_t addr, size_t size)
>  {
> -	if (addr < PHYS_OFFSET)
> -		return 0;
> -	if (addr + size > __pa(high_memory - 1) + 1)
> -		return 0;
> -
> -	return 1;
> +	/*
> +	 * Check whether addr is covered by a memory region without the
> +	 * MEMBLOCK_NOMAP attribute, and whether that region covers the
> +	 * entire range. In theory, this could lead to false negatives
> +	 * if the range is covered by distinct but adjacent memory regions
> +	 * that only differ in other attributes. However, few of such
> +	 * attributes have been defined, and it is debatable whether it
> +	 * follows that /dev/mem read() calls should be able traverse
> +	 * such boundaries.
> +	 */
> +	return memblock_is_region_memory(addr, size) &&
> +	       memblock_is_map_memory(addr);
>  }
>  
>  /*
> -- 
> 2.9.3
> 
