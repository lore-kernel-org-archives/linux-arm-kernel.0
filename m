From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Oct 2015 11:38:27 +0100
Subject: [PATCH 6/6] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
In-Reply-To: <1444655858-26083-7-git-send-email-james.morse@arm.com>
References: <1444655858-26083-1-git-send-email-james.morse@arm.com>
 <1444655858-26083-7-git-send-email-james.morse@arm.com>
Message-ID: <20151022103827.GB23135@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel, Rafael,

On Mon, Oct 12, 2015 at 02:17:38PM +0100, James Morse wrote:

[...]

> +/*
> + * Walk the provided mm's page tables, from start_addr to end_addr. Translate
> + * each page to its alias in the linear map, and clean that to the PoU.
> + * This is safe to call on user-space mm's, as all the access is to page tables
> + * and kernel linear-map addresses.
> + *
> + * Uses __clean_dcache_pou(), which does not provide any barriers or icache
> + * maintenance. Ensure start_addr is page aligned.
> + */
> +static void clean_mapped_range(struct mm_struct *mm, unsigned long start_addr,
> +			       unsigned long end_addr)
> +{
> +	pte_t *pte;
> +	size_t length;
> +	unsigned long map_addr;
> +	unsigned long linear_addr;
> +
> +	for (map_addr = start_addr; map_addr < end_addr; map_addr += length) {
> +		pte = lookup_address(pgd_offset(mm, map_addr), map_addr,
> +				     &length);
> +		/* length is valid, even if pte is NULL */
> +		if (!pte || !pte_valid(*pte))
> +			continue;
> +
> +		linear_addr = (unsigned long)pfn_to_kaddr(pte_pfn(*pte));
> +		__clean_dcache_pou(linear_addr, linear_addr+length);
> +	}
> +}
> +
> +int swsusp_arch_suspend(void)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +	struct task_struct *p;
> +	struct vm_area_struct *vma;
> +	struct sleep_stack_data state;
> +	struct mm_struct *mm = current->active_mm;
> +
> +	local_dbg_save(flags);
> +
> +	if (__cpu_suspend_enter(&state))
> +		ret = swsusp_save();
> +	else {
> +		__cpu_suspend_exit(mm);
> +
> +		pr_info("Performing cache maintenance.\n");
> +
> +		/*
> +		 * We clean the 'tricky' cache ranges here. Modules and user
> +		 * space executable code may have been written to via its
> +		 * alias in the kernel linear mapping.
> +		 *
> +		 * To clean these ranges, we walk the page tables to find the
> +		 * physical pages, and then their position in the linear map.
> +		 *
> +		 * The restore_pblist used during restore only contains pages
> +		 * that were in use - other pages containing executable code
> +		 * may have been written by core hibernate code.
> +		 */
> +		clean_mapped_range(&init_mm, MODULES_VADDR, MODULES_END);
> +
> +		/*
> +		 * Any user space executable code that isn't going to be
> +		 * reloaded from disk (e.g. jit code) is now potentially
> +		 * in the data cache, and needs cleaning.
> +		 *
> +		 * TODO: Some pages are mapped to user-space many times.
> +		 *       Implement a 'cleaned' bitmap so we only clean each
> +		 *       page once.
> +		 */
> +		read_lock(&tasklist_lock);
> +		for_each_process(p) {
> +			if (!p->mm || p->mm == &init_mm)
> +				continue;
> +
> +			down_read(&p->mm->mmap_sem);
> +			for_each_vma(p->mm, vma) {
> +				if (!(vma->vm_flags & VM_EXEC))
> +					continue;
> +
> +				clean_mapped_range(p->mm, vma->vm_start,
> +						   vma->vm_end);
> +			}
> +			up_read(&p->mm->mmap_sem);
> +		}
> +		read_unlock(&tasklist_lock);

After resuming from hibernate in the code above, we are forced to
walk the list of processes to make sure that for executable pages
that were copied by hibernate core code (I mean pages that are not
part of the restore_pblist and were already "restored" by the time
swsusp_arch_resume is called) the I-cache(s) and D-cache(s) are in sync.
We were wondering if you would accept moving that code to hibernate core
code, we see two options for that:

1) Add a cache flushing hook to do_copy_page() in snapshot.c so that
   we can make sure that, if the page in question contains executable
   code (I do not think there is an easy way to detect that though unless
   we walk the processes page tables), the D-cache and I-cache are in-sync
   (the hook might be empty on architectures like x86 where this is not an
   issue)
2) We add code like the loop above in hibernate core code either to
   create a bitmap of pages that need I-cache/D-cache synchronization
   on resume from hibernate (the bitmap can be created at snapshot
   preparation time) or to just do what James does here, basically walk
   the list of processes and call a cache sync hook to make sure I-cache
   and D-caches are in-sync

I do not think that the code above belongs in architecture specific
code since it is an arch-agnostic issue and it is already dealt with
in the kernel with the cache flushing API (eg flush_dcache_page) for
different purposes, I guess hibernate core code does not need this at
present because on x86 it is a non-existing problem.

If you are not opposed to moving this code to hibernate core code
we can put a patch together to deal with this in core code, please
let us know.

Thanks,
Lorenzo

> +
> +		/* page tables may still be cached -how does this affect dma? */
> +
> +		/* all cache cleaning should have finished */
> +		dsb(ish);
> +		__flush_icache_all();
> +	}
> +
> +	local_dbg_restore(flags);
> +
> +	return ret;
> +}
> +
> +static int copy_pte(pmd_t *dst, pmd_t *src, unsigned long start_addr)
> +{
> +	int i;
> +	pte_t *old_pte = pte_offset_kernel(src, start_addr);
> +	pte_t *new_pte = pte_offset_kernel(dst, start_addr);
> +
> +	for (i = pte_index(start_addr); i < PTRS_PER_PTE;
> +	     i++, old_pte++, new_pte++) {
> +		if (pte_val(*old_pte))
> +			set_pte(new_pte,
> +				__pte(pte_val(*old_pte) & ~PTE_RDONLY));
> +	}
> +
> +	return 0;
> +}
> +
> +static int copy_pmd(pud_t *dst, pud_t *src, unsigned long start_addr)
> +{
> +	int i;
> +	int rc = 0;
> +	pte_t *new_pte;
> +	pmd_t *old_pmd = pmd_offset(src, start_addr);
> +	pmd_t *new_pmd = pmd_offset(dst, start_addr);
> +
> +	for (i = pmd_index(start_addr); i < PTRS_PER_PMD;
> +	     i++, start_addr += PMD_SIZE, old_pmd++, new_pmd++) {
> +		if (!pmd_val(*old_pmd))
> +			continue;
> +
> +		if (pmd_table(*(old_pmd))) {
> +			new_pte = (pte_t *)get_safe_page(GFP_ATOMIC);
> +			if (!new_pte) {
> +				rc = -ENOMEM;
> +				break;
> +			}
> +
> +			set_pmd(new_pmd, __pmd(virt_to_phys(new_pte)
> +					       | PMD_TYPE_TABLE));
> +
> +			rc = copy_pte(new_pmd, old_pmd, start_addr);
> +			if (rc)
> +				break;
> +		} else
> +			set_pmd(new_pmd,
> +				__pmd(pmd_val(*old_pmd) & ~PMD_SECT_RDONLY));
> +	}
> +
> +	return rc;
> +}
> +
> +static int copy_pud(pgd_t *dst, pgd_t *src, unsigned long start_addr)
> +{
> +	int i;
> +	int rc = 0;
> +	pmd_t *new_pmd;
> +	pud_t *old_pud = pud_offset(src, start_addr);
> +	pud_t *new_pud = pud_offset(dst, start_addr);
> +
> +	for (i = pud_index(start_addr); i < PTRS_PER_PUD;
> +	     i++, start_addr += PUD_SIZE, old_pud++, new_pud++) {
> +		if (!pud_val(*old_pud))
> +			continue;
> +
> +		if (pud_table(*(old_pud))) {
> +			if (PTRS_PER_PMD != 1) {
> +				new_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +				if (!new_pmd) {
> +					rc = -ENOMEM;
> +					break;
> +				}
> +
> +				set_pud(new_pud, __pud(virt_to_phys(new_pmd)
> +						       | PUD_TYPE_TABLE));
> +			}
> +
> +			rc = copy_pmd(new_pud, old_pud, start_addr);
> +			if (rc)
> +				break;
> +		} else
> +			set_pud(new_pud,
> +				__pud(pud_val(*old_pud) & ~PMD_SECT_RDONLY));
> +	}
> +
> +	return rc;
> +}
> +
> +static int copy_linear_map(pgd_t *new_pgd)
> +{
> +	int i;
> +	int rc = 0;
> +	pud_t *new_pud;
> +	unsigned long start_addr = PAGE_OFFSET;
> +	pgd_t *old_pgd = pgd_offset_k(start_addr);
> +
> +	new_pgd += pgd_index(start_addr);
> +
> +	for (i = pgd_index(start_addr); i < PTRS_PER_PGD;
> +	     i++, start_addr += PGDIR_SIZE, old_pgd++, new_pgd++) {
> +		if (!pgd_val(*old_pgd))
> +			continue;
> +
> +		if (PTRS_PER_PUD != 1) {
> +			new_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +			if (!new_pud) {
> +				rc = -ENOMEM;
> +				break;
> +			}
> +
> +			set_pgd(new_pgd, __pgd(virt_to_phys(new_pud)
> +					       | PUD_TYPE_TABLE));
> +		}
> +
> +		rc = copy_pud(new_pgd, old_pgd, start_addr);
> +		if (rc)
> +			break;
> +	}
> +
> +	return rc;
> +}
> +
> +/*
> + * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
> + *
> + * Memory allocated by get_safe_page() will be dealt with by the hibernate code,
> + * we don't need to free it here.
> + *
> + * Allocate a safe zero page to use as ttbr0, as all existing page tables, and
> + * even the empty_zero_page will be overwritten.
> + */
> +int swsusp_arch_resume(void)
> +{
> +	int rc = 0;
> +	pgd_t *pgd;
> +	size_t length;
> +	size_t exit_size;
> +	pgd_t *tmp_pg_dir;
> +	pte_t *exit_page_pte;
> +	pte_t exit_page_pte_orig;
> +	unsigned long exit_page;
> +	void *safe_zero_page_mem;
> +	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t);
> +
> +	/* Copy swsusp_arch_suspend_exit() to a safe page. */
> +	exit_page = get_safe_page(GFP_ATOMIC);
> +	if (!exit_page) {
> +		pr_err("Failed to allocate memory for hibernate_exit code.");
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
> +	memcpy((void *)exit_page, __hibernate_exit_text_start, exit_size);
> +	flush_icache_range(exit_page, exit_page + exit_size);
> +	if (IS_ENABLED(CONFIG_DEBUG_RODATA)) {
> +		/*
> +		 * set_memory_x() is only for the module ranges. We only have
> +		 * the linear-map mapped - so need to make the copied page
> +		 * executable now, and when we run with the copied page tables.
> +		 * The process of restoring the hibernate kernel will undo
> +		 * this change.
> +		 */
> +		pgd = pgd_offset(&init_mm, exit_page);
> +		exit_page_pte = lookup_address(pgd, exit_page, &length);
> +		if (exit_page_pte) {
> +			exit_page_pte_orig = pte_val(*exit_page_pte);
> +			set_pte_at(&init_mm, exit_page, exit_page_pte,
> +				  __pte(pte_val(*exit_page_pte) & ~PTE_PXN));
> +			flush_tlb_kernel_range(exit_page, exit_page + PAGE_SIZE);
> +		}
> +		else {
> +			pr_err("Failed to find page table entry for hibernate_exit code!");
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +	}
> +	hibernate_exit = (void *)exit_page;
> +
> +	/*
> +	 * Even the zero page may get overwritten during restore.
> +	 * get_safe_page() only returns zero'd pages.
> +	 */
> +	safe_zero_page_mem = (void *)get_safe_page(GFP_ATOMIC);
> +	if (!safe_zero_page_mem) {
> +		pr_err("Failed to allocate memory for zero page.");
> +		rc = -ENOMEM;
> +		goto pte_undo;
> +	}
> +	empty_zero_page = virt_to_page(safe_zero_page_mem);
> +	cpu_set_reserved_ttbr0();
> +
> +	/*
> +	 * Restoring the memory image will overwrite the ttbr1 page tables.
> +	 * Create a second copy, of just the linear map, and use this when
> +	 * restoring.
> +	 */
> +	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!tmp_pg_dir) {
> +		pr_err("Failed to allocate memory for temporary page tables.");
> +		rc = -ENOMEM;
> +		goto pte_undo;
> +	}
> +	rc = copy_linear_map(tmp_pg_dir);
> +	if (rc)
> +		goto pte_undo;
> +
> +	/*
> +	 * EL2 may get upset if we overwrite its page-tables/stack.
> +	 * kvm_reset_cpu() returns EL2 to the hyp stub. This isn't needed
> +	 * on normal suspend/resume as PSCI prevents us from ruining EL2.
> +	 */
> +	if (IS_ENABLED(CONFIG_KVM_ARM_HOST))
> +		kvm_reset_cpu();
> +
> +	hibernate_exit(virt_to_phys(tmp_pg_dir), virt_to_phys(swapper_pg_dir));
> +
> +pte_undo:
> +	if (IS_ENABLED(CONFIG_DEBUG_RODATA)) {
> +		set_pte_at(&init_mm, exit_page, exit_page_pte,
> +			   exit_page_pte_orig);
> +		flush_tlb_kernel_range(exit_page, exit_page + PAGE_SIZE);
> +	}
> +out:
> +	return rc;
> +}
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index da4405062d83..f58008d6dadf 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -2,6 +2,7 @@
>  #include <linux/linkage.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/assembler.h>
> +#include <asm/memory.h>
>  
>  	.text
>  /*
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 98073332e2d0..3d8284d91f4c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -44,6 +44,16 @@ jiffies = jiffies_64;
>  	*(.idmap.text)					\
>  	VMLINUX_SYMBOL(__idmap_text_end) = .;
>  
> +#ifdef CONFIG_HIBERNATION
> +#define HIBERNATE_TEXT					\
> +	. = ALIGN(SZ_4K);				\
> +	VMLINUX_SYMBOL(__hibernate_exit_text_start) = .;\
> +	*(.hibernate_exit.text)				\
> +	VMLINUX_SYMBOL(__hibernate_exit_text_end) = .;
> +#else
> +#define HIBERNATE_TEXT
> +#endif
> +
>  /*
>   * The size of the PE/COFF section that covers the kernel image, which
>   * runs from stext to _edata, must be a round multiple of the PE/COFF
> @@ -102,6 +112,7 @@ SECTIONS
>  			LOCK_TEXT
>  			HYPERVISOR_TEXT
>  			IDMAP_TEXT
> +			HIBERNATE_TEXT
>  			*(.fixup)
>  			*(.gnu.warning)
>  		. = ALIGN(16);
> @@ -181,6 +192,10 @@ ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
>  	"HYP init code too big or misaligned")
>  ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
>  	"ID map text too big or misaligned")
> +#ifdef CONFIG_HIBERNATION
> +ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
> +	<= SZ_4K, "Hibernate exit text too big or misaligned")
> +#endif
>  
>  /*
>   * If padding is applied before .head.text, virt<->phys conversions will fail.
> -- 
> 2.1.4
> 
