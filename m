From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 06 Jun 2014 10:33:41 -0700
Subject: [RESEND PATCH v7 3/4] arm: dirty log write protect management support
Message-ID: <1402076021-9425-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_vm_ioctl_get_dirty_log() is generic used by x86, ARM. x86 recent patch 
changed this function, this patch picks up those changes, re-tested everything
works. Applies cleanly with other patches.

This patch adds support for keeping track of VM dirty pages. As dirty page log
is retrieved, the pages that have been written are write protected again for
next write and log read.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h |    3 ++
 arch/arm/kvm/arm.c              |    5 ---
 arch/arm/kvm/mmu.c              |   79 +++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |   86 ---------------------------------------
 virt/kvm/kvm_main.c             |   86 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 91 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 59565f5..b760f9c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -232,5 +232,8 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
 int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
 
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
+void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+	struct kvm_memory_slot *slot,
+	gfn_t gfn_offset, unsigned long mask);
 
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index dfd63ac..f06fb21 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -780,11 +780,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
index e5dff85..907344c 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -874,6 +874,85 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	spin_unlock(&kvm->mmu_lock);
 }
 
+/**
+ * stage2_wp_mask_range() - write protect memslot pages set in mask
+ * @pmd - pointer to page table
+ * @start_ipa - the start range of mask
+ * @addr - start_ipa or start range of adjusted mask if crossing PMD range
+ * @mask - mask of dirty pages
+ *
+ * Walk mask and write protect the associated dirty pages in the memory region.
+ * If mask crosses a PMD range adjust it to next page table and return.
+ */
+static void stage2_wp_mask_range(pmd_t *pmd, phys_addr_t start_ipa,
+		phys_addr_t *addr, unsigned long *mask)
+{
+	pte_t *pte;
+	bool crosses_pmd;
+	int i = __ffs(*mask);
+
+	if (unlikely(*addr > start_ipa))
+		start_ipa = *addr - i * PAGE_SIZE;
+	pte = pte_offset_kernel(pmd, start_ipa);
+	for (*addr = start_ipa + i * PAGE_SIZE; *mask;
+		i = __ffs(*mask), *addr = start_ipa + i * PAGE_SIZE) {
+		crosses_pmd = !!((start_ipa & PMD_MASK) ^ (*addr & PMD_MASK));
+		if (unlikely(crosses_pmd)) {
+			/* Adjust mask dirty bits relative to next page table */
+			*mask >>= (PTRS_PER_PTE - pte_index(start_ipa));
+			return;
+		}
+		if (!pte_none(pte[i]))
+			kvm_set_s2pte_readonly(&pte[i]);
+		*mask &= ~(1 << i);
+	}
+}
+
+/**
+ * kvm_mmu_write_protected_pt_masked() - write protect dirty pages set in mask
+ * @kvm:        The KVM pointer
+ * @slot:       The memory slot associated with mask
+ * @gfn_offset: The gfn offset in memory slot
+ * @mask:       The mask of dirty pages@offset 'gnf_offset' in this memory
+ *              slot to be write protected
+ *
+ * Called from dirty page logging read function to write protect bits set in
+ * mask to record future writes to these pages in dirty page log. This function
+ * uses simplified page table walk given  mask can spawn no more then 2 PMD
+ * table range.
+ * 'kvm->mmu_lock' must be  held to protect against concurrent modification
+ * of page tables (2nd stage fault, mmu modifiers, ...)
+ *
+ */
+void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+		struct kvm_memory_slot *slot,
+		gfn_t gfn_offset, unsigned long mask)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+	phys_addr_t start_ipa = (slot->base_gfn + gfn_offset) << PAGE_SHIFT;
+	phys_addr_t end_ipa = start_ipa + BITS_PER_LONG * PAGE_SIZE;
+	phys_addr_t addr = start_ipa;
+	pgd_t *pgdp = kvm->arch.pgd, *pgd;
+
+	do {
+		pgd = pgdp + pgd_index(addr);
+		if (pgd_present(*pgd)) {
+			pud = pud_offset(pgd, addr);
+			if (!pud_none(*pud) && !pud_huge(*pud)) {
+				pmd = pmd_offset(pud, addr);
+				if (!pmd_none(*pmd) && !kvm_pmd_huge(*pmd))
+					stage2_wp_mask_range(pmd, start_ipa,
+								&addr, &mask);
+				else
+					addr += PMD_SIZE;
+			} else
+				addr += PUD_SIZE;
+		} else
+			addr += PGDIR_SIZE;
+	} while (mask && addr < end_ipa);
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
index ba25765..c87c612 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -429,6 +429,92 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 	return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
 }
 
+/**
+ * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
+ * @kvm: kvm instance
+ * @log: slot id and address to which we copy the log
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
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
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
+
+	spin_unlock(&kvm->mmu_lock);
+
+	/* See the comments in kvm_mmu_slot_remove_write_access(). */
+	lockdep_assert_held(&kvm->slots_lock);
+
+	/*
+	 * All the TLBs can be flushed out of mmu lock, see the comments in
+	 * kvm_mmu_slot_remove_write_access().
+	 */
+	if (is_dirty)
+		kvm_flush_remote_tlbs(kvm);
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
