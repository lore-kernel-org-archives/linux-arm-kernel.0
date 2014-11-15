From: m.smarduch@samsung.com (m.smarduch at samsung.com)
Date: Sat, 15 Nov 2014 00:19:10 -0800
Subject: [PATCH v2 3/3] KVM: arm/arm64: Enable Dirty Page logging for ARMv8
In-Reply-To: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
References: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1416039550-28125-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mario Smarduch <m.smarduch@samsung.com>

This patch enables ARMv8 ditry page logging support. Plugs ARMv8 into generic
layer through Kconfig symbol, and drops earlier ARM64 constraints to enable
logging at architecture layer.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h | 12 ------------
 arch/arm/kvm/arm.c              |  4 ----
 arch/arm/kvm/mmu.c              | 20 +++++++++++---------
 arch/arm64/kvm/Kconfig          |  2 ++
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 8fa6238..21f828e 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,18 +220,6 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
-/**
- * kvm_flush_remote_tlbs() - flush all VM TLB entries
- * @kvm:	pointer to kvm structure.
- *
- * Interface to HYP function to flush all VM TLB entries without address
- * parameter.
- */
-static inline void kvm_flush_remote_tlbs(struct kvm *kvm)
-{
-	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
-}
-
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 040c0f3..8d27e94 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -759,7 +759,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
  */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
-#ifdef CONFIG_ARM
 	int r;
 	bool is_dirty = false;
 
@@ -783,9 +782,6 @@ out:
 	mutex_unlock(&kvm->slots_lock);
 
 	return r;
-#else /* ARM64 */
-	return -EINVAL;
-#endif
 }
 
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index d29de77..95df040 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -52,11 +52,18 @@ static phys_addr_t hyp_idmap_vector;
 
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
+ * kvm_flush_remote_tlbs() - flush all VM TLB entries for v7/8
+ * @kvm:	pointer to kvm structure.
+ *
+ * Interface to HYP function to flush all VM TLB entries
+ */
+inline void kvm_flush_remote_tlbs(struct kvm *kvm)
+{
+	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
 }
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
@@ -775,7 +782,6 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
 	return false;
 }
 
-#ifdef CONFIG_ARM
 /**
  * stage2_wp_ptes - write protect PMD range
  * @pmd:	pointer to pmd entry
@@ -920,7 +926,6 @@ void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
 
 	stage2_wp_range(kvm, start, end);
 }
-#endif
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot,
@@ -1323,7 +1328,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		spin_unlock(&kvm->mmu_lock);
 	}
 
-#ifdef CONFIG_ARM
 	/*
 	 * At this point memslot has been committed and there is an
 	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
@@ -1332,8 +1336,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	if (change != KVM_MR_DELETE && change != KVM_MR_MOVE &&
 					mem->flags & KVM_MEM_LOG_DIRTY_PAGES)
 		kvm_mmu_wp_memory_region(kvm, mem->slot);
-#endif
-
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8ba85e9..3ce389b 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -22,10 +22,12 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
+	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
 	select KVM_ARM_HOST
 	select KVM_ARM_VGIC
 	select KVM_ARM_TIMER
+	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	---help---
 	  Support hosting virtualized guest machines.
 
-- 
1.9.1
