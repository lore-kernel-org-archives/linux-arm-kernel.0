From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 11:29:54 +0100
Subject: [PATCH v7 15/16] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1459529620-22150-16-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-16-git-send-email-james.morse@arm.com>
Message-ID: <20160422102954.GB2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, Apr 01, 2016 at 05:53:39PM +0100, James Morse wrote:
> --- /dev/null
> +++ b/arch/arm64/kernel/hibernate-asm.S

[...]

> +ENTRY(swsusp_arch_suspend_exit)
> +	/* Temporary page tables are a copy, so no need for a trampoline here */
> +	msr	ttbr1_el1, x0
> +	isb
> +	tlbi	vmalle1is	/* invalidate intermediate caching entries */
> +	dsb	ish
> +
> +	mov	x21, x1
> +	mov	x30, x2		/* el2_setup() will eret to the lr directly */
> +	mov	x24, x4
> +	mov	x25, x5
> +
> +	/* walk the restore_pblist and use copy_page() to over-write memory */
> +	mov	x19, x3
> +
> +1:	ldr	x10, [x19, #HIBERN_PBE_ORIG]
> +	mov	x0, x10
> +	ldr	x1, [x19, #HIBERN_PBE_ADDR]
> +
> +	copy_page	x0, x1, x2, x3, x4, x5, x6, x7, x8, x9
> +
> +	add	x1, x10, #PAGE_SIZE
> +	/* Clean the copied page to PoU - based on flush_icache_range() */
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x4, x10, x3
> +2:	dc	cvau, x4	/* clean D line / unified line */
> +	add	x4, x4, x2
> +	cmp	x4, x1
> +	b.lo	2b
> +
> +	ldr	x19, [x19, #HIBERN_PBE_NEXT]
> +	cbnz	x19, 1b
> +
> +
> +	/* switch to the restored kernels page tables, to reconfigure el2 */
> +	msr	ttbr1_el1, x21  /* physical address of swapper page tables */
> +	isb
> +	tlbi	vmalle1is	/* invalidate intermediate caching entries */
> +	ic	ialluis
> +	dsb	ish		/* also waits for PoU cleaning to finish */
> +	isb

The waiting for PoU cleaning needs to happen before the IC instruction.

> +
> +
> +	cbz	x24, 4f		/* Did we boot at el1? */
> +	/* Clean el2_setup's page to PoC */
> +	mov	x0, x24
> +	/*
> +	 * We don't know if el2_setup() overlaps a page boundary, clean two
> +	 * pages, just in case.
> +	 */
> +	add	x1, x0, #2*PAGE_SIZE
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x4, x0, x3
> +3:	dc	cvac, x4
> +	add	x4, x4, x2
> +	cmp	x4, x1
> +	b.lo	3b
> +
> +	/* reconfigure el2 */
> +	mrs	x0, sctlr_el1
> +	hvc	#0
> +
> +	/*
> +	 * el2_setup() will eret to the location in x30, so we
> +	 * only get here if we booted at el1.
> +	 */
> +
> +4:	ret
> +
> +	.ltorg
> +ENDPROC(swsusp_arch_suspend_exit)

[...]

> --- /dev/null
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -0,0 +1,503 @@

[...]

> +/* Find a symbols alias in the linear map */
> +#define LMADDR(x)	phys_to_virt(virt_to_phys(x))

IIRC Ard was looking to add a specific macro in his subsequent KASLR
clean-up patches but I haven't checked the latest status.

[...]

> +/*
> + * Copies length bytes, starting at src_start into an new page,
> + * perform cache maintentance, then map it (nearly) at the bottom of memory
> + * as executable.
> + *
> + * This is used by hibernate to copy the code it needs to execute when
> + * overwriting the kernel text. This function generates a new set of page
> + * tables, which it loads into ttbr0.
> + *
> + * Length is provided as we probably only want 4K of data, even on a 64K
> + * page system. We don't use the very bottom page, so that dereferencing
> + * NULL continues to have the expected behaviour.
> + */
> +static int create_safe_exec_page(void *src_start, size_t length,
> +				 void **dst_addr, phys_addr_t *phys_dst_addr,
> +				 unsigned long (*allocator)(gfp_t mask),
> +				 gfp_t mask)
> +{
> +	int rc = 0;
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	unsigned long dst = allocator(mask);
> +
> +	if (!dst) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy((void *)dst, src_start, length);
> +	flush_icache_range(dst, dst + length);
> +
> +	pgd = (pgd_t *)allocator(mask) + pgd_index(PAGE_SIZE);

You could use pgd_offset_raw((pgd_t *)allocator(mask), PAGE_SIZE) (or
use two separate lines for allocation and offset in case of -ENOMEM).

BTW, can we have the allocator return type (void *) to avoid extra
casting?

> +	if (PTRS_PER_PGD > 1) {

I think you can use pgd_none(*pgd) here. In the nopud case, this would
be 0. I'm also not sure PTRS_PER_PGD is even correct here in the nopud
case where we don't need to allocate a pud but PTRS_PER_PGD is always
greater than 1.

> +		pud = (pud_t *)allocator(mask);
> +		if (!pud) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		set_pgd(pgd, __pgd(virt_to_phys(pud) | PUD_TYPE_TABLE));
> +	}
> +
> +	pud = pud_offset(pgd, PAGE_SIZE);
> +	if (PTRS_PER_PUD > 1) {

pud_none()

> +		pmd = (pmd_t *)allocator(mask);
> +		if (!pmd) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		set_pud(pud, __pud(virt_to_phys(pmd) | PUD_TYPE_TABLE));
> +	}
> +
> +	pmd = pmd_offset(pud, PAGE_SIZE);
> +	if (PTRS_PER_PMD > 1) {

pmd_none()

> +		pte = (pte_t *)allocator(mask);
> +		if (!pte) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		set_pmd(pmd, __pmd(virt_to_phys(pte) | PMD_TYPE_TABLE));
> +	}
> +
> +	pte = pte_offset_kernel(pmd, PAGE_SIZE);
> +	set_pte_at(&init_mm, dst, pte,
> +		   __pte(virt_to_phys((void *)dst) |
> +			 pgprot_val(PAGE_KERNEL_EXEC)));

I would use set_pte() rather than the *_at variant here as that one has
some side-effects. The alloc_init_pte() and fixmap code only use
set_pte().

> +
> +	/* Load our new page tables */
> +	asm volatile("msr	ttbr0_el1, %0;"
> +		     "isb;"
> +		     "tlbi	vmalle1is;"
> +		     "dsb	ish" : : "r"(virt_to_phys(pgd)));

Do we expect anything to have used ttbr0_el1 at this point? I think the
TLB for the low addresses should have already been invalidated
immediately after boot and we wouldn't run any user space at this point.

> +
> +	*dst_addr = (void *)(PAGE_SIZE);
> +	*phys_dst_addr = virt_to_phys((void *)dst);

More of a nitpick but you could set *dst_addr or a local variable (e.g.
vaddr) to PAGE_SIZE at the beginning of this function to make it clear
that this is the VA we picked for. Seeing PAGE_SIZE in several places
makes me think why we pass a "size" argument to those pte/pmd/pud
macros.

Even better, can we not just set this address in the caller of this
function (swsusp_arch_resume)? I find this **dst_addr argument passing
unnecessary since everything is contained in this file.

> +
> +out:
> +	return rc;
> +}
> +
> +
> +int swsusp_arch_suspend(void)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +	struct sleep_stack_data state;
> +
> +	local_dbg_save(flags);
> +
> +	if (__cpu_suspend_enter(&state)) {
> +		ret = swsusp_save();
> +	} else {
> +		void *lm_kernel_start;
> +
> +		/* Clean kernel to PoC for secondary core startup */
> +		lm_kernel_start = LMADDR(KERNEL_START);
> +		__flush_dcache_area(lm_kernel_start, KERNEL_END - KERNEL_START);

We don't need to use LMADDR here. The KERNEL_START is already mapped at
the caches are PIPT (-like), so flushing any of the aliases would do.

But I'm not sure we even need to flush the whole kernel. The secondary
cores would only execute certain areas before they enable the MMU, at
which point they have visibility over the whole cache. Is this needed
for secondary core startup on resume from hibernate?

[...]

> +static int copy_pud(pgd_t *dst_pgd, pgd_t *src_pgd, unsigned long start,
> +		    unsigned long end)
> +{
> +	int rc = 0;
> +	pmd_t *dst_pmd;
> +	unsigned long next;
> +	unsigned long addr = start;
> +	pud_t *src_pud = pud_offset(src_pgd, start);
> +	pud_t *dst_pud = pud_offset(dst_pgd, start);
> +
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (!pud_val(*src_pud))
> +			continue;
> +
> +		if (pud_table(*(src_pud))) {
> +			if (PTRS_PER_PMD != 1) {
> +				dst_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +				if (!dst_pmd) {
> +					rc = -ENOMEM;
> +					break;
> +				}
> +
> +				set_pud(dst_pud, __pud(virt_to_phys(dst_pmd)
> +						       | PUD_TYPE_TABLE));
> +			}
> +
> +			rc = copy_pmd(dst_pud, src_pud, addr, next);
> +			if (rc)
> +				break;
> +		} else {
> +			set_pud(dst_pud,
> +				__pud(pud_val(*src_pud) & ~PMD_SECT_RDONLY));
> +		}
> +	} while (dst_pud++, src_pud++, addr = next, addr != end);
> +
> +	return rc;
> +}
> +
> +static int copy_page_tables(pgd_t *dst_pgd, unsigned long start,
> +			    unsigned long end)
> +{
> +	int rc = 0;
> +	pud_t *dst_pud;
> +	unsigned long next;
> +	unsigned long addr = start;
> +	pgd_t *src_pgd = pgd_offset_k(start);
> +
> +	dst_pgd += pgd_index(start);
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (!pgd_val(*src_pgd))
> +			continue;
> +
> +		if (PTRS_PER_PUD != 1) {
> +			dst_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +			if (!dst_pud) {
> +				rc = -ENOMEM;
> +				break;
> +			}
> +
> +			set_pgd(dst_pgd, __pgd(virt_to_phys(dst_pud)
> +					       | PUD_TYPE_TABLE));
> +		}
> +
> +		rc = copy_pud(dst_pgd, src_pgd, addr, next);
> +		if (rc)
> +			break;
> +	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
> +
> +	return rc;
> +}

We have a few similar page table walking routines in the kernel, though
none of them seems close enough to be easily reusable. Most of them
require a vm_area_struct and mm_struct. But we could use them as
inspiration and the closest to what we need is copy_page_range(). The
main differences from what you have:

- using p*d_offset() instead of p*d_index(). The former is already
  defined in the pgtable-nop*d.h etc. files
- the pud allocation happens in copy_pud rather than copy_page_tables
  (similarly for pmd)
- using p*d_none() instead of !p*d_val(). Again, the former is already
  defined in pgtable-nop*d.h and I don't think we'll need the
  PTRS_PER_P*D checks

> +
> +/*
> + * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
> + *
> + * Memory allocated by get_safe_page() will be dealt with by the hibernate code,
> + * we don't need to free it here.
> + */
> +int swsusp_arch_resume(void)
> +{
> +	int rc = 0;
> +	size_t exit_size;
> +	pgd_t *tmp_pg_dir;
> +	void *lm_restore_pblist;
> +	phys_addr_t phys_hibernate_exit;
> +	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
> +					  void *, unsigned long, phys_addr_t);
> +
> +	/*
> +	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
> +	 * a new set of ttbr0 page tables and load them.
> +	 */
> +	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
> +	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
> +				   (void **)&hibernate_exit,
> +				   &phys_hibernate_exit,
> +				   get_safe_page, GFP_ATOMIC);

What I suggested above, just set hibernate_exit VA to PAGE_SIZE here and
pass it directly to create_safe_exec_page().

-- 
Catalin
