From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 18:26:02 +0100
Subject: [PATCH v2 5/5] arm64: Remove the !CONFIG_ARM64_HW_AFDBM alternative
 code paths
In-Reply-To: <20170818172602.7624-1-catalin.marinas@arm.com>
References: <20170818172602.7624-1-catalin.marinas@arm.com>
Message-ID: <20170818172602.7624-6-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the pte handling for hardware AF/DBM works even when the hardware
feature is not present, make the pte accessors implementation permanent
and remove the corresponding #ifdefs. The Kconfig option is kept as it
can still be used to disable the feature at the hardware level.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 9 +--------
 arch/arm64/kvm/hyp/s2-setup.c    | 2 +-
 arch/arm64/mm/fault.c            | 2 --
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0117cbcd62d4..bc4e92337d16 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -85,11 +85,7 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 	(__boundary - 1 < (end) - 1) ? __boundary : (end);			\
 })
 
-#ifdef CONFIG_ARM64_HW_AFDBM
 #define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
-#else
-#define pte_hw_dirty(pte)	(0)
-#endif
 #define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
 #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
 
@@ -228,8 +224,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * hardware updates of the pte (ptep_set_access_flags safely changes
 	 * valid ptes without going through an invalid entry).
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
-	    pte_valid(*ptep) && pte_valid(pte)) {
+	if (pte_valid(*ptep) && pte_valid(pte)) {
 		VM_WARN_ONCE(!pte_young(pte),
 			     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
 			     __func__, pte_val(*ptep), pte_val(pte));
@@ -565,7 +560,6 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
 }
 
-#ifdef CONFIG_ARM64_HW_AFDBM
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
@@ -670,7 +664,6 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 	ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
 }
 #endif
-#endif	/* CONFIG_ARM64_HW_AFDBM */
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
diff --git a/arch/arm64/kvm/hyp/s2-setup.c b/arch/arm64/kvm/hyp/s2-setup.c
index b81f4091c909..a81f5e10fc8c 100644
--- a/arch/arm64/kvm/hyp/s2-setup.c
+++ b/arch/arm64/kvm/hyp/s2-setup.c
@@ -70,7 +70,7 @@ u32 __hyp_text __init_stage2_translation(void)
 	 * Management in ID_AA64MMFR1_EL1 and enable the feature in VTCR_EL2.
 	 */
 	tmp = (read_sysreg(id_aa64mmfr1_el1) >> ID_AA64MMFR1_HADBS_SHIFT) & 0xf;
-	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && tmp)
+	if (tmp)
 		val |= VTCR_EL2_HA;
 
 	/*
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c3eebb4afd6c..4428b783147b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -140,7 +140,6 @@ void show_pte(unsigned long addr)
 	pr_cont("\n");
 }
 
-#ifdef CONFIG_ARM64_HW_AFDBM
 /*
  * This function sets the access flags (dirty, accessed), as well as write
  * permission, and only to a more permissive setting.
@@ -182,7 +181,6 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	flush_tlb_fix_spurious_fault(vma, address);
 	return 1;
 }
-#endif
 
 static bool is_el1_instruction_abort(unsigned int esr)
 {
