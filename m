From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 23 Oct 2013 02:19:55 -0700
Subject: [PATCH 4/4] KVM: ARM: Transparent huge page (THP) support
In-Reply-To: <1382519995-19886-1-git-send-email-christoffer.dall@linaro.org>
References: <1382519995-19886-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1382519995-19886-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support transparent huge pages in KVM/ARM and KVM/ARM64.  The
transparent_hugepage_adjust is not very pretty, but this is also how
it's solved on x86 and seems to be simply an artifact on how THPs
behave.  This should eventually be shared across architectures if
possible, but that can always be changed down the road.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 745d8b1..3719583 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -42,7 +42,7 @@ static unsigned long hyp_idmap_start;
 static unsigned long hyp_idmap_end;
 static phys_addr_t hyp_idmap_vector;
 
-#define kvm_pmd_huge(_x)	(pmd_huge(_x))
+#define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
@@ -576,12 +576,53 @@ out:
 	return ret;
 }
 
+static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
+{
+	pfn_t pfn = *pfnp;
+	gfn_t gfn = *ipap >> PAGE_SHIFT;
+
+	if (PageTransCompound(pfn_to_page(pfn))) {
+		unsigned long mask;
+		/*
+		 * The address we faulted on is backed by a transparent huge
+		 * page.  However, because we map the compound huge page and
+		 * not the individual tail page, we need to transfer the
+		 * refcount to the head page.  We have to be careful that the
+		 * THP doesn't start to split while we are adjusting the
+		 * refcounts.
+		 *
+		 * We are sure this doesn't happen, because mmu_notifier_retry
+		 * was successful and we are holding the mmu_lock, so if this
+		 * THP is trying to split, it will be blocked in the mmu
+		 * notifier before touching any of the pages, specifically
+		 * before being able to call __split_huge_page_refcount().
+		 *
+		 * We can therefore safely transfer the refcount from PG_tail
+		 * to PG_head and switch the pfn from a tail page to the head
+		 * page accordingly.
+		 */
+		mask = PTRS_PER_PMD - 1;
+		VM_BUG_ON((gfn & mask) != (pfn & mask));
+		if (pfn & mask) {
+			*ipap &= PMD_MASK;
+			kvm_release_pfn_clean(pfn);
+			pfn &= ~mask;
+			kvm_get_pfn(pfn);
+			*pfnp = pfn;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot,
 			  unsigned long fault_status)
 {
 	int ret;
-	bool write_fault, writable, hugetlb = false;
+	bool write_fault, writable, hugetlb = false, force_pte = false;
 	unsigned long mmu_seq;
 	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
 	unsigned long hva = gfn_to_hva(vcpu->kvm, gfn);
@@ -602,6 +643,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (is_vm_hugetlb_page(vma)) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
+	} else {
+		/*
+		 * Pages belonging to VMAs not aligned to the PMD mapping
+		 * granularity cannot be mapped using block descriptors even
+		 * if the pages belong to a THP for the process, because the
+		 * stage-2 block descriptor will cover more than a single THP
+		 * and we loose atomicity for unmapping, updates, and splits
+		 * of the THP or other pages in the stage-2 block range.
+		 */
+		if (vma->vm_start & ~PMD_MASK)
+			force_pte = true;
 	}
 	up_read(&current->mm->mmap_sem);
 
@@ -629,6 +681,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
+	if (!hugetlb && !force_pte)
+		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
 	if (hugetlb) {
 		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
-- 
1.7.10.4
