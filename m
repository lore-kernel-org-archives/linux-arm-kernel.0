From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Sep 2018 14:34:37 +0100
Subject: [PATCH v5 3/6] arm64/mm: Create the initial page table in the
 init_pg_dir.
In-Reply-To: <20180917044333.30051-4-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-4-yaojun8558363@gmail.com>
Message-ID: <20180924133437.zr2u5c42rfmhro6o@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 12:43:30PM +0800, Jun Yao wrote:
> Create the initial page table in the init_pg_dir. And update the
> init_mm.pgd to make sure that pgd_offset_k() works correctly. When
> the final page table is created, we redirect the init_mm.pgd to the
> swapper_pg_dir.
> 
> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 2 ++
>  arch/arm64/kernel/asm-offsets.c  | 1 +
>  arch/arm64/kernel/head.S         | 9 +++++++--
>  arch/arm64/mm/mmu.c              | 1 +
>  4 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2ab2031b778c..b11d6fc62a62 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -718,6 +718,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +extern pgd_t init_pg_dir[PTRS_PER_PGD];
> +extern pgd_t init_pg_end[];
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  extern pgd_t swapper_pg_end[];
>  extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 323aeb5f2fe6..43f52cfdfad4 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -82,6 +82,7 @@ int main(void)
>    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
>    BLANK();
>    DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
> +  DEFINE(MM_PGD,		offsetof(struct mm_struct, pgd));
>    BLANK();
>    DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
>    DEFINE(VMA_VM_FLAGS,		offsetof(struct vm_area_struct, vm_flags));
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index de2aaea00bd2..cf8a58211b80 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -376,7 +376,7 @@ __create_page_tables:
>  	/*
>  	 * Map the kernel image (starting with PHYS_OFFSET).
>  	 */
> -	adrp	x0, swapper_pg_dir
> +	adrp	x0, init_pg_dir
>  	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
>  	add	x5, x5, x23			// add KASLR displacement
>  	mov	x4, PTRS_PER_PGD
> @@ -439,6 +439,11 @@ __primary_switched:
>  	bl	__pi_memset
>  	dsb	ishst				// Make zero page visible to PTW
>  
> +	// Update init_mm.pgd
> +	adrp	x0, init_pg_dir
> +	adr_l	x1, init_mm
> +	str	x0, [x1, #MM_PGD]
> +

We should be able to set this up statically with INIT_MM_CONTEXT(). i.e.
in <asm/mmu.h> have:

#define INIT_MM_CONTEXT(name)	\
	.pgd = init_pg_dir

Thanks,
Mark.

>  #ifdef CONFIG_KASAN
>  	bl	kasan_early_init
>  #endif
> @@ -833,7 +838,7 @@ __primary_switch:
>  	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
>  #endif
>  
> -	adrp	x1, swapper_pg_dir
> +	adrp	x1, init_pg_dir
>  	bl	__enable_mmu
>  #ifdef CONFIG_RELOCATABLE
>  	bl	__relocate_kernel
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 65f86271f02b..af80dca335ce 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -646,6 +646,7 @@ void __init paging_init(void)
>  	cpu_replace_ttbr1(__va(pgd_phys));
>  	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
>  	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
> +	init_mm.pgd = swapper_pg_dir;
>  
>  	pgd_clear_fixmap();
>  	memblock_free(pgd_phys, PAGE_SIZE);
> -- 
> 2.17.1
> 
