From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 07 May 2014 17:40:16 -0700
Subject: [PATCH v5 4/4] add 2nd stage page fault handling during live migration
In-Reply-To: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
References: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1399509616-4632-5-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and splits up existing huge pages.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1458b6e..b0633dc 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1034,6 +1034,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	pfn_t pfn;
+	bool migration_active;
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1085,12 +1086,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 
 	spin_lock(&kvm->mmu_lock);
+
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
+	/* During migration no need rebuild huge pages */
+	if (!hugetlb && !force_pte && !migration_active)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
-	if (hugetlb) {
+	/* During migration don't install new huge pages */
+	if (hugetlb && !migration_active) {
 		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
 		new_pmd = pmd_mkhuge(new_pmd);
 		if (writable) {
@@ -1102,6 +1113,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	} else {
 		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
 		if (writable) {
+			/* First convert huge page pfn to small page pfn,
+			 * while  migration is in progress.
+			 * Second if pmd is  mapping a huge page then
+			 * clear pmd so stage2_set_pte() can split the pmd.
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
@@ -1109,6 +1133,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
 	}
 
+	if (writable)
+		mark_page_dirty(kvm, gfn);
 
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
-- 
1.7.9.5
