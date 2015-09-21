From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 21 Sep 2015 14:26:22 -0700
Subject: [RFT - PATCH 1/2] KVM/arm64: add hooks for armv8 fp/simd lazy switch
 support
In-Reply-To: <1442870783-30752-1-git-send-email-m.smarduch@samsung.com>
References: <1442870783-30752-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1442870783-30752-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds hooks to support fp/simd lazy switch. A vcpu flag to track
fp/simd state, offset into the vcpu structure and switch prototype function.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm64/include/asm/kvm_asm.h  | 1 +
 arch/arm64/include/asm/kvm_host.h | 3 +++
 arch/arm64/kernel/asm-offsets.c   | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 67fa0de..7d9936b 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -119,6 +119,7 @@ extern char __kvm_hyp_vector[];
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
+extern void __kvm_restore_host_vfp_state(struct kvm_vcpu *vcpu);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 415938d..f4665e5 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -161,6 +161,9 @@ struct kvm_vcpu_arch {
 	/* Interrupt related fields */
 	u64 irq_lines;		/* IRQ and FIQ levels */
 
+	/* Track fp/simd lazy switch */
+	u32 vfp_lazy;
+
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8d89cf8..d6edd65 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -124,6 +124,7 @@ int main(void)
   DEFINE(VCPU_HCR_EL2,		offsetof(struct kvm_vcpu, arch.hcr_el2));
   DEFINE(VCPU_MDCR_EL2,	offsetof(struct kvm_vcpu, arch.mdcr_el2));
   DEFINE(VCPU_IRQ_LINES,	offsetof(struct kvm_vcpu, arch.irq_lines));
+  DEFINE(VCPU_VFP_LAZY,		offsetof(struct kvm_vcpu, arch.vfp_lazy));
   DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
   DEFINE(VCPU_HOST_DEBUG_STATE, offsetof(struct kvm_vcpu, arch.host_debug_state));
   DEFINE(VCPU_TIMER_CNTV_CTL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
-- 
1.9.1
