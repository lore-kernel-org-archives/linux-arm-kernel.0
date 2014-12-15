From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sun, 14 Dec 2014 23:28:04 -0800
Subject: [PATCH v15 07/11] KVM: arm: page logging 2nd stage fault handling
In-Reply-To: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1418628488-3696-8-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and dissolves huge pages to page tables.
In case migration is canceled huge pages are used again. 

Also since last version an issues was found on SMP host running SMP Guest 
and clearing huge TLB entry. Multiple CPUs can write to same huge page range 
so all pages in the range are marked dirty after the TLB is flushed. It didn't 
showup on hardware, but appeared on Fast Models perhpas the TLB flush is 
slower. To prevent clutter in user_mem_abort() refactored some code into 
functions.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 73d506f..dc763bb 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -47,6 +47,18 @@ static phys_addr_t hyp_idmap_vector;
 #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
 #define kvm_pud_huge(_x)	pud_huge(_x)
 
+#define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
+#define KVM_S2PTE_FLAG_LOGGING_ACTIVE	(1UL << 1)
+
+static bool kvm_get_logging_state(struct kvm_memory_slot *memslot)
+{
+#ifdef CONFIG_ARM
+	return !!memslot->dirty_bitmap;
+#else
+	return false;
+#endif
+}
+
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
 	/*
@@ -59,6 +71,37 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
+/**
+ * stage2_dissolve_pmd() - clear and flush huge PMD entry
+ * @kvm:	pointer to kvm structure.
+ * @addr	IPA
+ * @pmd	pmd pointer for IPA
+ *
+ * Function clears a PMD entry, flushes addr 1st and 2nd stage TLBs. Marks all
+ * pages in the range dirty.
+ */
+void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
+{
+	gfn_t gfn;
+	int i;
+
+	if (kvm_pmd_huge(*pmd)) {
+		pmd_clear(pmd);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+		put_page(virt_to_page(pmd));
+#ifdef CONFIG_SMP
+		gfn = (addr & PMD_MASK) >> PAGE_SHIFT;
+
+		/*
+		 * Mark all pages in PMD range dirty, in case other CPUs are
+		 * writing to it.
+		 */
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			mark_page_dirty(kvm, gfn + i);
+#endif
+	}
+}
+
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
 {
@@ -703,10 +746,13 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 }
 
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
-			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
+			  phys_addr_t addr, const pte_t *new_pte,
+			  unsigned long flags)
 {
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
+	unsigned long iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
+	unsigned long logging_active = flags & KVM_S2PTE_FLAG_LOGGING_ACTIVE;
 
 	/* Create stage-2 page table mapping - Levels 0 and 1 */
 	pmd = stage2_get_pmd(kvm, cache, addr);
@@ -718,6 +764,13 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 		return 0;
 	}
 
+	/*
+	 * While dirty page logging - dissolve huge PMD, then continue on to
+	 * allocate page.
+	 */
+	if (logging_active)
+		stage2_dissolve_pmd(kvm, addr, pmd);
+
 	/* Create stage-2 page mappings - Level 2 */
 	if (pmd_none(*pmd)) {
 		if (!cache)
@@ -774,7 +827,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
-		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
+		ret = stage2_set_pte(kvm, &cache, addr, &pte,
+						KVM_S2PTE_FLAG_IS_IOMAP);
 		spin_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -1002,6 +1056,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool fault_ipa_uncached;
+	unsigned long logging_active = 0;
+
+	if (kvm_get_logging_state(memslot))
+		logging_active = KVM_S2PTE_FLAG_LOGGING_ACTIVE;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1018,7 +1076,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_vm_hugetlb_page(vma) && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
@@ -1065,7 +1123,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
-	if (!hugetlb && !force_pte)
+	if (!hugetlb && !force_pte && !logging_active)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
 	fault_ipa_uncached = memslot->flags & KVM_MEMSLOT_INCOHERENT;
@@ -1082,17 +1140,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
 		pte_t new_pte = pfn_pte(pfn, mem_type);
+		unsigned long flags = logging_active;
+
+		if (pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE))
+			flags |= KVM_S2PTE_FLAG_IS_IOMAP;
+
 		if (writable) {
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
 		}
 		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
 					  fault_ipa_uncached);
-		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
-			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
+		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, flags);
 	}
 
-
+	if (write_fault)
+		mark_page_dirty(kvm, gfn);
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
@@ -1242,7 +1305,14 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	pte_t *pte = (pte_t *)data;
 
-	stage2_set_pte(kvm, NULL, gpa, pte, false);
+	/*
+	 * We can always call stage2_set_pte with KVM_S2PTE_FLAG_LOGGING_ACTIVE
+	 * flag set because MMU notifiers will have unmapped a huge PMD before
+	 * calling ->change_pte() (which in turn calls kvm_set_spte_hva()) and
+	 * therefore stage2_set_pte() never needs to clear out a huge PMD
+	 * through this calling path.
+	 */
+	stage2_set_pte(kvm, NULL, gpa, pte, 0);
 }
 
 
-- 
1.9.1
