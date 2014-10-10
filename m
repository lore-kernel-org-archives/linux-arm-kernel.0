From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 09 Oct 2014 19:34:06 -0700
Subject: [PATCH 2/3] arm64: Add HYP interface to flush VM Stage 1/2 TLB entires
In-Reply-To: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
References: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1412908447-28247-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds HYP VM TLB FLush function.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm64/kvm/hyp.S | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index b0d1512..117a91c 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -645,6 +645,28 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
 	ret
 ENDPROC(__kvm_tlb_flush_vmid_ipa)
 
+/**
+ * void __kvm_tlb_flush_vmid(struct kvm *kvm) - Flush per-VMID TLBs
+ * @struc kvm *kvm - pointer to kvm structure
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
1.9.1
