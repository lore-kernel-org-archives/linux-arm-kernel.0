From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Oct 2014 17:00:32 +0200
Subject: [PATCH v4] arm/arm64: KVM: map MMIO regions at creation time
Message-ID: <1412953232-11699-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is really no point in faulting in memory regions page by page
if they are not backed by demand paged system RAM but by a linear
passthrough mapping of a host MMIO region. So instead, detect such
regions at setup time and install the mappings for the backing all
at once.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Changes since v3:
- reject the case where any of the VMAs being covered by a read-write memory
  region are read-only themselves

Changes since v2:
- moved the unmapping of moved/deleted regions to kvm_arch_flush_shadow_memslot
  so it occurs before parts of the new regions may be mapped in
  kvm_arch_prepare_memory_region
- allow memory regions with holes

Changes since v1:
- move this logic to kvm_arch_prepare_memory_region() so it can be invoked
  when moving memory regions as well as when creating memory regions
- as we are reasoning about memory regions now instead of memslots, all data
  is retrieved from the 'mem' argument which points to a struct
  kvm_userspace_memory_region
- minor tweaks to the logic flow

My test case (UEFI under QEMU/KVM) still executes correctly with this patch,
but more thorough testing with actual passthrough device regions is in order.

 arch/arm/kvm/mmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 37c1b35f90ad..fd7b1ebc5d32 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1132,13 +1132,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *old,
 				   enum kvm_mr_change change)
 {
-	gpa_t gpa = old->base_gfn << PAGE_SHIFT;
-	phys_addr_t size = old->npages << PAGE_SHIFT;
-	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
-		spin_lock(&kvm->mmu_lock);
-		unmap_stage2_range(kvm, gpa, size);
-		spin_unlock(&kvm->mmu_lock);
-	}
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
@@ -1146,7 +1139,69 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_userspace_memory_region *mem,
 				   enum kvm_mr_change change)
 {
-	return 0;
+	hva_t hva = mem->userspace_addr;
+	hva_t reg_end = hva + mem->memory_size;
+	bool writable = !(mem->flags & KVM_MEM_READONLY);
+	int ret = 0;
+
+	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE)
+		return 0;
+
+	/*
+	 * A memory region could potentially cover multiple VMAs, and any holes
+	 * between them, so iterate over all of them to find out if we can map
+	 * any of them right now.
+	 *
+	 *     +--------------------------------------------+
+	 * +---------------+----------------+   +----------------+
+	 * |   : VMA 1     |      VMA 2     |   |    VMA 3  :    |
+	 * +---------------+----------------+   +----------------+
+	 *     |               memory region                |
+	 *     +--------------------------------------------+
+	 */
+	do {
+		struct vm_area_struct *vma = find_vma(current->mm, hva);
+		hva_t vm_start, vm_end;
+
+		if (!vma || vma->vm_start >= reg_end)
+			break;
+
+		/*
+		 * Mapping a read-only VMA is only allowed if the
+		 * memory region is configured as read-only.
+		 */
+		if (writable && !(vma->vm_flags & VM_WRITE)) {
+			ret = -EPERM;
+			break;
+		}
+
+		/*
+		 * Take the intersection of this VMA with the memory region
+		 */
+		vm_start = max(hva, vma->vm_start);
+		vm_end = min(reg_end, vma->vm_end);
+
+		if (vma->vm_flags & VM_PFNMAP) {
+			gpa_t gpa = mem->guest_phys_addr +
+				    (vm_start - mem->userspace_addr);
+			phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) +
+					 vm_start - vma->vm_start;
+
+			ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
+						    vm_end - vm_start,
+						    writable);
+			if (ret)
+				break;
+		}
+		hva = vm_end;
+	} while (hva < reg_end);
+
+	if (ret) {
+		spin_lock(&kvm->mmu_lock);
+		unmap_stage2_range(kvm, mem->guest_phys_addr, mem->memory_size);
+		spin_unlock(&kvm->mmu_lock);
+	}
+	return ret;
 }
 
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
@@ -1171,4 +1226,10 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
+	gpa_t gpa = slot->base_gfn << PAGE_SHIFT;
+	phys_addr_t size = slot->npages << PAGE_SHIFT;
+
+	spin_lock(&kvm->mmu_lock);
+	unmap_stage2_range(kvm, gpa, size);
+	spin_unlock(&kvm->mmu_lock);
 }
-- 
1.8.3.2
