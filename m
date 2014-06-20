From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jun 2014 14:00:07 +0100
Subject: [PATCH v3 9/9] arm64: KVM: enable trapping of all debug registers
In-Reply-To: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403269207-1625-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable trapping of the debug registers, preventing the guests to
mess with the host state (and allowing guests to use the debug
infrastructure as well).

Reviewed-by: Anup Patel <anup.patel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 727087c..e36ca91 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -777,6 +777,14 @@ __kvm_hyp_code_start:
 	mrs	x2, mdcr_el2
 	and	x2, x2, #MDCR_EL2_HPMN_MASK
 	orr	x2, x2, #(MDCR_EL2_TPM | MDCR_EL2_TPMCR)
+	orr	x2, x2, #(MDCR_EL2_TDRA | MDCR_EL2_TDOSA)
+
+	// Check for KVM_ARM64_DEBUG_DIRTY, and set debug to trap
+	// if not dirty.
+	ldr	x3, [x0, #VCPU_DEBUG_FLAGS]
+	tbnz	x3, #KVM_ARM64_DEBUG_DIRTY_SHIFT, 1f
+	orr	x2, x2,  #MDCR_EL2_TDA
+1:
 	msr	mdcr_el2, x2
 .endm
 
-- 
1.8.3.4
