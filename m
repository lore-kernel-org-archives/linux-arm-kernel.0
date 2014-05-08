From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 07 May 2014 17:40:15 -0700
Subject: [PATCH v5 3/4] live migration support for VM dirty log management
In-Reply-To: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
References: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1399509616-4632-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for keeping track of VM dirty pages, by updating 
per memslot dirty bitmap and write protecting the page again.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h |    3 ++
 arch/arm/kvm/arm.c              |    5 --
 arch/arm/kvm/mmu.c              |   99 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |   86 ----------------------------------
 virt/kvm/kvm_main.c             |   83 ++++++++++++++++++++++++++++++++
 5 files changed, 185 insertions(+), 91 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 91744c3..e2db1b5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -239,5 +239,8 @@ int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
 void kvm_tlb_flush_vmid(struct kvm *kvm);
 
 int kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
+void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+	struct kvm_memory_slot *slot,
+	gfn_t gfn_offset, unsigned long mask);
 
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 1055266..0b847b5 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -777,11 +777,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 }
 
-int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
-{
-	return -EINVAL;
-}
-
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
 					struct kvm_arm_device_addr *dev_addr)
 {
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 85145d8..1458b6e 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -922,6 +922,105 @@ out:
 	return ret;
 }
 
+/**
+ * kvm_mmu_write_protected_pt_masked - after migration thread write protects
+ *  the entire VM address space itterative call are made to get diry pags
+ *  as the VM pages are being migrated. New dirty pages may be subset
+ *  of initial WPed VM or new writes faulted in. Here write protect new
+ *  dirty pages again in preparation of next dirty log read. This function is
+ *  called as a result KVM_GET_DIRTY_LOG ioctl, to determine what pages
+ *  need to be migrated.
+ *   'kvm->mmu_lock' must be  held to protect against concurrent modification
+ *   of page tables (2nd stage fault, mmu modifiers, ...)
+ *
+ * @kvm:        The KVM pointer
+ * @slot:       The memory slot the dirty log is retrieved for
+ * @gfn_offset: The gfn offset in memory slot
+ * @mask:       The mask of dirty pages at offset 'gnf_offset in this memory
+ *              slot to be writ protect
+ */
+
+void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+		struct kvm_memory_slot *slot,
+		gfn_t gfn_offset, unsigned long mask)
+{
+	phys_addr_t ipa, next, offset_ipa;
+	pgd_t *pgdp = kvm->arch.pgd, *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	gfn_t gfnofst = slot->base_gfn + gfn_offset;
+	bool crosses_pmd;
+
+	ipa = (gfnofst + __ffs(mask)) << PAGE_SHIFT;
+	offset_ipa  = gfnofst << PAGE_SHIFT;
+	next = (gfnofst + (BITS_PER_LONG - 1)) << PAGE_SHIFT;
+
+	/* check if mask width crosses 2nd level page table range, and
+	 * possibly 3rd, 4th. If not skip upper table lookups. Unlikely
+	 * to be true machine memory regions tend to start on atleast PMD
+	 * boundary and mask is a power of 2.
+	 */
+	crosses_pmd = ((offset_ipa & PMD_MASK) ^ (next & PMD_MASK)) ? true :
+									false;
+
+	/* If pgd, pud, pmd not present and you cross pmd range check next
+	 * index. Unlikely that pgd and pud would be not present. Between
+	 * dirty page marking and now page tables may have been altered.
+	 */
+	pgd = pgdp + pgd_index(ipa);
+	if (unlikely(crosses_pmd && !pgd_present(*pgd))) {
+		pgd = pgdp + pgd_index(next);
+		if (!pgd_present(*pgd))
+			return;
+	}
+
+	pud = pud_offset(pgd, ipa);
+	if (unlikely(crosses_pmd && !pud_present(*pud))) {
+		pud = pud_offset(pgd, next);
+		if (!pud_present(*pud))
+			return;
+	}
+
+	pmd = pmd_offset(pud, ipa);
+	if (unlikely(crosses_pmd && !pmd_present(*pmd))) {
+		pmd = pmd_offset(pud, next);
+		if (!pmd_present(*pmd))
+			return;
+	}
+
+	for (;;) {
+		pte = pte_offset_kernel(pmd, ipa);
+		if (!pte_present(*pte))
+			goto next_ipa;
+
+		if (kvm_s2pte_readonly(pte))
+			goto next_ipa;
+		kvm_set_s2pte_readonly(pte);
+next_ipa:
+		mask &= mask - 1;
+		if (!mask)
+			break;
+
+		/* find next page */
+		ipa = (gfnofst + __ffs(mask)) << PAGE_SHIFT;
+
+		/* skip upper page table lookups */
+		if (!crosses_pmd)
+			continue;
+
+		pgd = pgdp + pgd_index(ipa);
+		if (unlikely(!pgd_present(*pgd)))
+			goto next_ipa;
+		pud = pud_offset(pgd, ipa);
+		if (unlikely(!pud_present(*pud)))
+			goto next_ipa;
+		pmd = pmd_offset(pud, ipa);
+		if (unlikely(!pmd_present(*pmd)))
+			goto next_ipa;
+	}
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot,
 			  unsigned long fault_status)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c5582c3..a603ca3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3569,92 +3569,6 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
 	return 0;
 }
 
-/**
- * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
- * @kvm: kvm instance
- * @log: slot id and address to which we copy the log
- *
- * We need to keep it in mind that VCPU threads can write to the bitmap
- * concurrently.  So, to avoid losing data, we keep the following order for
- * each bit:
- *
- *   1. Take a snapshot of the bit and clear it if needed.
- *   2. Write protect the corresponding page.
- *   3. Flush TLB's if needed.
- *   4. Copy the snapshot to the userspace.
- *
- * Between 2 and 3, the guest may write to the page using the remaining TLB
- * entry.  This is not a problem because the page will be reported dirty at
- * step 4 using the snapshot taken before and step 3 ensures that successive
- * writes will be logged for the next call.
- */
-int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
-{
-	int r;
-	struct kvm_memory_slot *memslot;
-	unsigned long n, i;
-	unsigned long *dirty_bitmap;
-	unsigned long *dirty_bitmap_buffer;
-	bool is_dirty = false;
-
-	mutex_lock(&kvm->slots_lock);
-
-	r = -EINVAL;
-	if (log->slot >= KVM_USER_MEM_SLOTS)
-		goto out;
-
-	memslot = id_to_memslot(kvm->memslots, log->slot);
-
-	dirty_bitmap = memslot->dirty_bitmap;
-	r = -ENOENT;
-	if (!dirty_bitmap)
-		goto out;
-
-	n = kvm_dirty_bitmap_bytes(memslot);
-
-	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
-	memset(dirty_bitmap_buffer, 0, n);
-
-	spin_lock(&kvm->mmu_lock);
-
-	for (i = 0; i < n / sizeof(long); i++) {
-		unsigned long mask;
-		gfn_t offset;
-
-		if (!dirty_bitmap[i])
-			continue;
-
-		is_dirty = true;
-
-		mask = xchg(&dirty_bitmap[i], 0);
-		dirty_bitmap_buffer[i] = mask;
-
-		offset = i * BITS_PER_LONG;
-		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
-	}
-
-	spin_unlock(&kvm->mmu_lock);
-
-	/* See the comments in kvm_mmu_slot_remove_write_access(). */
-	lockdep_assert_held(&kvm->slots_lock);
-
-	/*
-	 * All the TLBs can be flushed out of mmu lock, see the comments in
-	 * kvm_mmu_slot_remove_write_access().
-	 */
-	if (is_dirty)
-		kvm_flush_remote_tlbs(kvm);
-
-	r = -EFAULT;
-	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
-		goto out;
-
-	r = 0;
-out:
-	mutex_unlock(&kvm->slots_lock);
-	return r;
-}
-
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 			bool line_status)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e49f976..7d95700 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -433,6 +433,89 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 	return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
 }
 
+
+/**
+ * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
+ * @kvm: kvm instance
+ * @log: slot id and address to which we copy the log
+ *
+ * Shared by x86 and ARM.
+ *
+ * We need to keep it in mind that VCPU threads can write to the bitmap
+ * concurrently.  So, to avoid losing data, we keep the following order for
+ * each bit:
+ *
+ *   1. Take a snapshot of the bit and clear it if needed.
+ *   2. Write protect the corresponding page.
+ *   3. Flush TLB's if needed.
+ *   4. Copy the snapshot to the userspace.
+ *
+ * Between 2 and 3, the guest may write to the page using the remaining TLB
+ * entry.  This is not a problem because the page will be reported dirty at
+ * step 4 using the snapshot taken before and step 3 ensures that successive
+ * writes will be logged for the next call.
+ */
+
+int __weak kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
+						struct kvm_dirty_log *log)
+{
+	int r;
+	struct kvm_memory_slot *memslot;
+	unsigned long n, i;
+	unsigned long *dirty_bitmap;
+	unsigned long *dirty_bitmap_buffer;
+	bool is_dirty = false;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = -EINVAL;
+	if (log->slot >= KVM_USER_MEM_SLOTS)
+		goto out;
+
+	memslot = id_to_memslot(kvm->memslots, log->slot);
+
+	dirty_bitmap = memslot->dirty_bitmap;
+	r = -ENOENT;
+	if (!dirty_bitmap)
+		goto out;
+
+	n = kvm_dirty_bitmap_bytes(memslot);
+
+	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
+	memset(dirty_bitmap_buffer, 0, n);
+
+	spin_lock(&kvm->mmu_lock);
+
+	for (i = 0; i < n / sizeof(long); i++) {
+		unsigned long mask;
+		gfn_t offset;
+
+		if (!dirty_bitmap[i])
+			continue;
+
+		is_dirty = true;
+
+		mask = xchg(&dirty_bitmap[i], 0);
+		dirty_bitmap_buffer[i] = mask;
+
+		offset = i * BITS_PER_LONG;
+		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
+	}
+	if (is_dirty)
+		kvm_flush_remote_tlbs(kvm);
+
+	spin_unlock(&kvm->mmu_lock);
+
+	r = -EFAULT;
+	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
+		goto out;
+
+	r = 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
 #else  /* !(CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER) */
 
 static int kvm_init_mmu_notifier(struct kvm *kvm)
-- 
1.7.9.5
