From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 01 Feb 2016 14:12:09 -0500 (EST)
Subject: [PATCH v4] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <1454349165-12249-1-git-send-email-chris.brandt@renesas.com>
References: <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <1454349165-12249-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <alpine.LFD.2.20.1602011404420.32766@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Feb 2016, Chris Brandt wrote:

> For an XIP build, __data_loc, not _etext, represents the end of the
> binary image that needs to stay mapped into the MODULES_VADDR area.
> Years ago, data came before text in the memory map. However,
> now that the order is text/init/data, an XIP_KERNEL needs to map
> up to the __data_loc symbol in order to keep from cutting off
> parts of the kernel that are needed.
> We only map up to the beginning of data because data has already been
> copied, so there's no reason to keep it around anymore.
> 
> This fixes the bug where you might lose the end of your kernel area
> after page table setup is complete.
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

The __data_loc symbol doesn't convey much to say with regards to XIP 
mapping.  It would be better to dedicate another symbol with a proper 
name instead.  Something like xiprom_start and xiprom_end perhaps.  
This way, someone looking at the linker script won't be fooled by a 
hidden meaning tied to _etext or __data_loc.


> ---
> v4:
> * Switched from using _edata_loc __data_loc.
>   Made commit text more accurate.
> v3:
> * Removed sections.h from Kbuild
> v2:
> * Added change for MODULES_VADDR
> * Moved extern to new file asm/sections.h
> ---
>  arch/arm/include/asm/Kbuild     | 1 -
>  arch/arm/include/asm/sections.h | 8 ++++++++
>  arch/arm/kernel/module.c        | 2 +-
>  arch/arm/mm/mmu.c               | 8 ++++++--
>  4 files changed, 15 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/include/asm/sections.h
> 
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 16da638..3f6616b 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -23,7 +23,6 @@ generic-y += preempt.h
>  generic-y += resource.h
>  generic-y += rwsem.h
>  generic-y += seccomp.h
> -generic-y += sections.h
>  generic-y += segment.h
>  generic-y += sembuf.h
>  generic-y += serial.h
> diff --git a/arch/arm/include/asm/sections.h b/arch/arm/include/asm/sections.h
> new file mode 100644
> index 0000000..8d50cce
> --- /dev/null
> +++ b/arch/arm/include/asm/sections.h
> @@ -0,0 +1,8 @@
> +#ifndef _ASM_ARM_SECTIONS_H
> +#define _ASM_ARM_SECTIONS_H
> +
> +#include <asm-generic/sections.h>
> +
> +extern char __data_loc[];
> +
> +#endif	/* _ASM_ARM_SECTIONS_H */
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index efdddcb..b48e3bc 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -34,7 +34,7 @@
>   * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
>   */
>  #undef MODULES_VADDR
> -#define MODULES_VADDR	(((unsigned long)_etext + ~PMD_MASK) & PMD_MASK)
> +#define MODULES_VADDR	(((unsigned long)__data_loc + ~PMD_MASK) & PMD_MASK)
>  #endif
>  
>  #ifdef CONFIG_MMU
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 434d76f..53d7a88 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1253,7 +1253,7 @@ static inline void prepare_page_table(void)
>  
>  #ifdef CONFIG_XIP_KERNEL
>  	/* The XIP kernel is mapped in the module area -- skip over it */
> -	addr = ((unsigned long)_etext + PMD_SIZE - 1) & PMD_MASK;
> +	addr = ((unsigned long)__data_loc + PMD_SIZE - 1) & PMD_MASK;
>  #endif
>  	for ( ; addr < PAGE_OFFSET; addr += PMD_SIZE)
>  		pmd_clear(pmd_off_k(addr));
> @@ -1335,7 +1335,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
>  #ifdef CONFIG_XIP_KERNEL
>  	map.pfn = __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK);
>  	map.virtual = MODULES_VADDR;
> -	map.length = ((unsigned long)_etext - map.virtual + ~SECTION_MASK) & SECTION_MASK;
> +	map.length = ((unsigned long)__data_loc - map.virtual + ~SECTION_MASK) & SECTION_MASK;
>  	map.type = MT_ROM;
>  	create_mapping(&map);
>  #endif
> @@ -1426,7 +1426,11 @@ static void __init kmap_init(void)
>  static void __init map_lowmem(void)
>  {
>  	struct memblock_region *reg;
> +#ifdef CONFIG_XIP_KERNEL
> +	phys_addr_t kernel_x_start = round_down(__pa(_sdata), SECTION_SIZE);
> +#else
>  	phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> +#endif
>  	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
>  
>  	/* Map all the lowmem memory banks. */
> -- 
> 1.9.1
> 
> 
> 
