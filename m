From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 18 Jun 2014 18:31:40 -0700
Subject: [PATCH v8 4/4] arm: dirty page logging 2nd stage page fault handling
 support
In-Reply-To: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
References: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1403141500-31010-5-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and dissolves huge pages to page tables.
In case migration is canceled huge pages will be used again. For ARMv8
logging is hardcoded to false.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1caf511..d49df28 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -641,7 +641,8 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 }
 
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
-			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
+			  phys_addr_t addr, const pte_t *new_pte, bool iomap,
+			  bool logging_active)
 {
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
@@ -656,6 +657,15 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 		return 0;
 	}
 
+	/*
+	 * While dirty memory logging, clear PMD entry for huge page and split
+	 * into smaller pages, to track dirty memory at page granularity.
+	 */
+	if (logging_active && kvm_pmd_huge(*pmd)) {
+		phys_addr_t ipa = pmd_pfn(*pmd) << PAGE_SHIFT;
+		clear_pmd_entry(kvm, pmd, ipa);
+	}
+
 	/* Create stage-2 page mappings - Level 2 */
 	if (pmd_none(*pmd)) {
 		if (!cache)
@@ -708,7 +718,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
-		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
+		ret = stage2_set_pte(kvm, &cache, addr, &pte, true, false);
 		spin_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -925,6 +935,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	pfn_t pfn;
+	/* Get logging status, if dirty_bitmap is not NULL then logging is on */
+#ifdef CONFIG_ARM
+	bool logging_active = !!memslot->dirty_bitmap;
+#else
+	bool logging_active = false;
+#endif
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -935,7 +951,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	down_read(&current->mm->mmap_sem);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_vm_hugetlb_page(vma) && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
@@ -978,7 +994,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
-	if (!hugetlb && !force_pte)
+	if (!hugetlb && !force_pte && !logging_active)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
 	if (hugetlb) {
@@ -997,9 +1013,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
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
@@ -1150,7 +1169,7 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	pte_t *pte = (pte_t *)data;
 
-	stage2_set_pte(kvm, NULL, gpa, pte, false);
+	stage2_set_pte(kvm, NULL, gpa, pte, false, false);
 }
 
 
-- 
1.7.9.5
