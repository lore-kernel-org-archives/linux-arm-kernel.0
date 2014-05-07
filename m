From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  7 May 2014 16:20:54 +0100
Subject: [PATCH 9/9] arm64: KVM: enable trapping of all debug registers
In-Reply-To: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
References: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1399476054-21571-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable trapping of the debug registers, preventing the guests to
mess with the host state (and allowing guests to use the debug
infrastructure as well).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index f9d5a1d..037d5d9 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -753,6 +753,14 @@ __kvm_hyp_code_start:
 	mrs	x2, mdcr_el2
 	and	x2, x2, #MDCR_EL2_HPMN_MASK
 	orr	x2, x2, #(MDCR_EL2_TPM | MDCR_EL2_TPMCR)
+	orr	x2, x2, #(MDCR_EL2_TDRA | MDCR_EL2_TDOSA)
+
+	// Check for KVM_ARM64_DEBUG_DIRTY, and set to debug to trap
+	// if not dirty.
+	ldr	x3, [x0, #VCPU_DEBUG_FLAGS]
+	tbnz	x3, #KVM_ARM64_DEBUG_DIRTY_SHIFT, 1f
+	orr	x2, x2,  #MDCR_EL2_TDA
+1:
 	msr	mdcr_el2, x2
 .endm
 
-- 
1.8.3.4
