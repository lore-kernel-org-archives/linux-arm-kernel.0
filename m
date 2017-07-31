From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 31 Jul 2017 11:24:14 +0100
Subject: [PATCH] arm64: mmu: Place guard page after mapping of kernel image
In-Reply-To: <1501175035-32460-1-git-send-email-will.deacon@arm.com>
References: <1501175035-32460-1-git-send-email-will.deacon@arm.com>
Message-ID: <20170731102414.GB21287@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 06:03:55PM +0100, Will Deacon wrote:
> The vast majority of virtual allocations in the vmalloc region are followed
> by a guard page, which can help to avoid overruning on vma into another,
> which may map a read-sensitive device.
> 
> This patch adds a guard page to the end of the kernel image mapping (i.e.
> following the data/bss segments).
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Looks sane to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/mm/mmu.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 23c2d89a362e..f1eb15e0e864 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -496,7 +496,7 @@ void mark_rodata_ro(void)
>  
>  static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
>  				      pgprot_t prot, struct vm_struct *vma,
> -				      int flags)
> +				      int flags, unsigned long vm_flags)
>  {
>  	phys_addr_t pa_start = __pa_symbol(va_start);
>  	unsigned long size = va_end - va_start;
> @@ -507,10 +507,13 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
>  	__create_pgd_mapping(pgd, pa_start, (unsigned long)va_start, size, prot,
>  			     early_pgtable_alloc, flags);
>  
> +	if (!(vm_flags & VM_NO_GUARD))
> +		size += PAGE_SIZE;
> +
>  	vma->addr	= va_start;
>  	vma->phys_addr	= pa_start;
>  	vma->size	= size;
> -	vma->flags	= VM_MAP;
> +	vma->flags	= VM_MAP | vm_flags;
>  	vma->caller	= __builtin_return_address(0);
>  
>  	vm_area_add_early(vma);
> @@ -541,14 +544,15 @@ static void __init map_kernel(pgd_t *pgd)
>  	 * Only rodata will be remapped with different permissions later on,
>  	 * all other segments are allowed to use contiguous mappings.
>  	 */
> -	map_kernel_segment(pgd, _text, _etext, text_prot, &vmlinux_text, 0);
> +	map_kernel_segment(pgd, _text, _etext, text_prot, &vmlinux_text, 0,
> +			   VM_NO_GUARD);
>  	map_kernel_segment(pgd, __start_rodata, __inittext_begin, PAGE_KERNEL,
> -			   &vmlinux_rodata, NO_CONT_MAPPINGS);
> +			   &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
>  	map_kernel_segment(pgd, __inittext_begin, __inittext_end, text_prot,
> -			   &vmlinux_inittext, 0);
> +			   &vmlinux_inittext, 0, VM_NO_GUARD);
>  	map_kernel_segment(pgd, __initdata_begin, __initdata_end, PAGE_KERNEL,
> -			   &vmlinux_initdata, 0);
> -	map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data, 0);
> +			   &vmlinux_initdata, 0, VM_NO_GUARD);
> +	map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
>  
>  	if (!pgd_val(*pgd_offset_raw(pgd, FIXADDR_START))) {
>  		/*
> -- 
> 2.1.4
> 
