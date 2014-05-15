From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 May 2014 11:27:31 -0700
Subject: [PATCH v6 4/4] add 2nd stage page fault handling during live migration
In-Reply-To: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1400178451-4984-5-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and splits up existing huge pages.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index b939312..10e7bf6 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1002,6 +1002,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	pfn_t pfn;
+	bool migration_active;
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1053,12 +1054,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 
 	spin_lock(&kvm->mmu_lock);
+
+	/*
+	 * Place inside lock to prevent race condition when whole VM is being
+	 * write proteced. Prevent race of huge page install when migration is
+	 * active.
+	 */
+	migration_active = vcpu->kvm->arch.migration_in_progress;
+
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
-	if (!hugetlb && !force_pte)
+
+	/* When migrating don't spend cycles coalescing huge pages */
+	if (!hugetlb && !force_pte && !migration_active)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
-	if (hugetlb) {
+	/* During migration don't install huge pages */
+	if (hugetlb && !migration_active) {
 		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
 		new_pmd = pmd_mkhuge(new_pmd);
 		if (writable) {
@@ -1069,6 +1081,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
 		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
+
+		/*
+		 * If pmd is  mapping a huge page then split it up into
+		 * small pages, when doing live migration.
+		 */
+		if (migration_active) {
+			pmd_t *pmd;
+			if (hugetlb) {
+				pfn += pte_index(fault_ipa);
+				gfn = fault_ipa >> PAGE_SHIFT;
+			}
+			new_pte = pfn_pte(pfn, PAGE_S2);
+			pmd = stage2_get_pmd(kvm, NULL, fault_ipa);
+			if (pmd && kvm_pmd_huge(*pmd))
+				clear_pmd_entry(kvm, pmd, fault_ipa);
+		}
+
 		if (writable) {
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
@@ -1077,6 +1106,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
 	}
 
+	/* Assuming 4k pages, set one bit/page in memslot dirty_bitmap[] */
+	if (writable)
+		mark_page_dirty(kvm, gfn);
 
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
-- 
1.7.9.5
