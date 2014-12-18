From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 17 Dec 2014 18:07:29 -0800
Subject: [RESEND PATCH v15 07/11] KVM: arm: page logging 2nd stage fault
 handling
Message-ID: <1418868449-23397-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a followup to v15 patch series, with following changes:
- When clearing/dissolving a huge, PMD mark huge page range dirty, since
  the state of whole range is unknown. After the huge page is dissolved 
  dirty page logging is at page granularity.
- Correct comment due to misinterpreted test results

Retested, everything appears to work fine. 
  

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 73d506f..7e83a16 100644
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
+
+		pmd_clear(pmd);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+		put_page(virt_to_page(pmd));
+
+		gfn = (addr & PMD_MASK) >> PAGE_SHIFT;
+
+		/*
+		 * The write is to a huge page, mark the whole page dirty
+		 * including this gfn.
+		 */
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			mark_page_dirty(kvm, gfn + i);
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
@@ -1002,6 +1056,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool fault_ipa_uncached;
+	unsigned long logging_active = 0;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1009,6 +1064,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+	if (kvm_get_logging_state(memslot) && write_fault)
+		logging_active = KVM_S2PTE_FLAG_LOGGING_ACTIVE;
+
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	down_read(&current->mm->mmap_sem);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
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
1.7.9.5
