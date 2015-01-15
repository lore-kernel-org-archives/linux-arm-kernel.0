From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 Jan 2015 15:58:57 -0800
Subject: [PATCH v16 06/10] KVM: arm: dirty logging write protect support
In-Reply-To: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
References: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1421366341-26012-7-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to track dirty pages between user space KVM_GET_DIRTY_LOG ioctl
calls. We call kvm_get_dirty_log_protect() function to do most of the work.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/Kconfig |    1 +
 arch/arm/kvm/arm.c   |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/kvm/mmu.c   |   22 ++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index f27f336..a8d1ace 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -24,6 +24,7 @@ config KVM
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
 	select KVM_ARM_HOST
+	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	depends on ARM_VIRT_EXT && ARM_LPAE
 	---help---
 	  Support hosting virtualized guest machines. You will also
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9e193c8..6e4290c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -719,9 +719,43 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 }
 
+/**
+ * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
+ * @kvm: kvm instance
+ * @log: slot id and address to which we copy the log
+ *
+ * Steps 1-4 below provide general overview of dirty page logging. See
+ * kvm_get_dirty_log_protect() function description for additional details.
+ *
+ * We call kvm_get_dirty_log_protect() to handle steps 1-3, upon return we
+ * always flush the TLB (step 4) even if previous step failed  and the dirty
+ * bitmap may be corrupt. Regardless of previous outcome the KVM logging API
+ * does not preclude user space subsequent dirty log read. Flushing TLB ensures
+ * writes will be marked dirty for next log read.
+ *
+ *   1. Take a snapshot of the bit and clear it if needed.
+ *   2. Write protect the corresponding page.
+ *   3. Copy the snapshot to the userspace.
+ *   4. Flush TLB's if needed.
+ */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
+#ifdef CONFIG_ARM
+	bool is_dirty = false;
+	int r;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
+
+	if (is_dirty)
+		kvm_flush_remote_tlbs(kvm);
+
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+#else /* arm64 */
 	return -EINVAL;
+#endif
 }
 
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 29e0108..73d506f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -964,6 +964,28 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	spin_unlock(&kvm->mmu_lock);
 	kvm_flush_remote_tlbs(kvm);
 }
+
+/**
+ * kvm_arch_mmu_write_protect_pt_masked() - write protect dirty pages
+ * @kvm:	The KVM pointer
+ * @slot:	The memory slot associated with mask
+ * @gfn_offset:	The gfn offset in memory slot
+ * @mask:	The mask of dirty pages at offset 'gfn_offset' in this memory
+ *		slot to be write protected
+ *
+ * Walks bits set in mask write protects the associated pte's. Caller must
+ * acquire kvm_mmu_lock.
+ */
+void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
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
