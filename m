From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 28 Apr 2014 17:55:08 -0700
Subject: [PATCH v4 4/5] add 2nd stage page fault handling during live migration
Message-ID: <535EF86C.7020506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and splits up existing huge pages.


Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c |   31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3442594..88f5503 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -978,6 +978,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	pfn_t pfn;
+	bool migration_active;
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1029,12 +1030,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 
 	spin_lock(&kvm->mmu_lock);
+	/* place inside lock to prevent race condition when whole VM is being
+	 * write proteced. Prevent race of huge page install when migration is
+	 * active.
+	 */
+	migration_active = vcpu->kvm->arch.migration_in_progress;
+
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
-	if (!hugetlb && !force_pte)
+
+	/* During migration don't rebuild huge pages */
+	if (!hugetlb && !force_pte && !migration_active)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
-	if (hugetlb) {
+	/* During migration don't install new huge pages */
+	if (hugetlb && !migration_active) {
 		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
 		new_pmd = pmd_mkhuge(new_pmd);
 		if (writable) {
@@ -1046,6 +1056,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	} else {
 		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
 		if (writable) {
+			/* First convert huge page pfn to normal 4k page pfn,
+			 * while  migration is in progress.
+			 * Second in migration mode and rare case where
+			 * splitting of huge pages fails check if pmd is
+			 * mapping a huge page if it is then clear it so
+			 * stage2_set_pte() can map in a small page.
+			 */
+			if (migration_active && hugetlb) {
+				pmd_t *pmd;
+				pfn += pte_index(fault_ipa);
+				new_pte = pfn_pte(pfn, PAGE_S2);
+				pmd = stage2_get_pmd(kvm, NULL, fault_ipa);
+				if (pmd && kvm_pmd_huge(*pmd))
+					clear_pmd_entry(kvm, pmd, fault_ipa);
+			}
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
 		}
@@ -1053,6 +1078,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
 	}
 
+	if (writable)
+		mark_page_dirty(kvm, gfn);
 
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
-- 
1.7.9.5
