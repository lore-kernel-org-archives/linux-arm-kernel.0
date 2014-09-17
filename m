From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Sep 2014 14:56:21 -0700
Subject: [PATCH 6/6] arm/arm64: KVM: map MMIO regions at creation time
In-Reply-To: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1410990981-665-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is really no point in faulting in memory regions page by page
if they are not backed by demand paged system RAM but by a linear
passthrough mapping of a host MMIO region.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kvm/mmu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index fe53c3a30383..b153ef0c6d9f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1162,7 +1162,55 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			    unsigned long npages)
 {
-	return 0;
+	hva_t hva = slot->userspace_addr;
+	phys_addr_t gpa = slot->base_gfn << PAGE_SHIFT;
+	phys_addr_t size = slot->npages << PAGE_SHIFT;
+	int ret = 0;
+
+	/*
+	 * A memslot could potentially cover multiple VMAs, so iterate
+	 * over all of them to find out if we can map any of them right now.
+	 *
+	 *     +--------------------------------------------+
+	 * +---+---------+-------------------+--------------+----+
+	 * |   : VMA 1   |       VMA 2       |       VMA 3  :    |
+	 * +---+---------+-------------------+--------------+----+
+	 *     |                   memslot                  |
+	 *     +--------------------------------------------+
+	 */
+	do {
+		struct vm_area_struct *vma = find_vma(current->mm, hva);
+		hva_t start, end;
+
+		if (!vma || vma->vm_start > hva) {
+			ret = -EFAULT;
+			break;
+		}
+
+		start = max(slot->userspace_addr, vma->vm_start);
+		end = min((hva_t)(slot->userspace_addr + size), vma->vm_end);
+
+		if (vma->vm_flags & VM_PFNMAP) {
+			phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) + start -
+					 vma->vm_start;
+			bool writable = vma->vm_flags & VM_WRITE &&
+					!(slot->flags & KVM_MEM_READONLY);
+
+			ret = kvm_phys_addr_ioremap(kvm, gpa, pa, end - start,
+						    writable);
+			if (ret)
+				break;
+		}
+		hva += end - start;
+		gpa += end - start;
+	} while (hva < slot->userspace_addr + size);
+
+	if (ret) {
+		spin_lock(&kvm->mmu_lock);
+		unmap_stage2_range(kvm, slot->base_gfn << PAGE_SHIFT, size);
+		spin_unlock(&kvm->mmu_lock);
+	}
+	return ret;
 }
 
 void kvm_arch_memslots_updated(struct kvm *kvm)
-- 
1.8.3.2
