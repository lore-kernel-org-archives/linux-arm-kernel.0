From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Mar 2015 01:27:06 +0000
Subject: [PATCH 1/4] arm64: use tagged pointers to distinguish kernel
 text from the linear mapping
In-Reply-To: <1427125016-3873-2-git-send-email-ard.biesheuvel@linaro.org>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150326012706.GC1676@flaeskesteg-linux.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, Mar 23, 2015 at 03:36:53PM +0000, Ard Biesheuvel wrote:
> This enables tagged pointers for kernel addresses, and uses it to
> tag statically allocated kernel objects. This allows us to use a
> separate translation regime for kernel text in the next patch.

If I've understood correctly, the tag is just to optimize virt_to_phys (using a
bit test rather than VA boundary comparisons), no? Or does the tag allow for
something else that I've missed?

If that is the case, can we not reorganise the kernel VA layout such that we
can use (1 << (VA_BITS - 1)) instead (i.e. check if we're above or below
PAGE_OFFSET) to distinguish the linear mapping form the text mapping?

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/memory.h        | 20 +++++++++++++++++++-
>  arch/arm64/include/asm/pgtable-hwdef.h |  1 +
>  arch/arm64/kernel/vmlinux.lds.S        |  4 ++--
>  arch/arm64/mm/mmu.c                    |  4 ++--
>  arch/arm64/mm/proc.S                   |  3 ++-
>  5 files changed, 26 insertions(+), 6 deletions(-)
> 
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
> +
> +/*
>   * Drivers should NOT use these either.
>   */
> -#define __pa(x)			__virt_to_phys((unsigned long)(x))
> +#define __pa(x)	({					\
> +	unsigned long __x = (unsigned long)(x);		\
> +	__IS_TEXT(__x) ? __text_to_phys(__x) :		\
> +			 __virt_to_phys(__x); })

Do we have an idea what the overhead of this is over a plain __virt_to_phys?

If it's noticeable, we might want to convert some users (eg arm64/mm) to use
__virt_to_phys / __text_to_phys exclusively. For mm that would require some
init code to figure out linear map pointers for the idmap and swapper from the
text map pointers.

Mark.

> +
>  #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>  #define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys(x))
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 5f930cc9ea83..8bcec4e626b4 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -163,5 +163,6 @@
>  #define TCR_TG1_64K		(UL(3) << 30)
>  #define TCR_ASID16		(UL(1) << 36)
>  #define TCR_TBI0		(UL(1) << 37)
> +#define TCR_TBI1		(UL(1) << 38)
>  
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
>  
>  	.head.text : {
>  		_text = .;
> @@ -171,4 +171,4 @@ ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) > __hyp_idmap_text_end),
>  /*
>   * If padding is applied before .head.text, virt<->phys conversions will fail.
>   */
> -ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
> +ASSERT(_text == (__TEXT(PAGE_OFFSET) + TEXT_OFFSET), "HEAD is misaligned")
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
>  		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
>  			&phys, virt);
>  		return;
> @@ -287,7 +287,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  static void create_mapping_late(phys_addr_t phys, unsigned long virt,
>  				  phys_addr_t size, pgprot_t prot)
>  {
> -	if (virt < VMALLOC_START) {
> +	if (__VIRT(virt) < VMALLOC_START) {
>  		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
>  			&phys, virt);
>  		return;
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 28eebfb6af76..7f2d7f73bc93 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -232,7 +232,8 @@ ENTRY(__cpu_setup)
>  	 * both user and kernel.
>  	 */
>  	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
> -			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
> +			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_TBI1
> +
>  	/*
>  	 * Read the PARange bits from ID_AA64MMFR0_EL1 and set the IPS bits in
>  	 * TCR_EL1.
> -- 
> 1.8.3.2
> 
> 
