From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 18 Jun 2014 18:31:37 -0700
Subject: [PATCH v8 1/4] arm: add ARMv7 HYP API to flush VM TLBs without address
 param
In-Reply-To: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
References: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1403141500-31010-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds HYP interface for global VM TLB invalidation without address
parameter. Moved VM TLB flushing back to architecture layer.
This patch depends on the unmap_range() patch, it needs to be applied first.
No changes to ARMv8.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_asm.h  |    1 +
 arch/arm/include/asm/kvm_host.h |    2 ++
 arch/arm/kvm/interrupts.S       |   11 +++++++++++
 arch/arm/kvm/mmu.c              |   16 ++++++++++++++++
 4 files changed, 30 insertions(+)

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
index 193ceaf..ac3bb65 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -231,4 +231,6 @@ int kvm_perf_teardown(void);
 u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
 int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
 
+void kvm_tlb_flush_vmid(struct kvm *kvm);
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 0d68d40..a3717b7 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -66,6 +66,17 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
 	bx	lr
 ENDPROC(__kvm_tlb_flush_vmid_ipa)
 
+/**
+ * void __kvm_tlb_flush_vmid(struct kvm *kvm) - Flush per-VMID TLBs
+ * @kvm:	pointer to kvm structure
+ *
+ * Reuses __kvm_tlb_flush_vmid_ipa() for ARMv7, without passing address
+ * parameter
+ */
+ENTRY(__kvm_tlb_flush_vmid)
+	b	__kvm_tlb_flush_vmid_ipa
+ENDPROC(__kvm_tlb_flush_vmid)
+
 /********************************************************************
  * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
  * domain, for all VMIDs
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 2ac9588..e90b9e4 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -56,6 +56,22 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
+#ifdef CONFIG_ARM
+/**
+ * kvm_tlb_flush_vmid() - flush all VM TLB entries
+ * @kvm:	pointer to kvm structure.
+ *
+ * Interface to HYP function to flush all VM TLB entries without address
+ * parameter. In HYP mode reuses __kvm_tlb_flush_vmid_ipa() function used by
+ * kvm_tlb_flush_vmid_ipa().
+ */
+void kvm_tlb_flush_vmid(struct kvm *kvm)
+{
+	if (kvm)
+		kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
+}
+#endif
+
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 				  int min, int max)
 {
-- 
1.7.9.5
