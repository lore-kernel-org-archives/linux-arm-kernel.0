From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:02 +0100
Subject: [GIT PULL 3/9] kvm: fix kvm_is_mmio_pfn() and rename to
 kvm_is_reserved_pfn()
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This reverts commit 85c8555ff0 ("KVM: check for !is_zero_pfn() in
kvm_is_mmio_pfn()") and renames the function to kvm_is_reserved_pfn.

The problem being addressed by the patch above was that some ARM code
based the memory mapping attributes of a pfn on the return value of
kvm_is_mmio_pfn(), whose name indeed suggests that such pfns should
be mapped as device memory.

However, kvm_is_mmio_pfn() doesn't do quite what it says on the tin,
and the existing non-ARM users were already using it in a way which
suggests that its name should probably have been 'kvm_is_reserved_pfn'
from the beginning, e.g., whether or not to call get_page/put_page on
it etc. This means that returning false for the zero page is a mistake
and the patch above should be reverted.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/ia64/kvm/kvm-ia64.c |  2 +-
 arch/x86/kvm/mmu.c       |  6 +++---
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 16 ++++++++--------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
index ec6b9ac..dbe46f4 100644
--- a/arch/ia64/kvm/kvm-ia64.c
+++ b/arch/ia64/kvm/kvm-ia64.c
@@ -1563,7 +1563,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 
 	for (i = 0; i < npages; i++) {
 		pfn = gfn_to_pfn(kvm, base_gfn + i);
-		if (!kvm_is_mmio_pfn(pfn)) {
+		if (!kvm_is_reserved_pfn(pfn)) {
 			kvm_set_pmt_entry(kvm, base_gfn + i,
 					pfn << PAGE_SHIFT,
 				_PAGE_AR_RWX | _PAGE_MA_WB);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ac1c4de..978f402 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -630,7 +630,7 @@ static int mmu_spte_clear_track_bits(u64 *sptep)
 	 * kvm mmu, before reclaiming the page, we should
 	 * unmap it from mmu first.
 	 */
-	WARN_ON(!kvm_is_mmio_pfn(pfn) && !page_count(pfn_to_page(pfn)));
+	WARN_ON(!kvm_is_reserved_pfn(pfn) && !page_count(pfn_to_page(pfn)));
 
 	if (!shadow_accessed_mask || old_spte & shadow_accessed_mask)
 		kvm_set_pfn_accessed(pfn);
@@ -2461,7 +2461,7 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 		spte |= PT_PAGE_SIZE_MASK;
 	if (tdp_enabled)
 		spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
-			kvm_is_mmio_pfn(pfn));
+			kvm_is_reserved_pfn(pfn));
 
 	if (host_writable)
 		spte |= SPTE_HOST_WRITEABLE;
@@ -2737,7 +2737,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 * PT_PAGE_TABLE_LEVEL and there would be no adjustment done
 	 * here.
 	 */
-	if (!is_error_noslot_pfn(pfn) && !kvm_is_mmio_pfn(pfn) &&
+	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
 	    level == PT_PAGE_TABLE_LEVEL &&
 	    PageTransCompound(pfn_to_page(pfn)) &&
 	    !has_wrprotected_page(vcpu->kvm, gfn, PT_DIRECTORY_LEVEL)) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ea53b04..a6059bd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -703,7 +703,7 @@ void kvm_arch_sync_events(struct kvm *kvm);
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu);
 void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
 
-bool kvm_is_mmio_pfn(pfn_t pfn);
+bool kvm_is_reserved_pfn(pfn_t pfn);
 
 struct kvm_irq_ack_notifier {
 	struct hlist_node link;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 25ffac9..3cee7b1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -107,10 +107,10 @@ EXPORT_SYMBOL_GPL(kvm_rebooting);
 
 static bool largepages_enabled = true;
 
-bool kvm_is_mmio_pfn(pfn_t pfn)
+bool kvm_is_reserved_pfn(pfn_t pfn)
 {
 	if (pfn_valid(pfn))
-		return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn));
+		return PageReserved(pfn_to_page(pfn));
 
 	return true;
 }
@@ -1321,7 +1321,7 @@ static pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 	else if ((vma->vm_flags & VM_PFNMAP)) {
 		pfn = ((addr - vma->vm_start) >> PAGE_SHIFT) +
 			vma->vm_pgoff;
-		BUG_ON(!kvm_is_mmio_pfn(pfn));
+		BUG_ON(!kvm_is_reserved_pfn(pfn));
 	} else {
 		if (async && vma_is_valid(vma, write_fault))
 			*async = true;
@@ -1427,7 +1427,7 @@ static struct page *kvm_pfn_to_page(pfn_t pfn)
 	if (is_error_noslot_pfn(pfn))
 		return KVM_ERR_PTR_BAD_PAGE;
 
-	if (kvm_is_mmio_pfn(pfn)) {
+	if (kvm_is_reserved_pfn(pfn)) {
 		WARN_ON(1);
 		return KVM_ERR_PTR_BAD_PAGE;
 	}
@@ -1456,7 +1456,7 @@ EXPORT_SYMBOL_GPL(kvm_release_page_clean);
 
 void kvm_release_pfn_clean(pfn_t pfn)
 {
-	if (!is_error_noslot_pfn(pfn) && !kvm_is_mmio_pfn(pfn))
+	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn))
 		put_page(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_release_pfn_clean);
@@ -1477,7 +1477,7 @@ static void kvm_release_pfn_dirty(pfn_t pfn)
 
 void kvm_set_pfn_dirty(pfn_t pfn)
 {
-	if (!kvm_is_mmio_pfn(pfn)) {
+	if (!kvm_is_reserved_pfn(pfn)) {
 		struct page *page = pfn_to_page(pfn);
 		if (!PageReserved(page))
 			SetPageDirty(page);
@@ -1487,14 +1487,14 @@ EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
 
 void kvm_set_pfn_accessed(pfn_t pfn)
 {
-	if (!kvm_is_mmio_pfn(pfn))
+	if (!kvm_is_reserved_pfn(pfn))
 		mark_page_accessed(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_set_pfn_accessed);
 
 void kvm_get_pfn(pfn_t pfn)
 {
-	if (!kvm_is_mmio_pfn(pfn))
+	if (!kvm_is_reserved_pfn(pfn))
 		get_page(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_get_pfn);
-- 
2.1.2.330.g565301e.dirty
