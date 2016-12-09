From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Fri, 9 Dec 2016 20:14:24 +0800
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
Message-ID: <bc099ca6-d927-3eb6-438c-291a66ecf5f9@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,
We have merged your patch to 4.9.0-rc8, however we still meet the similar problem
on our D05 board:

Thanks,
Yisheng Xie
-----------------
[    5.081971] ------------[ cut here ]------------
[    5.086668] kernel BUG at mm/page_alloc.c:1863!
[    5.091281] Internal error: Oops - BUG: 0 [#1] SMP
[    5.096159] Modules linked in:
[    5.099265] CPU: 61 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc8+ #58
[    5.105822] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 UEFI 16.08 RC1 12/08/2016
[    5.114860] task: fffffe13f23d7400 task.stack: fffffe13f66f8000
[    5.120903] PC is at move_freepages+0x170/0x180
[    5.125514] LR is at move_freepages_block+0xa8/0xb8
[    5.130479] pc : [<fffffc00081e9588>] lr : [<fffffc00081e9640>] pstate: 200000c5
[    5.138008] sp : fffffe13f66fb910
[    5.141375] x29: fffffe13f66fb910 x28: 00000000ffffff80
[    5.146784] x27: fffffdff800b0000 x26: fffffe13fbf62b90
[    5.152193] x25: 000000000000000a x24: fffffdff800b0020
[    5.157598] x23: 0000000000000000 x22: fffffdff800b0000
[    5.163006] x21: fffffdff800fffc0 x20: fffffe13fbf62680
[    5.168412] x19: fffffdff80080000 x18: 000000004c4d6d26
[    5.173820] x17: 0000000000000000 x16: 0000000000000000
[    5.179226] x15: 000000005c589429 x14: 0000000000000000
[    5.184634] x13: 0000000000000000 x12: 00000000fe2ce6e0
[    5.190039] x11: 00000000bb5b525b x10: 00000000bb48417b
[    5.195446] x9 : 0000000000000068 x8 : 0000000000000000
[    5.200854] x7 : fffffe13fbff2680 x6 : 0000000000000001
[    5.206260] x5 : fffffc0008e12328 x4 : 0000000000000000
[    5.211667] x3 : fffffe13fbf62680 x2 : 0000000000000000
[    5.217073] x1 : fffffe13fbff2680 x0 : fffffe13fbf62680
[...]
[    5.768991] [<fffffc00081e9588>] move_freepages+0x170/0x180
[    5.774664] [<fffffc00081e9640>] move_freepages_block+0xa8/0xb8
[    5.780691] [<fffffc00081e9bbc>] __rmqueue+0x494/0x5f0
[    5.785921] [<fffffc00081eb10c>] get_page_from_freelist+0x5ec/0xb58
[    5.792302] [<fffffc00081ebc4c>] __alloc_pages_nodemask+0x144/0xd08
[    5.798687] [<fffffc0008240514>] alloc_page_interleave+0x64/0xc0
[    5.804801] [<fffffc0008240b20>] alloc_pages_current+0x108/0x168
[    5.810920] [<fffffc0008c75410>] atomic_pool_init+0x78/0x1cc
[    5.816680] [<fffffc0008c755a0>] arm64_dma_init+0x3c/0x44
[    5.822180] [<fffffc0008082d94>] do_one_initcall+0x44/0x138
[    5.827853] [<fffffc0008c70d54>] kernel_init_freeable+0x1ec/0x28c
[    5.834060] [<fffffc00088a79f0>] kernel_init+0x18/0x110
[    5.839378] [<fffffc0008082b30>] ret_from_fork+0x10/0x20
[    5.844785] Code: 9108a021 9400afc5 d4210000 d503201f (d4210000)
[    5.851024] ---[ end trace 3382df1ae82057db ]---


On 2016/12/1 2:21, Robert Richter wrote:
> On ThunderX systems with certain memory configurations we see the
> following BUG_ON():
> 
>  kernel BUG at mm/page_alloc.c:1848!
> 
> This happens for some configs with 64k page size enabled. The BUG_ON()
> checks if start and end page of a memmap range belongs to the same
> zone.
> 
> The BUG_ON() check fails if a memory zone contains NOMAP regions. In
> this case the node information of those pages is not initialized. This
> causes an inconsistency of the page links with wrong zone and node
> information for that pages. NOMAP pages from node 1 still point to the
> mem zone from node 0 and have the wrong nid assigned.
> 
> The reason for the mis-configuration is a change in pfn_valid() which
> reports pages marked NOMAP as invalid:
> 
>  68709f45385a arm64: only consider memblocks with NOMAP cleared for linear mapping
> 
> This causes pages marked as nomap being no long reassigned to the new
> zone in memmap_init_zone() by calling __init_single_pfn().
> 
> Fixing this by restoring the old behavior of pfn_valid() to use
> memblock_is_memory(). Also changing users of pfn_valid() in arm64 code
> to use memblock_is_map_memory() where necessary. This only affects
> code in ioremap.c. The code in mmu.c still can use the new version of
> pfn_valid().
> 
> As a consequence, pfn_valid() can not be used to check if a physical
> page is RAM. It just checks if there is an underlying memmap with a
> valid struct page. Moreover, for performance reasons the whole memmap
> (with pageblock_nr_pages number of pages) has valid pfns (SPARSEMEM
> config). The memory range is extended to fit the alignment of the
> memmap. Thus, pfn_valid() may return true for pfns that do not map to
> physical memory. Those pages are simply not reported to the mm, they
> are not marked reserved nor added to the list of free pages. Other
> functions such a page_is_ram() or memblock_is_map_ memory() must be
> used to check for memory and if the page can be mapped with the linear
> mapping.
> 
> Since NOMAP mem ranges may need to be mapped with different mem
> attributes (e.g. read-only or non-caching) we can not use linear
> mapping here. The use of memblock_is_memory() in pfn_valid() may not
> break this behaviour. Since commit:
> 
>  e7cd190385d1 arm64: mark reserved memblock regions explicitly in iomem
> 
> NOMAP mem resources are no longer marked as system RAM (IORESOURCE_
> SYSTEM_RAM). Now page_is_ram() and region_intersects() (see
> memremap()) do not detect NOMAP mem as system ram and NOMAP mem is not
> added to the linear mapping as system RAM is.
> 
> v2:
> 
>  * Added Ack
>  * updated description to reflect the discussion
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/mm/init.c    | 2 +-
>  arch/arm64/mm/ioremap.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 212c4d1e2f26..166911f4a2e6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -147,7 +147,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  int pfn_valid(unsigned long pfn)
>  {
> -	return memblock_is_map_memory(pfn << PAGE_SHIFT);
> +	return memblock_is_memory(pfn << PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index 01e88c8bcab0..c17c220b0c48 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/io.h>
> @@ -55,7 +56,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
>  	/*
>  	 * Don't allow RAM to be mapped.
>  	 */
> -	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> +	if (WARN_ON(memblock_is_map_memory(phys_addr)))
>  		return NULL;
>  
>  	area = get_vm_area_caller(size, VM_IOREMAP, caller);
> @@ -96,7 +97,7 @@ EXPORT_SYMBOL(__iounmap);
>  void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
>  {
>  	/* For normal memory we already have a cacheable mapping. */
> -	if (pfn_valid(__phys_to_pfn(phys_addr)))
> +	if (memblock_is_map_memory(phys_addr))
>  		return (void __iomem *)__phys_to_virt(phys_addr);
>  
>  	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
> 
