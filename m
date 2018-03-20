From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Mar 2018 03:33:33 +0000
Subject: [RFC PATCH 1/6] arm64/mm: add explicit physical address argument
 to map_kernel_segment
In-Reply-To: <20180319111958.4171-2-ard.biesheuvel@linaro.org>
References: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
 <20180319111958.4171-2-ard.biesheuvel@linaro.org>
Message-ID: <20180320033323.kyjgtbzxc3vjpars@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 07:19:53PM +0800, Ard Biesheuvel wrote:
> In preparation of mapping a physically non-adjacent memory region
> as backing for the vmlinux segment covering the trampoline and primary
> level swapper_pg_dir regions, make the physical address an explicit
> argument of map_kernel_segment().
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/mmu.c | 22 ++++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8c704f1e53c2..007b2e32ca71 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -507,10 +507,10 @@ void mark_rodata_ro(void)
>  }
>  
>  static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
> -				      pgprot_t prot, struct vm_struct *vma,
> -				      int flags, unsigned long vm_flags)
> +				      phys_addr_t pa_start, pgprot_t prot,
> +				      struct vm_struct *vma, int flags,
> +				      unsigned long vm_flags)
>  {
> -	phys_addr_t pa_start = __pa_symbol(va_start);
>  	unsigned long size = va_end - va_start;
>  
>  	BUG_ON(!PAGE_ALIGNED(pa_start));

How about we rename this to __map_kernel_segment(), and have a
map_kernel_segment wrapper that does the __pa_symbol() stuff?

That would avoid some redundancy in map_kernel(), and when we can use
__map_kernel_segment() for the trampoline bits.

Thanks,
Mark.

> @@ -585,15 +585,19 @@ static void __init map_kernel(pgd_t *pgdp)
>  	 * Only rodata will be remapped with different permissions later on,
>  	 * all other segments are allowed to use contiguous mappings.
>  	 */
> -	map_kernel_segment(pgdp, _text, _etext, text_prot, &vmlinux_text, 0,
> -			   VM_NO_GUARD);
> -	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,
> +	map_kernel_segment(pgdp, _text, _etext, __pa_symbol(_text), text_prot,
> +			   &vmlinux_text, 0, VM_NO_GUARD);
> +	map_kernel_segment(pgdp, __start_rodata, __inittext_begin,
> +			   __pa_symbol(__start_rodata), PAGE_KERNEL,
>  			   &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
> -	map_kernel_segment(pgdp, __inittext_begin, __inittext_end, text_prot,
> +	map_kernel_segment(pgdp, __inittext_begin, __inittext_end,
> +			   __pa_symbol(__inittext_begin), text_prot,
>  			   &vmlinux_inittext, 0, VM_NO_GUARD);
> -	map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
> +	map_kernel_segment(pgdp, __initdata_begin, __initdata_end,
> +			   __pa_symbol(__initdata_begin), PAGE_KERNEL,
>  			   &vmlinux_initdata, 0, VM_NO_GUARD);
> -	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
> +	map_kernel_segment(pgdp, _data, _end, __pa_symbol(_data), PAGE_KERNEL,
> +			   &vmlinux_data, 0, 0);
>  
>  	if (!READ_ONCE(pgd_val(*pgd_offset_raw(pgdp, FIXADDR_START)))) {
>  		/*
> -- 
> 2.11.0
> 
