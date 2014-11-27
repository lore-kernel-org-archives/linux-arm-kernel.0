From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Nov 2014 19:40:59 +0100
Subject: [PATCH 4/5] arm/arm64: KVM: Introduce stage2_unmap_vm
In-Reply-To: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1417113660-23610-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new function to unmap user RAM regions in the stage2 page
tables.  This is needed on reboot (or when the guest turns off the MMU)
to ensure we fault in pages again and make the dcache, RAM, and icache
coherent.

Using unmap_stage2_range for the whole guest physical range does not
work, because that unmaps IO regions (such as the GIC) which will not be
recreated or in the best case faulted in on a page-by-page basis.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
There is an alternative version with more code reuse available here:
http://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vcpu_init_fixes-alternative

That version improves code-reuse at the cost of reduced code-readibility and
increased complexity.  I didn't test the alternative version or spend huge
amounts of time thinking about potential cleaner versions of the code, but
chose to include a pointer to the version as I can't make up my mind about the
preferred approach.  Input is welcome.

 arch/arm/include/asm/kvm_mmu.h   |  1 +
 arch/arm/kvm/mmu.c               | 65 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h |  1 +
 3 files changed, 67 insertions(+)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index acb0d57..4654c42 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -52,6 +52,7 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_boot_hyp_pgd(void);
 void free_hyp_pgds(void);
 
+void stage2_unmap_vm(struct kvm *kvm);
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 57a403a..b1f3c9a 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -611,6 +611,71 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
 	unmap_range(kvm, kvm->arch.pgd, start, size);
 }
 
+static void stage2_unmap_memslot(struct kvm *kvm,
+				 struct kvm_memory_slot *memslot)
+{
+	hva_t hva = memslot->userspace_addr;
+	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t size = PAGE_SIZE * memslot->npages;
+	hva_t reg_end = hva + size;
+
+	/*
+	 * A memory region could potentially cover multiple VMAs, and any holes
+	 * between them, so iterate over all of them to find out if we should
+	 * unmap any of them.
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
+		 * Take the intersection of this VMA with the memory region
+		 */
+		vm_start = max(hva, vma->vm_start);
+		vm_end = min(reg_end, vma->vm_end);
+
+		if (!(vma->vm_flags & VM_PFNMAP)) {
+			gpa_t gpa = addr + (vm_start - memslot->userspace_addr);
+			unmap_stage2_range(kvm, gpa, vm_end - vm_start);
+		}
+		hva = vm_end;
+	} while (hva < reg_end);
+}
+
+/**
+ * stage2_unmap_vm - Unmap Stage-2 RAM mappings
+ * @kvm: The struct kvm pointer
+ *
+ * Go through the memregions and unmap any reguler RAM
+ * backing memory already mapped to the VM.
+ */
+void stage2_unmap_vm(struct kvm *kvm)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int idx;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	spin_lock(&kvm->mmu_lock);
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(memslot, slots)
+		stage2_unmap_memslot(kvm, memslot);
+
+	spin_unlock(&kvm->mmu_lock);
+	srcu_read_unlock(&kvm->srcu, idx);
+}
+
 /**
  * kvm_free_stage2_pgd - free all stage-2 tables
  * @kvm:	The KVM struct pointer for the VM.
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 0caf7a5..061fed7 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -83,6 +83,7 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_boot_hyp_pgd(void);
 void free_hyp_pgds(void);
 
+void stage2_unmap_vm(struct kvm *kvm);
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-- 
2.1.2.330.g565301e.dirty
