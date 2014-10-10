From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 09 Oct 2014 19:34:07 -0700
Subject: [PATCH 3/3] arm/arm64: Enable Dirty Page logging for ARMv8 move log
 read, tlb flush to generic code
In-Reply-To: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
References: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1412908447-28247-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables ARMv8 dirty page logging and unifies ARMv7/ARMv8 code.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h | 12 ------------
 arch/arm/kvm/arm.c              |  9 ---------
 arch/arm/kvm/mmu.c              | 17 +++++++++++------
 arch/arm64/kvm/Kconfig          |  2 +-
 4 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 12311a5..59565f5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,18 +220,6 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
-/**
- * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries
- * @kvm:       pointer to kvm structure.
- *
- * Interface to HYP function to flush all VM TLB entries without address
- * parameter.
- */
-static inline void kvm_arch_flush_remote_tlbs(struct kvm *kvm)
-{
-	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
-}
-
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 0546fa3..6a6fd6b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -242,7 +242,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *old,
 				   enum kvm_mr_change change)
 {
-#ifdef CONFIG_ARM
 	/*
 	 * At this point memslot has been committed and there is an
 	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
@@ -250,7 +249,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	 */
 	if ((change != KVM_MR_DELETE) && (mem->flags & KVM_MEM_LOG_DIRTY_PAGES))
 		kvm_mmu_wp_memory_region(kvm, mem->slot);
-#endif
 }
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
@@ -783,13 +781,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 }
 
-#ifdef CONFIG_ARM64
-int kvm_arch_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
-{
-	return -EINVAL;
-}
-#endif
-
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
 					struct kvm_arm_device_addr *dev_addr)
 {
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index df1a5a3..8c0f9f2 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -49,11 +49,18 @@ static phys_addr_t hyp_idmap_vector;
 
 static bool kvm_get_logging_state(struct kvm_memory_slot *memslot)
 {
-#ifdef CONFIG_ARM
 	return !!memslot->dirty_bitmap;
-#else
-	return false;
-#endif
+}
+
+/**
+ * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries for ARMv7/8
+ * @kvm:	pointer to kvm structure.
+ *
+ * Interface to HYP function to flush all VM TLB entries
+ */
+inline void kvm_arch_flush_remote_tlbs(struct kvm *kvm)
+{
+	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
 }
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
@@ -769,7 +776,6 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
 	return false;
 }
 
-#ifdef CONFIG_ARM
 /**
  * stage2_wp_ptes - write protect PMD range
  * @pmd:	pointer to pmd entry
@@ -917,7 +923,6 @@ void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 
 	stage2_wp_range(kvm, start, end);
 }
-#endif
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot,
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 40a8d19..a1a35809 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -26,7 +26,7 @@ config KVM
 	select KVM_ARM_HOST
 	select KVM_ARM_VGIC
 	select KVM_ARM_TIMER
-	select HAVE_KVM_ARCH_DIRTY_LOG
+	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	---help---
 	  Support hosting virtualized guest machines.
 
-- 
1.9.1
