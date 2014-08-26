From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 26 Aug 2014 16:51:09 -0700
Subject: [PATCH v10 3/6] arm: KVM: Add ARMv7 API to flush TLBs
In-Reply-To: <1409097072-1096-1-git-send-email-m.smarduch@samsung.com>
References: <1409097072-1096-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1409097072-1096-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARMv7 architecture TLB Flush function.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_asm.h  |  1 +
 arch/arm/include/asm/kvm_host.h | 12 ++++++++++++
 arch/arm/kvm/Kconfig            |  1 +
 arch/arm/kvm/interrupts.S       | 12 ++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 53b3c4a..21bc519 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -78,6 +78,7 @@ extern char __kvm_hyp_code_end[];
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
+extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 #endif
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 8fc078d..42877dd 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,6 +220,18 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+/**
+ * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries
+ * @kvm:       pointer to kvm structure.
+ *
+ * Interface to HYP function to flush all VM TLB entries without address
+ * parameter.
+ */
+static inline void kvm_arch_flush_remote_tlbs(struct kvm *kvm)
+{
+	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
+}
+
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index cd9bb1c..eba8b00 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -24,6 +24,7 @@ config KVM
 	select KVM_MMIO
 	select KVM_ARM_HOST
 	select HAVE_KVM_ARCH_DIRTY_LOG
+	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	depends on ARM_VIRT_EXT && ARM_LPAE && !CPU_BIG_ENDIAN
 	---help---
 	  Support hosting virtualized guest machines. You will also
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 0d68d40..1258d46 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -66,6 +66,18 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
 	bx	lr
 ENDPROC(__kvm_tlb_flush_vmid_ipa)
 
+/**
+ * void __kvm_tlb_flush_vmid(struct kvm *kvm) - Flush per-VMID TLBs
+ *
+ * Reuses __kvm_tlb_flush_vmid_ipa() for ARMv7, without passing address
+ * parameter
+ */
+
+ENTRY(__kvm_tlb_flush_vmid)
+	b	__kvm_tlb_flush_vmid_ipa
+ENDPROC(__kvm_tlb_flush_vmid)
+
+
 /********************************************************************
  * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
  * domain, for all VMIDs
-- 
1.8.3.2
