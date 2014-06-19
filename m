From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 18 Jun 2014 18:31:39 -0700
Subject: [PATCH v8 3/4] arm: dirty log write protect management support
In-Reply-To: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
References: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1403141500-31010-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for keeping track of VM dirty pages. As dirty page log
is retrieved, the pages that have been written are write protected again for
next write and log read. For ARMv8 read of dirty log returns invalid operation.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h |    3 ++
 arch/arm/kvm/arm.c              |   83 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/mmu.c              |   22 +++++++++++
 3 files changed, 108 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 586c467..dbf3d45 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -233,5 +233,8 @@ int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
 
 void kvm_tlb_flush_vmid(struct kvm *kvm);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
+void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+		struct kvm_memory_slot *slot,
+		gfn_t gfn_offset, unsigned long mask);
 
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e11c2dd..cb3c090 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -783,10 +783,93 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 }
 
+#ifdef CONFIG_ARM
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
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
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
+
+	spin_unlock(&kvm->mmu_lock);
+
+	lockdep_assert_held(&kvm->slots_lock);
+	if (is_dirty)
+		kvm_tlb_flush_vmid(kvm);
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
+#else
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
 	return -EINVAL;
 }
+#endif
 
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
 					struct kvm_arm_device_addr *dev_addr)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 37edcbe..1caf511 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -888,6 +888,28 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	kvm_tlb_flush_vmid(kvm);
 	spin_unlock(&kvm->mmu_lock);
 }
+
+/**
+ * kvm_mmu_write_protected_pt_masked() - write protect dirty pages set in mask
+ * @kvm:	The KVM pointer
+ * @slot:	The memory slot associated with mask
+ * @gfn_offset:	The gfn offset in memory slot
+ * @mask:	The mask of dirty pages at offset 'gfn_offset' in this memory
+ *		slot to be write protected
+ *
+ * Walks bits set in mask write protects the associated pte's. Caller must
+ * acquire kvm_mmu_lock.
+ */
+void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+		struct kvm_memory_slot *slot,
+		gfn_t gfn_offset, unsigned long mask)
+{
+	phys_addr_t base_gfn = slot->base_gfn + gfn_offset;
+	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
+	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
+
+	stage2_wp_range(kvm, start, end);
+}
 #endif
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-- 
1.7.9.5
