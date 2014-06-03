From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 03 Jun 2014 16:19:27 -0700
Subject: [PATCH v7 4/4] arm: dirty page logging 2nd stage page fault handling
 support
In-Reply-To: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1401837567-5527-5-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for handling 2nd stage page faults during migration,
it disables faulting in huge pages, and disolves huge pages to page tables.
In case migration is canceled huge pages will be used again.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/mmu.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1c546c9..aca4fbf 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -966,6 +966,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	pfn_t pfn;
+	/* Get logging status, if dirty_bitmap is not NULL then logging is on */
+	bool logging_active = !!memslot->dirty_bitmap;
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -1019,10 +1021,16 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
-	if (!hugetlb && !force_pte)
+
+	/* When logging don't spend cycles to check for huge pages */
+	if (!hugetlb && !force_pte && !logging_active)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
-	if (hugetlb) {
+	/*
+	 * Force all not present/perm faults to PTE handling, address both
+	 * PMD and PTE faults
+	 */
+	if (hugetlb && !logging_active) {
 		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
 		new_pmd = pmd_mkhuge(new_pmd);
 		if (writable) {
@@ -1034,6 +1042,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	} else {
 		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
 		if (writable) {
+			/*
+			 * If pmd is  mapping a huge page then clear it and let
+			 * stage2_set_pte() create a pte table. At the sametime
+			 * you write protect the pte (PAGE_S2 pgprot_t).
+			 */
+			if (logging_active) {
+				pmd_t *pmd;
+				if (hugetlb) {
+					pfn += pte_index(fault_ipa);
+					gfn = fault_ipa >> PAGE_SHIFT;
+					new_pte = pfn_pte(pfn, PAGE_S2);
+				}
+				pmd = stage2_get_pmd(kvm, NULL, fault_ipa);
+				if (pmd && kvm_pmd_huge(*pmd))
+					clear_pmd_entry(kvm, pmd, fault_ipa);
+			}
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
 		}
@@ -1041,6 +1065,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
 	}
 
+	/*
+	 * Log the dirty page in dirty_bitmap[], call regardless if logging is
+	 * disabled or enabled both cases handled safely.
+	 * TODO: for larger page size mark mulitple dirty page bits for each
+	 *       4k page.
+	 */
+	if (writable)
+		mark_page_dirty(kvm, gfn);
 
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
-- 
1.7.9.5
