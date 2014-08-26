From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 26 Aug 2014 16:57:29 -0700
Subject: [PATCH v10 5/6] arm: KVM: dirty log read write protect support
Message-ID: <1409097449-1173-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to track VM dirty pages, between dirty log reads. Pages
that have been dirtied since last log read are write protected again, in
preparation of next dirty log read. In addition ARMv7 dirty log read function
is pushed up to generic layer.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/Kconfig |  1 -
 arch/arm/kvm/arm.c   |  2 ++
 arch/arm/kvm/mmu.c   | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index eba8b00..dddbb3d 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -23,7 +23,6 @@ config KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_ARM_HOST
-	select HAVE_KVM_ARCH_DIRTY_LOG
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	depends on ARM_VIRT_EXT && ARM_LPAE && !CPU_BIG_ENDIAN
 	---help---
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e1be6c7..0546fa3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -783,10 +783,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 }
 
+#ifdef CONFIG_ARM64
 int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
 	return -EINVAL;
 }
+#endif
 
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
 					struct kvm_arm_device_addr *dev_addr)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 0d8eae9..f176edf 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -872,6 +872,28 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	kvm_flush_remote_tlbs(kvm);
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
1.8.3.2
