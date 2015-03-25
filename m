From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 14:04:11 +0000
Subject: [PATCH 1/4] arm64: use tagged pointers to distinguish kernel
 text from the linear mapping
In-Reply-To: <1427125016-3873-2-git-send-email-ard.biesheuvel@linaro.org>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150325140411.GB26903@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 04:36:53PM +0100, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f800d45ea226..7dfe1b0c9c01 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -107,6 +107,10 @@
>  #define MT_S2_NORMAL		0xf
>  #define MT_S2_DEVICE_nGnRE	0x1
>  
> +#define __TEXT(x)	((x) & ~(UL(1) << 56))
> +#define __VIRT(x)	((x) | (UL(1) << 56))
> +#define __IS_TEXT(x)	(!((x) & (UL(1) << 56)))
> +
>  #ifndef __ASSEMBLY__
>  
>  extern phys_addr_t		memstart_addr;
> @@ -141,9 +145,23 @@ static inline void *phys_to_virt(phys_addr_t x)
>  }
>  
>  /*
> + * Return the physical address of a statically allocated object that
> + * is covered by the kernel Image mapping. We use tagged pointers to
> + * distinguish between the virtual linear and the virtual kimage range.
> + */
> +static inline phys_addr_t __text_to_phys(unsigned long x)
> +{
> +	return __virt_to_phys(__VIRT(x));
> +}

If PAGE_OFFSET is not an immediate value for SUB, you could define a
TEXT_PAGE_OFFSET as __TEXT(PAGE_OFFSET) and avoid the extra "or".

> +
> +/*
>   * Drivers should NOT use these either.
>   */

This existing comment doesn't seem to have any effect. I can see plenty
of drivers using __pa().

> -#define __pa(x)			__virt_to_phys((unsigned long)(x))
> +#define __pa(x)	({					\
> +	unsigned long __x = (unsigned long)(x);		\
> +	__IS_TEXT(__x) ? __text_to_phys(__x) :		\
> +			 __virt_to_phys(__x); })

Could we check where __pa() is actually used on a kernel text address?
If there are only a few such cases, we could avoid this check and create
a specific __kernel_pa(). Same for virt_to_phys(), there are some places
like setting the idmap_pg_dir.

Anyway, if the performance impact is not significant, we can live with
the check here. But I really think we should avoid tagged pointers by
simply splitting the VA space and check one of the bits which is 1 with
kernel text mapping and 0 with the linear mapping (move the kernel high
up).

>  #endif
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 5d9d2dca530d..434ef407ef0f 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -74,7 +74,7 @@ SECTIONS
>  		*(.discard.*)
>  	}
>  
> -	. = PAGE_OFFSET + TEXT_OFFSET;
> +	. = __TEXT(PAGE_OFFSET) + TEXT_OFFSET;

And without tagged pointers, just define something like
KERNEL_PAGE_OFFSET or TEXT_PAGE_OFFSET (I prefer to avoid TEXT since we
have data as well but I'm not really bothered).

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c9267acb699c..43496748e3d9 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -267,7 +267,7 @@ static void *late_alloc(unsigned long size)
>  static void __ref create_mapping(phys_addr_t phys, unsigned long virt,
>  				  phys_addr_t size, pgprot_t prot)
>  {
> -	if (virt < VMALLOC_START) {
> +	if (__VIRT(virt) < VMALLOC_START) {

I don't think we would need __VIRT() without tagged pointers.

-- 
Catalin
