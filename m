From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Mar 2014 15:52:16 -0400 (EDT)
Subject: [PATCH] ARM: Better virt_to_page() handling
In-Reply-To: <E1WTYiT-0007Jl-Fe@rmk-PC.arm.linux.org.uk>
References: <20140328152831.GK7528@n2100.arm.linux.org.uk>
 <E1WTYiT-0007Jl-Fe@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1403281506250.1571@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Mar 2014, Russell King wrote:

> virt_to_page() is incredibly inefficient when virt-to-phys patching is
> enabled.  This is because we end up with this calculation:
> 
>   page = &mem_map[asm virt_to_phys(addr) >> 12 - __pv_phys_offset >> 12]
> 
> in assembly.  The asm virt_to_phys() is equivalent this this operation:
> 
>   addr - PAGE_OFFSET + __pv_phys_offset
> 
> and we can see that because this is assembly, the compiler has no chance
> to optimise some of that away.  This should reduce down to:
> 
>   page = &mem_map[(addr - PAGE_OFFSET) >> 12]
> 
> for the common cases.  Permit the compiler to make this optimisation by
> giving it more of the information it needs - do this by providing a
> virt_to_pfn() macro.
> 
> Another issue which makes this more complex is that __pv_phys_offset is
> a 64-bit type on all platforms.  This is needlessly wasteful - if we
> store the physical offset as a PFN, we can save a lot of work having
> to deal with 64-bit values, which sometimes ends up producing incredibly
> horrid code:
> 
>      a4c:       e3009000        movw    r9, #0
>                         a4c: R_ARM_MOVW_ABS_NC  __pv_phys_offset
>      a50:       e3409000        movt    r9, #0          ; r9 = &__pv_phys_offset
>                         a50: R_ARM_MOVT_ABS     __pv_phys_offset
>      a54:       e3002000        movw    r2, #0
>                         a54: R_ARM_MOVW_ABS_NC  __pv_phys_offset
>      a58:       e3402000        movt    r2, #0          ; r2 = &__pv_phys_offset
>                         a58: R_ARM_MOVT_ABS     __pv_phys_offset
>      a5c:       e5999004        ldr     r9, [r9, #4]    ; r9 = high word of __pv_phys_offset
>      a60:       e3001000        movw    r1, #0
>                         a60: R_ARM_MOVW_ABS_NC  mem_map
>      a64:       e592c000        ldr     ip, [r2]        ; ip = low word of __pv_phys_offset
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Good catch!

Some observations below.

> ---
>  arch/arm/include/asm/memory.h | 41 ++++++++++++++++++++++++-----------------
>  arch/arm/kernel/armksyms.c    |  2 +-
>  arch/arm/kernel/head.S        | 17 +++++++++--------
>  3 files changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 4afb376d9c7c..02fa2558f662 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -166,9 +166,17 @@
>   * Physical vs virtual RAM address space conversion.  These are
>   * private definitions which should NOT be used outside memory.h
>   * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
> + *
> + * PFNs are used to describe any physical page; this means
> + * PFN 0 == physical address 0.
>   */
> -#ifndef __virt_to_phys
> -#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +#if defined(__virt_to_phys)
> +#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> +#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
> +
> +#define virt_to_pfn(kaddr) (__pa(kaddr) >> PAGE_SHIFT)
> +
> +#elif defined(CONFIG_ARM_PATCH_PHYS_VIRT)
>  
>  /*
>   * Constants used to force the right instruction encodings and shifts
> @@ -177,12 +185,17 @@
>  #define __PV_BITS_31_24	0x81000000
>  #define __PV_BITS_7_0	0x81
>  
> -extern u64 __pv_phys_offset;
> +extern unsigned long __pv_phys_pfn_offset;
>  extern u64 __pv_offset;
>  extern void fixup_pv_table(const void *, unsigned long);
>  extern const void *__pv_table_begin, *__pv_table_end;
>  
> -#define PHYS_OFFSET __pv_phys_offset
> +#define PHYS_OFFSET	((phys_addr_t)__pv_phys_pfn_offset << PAGE_SHIFT)
> +#define PHYS_PFN_OFFSET	(__pv_phys_pfn_offset)
> +
> +#define virt_to_pfn(kaddr) \
> +	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
> +	 PHYS_PFN_OFFSET)

This is the second definition for virt_to_pfn().

>  
>  #define __pv_stub(from,to,instr,type)			\
>  	__asm__("@ __pv_stub\n"				\
> @@ -243,6 +256,7 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>  #else
>  
>  #define PHYS_OFFSET	PLAT_PHYS_OFFSET
> +#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
>  
>  static inline phys_addr_t __virt_to_phys(unsigned long x)
>  {
> @@ -254,18 +268,11 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>  	return x - PHYS_OFFSET + PAGE_OFFSET;
>  }
>  
> -#endif
> -#endif
> +#define virt_to_pfn(kaddr) \
> +	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
> +	 PHYS_PFN_OFFSET)

This is a third definition, identical to the second one. 

I see it might be hard to make the last two common, unless it is defined 
up front and the odd case does a #undef virt_to_pfn before redefining 
it.  Which way is best I'm not sure.

Also this needs to take care of those machines overriding PHYS_OFFSET at 
run time (see commit a77e0c7b2774f).  However it looks like no code 
relying on the LPAE version of early_paging_init() has been merged in 
mainline yet.  Maybe a note in the commit log to mention this case might 
be all that is needed for now.

With that you may add:

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas
