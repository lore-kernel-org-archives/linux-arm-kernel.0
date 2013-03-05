From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:11 +0000
Subject: [PATCH 17/29] ARM: KVM: abstract most MMU operations
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move low level MMU-related operations to kvm_mmu.h. This makes
the MMU code reusable by the arm64 port.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h | 58 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/mmu.c             | 58 +++++++++---------------------------------
 2 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 421a20b..ac78493 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -19,6 +19,9 @@
 #ifndef __ARM_KVM_MMU_H__
 #define __ARM_KVM_MMU_H__
 
+#include <asm/cacheflush.h>
+#include <asm/pgalloc.h>
+
 int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_hyp_pmds(void);
@@ -36,6 +39,16 @@ phys_addr_t kvm_mmu_get_httbr(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
+static inline void kvm_set_pte(pte_t *pte, pte_t new_pte)
+{
+	pte_val(*pte) = new_pte;
+	/*
+	 * flush_pmd_entry just takes a void pointer and cleans the necessary
+	 * cache entries, so we can reuse the function for ptes.
+	 */
+	flush_pmd_entry(pte);
+}
+
 static inline bool kvm_is_write_fault(unsigned long hsr)
 {
 	unsigned long hsr_ec = hsr >> HSR_EC_SHIFT;
@@ -47,4 +60,49 @@ static inline bool kvm_is_write_fault(unsigned long hsr)
 		return true;
 }
 
+static inline void kvm_clean_pgd(pgd_t *pgd)
+{
+	clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
+}
+
+static inline void kvm_clean_pmd_entry(pmd_t *pmd)
+{
+	clean_pmd_entry(pmd);
+}
+
+static inline void kvm_clean_pte(pte_t *pte)
+{
+	clean_pte_table(pte);
+}
+
+static inline void kvm_set_s2pte_writable(pte_t *pte)
+{
+	pte_val(*pte) |= L_PTE_S2_RDWR;
+}
+
+struct kvm;
+
+static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+{
+	/*
+	 * If we are going to insert an instruction page and the icache is
+	 * either VIPT or PIPT, there is a potential problem where the host
+	 * (or another VM) may have used the same page as this guest, and we
+	 * read incorrect data from the icache.  If we're using a PIPT cache,
+	 * we can invalidate just that page, but if we are using a VIPT cache
+	 * we need to invalidate the entire icache - damn shame - as written
+	 * in the ARM ARM (DDI 0406C.b - Page B3-1393).
+	 *
+	 * VIVT caches are tagged using both the ASID and the VMID and doesn't
+	 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
+	 */
+	if (icache_is_pipt()) {
+		unsigned long hva = gfn_to_hva(kvm, gfn);
+		__cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
+	} else if (!icache_is_vivt_asid_tagged()) {
+		/* any kind of VIPT cache */
+		__flush_icache_all();
+	}
+}
+
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 8e9047a..6b4ea18 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -28,8 +28,6 @@
 #include <asm/kvm_mmio.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
-#include <asm/mach/map.h>
-#include <trace/events/kvm.h>
 
 #include "trace.h"
 
@@ -42,16 +40,6 @@ static void kvm_tlb_flush_vmid(struct kvm *kvm)
 	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
 }
 
-static void kvm_set_pte(pte_t *pte, pte_t new_pte)
-{
-	pte_val(*pte) = new_pte;
-	/*
-	 * flush_pmd_entry just takes a void pointer and cleans the necessary
-	 * cache entries, so we can reuse the function for ptes.
-	 */
-	flush_pmd_entry(pte);
-}
-
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
 {
@@ -290,7 +278,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 	VM_BUG_ON((unsigned long)pgd & (S2_PGD_SIZE - 1));
 
 	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
-	clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
+	kvm_clean_pgd(pgd);
 	kvm->arch.pgd = pgd;
 
 	return 0;
@@ -422,22 +410,22 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			return 0; /* ignore calls from kvm_set_spte_hva */
 		pmd = mmu_memory_cache_alloc(cache);
 		pud_populate(NULL, pud, pmd);
-		pmd += pmd_index(addr);
 		get_page(virt_to_page(pud));
-	} else
-		pmd = pmd_offset(pud, addr);
+	}
+
+	pmd = pmd_offset(pud, addr);
 
 	/* Create 2nd stage page table mapping - Level 2 */
 	if (pmd_none(*pmd)) {
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
 		pte = mmu_memory_cache_alloc(cache);
-		clean_pte_table(pte);
+		kvm_clean_pte(pte);
 		pmd_populate_kernel(NULL, pmd, pte);
-		pte += pte_index(addr);
 		get_page(virt_to_page(pmd));
-	} else
-		pte = pte_offset_kernel(pmd, addr);
+	}
+
+	pte = pte_offset_kernel(pmd, addr);
 
 	if (iomap && pte_present(*pte))
 		return -EFAULT;
@@ -473,7 +461,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	pfn = __phys_to_pfn(pa);
 
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
-		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE | L_PTE_S2_RDWR);
+		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
+		kvm_set_s2pte_writable(&pte);
 
 		ret = mmu_topup_memory_cache(&cache, 2, 2);
 		if (ret)
@@ -492,29 +481,6 @@ out:
 	return ret;
 }
 
-static void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
-{
-	/*
-	 * If we are going to insert an instruction page and the icache is
-	 * either VIPT or PIPT, there is a potential problem where the host
-	 * (or another VM) may have used the same page as this guest, and we
-	 * read incorrect data from the icache.  If we're using a PIPT cache,
-	 * we can invalidate just that page, but if we are using a VIPT cache
-	 * we need to invalidate the entire icache - damn shame - as written
-	 * in the ARM ARM (DDI 0406C.b - Page B3-1393).
-	 *
-	 * VIVT caches are tagged using both the ASID and the VMID and doesn't
-	 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
-	 */
-	if (icache_is_pipt()) {
-		unsigned long hva = gfn_to_hva(kvm, gfn);
-		__cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
-	} else if (!icache_is_vivt_asid_tagged()) {
-		/* any kind of VIPT cache */
-		__flush_icache_all();
-	}
-}
-
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  gfn_t gfn, struct kvm_memory_slot *memslot,
 			  unsigned long fault_status)
@@ -560,7 +526,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
 		goto out_unlock;
 	if (writable) {
-		pte_val(new_pte) |= L_PTE_S2_RDWR;
+		kvm_set_s2pte_writable(&new_pte);
 		kvm_set_pfn_dirty(pfn);
 	}
 	stage2_set_pte(vcpu->kvm, memcache, fault_ipa, &new_pte, false);
@@ -774,7 +740,7 @@ void kvm_clear_hyp_idmap(void)
 		pmd = pmd_offset(pud, addr);
 
 		pud_clear(pud);
-		clean_pmd_entry(pmd);
+		kvm_clean_pmd_entry(pmd);
 		pmd_free(NULL, (pmd_t *)((unsigned long)pmd & PAGE_MASK));
 	} while (pgd++, addr = next, addr < end);
 }
-- 
1.7.12.4
