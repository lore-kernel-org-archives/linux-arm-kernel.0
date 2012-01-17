From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 17 Jan 2012 14:11:14 -0500 (EST)
Subject: [PATCH v2] ARM: vectors: use gate_vma for vectors user mapping
In-Reply-To: <1326819020-5004-1-git-send-email-will.deacon@arm.com>
References: <1326819020-5004-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1201171410250.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2012, Will Deacon wrote:

> The current user mapping for the vectors page is inserted as a `horrible
> hack vma' into each task via arch_setup_additional_pages. This causes
> problems with the MM subsystem and vm_normal_page, as described here:
> 
> https://lkml.org/lkml/2012/1/14/55
> 
> Following the suggestion from Hugh in the above thread, this patch uses
> the gate_vma for the vectors user mapping, therefore consolidating
> the horrible hack VMAs into one.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Nicolas Pitre <nico@linaro.org>

> ---
> 
> v2: Removed old arch_{exit,dup}_mmap implementations for ARM.
>     Tested on vexpress (ctca9x4), PB1176 and AB926.
> 
>  arch/arm/include/asm/elf.h         |    4 ---
>  arch/arm/include/asm/mmu_context.h |   29 +--------------------------
>  arch/arm/include/asm/page.h        |    2 +
>  arch/arm/kernel/process.c          |   38 ++++++++++++++++++++++++++---------
>  4 files changed, 31 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> index 0e9ce8d..38050b1 100644
> --- a/arch/arm/include/asm/elf.h
> +++ b/arch/arm/include/asm/elf.h
> @@ -130,8 +130,4 @@ struct mm_struct;
>  extern unsigned long arch_randomize_brk(struct mm_struct *mm);
>  #define arch_randomize_brk arch_randomize_brk
>  
> -extern int vectors_user_mapping(void);
> -#define arch_setup_additional_pages(bprm, uses_interp) vectors_user_mapping()
> -#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
> -
>  #endif
> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
> index 71605d9..a0b3cac 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -18,6 +18,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cachetype.h>
>  #include <asm/proc-fns.h>
> +#include <asm-generic/mm_hooks.h>
>  
>  void __check_kvm_seq(struct mm_struct *mm);
>  
> @@ -133,32 +134,4 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  #define deactivate_mm(tsk,mm)	do { } while (0)
>  #define activate_mm(prev,next)	switch_mm(prev, next, NULL)
>  
> -/*
> - * We are inserting a "fake" vma for the user-accessible vector page so
> - * gdb and friends can get to it through ptrace and /proc/<pid>/mem.
> - * But we also want to remove it before the generic code gets to see it
> - * during process exit or the unmapping of it would  cause total havoc.
> - * (the macro is used as remove_vma() is static to mm/mmap.c)
> - */
> -#define arch_exit_mmap(mm) \
> -do { \
> -	struct vm_area_struct *high_vma = find_vma(mm, 0xffff0000); \
> -	if (high_vma) { \
> -		BUG_ON(high_vma->vm_next);  /* it should be last */ \
> -		if (high_vma->vm_prev) \
> -			high_vma->vm_prev->vm_next = NULL; \
> -		else \
> -			mm->mmap = NULL; \
> -		rb_erase(&high_vma->vm_rb, &mm->mm_rb); \
> -		mm->mmap_cache = NULL; \
> -		mm->map_count--; \
> -		remove_vma(high_vma); \
> -	} \
> -} while (0)
> -
> -static inline void arch_dup_mmap(struct mm_struct *oldmm,
> -				 struct mm_struct *mm)
> -{
> -}
> -
>  #endif
> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
> index 97b440c..5838361 100644
> --- a/arch/arm/include/asm/page.h
> +++ b/arch/arm/include/asm/page.h
> @@ -151,6 +151,8 @@ extern void __cpu_copy_user_highpage(struct page *to, struct page *from,
>  #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
>  extern void copy_page(void *to, const void *from);
>  
> +#define __HAVE_ARCH_GATE_AREA 1
> +
>  #ifdef CONFIG_ARM_LPAE
>  #include <asm/pgtable-3level-types.h>
>  #else
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 971d65c..e11b523 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -526,22 +526,40 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
>  #ifdef CONFIG_MMU
>  /*
>   * The vectors page is always readable from user space for the
> - * atomic helpers and the signal restart code.  Let's declare a mapping
> - * for it so it is visible through ptrace and /proc/<pid>/mem.
> + * atomic helpers and the signal restart code. Insert it into the
> + * gate_vma so that it is visible through ptrace and /proc/<pid>/mem.
>   */
> +static struct vm_area_struct gate_vma;
>  
> -int vectors_user_mapping(void)
> +static int __init gate_vma_init(void)
>  {
> -	struct mm_struct *mm = current->mm;
> -	return install_special_mapping(mm, 0xffff0000, PAGE_SIZE,
> -				       VM_READ | VM_EXEC |
> -				       VM_MAYREAD | VM_MAYEXEC |
> -				       VM_ALWAYSDUMP | VM_RESERVED,
> -				       NULL);
> +	gate_vma.vm_start	= 0xffff0000;
> +	gate_vma.vm_end		= 0xffff0000 + PAGE_SIZE;
> +	gate_vma.vm_page_prot	= PAGE_READONLY_EXEC;
> +	gate_vma.vm_flags	= VM_READ | VM_EXEC |
> +				  VM_MAYREAD | VM_MAYEXEC |
> +				  VM_ALWAYSDUMP;
> +	return 0;
> +}
> +arch_initcall(gate_vma_init);
> +
> +struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
> +{
> +	return &gate_vma;
> +}
> +
> +int in_gate_area(struct mm_struct *mm, unsigned long addr)
> +{
> +	return (addr >= gate_vma.vm_start) && (addr < gate_vma.vm_end);
> +}
> +
> +int in_gate_area_no_mm(unsigned long addr)
> +{
> +	return in_gate_area(NULL, addr);
>  }
>  
>  const char *arch_vma_name(struct vm_area_struct *vma)
>  {
> -	return (vma->vm_start == 0xffff0000) ? "[vectors]" : NULL;
> +	return (vma == &gate_vma) ? "[vectors]" : NULL;
>  }
>  #endif
> -- 
> 1.7.4.1
> 
