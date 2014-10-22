From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 22 Oct 2014 15:34:08 -0700
Subject: [PATCH v12 3/6] arm: KVM: Add ARMv7 API to flush TLBs
In-Reply-To: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1414017251-5772-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARMv7 architecture TLB Flush function.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_asm.h  |    1 +
 arch/arm/include/asm/kvm_host.h |   12 ++++++++++++
 arch/arm/kvm/Kconfig            |    1 +
 arch/arm/kvm/interrupts.S       |   11 +++++++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 3a67bec..25410b2 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -96,6 +96,7 @@ extern char __kvm_hyp_code_end[];
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
+extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 #endif
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 6dfb404..fad598c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,6 +220,18 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+/**
+ * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries
+ * @kvm:	pointer to kvm structure.
+ *
+ * Interface to HYP function to flush all VM TLB entries without address
+ * parameter.
+ */
+static inline void kvm_flush_remote_tlbs(struct kvm *kvm)
+{
+	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
+}
+
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 466bd29..a099df4 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -23,6 +23,7 @@ config KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_ARM_HOST
+	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	depends on ARM_VIRT_EXT && ARM_LPAE
 	---help---
 	  Support hosting virtualized guest machines. You will also
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 01dcb0e..79caf79 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -66,6 +66,17 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
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
 /********************************************************************
  * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
  * domain, for all VMIDs
-- 
1.7.9.5
