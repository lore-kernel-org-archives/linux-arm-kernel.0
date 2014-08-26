From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 26 Aug 2014 16:58:46 -0700
Subject: [PATCH v10 6/6] arm: KVM: ARMv7 dirty page logging 2nd stage page
 fault handling support
Message-ID: <1409097526-1225-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and dissolves huge pages to page tables.
In case migration is canceled huge pages may be used again.

Signed-off-by: Mario Smaduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index f176edf..0d79db04 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -47,6 +47,15 @@ static phys_addr_t hyp_idmap_vector;
 #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
 #define kvm_pud_huge(_x)	pud_huge(_x)
 
+static bool kvm_get_logging_state(unsigned long *dirty_bitmap)
+{
+#ifdef CONFIG_ARM
+	return !!dirty_bitmap;
+#else
+	return false;
+#endif
+}
+
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
 	/*
@@ -626,7 +635,8 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 }
 
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
-			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
+			  phys_addr_t addr, const pte_t *new_pte, bool iomap,
+			  bool logging_active)
 {
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
@@ -641,6 +651,18 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 		return 0;
 	}
 
+	/*
+	 * While dirty memory logging, clear PMD entry for huge page and split
+	 * into smaller pages, to track dirty memory at page granularity.
+	 */
+	if (logging_active && kvm_pmd_huge(*pmd)) {
+		phys_addr_t ipa = pmd_pfn(*pmd) << PAGE_SHIFT;
+
+		pmd_clear(pmd);
+		kvm_tlb_flush_vmid_ipa(kvm, ipa);
+		put_page(virt_to_page(pmd));
+	}
+
 	/* Create stage-2 page mappings - Level 2 */
 	if (pmd_none(*pmd)) {
 		if (!cache)
@@ -693,7 +715,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
-		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
+		ret = stage2_set_pte(kvm, &cache, addr, &pte, true, false);
 		spin_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -909,6 +931,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	pfn_t pfn;
+	bool logging_active = kvm_get_logging_state(memslot->dirty_bitmap);
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -919,7 +942,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	down_read(&current->mm->mmap_sem);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_vm_hugetlb_page(vma) && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
@@ -962,7 +985,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
-	if (!hugetlb && !force_pte)
+	if (!hugetlb && !force_pte && !logging_active)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
 	if (hugetlb) {
@@ -981,9 +1004,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_pfn_dirty(pfn);
 		}
 		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE);
-		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
+		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false,
+					logging_active);
 	}
 
+	if (write_fault)
+		mark_page_dirty(kvm, gfn);
 
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
@@ -1134,7 +1160,14 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	pte_t *pte = (pte_t *)data;
 
-	stage2_set_pte(kvm, NULL, gpa, pte, false);
+	/*
+	 * We can always call stage2_set_pte with logging_active == false,
+	 * because MMU notifiers will have unmapped a huge PMD before calling
+	 * ->change_pte() (which in turn calls kvm_set_spte_hva()) and therefore
+	 * stage2_set_pte() never needs to clear out a huge PMD through this
+	 * calling path.
+	 */
+	stage2_set_pte(kvm, NULL, gpa, pte, false, false);
 }
 
 
-- 
1.8.3.2
