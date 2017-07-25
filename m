From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Jul 2017 14:53:08 +0100
Subject: [PATCH 6/6] arm64: Remove the CONFIG_ARM64_HW_AFDBM option
In-Reply-To: <20170725135308.18173-1-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
Message-ID: <20170725135308.18173-7-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the pte handling for hardware AF/DBM works even when the hardware
feature is not present, make the implementation permanent and remove the
Kconfig option.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig               | 17 -----------------
 arch/arm64/include/asm/pgtable.h |  9 +--------
 arch/arm64/kvm/hyp/s2-setup.c    |  2 +-
 arch/arm64/mm/fault.c            |  2 --
 arch/arm64/mm/proc.S             |  3 +--
 5 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dfd908630631..eeb61d800441 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -879,23 +879,6 @@ config ARM64_SW_TTBR0_PAN
 
 menu "ARMv8.1 architectural features"
 
-config ARM64_HW_AFDBM
-	bool "Support for hardware updates of the Access and Dirty page flags"
-	default y
-	help
-	  The ARMv8.1 architecture extensions introduce support for
-	  hardware updates of the access and dirty information in page
-	  table entries. When enabled in TCR_EL1 (HA and HD bits) on
-	  capable processors, accesses to pages with PTE_AF cleared will
-	  set this bit instead of raising an access flag fault.
-	  Similarly, writes to read-only pages with the DBM bit set will
-	  clear the read-only bit (AP[2]) instead of raising a
-	  permission fault.
-
-	  Kernels built with this configuration option enabled continue
-	  to work on pre-ARMv8.1 hardware and the performance impact is
-	  minimal. If unsure, say Y.
-
 config ARM64_PAN
 	bool "Enable support for Privileged Access Never (PAN)"
 	default y
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3fefcc0182c7..e23811f6b9da 100644
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
@@ -666,7 +660,6 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
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
index cfff98a97a7c..ce361234e78b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -140,7 +140,6 @@ void show_pte(unsigned long addr)
 	pr_cont("\n");
 }
 
-#ifdef CONFIG_ARM64_HW_AFDBM
 /*
  * This function sets the access flags (dirty, accessed), as well as write
  * permission, and only to a more permissive setting.
@@ -181,7 +180,6 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	flush_tlb_fix_spurious_fault(vma, address);
 	return 1;
 }
-#endif
 
 static bool is_el1_instruction_abort(unsigned int esr)
 {
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 877d42fb0df6..ba82f8bf3cf1 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -234,7 +234,7 @@ ENTRY(__cpu_setup)
 	 */
 	mrs	x9, ID_AA64MMFR0_EL1
 	bfi	x10, x9, #32, #3
-#ifdef CONFIG_ARM64_HW_AFDBM
+
 	/*
 	 * Hardware update of the Access and Dirty bits.
 	 */
@@ -246,7 +246,6 @@ ENTRY(__cpu_setup)
 	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
 1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
 2:
-#endif	/* CONFIG_ARM64_HW_AFDBM */
 	msr	tcr_el1, x10
 	ret					// return to head.S
 ENDPROC(__cpu_setup)
