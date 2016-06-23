From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Jun 2016 12:40:07 +0100
Subject: [PATCH] arm64: mm: fix location of _etext
In-Reply-To: <1466678792-7971-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1466678792-7971-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160623114006.GB8836@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> As Kees Cook notes in the ARM counterpart of this patch [0]:
> 
>   The _etext position is defined to be the end of the kernel text code,
>   and should not include any part of the data segments. This interferes
>   with things that might check memory ranges and expect executable code
>   up to _etext.
> 
> In particular, Kees is referring to the HARDENED_USERCOPY patch set [1],
> which rejects attempts to call copy_to_user() on kernel ranges containing
> executable code, but does allow access to the .rodata segment. Regardless
> of whether one may or may not agree with the distinction, it makes sense
> for _etext to have the same meaning across architectures.

I certainly agree with this.

> So let's put _etext where it belongs, between .text and .rodata, and fix
> up existing references to use __init_begin instead, which, unlike
> __end_rodata, includes the exception and notes sections as well.
> 
> The _etext references in kaslr.c are left untouched, since its references
> to [_stext, _etext) are meant to capture potential jump instruction targets,
> and so disregarding .rodata is actually an improvement here.
> 
> [0] http://article.gmane.org/gmane.linux.kernel/2245084
> [1] http://thread.gmane.org/gmane.linux.kernel.hardened.devel/2502
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/setup.c       |  4 ++--
>  arch/arm64/kernel/vmlinux.lds.S |  7 ++++---
>  arch/arm64/mm/init.c            |  4 ++--
>  arch/arm64/mm/mmu.c             | 16 ++++++++--------
>  4 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 3279defabaa2..f8b4837d1805 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -202,7 +202,7 @@ static void __init request_standard_resources(void)
>  	struct resource *res;
>  
>  	kernel_code.start   = virt_to_phys(_text);
> -	kernel_code.end     = virt_to_phys(_etext - 1);
> +	kernel_code.end     = virt_to_phys(__init_begin - 1);
>  	kernel_data.start   = virt_to_phys(_sdata);
>  	kernel_data.end     = virt_to_phys(_end - 1);

Given that these resources are coarse to begin with, I guess it doesn't
matter that we're capturing rodata friends here, and this retains the
existing behaviour.

> @@ -232,7 +232,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	sprintf(init_utsname()->machine, ELF_PLATFORM);
>  	init_mm.start_code = (unsigned long) _text;
> -	init_mm.end_code   = (unsigned long) _etext;
> +	init_mm.end_code   = (unsigned long) __init_begin;

Why does this need to be __init_begin?

We don't have code in .rodata, the exception tables, or notes, so
shouldn't this be left pointing at _etext if we're tightening things up?

>  	init_mm.end_data   = (unsigned long) _edata;
>  	init_mm.brk	   = (unsigned long) _end;
>  
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 435e820e898d..0de7be4f1a9d 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -131,12 +131,13 @@ SECTIONS
>  	}
>  
>  	. = ALIGN(SEGMENT_ALIGN);
> -	RO_DATA(PAGE_SIZE)		/* everything from this point to */
> -	EXCEPTION_TABLE(8)		/* _etext will be marked RO NX   */
> +	_etext = .;			/* End of text section */
> +
> +	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
> +	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
>  	NOTES
>  
>  	. = ALIGN(SEGMENT_ALIGN);
> -	_etext = .;			/* End of text and rodata section */
>  	__init_begin = .;
>  
>  	INIT_TEXT_SECTION(8)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d45f8627012c..7bc5bed0220a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -430,9 +430,9 @@ void __init mem_init(void)
>  	pr_cont("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
>  		MLG(VMALLOC_START, VMALLOC_END));
>  	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
> -		MLK_ROUNDUP(_text, __start_rodata));
> +		MLK_ROUNDUP(_text, _etext));
>  	pr_cont("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
> -		MLK_ROUNDUP(__start_rodata, _etext));
> +		MLK_ROUNDUP(__start_rodata, __init_begin));
>  	pr_cont("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>  		MLK_ROUNDUP(__init_begin, __init_end));
>  	pr_cont("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 0f85a46c3e18..a263a5d19bd9 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -386,7 +386,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
>  static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
>  {
>  	unsigned long kernel_start = __pa(_text);
> -	unsigned long kernel_end = __pa(_etext);
> +	unsigned long kernel_end = __pa(__init_begin);
>  
>  	/*
>  	 * Take care not to create a writable alias for the
> @@ -417,7 +417,7 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
>  				     early_pgtable_alloc);
>  
>  	/*
> -	 * Map the linear alias of the [_text, _etext) interval as
> +	 * Map the linear alias of the [_text, __init_begin) interval as
>  	 * read-only/non-executable. This makes the contents of the
>  	 * region accessible to subsystems such as hibernate, but
>  	 * protects it from inadvertent modification or execution.

There are a couple of comments regarding overlap that are probably worth
updating to say "text + rodata" rather than "text". Strictly speaking
they're already slightly wrong, but this is a good opportunity to fix
them up.

> @@ -449,14 +449,14 @@ void mark_rodata_ro(void)
>  {
>  	unsigned long section_size;
>  
> -	section_size = (unsigned long)__start_rodata - (unsigned long)_text;
> +	section_size = (unsigned long)_etext - (unsigned long)_text;
>  	create_mapping_late(__pa(_text), (unsigned long)_text,
>  			    section_size, PAGE_KERNEL_ROX);
>  	/*
> -	 * mark .rodata as read only. Use _etext rather than __end_rodata to
> -	 * cover NOTES and EXCEPTION_TABLE.
> +	 * mark .rodata as read only. Use __init_begin rather than __end_rodata
> +	 * to cover NOTES and EXCEPTION_TABLE.
>  	 */
> -	section_size = (unsigned long)_etext - (unsigned long)__start_rodata;
> +	section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
>  	create_mapping_late(__pa(__start_rodata), (unsigned long)__start_rodata,
>  			    section_size, PAGE_KERNEL_RO);
>  }
> @@ -499,8 +499,8 @@ static void __init map_kernel(pgd_t *pgd)
>  {
>  	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init, vmlinux_data;
>  
> -	map_kernel_segment(pgd, _text, __start_rodata, PAGE_KERNEL_EXEC, &vmlinux_text);
> -	map_kernel_segment(pgd, __start_rodata, _etext, PAGE_KERNEL, &vmlinux_rodata);
> +	map_kernel_segment(pgd, _text, _etext, PAGE_KERNEL_EXEC, &vmlinux_text);
> +	map_kernel_segment(pgd, __start_rodata, __init_begin, PAGE_KERNEL, &vmlinux_rodata);
>  	map_kernel_segment(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
>  			   &vmlinux_init);
>  	map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data);
> -- 
> 2.7.4
> 

Other than the above, this looks good to me!

Thanks,
Mark.
