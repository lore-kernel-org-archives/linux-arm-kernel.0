From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:40 +0100
Subject: [GIT PULL 11/36] KVM: arm: page logging 2nd stage fault handling
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-12-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mario Smarduch <m.smarduch@samsung.com>

This patch adds support for 2nd stage page fault handling while dirty page
logging. On huge page faults, huge pages are dissolved to normal pages, and
rebuilding of 2nd stage huge pages is blocked. In case migration is
canceled this restriction is removed and huge pages may be rebuilt again.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 565e903..6685c68 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -47,6 +47,18 @@ static phys_addr_t hyp_idmap_vector;
 #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
 #define kvm_pud_huge(_x)	pud_huge(_x)
 
+#define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
+#define KVM_S2_FLAG_LOGGING_ACTIVE	(1UL << 1)
+
+static bool memslot_is_logging(struct kvm_memory_slot *memslot)
+{
+#ifdef CONFIG_ARM
+	return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
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
@@ -768,10 +799,15 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 }
 
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
-			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
+			  phys_addr_t addr, const pte_t *new_pte,
+			  unsigned long flags)
 {
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
+	bool iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
+	bool logging_active = flags & KVM_S2_FLAG_LOGGING_ACTIVE;
+
+	VM_BUG_ON(logging_active && !cache);
 
 	/* Create stage-2 page table mapping - Levels 0 and 1 */
 	pmd = stage2_get_pmd(kvm, cache, addr);
@@ -783,6 +819,13 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
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
@@ -839,7 +882,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
-		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
+		ret = stage2_set_pte(kvm, &cache, addr, &pte,
+						KVM_S2PTE_FLAG_IS_IOMAP);
 		spin_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -1067,6 +1111,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool fault_ipa_uncached;
+	bool logging_active = memslot_is_logging(memslot);
+	unsigned long flags = 0;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1083,7 +1129,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_vm_hugetlb_page(vma) && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
@@ -1124,12 +1170,30 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (is_error_pfn(pfn))
 		return -EFAULT;
 
-	if (kvm_is_device_pfn(pfn))
+	if (kvm_is_device_pfn(pfn)) {
 		mem_type = PAGE_S2_DEVICE;
+		flags |= KVM_S2PTE_FLAG_IS_IOMAP;
+	} else if (logging_active) {
+		/*
+		 * Faults on pages in a memslot with logging enabled
+		 * should not be mapped with huge pages (it introduces churn
+		 * and performance degradation), so force a pte mapping.
+		 */
+		force_pte = true;
+		flags |= KVM_S2_FLAG_LOGGING_ACTIVE;
+
+		/*
+		 * Only actually map the page as writable if this was a write
+		 * fault.
+		 */
+		if (!write_fault)
+			writable = false;
+	}
 
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
+
 	if (!hugetlb && !force_pte)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
@@ -1147,17 +1211,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
 		pte_t new_pte = pfn_pte(pfn, mem_type);
+
 		if (writable) {
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
+			mark_page_dirty(kvm, gfn);
 		}
 		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
 					  fault_ipa_uncached);
-		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
-			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
+		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, flags);
 	}
 
-
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
@@ -1307,7 +1371,14 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
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
 
 
@@ -1461,7 +1532,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	bool writable = !(mem->flags & KVM_MEM_READONLY);
 	int ret = 0;
 
-	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE)
+	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE &&
+			change != KVM_MR_FLAGS_ONLY)
 		return 0;
 
 	/*
@@ -1512,6 +1584,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) +
 					 vm_start - vma->vm_start;
 
+			/* IO region dirty page logging not allowed */
+			if (memslot->flags & KVM_MEM_LOG_DIRTY_PAGES)
+				return -EINVAL;
+
 			ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
 						    vm_end - vm_start,
 						    writable);
@@ -1521,6 +1597,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		hva = vm_end;
 	} while (hva < reg_end);
 
+	if (change == KVM_MR_FLAGS_ONLY)
+		return ret;
+
 	spin_lock(&kvm->mmu_lock);
 	if (ret)
 		unmap_stage2_range(kvm, mem->guest_phys_addr, mem->memory_size);
-- 
2.1.2.330.g565301e.dirty
