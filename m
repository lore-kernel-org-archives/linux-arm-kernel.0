From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 14:21:02 +0100
Subject: [PATCH v2 14/17] kvm-arm: Cleanup kvm_* wrappers
In-Reply-To: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1460640065-27658-15-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have switched to explicit page table routines,
get rid of the obsolete kvm_* wrappers.

Also, kvm_tlb_flush_vmid_by_ipa is now called only on stage2
page tables, hence get rid of the redundant check.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   |   20 --------------------
 arch/arm/kvm/mmu.c               |    9 +--------
 arch/arm64/include/asm/kvm_mmu.h |   24 ------------------------
 3 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 901c1ea..50aa901 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -136,32 +136,12 @@ static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
 	return (pmd_val(*pmd) & L_PMD_S2_RDWR) == L_PMD_S2_RDONLY;
 }
 
-
-/* Open coded p*d_addr_end that can deal with 64bit addresses */
-#define kvm_pgd_addr_end(addr, end)					\
-({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
-
-#define kvm_pud_addr_end(addr,end)		(end)
-
-#define kvm_pmd_addr_end(addr, end)					\
-({	u64 __boundary = ((addr) + PMD_SIZE) & PMD_MASK;		\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
-
-#define kvm_pgd_index(addr)			pgd_index(addr)
-
 static inline bool kvm_page_empty(void *ptr)
 {
 	struct page *ptr_page = virt_to_page(ptr);
 	return page_count(ptr_page) == 1;
 }
 
-#define kvm_pte_table_empty(kvm, ptep) kvm_page_empty(ptep)
-#define kvm_pmd_table_empty(kvm, pmdp) kvm_page_empty(pmdp)
-#define kvm_pud_table_empty(kvm, pudp) (0)
-
 #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
 #define hyp_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
 #define hyp_pud_table_empty(pudp) (0)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index f2a6d9b..d3fa96e 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -66,14 +66,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
-	/*
-	 * This function also gets called when dealing with HYP page
-	 * tables. As HYP doesn't have an associated struct kvm (and
-	 * the HYP page tables are fairly static), we don't do
-	 * anything there.
-	 */
-	if (kvm)
-		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
+	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
 /*
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index edf3c62..a3c0d05 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -153,13 +153,6 @@ static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
 	return (pmd_val(*pmd) & PMD_S2_RDWR) == PMD_S2_RDONLY;
 }
 
-
-#define kvm_pgd_addr_end(addr, end)	pgd_addr_end(addr, end)
-#define kvm_pud_addr_end(addr, end)	pud_addr_end(addr, end)
-#define kvm_pmd_addr_end(addr, end)	pmd_addr_end(addr, end)
-
-#define kvm_pgd_index(addr)	(((addr) >> PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1))
-
 static inline void *kvm_get_hwpgd(struct kvm *kvm)
 {
 	pgd_t *pgd = kvm->arch.pgd;
@@ -232,23 +225,6 @@ static inline bool kvm_page_empty(void *ptr)
 	return page_count(ptr_page) == 1;
 }
 
-#define kvm_pte_table_empty(kvm, ptep) kvm_page_empty(ptep)
-
-#ifdef __PAGETABLE_PMD_FOLDED
-#define kvm_pmd_table_empty(kvm, pmdp) (0)
-#else
-#define kvm_pmd_table_empty(kvm, pmdp) \
-	(kvm_page_empty(pmdp) && (!(kvm) || KVM_PREALLOC_LEVEL < 2))
-#endif
-
-#ifdef __PAGETABLE_PUD_FOLDED
-#define kvm_pud_table_empty(kvm, pudp) (0)
-#else
-#define kvm_pud_table_empty(kvm, pudp) \
-	(kvm_page_empty(pudp) && (!(kvm) || KVM_PREALLOC_LEVEL < 1))
-#endif
-
-
 #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
 
 #ifdef __PAGETABLE_PMD_FOLDED
-- 
1.7.9.5
