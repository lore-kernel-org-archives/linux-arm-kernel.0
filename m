From: wmills@ti.com (Bill Mills)
Date: Sun, 5 Jun 2016 23:20:26 -0400
Subject: [RFC v2 1/4] ARM: mm: add early page table attribute modification
 ability
In-Reply-To: <1465183229-24147-1-git-send-email-wmills@ti.com>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
Message-ID: <1465183229-24147-2-git-send-email-wmills@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow early-init to specify modifications to be made to the boot time page
table. Any modifications specified will be done with MMU off at the same
time that any Phy<->Virt fixup is done.

This ability is enabled with ARM_PV_FIXUP.

It is currently only implemented for LPAE mode.

Signed-off-by: Bill Mills <wmills@ti.com>
---
 arch/arm/include/asm/pgtable-hwdef.h | 21 +++++++++
 arch/arm/mm/mmu.c                    | 36 ++++++++++++---
 arch/arm/mm/pv-fixup-asm.S           | 86 ++++++++++++++++++++++++++++++++++--
 3 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-hwdef.h b/arch/arm/include/asm/pgtable-hwdef.h
index 8426229..c35d71f 100644
--- a/arch/arm/include/asm/pgtable-hwdef.h
+++ b/arch/arm/include/asm/pgtable-hwdef.h
@@ -16,4 +16,25 @@
 #include <asm/pgtable-2level-hwdef.h>
 #endif
 
+#ifdef CONFIG_ARM_PV_FIXUP
+
+#define MAX_ATTR_MOD_ENTRIES	64
+
+#ifndef __ASSEMBLY__
+
+struct attr_mod_entry {
+	pmdval_t	test_mask;
+	pmdval_t	test_value;
+	pmdval_t	clear_mask;
+	pmdval_t	set_mask;
+};
+
+bool attr_mod_add(struct attr_mod_entry *pmod);
+
+extern int num_attr_mods;
+extern struct attr_mod_entry attr_mod_table[MAX_ATTR_MOD_ENTRIES];
+
+#endif	/* __ASSEMBLY__ */
+#endif	/* CONFIG_ARM_PV_FIXUP */
+
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 62f4d01..a608980 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1496,23 +1496,41 @@ extern unsigned long __atags_pointer;
 typedef void pgtables_remap(long long offset, unsigned long pgd, void *bdata);
 pgtables_remap lpae_pgtables_remap_asm;
 
+int num_attr_mods;
+
+/* add an entry to the early page table attribute modification list */
+bool __init attr_mod_add(struct attr_mod_entry *pmod)
+{
+	if (num_attr_mods >= MAX_ATTR_MOD_ENTRIES) {
+		pr_crit("Out of room for (or late use of) early page table attribute modifications.\n");
+		return false;
+	}
+
+	attr_mod_table[num_attr_mods++] = *pmod;
+	return true;
+}
+
 /*
  * early_paging_init() recreates boot time page table setup, allowing machines
  * to switch over to a high (>4G) address space on LPAE systems
+ *
+ * This function also applies any attribute modifications specified in
+ * attr_mod_table.  These may have been added before we got here (early_param)
+ * or from within mdesc->pv_fixup called by this function
  */
 void __init early_paging_init(const struct machine_desc *mdesc)
 {
 	pgtables_remap *lpae_pgtables_remap;
 	unsigned long pa_pgd;
 	unsigned int cr, ttbcr;
-	long long offset;
+	long long offset = 0;
 	void *boot_data;
+	unsigned long pmd;
 
-	if (!mdesc->pv_fixup)
-		return;
+	if (mdesc->pv_fixup)
+		offset = mdesc->pv_fixup();
 
-	offset = mdesc->pv_fixup();
-	if (offset == 0)
+	if (offset == 0 && num_attr_mods == 0)
 		return;
 
 	/*
@@ -1564,6 +1582,14 @@ void __init early_paging_init(const struct machine_desc *mdesc)
 	/* Re-enable the caches and cacheable TLB walks */
 	asm volatile("mcr p15, 0, %0, c2, c0, 2" : : "r" (ttbcr));
 	set_cr(cr);
+
+	/* disable any further use of attribute fixup */
+	num_attr_mods = MAX_ATTR_MOD_ENTRIES + 1;
+
+	/* record the new "initial" pmd and cachepolicy */
+	pmd = pmd_val(*pmd_off_k((unsigned long)_data));
+	pmd &= ~PMD_MASK;
+	init_default_cache_policy(pmd);
 }
 
 #else
diff --git a/arch/arm/mm/pv-fixup-asm.S b/arch/arm/mm/pv-fixup-asm.S
index 1867f3e4..ad8edc2 100644
--- a/arch/arm/mm/pv-fixup-asm.S
+++ b/arch/arm/mm/pv-fixup-asm.S
@@ -19,8 +19,44 @@
 #define L1_ORDER 3
 #define L2_ORDER 3
 
+/*
+ *	attr_mod_table:
+ *		describe transforms to be made to the early boot pgtable
+ *		This is poked by early init code
+ *	mod descriptor list:
+ *		64 bit test mask
+ *		64 bit test value
+ *		64 bit clear mask
+ *		64 bit set mask
+ *      	next descriptor
+ *		...
+ *		0x0000_00000 0x0000_0000 end of list
+ */
+/* TODO: what segment?, test w/ XIP kernel? */
+	 .globl attr_mod_table
+attr_mod_table:
+	.zero   8*MAX_ATTR_MOD_ENTRIES*4 + 1
+
+/*
+ *	lpae_pgtables_remap_asm(long long offset, unsigned long pg,
+ *		void* boot_data)
+ *
+ *	Rewrite initial boot page tables with new physical addresses and or
+ *	attributes.
+ *	This function starts in identity mapped VA -> low PA
+ *	The body runs in low PA with MMU off
+ * 	The function ends in "identity mapped" VA -> high PA
+ *	The function returns to kernel VA space -> high PA
+ *
+ *	- r0    PA delta low
+ *	- r1	PA delta high
+ *	- r2    address of top level table
+ *	- r3    address of dtb (or atags))
+ *
+ *	uses null terminated list of attribute modifications in attr_mod_table
+ */
 ENTRY(lpae_pgtables_remap_asm)
-	stmfd	sp!, {r4-r8, lr}
+	stmfd	sp!, {r4-r11, lr}
 
 	mrc	p15, 0, r8, c1, c0, 0		@ read control reg
 	bic	ip, r8, #CR_M			@ disable caches and MMU
@@ -63,6 +99,7 @@ ENTRY(lpae_pgtables_remap_asm)
 	subs	r6, r6, #1
 	bne	2b
 
+	/* Update HW page table regs with new PA */
 	mrrc	p15, 0, r4, r5, c2		@ read TTBR0
 	adds	r4, r4, r0			@ update physical address
 	adc	r5, r5, r1
@@ -74,15 +111,58 @@ ENTRY(lpae_pgtables_remap_asm)
 
 	dsb
 
+	/* Update attributes of all level 2 entries in 1GB space */
+	/* TODO: fix/test BE8 THUMB2 kernel */
+	adrl	r3, attr_mod_table
+	add	r7, r2, #0x1000
+	add	r6, r7, #0x4000
+	bl	3f				@ NOT C ABI
+
+	/* Update attributes of the 4 level 1 entries */
+	/* TODO: delete this or allow mod entries to match only L1 */
+	mov	r7, r2
+	add	r6, r7, #32
+	bl	3f				@ NOT C ABI
+	b	7f
+
+3:	ldrd	r4, [r7]
+	orrs	r11, r4, r5
+	beq	6f				@ skip unused entries
+	mov 	r10, r3
+4:	ldrd	r8, [r10]
+	orrs	r11, r8, r9
+	beq	6f				@ end of mod table?
+	and	r0, r4, r8			@ no, load test mask
+	and	r1, r5, r9
+	ldrd	r8, [r10, #8]			@ load test bits
+	cmp	r0, r8
+	cmpeq	r1, r9
+	bne	5f				@ does entry match desc?
+	ldrd	r8, [r10, #16]			@ yes, load mod clear mask
+	bic	r4, r4, r8
+	bic	r5, r5, r9
+	ldrd	r8, [r10, #24]			@ load mod set mask
+	orr	r4, r4, r8
+	orr	r5, r5, r9
+5:	add     r10, r10, #32			@ try next mod desc
+	b	4b
+6:	strd	r4, [r7], #1 << L2_ORDER
+	cmp	r7, r6
+	bls	3b
+	bx 	lr
+
+7:
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c5, 0		@ I+BTB cache invalidate
 	mcr	p15, 0, ip, c8, c7, 0		@ local_flush_tlb_all()
 	dsb
 	isb
 
-	mcr	p15, 0, r8, c1, c0, 0		@ re-enable MMU
+	mrc	p15, 0, r8, c1, c0, 0		@ re-enable MMU
+	orr	r8, r8, #CR_M
+	mcr	p15, 0, r8, c1, c0, 0
 	dsb
 	isb
 
-	ldmfd	sp!, {r4-r8, pc}
+	ldmfd	sp!, {r4-r11, pc}
 ENDPROC(lpae_pgtables_remap_asm)
-- 
1.9.1
