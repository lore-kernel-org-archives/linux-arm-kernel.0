From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 08 Apr 2015 10:45:30 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150408094438.GM12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
Message-ID: <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-implement the physical address space switching to be architecturally
complaint.  This involves flushing the caches, disabling the MMU, and
only then updating the page tables.  Once that is complete, the system
can be brought back up again.

Since we disable the MMU, we need to do the update in assembly code.
Luckily, the entries which need updating are fairly trivial, and are
all setup by the early assembly code.  We can merely adjust each entry
by the delta required.

Not only does htis fix the code to be architecturally compliant, but it
fixes a couple of bugs too:

1. The original code would only ever update the first L2 entry covering
   a fraction of the kernel; the remainder were left untouched.
2. The L2 entries covering the DTB blob were likewise untouched.

This solution fixes up all entries.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig        |   4 ++
 arch/arm/mm/Makefile       |   1 +
 arch/arm/mm/mmu.c          | 119 +++++++++++++--------------------------------
 arch/arm/mm/pv-fixup-asm.S |  88 +++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 84 deletions(-)
 create mode 100644 arch/arm/mm/pv-fixup-asm.S

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index b7644310236b..cc873e74643a 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -624,6 +624,10 @@ config ARM_LPAE
 
 	  If unsure, say N.
 
+config ARM_PV_FIXUP
+	def_bool y
+	depends on ARM_LPAE && ARM_PATCH_PHYS_VIRT && ARCH_KEYSTONE
+
 config ARCH_PHYS_ADDR_T_64BIT
 	def_bool ARM_LPAE
 
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 19df9bd9a79f..290ec5056b3b 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MODULES)		+= proc-syms.o
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
+obj-$(CONFIG_ARM_PV_FIXUP)	+= pv-fixup-asm.o
 
 obj-$(CONFIG_CPU_ABRT_NOMMU)	+= abort-nommu.o
 obj-$(CONFIG_CPU_ABRT_EV4)	+= abort-ev4.o
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4eab87eab5aa..addb7987c714 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1387,7 +1387,11 @@ static void __init map_lowmem(void)
 	}
 }
 
-#if defined(CONFIG_ARM_LPAE) && defined(CONFIG_ARM_PATCH_PHYS_VIRT)
+#ifdef CONFIG_ARM_PV_FIXUP
+extern unsigned long __atags_pointer;
+typedef void pgtables_remap(long long offset, unsigned long pgd, void *bdata);
+pgtables_remap lpae_pgtables_remap_asm;
+
 /*
  * early_paging_init() recreates boot time page table setup, allowing machines
  * to switch over to a high (>4G) address space on LPAE systems
@@ -1395,35 +1399,30 @@ static void __init map_lowmem(void)
 void __init early_paging_init(const struct machine_desc *mdesc,
 			      struct proc_info_list *procinfo)
 {
-	pmdval_t pmdprot = procinfo->__cpu_mm_mmu_flags;
-	unsigned long map_start, map_end;
+	pgtables_remap *lpae_pgtables_remap;
+	unsigned long pa_pgd;
+	unsigned int cr;
 	long long offset;
-	pgd_t *pgd0, *pgdk;
-	pud_t *pud0, *pudk, *pud_start;
-	pmd_t *pmd0, *pmdk;
-	phys_addr_t phys;
-	int i;
+	void *boot_data;
 
 	if (!mdesc->pv_fixup)
 		return;
 
-	/* remap kernel code and data */
-	map_start = init_mm.start_code & PMD_MASK;
-	map_end   = ALIGN(init_mm.brk, PMD_SIZE);
-
-	/* get a handle on things... */
-	pgd0 = pgd_offset_k(0);
-	pud_start = pud0 = pud_offset(pgd0, 0);
-	pmd0 = pmd_offset(pud0, 0);
-
-	pgdk = pgd_offset_k(map_start);
-	pudk = pud_offset(pgdk, map_start);
-	pmdk = pmd_offset(pudk, map_start);
-
 	offset = mdesc->pv_fixup();
 	if (offset == 0)
 		return;
 
+	/*
+	 * Get the address of the remap function in the 1:1 identity
+	 * mapping setup by the early page table assembly code.  We
+	 * must get this prior to the pv update.  The following barrier
+	 * ensures that this is complete before we fixup any P:V offsets.
+	 */
+	lpae_pgtables_remap = (pgtables_remap *)(unsigned long)__pa(lpae_pgtables_remap_asm);
+	pa_pgd = __pa(swapper_pg_dir);
+	boot_data = __va(__atags_pointer);
+	barrier();
+
 	pr_info("Switching physical address space to 0x%08llx\n",
 		(u64)PHYS_OFFSET + offset);
 
@@ -1436,75 +1435,27 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 		(&__pv_table_end - &__pv_table_begin) << 2);
 
 	/*
-	 * Cache cleaning operations for self-modifying code
-	 * We should clean the entries by MVA but running a
-	 * for loop over every pv_table entry pointer would
-	 * just complicate the code.
-	 */
-	flush_cache_louis();
-	dsb(ishst);
-	isb();
-
-	/*
-	 * FIXME: This code is not architecturally compliant: we modify
-	 * the mappings in-place, indeed while they are in use by this
-	 * very same code.  This may lead to unpredictable behaviour of
-	 * the CPU.
-	 *
-	 * Even modifying the mappings in a separate page table does
-	 * not resolve this.
-	 *
-	 * The architecture strongly recommends that when a mapping is
-	 * changed, that it is changed by first going via an invalid
-	 * mapping and back to the new mapping.  This is to ensure that
-	 * no TLB conflicts (caused by the TLB having more than one TLB
-	 * entry match a translation) can occur.  However, doing that
-	 * here will result in unmapping the code we are running.
-	 */
-	pr_warn("WARNING: unsafe modification of in-place page tables - tainting kernel\n");
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-
-	/*
-	 * Remap level 1 table.  This changes the physical addresses
-	 * used to refer to the level 2 page tables to the high
-	 * physical address alias, leaving everything else the same.
-	 */
-	for (i = 0; i < PTRS_PER_PGD; pud0++, i++) {
-		set_pud(pud0,
-			__pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
-		pmd0 += PTRS_PER_PMD;
-	}
-
-	/*
-	 * Remap the level 2 table, pointing the mappings at the high
-	 * physical address alias of these pages.
-	 */
-	phys = __pa(map_start);
-	do {
-		*pmdk++ = __pmd(phys | pmdprot);
-		phys += PMD_SIZE;
-	} while (phys < map_end);
-
-	/*
-	 * Ensure that the above updates are flushed out of the cache.
-	 * This is not strictly correct; on a system where the caches
-	 * are coherent with each other, but the MMU page table walks
-	 * may not be coherent, flush_cache_all() may be a no-op, and
-	 * this will fail.
+	 * We changing not only the virtual to physical mapping, but
+	 * also the physical addresses used to access memory.  We need
+	 * to flush all levels of cache in the system with caching
+	 * disabled to ensure that all data is written back.  We do this
+	 * with caching and write buffering disabled to ensure that
+	 * nothing is speculatively prefetched.
 	 */
+	cr = get_cr();
+	set_cr(cr & ~(CR_I | CR_C | CR_W));
 	flush_cache_all();
 
 	/*
-	 * Re-write the TTBR values to point them@the high physical
-	 * alias of the page tables.  We expect __va() will work on
-	 * cpu_get_pgd(), which returns the value of TTBR0.
+	 * Fixup the page tables - this must be in the idmap region as
+	 * we need to disable the MMU to do this safely, and hence it
+	 * needs to be assembly.  It's fairly simple, as we're using the
+	 * temporary tables setup by the initial assembly code.
 	 */
-	cpu_switch_mm(pgd0, &init_mm);
-	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
+	lpae_pgtables_remap(offset, pa_pgd, boot_data);
 
-	/* Finally flush any stale TLB values. */
-	local_flush_bp_all();
-	local_flush_tlb_all();
+	/* Re-enable the caches */
+	set_cr(cr);
 }
 
 #else
diff --git a/arch/arm/mm/pv-fixup-asm.S b/arch/arm/mm/pv-fixup-asm.S
new file mode 100644
index 000000000000..1867f3e43016
--- /dev/null
+++ b/arch/arm/mm/pv-fixup-asm.S
@@ -0,0 +1,88 @@
+/*
+ *  Copyright (C) 2015 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This assembly is required to safely remap the physical address space
+ * for Keystone 2
+ */
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/cp15.h>
+#include <asm/memory.h>
+#include <asm/pgtable.h>
+
+	.section ".idmap.text", "ax"
+
+#define L1_ORDER 3
+#define L2_ORDER 3
+
+ENTRY(lpae_pgtables_remap_asm)
+	stmfd	sp!, {r4-r8, lr}
+
+	mrc	p15, 0, r8, c1, c0, 0		@ read control reg
+	bic	ip, r8, #CR_M			@ disable caches and MMU
+	mcr	p15, 0, ip, c1, c0, 0
+	dsb
+	isb
+
+	/* Update level 2 entries covering the kernel */
+	ldr	r6, =(_end - 1)
+	add	r7, r2, #0x1000
+	add	r6, r7, r6, lsr #SECTION_SHIFT - L2_ORDER
+	add	r7, r7, #PAGE_OFFSET >> (SECTION_SHIFT - L2_ORDER)
+1:	ldrd	r4, [r7]
+	adds	r4, r4, r0
+	adc	r5, r5, r1
+	strd	r4, [r7], #1 << L2_ORDER
+	cmp	r7, r6
+	bls	1b
+
+	/* Update level 2 entries for the boot data */
+	add	r7, r2, #0x1000
+	add	r7, r7, r3, lsr #SECTION_SHIFT - L2_ORDER
+	bic	r7, r7, #(1 << L2_ORDER) - 1
+	ldrd	r4, [r7]
+	adds	r4, r4, r0
+	adc	r5, r5, r1
+	strd	r4, [r7], #1 << L2_ORDER
+	ldrd	r4, [r7]
+	adds	r4, r4, r0
+	adc	r5, r5, r1
+	strd	r4, [r7]
+
+	/* Update level 1 entries */
+	mov	r6, #4
+	mov	r7, r2
+2:	ldrd	r4, [r7]
+	adds	r4, r4, r0
+	adc	r5, r5, r1
+	strd	r4, [r7], #1 << L1_ORDER
+	subs	r6, r6, #1
+	bne	2b
+
+	mrrc	p15, 0, r4, r5, c2		@ read TTBR0
+	adds	r4, r4, r0			@ update physical address
+	adc	r5, r5, r1
+	mcrr	p15, 0, r4, r5, c2		@ write back TTBR0
+	mrrc	p15, 1, r4, r5, c2		@ read TTBR1
+	adds	r4, r4, r0			@ update physical address
+	adc	r5, r5, r1
+	mcrr	p15, 1, r4, r5, c2		@ write back TTBR1
+
+	dsb
+
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c5, 0		@ I+BTB cache invalidate
+	mcr	p15, 0, ip, c8, c7, 0		@ local_flush_tlb_all()
+	dsb
+	isb
+
+	mcr	p15, 0, r8, c1, c0, 0		@ re-enable MMU
+	dsb
+	isb
+
+	ldmfd	sp!, {r4-r8, pc}
+ENDPROC(lpae_pgtables_remap_asm)
-- 
1.8.3.1
