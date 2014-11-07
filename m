From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 06 Nov 2014 16:40:47 -0800
Subject: [PATCH v13 6/7] arm: KVM: dirty log read write protect support
In-Reply-To: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
References: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1415320848-13813-7-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to track dirty pages between user space KVM_GET_DIRTY_LOG ioctl
calls. We call kvm_get_dirty_log_protect() function to do most of the work.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/arm.c  |   37 +++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/mmu.c  |   22 ++++++++++++++++++++++
 virt/kvm/kvm_main.c |    3 +--
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a99e0cd..212d835 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -737,9 +737,46 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 }
 
+/**
+ * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in a slot
+ * @kvm:	kvm instance
+ * @log:	slot id and address to which we copy the log
+ *
+ * We need to keep it in mind that VCPU threads can write to the bitmap
+ * concurrently.  So, to avoid losing data, we keep the following order for
+ * each bit:
+ *
+ *   1. Take a snapshot of the bit and clear it if needed.
+ *   2. Write protect the corresponding page.
+ *   3. Copy the snapshot to the userspace.
+ *   4. Flush TLB's if needed.
+ *
+ * Steps 1,2,3 are handled by kvm_get_dirty_log_protect().
+ * Between 2 and 4, the guest may write to the page using the remaining TLB
+ * entry.  This is not a problem because the page is reported dirty using
+ * the snapshot taken before and step 4 ensures that writes done after
+ * exiting to userspace will be logged for the next call.
+ */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
+#ifdef CONFIG_ARM
+	int r;
+	bool is_dirty = false;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
+	if (r)
+		goto out;
+
+	if (is_dirty)
+		kvm_flush_remote_tlbs(kvm);
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+#else /* ARM64 */
 	return -EINVAL;
+#endif
 }
 
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3b86522..2f5131e 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -872,6 +872,28 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
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
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f017760..c80dd2f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -982,8 +982,7 @@ out:
 EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
 
 #if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_MIPS) || \
-    defined(CONFIG_IA64) || defined(CONFIG_X86) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64)
+    defined(CONFIG_IA64) || defined(CONFIG_X86) || defined(CONFIG_ARM64)
 /*
  * For architectures that don't use kvm_get_dirty_log_protect() for dirty page
  * logging, calling this function is illegal. Otherwise the function is defined
-- 
1.7.9.5
