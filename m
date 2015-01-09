From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 08 Jan 2015 17:42:06 -0800
Subject: [PATCH RESEND v15 07/10] KVM: arm: page logging 2nd stage fault
 handling
Message-ID: <1420767727-20851-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and dissolves huge pages to normal pages.
In case migration is canceled huge pages are used again, if memory conditions
permit it. I applies cleanly on top patches series posted Dec 15:
https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012826.html

Patch number #11 of the series has be dropped.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---

Change Log since last RESEND:
- fixed bug exposed __get_user_pages_fast(), when region is writable prevent
  write protection of pte so we can handle a future write fault and mark page
  dirty.
- Removed marking entire huge page dirty on initial dirty log read.
- don't dissolve non-writable huge pages
- Made updates based on Christoffers comments
  - renamed logging status function to memslot_is_logging()
  - changes few values to bool from
  - streamlined user_mem_abort() to eliminate extra conditional checks
 
---
 arch/arm/kvm/mmu.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 73d506f..2bfe22d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -47,6 +47,18 @@ static phys_addr_t hyp_idmap_vector;
 #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
 #define kvm_pud_huge(_x)	pud_huge(_x)
 
+#define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
+#define KVM_S2PTE_FLAG_LOGGING_ACTIVE	(1UL << 1)
+
+static bool memslot_is_logging(struct kvm_memory_slot *memslot)
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
@@ -59,6 +71,25 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
+/**
+ * stage2_dissolve_pmd() - clear and flush huge PMD entry
+ * @kvm:	pointer to kvm structure.
+ * @addr:	IPA
+ * @pmd:	pmd pointer for IPA
+ *
+ * Function clears a PMD entry, flushes addr 1st and 2nd stage TLBs. Marks all
+ * pages in the range dirty.
+ */
+static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
+{
+	if (!kvm_pmd_huge(*pmd))
+		return;
+
+	pmd_clear(pmd);
+	kvm_tlb_flush_vmid_ipa(kvm, addr);
+	put_page(virt_to_page(pmd));
+}
+
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
 {
@@ -703,10 +734,13 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 }
 
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
-			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
+			  phys_addr_t addr, const pte_t *new_pte,
+			  unsigned long flags)
 {
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
+	bool iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
+	bool logging_active = flags & KVM_S2PTE_FLAG_LOGGING_ACTIVE;
 
 	/* Create stage-2 page table mapping - Levels 0 and 1 */
 	pmd = stage2_get_pmd(kvm, cache, addr);
@@ -718,6 +752,13 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
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
@@ -774,7 +815,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
-		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
+		ret = stage2_set_pte(kvm, &cache, addr, &pte,
+						KVM_S2PTE_FLAG_IS_IOMAP);
 		spin_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -1002,6 +1044,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool fault_ipa_uncached;
+	bool can_set_pte_rw = true;
+	unsigned long set_pte_flags = 0;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1009,6 +1053,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	down_read(&current->mm->mmap_sem);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
@@ -1065,6 +1110,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
+
+	/*
+	 * When logging is enabled general page fault handling changes:
+	 * -  Writable huge pages are dissolved on a read or write fault.
+	 * -  pte's are not allowed write permission on a read fault to
+	 *    writable region so future writes can be marked dirty
+	 * -  access to non-writable region is unchanged
+	 */
+	if (memslot_is_logging(memslot) && writable) {
+		set_pte_flags = KVM_S2PTE_FLAG_LOGGING_ACTIVE;
+		if (hugetlb) {
+			gfn += pte_index(fault_ipa);
+			pfn += pte_index(fault_ipa);
+			hugetlb = false;
+		}
+		force_pte = true;
+		if (!write_fault)
+			can_set_pte_rw = false;
+	}
+
 	if (!hugetlb && !force_pte)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
@@ -1082,16 +1147,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
 		pte_t new_pte = pfn_pte(pfn, mem_type);
-		if (writable) {
+
+		if (pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE))
+			set_pte_flags |= KVM_S2PTE_FLAG_IS_IOMAP;
+
+		/*
+		 * Don't set write permission, for non-writable region, and
+		 * for read fault to writable region while logging.
+		 */
+		if (writable && can_set_pte_rw) {
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
 		}
 		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
 					  fault_ipa_uncached);
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
-			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
+							set_pte_flags);
 	}
 
+	if (write_fault)
+		mark_page_dirty(kvm, gfn);
 
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
@@ -1242,7 +1317,14 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	pte_t *pte = (pte_t *)data;
 
-	stage2_set_pte(kvm, NULL, gpa, pte, false);
+	/*
+	 * We can always call stage2_set_pte with KVM_S2PTE_FLAG_LOGGING_ACTIVE
+	 * flag clear because MMU notifiers will have unmapped a huge PMD before
+	 * calling ->change_pte() (which in turn calls kvm_set_spte_hva()) and
+	 * therefore stage2_set_pte() never needs to clear out a huge PMD
+	 * through this calling path.
+	 */
+	stage2_set_pte(kvm, NULL, gpa, pte, 0);
 }
 
 
-- 
1.7.9.5
