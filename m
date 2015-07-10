From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Jul 2015 17:24:28 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access and
 dirty pte bits
Message-ID: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8.1 architecture extensions introduce support for hardware
updates of the access and dirty information in page table entries. With
TCR_EL1.HA enabled, when the CPU accesses an address with the PTE_AF bit
cleared in the page table, instead of raising an access flag fault the
CPU sets the actual page table entry bit. To ensure that kernel
modifications to the page tables do not inadvertently revert a change
introduced by hardware updates, the exclusive monitor (ldxr/stxr) is
adopted in the pte accessors.

When TCR_EL1.HD is enabled, a write access to a memory location with the
DBM (Dirty Bit Management) bit set in the corresponding pte
automatically clears the read-only bit (AP[2]). Such DBM bit maps onto
the Linux PTE_WRITE bit and to check whether a writable (DBM set) page
is dirty, the kernel tests the PTE_RDONLY bit. In order to allow
read-only and dirty pages, the kernel needs to preserve the software
dirty bit. The hardware dirty status is transferred to the software
dirty bit in ptep_set_wrprotect() (using load/store exclusive loop) and
pte_modify().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

This patch only covers stage 1 page table support. For stage 2 (KVM),
talking to Marc Z it seems to be doable but it requires some more
investigation (basically kvm_set_pfn_{accessed,dirty} would no longer be
called via the abort path since the hardware toggles the bits
automatically; we would have to call these functions explicitly via
kvm_age_hva, kvm_unmap_hva, kvm_mmu_write_protect_pt_masked etc.).

I did not bother with alternatives for when the hardware feature is not
present. I don't think there is a noticeable performance impact with
this patch applied (but, well, benchmarking on a software model isn't
useful).

 arch/arm64/Kconfig                     |  17 ++++
 arch/arm64/include/asm/pgtable-hwdef.h |   3 +
 arch/arm64/include/asm/pgtable.h       | 147 ++++++++++++++++++++++++++++++++-
 arch/arm64/mm/proc.S                   |  13 +++
 4 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f6edb14b7e4..20a1a968aecc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -469,6 +469,23 @@ config ARM64_VA_BITS
 	default 42 if ARM64_VA_BITS_42
 	default 48 if ARM64_VA_BITS_48
 
+config ARM64_HW_AFDBM
+	bool "Support for hardware updates of the Access and Dirty page flags"
+	default y
+	help
+	  The ARMv8.1 architecture extensions introduce support for
+	  hardware updates of the access and dirty information in page
+	  table entries. When enabled in TCR_EL1 (HA and HD bits) on
+	  capable processors, accesses to pages with PTE_AF cleared will
+	  set this bit instead of raising an access flag fault.
+	  Similarly, writes to read-only pages with the DBM bit set will
+	  clear the read-only bit (AP[2]) instead of raising a
+	  permission fault.
+
+	  Kernels built with this configuration option enabled continue
+	  to work on pre-ARMv8.1 hardware and the performance impact is
+	  minimal. If unsure, say Y.
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 59bfae75dc98..24154b055835 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -104,6 +104,7 @@
 #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
 #define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
 #define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
+#define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
 #define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
 #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
 
@@ -168,5 +169,7 @@
 #define TCR_TG1_64K		(UL(3) << 30)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
+#define TCR_HA			(UL(1) << 39)
+#define TCR_HD			(UL(1) << 40)
 
 #endif
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 56283f8a675c..599af27ed84d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_PGTABLE_H
 #define __ASM_PGTABLE_H
 
+#include <asm/bug.h>
 #include <asm/proc-fns.h>
 
 #include <asm/memory.h>
@@ -27,7 +28,11 @@
 #define PTE_VALID		(_AT(pteval_t, 1) << 0)
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
+#ifdef CONFIG_ARM64_HW_AFDBM
+#define PTE_WRITE		(PTE_DBM)		 /* same as DBM */
+#else
 #define PTE_WRITE		(_AT(pteval_t, 1) << 57)
+#endif
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
 
 /*
@@ -48,6 +53,9 @@
 #define FIRST_USER_ADDRESS	0UL
 
 #ifndef __ASSEMBLY__
+
+#include <linux/mmdebug.h>
+
 extern void __pte_error(const char *file, int line, unsigned long val);
 extern void __pmd_error(const char *file, int line, unsigned long val);
 extern void __pud_error(const char *file, int line, unsigned long val);
@@ -137,12 +145,20 @@ extern struct page *empty_zero_page;
  * The following only work if pte_present(). Undefined behaviour otherwise.
  */
 #define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
-#define pte_dirty(pte)		(!!(pte_val(pte) & PTE_DIRTY))
 #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
 #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
 #define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
 
+#ifdef CONFIG_ARM64_HW_AFDBM
+#define pte_hw_dirty(pte)	(!(pte_val(pte) & PTE_RDONLY))
+#else
+#define pte_hw_dirty(pte)	(0)
+#endif
+#define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
+#define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
+
+#define pte_valid(pte)		(!!(pte_val(pte) && PTE_VALID))
 #define pte_valid_user(pte) \
 	((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
 #define pte_valid_not_user(pte) \
@@ -209,20 +225,49 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	}
 }
 
+struct mm_struct;
+struct vm_area_struct;
+
 extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
 
+/*
+ * PTE bits configuration in the presence of hardware Dirty Bit Management
+ * (PTE_WRITE == PTE_DBM):
+ *
+ * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
+ *   0      0      |   1           0          0
+ *   0      1      |   1           1          0
+ *   1      0      |   1           0          1
+ *   1      1      |   0           1          x
+ *
+ * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
+ * the page fault mechanism. Checking the dirty status of a pte becomes:
+ *
+ *   PTE_DIRTY || !PTE_RDONLY
+ */
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
 	if (pte_valid_user(pte)) {
 		if (!pte_special(pte) && pte_exec(pte))
 			__sync_icache_dcache(pte, addr);
-		if (pte_dirty(pte) && pte_write(pte))
+		if (pte_sw_dirty(pte) && pte_write(pte))
 			pte_val(pte) &= ~PTE_RDONLY;
 		else
 			pte_val(pte) |= PTE_RDONLY;
 	}
 
+	/*
+	 * If the existing pte is valid, check for potential race with
+	 * hardware updates of the pte (ptep_set_access_flags safely changes
+	 * valid ptes without going through an invalid entry).
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
+	    pte_valid(*ptep)) {
+		BUG_ON(!pte_young(pte));
+		BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
+	}
+
 	set_pte(ptep, pte);
 }
 
@@ -461,6 +506,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
 			      PTE_PROT_NONE | PTE_WRITE | PTE_TYPE_MASK;
+	/* preserve the hardware dirty information */
+	if (pte_hw_dirty(pte))
+		newprot |= PTE_DIRTY;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
@@ -470,6 +518,101 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
 }
 
+#ifdef CONFIG_ARM64_HW_AFDBM
+/*
+ * Atomic pte/pmd modifications.
+ */
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pte_t *ptep)
+{
+	pteval_t pteval;
+	unsigned int tmp, res;
+
+	asm volatile("//	ptep_test_and_clear_young\n"
+	"	prfm	pstl1strm, %2\n"
+	"1:	ldxr	%0, %2\n"
+	"	ubfx	%w3, %w0, %5, #1	// extract PTE_AF (young)\n"
+	"	and	%0, %0, %4		// clear PTE_AF\n"
+	"	stxr	%w1, %0, %2\n"
+	"	cbnz	%w1, 1b\n"
+	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep)), "=&r" (res)
+	: "L" (~PTE_AF), "I" (ilog2(PTE_AF)));
+
+	return res;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
+static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pmd_t *pmdp)
+{
+	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pte_t *ptep)
+{
+	pteval_t old_pteval;
+	unsigned int tmp;
+
+	asm volatile("//	ptep_get_and_clear\n"
+	"	prfm	pstl1strm, %2\n"
+	"1:	ldxr	%0, %2\n"
+	"	stxr	%w1, xzr, %2\n"
+	"	cbnz	%w1, 1b\n"
+	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep)));
+
+	return __pte(old_pteval);
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_PMDP_GET_AND_CLEAR
+static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pmd_t *pmdp)
+{
+	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+/*
+ * ptep_set_wrprotect - mark read-only while trasferring potential hardware
+ * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
+ */
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
+{
+	pteval_t pteval;
+	unsigned long tmp;
+
+	asm volatile("//	ptep_set_wrprotect\n"
+	"	prfm	pstl1strm, %2\n"
+	"1:	ldxr	%0, %2\n"
+	"	tst	%0, %4			// check for hw dirty (!PTE_RDONLY)\n"
+	"	csel	%1, %3, xzr, eq		// set PTE_DIRTY|PTE_RDONLY if dirty\n"
+	"	orr	%0, %0, %1		// if !dirty, PTE_RDONLY is already set\n"
+	"	and	%0, %0, %5		// clear PTE_WRITE/PTE_DBM\n"
+	"	stxr	%w1, %0, %2\n"
+	"	cbnz	%w1, 1b\n"
+	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
+	: "r" (PTE_DIRTY|PTE_RDONLY), "L" (PTE_RDONLY), "L" (~PTE_WRITE)
+	: "cc");
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm,
+				      unsigned long address, pmd_t *pmdp)
+{
+	ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
+}
+#endif
+#endif	/* CONFIG_ARM64_HW_AFDBM */
+
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 39139a3aa16d..a8be513dff6f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -196,6 +196,19 @@ ENTRY(__cpu_setup)
 	 */
 	mrs	x9, ID_AA64MMFR0_EL1
 	bfi	x10, x9, #32, #3
+#ifdef CONFIG_ARM64_HW_AFDBM
+	/*
+	 * Hardware update of the Access and Dirty bits.
+	 */
+	mrs	x9, ID_AA64MMFR1_EL1
+	and	x9, x9, #0xf
+	cbz	x9, 2f
+	cmp	x9, #2
+	b.lt	1f
+	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
+1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
+2:
+#endif	/* CONFIG_ARM64_HW_AFDBM */
 	msr	tcr_el1, x10
 	ret					// return to head.S
 ENDPROC(__cpu_setup)
