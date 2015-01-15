From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 Jan 2015 15:59:00 -0800
Subject: [PATCH v16 09/10] KVM: arm64: Add HYP interface to flush VM Stage 1/2
 TLB entries
In-Reply-To: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
References: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1421366341-26012-10-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for arm64 hyp interface to flush all TLBs associated
with VMID.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm64/kvm/hyp.S |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index b72aa9f..6e1b5df 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -1030,6 +1030,28 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
 	ret
 ENDPROC(__kvm_tlb_flush_vmid_ipa)
 
+/**
+ * void __kvm_tlb_flush_vmid(struct kvm *kvm) - Flush per-VMID TLBs
+ * @struct kvm *kvm - pointer to kvm structure
+ *
+ * Invalidates all Stage 1 and 2 TLB entries for current VMID.
+ */
+ENTRY(__kvm_tlb_flush_vmid)
+	dsb     ishst
+
+	kern_hyp_va     x0
+	ldr     x2, [x0, #KVM_VTTBR]
+	msr     vttbr_el2, x2
+	isb
+
+	tlbi    vmalls12e1is
+	dsb     ish
+	isb
+
+	msr     vttbr_el2, xzr
+	ret
+ENDPROC(__kvm_tlb_flush_vmid)
+
 ENTRY(__kvm_flush_vm_context)
 	dsb	ishst
 	tlbi	alle1is
-- 
1.7.9.5
