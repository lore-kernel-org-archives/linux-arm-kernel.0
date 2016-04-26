From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Apr 2016 15:39:45 +0100
Subject: [PATCH v8 12/13] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1461604250-12789-13-git-send-email-james.morse@arm.com>
References: <1461604250-12789-1-git-send-email-james.morse@arm.com>
 <1461604250-12789-13-git-send-email-james.morse@arm.com>
Message-ID: <20160426143945.GD8525@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 06:10:49PM +0100, James Morse wrote:
> Add support for hibernate/suspend-to-disk.
> 
> Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
> before calling swsusp_save() to save the memory image.
> 
> Restore creates a set of temporary page tables, covering only the
> linear map, copies the restore code to a 'safe' page, then uses the copy to
> restore the memory image. The copied code executes in the lower half of the
> address space, and once complete, restores the original kernel's page
> tables. It then calls into cpu_resume(), and follows the normal
> cpu_suspend() path back into the suspend code.
> 
> To restore a kernel using KASLR, the address of the page tables, and
> cpu_resume() are stored in the hibernate arch-header and the el2
> vectors are pivotted via the 'safe' page in low memory.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com> # Tested on Juno R2
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>

Nitpick: please keep the Cc: tags in the same block as the other tags
(signed-off etc.; IOW no empty line between them). Though at some point
you'll change this to a reviewed-by tag.

> --- /dev/null
> +++ b/arch/arm64/kernel/hibernate-asm.S
> @@ -0,0 +1,157 @@
> +/*
> + * Hibernate low-level support
> + *
> + * Copyright (C) 2016 ARM Ltd.
> + * Author:	James Morse <james.morse@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/linkage.h>
> +#include <linux/errno.h>
> +
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
> +#include <asm/cputype.h>
> +#include <asm/memory.h>
> +#include <asm/page.h>
> +#include <asm/virt.h>
> +
> +/*
> + * Corrupt memory.

Maybe a better headline for this function ;).

> + *
> + * Loads temporary page tables then restores the memory image.
> + * Finally branches to cpu_resume() to restore the state saved by
> + * swsusp_arch_suspend().
> + *
> + * Because this code has to be copied to a safe_page, it can't call out to
> + * other functions by PC-relative address. Also remember that it may be
> + * mid-way through over-writing other functions. For this reason it contains
> + * code from flush_icache_range() and uses the copy_page() macro.
> + *
> + * All of memory gets written to, including code. We need to clean the kernel
> + * text to the Point of Coherence (PoC) before secondary cores can be booted.
> + * Because the kernel modules and executable pages mapped to user space are
> + * also written as data, we clean all pages we touch to the Point of
> + * Unification (PoU).
> + *
> + * We use el2_setup() to reconfigure el2. This code needs cleaning to PoC by VA,
> + * but called with its physical address, as we left el2 with the MMU turned off.
> + *
> + * x0: physical address of temporary page tables
> + * x1: physical address of swapper page tables
> + * x2: address of cpu_resume
> + * x3: linear map address of restore_pblist in the current kernel
> + * x4: physical address of __hyp_stub_vectors, or 0
> + */
> +.pushsection    ".hibernate_exit.text", "ax"
> +ENTRY(swsusp_arch_suspend_exit)
> +	/* Temporary page tables are a copy, so no need for a trampoline here */
> +	msr	ttbr1_el1, x0
> +	isb
> +	tlbi	vmalle1is	/* invalidate intermediate caching entries */
> +	dsb	ish

I think you need an ISB here as well since you are continuing with the
new page tables (without an ERET or exception taking).

> +
> +	mov	x21, x1
> +	mov	x30, x2		/* el2_setup() will eret to the lr directly */
> +	mov	x24, x4
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
> +	dsb	ish		/* wait for PoU cleaning to finish */
> +
> +	/* switch to the restored kernels page tables */
> +	msr	ttbr1_el1, x21  /* physical address of swapper page tables */
> +	isb
> +	tlbi	vmalle1is	/* invalidate intermediate caching entries */
> +	ic	ialluis
> +	dsb	ish		/* wait for icache invalidate to finish */
> +	isb

It looks like you have an ISB here but not above.

> +
> +	cbz	x24, 3f		/* Do we need to re-initialise EL2? */
> +	hvc	#0
> +3:	ret
> +
> +	.ltorg
> +ENDPROC(swsusp_arch_suspend_exit)

[...]

> --- /dev/null
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -0,0 +1,444 @@

[...]

> +/*
> + * Copies length bytes, starting at src_start into an new page,
> + * perform cache maintentance, then maps it at the specified address low
> + * address as executable.
> + *
> + * This is used by hibernate to copy the code it needs to execute when
> + * overwriting the kernel text. This function generates a new set of page
> + * tables, which it loads into ttbr0.
> + *
> + * Length is provided as we probably only want 4K of data, even on a 64K
> + * page system.
> + */
> +static int create_safe_exec_page(void *src_start, size_t length,
> +				 unsigned long dst_addr,
> +				 phys_addr_t *phys_dst_addr,
> +				 void *(*allocator)(gfp_t mask),
> +				 gfp_t mask)
> +{
> +	int rc = 0;
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	unsigned long dst = (unsigned long)allocator(mask);
> +
> +	if (!dst) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy((void *)dst, src_start, length);
> +	flush_icache_range(dst, dst + length);
> +
> +	pgd = pgd_offset_raw(allocator(mask), dst_addr);
> +	if (pgd_none(*pgd)) {
> +		pud = allocator(mask);
> +		if (!pud) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		set_pgd(pgd, __pgd(virt_to_phys(pud) | PUD_TYPE_TABLE));
> +	}
> +
> +	pud = pud_offset(pgd, dst_addr);
> +	if (pud_none(*pud)) {
> +		pmd = allocator(mask);
> +		if (!pmd) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		set_pud(pud, __pud(virt_to_phys(pmd) | PUD_TYPE_TABLE));
> +	}
> +
> +	pmd = pmd_offset(pud, dst_addr);
> +	if (pmd_none(*pmd)) {
> +		pte = allocator(mask);
> +		if (!pte) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		set_pmd(pmd, __pmd(virt_to_phys(pte) | PMD_TYPE_TABLE));
> +	}

It looks fine now. A potential improvement would be to use
p*d_populate() instead of set_p*d(), though it needs an init_mm. It's up
to you (I have a similar comment further down).

> +
> +	pte = pte_offset_kernel(pmd, dst_addr);
> +	set_pte(pte, __pte(virt_to_phys((void *)dst) |
> +			 pgprot_val(PAGE_KERNEL_EXEC)));
> +
> +	/* Load our new page tables */
> +	asm volatile("msr	ttbr0_el1, %0;"
> +		     "isb;"
> +		     "tlbi	vmalle1is;"
> +		     "dsb	ish" : : "r"(virt_to_phys(pgd)));

ISB needed after TLBI *if* we are going to execute code from the new
mapping *without* an ERET (or taking of an exception).

> +
> +	*phys_dst_addr = virt_to_phys((void *)dst);
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
> +		/* Clean kernel to PoC for secondary core startup */
> +		__flush_dcache_area(LMADDR(KERNEL_START), KERNEL_END - KERNEL_START);
> +
> +		/*
> +		 * Tell the hibernation core that we've just restored
> +		 * the memory
> +		 */
> +		in_suspend = 0;
> +
> +		__cpu_suspend_exit();
> +	}
> +
> +	local_dbg_restore(flags);
> +
> +	return ret;
> +}
> +
> +static int copy_pte(pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long start,
> +		    unsigned long end)
> +{
> +	pte_t *src_pte;
> +	pte_t *dst_pte;
> +	unsigned long addr = start;
> +
> +	dst_pte = (pte_t *)get_safe_page(GFP_ATOMIC);
> +	if (!dst_pte)
> +		return -ENOMEM;
> +	set_pmd(dst_pmd, __pmd(virt_to_phys(dst_pte) | PMD_TYPE_TABLE));
> +	dst_pte = pte_offset_kernel(dst_pmd, start);
> +
> +	src_pte = pte_offset_kernel(src_pmd, start);
> +	do {
> +		if (pte_val(*src_pte))
> +			set_pte(dst_pte, __pte(pte_val(*src_pte) & ~PTE_RDONLY));
> +	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
> +
> +	return 0;
> +}
> +
> +static int copy_pmd(pud_t *dst_pud, pud_t *src_pud, unsigned long start,
> +		    unsigned long end)
> +{
> +	pmd_t *src_pmd;
> +	pmd_t *dst_pmd;
> +	unsigned long next;
> +	unsigned long addr = start;
> +
> +	dst_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!dst_pmd)
> +		return -ENOMEM;
> +	set_pud(dst_pud, __pud(virt_to_phys(dst_pmd) | PUD_TYPE_TABLE));
> +	dst_pmd = pmd_offset(dst_pud, start);
> +
> +	src_pmd = pmd_offset(src_pud, start);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (!pmd_val(*src_pmd))
> +			continue;
> +		if (pmd_table(*src_pmd)) {
> +			if (copy_pte(dst_pmd, src_pmd, addr, next))
> +				return -ENOMEM;
> +		} else {
> +			set_pmd(dst_pmd,
> +				__pmd(pmd_val(*src_pmd) & ~PMD_SECT_RDONLY));
> +		}
> +	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static int copy_pud(pgd_t *dst_pgd, pgd_t *src_pgd, unsigned long start,
> +		    unsigned long end)
> +{
> +	pud_t *dst_pud;
> +	pud_t *src_pud;
> +	unsigned long next;
> +	unsigned long addr = start;
> +
> +	dst_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +	if (!dst_pud)
> +		return -ENOMEM;
> +	set_pgd(dst_pgd, __pgd(virt_to_phys(dst_pud) | PUD_TYPE_TABLE));
> +	dst_pud = pud_offset(dst_pgd, start);

I think this is allocating pages even if we don't have a pud. So we
need:

	if (pgd_none(*dst_pgd)) {
		dst_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
		if (!dst_pud)
			return -ENOMEM;
		set_pgd(dst_pgd, __pgd(virt_to_phys(dst_pud) | PUD_TYPE_TABLE));
	}
	dst_pud = pud_offset(dst_pgd, start);

With nopud, pgd_none is 0, so we simply skip the allocation (inspired by
the pud_alloc() macro).

You could also use pgd_populate() here, though you need init_mm
(alternatively, there is __pgd_populate()).

> +
> +	src_pud = pud_offset(src_pgd, start);
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (!pud_val(*src_pud))
> +			continue;

As for the pgd, I would use pud_none(*src_pud) here.

> +		if (pud_table(*(src_pud))) {
> +			if (copy_pmd(dst_pud, src_pud, addr, next))
> +				return -ENOMEM;
> +		} else {
> +			set_pud(dst_pud,
> +				__pud(pud_val(*src_pud) & ~PMD_SECT_RDONLY));

Why does PMD_SECT_RDONLY need clearing? You may want to add a comment.

The same comments apply to the copy_pmd/copy_pte functions above (I just
reviewed this part in reverse ;)).

> +		}
> +	} while (dst_pud++, src_pud++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static int copy_page_tables(pgd_t *dst_pgd, unsigned long start,
> +			    unsigned long end)
> +{
> +	unsigned long next;
> +	unsigned long addr = start;
> +	pgd_t *src_pgd = pgd_offset_k(start);
> +
> +	dst_pgd = pgd_offset_raw(dst_pgd, start);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (!pgd_val(*src_pgd))
> +			continue;

The outcome may be the same but I would rather use:

		if (pgd_none(*src_pgd))
			continue;

When nopud, we won't even bother checking as pgd_none() is 0.

> +		if (copy_pud(dst_pgd, src_pgd, addr, next))
> +			return -ENOMEM;
> +	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
> +
> +	return 0;
> +}

[...]

-- 
Catalin
