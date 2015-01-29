From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 29 Jan 2015 23:37:56 +0100
Subject: [GIT PULL 2/3] arm/arm64: KVM: Invalidate data cache on unmap
In-Reply-To: <1422571077-14576-1-git-send-email-christoffer.dall@linaro.org>
References: <1422571077-14576-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422571077-14576-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Let's assume a guest has created an uncached mapping, and written
to that page. Let's also assume that the host uses a cache-coherent
IO subsystem. Let's finally assume that the host is under memory
pressure and starts to swap things out.

Before this "uncached" page is evicted, we need to make sure
we invalidate potential speculated, clean cache lines that are
sitting there, or the IO subsystem is going to swap out the
cached view, loosing the data that has been written directly
into memory.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h   | 31 +++++++++++++++
 arch/arm/kvm/mmu.c               | 82 ++++++++++++++++++++++++++++++++--------
 arch/arm64/include/asm/kvm_mmu.h | 18 +++++++++
 3 files changed, 116 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 286644c..552c31f 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -44,6 +44,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
 
@@ -188,6 +189,36 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 	}
 }
 
+static inline void __kvm_flush_dcache_pte(pte_t pte)
+{
+	void *va = kmap_atomic(pte_page(pte));
+
+	kvm_flush_dcache_to_poc(va, PAGE_SIZE);
+
+	kunmap_atomic(va);
+}
+
+static inline void __kvm_flush_dcache_pmd(pmd_t pmd)
+{
+	unsigned long size = PMD_SIZE;
+	pfn_t pfn = pmd_pfn(pmd);
+
+	while (size) {
+		void *va = kmap_atomic_pfn(pfn);
+
+		kvm_flush_dcache_to_poc(va, PAGE_SIZE);
+
+		pfn++;
+		size -= PAGE_SIZE;
+
+		kunmap_atomic(va);
+	}
+}
+
+static inline void __kvm_flush_dcache_pud(pud_t pud)
+{
+}
+
 #define kvm_virt_to_phys(x)		virt_to_idmap((unsigned long)(x))
 
 void kvm_set_way_flush(struct kvm_vcpu *vcpu);
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 106737e..78e68ab 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -58,6 +58,26 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
+/*
+ * D-Cache management functions. They take the page table entries by
+ * value, as they are flushing the cache using the kernel mapping (or
+ * kmap on 32bit).
+ */
+static void kvm_flush_dcache_pte(pte_t pte)
+{
+	__kvm_flush_dcache_pte(pte);
+}
+
+static void kvm_flush_dcache_pmd(pmd_t pmd)
+{
+	__kvm_flush_dcache_pmd(pmd);
+}
+
+static void kvm_flush_dcache_pud(pud_t pud)
+{
+	__kvm_flush_dcache_pud(pud);
+}
+
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
 {
@@ -119,6 +139,26 @@ static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
 	put_page(virt_to_page(pmd));
 }
 
+/*
+ * Unmapping vs dcache management:
+ *
+ * If a guest maps certain memory pages as uncached, all writes will
+ * bypass the data cache and go directly to RAM.  However, the CPUs
+ * can still speculate reads (not writes) and fill cache lines with
+ * data.
+ *
+ * Those cache lines will be *clean* cache lines though, so a
+ * clean+invalidate operation is equivalent to an invalidate
+ * operation, because no cache lines are marked dirty.
+ *
+ * Those clean cache lines could be filled prior to an uncached write
+ * by the guest, and the cache coherent IO subsystem would therefore
+ * end up writing old data to disk.
+ *
+ * This is why right after unmapping a page/section and invalidating
+ * the corresponding TLBs, we call kvm_flush_dcache_p*() to make sure
+ * the IO subsystem will never hit in the cache.
+ */
 static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
 		       phys_addr_t addr, phys_addr_t end)
 {
@@ -128,9 +168,16 @@ static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
 	start_pte = pte = pte_offset_kernel(pmd, addr);
 	do {
 		if (!pte_none(*pte)) {
+			pte_t old_pte = *pte;
+
 			kvm_set_pte(pte, __pte(0));
-			put_page(virt_to_page(pte));
 			kvm_tlb_flush_vmid_ipa(kvm, addr);
+
+			/* No need to invalidate the cache for device mappings */
+			if ((pte_val(old_pte) & PAGE_S2_DEVICE) != PAGE_S2_DEVICE)
+				kvm_flush_dcache_pte(old_pte);
+
+			put_page(virt_to_page(pte));
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
@@ -149,8 +196,13 @@ static void unmap_pmds(struct kvm *kvm, pud_t *pud,
 		next = kvm_pmd_addr_end(addr, end);
 		if (!pmd_none(*pmd)) {
 			if (kvm_pmd_huge(*pmd)) {
+				pmd_t old_pmd = *pmd;
+
 				pmd_clear(pmd);
 				kvm_tlb_flush_vmid_ipa(kvm, addr);
+
+				kvm_flush_dcache_pmd(old_pmd);
+
 				put_page(virt_to_page(pmd));
 			} else {
 				unmap_ptes(kvm, pmd, addr, next);
@@ -173,8 +225,13 @@ static void unmap_puds(struct kvm *kvm, pgd_t *pgd,
 		next = kvm_pud_addr_end(addr, end);
 		if (!pud_none(*pud)) {
 			if (pud_huge(*pud)) {
+				pud_t old_pud = *pud;
+
 				pud_clear(pud);
 				kvm_tlb_flush_vmid_ipa(kvm, addr);
+
+				kvm_flush_dcache_pud(old_pud);
+
 				put_page(virt_to_page(pud));
 			} else {
 				unmap_pmds(kvm, pud, addr, next);
@@ -209,10 +266,9 @@ static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		if (!pte_none(*pte)) {
-			hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
-			kvm_flush_dcache_to_poc((void*)hva, PAGE_SIZE);
-		}
+		if (!pte_none(*pte) &&
+		    (pte_val(*pte) & PAGE_S2_DEVICE) != PAGE_S2_DEVICE)
+			kvm_flush_dcache_pte(*pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
@@ -226,12 +282,10 @@ static void stage2_flush_pmds(struct kvm *kvm, pud_t *pud,
 	do {
 		next = kvm_pmd_addr_end(addr, end);
 		if (!pmd_none(*pmd)) {
-			if (kvm_pmd_huge(*pmd)) {
-				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
-				kvm_flush_dcache_to_poc((void*)hva, PMD_SIZE);
-			} else {
+			if (kvm_pmd_huge(*pmd))
+				kvm_flush_dcache_pmd(*pmd);
+			else
 				stage2_flush_ptes(kvm, pmd, addr, next);
-			}
 		}
 	} while (pmd++, addr = next, addr != end);
 }
@@ -246,12 +300,10 @@ static void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
 	do {
 		next = kvm_pud_addr_end(addr, end);
 		if (!pud_none(*pud)) {
-			if (pud_huge(*pud)) {
-				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
-				kvm_flush_dcache_to_poc((void*)hva, PUD_SIZE);
-			} else {
+			if (pud_huge(*pud))
+				kvm_flush_dcache_pud(*pud);
+			else
 				stage2_flush_pmds(kvm, pud, addr, next);
-			}
 		}
 	} while (pud++, addr = next, addr != end);
 }
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 92d22e9..cbdc236 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -258,6 +258,24 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 	}
 }
 
+static inline void __kvm_flush_dcache_pte(pte_t pte)
+{
+	struct page *page = pte_page(pte);
+	kvm_flush_dcache_to_poc(page_address(page), PAGE_SIZE);
+}
+
+static inline void __kvm_flush_dcache_pmd(pmd_t pmd)
+{
+	struct page *page = pmd_page(pmd);
+	kvm_flush_dcache_to_poc(page_address(page), PMD_SIZE);
+}
+
+static inline void __kvm_flush_dcache_pud(pud_t pud)
+{
+	struct page *page = pud_page(pud);
+	kvm_flush_dcache_to_poc(page_address(page), PUD_SIZE);
+}
+
 #define kvm_virt_to_phys(x)		__virt_to_phys((unsigned long)(x))
 
 void kvm_set_way_flush(struct kvm_vcpu *vcpu);
-- 
2.1.2.330.g565301e.dirty
